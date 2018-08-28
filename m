Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVtw-0001xg-V2
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVoq-0000cw-G0
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuVoq-0000cp-B3
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:41:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-7-armbru@redhat.com>
	<9f11e72b-42c5-da48-3f70-7370d680d59d@redhat.com>
Date: Tue, 28 Aug 2018 06:41:28 +0200
In-Reply-To: <9f11e72b-42c5-da48-3f70-7370d680d59d@redhat.com> (Eric Blake's
	message of "Mon, 27 Aug 2018 12:25:02 -0500")
Message-ID: <878t4rqf0n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] json: Eliminate lexer state
 IN_WHITESPACE, pseudo-token JSON_SKIP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/27/2018 02:00 AM, Markus Armbruster wrote:
>> The lexer ignores whitespace like this:
>>
>>           on whitespace      on non-ws   spontaneously
>>      IN_START --> IN_WHITESPACE --> JSON_SKIP --> IN_START
>>                      ^    |
>>                       \__/  on whitespace
>>
>> This accumulates a whitespace token in state IN_WHITESPACE, only to
>> throw it away on the transition via JSON_SKIP to the start state.
>> Wasteful.  Go from IN_START to IN_START on whitspace directly,
>
> s/whitspace/whitespace/

Will fix.

>> dropping the whitespace character.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c      | 22 +++++-----------------
>>   qobject/json-parser-int.h |  1 -
>>   2 files changed, 5 insertions(+), 18 deletions(-)
>>
>> @@ -263,10 +253,10 @@ static const uint8_t json_lexer[][256] =  {
>>           [','] = JSON_COMMA,
>>           [':'] = JSON_COLON,
>>           ['a' ... 'z'] = IN_KEYWORD,
>> -        [' '] = IN_WHITESPACE,
>> -        ['\t'] = IN_WHITESPACE,
>> -        ['\r'] = IN_WHITESPACE,
>> -        ['\n'] = IN_WHITESPACE,
>> +        [' '] = IN_START,
>> +        ['\t'] = IN_START,
>> +        ['\r'] = IN_START,
>> +        ['\n'] = IN_START,
>>       },
>>       [IN_START_INTERP]['%'] = IN_INTERP,
>
> Don't you need to set [IN_START_INTERP][' '] to IN_START_INTERP,
> rather than IN_START?  Otherwise, the presence of skipped whitespace
> would change whether interpolation happens.  (At least, that's what
> you had in an earlier version of this patch).
>
>>   };
>> @@ -323,10 +313,8 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
>>               json_message_process_token(lexer, lexer->token, new_state,
>>                                          lexer->x, lexer->y);
>>               /* fall through */
>> -        case JSON_SKIP:
>> -            g_string_truncate(lexer->token, 0);
>> -            /* fall through */
>>           case IN_START:
>> +            g_string_truncate(lexer->token, 0);
>>               new_state = lexer->start_state;
>
> Oh, I see. We are magically reverting to the correct start state if
> the requested transition reports IN_START, rather than blindly using
> IN_START.

Correct.  Less repetitive this way.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
