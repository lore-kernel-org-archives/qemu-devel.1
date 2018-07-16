Received: from eggs.gnu.org ([2001:4830:134:3::10]:59175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fewPc-0006En-8w
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fewPY-0001sB-0m
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:08 -0400
Received: from ozlabs.org ([203.11.71.1]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fewPW-0001r1-U8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 01:51:03 -0400
Date: Mon, 16 Jul 2018 14:25:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716042544.GH2599@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-6-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-6-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 05/14] timer: ds1338 change write handling
 and fix wday_offset handling
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


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:52AM -0700, Michael Davidsaver wrote:
> instead of a read-modify-write, do direct translation
> of device registers to struct tm members.
>=20
> This new ds1338_update() is the reverse of
> the existing capture_current_time().
>=20
> Simplifies later handling of CENTURY bit in
> similar Dallas RTC chips.
>=20
> Correctly handle different real weekday in
> guest and host timezones.
> Allow guest to use any day as start of week
> (day 1).  eg. Monday instead of Sunday.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> ---
>  hw/timer/ds1338.c | 95 ++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 48 insertions(+), 47 deletions(-)
>=20
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 637a0f4246..0134ffd72a 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -110,7 +110,10 @@ static void capture_current_time(DS1338State *s)
>          /* 24 hour mode. */
>          s->nvram[R_HOUR] =3D to_bcd(now.tm_hour);
>      }
> -    s->nvram[R_WDAY] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> +    s->nvram[R_WDAY] =3D (now.tm_wday + s->wday_offset) % 7;
> +    if (s->nvram[R_WDAY] =3D=3D 0) {
> +        s->nvram[R_WDAY] =3D 7;
> +    }

This looks a bit odd - you've removed the + 1 here, but...

>      s->nvram[R_DATE] =3D to_bcd(now.tm_mday);
>      s->nvram[R_MONTH] =3D to_bcd(now.tm_mon + 1);
>      s->nvram[R_YEAR] =3D to_bcd(now.tm_year - 100);
> @@ -161,6 +164,46 @@ static int ds1338_recv(I2CSlave *i2c)
>      return res;
>  }
> =20
> +/* call after guest writes to current time registers
> + * to re-compute our offset from host time.
> + */
> +static void ds1338_update(DS1338State *s)
> +{
> +
> +    struct tm now =3D {};
> +
> +    /* TODO: Implement CH (stop) bit?  */
> +    now.tm_sec =3D from_bcd(s->nvram[R_SEC] & 0x7f);
> +    now.tm_min =3D from_bcd(s->nvram[R_MIN] & 0x7f);
> +    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
> +        /* 12 hour (1-12) */
> +        /* read and wrap 1-12 -> 0-11 */
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR12=
)) % 12u;
> +        if (ARRAY_FIELD_EX32(s->nvram, HOUR, AMPM)) {
> +            now.tm_hour +=3D 12;
> +        }
> +
> +    } else {
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR24=
));
> +    }
> +    now.tm_wday =3D from_bcd(s->nvram[R_WDAY]) - 1u;

=2E. you still have the -1 here.  Am I missing something?

