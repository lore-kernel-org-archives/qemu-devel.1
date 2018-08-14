Received: from eggs.gnu.org ([2001:4830:134:3::10]:45209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpTBJ-000410-IX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpTBG-0007zi-E1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:51:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpTBG-0007zR-7y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:51:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-38-armbru@redhat.com>
	<20952f34-7b57-46ae-73ee-6bbc6b2ac939@redhat.com>
Date: Tue, 14 Aug 2018 08:51:46 +0200
In-Reply-To: <20952f34-7b57-46ae-73ee-6bbc6b2ac939@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 10:48:14 -0500")
Message-ID: <87tvnx30fx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 37/56] json: Treat unwanted interpolation
 as lexical error
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
>> The JSON parser optionally supports interpolation.  The lexer
>> recognizes interpolation tokens unconditionally.  The parser rejects
>> them when interpolation is disabled, in parse_interpolation().
>> However, it neglects to set an error then, which can make
>> json_parser_parse() fail without setting an error.
>>
>> Move the check for unwanted interpolation from the parser's
>> parse_interpolation() into the lexer's finite state machine.  When
>> interpolation is disabled, '%' is now handled like any other
>> unexpected character.
>>
>> The next commit will improve how such lexical errors are handled.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/qmp/json-lexer.h |  4 ++--
>>   qobject/json-lexer.c          | 42 ++++++++++++++++++++++++++---------
>>   qobject/json-parser.c         |  4 ----
>>   qobject/json-streamer.c       |  2 +-
>>   tests/qmp-test.c              |  4 ++++
>>   5 files changed, 39 insertions(+), 17 deletions(-)
>>
>
>
>> @@ -271,17 +272,38 @@ static const uint8_t json_lexer[][256] =  {
>>           [','] = JSON_COMMA,
>>           [':'] = JSON_COLON,
>>           ['a' ... 'z'] = IN_KEYWORD,
>> +        [' '] = IN_WHITESPACE,
>> +        ['\t'] = IN_WHITESPACE,
>> +        ['\r'] = IN_WHITESPACE,
>> +        ['\n'] = IN_WHITESPACE,
>> +    },
>> +
>> +    [IN_START_INTERPOL] = {
>> +        ['"'] = IN_DQ_STRING,
> ...
>
>> +        ['\n'] = IN_WHITESPACE,
>> +        /* matches IN_START up to here */
>>           ['%'] = IN_INTERPOL,
>
> You could compress this as:
>
> [IN_START_INTERPOL ... IN_START] = {
>    ['"'] = ...
>    ['\n'] = ...
> },
> [IN_START_INTERPOL]['%'] = IN_INTERPOL,
>
> rather than duplicating the common list twice. (We already exploit
> gcc's range initialization, and the fact that you can initialize a
> broader range and then re-initialize a more specific subset later)

Neat!

It'll lose some of its charm in PATCH 52, but enough remains for me to
like it.

>> +++ b/tests/qmp-test.c
>> @@ -94,6 +94,10 @@ static void test_malformed(QTestState *qts)
>>         /* lexical error: interpolation */
>>       qtest_qmp_send_raw(qts, "%%p\n");
>> +    /* two errors, one for "%", one for "p" */
>> +    resp = qtest_qmp_receive(qts);
>> +    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>> +    qobject_unref(resp);
>>       resp = qtest_qmp_receive(qts);
>>       g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>>       qobject_unref(resp);
>
> I'm impressed at how easily you got the lexer to parse two different
> token grammars, and agree that doing it in the lexer when we don't
> want interpolation is a nicer place.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Well, what you see here isn't my first attempt to make the lexer do it,
it's the one I finally liked :)

Thanks!
