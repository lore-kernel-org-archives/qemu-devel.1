Received: from eggs.gnu.org ([2001:4830:134:3::10]:54316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVuC-0001xg-4E
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuVin-0001N6-Bl
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:35:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuVin-0001LX-4u
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 00:35:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-5-armbru@redhat.com>
	<4550a64e-1218-2a58-bed1-f0a9f0efa30b@redhat.com>
Date: Tue, 28 Aug 2018 06:35:12 +0200
In-Reply-To: <4550a64e-1218-2a58-bed1-f0a9f0efa30b@redhat.com> (Eric Blake's
	message of "Mon, 27 Aug 2018 12:18:42 -0500")
Message-ID: <87h8jfqfb3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/6] json: Nicer recovery from lexical
 errors
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
>> When the lexer chokes on an input character, it consumes the
>> character, emits a JSON error token, and enters its start state.  This
>> can lead to suboptimal error recovery.  For instance, input
>>
>>      0123 ,
>>
>> produces the tokens
>>
>>      JSON_ERROR    01
>>      JSON_INTEGER  23
>>      JSON_COMMA    ,
>>
>> Make the lexer skip characters after a lexical error until a
>> structural character ('[', ']', '{', '}', ':', ','), an ASCII control
>> character, or '\xFE', or '\xFF'.
>>
>> Note that we must not skip ASCII control characters, '\xFE', '\xFF',
>> because those are documented to force the JSON parser into known-good
>> state, by docs/interop/qmp-spec.txt.
>>
>> The lexer now produces
>>
>>      JSON_ERROR    01
>>      JSON_COMMA    ,
>
> So the lexer has now completely skipped the intermediate input, but
> the resulting error message need only point at the start of where
> input went wrong, and skipping to a sane point results in fewer error
> tokens to be reported.  Makes sense.

Exactly.

We could emit a recovery token to let json_message_process_token()
report what we skipped, but I don't think it's worth the trouble.

>> Update qmp-test for the nicer error recovery: QMP now report just one
>
> s/report/reports/

Will fix.

>> error for input %p instead of two.  Also drop the newline after %p; it
>> was needed to tease out the second error.
>
> That's because pre-patch, 'p' is one of the input characters that
> requires lookahead to determine if it forms a complete token (and the
> newline provides the transition needed to consume it); now post-patch,
> the 'p' is consumed as part of the junk after the error is first
> detected at the '%'.

Exactly.

> And to my earlier complaint about 0x1a resulting in JSON_ERROR then
> JSON_INTEGER then JSON_KEYWORD, that sequence is likewise now
> identified as a single JSON_ERROR at the 'x', with the rest of the
> attempted hex number (invalid in JSON) silently skipped.  Nice.

Correct.

>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c | 43 +++++++++++++++++++++++++++++--------------
>>   tests/qmp-test.c     |  6 +-----
>>   2 files changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>> index 28582e17d9..39c7ce7adc 100644
>> --- a/qobject/json-lexer.c
>> +++ b/qobject/json-lexer.c
>> @@ -101,6 +101,7 @@
>>     enum json_lexer_state {
>>       IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
>> +    IN_RECOVERY,
>>       IN_DQ_STRING_ESCAPE,
>>       IN_DQ_STRING,
>>       IN_SQ_STRING_ESCAPE,
>> @@ -130,6 +131,28 @@ QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
>>   static const uint8_t json_lexer[][256] =  {
>>       /* Relies on default initialization to IN_ERROR! */
>>   +    /* error recovery */
>> +    [IN_RECOVERY] = {
>> +        /*
>> +         * Skip characters until a structural character, an ASCII
>> +         * control character other than '\t', or impossible UTF-8
>> +         * bytes '\xFE', '\xFF'.  Structural characters and line
>> +         * endings are promising resynchronization points.  Clients
>> +         * may use the others to force the JSON parser into known-good
>> +         * state; see docs/interop/qmp-spec.txt.
>> +         */
>> +        [0 ... 0x1F] = IN_START | LOOKAHEAD,
>
> And here's where the LOOKAHEAD bit has to be separate, because you are
> now assigning semantics to the transition on '\0' that are distinct
> from either of the two roles previously enumerated as possible.

I could do

            TERMINAL(IN_START)
            [0x20 ... 0xFD] = IN_RECOVERY,
            ['\t'] = IN_RECOVERY,

but it would be awful :)

>> +        [0x20 ... 0xFD] = IN_RECOVERY,
>> +        [0xFE ... 0xFF] = IN_START | LOOKAHEAD,
>> +        ['\t'] = IN_RECOVERY,
>> +        ['['] = IN_START | LOOKAHEAD,
>> +        [']'] = IN_START | LOOKAHEAD,
>> +        ['{'] = IN_START | LOOKAHEAD,
>> +        ['}'] = IN_START | LOOKAHEAD,
>> +        [':'] = IN_START | LOOKAHEAD,
>> +        [','] = IN_START | LOOKAHEAD,
>> +    },
>
> It took me a couple of reads before I was satisfied that everything is
> initialized as desired (range assignments followed by more-specific
> re-assignment works, but isn't common), but this looks right.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
