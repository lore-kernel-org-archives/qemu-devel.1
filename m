Received: from eggs.gnu.org ([2001:4830:134:3::10]:51507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfES-0007Eo-UG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfEQ-0004l9-0h
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:17:00 -0400
Date: Fri, 15 Jun 2018 13:16:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615031648.GO4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 6/6] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
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


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:43PM +0200, C=E9dric Le Goater wrote:
> This is a major reshuffle of the PowerNV machine and chip models to
> introduce a machine type per processor. It is quite noisy but it
> doesn't change much the code flow.
>=20
> It introduces a base PnvChip class from which the specific processor
> chip classes, Pnv8Chip and Pnv9Chip, inherit. Each of them needs to
> define an init and a realize routine which will create the controllers
> of the target processor.
>=20
> For the moment, the base PnvChip class handles the XSCOM bus and the
> cores but the core creation will surely move to the specific processor
> chip classes because of the new XIVE interrupt controller in Power9.
> The base class also has pointers on the main controllers of the chip
> which are common to all processors : PSI, LPC, OCC. These controllers
> have some subtil differences in each processor version, but, globally,
> they are very similar and provide the same feature. This is how we
> have a console for instance.
>=20
> >From there, we introduce two different machines : "powernv8" and
> "powernv9" but, a part from the XICSFabric interface, this is not
> strictly needed as it is the cpu type which determines the PnvChip
> class. Something to discuss.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv.h |  28 ++++-
>  hw/ppc/pnv.c         | 322 +++++++++++++++++++++++++++++++++------------=
------
>  hw/ppc/pnv_lpc.c     |   2 +-
>  3 files changed, 236 insertions(+), 116 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index e934e84f555e..4942add9458a 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -57,12 +57,37 @@ typedef struct PnvChip {
>      MemoryRegion xscom_mmio;
>      MemoryRegion xscom;
>      AddressSpace xscom_as;
> +
> +    /* Base class controllers */
> +    PnvLpcController *lpc;
> +    PnvPsi       *psi;
> +    PnvOCC       *occ;

Having pointers here to full structures in the subclass seems
bizarrely pointless.

> +} PnvChip;
> +
> +#define TYPE_PNV8_CHIP "pnv8-chip"
> +#define PNV8_CHIP(obj) OBJECT_CHECK(Pnv8Chip, (obj), TYPE_PNV8_CHIP)
> +
> +typedef struct Pnv8Chip {
> +    /*< private >*/
> +    PnvChip      parent_obj;
> +
> +    /*< public >*/
>      MemoryRegion icp_mmio;
> =20
>      PnvLpcController lpc;
>      PnvPsi       psi;
>      PnvOCC       occ;
> -} PnvChip;
> +} Pnv8Chip;
> +
> +#define TYPE_PNV9_CHIP "pnv9-chip"
> +#define PNV9_CHIP(obj) OBJECT_CHECK(Pnv9Chip, (obj), TYPE_PNV9_CHIP)
> +
> +typedef struct Pnv9Chip {
> +    /*< private >*/
> +    PnvChip      parent_obj;
> +
> +    /*< public >*/
> +} Pnv9Chip;
> =20
>  typedef struct PnvChipClass {
>      /*< private >*/
> @@ -75,6 +100,7 @@ typedef struct PnvChipClass {
> =20
>      hwaddr       xscom_base;
> =20
> +    void (*realize)(PnvChip *chip, Error **errp);
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>      Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
>  } PnvChipClass;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7d99366daf90..60b56c7fe07b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -267,7 +267,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint=
32_t pir,
> =20
>  static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
>  {
> -    return fdt_path_offset(fdt, chip->lpc.isa_bus_name);
> +    return fdt_path_offset(fdt, chip->lpc->isa_bus_name);
>  }
> =20
>  static void pnv_dt_chip(PnvChip *chip, void *fdt)
> @@ -516,7 +516,7 @@ static ISABus *pnv_isa_create(PnvChip *chip)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> =20
> -    return pnv_lpc_isa_create(&chip->lpc, pcc->chip_type);
> +    return pnv_lpc_isa_create(chip->lpc, pcc->chip_type);
>  }
> =20
>  static void pnv_init(MachineState *machine)
> @@ -695,6 +695,106 @@ static Object *pnv_chip_power9_intc_create(PnvChip =
*chip, Object *child,
>   */
>  #define POWER9_CORE_MASK   (0xffffffffffffffull)
> =20
> +static void pnv_chip_power8_initfn(Object *obj)

I'm trying to standardize on *_instance_init() for instance_init functions.

> +{
> +    Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> +    PnvChip *chip =3D PNV_CHIP(obj);
> +
> +    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
> +    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);

Especially when you *also* have these child link properties which
would let you get to the sub-objects from the base ckass,

> +    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
> +    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
> +    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
> +                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
> +
> +    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
> +    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
> +    object_property_add_const_link(OBJECT(&chip8->occ), "psi",
> +                                   OBJECT(&chip8->psi), &error_abort);
> +
> +    /*
> +     * The LPC controller needs a few things from the chip : to know
> +     * if it's primary and PSI to generate interrupts
> +     */
> +    object_property_add_const_link(OBJECT(&chip8->lpc), "chip",
> +                                   OBJECT(chip8), &error_abort);
> +
> +    /* Intialize the controllers in the base class also */
> +    chip->lpc =3D &chip8->lpc;
> +    chip->psi =3D &chip8->psi;
> +    chip->occ =3D &chip8->occ;
> +}
> +
> +static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
> + {
> +    PnvChip *chip =3D PNV_CHIP(chip8);
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    const char *typename =3D pnv_chip_core_typename(chip);
> +    size_t typesize =3D object_type_get_instance_size(typename);
> +    int i, j;
> +    char *name;
> +    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> +
> +    name =3D g_strdup_printf("icp-%x", chip->chip_id);
> +    memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
> +    g_free(name);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> +
> +    /* Map the ICP registers for each thread */
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> +        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
> +
> +        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
> +            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
> +            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
> +
> +            memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
> +                                        &icp->mmio);
> +        }
> +    }
> +}
> +
> +static void pnv_chip_power8_realize(PnvChip *chip, Error **errp)
> + {
> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
> +    Error *error =3D NULL;
> +
> +    /* Create LPC controller */
> +    object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
> +                             &error_fatal);
> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
> +
> +    /* Interrupt Management Area. This is the memory region holding
> +     * all the Interrupt Control Presenter (ICP) registers */
> +    pnv_chip_icp_realize(chip8, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    /* Processor Service Interface (PSI) Host Bridge */
> +    object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
> +                            "bar", &error_fatal);
> +    object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &err=
or);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip8->psi.xsco=
m_regs);
> +
> +    /* Create the simplified OCC model */
> +    object_property_set_bool(OBJECT(&chip8->occ), true, "realized", &err=
or);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
> +}
> +
>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -719,6 +819,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->realize  =3D pnv_chip_power8_realize;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> @@ -733,10 +834,20 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
> +    k->realize  =3D pnv_chip_power8_realize;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> =20
> +static void pnv_chip_power9_initfn(Object *obj)
> +{
> +}
> +
> +static void pnv_chip_power9_realize(PnvChip *chip, Error **errp)
> +{
> +
> +}
> +
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -747,6 +858,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->cores_mask =3D POWER9_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p9;
>      k->intc_create =3D pnv_chip_power9_intc_create;
> +    k->realize  =3D pnv_chip_power9_realize;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> @@ -781,62 +893,9 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Er=
ror **errp)
>      }
>  }
> =20
> -static void pnv_chip_init(Object *obj)
> +static void pnv_chip_initfn(Object *obj)
>  {
> -    PnvChip *chip =3D PNV_CHIP(obj);
> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -
> -    chip->xscom_base =3D pcc->xscom_base;
> -
> -    object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
> -    object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
> -
> -    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
> -    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
> -    object_property_add_const_link(OBJECT(&chip->psi), "xics",
> -                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
> -
> -    object_initialize(&chip->occ, sizeof(chip->occ), TYPE_PNV_OCC);
> -    object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
> -    object_property_add_const_link(OBJECT(&chip->occ), "psi",
> -                                   OBJECT(&chip->psi), &error_abort);
> -
> -    /*
> -     * The LPC controller needs a few things from the chip : to know
> -     * if it's primary and PSI to generate interrupts
> -     */
> -    object_property_add_const_link(OBJECT(&chip->lpc), "chip",
> -                                   OBJECT(chip), &error_abort);
> -}
> -
> -static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> -{
> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> -    const char *typename =3D pnv_chip_core_typename(chip);
> -    size_t typesize =3D object_type_get_instance_size(typename);
> -    int i, j;
> -    char *name;
> -    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> -
> -    name =3D g_strdup_printf("icp-%x", chip->chip_id);
> -    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE=
);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
> -    g_free(name);
> -
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> -
> -    /* Map the ICP registers for each thread */
> -    for (i =3D 0; i < chip->nr_cores; i++) {
> -        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> -        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
> -
> -        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
> -            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
> -            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
> -
> -            memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp=
->mmio);
> -        }
> -    }
> +    PNV_CHIP(obj)->xscom_base =3D PNV_CHIP_GET_CLASS(obj)->xscom_base;
>  }
> =20
>  static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
> @@ -904,6 +963,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
>  {
>      PnvChip *chip =3D PNV_CHIP(dev);
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>      Error *error =3D NULL;
> =20
>      /* XSCOM bridge */
> @@ -921,36 +981,7 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
>          return;
>      }
> =20
> -    /* Create LPC controller */
> -    object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
> -                             &error_fatal);
> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
> -
> -    /* Interrupt Management Area. This is the memory region holding
> -     * all the Interrupt Control Presenter (ICP) registers */
> -    pnv_chip_icp_realize(chip, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -
> -    /* Processor Service Interface (PSI) Host Bridge */
> -    object_property_set_int(OBJECT(&chip->psi), PNV_PSIHB_BASE(chip),
> -                            "bar", &error_fatal);
> -    object_property_set_bool(OBJECT(&chip->psi), true, "realized", &erro=
r);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xscom=
_regs);
> -
> -    /* Create the simplified OCC model */
> -    object_property_set_bool(OBJECT(&chip->occ), true, "realized", &erro=
r);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xscom_r=
egs);
> +    pcc->realize(chip, errp);
>  }
> =20
>  static Property pnv_chip_properties[] =3D {
> @@ -972,26 +1003,29 @@ static void pnv_chip_class_init(ObjectClass *klass=
, void *data)
>      dc->desc =3D "PowerNV Chip";
>  }
> =20
> -static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> +static ICSState *pnv8_ics_get(XICSFabric *xi, int irq)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(xi);
>      int i;
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        if (ics_valid_irq(&pnv->chips[i]->psi.ics, irq)) {
> -            return &pnv->chips[i]->psi.ics;
> +        Pnv8Chip *chip =3D PNV8_CHIP(pnv->chips[i]);
> +
> +        if (ics_valid_irq(&chip->psi.ics, irq)) {
> +            return &chip->psi.ics;
>          }
>      }
>      return NULL;
>  }
> =20
> -static void pnv_ics_resend(XICSFabric *xi)
> +static void pnv8_ics_resend(XICSFabric *xi)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(xi);
>      int i;
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        ics_resend(&pnv->chips[i]->psi.ics);
> +        Pnv8Chip *chip =3D PNV8_CHIP(pnv->chips[i]);
> +        ics_resend(&chip->psi.ics);
>      }
>  }
> =20
> @@ -1011,15 +1045,14 @@ static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
>      return NULL;
>  }
> =20
> -static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
> +static ICPState *pnv8_icp_get(XICSFabric *xi, int pir)
>  {
>      PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> =20
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
> -static void pnv_pic_print_info(InterruptStatsProvider *obj,
> -                               Monitor *mon)
> +static void pnv8_pic_print_info(InterruptStatsProvider *obj, Monitor *mo=
n)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
>      int i;
> @@ -1032,7 +1065,8 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
>      }
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
> +        Pnv8Chip *chip =3D PNV8_CHIP(pnv->chips[i]);
> +        ics_pic_print_info(&chip->psi.ics, mon);
>      }
>  }
> =20
> @@ -1086,8 +1120,6 @@ static void pnv_machine_class_props_init(ObjectClas=
s *oc)
>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> -    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> -    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D pnv_init;
> @@ -1099,48 +1131,110 @@ static void pnv_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      mc->default_ram_size =3D 1 * G_BYTE;
> -    xic->icp_get =3D pnv_icp_get;
> -    xic->ics_get =3D pnv_ics_get;
> -    xic->ics_resend =3D pnv_ics_resend;
> -    ispc->print_info =3D pnv_pic_print_info;
> =20
>      pnv_machine_class_props_init(oc);
>  }
> =20
> -#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
> -    {                                            \
> -        .name          =3D type,                   \
> -        .class_init    =3D class_initfn,           \
> -        .parent        =3D TYPE_PNV_CHIP,          \
> +static void pnv8_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> +
> +    /* Power8 is the default */
> +    mc->alias =3D "powernv";
> +    mc->is_default =3D 1;
> +
> +    xic->icp_get =3D pnv8_icp_get;
> +    xic->ics_get =3D pnv8_ics_get;
> +    xic->ics_resend =3D pnv8_ics_resend;
> +    ispc->print_info =3D pnv8_pic_print_info;
> +}
> +
> +static void pnv9_machine_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +#define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
> +    {                                             \
> +        .name          =3D type,                    \
> +        .class_init    =3D class_initfn,            \
> +        .parent        =3D TYPE_PNV8_CHIP,          \
> +    }
> +
> +#define DEFINE_PNV9_CHIP_TYPE(type, class_initfn) \
> +    {                                             \
> +        .name          =3D type,                    \
> +        .class_init    =3D class_initfn,            \
> +        .parent        =3D TYPE_PNV9_CHIP,          \
>      }
> =20
>  static const TypeInfo types[] =3D {
> +    /*
> +     * PowerNV machines and variants
> +     */
>      {
>          .name          =3D TYPE_PNV_MACHINE,
>          .parent        =3D TYPE_MACHINE,
> +        .abstract      =3D true,
>          .instance_size =3D sizeof(PnvMachineState),
>          .instance_init =3D pnv_machine_initfn,
>          .class_init    =3D pnv_machine_class_init,
>          .interfaces =3D (InterfaceInfo[]) {
> -            { TYPE_XICS_FABRIC },
>              { TYPE_INTERRUPT_STATS_PROVIDER },
>              { },
>          },
>      },
>      {
> +        .name          =3D MACHINE_TYPE_NAME("powernv9"),
> +        .parent        =3D TYPE_PNV_MACHINE,
> +        .class_init    =3D pnv9_machine_class_init,
> +    },
> +    {
> +        .name          =3D MACHINE_TYPE_NAME("powernv8"),
> +        .parent        =3D TYPE_PNV_MACHINE,
> +        .class_init    =3D pnv8_machine_class_init,
> +        .interfaces    =3D (InterfaceInfo[]) {
> +            { TYPE_XICS_FABRIC },
> +            { },
> +        },
> +    },
> +
> +    /* Power Chip */
> +    {
>          .name          =3D TYPE_PNV_CHIP,
>          .parent        =3D TYPE_SYS_BUS_DEVICE,
>          .class_init    =3D pnv_chip_class_init,
> -        .instance_init =3D pnv_chip_init,
> +        .instance_init =3D pnv_chip_initfn,
>          .instance_size =3D sizeof(PnvChip),
>          .class_size    =3D sizeof(PnvChipClass),
>          .abstract      =3D true,
>      },
> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_ini=
t),
> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
> -                         pnv_chip_power8nvl_class_init),
> +
> +    /*
> +     * P9 chips and variants
> +     */
> +    {
> +        .name          =3D TYPE_PNV9_CHIP,
> +        .parent        =3D TYPE_PNV_CHIP,
> +        .instance_init =3D pnv_chip_power9_initfn,
> +        .instance_size =3D sizeof(Pnv9Chip),
> +    },
> +    DEFINE_PNV9_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_in=
it),
> +
> +    /*
> +     * P8 chips and variants
> +     */
> +    {
> +        .name          =3D TYPE_PNV8_CHIP,
> +        .parent        =3D TYPE_PNV_CHIP,
> +        .instance_init =3D pnv_chip_power8_initfn,
> +        .instance_size =3D sizeof(Pnv8Chip),
> +    },
> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_in=
it),
> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_=
init),
> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
> +                          pnv_chip_power8nvl_class_init),
>  };
> =20
>  DEFINE_TYPES(types)
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 7f13c4bcf52c..265d94c3240d 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -435,7 +435,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
*errp)
>          return;
>      }
>      chip =3D PNV_CHIP(obj);
> -    lpc->psi =3D &chip->psi;
> +    lpc->psi =3D chip->psi;
>      lpc->primary =3D chip->chip_id =3D=3D 0;
> =20
>      /* Reg inits */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjL54ACgkQbDjKyiDZ
s5KQSxAA5u/d7ZmTRedBgDQ86kMABihYif8SmTO/AOnlRfvKbAsxRHUKXv5VMLKy
XmfAm1h+2aWDgDT4tif9BpWDZXEnmJKywa9nz+m7vIy2yo95O0s29hbBQUGx+qrP
YytAX4AivfmGGf+OEJZLzueXywDHtll0WKm7KTdAdUx+HXQFN+CeqUrkgAorA5ow
p6DWvwL713cb+JVKL7ODpxuEp4/3DK70c0nHh0i0+irzfDdhaBihFECwhsJvF+dM
Em3VXdbnEq//lNqEs9aMMZHilEkTe5mH5TKOqR4Opk0w7ee2mhMYGVWzg14pRYra
HsZrY6Sd/gT1M+rkLgsBilUFwUil3MyaPgiO9LeRcsHziFTybLvzi+EUoj8dKBO1
svgs+b9IoIsZAGp9FDbO3mt6b1lr98iVf39l7i8TvTcDB29AgJHoYbXS1YoeD5rO
PQNRp72dpOtNeP/LYJF2qmqPpTskN/pk15GqrEvjuQ18Pv3uz6Pj8cR155+9JOYv
u531dDAHvbA3crcuoJk5kvYU73KVvpw6dzQkQr7PzVFIMmBhEEtsZY31qWVIHEis
wVcAVac8BCgN25BF+RG6jyXAjiETBS6gv/Vj/+ZU1jjv6yZaEaE8DOKpfQtvtLon
dfH9k30DjZD5PLqhvYbMIa1Qb18WJ+yulEyeIN9KFqf/JcCxjnI=
=g025
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--
