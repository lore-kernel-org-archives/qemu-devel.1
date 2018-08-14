Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpTfa-0007iP-W8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpTfW-0004rp-Tr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:23:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpTfW-0004rU-MJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:23:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-40-armbru@redhat.com>
	<5f5cbcf3-bb28-0cef-8951-794d4b2607fd@redhat.com>
Date: Tue, 14 Aug 2018 09:23:04 +0200
In-Reply-To: <5f5cbcf3-bb28-0cef-8951-794d4b2607fd@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 11:12:13 -0500")
Message-ID: <87h8jx2yzr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 39/56] json: Leave rejecting invalid
 interpolation to parser
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
>> Both lexer and parser reject invalid interpolation specifications.
>> The parser's check is useless.
>>
>> The lexer ends the token right after the first bad character.  This
>> tends to lead to suboptimal error reporting.  For instance, input
>>
>>      [ %11d ]
>
> With no context of other characters on this line, it took me a while
> to notice that this was '1' (one) not 'l' (ell), even though my
> current font renders the two quite distinctly. (And now you know why
> base32 avoids 0/1 in its alphabet, to minimize confusion with O/l -
> see RFC 4648).  A better example might be %22d.

I made up an example that could plausibly escape review.  I guess the
realism is too... realistic.  Also, not really helpful.

>> produces the tokens
>>
>>      JSON_LSQUARE  [
>>      JSON_ERROR    %1
>>      JSON_INTEGER  1
>
> And that's in spite of the context you have here, which makes it
> obvious that the parser saw an integer.
>
>>      JSON_KEYWORD  d
>>      JSON_RSQUARE  ]
>>
>> The parser then yields an error, an object and two more errors:
>>
>>      error: Invalid JSON syntax
>>      object: 1
>>      error: JSON parse error, invalid keyword
>>      error: JSON parse error, expecting value
>>
>> Change the lexer to accept [A-Za-z0-9]*[duipsf].  It now produces
>
> That regex doesn't match the code.

Left over from a previous, unpublished iteration.  I'll fix it.

>>
>>      JSON_LSQUARE  [
>>      JSON_INTERPOLATION %11d
>>      JSON_RSQUARE  ]
>>
>> and the parser reports just
>>
>>      JSON parse error, invalid interpolation '%11d'
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c  | 52 +++++++++----------------------------------
>>   qobject/json-parser.c |  1 +
>>   2 files changed, 11 insertions(+), 42 deletions(-)
>>
>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>> index 0ea1eae4aa..7a82aab88b 100644
>> --- a/qobject/json-lexer.c
>> +++ b/qobject/json-lexer.c
>> @@ -93,7 +93,8 @@
>>    *   (apostrophe) instead of %x22 (quotation mark), and can't contain
>>    *   unescaped apostrophe, but can contain unescaped quotation mark.
>>    * - Interpolation:
>> - *   interpolation = %((l|ll|I64)[du]|[ipsf])
>> + *   The lexer accepts [A-Za-z0-9]*, and leaves rejecting invalid ones
>> + *   to the parser.
>
> This comment is more apropos.  But is it worth spelling "The lexer
> accepts %[A-Za-z0-9]*",

Yes.

>                         and/or documenting that recognizing
> interpolation during lexing is now optional (thanks to the previous
> patch)?

Should be done right when I make it optional, in PATCH 37, perhaps like
this:

@@ -92,7 +92,7 @@
  *   Like double-quoted strings, except they're delimited by %x27
  *   (apostrophe) instead of %x22 (quotation mark), and can't contain
  *   unescaped apostrophe, but can contain unescaped quotation mark.
- * - Interpolation:
+ * - Interpolation, if enabled:
  *   interpolation = %((l|ll|I64)[du]|[ipsf])
  *
  * Note:

>> @@ -278,6 +238,14 @@ static const uint8_t json_lexer[][256] =  {
>>           ['\n'] = IN_WHITESPACE,
>>       },
>>   +    /* interpolation */
>> +    [IN_INTERPOL] = {
>> +        TERMINAL(JSON_INTERPOL),
>> +        ['A' ... 'Z'] = IN_INTERPOL,
>> +        ['a' ... 'z'] = IN_INTERPOL,
>> +        ['0' ... '9'] = IN_INTERPOL,
>> +    },
>> +
>
> Note that we still treat code like "'foo': %#x" as an invalid
> interpolation request (it would be a valid printf format), while at
> the same time passing "%1" on to the parser (which is not a valid
> printf format, so -Wformat would have flagged it).  In fact, "%d1"
> which is valid for printf as "%d" followed by a literal "1" gets
> thrown to the parser as one chunk - but it is not valid in JSON to
> have %d adjacent to another integer any more than it is to reject
> "%d1" as an unknown sequence.  I don't think that catering to the
> remaining printf metacharacters (' ', '#', '\'', '-', '*', '+') nor
> demanding that things end on a letter is worth the effort, since it
> just makes the lexer more complicated when your goal was to do as
> little as possible to get things thrown over to the parser.

Yes.

The goal is to catch all mistakes safely, and as many as practical at
compile time.

Invalid interpolation specifications get rejected at run time, by
parse_interpolation().  We can't check them at compile time.

We can't check the variadic arguments match the interpolation
specifications at run time.  We can enlist gcc to check at compile time.
The only remaining hole is '%' in strings.  I intend to plug it.

> So even though your lexing is now somewhat different from printf, I
> don't see that as a serious drawback (the uses we care about are still
> -Wformat clean, and the uses we don't like are properly handled in the
> parser).

Exactly.

> Perhaps you want to enhance the testsuite (earlier in the series) to
> cover "%22d", "%d1", "%1" as various unaccepted interpolation requests
> (if you didn't already).

We don't have negative tests so far.

>From a white box point of view, one negative test certainly makes sense,
to cover parse_interpolation()'s error path.  Multiple ones not so much;
it's all the same to parse_interpolation().

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
