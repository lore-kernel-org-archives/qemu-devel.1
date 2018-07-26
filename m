Received: from eggs.gnu.org ([2001:4830:134:3::10]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiVGk-00027R-Cg
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiVGh-0007AJ-EV
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 21:40:42 -0400
Date: Thu, 26 Jul 2018 11:40:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180726014020.GJ6830@umbus.fritz.box>
References: <1532434384-12355-1-git-send-email-yasmins@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
Content-Disposition: inline
In-Reply-To: <1532434384-12355-1-git-send-email-yasmins@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: simplify bcdadd/sub functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yasmin Beatriz <yasmins@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 12:13:04PM +0000, Yasmin Beatriz wrote:
> After solving a corner case in bcdsub, this patch simplifies the logic
> of both bcdadd/sub instructions by removing some unnecessary local flags.
>=20
> Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
> ---
>  target/ppc/int_helper.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index fa18e6e..b8ac4bb 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2671,16 +2671,14 @@ static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_t *b)
>      return 0;
>  }
> =20
> -static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *in=
valid,
> +static void bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *i=
nvalid,
>                         int *overflow)
>  {
>      int carry =3D 0;
>      int i;
> -    int is_zero =3D 1;
>      for (i =3D 1; i <=3D 31; i++) {
>          uint8_t digit =3D bcd_get_digit(a, i, invalid) +
>                          bcd_get_digit(b, i, invalid) + carry;
> -        is_zero &=3D (digit =3D=3D 0);
>          if (digit > 9) {
>              carry =3D 1;
>              digit -=3D 10;
> @@ -2689,26 +2687,20 @@ static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a=
, ppc_avr_t *b, int *invalid,
>          }
> =20
>          bcd_put_digit(t, digit, i);
> -
> -        if (unlikely(*invalid)) {
> -            return -1;
> -        }
>      }
> =20
>      *overflow =3D carry;
> -    return is_zero;
>  }
> =20
> -static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *in=
valid,
> +static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *i=
nvalid,
>                         int *overflow)
>  {
>      int carry =3D 0;
>      int i;
> -    int is_zero =3D 1;
> +
>      for (i =3D 1; i <=3D 31; i++) {
>          uint8_t digit =3D bcd_get_digit(a, i, invalid) -
>                          bcd_get_digit(b, i, invalid) + carry;
> -        is_zero &=3D (digit =3D=3D 0);
>          if (digit & 0x80) {
>              carry =3D -1;
>              digit +=3D 10;
> @@ -2717,14 +2709,9 @@ static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a,=
 ppc_avr_t *b, int *invalid,
>          }
> =20
>          bcd_put_digit(t, digit, i);
> -
> -        if (unlikely(*invalid)) {
> -            return -1;
> -        }
>      }
> =20
>      *overflow =3D carry;
> -    return is_zero;
>  }
> =20
>  uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32=
_t ps)
> @@ -2734,25 +2721,25 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *=
a, ppc_avr_t *b, uint32_t ps)
>      int sgnb =3D bcd_get_sgn(b);
>      int invalid =3D (sgna =3D=3D 0) || (sgnb =3D=3D 0);
>      int overflow =3D 0;
> -    int zero =3D 0;
>      uint32_t cr =3D 0;
>      ppc_avr_t result =3D { .u64 =3D { 0, 0 } };
> =20
>      if (!invalid) {
>          if (sgna =3D=3D sgnb) {
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, ps);
> -            zero =3D bcd_add_mag(&result, a, b, &invalid, &overflow);
> -            cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
> +            bcd_add_mag(&result, a, b, &invalid, &overflow);
> +            cr =3D bcd_cmp_zero(&result);
>          } else if (bcd_cmp_mag(a, b) > 0) {
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, ps);
> -            zero =3D bcd_sub_mag(&result, a, b, &invalid, &overflow);
> +            bcd_sub_mag(&result, a, b, &invalid, &overflow);
>              cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
>          } else if (bcd_cmp_mag(a, b) =3D=3D 0) {
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(0, ps);
> -            zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);
> +            bcd_sub_mag(&result, b, a, &invalid, &overflow);

I don't think you actually need the sub here, since you know the
result is going to be zero.

Although.. in all of the different-sign cases aren't we effectively
doing the subtraction twice - once in bcd_cmp_mag() then again in
bcd_sub_mag()?

> +            cr =3D CRF_EQ;
>          } else {
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgnb, ps);
> -            zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);
> +            bcd_sub_mag(&result, b, a, &invalid, &overflow);
>              cr =3D (sgnb > 0) ? CRF_GT : CRF_LT;
>          }
>      }
> @@ -2762,8 +2749,6 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a,=
 ppc_avr_t *b, uint32_t ps)
>          cr =3D CRF_SO;
>      } else if (overflow) {
>          cr |=3D CRF_SO;
> -    } else if (zero) {
> -        cr =3D CRF_EQ;
>      }
> =20
>      *r =3D result;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltZJn8ACgkQbDjKyiDZ
s5ItcQ//WdSJAcj5DRsKiDUmqr7MYn9oCmFHTCXbjx3dgF7XjljORoDxNDppWmG/
p8y/8OQ2CRKgvbuPMwCGFps3Ig+omUbXb5tLrFIwCBVi2KqKn8U2m/66Z1Oao8wJ
buRhc9xL/T6ghGwf1v7w4sdvxezhp9tSYls0YbrPcUXd9y/anEIBqEVMjEtD0a3G
75WPgWt6YY0QgTgjFaJUSi+7JrlPtuQVATSWn9nOFXNHlQDmrwzgApRD5S76q/Q8
2FJUb/g3iCzerH3W31hirZqvU/FGatO+T5HdOhjqR0ZM1oMVcBIoQ/PIWLaZJdyS
iWwsshNKGBXPVK/DO7Ervjw+5Ei/QpSMZWVQlrILMQhV5sjcPhXYABa/kI2BGHoJ
NVoo8afCxvPEPKNA6rCrHHqUVZTAuLJ1OBzfYSkx5X5dd8ch1nwKVQ/47E18+Bz9
3o4VjMVnUGujcJPQmDFvWVZ/+rWMnQBugbkprDSUjnQ7XD2+qmGubD6y3WCT72fb
W6tCGxFOjmOxgHqcGQRvRfuWNaKfMZoqymjvajCuQT2xDrFyAmC1/qrhpFbaMuMl
g2HH6ampBP2tpHWTKXRY6DuTih5ZMbABZaSxXDGC/aud0aA89jDR6eBNUfsXxPJX
ErXYipMMoxUfgmKFtUDqd9x8BxoPzJuiHRM2IOgeSDM836guA+I=
=AdNN
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--
