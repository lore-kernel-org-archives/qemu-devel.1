Received: from eggs.gnu.org ([2001:4830:134:3::10]:51229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVcq-0004Jv-9M
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVcl-0002QY-B2
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:29:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuVcl-0002QM-4s
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:29:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-3-armbru@redhat.com>
	<ef8a1994-4e57-ee0c-6dc3-793f94e15321@redhat.com>
Date: Tue, 28 Aug 2018 06:28:59 +0200
In-Reply-To: <ef8a1994-4e57-ee0c-6dc3-793f94e15321@redhat.com> (Eric Blake's
	message of "Mon, 27 Aug 2018 11:58:28 -0500")
Message-ID: <87lg8rqflg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/6] json: Clean up how lexer consumes "end
 of input"
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

> On 08/27/2018 02:00 AM, Markus Armbruster wrote:
>> When the lexer isn't in its start state at the end of input, it's
>> working on a token.  To flush it out, it needs to transit to its start
>> state on "end of input" lookahead.
>>
>> There are two ways to the start state, depending on the current state:
>>
>> * If the lexer is in a TERMINAL(JSON_FOO) state, it can emit a
>>    JSON_FOO token.
>>
>> * Else, it can go to IN_ERROR state, and emit a JSON_ERROR token.
>>
>> There are complications, however:
>>
>> * The transition to IN_ERROR state consumes the input character and
>>    adds it to the JSON_ERROR token.  The latter is inappropriate for
>>    the "end of input" character, so we suppress that.  See also recent
>>    commit "json: Fix lexer to include the bad character in JSON_ERROR
>>    token".
>
> Now commit a2ec6be7

I'll update the commit message.

>>
>> * The transition to a TERMINAL(JSON_FOO) state doesn't consume the
>>    input character.  In that case, the lexer normally loops until it is
>>    consumed.  We have to suppress that for the "end of input" input
>>    character.  If we didn't, the lexer would consume it by entering
>>    IN_ERROR state, emitting a bogus JSON_ERROR token.  We fixed that in
>>    commit bd3924a33a6.
>>
>> However, simply breaking the loop this way assumes that the lexer
>> needs exactly one state transition to reach its start state.  That
>> assumption is correct now, but it's unclean, and I'll soon break it.
>> Clean up: instead of breaking the loop after one iteration, break it
>> after it reached the start state.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>> index 4867839f66..ec3aec726f 100644
>> --- a/qobject/json-lexer.c
>> +++ b/qobject/json-lexer.c
>> @@ -261,7 +261,8 @@ void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
>>     static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool
>> flush)
>>   {
>> -    int char_consumed, new_state;
>> +    int new_state;
>> +    bool char_consumed = false;
>
> Yay for the switch to bool.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
