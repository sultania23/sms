class UsersController < ApplicationController
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			
         begin 
		@client = Twilio::REST::Client.new("sid secret","token secret")

        message = @client.account.messages.create(
        :from => "Num", #from which you want ot send sms
        :to => @user.phone,
        :body => 'hey ram'
      
         )
        rescue Twilio::REST::RequestError => e
         render text: e.message
       end

		else
			render 'new'
		end

	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :phone, verification: false)
	end
end
