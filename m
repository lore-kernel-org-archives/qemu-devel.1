Received: from eggs.gnu.org ([209.51.188.92]:34581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXo-0003L0-RW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kXn-0002Fk-1L
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:22:08 -0500
Date: Thu, 7 Mar 2019 15:18:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307041816.GL7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-19-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-19-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 18/27] ppc/pnv: add a LPC Controller model
 for POWER9
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


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:23AM +0100, C=E9dric Le Goater wrote:
> The LPC Controller on POWER9 is very similar to the one found on
> POWER8 but accesses are now done via on MMIOs, without the XSCOM and
> ECCB logic. The device tree is populated differently so we add a
> specific POWER9 routine for the purpose.
>=20
> SerIRQ routing is yet to be done.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv.h     |   4 +
>  include/hw/ppc/pnv_lpc.h |  10 ++
>  hw/ppc/pnv.c             |  29 +++++-
>  hw/ppc/pnv_lpc.c         | 200 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 57d0337219be..2d68aabc212f 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -85,6 +85,7 @@ typedef struct Pnv9Chip {
>      /*< public >*/
>      PnvXive      xive;
>      PnvPsi       psi;
> +    PnvLpcController lpc;
>  } Pnv9Chip;
> =20
>  typedef struct PnvChipClass {
> @@ -232,6 +233,9 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>  #define PNV9_XIVE_PC_SIZE            0x0000001000000000ull
>  #define PNV9_XIVE_PC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000601800000=
0000ull)
> =20
> +#define PNV9_LPCM_SIZE               0x0000000100000000ull
> +#define PNV9_LPCM_BASE(chip)         PNV9_CHIP_BASE(chip, 0x000603000000=
0000ull)
> +
>  #define PNV9_PSIHB_SIZE              0x0000000000100000ull
>  #define PNV9_PSIHB_BASE(chip)        PNV9_CHIP_BASE(chip, 0x000603020300=
0000ull)
> =20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 242baecdcb93..24fe23f0f63b 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -28,6 +28,10 @@
>  #define PNV8_LPC(obj) \
>      OBJECT_CHECK(PnvLpc, (obj), TYPE_PNV8_LPC)
> =20
> +#define TYPE_PNV9_LPC TYPE_PNV_LPC "-POWER9"
> +#define PNV9_LPC(obj) \
> +    OBJECT_CHECK(PnvLpc, (obj), TYPE_PNV9_LPC)
> +
>  typedef struct PnvLpcController {
>      DeviceState parent;
> =20
> @@ -86,6 +90,12 @@ typedef struct PnvLpcClass {
>      DeviceRealize parent_realize;
>  } PnvLpcClass;
> =20
> +/*
> + * Old compilers error on typdef forward declarations. Keep them happy.
> + */
> +struct PnvChip;
> +
>  ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
> +int pnv_dt_lpc(struct PnvChip *chip, void *fdt, int root_offset);
> =20
>  #endif /* _PPC_PNV_LPC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7176e1b68d0e..895be470af67 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -306,6 +306,8 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip=
, void *fdt)
>      if (chip->ram_size) {
>          pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
>      }
> +
> +    pnv_dt_lpc(chip, fdt, 0);
>  }
> =20
>  static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
> @@ -422,8 +424,14 @@ static int pnv_chip_isa_offset(PnvChip *chip, void *=
fdt)
>      char *name;
>      int offset;
> =20
> -    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> -                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
> +    if (pnv_chip_is_power9(chip)) {

Again explicit chip type checks aren't very pretty.  Better to
redirect through a method.  Or, better, call into the common ISA DT
code from chip specific code passing the offset, rather than calling
out again to get it.

> +        name =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
> +                               (uint64_t) PNV9_LPCM_BASE(chip));
> +    } else {
> +        name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
> +                               (uint64_t) PNV_XSCOM_BASE(chip),
> +                               PNV_XSCOM_LPC_BASE);
> +    }
>      offset =3D fdt_path_offset(fdt, name);
>      g_free(name);
>      return offset;
> @@ -559,7 +567,8 @@ static ISABus *pnv_chip_power8nvl_isa_create(PnvChip =
*chip, Error **errp)
> =20
>  static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
>  {
> -    return NULL;
> +    Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
> +    return pnv_lpc_isa_create(&chip9->lpc, false, errp);
>  }
> =20
>  static ISABus *pnv_isa_create(PnvChip *chip, Error **errp)
> @@ -954,6 +963,11 @@ static void pnv_chip_power9_instance_init(Object *ob=
j)
>                              TYPE_PNV9_PSI, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj,
>                                     &error_abort);
> +
> +    object_initialize_child(obj, "lpc",  &chip9->lpc, sizeof(chip9->lpc),
> +                            TYPE_PNV9_LPC, &error_abort, NULL);
> +    object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
> +                                   OBJECT(&chip9->psi), &error_abort);
>  }
> =20
>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> @@ -997,6 +1011,15 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
>      }
>      pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
>                              &chip9->psi.xscom_regs);
> +
> +    /* LPC */
> +    object_property_set_bool(OBJECT(&chip9->lpc), true, "realized", &loc=
al_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip=
),
> +                                &chip9->lpc.xscom_regs);
>  }
> =20
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 3c509a30a0af..6df694e0abc1 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -118,6 +118,100 @@ static int pnv_lpc_dt_xscom(PnvXScomInterface *dev,=
 void *fdt, int xscom_offset)
