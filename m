Received: from eggs.gnu.org ([209.51.188.92]:34620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXq-0003LB-Sx
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXp-0002Lk-4V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:10 -0500
Date: Thu, 7 Mar 2019 15:05:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307040519.GH7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 14/27] ppc/pnv: add a PSI bridge model class
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


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:19AM +0100, C=E9dric Le Goater wrote:
> It will ease the introduction of the PSI bridge model for POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/pnv_psi.h | 21 +++++++++++-
>  hw/ppc/pnv.c             |  2 +-
>  hw/ppc/pnv_psi.c         | 72 ++++++++++++++++++++++++++++------------
>  3 files changed, 72 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index 64ac73512e81..585a41cd19b6 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -25,6 +25,9 @@
>  #define TYPE_PNV_PSI "pnv-psi"
>  #define PNV_PSI(obj) \
>       OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI)
> +#define TYPE_PNV8_PSI TYPE_PNV_PSI "-POWER8"
> +#define PNV8_PSI(obj) \
> +    OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV8_PSI)
> =20
>  #define PSIHB_XSCOM_MAX         0x20
> =20
> @@ -48,6 +51,22 @@ typedef struct PnvPsi {
>      MemoryRegion xscom_regs;
>  } PnvPsi;
> =20
> +#define PNV_PSI_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PnvPsiClass, (klass), TYPE_PNV_PSI)
> +#define PNV_PSI_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PnvPsiClass, (obj), TYPE_PNV_PSI)
> +
> +typedef struct PnvPsiClass {
> +    SysBusDeviceClass parent_class;
> +
> +    int chip_type;
> +    uint32_t xscom_pcba;
> +    uint32_t xscom_size;
> +    uint64_t bar_mask;
> +
> +    void (*irq_set)(PnvPsi *psi, int, bool state);
> +} PnvPsiClass;
> +
>  /* The PSI and FSP interrupts are muxed on the same IRQ number */
>  typedef enum PnvPsiIrq {
>      PSIHB_IRQ_PSI, /* internal use only */
> @@ -61,6 +80,6 @@ typedef enum PnvPsiIrq {
> =20
>  #define PSI_NUM_INTERRUPTS 6
> =20
> -extern void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state);
> +void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
> =20
>  #endif /* _PPC_PNV_PSI_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7660eaa22cf9..67d40dc3eebc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -788,7 +788,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> =20
>      object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
> -                            TYPE_PNV_PSI, &error_abort, NULL);
> +                            TYPE_PNV8_PSI, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->psi), "xics",
>                                     OBJECT(qdev_get_machine()), &error_ab=
ort);
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index e61861bfd3c6..e56b455a61b1 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -118,10 +118,11 @@
> =20
>  static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>  {
> +    PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(psi);
>      MemoryRegion *sysmem =3D get_system_memory();
>      uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
> =20
> -    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (PSIHB_BAR_MASK | PSIHB_BAR_EN);
> +    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (ppc->bar_mask | PSIHB_BAR_EN);
> =20
>      /* Update MR, always remove it first */
>      if (old & PSIHB_BAR_EN) {
> @@ -130,7 +131,7 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
> =20
>      /* Then add it back if needed */
>      if (bar & PSIHB_BAR_EN) {
> -        uint64_t addr =3D bar & PSIHB_BAR_MASK;
> +        uint64_t addr =3D bar & ppc->bar_mask;
>          memory_region_add_subregion(sysmem, addr, &psi->regs_mr);
>      }
>  }
> @@ -207,7 +208,12 @@ static const uint64_t stat_bits[] =3D {
>      [PSIHB_IRQ_EXTERNAL]  =3D PSIHB_IRQ_STAT_EXT,
>  };
> =20
> -void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
> +void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state)
> +{
> +    PNV_PSI_GET_CLASS(psi)->irq_set(psi, irq, state);
> +}
> +
> +static void pnv_psi_power8_irq_set(PnvPsi *psi, int irq, bool state)
>  {
>      uint32_t xivr_reg;
>      uint32_t stat_reg;
> @@ -451,9 +457,9 @@ static void pnv_psi_reset(void *dev)
>      psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
>  }
> =20
> -static void pnv_psi_init(Object *obj)
> +static void pnv_psi_power8_instance_init(Object *obj)
>  {
> -    PnvPsi *psi =3D PNV_PSI(obj);
> +    PnvPsi *psi =3D PNV8_PSI(obj);
> =20
>      object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics),
>                              TYPE_ICS_SIMPLE, &error_abort, NULL);
> @@ -468,9 +474,9 @@ static const uint8_t irq_to_xivr[] =3D {
>      PSIHB_XSCOM_XIVR_EXT,
>  };
> =20
> -static void pnv_psi_realize(DeviceState *dev, Error **errp)
> +static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
>  {
> -    PnvPsi *psi =3D PNV_PSI(dev);
> +    PnvPsi *psi =3D PNV8_PSI(dev);
>      ICSState *ics =3D &psi->ics;
>      Object *obj;
>      Error *err =3D NULL;
> @@ -524,28 +530,28 @@ static void pnv_psi_realize(DeviceState *dev, Error=
 **errp)
>      qemu_register_reset(pnv_psi_reset, dev);
>  }
> =20
> +static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
> +
>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {
> -    const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
> +    PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(dev);
>      char *name;
>      int offset;
> -    uint32_t lpc_pcba =3D PNV_XSCOM_PSIHB_BASE;
>      uint32_t reg[] =3D {
> -        cpu_to_be32(lpc_pcba),
> -        cpu_to_be32(PNV_XSCOM_PSIHB_SIZE)
> +        cpu_to_be32(ppc->xscom_pcba),
> +        cpu_to_be32(ppc->xscom_size)
>      };
> =20
> -    name =3D g_strdup_printf("psihb@%x", lpc_pcba);
> +    name =3D g_strdup_printf("psihb@%x", ppc->xscom_pcba);
>      offset =3D fdt_add_subnode(fdt, xscom_offset, name);
>      _FDT(offset);
>      g_free(name);
> =20
> -    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> -
> -    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
> -    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
> -                      sizeof(compat))));
> +    _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
> +    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
> +    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
> +                     sizeof(compat_p8)));
>      return 0;
>  }
> =20
> @@ -555,6 +561,28 @@ static Property pnv_psi_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
> +
> +    dc->desc    =3D "PowerNV PSI Controller POWER8";
> +    dc->realize =3D pnv_psi_power8_realize;
> +
> +    ppc->chip_type =3D  PNV_CHIP_POWER8;
> +    ppc->xscom_pcba =3D PNV_XSCOM_PSIHB_BASE;
> +    ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
> +    ppc->bar_mask   =3D PSIHB_BAR_MASK;
> +    ppc->irq_set    =3D pnv_psi_power8_irq_set;
> +}
> +
> +static const TypeInfo pnv_psi_power8_info =3D {
> +    .name          =3D TYPE_PNV8_PSI,
> +    .parent        =3D TYPE_PNV_PSI,
> +    .instance_init =3D pnv_psi_power8_instance_init,
> +    .class_init    =3D pnv_psi_power8_class_init,
> +};
> +
>  static void pnv_psi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -562,7 +590,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
> =20
>      xdc->dt_xscom =3D pnv_psi_dt_xscom;
> =20
> -    dc->realize =3D pnv_psi_realize;
> +    dc->desc =3D "PowerNV PSI Controller";
>      dc->props =3D pnv_psi_properties;
>  }
> =20
> @@ -570,8 +598,9 @@ static const TypeInfo pnv_psi_info =3D {
>      .name          =3D TYPE_PNV_PSI,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(PnvPsi),
> -    .instance_init =3D pnv_psi_init,
>      .class_init    =3D pnv_psi_class_init,
> +    .class_size    =3D sizeof(PnvPsiClass),
> +    .abstract      =3D true,
>      .interfaces    =3D (InterfaceInfo[]) {
>          { TYPE_PNV_XSCOM_INTERFACE },
>          { }
> @@ -581,6 +610,7 @@ static const TypeInfo pnv_psi_info =3D {
>  static void pnv_psi_register_types(void)
>  {
>      type_register_static(&pnv_psi_info);
> +    type_register_static(&pnv_psi_power8_info);
>  }
> =20
> -type_init(pnv_psi_register_types)
> +type_init(pnv_psi_register_types);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAmH8ACgkQbDjKyiDZ
s5JB4RAAxuRaZX9+mRSeFbN/t8IB2QWqS5GdNhytlvmFYcpP9Ntpweiyyrq2C2At
ohCB4FWfaNizxFodkrpHEOhIxPDSLzmOti5umUmzfLoRzpsPD1RdJNVNxCKZhFvW
gXUSbJ0Ksdo51wn42EBBKuLU3umG3HDME228NYx40zs9yrH57vb1ql1+ep8SNPvG
H0gCOp2o02eo8PvKG6Ze9a04mfIQyYDm+30liTPwIfOH377d43IePWUcM0H3UdGZ
GF0RhVVJZKde/O4PCK/D3B34ql9hsOc5rjSnBrfszYKjBmnyYUxOZir9pqWnHMiG
pZG66zr5w9t+iF7IVm2VNzIEbFgB7NBVbTWo2B/IaTJJbDskn/nFwuMbOCLEuvkM
BankOi12uKtnuqrx16332JOLqT1TN2ibNpkxVIp71RNLwih/zRSY49xbN3tz6ync
8LCL9cHYUZA3Tuhac9DjlNtqQ4z7shgWc1gaTGqqY/Pg1o6ArpiyeffYLAPTOfb0
B1qvgN6pMhOpGePZ0Hz/RGZW12SFFsBXJC/RKhnOW8x5Oudssnm4PxsmA6M+4I46
UmZiu4Lsrj7Pt/IWGkFjEpi3crfo17eEc2hV7gbCrULzTbCf2HPJn3glrl6ecPzf
Bool64emr7N9Nk68H7+vmJRXdmVH367Onrh9sYj6zo/Tc9L1Co0=
=QpBk
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
