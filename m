Received: from eggs.gnu.org ([2001:4830:134:3::10]:43897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpUce-0003HY-A3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpUcd-0004ej-70
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:24:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpUcd-0004eP-17
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:24:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-42-armbru@redhat.com>
	<eb69bba3-9226-87b7-ddf7-45c2d51b8446@redhat.com>
Date: Tue, 14 Aug 2018 10:24:07 +0200
In-Reply-To: <eb69bba3-9226-87b7-ddf7-45c2d51b8446@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 11:33:14 -0500")
Message-ID: <87in4d1hlk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 41/56] json: Nicer recovery from invalid
 leading zero
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

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> For input 0123, the lexer produces the tokens
>>
>>      JSON_ERROR    01
>>      JSON_INTEGER  23
>>
>> Reporting an error is correct; 0123 is invalid according to RFC 7159.
>> But the error recovery isn't nice.
>>
>> Make the finite state machine eat digits before going into the error
>> state.  The lexer now produces
>>
>>      JSON_ERROR    0123
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>
>> @@ -158,10 +159,14 @@ static const uint8_t json_lexer[][256] =  {
>>       /* Zero */
>>       [IN_ZERO] = {
>>           TERMINAL(JSON_INTEGER),
>> -        ['0' ... '9'] = IN_ERROR,
>> +        ['0' ... '9'] = IN_BAD_ZERO,
>>           ['.'] = IN_MANTISSA,
>>       },
>>   +    [IN_BAD_ZERO] = {
>> +        ['0' ... '9'] = IN_BAD_ZERO,
>> +    },
>> +
>
> Should IN_BAD_ZERO also consume '.' and/or 'e' (after all, '01e2 is a
> valid C constant, but not a valid JSON literal)?  But I think your
> choice here is fine (again, add too much, and then the lexer has to
> track a lot of state; whereas this minimal addition catches the most
> obvious things with little effort).

My patch is of marginal value to begin with.  It improves error recovery
only for the "integer with redundant leading zero" case.  I guess that's
more common than "floating-point with redundant leading zero".

An obvious way to extend it to "number with redundant leading zero"
would be cloning the lexer states related to numbers.  Clean, but six
more states.  Meh.

Another way is to dumb down the lexer not to care about leading zero,
and catch it in parse_literal() instead.  Basically duplicates the lexer
state machine up to where leading zero is recognized.  Not much code,
but meh.

Yet another way is to have the lexer eat "digit salad" after redundant
leading zero:

    [IN_BAD_ZERO] = {
        ['0' ... '9'] = IN_BAD_ZERO,
        ['.'] = IN_BAD_ZERO,
        ['e'] = IN_BAD_ZERO,
        ['-'] = IN_BAD_ZERO,
        ['+'] = IN_BAD_ZERO,
    },

Eats even crap like 01e...  But then the same crap without leading zero
should also be eaten.  We'd have to add state transitions to IN_BAD_ZERO
to the six states related to numbers.  Perhaps clever use of gcc's range
initialization lets us do this compactly.  Otherwise, meh again.

Opinions?

I'd also be fine with dropping this patch.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
