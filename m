Received: from eggs.gnu.org ([2001:4830:134:3::10]:35043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlnc-0006qx-3K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlna-0008Cq-TQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:56 -0400
Date: Tue, 11 Apr 2017 12:40:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411024041.GW27571@umbus>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
	<1491832618-27536-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CpBQqYjq/d0HQTAP"
Content-Disposition: inline
In-Reply-To: <1491832618-27536-3-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] ppc/pnv: enable only one LPC bus
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


--CpBQqYjq/d0HQTAP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:56:52PM +0200, C=E9dric Le Goater wrote:
> The firmware (skiboot) chooses the default LPC bus of a multichip
> systems using a "primary" property. The LPC bus of chip 0 should be
> the only connected in the system. Let's advertise it in the device
> tree.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  Changes since v1:
>=20
>  - the device tree is populated for all LPC busses of the system but
>    only the one on chip 0 has the "primary" property.
>=20
>  hw/ppc/pnv.c             |  2 ++
>  hw/ppc/pnv_lpc.c         | 23 ++++++++++++++---------
>  include/hw/ppc/pnv_lpc.h |  2 ++
>  3 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 27589b91d1cf..7d742b6e34e1 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -765,6 +765,8 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
>      g_free(typename);
> =20
>      /* Create LPC controller */
> +    object_property_set_int(OBJECT(&chip->lpc), chip->chip_id, "chip-id",
> +                            &error_fatal);
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>                               &error_fatal);
>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index baee366d386a..13d7a695678d 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -92,14 +92,6 @@ enum {
>  #define LPC_HC_REGS_OPB_SIZE    0x00001000
> =20
> =20
> -/*
> - * TODO: the "primary" cell should only be added on chip 0. This is
> - * how skiboot chooses the default LPC controller on multichip
> - * systems.
> - *
> - * It would be easly done if we can change the populate() interface to
> - * replace the PnvXScomInterface parameter by a PnvChip one
> - */
>  static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {
>      const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
> @@ -110,6 +102,7 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, v=
oid *fdt, int xscom_offset)
>          cpu_to_be32(lpc_pcba),
>          cpu_to_be32(PNV_XSCOM_LPC_SIZE)
>      };
> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> =20
>      name =3D g_strdup_printf("isa@%x", lpc_pcba);
>      offset =3D fdt_add_subnode(fdt, xscom_offset, name);
> @@ -119,7 +112,13 @@ static int pnv_lpc_populate(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
>      _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
>      _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
>      _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
> -    _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
> +
> +    /* The firmware (skiboot) chooses the default LPC bus of the
> +     * system using a "primary" property.
> +     */
> +    if (lpc->chip_id =3D=3D 0x0) {
> +        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
> +    }

So, the choice of primary bus is really a machine level thing, rather
than chip level.

So I think it would make more sense for the machine to poke the
'primary' property into the device tree afterwards, rather than adding
it initially within the chip/LPC code.  That will then avoid having to
pass the chip-id property into the LPC.

>      _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
>      return 0;
>  }
> @@ -486,6 +485,11 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
>      lpc->psi =3D PNV_PSI(obj);
>  }
> =20
> +static Property pnv_lpc_properties[] =3D {
> +    DEFINE_PROP_UINT32("chip-id", PnvLpcController, chip_id, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -494,6 +498,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
>      xdc->populate =3D pnv_lpc_populate;
> =20
>      dc->realize =3D pnv_lpc_realize;
> +    dc->props =3D pnv_lpc_properties;
>  }
> =20
>  static const TypeInfo pnv_lpc_info =3D {
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index ccf969af9448..c78ee4a98c62 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -67,6 +67,8 @@ typedef struct PnvLpcController {
> =20
>      /* PSI to generate interrupts */
>      PnvPsi *psi;
> +
> +    uint32_t chip_id;
>  } PnvLpcController;
> =20
>  qemu_irq *pnv_lpc_isa_irq_create(PnvLpcController *lpc, int chip_type,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CpBQqYjq/d0HQTAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7EImAAoJEGw4ysog2bOSCi0P/jV8xgyNdQcsKskpwsHQ9aPG
DxWgNU/pGx9jIwaUG8fSPCMerWwjGfy64Fx4fgestsHLDC5Vkm1w8QY7HYth8h8r
oRVLqOdCulxFBKzsfMLbEmnMWwVV+vUEzeDu7vNNOIFNq2yyFO1+jBF5kbPB8aRr
0zn8QnT49zpewJuYnUpca/+cUQdd+9+0papjJk/Kt0YgO3ZWMuHEpSOpFURnLsX6
jUrEXwOjVj8fipHBMkMUHJ9o+yLy3c4p1vDOhwQmHUgNJKxHe6EZNur49ttYeL85
ta5k5I64b6kRu9ukdA0DkZQSd2TK+a7Xpaakik/BXMwsnB/xLKZwI/YS848rN+aC
PukGE5cznEktAOxc2ipoVqi5knnGpiRdAbjEXjqJCSPjQc4hDhZSpGKMjJuXA1Av
iecOOJQJBn5g0USrFTRdelhIrHMUh/35AYodEIOHsHJxJbt60qz81ipmr6hHm+YY
pOHJ0nD888MmnAfebGiqdNB3snwE9HthVKUrezilmA7iVYnr5sWRnvPKD76FhA/V
q0+WLNLYdKupjyo7CyyKMvxHOhtKdssbUXXM05k+90p1G4sTxVtlLWxJgk0ea/9Y
JwFroexgbDkyxKI5TGxDcow19me5NkYB/nKNJoHUVNmnjyV9BoQ8VDLWLk7+WBjC
iBv/C/3KLMT1Gd//DiN0
=y1dK
-----END PGP SIGNATURE-----

--CpBQqYjq/d0HQTAP--
