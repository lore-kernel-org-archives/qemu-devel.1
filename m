Received: from eggs.gnu.org ([2001:4830:134:3::10]:48923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHRY-0004xE-0Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHRX-0000Hg-0V
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:29:20 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-8-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d57b6ebf-f28e-083f-9cf5-6a4c702b9d96@redhat.com>
Date: Fri, 22 Jun 2018 10:29:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/11] hw/i2c/omap_i2c: Use
 qemu_log_mask(UNIMP) instead of fprintf
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
>  hw/i2c/omap_i2c.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 26e3e5ebf6..e6f34fe31f 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -17,6 +17,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/arm/omap.h"
> @@ -339,14 +340,17 @@ static void omap_i2c_write(void *opaque, hwaddr a=
ddr,
>              }
>              break;
>          }
> -        if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
> -            fprintf(stderr, "%s: I^2C slave mode not supported\n",
> -                            __func__);
> +        if ((value & (1 << 15)) && !(value & (1 << 10))) {
> +            /* MST */
> +            qemu_log_mask(LOG_UNIMP, "%s: I^2C slave mode not supporte=
d\n",
> +                          __func__);
>              break;
>          }
> -        if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
> -            fprintf(stderr, "%s: 10-bit addressing mode not supported\=
n",
> -                            __func__);
> +        if ((value & (1 << 15)) && value & (1 << 8)) {
> +            /* XA */
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: 10-bit addressing mode not supported\n"=
,
> +                          __func__);
>              break;
>          }
>          if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
> @@ -392,8 +396,11 @@ static void omap_i2c_write(void *opaque, hwaddr ad=
dr,
>                  s->stat |=3D 0x3f;
>                  omap_i2c_interrupts_update(s);
>              }
> -        if (value & (1 << 15))					/* ST_EN */
> -            fprintf(stderr, "%s: System Test not supported\n", __func_=
_);
> +        if (value & (1 << 15)) {
> +            /* ST_EN */
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: System Test not supported\n", __func__)=
;
> +        }
>          break;
> =20
>      default:

Could you please leave the comments at the end of the if-statement lines?

 Thomas
