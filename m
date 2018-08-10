Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9mV-0006LE-2E
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9mR-0003UW-4W
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:56:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9mQ-0003U1-Ut
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:56:47 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-26-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d20bd7f2-8398-2eec-8b24-5386115c77ba@redhat.com>
Date: Fri, 10 Aug 2018 10:56:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Both lexer and parser reject invalid escape sequences in strings.  The
> parser's check is useless.
> 

> 
> Drop the lexer's escape sequence checking, and make it accept the same
> characters after '\' it accepts elsewhere in strings.  It now produces
> 
>      JSON_LCURLY   {
>      JSON_STRING   "abc\@ijk"
>      JSON_COLON    :
>      JSON_INTEGER  1
>      JSON_RCURLY
> 
> and the parser reports just
> 
>      JSON parse error, invalid escape sequence in string
> 
> While there, fix parse_string()'s inaccurate function comment.

Worthwhile improvement.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c  | 72 +++----------------------------------------
>   qobject/json-parser.c | 56 +++++++++++++++++++--------------
>   2 files changed, 37 insertions(+), 91 deletions(-)

and shorter!

>       [IN_DQ_STRING_ESCAPE] = {
> -        ['b'] = IN_DQ_STRING,
> -        ['f'] =  IN_DQ_STRING,
> -        ['n'] =  IN_DQ_STRING,
> -        ['r'] =  IN_DQ_STRING,
> -        ['t'] =  IN_DQ_STRING,
> -        ['/'] = IN_DQ_STRING,
> -        ['\\'] = IN_DQ_STRING,
> -        ['\''] = IN_DQ_STRING,
> -        ['\"'] = IN_DQ_STRING,
> -        ['u'] = IN_DQ_UCODE0,
> +        [0x20 ... 0xFD] = IN_DQ_STRING,

Among other things, this means the parser now has to flag "\u" as an 
incomplete escape - but your added testsuite coverage earlier in the 
series ensures that we do.

> +++ b/qobject/json-parser.c
> @@ -106,30 +106,40 @@ static int hex2decimal(char ch)
>   }
>   
>   /**
> - * parse_string(): Parse a json string and return a QObject
> + * parse_string(): Parse a JSON string
>    *
> - *  string

> + * From RFC 7159 "The JavaScript Object Notation (JSON) Data
> + * Interchange Format":
> + *
> + *    char = unescaped /
> + *        escape (
> + *            %x22 /          ; "    quotation mark  U+0022
> + *            %x5C /          ; \    reverse solidus U+005C
> + *            %x2F /          ; /    solidus         U+002F
> + *            %x62 /          ; b    backspace       U+0008
> + *            %x66 /          ; f    form feed       U+000C
> + *            %x6E /          ; n    line feed       U+000A
> + *            %x72 /          ; r    carriage return U+000D
> + *            %x74 /          ; t    tab             U+0009
> + *            %x75 4HEXDIG )  ; uXXXX                U+XXXX
> + *    escape = %x5C              ; \
> + *    quotation-mark = %x22      ; "
> + *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
> + *
> + * Extensions over RFC 7159:
> + * - Extra escape sequence in strings:
> + *   0x27 (apostrophe) is recognized after escape, too
> + * - Single-quoted strings:
> + *   Like double-quoted strings, except they're delimited by %x27
> + *   (apostrophe) instead of %x22 (quotation mark), and can't contain
> + *   unescaped apostrophe, but can contain unescaped quotation mark.
> + *
> + * Note:
> + * - Encoding is modified UTF-8.

That is an extension over RFC 7159. But I'm okay with leaving it in the 
Notes section.

> + * - Invalid Unicode characters are rejected.
> + * - Control characters are rejected by the lexer.

Worth being explicit that this is 00-1f, fe, and ff?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
