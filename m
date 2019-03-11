Received: from eggs.gnu.org ([209.51.188.92]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3IIV-0004eZ-C8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3IIT-0005cu-Bl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:36:43 -0400
References: <20190311102712.8572-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4bb7758-d9c2-adf2-de92-e69d3254adb9@redhat.com>
Date: Mon, 11 Mar 2019 11:36:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190311102712.8572-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/net/pcnet: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>, Aurelien Jarno <aurelien@aurel32.net>

On 11/03/2019 11.27, Philippe Mathieu-Daud=C3=A9 wrote:
> Avoid to clutter stdout until explicitly requested
> (with -d guest_errors):
>=20
>   $ qemu-system-mips -M malta -m 512 -kernel vmlinux-3.2.0-4-4kc-malta
>   Bad SWSTYLE=3D0x04
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Helge patch "pcnet: Avoid warning when switching back to 16bit mode"
> remembered me I had this one somewhere.
> ---
>  hw/net/pcnet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index d9ba04bdfc..16683091c9 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -36,6 +36,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/qdev.h"
>  #include "net/net.h"
>  #include "net/eth.h"
> @@ -1501,7 +1502,8 @@ static void pcnet_bcr_writew(PCNetState *s, uint3=
2_t rap, uint32_t val)
>              val |=3D 0x0300;
>              break;
>          default:
> -            printf("Bad SWSTYLE=3D0x%02x\n", val & 0xff);
> +            qemu_log_mask(LOG_GUEST_ERROR, "pcnet: Bad SWSTYLE=3D0x%02=
x\n",
> +                          val & 0xff);
>              val =3D 0x0200;
>              break;
>          }
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
