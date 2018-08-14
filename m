Received: from eggs.gnu.org ([2001:4830:134:3::10]:40133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSeU-0000ij-HZ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSeR-0003Cf-Br
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpSeR-0003CO-6J
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:17:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-35-armbru@redhat.com>
	<a33fd1ea-c2b7-1fe9-8af6-408796d20648@redhat.com>
Date: Tue, 14 Aug 2018 08:17:49 +0200
In-Reply-To: <a33fd1ea-c2b7-1fe9-8af6-408796d20648@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 10:32:09 -0500")
Message-ID: <874lfx4gky.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 34/56] json: Don't pass null @tokens to
 json_parser_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> json_parser_parse() normally returns the QObject on success.  Except
>> it returns null when its @tokens argument is null.
>>
>> Its only caller json_message_process_token() passes null @tokens when
>> emitting a lexical error.  The call is a rather opaque way to say json
>> = NULL then.
>>
>> Simplify matters by lifting the assignment to json out of the emit
>> path: initialize json to null, set it to the value of
>> json_parser_parse() when there's no lexical error.  Drop the special
>> case from json_parser_parse().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-parser.c   |  4 ----
>>   qobject/json-streamer.c | 25 ++++++++++++-------------
>>   2 files changed, 12 insertions(+), 17 deletions(-)
>>
>
> Shorter and simpler.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/qobject/json-streamer.c
>> @@ -39,9 +39,9 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
>>                                   JSONTokenType type, int x, int y)
>>   {
>>       JSONMessageParser *parser = container_of(lexer, JSONMessageParser, lexer);
>> +    QObject *json = NULL;
>>       Error *err = NULL;
>>       JSONToken *token;
>> -    QObject *json;
>
> Why the churn in position?

I like to put declarations with initializers before declarations without
initializers.  ObMovieQuote: "it's a symbol of my individuality, and my
belief in personal freedom."