> +    now.tm_mday =3D from_bcd(s->nvram[R_DATE] & 0x3f);
> +    now.tm_mon =3D from_bcd(s->nvram[R_MONTH] & 0x1f) - 1;
> +    now.tm_year =3D from_bcd(s->nvram[R_YEAR]) + 100;
> +    s->offset =3D qemu_timedate_diff(&now);
> +
> +    {
> +        /* Round trip to get real wday_offset based on time delta and
> +         * ref. timezone.
> +         * Race if midnight (in ref. timezone) happens here.
> +         */
> +        int user_wday =3D now.tm_wday;
> +        qemu_get_timedate(&now, s->offset);
> +
> +        s->wday_offset =3D (user_wday - now.tm_wday) % 7 + 1;
> +    }
> +}
> +
>  static int ds1338_send(I2CSlave *i2c, uint8_t data)
>  {
>      DS1338State *s =3D DS1338(i2c);
> @@ -170,52 +213,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>          s->addr_byte =3D false;
>          return 0;
>      }
> -    if (s->ptr < 7) {
> -        /* Time register. */
> -        struct tm now;
> -        qemu_get_timedate(&now, s->offset);
> -        switch(s->ptr) {
> -        case R_SEC:
> -            /* TODO: Implement CH (stop) bit.  */
> -            now.tm_sec =3D from_bcd(data & 0x7f);
> -            break;
> -        case R_MIN:
> -            now.tm_min =3D from_bcd(data & 0x7f);
> -            break;
> -        case R_HOUR:
> -            if (FIELD_EX32(data, HOUR, SET12)) {
> -                /* 12 hour (1-12) */
> -                /* read and wrap 1-12 -> 0-11 */
> -                now.tm_hour =3D from_bcd(FIELD_EX32(data, HOUR, HOUR12))=
 % 12u;
> -                if (FIELD_EX32(data, HOUR, AMPM)) {
> -                    now.tm_hour +=3D 12;
> -                }
> -
> -            } else {
> -                now.tm_hour =3D from_bcd(FIELD_EX32(data, HOUR, HOUR24));
> -            }
> -            break;
> -        case R_WDAY:
> -            {
> -                /* The day field is supposed to contain a value in
> -                   the range 1-7. Otherwise behavior is undefined.
> -                 */
> -                int user_wday =3D (data & 7) - 1;
> -                s->wday_offset =3D (user_wday - now.tm_wday + 7) % 7;
> -            }
> -            break;
> -        case R_DATE:
> -            now.tm_mday =3D from_bcd(data & 0x3f);
> -            break;
> -        case R_MONTH:
> -            now.tm_mon =3D from_bcd(data & 0x1f) - 1;
> -            break;
> -        case R_YEAR:
> -            now.tm_year =3D from_bcd(data) + 100;
> -            break;
> -        }
> -        s->offset =3D qemu_timedate_diff(&now);
> -    } else if (s->ptr =3D=3D R_CTRL) {
> +    if (s->ptr =3D=3D R_CTRL) {
>          /* Control register. */
> =20
>          /* Ensure bits 2, 3 and 6 will read back as zero. */
> @@ -227,6 +225,9 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
> =20
>      }
>      s->nvram[s->ptr] =3D data;
> +    if (s->ptr <=3D R_YEAR) {
> +        ds1338_update(s);
> +    }
>      inc_regptr(s);
>      return 0;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMHkgACgkQbDjKyiDZ
s5KBqhAAlKw3b2vJjfIheKYrJ0K+BXfJknAHU7Fgwp/Iwqmr8XgSeT4jOARxS9OC
5vdJHiLymj9bIKRj4pof8P6TuqbSYa92UmZ8IF6o1aZQwX0+YCdUehlhYwnqwMAp
VvIhcfXdXxsY2iVXFhTH5UYb3zm2qdxlscFjsKFhDnrjAiX7HdGCHcFc1ucjuUDr
v6e4Rt+Y62N93RbgA2VEbtc2LTp6ifDVaKOk6WWnVGbcWKA8W8njjBrbo/0PdLPY
N5xMHJ5ozx8vgmEIlCd51GMNk9roIw4km5CY5yrQ7+ZgEQBA76zbcB9vYk2T0/pG
2R3FD2yxW2SLCvJ950llXpj+NMnYF+bwICJGP681fFV+LM0iGJP3ArCZAnbIbwRV
4qf1XZUHuOe3pTDV9YbHmlFJZxamotCpgnaDW2tHVplQXy5n7S7H8qG2qLM03kU/
Lr9TVm4jO3SwPmVGaqXO5i5ne5aTa7N6YYF9dwpBIMhAaYkRAM/0Kazdwdmkrtx4
68Z3YZJRs/7GiFQEE1gQZH1f6rWStNSwyBIEYCWaiTmIencBPnp/6H9yvV7JSsCA
CFmdlqzqjeAybHc5F9Q3iOBU09FQLVE58kHe6NYy7kttzs3dWyWbfkfElXm1mBRg
/Vgkau7PTYhHRMFMy1EfxRxp/+2LM1vfMzNH/4ooIBjzz8X/smw=
=2fOg
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
