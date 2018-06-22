Received: from eggs.gnu.org ([2001:4830:134:3::10]:44422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRlv-0001OM-Vd
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRlv-000575-3Z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:31:03 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ced44643-660e-97d4-1339-5c842eeee0db@redhat.com>
Date: Fri, 22 Jun 2018 21:30:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/14] hw/input/tsc2005: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/input/tsc2005.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
> index 7990954b6c..4dd95596ab 100644
> --- a/hw/input/tsc2005.c
> +++ b/hw/input/tsc2005.c
> @@ -19,6 +19,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "qemu/timer.h"
>  #include "ui/console.h"
> @@ -208,9 +209,10 @@ static void tsc2005_write(TSC2005State *s, int reg=
, uint16_t data)
>          }
>          s->nextprecision =3D (data >> 13) & 1;
>          s->timing[0] =3D data & 0x1fff;
> -        if ((s->timing[0] >> 11) =3D=3D 3)
> -            fprintf(stderr, "%s: illegal conversion clock setting\n",
> -                            __func__);
> +        if ((s->timing[0] >> 11) =3D=3D 3) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "tsc2005_write: illegal conversion clock set=
ting\n");
> +        }
>          break;
>      case 0xd:	/* CFR1 */
>          s->timing[1] =3D data & 0xf07;
> @@ -221,8 +223,9 @@ static void tsc2005_write(TSC2005State *s, int reg,=
 uint16_t data)
>          break;
> =20
>      default:
> -        fprintf(stderr, "%s: write into read-only register %x\n",
> -                        __func__, reg);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: write into read-only register 0x%x\n",
> +                      __func__, reg);
>      }
>  }
> =20

Reviewed-by: Thomas Huth <thuth@redhat.com>
