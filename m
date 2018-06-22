Received: from eggs.gnu.org ([2001:4830:134:3::10]:48558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHP3-00048p-CY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHP2-0007iy-Hk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:26:45 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-7-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7b7b28e6-5a74-08b5-0cea-78d159501a24@redhat.com>
Date: Fri, 22 Jun 2018 10:26:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] hw/sd/omap_mmc: Use
 qemu_log_mask(UNIMP) instead of printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/omap_mmc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index 5b47cadf11..aa2a816f76 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -17,6 +17,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/arm/omap.h"
>  #include "hw/sd/sd.h"
> @@ -449,10 +450,14 @@ static void omap_mmc_write(void *opaque, hwaddr o=
ffset,
>          s->enable =3D (value >> 11) & 1;
>          s->be =3D (value >> 10) & 1;
>          s->clkdiv =3D (value >> 0) & (s->rev >=3D 2 ? 0x3ff : 0xff);
> -        if (s->mode !=3D 0)
> -            printf("SD mode %i unimplemented!\n", s->mode);
> -        if (s->be !=3D 0)
> -            printf("SD FIFO byte sex unimplemented!\n");
> +        if (s->mode !=3D 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "omap_mmc_wr: mode #%i unimplemented\n", s->=
mode);
> +        }
> +        if (s->be !=3D 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "omap_mmc_wr: Big Endian not implemented\n")=
;
> +        }
>          if (s->dw !=3D 0 && s->lines < 4)
>              printf("4-bit SD bus enabled\n");
>          if (!s->enable)

Reviewed-by: Thomas Huth <thuth@redhat.com>
