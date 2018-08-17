Received: from eggs.gnu.org ([2001:4830:134:3::10]:52156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhjZ-0003nj-QI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhjW-0004eJ-MM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:36:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhjW-0004eB-Gt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:36:18 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-29-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32b3b6c0-5f70-1b6c-9db2-c19f133358ec@redhat.com>
Date: Fri, 17 Aug 2018 11:36:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/60] json: Fix \uXXXX for surrogate
 pairs
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

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> The JSON parser treats each half of a surrogate pair as unpaired
> surrogate.  Fix it to recognize surrogate pairs.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I might have dropped the R-b, to ensure the changes since v1 get 
re-reviewed.

> ---
>   qobject/json-parser.c | 60 ++++++++++++++++++++++++++++---------------
>   tests/check-qjson.c   |  3 +--
>   2 files changed, 40 insertions(+), 23 deletions(-)
> 

> @@ -157,22 +169,28 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
>                   qstring_append_chr(str, '\t');
>                   break;
>               case 'u':
> -                cp = 0;
> -                for (i = 0; i < 4; i++) {
> -                    if (!qemu_isxdigit(*ptr)) {
> -                        parse_error(ctxt, token,
> -                                    "invalid hex escape sequence in string");
> -                        goto out;
> +                cp = cvt4hex(ptr);
> +                ptr += 4;
> +
> +                /* handle surrogate pairs */
> +                if (cp >= 0xD800 && cp <= 0xDBFF
> +                    && ptr[0] == '\\' && ptr[1] == 'u') {
> +                    /* leading surrogate followed by \u */
> +                    cp = 0x10000 + ((cp & 0x3FF) << 10);
> +                    trailing = cvt4hex(ptr + 2);
> +                    if (trailing >= 0xDC00 && trailing <= 0xDFFF) {
> +                        /* followed by trailing surrogate */
> +                        cp |= trailing & 0x3FF;
> +                        ptr += 6;
> +                    } else {
> +                        cp = -1; /* invalid */
>                       }
> -                    cp <<= 4;
> -                    cp |= hex2decimal(*ptr);
> -                    ptr++;
>                   }
>   
>                   if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
>                       parse_error(ctxt, token,
> -                                "\\u%.4s is not a valid Unicode character",
> -                                ptr - 3);
> +                                "%.*s is not a valid Unicode character",
> +                                (int)(ptr - beg), beg);

The error reporting here has indeed been improved over v1.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