>      return 0;
>  }
> =20
> +/* POWER9 only */
> +int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset)
> +{
> +    const char compat[] =3D "ibm,power9-lpcm-opb\0simple-bus";
> +    const char lpc_compat[] =3D "ibm,power9-lpc\0ibm,lpc";
> +    char *name;
> +    int offset, lpcm_offset;
> +    uint64_t lpcm_addr =3D PNV9_LPCM_BASE(chip);
> +    uint32_t opb_ranges[8] =3D { 0,
> +                               cpu_to_be32(lpcm_addr >> 32),
> +                               cpu_to_be32((uint32_t)lpcm_addr),
> +                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
> +                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
> +                               cpu_to_be32(lpcm_addr >> 32),
> +                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
> +                               cpu_to_be32(PNV9_LPCM_SIZE / 2),
> +    };
> +    uint32_t opb_reg[4] =3D { cpu_to_be32(lpcm_addr >> 32),
> +                            cpu_to_be32((uint32_t)lpcm_addr),
> +                            cpu_to_be32(PNV9_LPCM_SIZE >> 32),
> +                            cpu_to_be32((uint32_t)PNV9_LPCM_SIZE),
> +    };
> +    uint32_t reg[2];
> +
> +    /*
> +     * OPB bus
> +     */
> +    name =3D g_strdup_printf("lpcm-opb@%"PRIx64, lpcm_addr);
> +    lpcm_offset =3D fdt_add_subnode(fdt, root_offset, name);
> +    _FDT(lpcm_offset);
> +    g_free(name);
> +
> +    _FDT((fdt_setprop(fdt, lpcm_offset, "reg", opb_reg, sizeof(opb_reg))=
));
> +    _FDT((fdt_setprop_cell(fdt, lpcm_offset, "#address-cells", 1)));
> +    _FDT((fdt_setprop_cell(fdt, lpcm_offset, "#size-cells", 1)));
> +    _FDT((fdt_setprop(fdt, lpcm_offset, "compatible", compat, sizeof(com=
pat))));
> +    _FDT((fdt_setprop_cell(fdt, lpcm_offset, "ibm,chip-id", chip->chip_i=
d)));
> +    _FDT((fdt_setprop(fdt, lpcm_offset, "ranges", opb_ranges,
> +                      sizeof(opb_ranges))));
> +
> +    /*
> +     * OPB Master registers
> +     */
> +    name =3D g_strdup_printf("opb-master@%x", LPC_OPB_REGS_OPB_ADDR);
> +    offset =3D fdt_add_subnode(fdt, lpcm_offset, name);
> +    _FDT(offset);
> +    g_free(name);
> +
> +    reg[0] =3D cpu_to_be32(LPC_OPB_REGS_OPB_ADDR);
> +    reg[1] =3D cpu_to_be32(LPC_OPB_REGS_OPB_SIZE);
> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> +    _FDT((fdt_setprop_string(fdt, offset, "compatible",
> +                             "ibm,power9-lpcm-opb-master")));
> +
> +    /*
> +     * OPB arbitrer registers
> +     */
> +    name =3D g_strdup_printf("opb-arbitrer@%x", LPC_OPB_REGS_OPBA_ADDR);
> +    offset =3D fdt_add_subnode(fdt, lpcm_offset, name);
> +    _FDT(offset);
> +    g_free(name);
> +
> +    reg[0] =3D cpu_to_be32(LPC_OPB_REGS_OPBA_ADDR);
> +    reg[1] =3D cpu_to_be32(LPC_OPB_REGS_OPBA_SIZE);
> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> +    _FDT((fdt_setprop_string(fdt, offset, "compatible",
> +                             "ibm,power9-lpcm-opb-arbiter")));
> +
> +    /*
> +     * LPC Host Controller registers
> +     */
> +    name =3D g_strdup_printf("lpc-controller@%x", LPC_HC_REGS_OPB_ADDR);
> +    offset =3D fdt_add_subnode(fdt, lpcm_offset, name);
> +    _FDT(offset);
> +    g_free(name);
> +
> +    reg[0] =3D cpu_to_be32(LPC_HC_REGS_OPB_ADDR);
> +    reg[1] =3D cpu_to_be32(LPC_HC_REGS_OPB_SIZE);
> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> +    _FDT((fdt_setprop_string(fdt, offset, "compatible",
> +                             "ibm,power9-lpc-controller")));
> +
> +    name =3D g_strdup_printf("lpc@0");
> +    offset =3D fdt_add_subnode(fdt, lpcm_offset, name);
> +    _FDT(offset);
> +    g_free(name);
> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
> +    _FDT((fdt_setprop(fdt, offset, "compatible", lpc_compat,
> +                      sizeof(lpc_compat))));
> +
> +    return 0;
> +}
> +
>  /*
>   * These read/write handlers of the OPB address space should be common
>   * with the P9 LPC Controller which uses direct MMIOs.
> @@ -242,6 +336,74 @@ static const MemoryRegionOps pnv_lpc_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> +static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> +    uint64_t val =3D 0;
> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> +    MemTxResult result;
> +
> +    switch (size) {
> +    case 4:
> +        val =3D address_space_ldl(&lpc->opb_as, opb_addr, MEMTXATTRS_UNS=
PECIFIED,
> +                                &result);
> +        break;
> +    case 1:
> +        val =3D address_space_ldub(&lpc->opb_as, opb_addr, MEMTXATTRS_UN=
SPECIFIED,
> +                                 &result);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> +        return 0;
> +    }
> +
> +    if (result !=3D MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB read failed at @0x%"
> +                      HWADDR_PRIx "\n", addr);
> +    }
> +
> +    return val;

Couldn't you just map the relevant portion of the OPB AS into the MMIO
AS, rather than having to forward the IOs with explicit read/write
functions?

> +}
> +
> +static void pnv_lpc_mmio_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    PnvLpcController *lpc =3D PNV_LPC(opaque);
> +    uint32_t opb_addr =3D addr & ECCB_CTL_ADDR_MASK;
> +    MemTxResult result;
> +
> +    switch (size) {
> +    case 4:
> +        address_space_stl(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNSPEC=
IFIED,
> +                          &result);
> +         break;
> +    case 1:
> +        address_space_stb(&lpc->opb_as, opb_addr, val, MEMTXATTRS_UNSPEC=
IFIED,
> +                          &result);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> +                      HWADDR_PRIx " invalid size %d\n", addr, size);
> +        return;
> +    }
> +
> +    if (result !=3D MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "OPB write failed at @0x%"
> +                      HWADDR_PRIx "\n", addr);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_lpc_mmio_ops =3D {
> +    .read =3D pnv_lpc_mmio_read,
> +    .write =3D pnv_lpc_mmio_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
>  static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
>  {
>      bool lpc_to_opb_irq =3D false;
> @@ -465,6 +627,43 @@ static const TypeInfo pnv_lpc_power8_info =3D {
>      }
>  };
> =20
> +static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
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
> +    /* P9 uses a MMIO region */
> +    memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_o=
ps,
> +                          lpc, "lpcm", PNV9_LPCM_SIZE);
> +}
> +
> +static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PnvLpcClass *plc =3D PNV_LPC_CLASS(klass);
> +
> +    dc->desc =3D "PowerNV LPC Controller POWER9";
> +
> +    plc->psi_irq =3D PSIHB9_IRQ_LPCHC;
> +
> +    device_class_set_parent_realize(dc, pnv_lpc_power9_realize,
> +                                    &plc->parent_realize);
> +}
> +
> +static const TypeInfo pnv_lpc_power9_info =3D {
> +    .name          =3D TYPE_PNV9_LPC,
> +    .parent        =3D TYPE_PNV_LPC,
> +    .instance_size =3D sizeof(PnvLpcController),
> +    .class_init    =3D pnv_lpc_power9_class_init,
> +};
> +
>  static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>  {
>      PnvLpcController *lpc =3D PNV_LPC(dev);
> @@ -540,6 +739,7 @@ static void pnv_lpc_register_types(void)
>  {
>      type_register_static(&pnv_lpc_info);
>      type_register_static(&pnv_lpc_power8_info);
> +    type_register_static(&pnv_lpc_power9_info);
>  }
> =20
>  type_init(pnv_lpc_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAm4gACgkQbDjKyiDZ
s5IOGA/8Cw96k/rDORtmP9Okg1HwxEYxbH50AavoGPTmMZoF3SvUFgryC/1UipbC
k9LOAquP2lZQZZJC4ffsU2OyKC90IQw96hoyv+SQhl2DIErD20WG97ze4x+5HIpv
6Mk6YxC6CXwoKdR+PZ68k+JQK4qZSAEDQ+jNzz4N0QsWdK/kEZC8El4gCGlDCGyh
S3y8VySGnFPN5MOfEG8O94ngsZvcWB8+OTesT46xTokuZ2ie5Zf/I7HoSnyqRMW9
aCG+d6q5PN2GbmwX3TBA4FZtILObJ166thO/Ox/3Mg29NIYLu/8rkt7+5AKdde3N
/5H1lhen3rusJCXVPI7aVidbQTI3cq/a+TtN9RaEmmxnlX73/eusHHTw2fymB+0V
Nl/hPS44a8oKBDwlFQ6NIi0amd9c10DeC1p2MBQnj90Fv+T2DRKqfWdVnzpeyklb
wTGslkpjiSkdVC5EtzuZSGKY3kqlnLgXGfokBzkizDPwn9OB+/C4vfOJNnn94U7F
7kYuIpynNARhL7bBiMjZEq04+CmfOJHZvZ5BYS9gH2ZqPAuupsOVAOsNNwCAwoiH
bUBjHdDBFKQ0XFoHb+Y4d6XrHM2m8Z4JAznP8HSBl9hAGOgtTRT9/h3Gu/cGJCUF
T1Ku7nKs50o0o7E06481DiyxvKZljd039twE/i4bbwziaN1UTBM=
=3rdl
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--
