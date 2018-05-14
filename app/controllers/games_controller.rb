require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @score = ""
    # 1. Check if the word is an english one unless the letters are not in the grid
    unless !@word.chars.all? { |letter| @letters.split(" ").include?(letter) }
      if @dict = checking_dictionnary(@word)
        @score = "Congrat's #{@word} is a valid English word"
      else
        @score = "Sorry, but #{@word} is not a valid English word"
      end
    else
      @score = "Hum... #{@word} can't be built out of '#{@letters}'"
    end
  end

  def checking_dictionnary(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_word = open(url).read
    @dictionnary_word = JSON.parse(serialized_word)
    return @dictionnary_word = @dictionnary_word["found"]
  end
end
