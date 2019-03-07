Received: from eggs.gnu.org ([209.51.188.92]:34577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXo-0003Ky-HI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXn-0002GR-5z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:08 -0500
Date: Thu, 7 Mar 2019 15:12:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307041232.GK7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-18-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-18-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/27] ppc/pnv: add a LPC Controller model
 class
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


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:22AM +0100, C=E9dric Le Goater wrote:
> It will ease the introduction of the LPC Controller model for POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/pnv_lpc.h | 16 ++++++++
>  hw/ppc/pnv.c             |  2 +-
>  hw/ppc/pnv_lpc.c         | 85 ++++++++++++++++++++++++++++------------
>  3 files changed, 78 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index d657489b07ce..242baecdcb93 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -24,6 +24,9 @@
>  #define TYPE_PNV_LPC "pnv-lpc"
>  #define PNV_LPC(obj) \
>       OBJECT_CHECK(PnvLpcController, (obj), TYPE_PNV_LPC)
> +#define TYPE_PNV8_LPC TYPE_PNV_LPC "-POWER8"
> +#define PNV8_LPC(obj) \
> +    OBJECT_CHECK(PnvLpc, (obj), TYPE_PNV8_LPC)
> =20
>  typedef struct PnvLpcController {
>      DeviceState parent;
> @@ -70,6 +73,19 @@ typedef struct PnvLpcController {
>      PnvPsi *psi;
>  } PnvLpcController;
> =20
> +#define PNV_LPC_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PnvLpcClass, (klass), TYPE_PNV_LPC)
> +#define PNV_LPC_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PnvLpcClass, (obj), TYPE_PNV_LPC)
> +
> +typedef struct PnvLpcClass {
> +    DeviceClass parent_class;
> +
> +    int psi_irq;
> +
> +    DeviceRealize parent_realize;
> +} PnvLpcClass;
> +
>  ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
> =20
>  #endif /* _PPC_PNV_LPC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 4375f97c7135..7176e1b68d0e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -794,7 +794,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>                                     OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
>      object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
> -                            TYPE_PNV_LPC, &error_abort, NULL);
> +                            TYPE_PNV8_LPC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
> =20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 547be609cafe..3c509a30a0af 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -245,6 +245,7 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
>  static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>  {
>      bool lpc_to_opb_irq =3D false;
> +    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(lpc);
> =20
>      /* Update LPC controller to OPB line */
>      if (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_EN) {
> @@ -267,7 +268,7 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>      lpc->opb_irq_stat |=3D lpc->opb_irq_input & lpc->opb_irq_mask;
> =20
>      /* Reflect the interrupt */
> -    pnv_psi_irq_set(lpc->psi, PSIHB_IRQ_LPC_I2C, lpc->opb_irq_stat !=3D =
0);
> +    pnv_psi_irq_set(lpc->psi, plc->psi_irq, lpc->opb_irq_stat !=3D 0);
>  }
> =20
>  static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
> @@ -419,11 +420,65 @@ static const MemoryRegionOps opb_master_ops =3D {
>      },
>  };
> =20
> +static void pnv_lpc_power8_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> +    PnvLpcClass *plc =3D PNV_LPC_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    plc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    /* P8 uses a XSCOM region for LPC registers */
> +    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(lpc),
> +                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
> +                          PNV_XSCOM_LPC_SIZE);
> +}
> +
> +static void pnv_lpc_power8_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
> +    PnvLpcClass *plc =3D PNV_LPC_CLASS(klass);
> +
> +    dc->desc =3D "PowerNV LPC Controller POWER8";
> +
> +    xdc->dt_xscom =3D pnv_lpc_dt_xscom;
> +
> +    plc->psi_irq =3D PSIHB_IRQ_LPC_I2C;
> +
> +    device_class_set_parent_realize(dc, pnv_lpc_power8_realize,
> +                                    &plc->parent_realize);
> +}
> +
> +static const TypeInfo pnv_lpc_power8_info =3D {
> +    .name          =3D TYPE_PNV8_LPC,
> +    .parent        =3D TYPE_PNV_LPC,
> +    .instance_size =3D sizeof(PnvLpcController),
> +    .class_init    =3D pnv_lpc_power8_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
>  static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>  {
>      PnvLpcController *lpc =3D PNV_LPC(dev);
>      Object *obj;
> -    Error *error =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
> +    if (!obj) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'psi' not found: ");
> +        return;
> +    }
> +    /* The LPC controller needs PSI to generate interrupts  */
> +    lpc->psi =3D PNV_PSI(obj);
> =20
>      /* Reg inits */
>      lpc->lpc_hc_fw_rd_acc_size =3D LPC_HC_FW_RD_4B;
> @@ -463,46 +518,28 @@ static void pnv_lpc_realize(DeviceState *dev, Error=
 **errp)
>                            "lpc-hc", LPC_HC_REGS_OPB_SIZE);
>      memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>                                  &lpc->lpc_hc_regs);
> -
> -    /* XScom region for LPC registers */
> -    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
> -                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
> -                          PNV_XSCOM_LPC_SIZE);
> -
> -    /* get PSI object from chip */
> -    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
> -    if (!obj) {
> -        error_setg(errp, "%s: required link 'psi' not found: %s",
> -                   __func__, error_get_pretty(error));
> -        return;
> -    }
> -    lpc->psi =3D PNV_PSI(obj);
>  }
> =20
>  static void pnv_lpc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
> -
> -    xdc->dt_xscom =3D pnv_lpc_dt_xscom;
> =20
>      dc->realize =3D pnv_lpc_realize;
> +    dc->desc =3D "PowerNV LPC Controller";
>  }
> =20
>  static const TypeInfo pnv_lpc_info =3D {
>      .name          =3D TYPE_PNV_LPC,
>      .parent        =3D TYPE_DEVICE,
> -    .instance_size =3D sizeof(PnvLpcController),
>      .class_init    =3D pnv_lpc_class_init,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_PNV_XSCOM_INTERFACE },
> -        { }
> -    }
> +    .class_size    =3D sizeof(PnvLpcClass),
> +    .abstract      =3D true,
>  };
> =20
>  static void pnv_lpc_register_types(void)
>  {
>      type_register_static(&pnv_lpc_info);
> +    type_register_static(&pnv_lpc_power8_info);
>  }
> =20
>  type_init(pnv_lpc_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAmjAACgkQbDjKyiDZ
s5KC3Q/8CaXce2Dpqr24oYw89uTx43zNJubtbk8NizmZQRFiDIaRwsV8lQhnI3n2
yPM3XAdPXNA0T5UVhYsfOr4h4T5LZqsPumxNOuR9s5aJC2qALeBYh7qN4p9v//js
qSaBuJUNCTkBCUehBoaY63jTSfCjKBO7LO5z5So0UGPm+tM+mn4hcL4rnJqlLefK
apOW1Xm1qM3MzJFJnDJXnUXCGIY7PBY3d2XgbsxMUbt/qY22OTrO9poyEHrVlYO+
dgvLtwbJCFbdeifNOKP9sGnuiDemL2HZbfD+e+QP46z3I/3qYar8dQ6ZVQTbClGF
CcimrIW+3R/isN3sKZ2QBlrL/g56JTJPFVmZjOZEXolePRiUgXOnubOoGEdHo5Fy
VD5YK+HG+Iu8YsLOKROF6QjhEbK4z6Z3pkXCLRWOG71z6J+wHcu5fYKHjmBLasGr
u4M9s0KR5ZuiyvPAkp502P7EVTOHS7EjoyYARJmxiKbdojhAxh0ZXP1NZ0qD7Uxc
7dWs+zOLT2/lrBEGn6d10tucSohJp3bMhYG9gqqgm0FNtrN99ElrB6c48AsF0DuJ
6DPgUZ//3lkzehF6GLQ3ZmK8wKDmAm2q+z2U205xxmfb0+PmzMrdLmL8q/fC1e8/
sVhRvAozmoh912LvobDEOB3BggCwSaScPuwUk5R+OxZqsNrot/U=
=QVQk
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
