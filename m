Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fW3wy-00029k-MJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fW3wx-0007NK-OV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:04:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-6-f4bug@amsat.org>
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 Jun 2018 11:04:15 -0700
Message-ID: <CAKmqyKMgfiaLhQgKmSqewNzC6k1B5MfhNXThBScNoUcmyuuuBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/ssi/omap_spi: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Jun 21, 2018 at 11:02 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/omap_spi.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
> index 34163e5646..f278a55160 100644
> --- a/hw/ssi/omap_spi.c
> +++ b/hw/ssi/omap_spi.c
> @@ -20,6 +20,7 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/arm/omap.h"
>
> @@ -294,11 +295,15 @@ static void omap_mcspi_write(void *opaque, hwaddr a=
ddr,
>      case 0x2c: /* MCSPI_CHCONF */
>          if ((value ^ s->ch[ch].config) & (3 << 14))    /* DMAR | DMAW */
>              omap_mcspi_dmarequest_update(s->ch + ch);
> -        if (((value >> 12) & 3) =3D=3D 3)                  /* TRM */
> -            fprintf(stderr, "%s: invalid TRM value (3)\n", __func__);
> -        if (((value >> 7) & 0x1f) < 3)                 /* WL */
> -            fprintf(stderr, "%s: invalid WL value (%" PRIx64 ")\n",
> -                            __func__, (value >> 7) & 0x1f);
> +        if (((value >> 12) & 3) =3D=3D 3) { /* TRM */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid TRM value (3)\n"=
,
> +                          __func__);
> +        }
> +        if (((value >> 7) & 0x1f) < 3) { /* WL */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: invalid WL value (%" PRIx64 ")\n",
> +                          __func__, (value >> 7) & 0x1f);
> +        }
>          s->ch[ch].config =3D value & 0x7fffff;
>          break;
>
> --
> 2.18.0.rc2
>
>
