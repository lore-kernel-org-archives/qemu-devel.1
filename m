Received: from eggs.gnu.org ([209.51.188.92]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr5u-000484-Ij
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr5p-0000vK-EN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr5o-0000uU-Sf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:24:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id b67so4643482wmg.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:24:19 -0700 (PDT)
References: <20190501144646.4851-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb43af48-c48b-74cf-6e83-982a310bf1d9@redhat.com>
Date: Wed, 1 May 2019 17:24:17 +0200
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 5/1/19 4:46 PM, Daniel P. Berrangé wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
