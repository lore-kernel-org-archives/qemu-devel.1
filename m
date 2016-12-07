Received: from eggs.gnu.org ([2001:4830:134:3::10]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXuG-00041w-5C
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXuC-0005Wz-1Y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:48:52 -0500
Date: Wed, 7 Dec 2016 16:48:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161207054851.GG12489@umbus.fritz.box>
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481053210-26821-2-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <1481053210-26821-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] target-ppc: Implement bcd_is_valid
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:40:04PM -0200, Jose Ricardo Ziviani wrote:
> A function to check if all digits of a given BCD number is valid is
> here presented because more instructions will need to reuse the
> same code.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

I've applied this patch to ppc-for-2.9, the rest still have comments
on them.

> ---
>  target-ppc/int_helper.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 7030f61..7989b1f 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -2596,6 +2596,24 @@ static void bcd_put_digit(ppc_avr_t *bcd, uint8_t =
digit, int n)
>      }
>  }
> =20
> +static bool bcd_is_valid(ppc_avr_t *bcd)
> +{
> +    int i;
> +    int invalid =3D 0;
> +
> +    if (bcd_get_sgn(bcd) =3D=3D 0) {
> +        return false;
> +    }
> +
> +    for (i =3D 1; i < 32; i++) {
> +        bcd_get_digit(bcd, i, &invalid);
> +        if (unlikely(invalid)) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>  static int bcd_cmp_zero(ppc_avr_t *bcd)
>  {
>      if (bcd->u64[HI_IDX] =3D=3D 0 && (bcd->u64[LO_IDX] >> 4) =3D=3D 0) {
> @@ -3013,18 +3031,13 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t =
*a, ppc_avr_t *b, uint32_t ps)
> =20
>  uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
>  {
> -    int i;
> -    int invalid =3D 0;
>      int sgnb =3D bcd_get_sgn(b);
> =20
>      *r =3D *b;
>      bcd_put_digit(r, bcd_preferred_sgn(sgnb, ps), 0);
> =20
> -    for (i =3D 1; i < 32; i++) {
> -        bcd_get_digit(b, i, &invalid);
> -        if (unlikely(invalid)) {
> -            return CRF_SO;
> -        }
> +    if (bcd_is_valid(b) =3D=3D false) {
> +        return CRF_SO;
>      }
> =20
>      return bcd_cmp_zero(r);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR6LCAAoJEGw4ysog2bOSvgwQAJu//7C66GqSWYIyj3sMz7Ne
jaM3VfXGkqMjVV8yh2+U0HJitcdl/SYWqLWZEhVwZi7GLT2Z9Lqq3V0feCOpLJiC
L6gcuhYB/rQuTNzIQaY3JS7K80W/D4g1j403nZVKCd4XPrFZVlotIGpFDpsb6/+T
LioOySIiZkN47nJRZ2r2uBo1FdKjSJa/ZZocZeRiuACtlvW8rJ5hCOcOjJLBmyO8
MsjNWIdrfXvbnTNob7Q7rCNHLTCA9uMR402wT0rF8xTnaIeI+8KZfSnJPiFyWXXC
cY0X8MJnoBLt7PWgPpTrdnbBauA1vfJuvs4KRWfUw2LIUupQ+HQ2Z86iRJJY6hDc
Pfnfv2BL+ziNTMlHl4dovCOx4e/WDdRPj13CSM3vLnhn7Kg9XDPQw0qzbF5Ely8I
fo3MaBtsbj+cF85UBL8kpF2WNwSqPDjp37PUBSbiP90fY6nei864UNFstUELM4gX
0j7EZFewiOJxcCroqmOaFgARQhFSO6rtwzCRPxzKGNUZ+s2dFYmtCInuQRINzSXA
GrQ5BM3Bs4vRQjRPPHvGhyVbjoDUMOZeyBKUM6ES8KrUobx2cJBi24DK3p2U1ipu
znG4J+QxGb/AWHOxLxJYsXr7iHtUFfsxdfQ3f15IlVlC7bLD7EyPF5NBIgh+seAj
1YVD8KwQdEdNiXD2EUYs
=OyOA
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
