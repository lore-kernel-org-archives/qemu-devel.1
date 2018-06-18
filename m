Received: from eggs.gnu.org ([2001:4830:134:3::10]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUsMd-00042M-4R
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUsMY-0008W2-A0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:30:27 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:48948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUsMX-0008VV-RE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:30:22 -0400
Received: from player756.ha.ovh.net (unknown [10.109.120.29])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 21B951C2D0C
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 13:30:19 +0200 (CEST)
References: <20180615152536.30093-1-clg@kaod.org>
	<20180615152536.30093-4-clg@kaod.org>
	<20180618103844.GX25461@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9d1ce421-9caa-08eb-2417-15307dd271ed@kaod.org>
Date: Mon, 18 Jun 2018 13:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180618103844.GX25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] ppc/pnv: introduce Pnv8Chip and
 Pnv9Chip models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/18/2018 12:38 PM, David Gibson wrote:
> On Fri, Jun 15, 2018 at 05:25:35PM +0200, C=E9dric Le Goater wrote:
>> This is a major reshuffle of the PowerNV machine and chip models to
>> introduce a machine type per processor. It is quite noisy but it
>> doesn't change much the code flow.
>>
>> It introduces a base PnvChip class from which the specific processor
>> chip classes, Pnv8Chip and Pnv9Chip, inherit. Each of them needs to
>> define an init and a realize routine which will create the controllers
>> of the target processor. For the moment, the base PnvChip class
>> handles the XSCOM bus and the cores but the core creation will surely
>> move to the specific processor chip classes because of the new XIVE
>> interrupt controller in Power9.
>>
>> >From there, we introduce two different machines : "powernv8" and
>> "powernv9" but, a part from the XICSFabric interface, this is not
>> strictly needed as it is the cpu type which determines the PnvChip
>> class. Something to discuss.
>=20
> Yeah.. I'd leave this bit out for now.  It can go into a later patch,
> with the machine type actually determining the chip type.

