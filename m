Received: from eggs.gnu.org ([2001:4830:134:3::10]:35575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9eo-0003xP-Kb
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo9ek-0003nb-Ma
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:48:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo9ek-0003mo-Fi
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:48:50 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-25-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22bb1644-c2a9-4bdb-33fb-057660d22844@redhat.com>
Date: Fri, 10 Aug 2018 10:48:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/56] json: Accept overlong \xC0\x80 as
 U+0000 ("modified UTF-8")
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
> This is consistent with qobject_to_json().  See commit e2ec3f97680.

Side note: that commit mentions that on output, ASCII DEL (0x7f) is 
always escaped. RFC 7159 does not require it to be escaped on input, but 
I wonder if any of your earlier testsuite improvements should 
specifically cover \x7f vs. \u007f on input being canonicalized to 
\u007f on round trip output.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c  | 2 +-
>   qobject/json-parser.c | 2 +-
>   tests/check-qjson.c   | 8 +-------
>   3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
> index ca1e0e2c03..36fb665b12 100644
> --- a/qobject/json-lexer.c
> +++ b/qobject/json-lexer.c
> @@ -93,7 +93,7 @@
>    *   interpolation = %((l|ll|I64)[du]|[ipsf])
>    *
>    * Note:
> - * - Input must be encoded in UTF-8.
> + * - Input must be encoded in modified UTF-8.

Worth documenting this in the QMP doc as an explicit extension? In 
general, our QMP interfaces that take binary input do so via base64 
encoding, rather than via a modified UTF-8 string - and I don't know how 
yajl or jansson would feel about an extension for producing modified 
UTF-8 for QMP to consume if we really did want to pass NUL bytes without 
the overhead of UTF-8; what's more, even if you can pass NUL, you still 
have to worry about all other byte sequences being valid (so base64 is 
still better for true binary data - it's hard to argue that we'd ever 
have an interface where we want UTF-8 including embedded NUL rather than 
true binary).  I guess it can also be argued that outputting modified 
UTF-8 is a violation of JSON, so the fact that we can round-trip NUL 
doesn't help if the client can't read it.

So having typed all that, I guess the answer is no, we don't want to 
document it; for now, the fact that we accept \xc0\x80 on input and 
produce it on output is only for the testsuite, and unlikely to matter 
to any real client of QMP.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
