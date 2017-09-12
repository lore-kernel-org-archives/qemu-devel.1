Received: from eggs.gnu.org ([2001:4830:134:3::10]:43851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkFL-0004W1-1F
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkFH-00058j-Ur
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:24:55 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drkFH-00058C-Pc
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:24:51 -0400
Received: by mail-qk0-x243.google.com with SMTP id i14so7071114qke.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 05:24:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8957d78-66ec-ffeb-fbcd-a35d60190dc2@amsat.org>
Date: Tue, 12 Sep 2017 09:24:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/27] libvhost-user: drop dependency on
 glib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

Hi Marc-André,

On 08/23/2017 01:19 PM, Marc-André Lureau wrote:
> libvhost-user is meant to be free of glib dependency. Make sure it is
> by droping qemu/osdep.h (which included glib.h)
> 
> This fixes a bad malloc()/g_free() pair.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 35fa0c5e56..bb294c6ef7 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -13,11 +13,22 @@
>    * later.  See the COPYING file in the top-level directory.
>    */
>   
> -#include <qemu/osdep.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdarg.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <assert.h>
> +#include <inttypes.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
>   #include <sys/eventfd.h>
> +#include <sys/mman.h>
>   #include <linux/vhost.h>
>   
>   #include "qemu/atomic.h"
> +#include "qemu/compiler.h"
>   
>   #include "libvhost-user.h"
>   
> @@ -34,6 +45,14 @@
>           }                                       \
>       } while (0)
>   
> +#ifndef MIN
> +#define MIN(x, y) ({                            \
> +        typeof(x) _min1 = (x);                  \
> +        typeof(y) _min2 = (y);                  \
> +        (void) (&_min1 == &_min2);              \
> +        _min1 < _min2 ? _min1 : _min2; })

why not add this in qemu/compiler.h instead?

> +#endif
> +
>   static const char *
>   vu_request_to_string(int req)
>   {
> @@ -81,7 +100,7 @@ vu_panic(VuDev *dev, const char *msg, ...)
>       va_list ap;
>   
>       va_start(ap, msg);
> -    buf = g_strdup_vprintf(msg, ap);
> +    vasprintf(&buf, msg, ap);
>       va_end(ap);
>   
>       dev->broken = true;
> @@ -840,7 +859,7 @@ vu_dispatch(VuDev *dev)
>       success = true;
>   
>   end:
> -    g_free(vmsg.data);
> +    free(vmsg.data);
>       return success;
>   }
>   
> 
