Received: from eggs.gnu.org ([2001:4830:134:3::10]:54641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fntEj-0000y6-Fw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fntEg-0006L1-Qx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:16:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fntEg-0006KZ-KP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:16:50 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-22-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f889c18-c795-85e3-3ed1-001247403a1d@redhat.com>
Date: Thu, 9 Aug 2018 17:16:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/56] json: Reject invalid UTF-8 sequences
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> We reject bytes that can't occur in valid UTF-8 (\xC0..\xC1,
> \xF5..\xFF in the lexer.  That's insufficient; there's plenty of
> invalid UTF-8 not containing these bytes, as demonstrated by
> check-qjson:
> 
> * Malformed sequences
> 
>    - Unexpected continuation bytes
> 
>    - Missing continuation bytes after start bytes other than
>      \xC0..\xC1, \xF5..\xFD.
> 
> * Overlong sequences with start bytes other than \xC0..\xC1,
>    \xF5..\xFD.
> 
> * Invalid code points
> 
> Fixing this in the lexer would be bothersome.  Fixing it in the parser
> is straightforward, so do that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -193,12 +198,15 @@ static QString *qstring_from_escaped_str(JSONParserContext *ctxt,
>                   goto out;
>               }
>           } else {
> -            char dummy[2];
> -
> -            dummy[0] = *ptr;
> -            dummy[1] = 0;
> -
> -            qstring_append(str, dummy);
> +            cp = mod_utf8_codepoint(ptr, 6, &end);

Why are you hard-coding 6 here, rather than computing min(6, 
strchr(ptr,0)-ptr)?  If the user passes an invalid sequence at the end 
of the string, can we end up making mod_utf8_codepoint() read beyond the 
end of our string?  Would it be better to just always pass the remaining 
string length (mod_utf8_codepoint() only cares about stopping short of 6 
bytes, but never reads beyond there even if you pass a larger number)?

> +            if (cp <= 0) {
> +                parse_error(ctxt, token, "invalid UTF-8 sequence in string");
> +                goto out;
> +            }
> +            ptr = end - 1;
> +            len = mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp);
> +            assert(len >= 0);
> +            qstring_append(str, utf8_buf);
>           }
>       }
>   

> +++ b/util/unicode.c
> @@ -13,6 +13,21 @@
>   #include "qemu/osdep.h"
>   #include "qemu/unicode.h"
>   

> +ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint)
> +{
> +    assert(bufsz >= 5);
> +
> +    if (!is_valid_codepoint(codepoint)) {
> +        return -1;
> +    }
> +
> +    if (codepoint > 0 && codepoint <= 0x7F) {
> +        buf[0] = codepoint & 0x7F;

Dead use of binary &. But acceptable for symmetry with the other code 
branches.

> +        buf[1] = 0;
> +        return 1;
> +    }
> +    if (codepoint <= 0x7FF) {
> +        buf[0] = 0xC0 | ((codepoint >> 6) & 0x1F);
> +        buf[1] = 0x80 | (codepoint & 0x3F);
> +        buf[2] = 0;
> +        return 2;
> +    }
> +    if (codepoint <= 0xFFFF) {
> +        buf[0] = 0xE0 | ((codepoint >> 12) & 0x0F);
> +        buf[1] = 0x80 | ((codepoint >> 6) & 0x3F);
> +        buf[2] = 0x80 | (codepoint & 0x3F);
> +        buf[3] = 0;
> +        return 3;
> +    }
> +    buf[0] = 0xF0 | ((codepoint >> 18) & 0x07);
> +    buf[1] = 0x80 | ((codepoint >> 12) & 0x3F);
> +    buf[2] = 0x80 | ((codepoint >> 6) & 0x3F);
> +    buf[3] = 0x80 | (codepoint & 0x3F);
> +    buf[4] = 0;
> +    return 4;
> +}
> 

Overall, looks nice.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