yes. There are other issues to fix around the machine type anyway. Like
making sure we cannot start a machine with : -M powernv9 -cpu POWER8
=20
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/pnv.h |  23 +++-
>>  hw/ppc/pnv.c         | 322 +++++++++++++++++++++++++++++++++---------=
---------
>>  2 files changed, 231 insertions(+), 114 deletions(-)
>>
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index 563279f3e00c..244856414580 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -57,12 +57,32 @@ typedef struct PnvChip {
>>      MemoryRegion xscom_mmio;
>>      MemoryRegion xscom;
>>      AddressSpace xscom_as;
>> +} PnvChip;
>> +
>> +#define TYPE_PNV8_CHIP "pnv8-chip"
>> +#define PNV8_CHIP(obj) OBJECT_CHECK(Pnv8Chip, (obj), TYPE_PNV8_CHIP)
>> +
>> +typedef struct Pnv8Chip {
>> +    /*< private >*/
>> +    PnvChip      parent_obj;
>> +
>> +    /*< public >*/
>>      MemoryRegion icp_mmio;
>> =20
>>      PnvLpcController lpc;
>>      PnvPsi       psi;
>>      PnvOCC       occ;
>> -} PnvChip;
>> +} Pnv8Chip;
>> +
>> +#define TYPE_PNV9_CHIP "pnv9-chip"
>> +#define PNV9_CHIP(obj) OBJECT_CHECK(Pnv9Chip, (obj), TYPE_PNV9_CHIP)
>> +
>> +typedef struct Pnv9Chip {
>> +    /*< private >*/
>> +    PnvChip      parent_obj;
>> +
>> +    /*< public >*/
>> +} Pnv9Chip;
>> =20
>>  typedef struct PnvChipClass {
>>      /*< private >*/
>> @@ -75,6 +95,7 @@ typedef struct PnvChipClass {
>> =20
>>      hwaddr       xscom_base;
>> =20
>> +    void (*realize)(PnvChip *chip, Error **errp);
>=20
> This looks the wrong way round from how things are usually done.
> Rather than having the base class realize() call the subclass specific
> realize hook, it's more usual for the subclass to set the
> dc->realize() and have it call a k->parent_realize() to call up the
> chain.  grep for device_class_set_parent_realize() for some more
> examples.

Ah. That is more to my liking. There are a couple of models following
the wrong object pattern, xics, vio. I will check them.
=20
> As a general rule, giving the overall control flow to the most
> specific subclass in the chain tends to work better.

yes.=20

> Other than that, this looks good.

OK. I will then reshuffle the patchset and move out of the physmap patch=20
on which we don't seem to have the same ideas. It can come later.

After that round, the P8/phb3 and P9/Xive can be the next models.

phb3 would be a good extension to the existing machine. It did some
code rework, so it looks better.

and Xive is a must of have for P9. But to get a P9 machine running,=20
we need a couple of more models :
=20
	PSI, LPC, OCC,=20

nothing complex, and I think they are ready, and some P9 CPU work:=20

	32bit decrementer, stop_lite state, radix.

I worked around these for the moment.

Thanks,

C.=20

>>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>>      Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp=
);
>>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index ac828d133173..b416a1a6ed63 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -531,12 +531,14 @@ static void pnv_reset(void)
>> =20
>>  static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp=
)
>>  {
>> -    return pnv_lpc_isa_create(&chip->lpc, true, errp);
>> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
>> +    return pnv_lpc_isa_create(&chip8->lpc, true, errp);
>>  }
>> =20
>>  static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **e=
rrp)
>>  {
>> -    return pnv_lpc_isa_create(&chip->lpc, false, errp);
>> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
>> +    return pnv_lpc_isa_create(&chip8->lpc, false, errp);
>>  }
>> =20
>>  static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp=
)
>> @@ -725,6 +727,97 @@ static Object *pnv_chip_power9_intc_create(PnvChi=
p *chip, Object *child,
>>   */
>>  #define POWER9_CORE_MASK   (0xffffffffffffffull)
>> =20
>> +static void pnv_chip_power8_instance_init(Object *obj)
>> +{
>> +    Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
>> +
>> +    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
>> +    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
>> +
>> +    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
>> +    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
>> +    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
>> +                                   OBJECT(qdev_get_machine()), &error=
_abort);
>> +
>> +    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
>> +    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
>> +    object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>> +                                   OBJECT(&chip8->psi), &error_abort)=
;
>> +
>> +    /* The LPC controller needs PSI to generate interrupts */
>> +    object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
>> +                                   OBJECT(&chip8->psi), &error_abort)=
;
>> +}
>> +
>> +static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
>> + {
>> +    PnvChip *chip =3D PNV_CHIP(chip8);
>> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>> +    const char *typename =3D pnv_chip_core_typename(chip);
>> +    size_t typesize =3D object_type_get_instance_size(typename);
>> +    int i, j;
>> +    char *name;
>> +    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
>> +
>> +    name =3D g_strdup_printf("icp-%x", chip->chip_id);
>> +    memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_=
SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
>> +    g_free(name);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
>> +
>> +    /* Map the ICP registers for each thread */
>> +    for (i =3D 0; i < chip->nr_cores; i++) {
>> +        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
>> +        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
>> +
>> +        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
>> +            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
>> +            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
>> +
>> +            memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
>> +                                        &icp->mmio);
>> +        }
>> +    }
>> +}
>> +
>> +static void pnv_chip_power8_realize(PnvChip *chip, Error **errp)
>> + {
>> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
>> +    Error *error =3D NULL;
>> +
>> +    /* Create LPC controller */
>> +    object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
>> +                             &error_fatal);
>> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xsc=
om_regs);
>> +
>> +    /* Interrupt Management Area. This is the memory region holding
>> +     * all the Interrupt Control Presenter (ICP) registers */
>> +    pnv_chip_icp_realize(chip8, &error);
>> +    if (error) {
>> +        error_propagate(errp, error);
>> +        return;
>> +    }
>> +
>> +    /* Processor Service Interface (PSI) Host Bridge */
>> +    object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip)=
,
>> +                            "bar", &error_fatal);
>> +    object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &=
error);
>> +    if (error) {
>> +        error_propagate(errp, error);
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip8->psi.x=
scom_regs);
>> +
>> +    /* Create the simplified OCC model */
>> +    object_property_set_bool(OBJECT(&chip8->occ), true, "realized", &=
error);
>> +    if (error) {
>> +        error_propagate(errp, error);
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xsc=
om_regs);
>> +}
>> +
>>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *dat=
a)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> @@ -736,6 +829,7 @@ static void pnv_chip_power8e_class_init(ObjectClas=
s *klass, void *data)
>>      k->core_pir =3D pnv_chip_core_pir_p8;
>>      k->intc_create =3D pnv_chip_power8_intc_create;
>>      k->isa_create =3D pnv_chip_power8_isa_create;
>> +    k->realize  =3D pnv_chip_power8_realize;
>>      k->xscom_base =3D 0x003fc0000000000ull;
>>      dc->desc =3D "PowerNV Chip POWER8E";
>>  }
>> @@ -751,6 +845,7 @@ static void pnv_chip_power8_class_init(ObjectClass=
 *klass, void *data)
