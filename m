Received: from eggs.gnu.org ([209.51.188.92]:50108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlj8-0004Rg-Sw
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlj4-0005dI-6I
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:34 -0400
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Date: Wed, 1 May 2019 11:40:13 +0200
MIME-Version: 1.0
In-Reply-To: <14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 01/05/2019 01:28, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘sys_uname’ at /home/alistair/qemu/linux-user/uname.c:94:3:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/uname.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79dbad..2fc6096a5b 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>  #define COPY_UTSNAME_FIELD(dest, src) \
>    do { \
>        /* __NEW_UTS_LEN doesn't include terminating null */ \
> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); \

You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
character if it is present and fit in __NEW_UTS_LEN.

>        (dest)[__NEW_UTS_LEN] = '\0'; \
>    } while (0)
>  
> 
