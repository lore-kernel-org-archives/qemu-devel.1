Received: from eggs.gnu.org ([2001:4830:134:3::10]:49494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmr-0006UR-Ls
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsmo-0004Hm-Eo
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:19:57 -0400
Date: Sun, 10 Sep 2017 13:16:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910031655.GX2735@umbus.fritz.box>
References: <20170908143344.12960-1-clg@kaod.org>
	<20170908143344.12960-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5FFaGRZUwcpbKFrw"
Content-Disposition: inline
In-Reply-To: <20170908143344.12960-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] ppc/xive: fix OV5_XIVE_EXPLOIT bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--5FFaGRZUwcpbKFrw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 04:33:42PM +0200, C=E9dric Le Goater wrote:
> On POWER9, the Client Architecture Support (CAS) negotiation process
> determines whether the guest operates in XIVE Legacy compatibility or
> in XIVE exploitation mode. Now that we have initial guest support for
> the XIVE interrupt controller, let's fix the bits definition which have
> evolved in the latest specs.
>=20
> The platform advertises the XIVE Exploitation Mode support using the
> property "ibm,arch-vec-5-platform-support-vec-5", byte 23 bits 0-1 :
>=20
>  - 0b00 XIVE legacy mode Only
>  - 0b01 XIVE exploitation mode Only
>  - 0b10 XIVE legacy or exploitation mode
>=20
> The OS asks for XIVE Exploitation Mode support using the property
> "ibm,architecture-vec-5", byte 23 bits 0-1:
>=20
>  - 0b00 XIVE legacy mode Only
>  - 0b01 XIVE exploitation mode Only
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.11, thanks.

> ---
>  hw/ppc/spapr.c              | 2 +-
>  include/hw/ppc/spapr_ovec.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cec441cbf48d..3e3ff1fbc988 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -914,7 +914,7 @@ static void spapr_dt_ov5_platform_support(void *fdt, =
int chosen)
>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> =20
>      char val[2 * 4] =3D {
> -        23, 0x00, /* Xive mode: 0 =3D legacy (as in ISA 2.7), 1 =3D Expl=
oitation */
> +        23, 0x00, /* Xive mode, filled in below. */
>          24, 0x00, /* Hash/Radix, filled in below. */
>          25, 0x00, /* Hash options: Segment Tables =3D=3D no, GTSE =3D=3D=
 no. */
>          26, 0x40, /* Radix options: GTSE =3D=3D yes. */
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 9edfa5ff7530..bf25e5d954a1 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -51,7 +51,8 @@ typedef struct sPAPROptionVector sPAPROptionVector;
>  #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
>  #define OV5_HP_EVT              OV_BIT(6, 5)
>  #define OV5_HPT_RESIZE          OV_BIT(6, 7)
> -#define OV5_XIVE_EXPLOIT        OV_BIT(23, 7)
> +#define OV5_XIVE_BOTH           OV_BIT(23, 0)
> +#define OV5_XIVE_EXPLOIT        OV_BIT(23, 1) /* 1=3Dexploitation 0=3Dle=
gacy */
> =20
>  /* ISA 3.00 MMU features: */
>  #define OV5_MMU_BOTH            OV_BIT(24, 0) /* Radix and hash */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5FFaGRZUwcpbKFrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0ro0ACgkQbDjKyiDZ
s5J2JRAAhEDAjIiM8oc6s7CFi8igCz4ztMM9/IKKxH/fZaZchoHtKOAn2mNIHoCz
EbdPnpKF0n4s2S6UhUgOfBAkZXu4Z/4VS+ENmbEDkmPkCQTor+3ha3bhZ9+1+O/U
toCIsgk8VGT0R1OcdXfNsOPKART4m4x9HjWh9tPJhU+h5Jr6eFyxTc9oHpQQwuRa
rsYRAtxJ+ShD3WpzfP/QApmFWrSEXduwNsxmfVmwPNL9eKobxVLktP2p7CRHC3yb
X+WkxUImgBVuKFare11hx+whKM0N8rlWxyCEnSRO8Dfveoun24tEt9Mbt6uRBIKu
+fRG2sTMmyYFUqYSjHZ5TS9KVkhYbhUbd2v/Odi1oDeUcGe0lyygCzve1aN2ATPw
jIBxYvFnoQQQV+ciCXzqx5uCNVhH7NwbcuqCu5lStK+ZrYyuAzL2Ys811nq7wsKe
oAXxCkA+1cuaYaeWWDvgPE6TJlwS4WS4OIIBTJXOidI8Qrm2y7aI37y1Tw+qblZY
2sK9PDi4u6fj6o3hCrL67+8Bpsj4oF4HeawBqwA5ncGMMjGPYTpgi8h8QvSLkqq8
NCxnJIiw1mMIt4zt1nJcrY+LM+XmHvOTee4fMuP7UwuGVO08lmJoDJcBZBebMh4E
gs29zNoGpif5cG2lz2qDdWCd9bKaxeNUubG6lg4i9nM4mDJY1o4=
=dj1K
-----END PGP SIGNATURE-----

--5FFaGRZUwcpbKFrw--
