Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS5J-0003lm-MZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS5H-0004Hb-OC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:51:05 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-12-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bcbba38b-7d1b-3a70-383f-69c0832666a6@redhat.com>
Date: Fri, 22 Jun 2018 21:50:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/14] hw/net/stellaris_enet: Use
 qemu_log_mask(GUEST_ERROR) instead of hw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> hw_error() finally calls abort(), but there is no need to abort here.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/stellaris_enet.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
> index 04bd10ada3..f8edebdecd 100644
> --- a/hw/net/stellaris_enet.c
> +++ b/hw/net/stellaris_enet.c
> @@ -9,6 +9,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
> +#include "qemu/log.h"
>  #include <zlib.h>
> =20
>  //#define DEBUG_STELLARIS_ENET 1
> @@ -343,7 +344,9 @@ static uint64_t stellaris_enet_read(void *opaque, h=
waddr offset,
>      case 0x3c: /* Undocuented: Timestamp? */

I guess it's trivial enough that you could fix the above type in your
patch here, too (just mention it in the patch description).

>          return 0;
>      default:
> -        hw_error("stellaris_enet_read: Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "stellaris_enet_rd%d: Illegal r=
egister"
> +                                       " 0x02%" HWADDR_PRIx "\n",
> +                      size << 2, offset);

Why "<< 2" ? Shouldn't that be "<< 3" or "* 8" instead?

>          return 0;
>      }
>  }
> @@ -442,7 +445,9 @@ static void stellaris_enet_write(void *opaque, hwad=
dr offset,
>          /* Ignored.  */
>          break;
>      default:
> -        hw_error("stellaris_enet_write: Bad offset %x\n", (int)offset)=
;
> +        qemu_log_mask(LOG_GUEST_ERROR, "stellaris_enet_wr%d: Illegal r=
egister"
> +                                       " 0x02%" HWADDR_PRIx " =3D 0x%l=
x\n",
> +                      size << 2, offset, value);

dito.

 Thomas
