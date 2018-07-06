Received: from eggs.gnu.org ([2001:4830:134:3::10]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFf8-0001Np-Pv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFf5-000715-JP
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:35:54 -0400
Received: from ozlabs.org ([203.11.71.1]:58871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fbFf4-0006vm-B7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:35:51 -0400
Date: Fri, 6 Jul 2018 11:35:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706013510.GL3450@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-3-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-3-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/14] timer: ds1338 use registerfields.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:49AM -0700, Michael Davidsaver wrote:
> Use names for registers and bits except
> for R_CTRL which will be dealt with later,
> and isn't modeled anyway.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/ds1338.c | 80 +++++++++++++++++++++++++++++++++++++------------=
------
>  1 file changed, 54 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 3849b74a68..7298c5af43 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "hw/i2c/i2c.h"
> +#include "hw/registerfields.h"
>  #include "qemu/bcd.h"
> =20
>  /* Size of NVRAM including both the user-accessible area and the
> @@ -20,15 +21,42 @@
>   */
>  #define NVRAM_SIZE 64
> =20
> -/* Flags definitions */
> -#define SECONDS_CH 0x80
> -#define HOURS_12   0x40
> -#define HOURS_PM   0x20
>  #define CTRL_OSF   0x20
> =20
>  #define TYPE_DS1338 "ds1338"
>  #define DS1338(obj) OBJECT_CHECK(DS1338State, (obj), TYPE_DS1338)
> =20
> +/* values stored in BCD */
> +/* 00-59 */
> +#define R_SEC   (0x0)
> +/* 00-59 */
> +#define R_MIN   (0x1)
> +#define R_HOUR  (0x2)
> +/* 1-7 */
> +#define R_WDAY  (0x3)
> +/* 0-31 */
> +#define R_DATE  (0x4)
> +#define R_MONTH (0x5)
> +/* 0-99 */
> +#define R_YEAR  (0x6)
> +
> +#define R_CTRL  (0x7)
> +
> +/* use 12 hour mode when set */
> +FIELD(HOUR, SET12, 6, 1)
> +/* 00-23 */
> +FIELD(HOUR, HOUR24, 0, 6)
> +/* PM when set */
> +FIELD(HOUR, AMPM, 5, 1)
> +/* 1-12 (not 0-11!) */
> +FIELD(HOUR, HOUR12, 0, 5)
> +
> +/* 1-12 */
> +FIELD(MONTH, MONTH, 0, 5)
> +FIELD(MONTH, CENTURY, 7, 1)
> +
> +FIELD(CTRL, OSF, 5, 1)
> +
>  typedef struct DS1338State {
>      I2CSlave parent_obj;
> =20
> @@ -61,25 +89,25 @@ static void capture_current_time(DS1338State *s)
>       */
>      struct tm now;
>      qemu_get_timedate(&now, s->offset);
> -    s->nvram[0] =3D to_bcd(now.tm_sec);
> -    s->nvram[1] =3D to_bcd(now.tm_min);
> -    if (s->nvram[2] & HOURS_12) {
> +    s->nvram[R_SEC] =3D to_bcd(now.tm_sec);
> +    s->nvram[R_MIN] =3D to_bcd(now.tm_min);
> +    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
>          int tmp =3D now.tm_hour;
>          if (tmp % 12 =3D=3D 0) {
>              tmp +=3D 12;
>          }
>          if (tmp <=3D 12) {
> -            s->nvram[2] =3D HOURS_12 | to_bcd(tmp);
> +            s->nvram[R_HOUR] =3D R_HOUR_SET12_MASK | to_bcd(tmp);
>          } else {
> -            s->nvram[2] =3D HOURS_12 | HOURS_PM | to_bcd(tmp - 12);
> +            s->nvram[R_HOUR] =3D R_HOUR_SET12_MASK | R_HOUR_AMPM_MASK | =
to_bcd(tmp - 12);
>          }
>      } else {
> -        s->nvram[2] =3D to_bcd(now.tm_hour);
> +        s->nvram[R_HOUR] =3D to_bcd(now.tm_hour);
>      }
> -    s->nvram[3] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> -    s->nvram[4] =3D to_bcd(now.tm_mday);
> -    s->nvram[5] =3D to_bcd(now.tm_mon + 1);
> -    s->nvram[6] =3D to_bcd(now.tm_year - 100);
> +    s->nvram[R_WDAY] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> +    s->nvram[R_DATE] =3D to_bcd(now.tm_mday);
> +    s->nvram[R_MONTH] =3D to_bcd(now.tm_mon + 1);
> +    s->nvram[R_YEAR] =3D to_bcd(now.tm_year - 100);
>  }
> =20
>  static void inc_regptr(DS1338State *s)
> @@ -141,17 +169,17 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>          struct tm now;
>          qemu_get_timedate(&now, s->offset);
>          switch(s->ptr) {
> -        case 0:
> +        case R_SEC:
>              /* TODO: Implement CH (stop) bit.  */
>              now.tm_sec =3D from_bcd(data & 0x7f);
>              break;
> -        case 1:
> +        case R_MIN:
>              now.tm_min =3D from_bcd(data & 0x7f);
>              break;
> -        case 2:
> -            if (data & HOURS_12) {
> -                int tmp =3D from_bcd(data & (HOURS_PM - 1));
> -                if (data & HOURS_PM) {
> +        case R_HOUR:
> +            if (FIELD_EX32(data, HOUR, SET12)) {
> +                int tmp =3D from_bcd(FIELD_EX32(data, HOUR, HOUR12));
> +                if (FIELD_EX32(data, HOUR, AMPM)) {
>                      tmp +=3D 12;
>                  }
>                  if (tmp % 12 =3D=3D 0) {
> @@ -159,10 +187,10 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>                  }
>                  now.tm_hour =3D tmp;
>              } else {
> -                now.tm_hour =3D from_bcd(data & (HOURS_12 - 1));
> +                now.tm_hour =3D from_bcd(FIELD_EX32(data, HOUR, HOUR24));
>              }
>              break;
> -        case 3:
> +        case R_WDAY:
>              {
>                  /* The day field is supposed to contain a value in
>                     the range 1-7. Otherwise behavior is undefined.
> @@ -171,18 +199,18 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>                  s->wday_offset =3D (user_wday - now.tm_wday + 7) % 7;
>              }
>              break;
> -        case 4:
> +        case R_DATE:
>              now.tm_mday =3D from_bcd(data & 0x3f);
>              break;
> -        case 5:
> +        case R_MONTH:
>              now.tm_mon =3D from_bcd(data & 0x1f) - 1;
>              break;
> -        case 6:
> +        case R_YEAR:
>              now.tm_year =3D from_bcd(data) + 100;
>              break;
>          }
>          s->offset =3D qemu_timedate_diff(&now);
> -    } else if (s->ptr =3D=3D 7) {
> +    } else if (s->ptr =3D=3D R_CTRL) {
>          /* Control register. */
> =20
>          /* Ensure bits 2, 3 and 6 will read back as zero. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls+x0sACgkQbDjKyiDZ
s5KRug//eQ/jrq/fUzd7jWd0Go6wUSLo+duP/xCWbrUwjP8AymChOe/sjHrVD9Lh
w8NAE9V9RAjbir1LpGO79lfO+Wl8PRdEgwbQZf7+HkRAkdsWAMovfKapMmixvqnF
atwCkKwItmuIPL+TB0EbZHEU7rNWYaQt2VK6gViQz+SCZaTTI+S58XYLiA2xQC0w
yLYZMp1coagLc+5AtH2ZwnyXDMbnCfryt3Em6cFQHAbzVwUdH/I+/YFAPOS2EMV1
ymFmujzdIZwOfLyG9OAyPVn4IO1eVii2SyjbxazQnF5QvcztbxOWUubQp6UlDBXG
TmUidzk1wSZfnxjKNP4pyh7jYM7BxBaRhOcLLavuPkCiQA1PbtDmj8myEyaRgAOY
PTRM/nQuMe3AabQ7yzBneIYaajabRIoncaSB0iOpN6MfX/1+ij8P8cZ1VTICrXUf
L9WKvitXs7Nq1D/JiPgO1ZnF8g1UBJ5HeNDMpzpxBypTBzCTDVAixWdOY4GchxKN
nP18WXMqC5e2kqTJ0MuuyrUOYs5jO+L46gnSeOV3a5q7P4DZVkWFpPIaYhTMCoxP
JW4ajKDh0kRbbtDa9ENw7wHda9DJgSWbtUZWPX4ZZ2bHGxQr5LgCkamyNQK4+/cD
a3vn6VRR33oKFW61S4kHAiTYdPQovYRln6wHlOaq/ucZloSE+Nc=
=Vw5M
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--
