Received: from eggs.gnu.org ([2001:4830:134:3::10]:55474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgLpR-00081U-R5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgLpQ-0008Gn-HC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:34:49 -0500
Date: Wed, 22 Feb 2017 11:57:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170222005757.GB12577@umbus.fritz.box>
References: <1487684021-22713-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1487684021-22713-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/ppc405_uc.c: Avoid integer overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 01:33:41PM +0000, Peter Maydell wrote:
> When performing clock calculations, the ppc405_uc code
> has several places where it multiplies together two
> 32-bit variables and assigns the result to a 64-bit
> variable. This doesn't quite do what is intended because
> C will compute a 32-bit multiply result. Add casts to
> ensure we don't truncate the result.
>=20
> (Spotted by Coverity, CID 1005504, 1005505.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Ouch.  Applied to ppc-for-2.9.

> ---
>  hw/ppc/ppc405_uc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index d6d3fc2..d5df94a 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1881,7 +1881,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
>          D1 =3D (((cpc->pllmr >> 20) - 1) & 0xF) + 1; /* FBDV */
>          D2 =3D 8 - ((cpc->pllmr >> 16) & 0x7); /* FWDVA */
>          M =3D D0 * D1 * D2;
> -        VCO_out =3D cpc->sysclk * M;
> +        VCO_out =3D (uint64_t)cpc->sysclk * M;
>          if (VCO_out < 400000000 || VCO_out > 800000000) {
>              /* PLL cannot lock */
>              cpc->pllmr &=3D ~0x80000000;
> @@ -1892,7 +1892,7 @@ static void ppc405cr_clk_setup (ppc405cr_cpc_t *cpc)
>          /* Bypass PLL */
>      bypass_pll:
>          M =3D D0;
> -        PLL_out =3D cpc->sysclk * M;
> +        PLL_out =3D (uint64_t)cpc->sysclk * M;
>      }
>      CPU_clk =3D PLL_out;
>      if (cpc->cr1 & 0x00800000)
> @@ -2242,7 +2242,7 @@ static void ppc405ep_compute_clocks (ppc405ep_cpc_t=
 *cpc)
>  #ifdef DEBUG_CLOCKS_LL
>          printf("FWDA %01" PRIx32 " %d\n", (cpc->pllmr[1] >> 16) & 0x7, D=
);
>  #endif
> -        VCO_out =3D cpc->sysclk * M * D;
> +        VCO_out =3D (uint64_t)cpc->sysclk * M * D;
>          if (VCO_out < 500000000UL || VCO_out > 1000000000UL) {
>              /* Error - unlock the PLL */
>              printf("VCO out of range %" PRIu64 "\n", VCO_out);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrOITAAoJEGw4ysog2bOSIIgP/3RTo9krfMWp91BWPogygsVz
uPckOtI/MLYTPb2x5NLRIbqqiZWKK4JFqSXUiR1fYfpY9zCjPJhIujG4ENsgoxg9
pQk0UHAJWKPzzQaCLQt9plC+WHFYzbWRdeHql8zhl95B6wKz6+L04FUnbJoISfqd
kJZ4gwdjftqehZGWNCpogF73xHB5dAVn6hvxMU20jGfsB8l3yOrPd19qY2Jr5YFd
dnP7LkgRXQGkj5mq2tK4CRn/rTfB+9Nxjf3H35Urnsn8Dv0cMJSUWbsD2jS7ty+o
LKlM77VG8MlzkeO23SO1HHUd3IhvukW1rMEFBmBLu2W/4++2I21zYCZU7apnsR75
S5imerG99MvsqvSOMBQQSsKJPF8I2GWPltsWgfQzhTJikBj8muoAuLWWCsXls8Wr
nLmgnJdOxDcRkrUUMyz8r54HqaSgoanyD0Nj+6vbVepzOxXpu2iQhFtrLG8kOXo7
Dcq2z3OXSu+8ttqttclAyo0z9NuDIMEWPyD7PYayktuIi2NTUtBRBIxEjTdo/v7T
fY5GrqaZcqZuCL03Z4ZBz5SHeW1v2UmZTG8ldq9672OoxoARx62tLmx8Iiq/vky5
TVRvA3D5XlZZkMFuWX+i4jZMXqtVYKa3dqaeY5BOEMiw6FGeWyYhduyoHCyCPsoT
HqEoDWnwHsDi8mshwsoD
=f96Z
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
