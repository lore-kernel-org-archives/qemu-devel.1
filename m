Received: from eggs.gnu.org ([209.51.188.92]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6ti-0003aC-SX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM6th-0008Nq-6X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hM6te-0007ht-Ug
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
References: <20190501144646.4851-1-berrange@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2875a50f-6720-1346-6c14-83c5165cf6a8@vivier.eu>
Date: Thu, 2 May 2019 10:16:24 +0200
MIME-Version: 1.0
In-Reply-To: <20190501144646.4851-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: avoid string truncation
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Alistair Francis <Alistair.Francis@wdc.com>

On 01/05/2019 16:46, Daniel P. Berrangé wrote:
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
> 
> Changed in v2:
> 
>  - Always use sizeof() in preference to __NEW_UTS_LEN
> 
>  linux-user/uname.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..1c05f95387 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -72,9 +72,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
> -      /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> -      (dest)[__NEW_UTS_LEN] = '\0'; \
> +      memcpy((dest), (src), MIN(sizeof(src), sizeof(dest))); \
> +      (dest)[sizeof(dest) - 1] = '\0'; \
>    } while (0)
>  
>  int sys_uname(struct new_utsname *buf)
> 

Applied to my linux-user branch.

Thanks,
Laurent
