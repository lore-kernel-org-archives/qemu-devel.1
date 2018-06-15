Received: from eggs.gnu.org ([2001:4830:134:3::10]:35109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTell-0005JQ-HK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTelk-0001ym-FB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 22:47:21 -0400
Date: Fri, 15 Jun 2018 12:47:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615024711.GL4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AGBBLMjITsWHeOTZ"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 3/6] ppc/pnv: introduce an 'isa_bus_name'
 field under the LPC model
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


--AGBBLMjITsWHeOTZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:40PM +0200, C=E9dric Le Goater wrote:
> This is again a small cleanup to hide to the machine the details of
> the ISA bus. The ISA bus device tree nodename will be different on
> Power9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>



> ---
>  include/hw/ppc/pnv_lpc.h | 1 +
>  hw/ppc/pnv.c             | 9 +--------
>  hw/ppc/pnv_lpc.c         | 4 ++++
>  3 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index fb4b7b83d798..e8f7dcb9bfe9 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -70,6 +70,7 @@ typedef struct PnvLpcController {
>      PnvPsi *psi;
> =20
>      bool   primary;
> +    char   *isa_bus_name;

I'd suggest putting 'dt' somewhere in the field to make it more
obvious that this is about the bus's path in the device tree, rather
than say the bus's QOM path name.

>  } PnvLpcController;
> =20
>  ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d2126ee4affc..72cfe4c2627c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -267,14 +267,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uin=
t32_t pir,
> =20
>  static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
>  {
> -    char *name;
> -    int offset;
> -
> -    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> -                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
> -    offset =3D fdt_path_offset(fdt, name);
> -    g_free(name);
> -    return offset;
> +    return fdt_path_offset(fdt, chip->lpc.isa_bus_name);
>  }

Having reduced this wrapper to 1 line, I'm not sure there is any
remaining point to it.

> =20
>  static void pnv_dt_chip(PnvChip *chip, void *fdt)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 7c6c012d5176..7f13c4bcf52c 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -481,6 +481,10 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
>                            &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
>                            PNV_XSCOM_LPC_SIZE);
> +
> +    lpc->isa_bus_name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> +                                        (uint64_t) PNV_XSCOM_BASE(chip),
> +                                        PNV_XSCOM_LPC_BASE);
>  }
> =20
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AGBBLMjITsWHeOTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjKK8ACgkQbDjKyiDZ
s5KjJg//RoIgvKtaKtY4cwSaJ6j5rZed697gSclPNqMo0vxtM4KwpPMYESiVZEiZ
5UKl5Z/RATx9g0YsCSC+FkrOp34kEdsGo1Ln/ZB7lPgIuAMnGhWr56tG9sTQJA+X
gj6yrH3J7L1Z2jI5sc0SPiuu2p5YTgyxv4DUwyWXhRRHWeLKOn2paQt84sHI8FQK
scQU5erCSy6lfkxGVnAMWkBsbxtzviySh5HWwLg3ulIJwt5r7M/ffDkQS+TVLyLs
wwFNes3oL58Xtb8mf/R2H2Smr6qDLR9GLKL9vLGt612LsPsMxD3geM3rSDL+J3uF
aScOdrg3DquHermQJMp8DcZQjQlvfNqVgjqWYhWRcKkgoWQ9tkeOjrmLP4BO2z8r
2uiCf21eiR5cQzK730rFsLGgA/gX0ddw2nvFvCyyt0WUTZZ27/Ax7ROux1b+AwGx
Y58LvE2zux+pTpd+Edi/mGrXk4yJp0X8EAq6uBCez8epcVHOcWN4wkbMpdr7FSUX
/BDszGc7ATMnhccwkcEObCMWued8mvJtS1l/+KuxhFsaf9OMfs0+9AdCyHE8F5QE
xmCegV6nFsN2AaCEX4xeXmgr6tVzkCOeqpQQ1xJD/bAwumxIxF5qBv+ZOvOgvM0y
B6ePQcmWdnt3MuphDEopr9PfOP0ovCrt87YoaSpZ3biB+3wfK6Y=
=8Ry2
-----END PGP SIGNATURE-----

--AGBBLMjITsWHeOTZ--
