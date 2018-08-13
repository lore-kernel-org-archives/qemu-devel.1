Received: from eggs.gnu.org ([2001:4830:134:3::10]:35265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6vF-00022W-1U
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp6vA-00061f-3D
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:05:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp6v9-00061Z-Tl
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:05:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-26-armbru@redhat.com>
	<d20bd7f2-8398-2eec-8b24-5386115c77ba@redhat.com>
Date: Mon, 13 Aug 2018 09:05:38 +0200
In-Reply-To: <d20bd7f2-8398-2eec-8b24-5386115c77ba@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 10:56:45 -0500")
Message-ID: <87k1oubvb1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 25/56] json: Leave rejecting invalid escape
 sequences to parser
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
>> Both lexer and parser reject invalid escape sequences in strings.  The
>> parser's check is useless.
>>
>
>>
>> Drop the lexer's escape sequence checking, and make it accept the same
>> characters after '\' it accepts elsewhere in strings.  It now produces
>>
>>      JSON_LCURLY   {
>>      JSON_STRING   "abc\@ijk"
>>      JSON_COLON    :
>>      JSON_INTEGER  1
>>      JSON_RCURLY
>>
>> and the parser reports just
>>
>>      JSON parse error, invalid escape sequence in string
>>
>> While there, fix parse_string()'s inaccurate function comment.
>
> Worthwhile improvement.
>
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qobject/json-lexer.c  | 72 +++----------------------------------------
>>   qobject/json-parser.c | 56 +++++++++++++++++++--------------
>>   2 files changed, 37 insertions(+), 91 deletions(-)
>
> and shorter!
>
>>       [IN_DQ_STRING_ESCAPE] = {
>> -        ['b'] = IN_DQ_STRING,
>> -        ['f'] =  IN_DQ_STRING,
>> -        ['n'] =  IN_DQ_STRING,
>> -        ['r'] =  IN_DQ_STRING,
>> -        ['t'] =  IN_DQ_STRING,
>> -        ['/'] = IN_DQ_STRING,
>> -        ['\\'] = IN_DQ_STRING,
>> -        ['\''] = IN_DQ_STRING,
>> -        ['\"'] = IN_DQ_STRING,
>> -        ['u'] = IN_DQ_UCODE0,
>> +        [0x20 ... 0xFD] = IN_DQ_STRING,
>
> Among other things, this means the parser now has to flag "\u" as an
> incomplete escape - but your added testsuite coverage earlier in the
> series ensures that we do.

Yes.

>> +++ b/qobject/json-parser.c
>> @@ -106,30 +106,40 @@ static int hex2decimal(char ch)
>>   }
>>     /**
>> - * parse_string(): Parse a json string and return a QObject
>> + * parse_string(): Parse a JSON string
>>    *
>> - *  string
>
>> + * From RFC 7159 "The JavaScript Object Notation (JSON) Data
>> + * Interchange Format":
>> + *
>> + *    char = unescaped /
>> + *        escape (
>> + *            %x22 /          ; "    quotation mark  U+0022
>> + *            %x5C /          ; \    reverse solidus U+005C
>> + *            %x2F /          ; /    solidus         U+002F
>> + *            %x62 /          ; b    backspace       U+0008
>> + *            %x66 /          ; f    form feed       U+000C
>> + *            %x6E /          ; n    line feed       U+000A
>> + *            %x72 /          ; r    carriage return U+000D
>> + *            %x74 /          ; t    tab             U+0009
>> + *            %x75 4HEXDIG )  ; uXXXX                U+XXXX
>> + *    escape = %x5C              ; \
>> + *    quotation-mark = %x22      ; "
>> + *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
>> + *
>> + * Extensions over RFC 7159:
>> + * - Extra escape sequence in strings:
>> + *   0x27 (apostrophe) is recognized after escape, too
>> + * - Single-quoted strings:
>> + *   Like double-quoted strings, except they're delimited by %x27
>> + *   (apostrophe) instead of %x22 (quotation mark), and can't contain
>> + *   unescaped apostrophe, but can contain unescaped quotation mark.
>> + *
>> + * Note:
>> + * - Encoding is modified UTF-8.
>
> That is an extension over RFC 7159. But I'm okay with leaving it in
> the Notes section.
>
>> + * - Invalid Unicode characters are rejected.
>> + * - Control characters are rejected by the lexer.
>
> Worth being explicit that this is 00-1f, fe, and ff?

\xFE and \xFF are invalid, not control.

What about:

 * - Invalid Unicode characters are rejected.
 * - Control characters \x00..\x1F are rejected by the lexer.