>>      k->core_pir =3D pnv_chip_core_pir_p8;
>>      k->intc_create =3D pnv_chip_power8_intc_create;
>>      k->isa_create =3D pnv_chip_power8_isa_create;
>> +    k->realize  =3D pnv_chip_power8_realize;
>>      k->xscom_base =3D 0x003fc0000000000ull;
>>      dc->desc =3D "PowerNV Chip POWER8";
>>  }
>> @@ -766,10 +861,20 @@ static void pnv_chip_power8nvl_class_init(Object=
Class *klass, void *data)
>>      k->core_pir =3D pnv_chip_core_pir_p8;
>>      k->intc_create =3D pnv_chip_power8_intc_create;
>>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
>> +    k->realize  =3D pnv_chip_power8_realize;
>>      k->xscom_base =3D 0x003fc0000000000ull;
>>      dc->desc =3D "PowerNV Chip POWER8NVL";
>>  }
>> =20
>> +static void pnv_chip_power9_instance_init(Object *obj)
>> +{
>> +}
>> +
>> +static void pnv_chip_power9_realize(PnvChip *chip, Error **errp)
>> +{
>> +
>> +}
>> +
>>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data=
)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> @@ -781,6 +886,7 @@ static void pnv_chip_power9_class_init(ObjectClass=
 *klass, void *data)
>>      k->core_pir =3D pnv_chip_core_pir_p9;
>>      k->intc_create =3D pnv_chip_power9_intc_create;
>>      k->isa_create =3D pnv_chip_power9_isa_create;
>> +    k->realize  =3D pnv_chip_power9_realize;
>>      k->xscom_base =3D 0x00603fc00000000ull;
>>      dc->desc =3D "PowerNV Chip POWER9";
>>  }
>> @@ -815,59 +921,9 @@ static void pnv_chip_core_sanitize(PnvChip *chip,=
 Error **errp)
