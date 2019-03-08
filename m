Received: from eggs.gnu.org ([209.51.188.92]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006FC-Gm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240K-00010K-DE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:54 -0500
Date: Fri, 8 Mar 2019 11:56:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308005653.GQ7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9QFLzLG6sIJR48rg"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 13/15] ppc/pnv: add more dummy XSCOM
 addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9QFLzLG6sIJR48rg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:46PM +0100, C=E9dric Le Goater wrote:
> To improve OPAL/skiboot support. We don't need to strictly model these
> XSCOM accesses.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/pnv_xscom.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 46fae41f32b0..c285ef514e88 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -64,11 +64,21 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
>      switch (pcba) {
>      case 0xf000f:
>          return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
> +    case 0x18002:       /* ECID2 */
> +        return 0;
> +
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
> -    case 0x2020007:     /* ADU stuff */
> -    case 0x2020009:     /* ADU stuff */
> -    case 0x202000f:     /* ADU stuff */
> +
> +        /* P9 xscom reset */
> +    case 0x0090018:     /* Receive status reg */
> +    case 0x0090012:     /* log register */
> +    case 0x0090013:     /* error register */
> +
> +        /* P8 xscom reset */
> +    case 0x2020007:     /* ADU stuff, log register */
> +    case 0x2020009:     /* ADU stuff, error register */
> +    case 0x202000f:     /* ADU stuff, receive status register*/
>          return 0;
>      case 0x2013f00:     /* PBA stuff */
>      case 0x2013f01:     /* PBA stuff */
> @@ -100,9 +110,20 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
>      case 0x1010c03:     /* PIBAM FIR MASK */
>      case 0x1010c04:     /* PIBAM FIR MASK */
>      case 0x1010c05:     /* PIBAM FIR MASK */
> -    case 0x2020007:     /* ADU stuff */
> -    case 0x2020009:     /* ADU stuff */
> -    case 0x202000f:     /* ADU stuff */
> +        /* P9 xscom reset */
> +    case 0x0090018:     /* Receive status reg */
> +    case 0x0090012:     /* log register */
> +    case 0x0090013:     /* error register */
> +
> +        /* P8 xscom reset */
> +    case 0x2020007:     /* ADU stuff, log register */
> +    case 0x2020009:     /* ADU stuff, error register */
> +    case 0x202000f:     /* ADU stuff, receive status register*/
> +
> +    case 0x2013028:     /* CAPP stuff */
> +    case 0x201302a:     /* CAPP stuff */
> +    case 0x2013801:     /* CAPP stuff */
> +    case 0x2013802:     /* CAPP stuff */
>          return true;
>      default:
>          return false;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9QFLzLG6sIJR48rg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBvdUACgkQbDjKyiDZ
s5Lvhg/6AhwecWt9cNgScqLe7vbuYzXO2WNLOZlnHfx0C45ISa6yFL6V9c2D9T1y
KsbyfFXrVpCNyu26ba52p3Joo08O1JPvSSYpwwMiDZfL+BS0OURxL9HCPB6/4UmP
MPanDzc7toiNn27G28vdubyHb2eJH5NJWW8cR3VUsQKPhsWm1IyT/OfH5v4PiJOk
UNjrKDG3iLFZSmRfixYvFOqCP+QVzGZ8gjNGkfV9q3M+XdkJrjzKqmyVTG5ZUDC+
KdX+xkXZR2jIBALh6W3jIWbeK16d+rv1dfYQSdTnsa5t5RnQ8PpctSyNhKeTcTLd
54tCOyfX2hWYTeAgX4O4wXR4GSntG0R/uAIKWVlibi3/9dFpaUNO2/tdiQfk6Hbm
FPxhSz6cRLIv3LXFMKONnFMmUfnxw+j3+r+QoeLpB9XTG7P4uzqY781n7pTKnCG2
1yNf49EOww0ZXEhcXPDsTqjytwb+Dp7dePrTBnXxDOy2gITD7zrnZaUaiVkxsBxJ
XZ5Xh+/4q+0vFhgliXaon72XWusZx/Z/qFOMc9PwztBiDpPAahCUbUvLsZhzbuIQ
KAbGYQ7MDUA0VoEVjeItUItrCBqIIuTCqdtglgPwePsShoNPmmZOywH1/EcCQrJ2
0cNAR7wfaWmwx8XH98qdShq59b9JkXDJxFPfXdmNdny8l4hnhuI=
=RFXP
-----END PGP SIGNATURE-----

--9QFLzLG6sIJR48rg--
