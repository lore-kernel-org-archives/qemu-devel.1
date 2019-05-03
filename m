Received: from eggs.gnu.org ([209.51.188.92]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQUA-0003AC-EJ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQU6-0007la-MC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:11:50 -0400
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003719.10233-1-driver1998@foxmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db80e5ca-ab98-9c0b-a8c5-8e0c88c58638@redhat.com>
Date: Fri, 3 May 2019 07:11:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190503003719.10233-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation
 regarding stdio formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 03/05/2019 02.37, Cao Jiaxi wrote:
> I encountered the following compilation error on mingw:
> 
> /mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO' macro redefined [-Werror,-Wmacro-redefined]
>  #define __USE_MINGW_ANSI_STDIO 1
>         ^
> /mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: previous definition is here
>  #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be 0 */
> 
> It turns out that __USE_MINGW_ANSI_STDIO must be set before any
> system headers are included, not just before stdio.h.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  include/qemu/osdep.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 303d315c5d..af2b91f0b8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -85,17 +85,17 @@ extern int daemon(int, int);
>  #endif
>  #endif
>  
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif
>  #include <stdio.h>
>  
>  #include <string.h>
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