>>      }
>>  }
>> =20
>> -static void pnv_chip_init(Object *obj)
>> +static void pnv_chip_instance_init(Object *obj)
>>  {
>> -    PnvChip *chip =3D PNV_CHIP(obj);
>> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>> -
>> -    chip->xscom_base =3D pcc->xscom_base;
>> -
>> -    object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
>> -    object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
>> -
>> -    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
>> -    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
>> -    object_property_add_const_link(OBJECT(&chip->psi), "xics",
>> -                                   OBJECT(qdev_get_machine()), &error=
_abort);
>> -
>> -    object_initialize(&chip->occ, sizeof(chip->occ), TYPE_PNV_OCC);
>> -    object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
>> -    object_property_add_const_link(OBJECT(&chip->occ), "psi",
>> -                                   OBJECT(&chip->psi), &error_abort);
>> -
>> -    /* The LPC controller needs PSI to generate interrupts */
>> -    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
>> -                                   OBJECT(&chip->psi), &error_abort);
>> -}
>> -
>> -static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>> -{
>> -    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>> -    const char *typename =3D pnv_chip_core_typename(chip);
>> -    size_t typesize =3D object_type_get_instance_size(typename);
>> -    int i, j;
>> -    char *name;
>> -    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
>> -
>> -    name =3D g_strdup_printf("icp-%x", chip->chip_id);
>> -    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_S=
IZE);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
>> -    g_free(name);
>> -
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
>> -
>> -    /* Map the ICP registers for each thread */
>> -    for (i =3D 0; i < chip->nr_cores; i++) {
>> -        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
>> -        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
>> -
>> -        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
>> -            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
>> -            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
>> -
>> -            memory_region_add_subregion(&chip->icp_mmio, pir << 12, &=
icp->mmio);
>> -        }
>> -    }
>> +    PNV_CHIP(obj)->xscom_base =3D PNV_CHIP_GET_CLASS(obj)->xscom_base=
;
>>  }
>> =20
>>  static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
>> @@ -935,6 +991,7 @@ static void pnv_chip_core_realize(PnvChip *chip, E=
rror **errp)
>>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
>>  {
>>      PnvChip *chip =3D PNV_CHIP(dev);
>> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
>>      Error *error =3D NULL;
>> =20
>>      /* XSCOM bridge */
>> @@ -952,36 +1009,7 @@ static void pnv_chip_realize(DeviceState *dev, E=
rror **errp)
>>          return;
>>      }
>> =20
>> -    /* Create LPC controller */
>> -    object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>> -                             &error_fatal);
>> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xsco=
m_regs);
>> -
>> -    /* Interrupt Management Area. This is the memory region holding
>> -     * all the Interrupt Control Presenter (ICP) registers */
>> -    pnv_chip_icp_realize(chip, &error);
>> -    if (error) {
>> -        error_propagate(errp, error);
>> -        return;
>> -    }
>> -
>> -    /* Processor Service Interface (PSI) Host Bridge */
>> -    object_property_set_int(OBJECT(&chip->psi), PNV_PSIHB_BASE(chip),
>> -                            "bar", &error_fatal);
>> -    object_property_set_bool(OBJECT(&chip->psi), true, "realized", &e=
rror);
>> -    if (error) {
>> -        error_propagate(errp, error);
>> -        return;
>> -    }
>> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xs=
com_regs);
>> -
>> -    /* Create the simplified OCC model */
>> -    object_property_set_bool(OBJECT(&chip->occ), true, "realized", &e=
rror);
>> -    if (error) {
>> -        error_propagate(errp, error);
>> -        return;
>> -    }
>> -    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xsco=
m_regs);
>> +    pcc->realize(chip, errp);
>>  }
>> =20
>>  static Property pnv_chip_properties[] =3D {
>> @@ -1003,26 +1031,29 @@ static void pnv_chip_class_init(ObjectClass *k=
lass, void *data)
>>      dc->desc =3D "PowerNV Chip";
>>  }
>> =20
>> -static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>> +static ICSState *pnv8_ics_get(XICSFabric *xi, int irq)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(xi);
>>      int i;
>> =20
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>> -        if (ics_valid_irq(&pnv->chips[i]->psi.ics, irq)) {
>> -            return &pnv->chips[i]->psi.ics;
>> +        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
>> +
>> +        if (ics_valid_irq(&chip8->psi.ics, irq)) {
>> +            return &chip8->psi.ics;
>>          }
>>      }
>>      return NULL;
>>  }
>> =20
>> -static void pnv_ics_resend(XICSFabric *xi)
>> +static void pnv8_ics_resend(XICSFabric *xi)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(xi);
>>      int i;
>> =20
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>> -        ics_resend(&pnv->chips[i]->psi.ics);
>> +        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
>> +        ics_resend(&chip8->psi.ics);
>>      }
>>  }
>> =20
>> @@ -1042,15 +1073,14 @@ static PowerPCCPU *ppc_get_vcpu_by_pir(int pir=
)
>>      return NULL;
>>  }
>> =20
>> -static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
>> +static ICPState *pnv8_icp_get(XICSFabric *xi, int pir)
>>  {
>>      PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
>> =20
>>      return cpu ? ICP(cpu->intc) : NULL;
>>  }
>> =20
>> -static void pnv_pic_print_info(InterruptStatsProvider *obj,
>> -                               Monitor *mon)
>> +static void pnv8_pic_print_info(InterruptStatsProvider *obj, Monitor =
*mon)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
>>      int i;
>> @@ -1063,7 +1093,8 @@ static void pnv_pic_print_info(InterruptStatsPro=
vider *obj,
>>      }
>> =20
>>      for (i =3D 0; i < pnv->num_chips; i++) {
>> -        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
>> +        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
>> +        ics_pic_print_info(&chip8->psi.ics, mon);
>>      }
>>  }
>> =20
>> @@ -1098,7 +1129,7 @@ static void pnv_set_num_chips(Object *obj, Visit=
or *v, const char *name,
>>      pnv->num_chips =3D num_chips;
>>  }
>> =20
>> -static void pnv_machine_initfn(Object *obj)
>> +static void pnv_machine_instance_init(Object *obj)
>>  {
>>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
>>      pnv->num_chips =3D 1;
>> @@ -1117,8 +1148,6 @@ static void pnv_machine_class_props_init(ObjectC=
lass *oc)
>>  static void pnv_machine_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>> -    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> -    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
>> =20
>>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>>      mc->init =3D pnv_init;
>> @@ -1130,48 +1159,115 @@ static void pnv_machine_class_init(ObjectClas=
s *oc, void *data)
>>      mc->no_parallel =3D 1;
>>      mc->default_boot_order =3D NULL;
>>      mc->default_ram_size =3D 1 * G_BYTE;
>> -    xic->icp_get =3D pnv_icp_get;
>> -    xic->ics_get =3D pnv_ics_get;
>> -    xic->ics_resend =3D pnv_ics_resend;
>> -    ispc->print_info =3D pnv_pic_print_info;
>> =20
>>      pnv_machine_class_props_init(oc);
>>  }
>> =20
>> -#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
>> -    {                                            \
>> -        .name          =3D type,                   \
>> -        .class_init    =3D class_initfn,           \
>> -        .parent        =3D TYPE_PNV_CHIP,          \
>> +static void pnv8_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>> +    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
>> +
>> +    /* Power8 is the default */
>> +    mc->desc =3D "IBM PowerNV (Non-Virtualized) Power8";
>> +    mc->alias =3D "powernv";
>> +    mc->is_default =3D 1;
>> +
>> +    xic->icp_get =3D pnv8_icp_get;
>> +    xic->ics_get =3D pnv8_ics_get;
>> +    xic->ics_resend =3D pnv8_ics_resend;
>> +    ispc->print_info =3D pnv8_pic_print_info;
>> +}
>> +
>> +static void pnv9_machine_class_init(ObjectClass *oc, void *data)
>> +{
>> +   MachineClass *mc =3D MACHINE_CLASS(oc);
>> +
>> +   mc->desc =3D "IBM PowerNV (Non-Virtualized) Power9";
>> +   mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>> +}
>> +
>> +#define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
>> +    {                                             \
>> +        .name          =3D type,                    \
>> +        .class_init    =3D class_initfn,            \
>> +        .parent        =3D TYPE_PNV8_CHIP,          \
>> +    }
>> +
>> +#define DEFINE_PNV9_CHIP_TYPE(type, class_initfn) \
>> +    {                                             \
>> +        .name          =3D type,                    \
>> +        .class_init    =3D class_initfn,            \
>> +        .parent        =3D TYPE_PNV9_CHIP,          \
>>      }
>> =20
>>  static const TypeInfo types[] =3D {
>> +    /*
>> +     * PowerNV machines and variants
>> +     */
>>      {
>>          .name          =3D TYPE_PNV_MACHINE,
>>          .parent        =3D TYPE_MACHINE,
>> +        .abstract      =3D true,
>>          .instance_size =3D sizeof(PnvMachineState),
>> -        .instance_init =3D pnv_machine_initfn,
>> +        .instance_init =3D pnv_machine_instance_init,
>>          .class_init    =3D pnv_machine_class_init,
>>          .interfaces =3D (InterfaceInfo[]) {
>> -            { TYPE_XICS_FABRIC },
>>              { TYPE_INTERRUPT_STATS_PROVIDER },
>>              { },
>>          },
>>      },
>>      {
>> +        .name          =3D MACHINE_TYPE_NAME("powernv9"),
>> +        .parent        =3D TYPE_PNV_MACHINE,
>> +        .class_init    =3D pnv9_machine_class_init,
>> +    },
>> +    {
>> +        .name          =3D MACHINE_TYPE_NAME("powernv8"),
>> +        .parent        =3D TYPE_PNV_MACHINE,
>> +        .class_init    =3D pnv8_machine_class_init,
>> +        .interfaces    =3D (InterfaceInfo[]) {
>> +            { TYPE_XICS_FABRIC },
>> +            { },
>> +        },
>> +    },
>> +
>> +    /* Power Chip */
>> +    {
>>          .name          =3D TYPE_PNV_CHIP,
>>          .parent        =3D TYPE_SYS_BUS_DEVICE,
>>          .class_init    =3D pnv_chip_class_init,
>> -        .instance_init =3D pnv_chip_init,
>> +        .instance_init =3D pnv_chip_instance_init,
>>          .instance_size =3D sizeof(PnvChip),
>>          .class_size    =3D sizeof(PnvChipClass),
>>          .abstract      =3D true,
>>      },
>> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_=
init),
>> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_=
init),
>> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_clas=
s_init),
>> -    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
>> -                         pnv_chip_power8nvl_class_init),
>> +
>> +    /*
>> +     * P9 chips and variants
>> +     */
>> +    {
>> +        .name          =3D TYPE_PNV9_CHIP,
>> +        .parent        =3D TYPE_PNV_CHIP,
>> +        .instance_init =3D pnv_chip_power9_instance_init,
>> +        .instance_size =3D sizeof(Pnv9Chip),
>> +    },
>> +    DEFINE_PNV9_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class=
_init),
>> +
>> +    /*
>> +     * P8 chips and variants
>> +     */
>> +    {
>> +        .name          =3D TYPE_PNV8_CHIP,
>> +        .parent        =3D TYPE_PNV_CHIP,
>> +        .instance_init =3D pnv_chip_power8_instance_init,
>> +        .instance_size =3D sizeof(Pnv8Chip),
>> +    },
>> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class=
_init),
>> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_cla=
ss_init),
>> +    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
>> +                          pnv_chip_power8nvl_class_init),
>>  };
>> =20
>>  DEFINE_TYPES(types)
>=20
