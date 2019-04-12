Received: from eggs.gnu.org ([209.51.188.92]:40088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvIj-00060J-5t
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEvIi-0005Ms-7l
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:29:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hEvIg-0005Ko-Av
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:28:59 -0400
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-2-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <301236a7-18f3-1b63-5785-eb8ec93ff583@vivier.eu>
Date: Fri, 12 Apr 2019 14:28:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190412121626.19829-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: avoid string truncation
 warnings in uname field copying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>

On 12/04/2019 14:16, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from linux-user/uname.c:20:
> In function ‘strncpy’,
>     inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We don't care where the NUL terminator in the original uname
> field was. It suffices to copy the entire original field and
> simply force a NUL terminator at the end of the new field.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  linux-user/uname.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..3dff33effe 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
>        /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> +      memcpy((dest), (src), MIN(sizeof(src), __NEW_UTS_LEN));   \

If we use sizeof(), I think we should use it for both:

  MIN(sizeof(dest), sizeof(src))

Thanks,
Laurent
