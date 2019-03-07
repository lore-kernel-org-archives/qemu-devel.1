Received: from eggs.gnu.org ([209.51.188.92]:60562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21a7-0005OD-4F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21a4-0005g2-Ir
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:33:38 -0500
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:57587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21a2-0005Tw-Sr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:33:35 -0500
Received: from player778.ha.ovh.net (unknown [10.109.160.62])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3842E103310
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 23:33:31 +0100 (CET)
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-16-clg@kaod.org>
	<20190307041046.GI7722@umbus.fritz.box>
	<a852c265-9223-8d5f-f1de-0692e6228bc7@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <30942e48-02c6-371b-7895-c8254d37df65@kaod.org>
Date: Thu, 7 Mar 2019 23:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <a852c265-9223-8d5f-f1de-0692e6228bc7@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/27] ppc/pnv: add a PSI bridge model for
 POWER9
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

On 3/7/19 7:37 AM, C=E9dric Le Goater wrote:
> On 3/7/19 5:10 AM, David Gibson wrote:
>> On Wed, Mar 06, 2019 at 09:50:20AM +0100, C=E9dric Le Goater wrote:
>>> The PSI bridge on POWER9 is very similar to POWER8. The BAR is still
>>> set through XSCOM but the controls are now entirely done with MMIOs.
>>> More interrupts are defined and the interrupt controller interface ha=
s
>>> changed to XIVE. The POWER9 model is a first example of the usage of
>>> the notify() handler of the XiveNotifier interface, linking the PSI
>>> XiveSource to its owning device model.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> ---
>>>  include/hw/ppc/pnv.h       |   6 +
>>>  include/hw/ppc/pnv_psi.h   |  24 +++
>>>  include/hw/ppc/pnv_xscom.h |   3 +
>>>  hw/ppc/pnv.c               |  17 ++
>>>  hw/ppc/pnv_psi.c           | 325 +++++++++++++++++++++++++++++++++++=
+-
>>>  5 files changed, 373 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>>> index eb4bba25b3e9..57d0337219be 100644
>>> --- a/include/hw/ppc/pnv.h
>>> +++ b/include/hw/ppc/pnv.h
>>> @@ -84,6 +84,7 @@ typedef struct Pnv9Chip {
>>> =20
>>>      /*< public >*/
>>>      PnvXive      xive;
>>> +    PnvPsi       psi;
>>>  } Pnv9Chip;
>>> =20
>>>  typedef struct PnvChipClass {
>>> @@ -231,11 +232,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>>>  #define PNV9_XIVE_PC_SIZE            0x0000001000000000ull
>>>  #define PNV9_XIVE_PC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x00060180=
00000000ull)
>>> =20
>>> +#define PNV9_PSIHB_SIZE              0x0000000000100000ull
>>> +#define PNV9_PSIHB_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00060302=
03000000ull)
>>> +
>>>  #define PNV9_XIVE_IC_SIZE            0x0000000000080000ull
>>>  #define PNV9_XIVE_IC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x00060302=
03100000ull)
>>> =20
>>>  #define PNV9_XIVE_TM_SIZE            0x0000000000040000ull
>>>  #define PNV9_XIVE_TM_BASE(chip)      PNV9_CHIP_BASE(chip, 0x00060302=
03180000ull)
>>> =20
>>> +#define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
>>> +#define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x00060302=
031c0000ull)
>>> =20
>>>  #endif /* _PPC_PNV_H */
>>> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
>>> index 585a41cd19b6..d7e1ab282cf8 100644
>>> --- a/include/hw/ppc/pnv_psi.h
>>> +++ b/include/hw/ppc/pnv_psi.h
>>> @@ -21,6 +21,7 @@
>>> =20
>>>  #include "hw/sysbus.h"
>>>  #include "hw/ppc/xics.h"
>>> +#include "hw/ppc/xive.h"
>>> =20
>>>  #define TYPE_PNV_PSI "pnv-psi"
>>>  #define PNV_PSI(obj) \
>>> @@ -28,6 +29,9 @@
>>>  #define TYPE_PNV8_PSI TYPE_PNV_PSI "-POWER8"
>>>  #define PNV8_PSI(obj) \
>>>      OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV8_PSI)
>>> +#define TYPE_PNV9_PSI TYPE_PNV_PSI "-POWER9"
>>> +#define PNV9_PSI(obj) \
>>> +    OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV9_PSI)
>>> =20
>>>  #define PSIHB_XSCOM_MAX         0x20
>>> =20
>>> @@ -43,6 +47,7 @@ typedef struct PnvPsi {
>>> =20
>>>      /* Interrupt generation */
>>>      ICSState ics;
>>> +    XiveSource source;
>>
>> Uh... surely these should move to the subtype structures, so you don't
>> have both of them.
>=20
> I did not introduce a subtype, only a subclass. But we could=20
> possibly. It seemed overkill for one attribute.

But it is not that complex either to add a Pnv8Psi and a Pnv9Psi
with the correct attributes.=20

I will send a v2 with these changes. Hopefully these are good
enough for 4.0.=20

Thanks,

C.=20

>=20
>>
>>>      qemu_irq *qirqs;
>>> =20
>>>      /* Registers */
>>> @@ -82,4 +87,23 @@ typedef enum PnvPsiIrq {
>>> =20
>>>  void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
>>> =20
>>> +/* P9 PSI Interrupts */
>>> +#define PSIHB9_IRQ_PSI          0
>>> +#define PSIHB9_IRQ_OCC          1
>>> +#define PSIHB9_IRQ_FSI          2
>>> +#define PSIHB9_IRQ_LPCHC        3
>>> +#define PSIHB9_IRQ_LOCAL_ERR    4
>>> +#define PSIHB9_IRQ_GLOBAL_ERR   5
>>> +#define PSIHB9_IRQ_TPM          6
>>> +#define PSIHB9_IRQ_LPC_SIRQ0    7
>>> +#define PSIHB9_IRQ_LPC_SIRQ1    8
>>> +#define PSIHB9_IRQ_LPC_SIRQ2    9
>>> +#define PSIHB9_IRQ_LPC_SIRQ3    10
>>> +#define PSIHB9_IRQ_SBE_I2C      11
>>> +#define PSIHB9_IRQ_DIO          12
>>> +#define PSIHB9_IRQ_PSU          13
>>> +#define PSIHB9_NUM_IRQS         14
>>> +
>>> +void pnv_psi_pic_print_info(PnvPsi *psi, Monitor *mon);
>>> +
>>>  #endif /* _PPC_PNV_PSI_H */
>>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>>> index 6623ec54a7a8..403a365ed274 100644
>>> --- a/include/hw/ppc/pnv_xscom.h
>>> +++ b/include/hw/ppc/pnv_xscom.h
>>> @@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
>>>  #define PNV_XSCOM_OCC_BASE        0x0066000
>>>  #define PNV_XSCOM_OCC_SIZE        0x6000
>>> =20
>>> +#define PNV9_XSCOM_PSIHB_BASE     0x5012900
>>> +#define PNV9_XSCOM_PSIHB_SIZE     0x100
>>> +
>>>  #define PNV9_XSCOM_XIVE_BASE      0x5013000
>>>  #define PNV9_XSCOM_XIVE_SIZE      0x300
>>> =20
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 67d40dc3eebc..4375f97c7135 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -579,6 +579,7 @@ static void pnv_chip_power9_pic_print_info(PnvChi=
p *chip, Monitor *mon)
>>>      Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
>>> =20
>>>      pnv_xive_pic_print_info(&chip9->xive, mon);
>>> +    pnv_psi_pic_print_info(&chip9->psi, mon);
>>>  }
>>> =20
>>>  static void pnv_init(MachineState *machine)
>>> @@ -948,6 +949,11 @@ static void pnv_chip_power9_instance_init(Object=
 *obj)
>>>                              TYPE_PNV_XIVE, &error_abort, NULL);
>>>      object_property_add_const_link(OBJECT(&chip9->xive), "chip", obj=
,
>>>                                     &error_abort);
>>> +
>>> +    object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->=
psi),
>>> +                            TYPE_PNV9_PSI, &error_abort, NULL);
>>> +    object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj,
>>> +                                   &error_abort);
>>>  }
>>> =20
>>>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>>> @@ -980,6 +986,17 @@ static void pnv_chip_power9_realize(DeviceState =
*dev, Error **errp)
>>>      }
>>>      pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
>>>                              &chip9->xive.xscom_regs);
>>> +
>>> +    /* Processor Service Interface (PSI) Host Bridge */
>>> +    object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chi=
p),
>>> +                            "bar", &error_fatal);
>>> +    object_property_set_bool(OBJECT(&chip9->psi), true, "realized", =
&local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
>>> +                            &chip9->psi.xscom_regs);
>>>  }
>>> =20
>>>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *dat=
a)
>>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>>> index e56b455a61b1..3f995a0e0d7f 100644
>>> --- a/hw/ppc/pnv_psi.c
>>> +++ b/hw/ppc/pnv_psi.c
>>> @@ -22,6 +22,7 @@
>>>  #include "target/ppc/cpu.h"
>>>  #include "qemu/log.h"
>>>  #include "qapi/error.h"
>>> +#include "monitor/monitor.h"
>>> =20
>>>  #include "exec/address-spaces.h"
>>> =20
>>> @@ -114,6 +115,9 @@
>>>  #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
>>>  #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
>>> =20
>>> +#define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
>>> +#define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
>>> +
>>>  #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
>>> =20
>>>  static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>>> @@ -531,6 +535,7 @@ static void pnv_psi_power8_realize(DeviceState *d=
ev, Error **errp)
>>>  }
>>> =20
>>>  static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
>>> +static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
>>> =20
>>>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int x=
scom_offset)
>>>  {
>>> @@ -550,8 +555,13 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *d=
ev, void *fdt, int xscom_offset)
>>>      _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
>>>      _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
>>>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
>>> -    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
>>> -                     sizeof(compat_p8)));
>>> +    if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
>>
>> Ew.  You already have subclasses - put the compatible in there, rather
>> than more explicit tests against chip type.
>=20
> I would also prefer to move the compat string to PnvPsiClass instead=20
> of using a chip_type field but I didn't find a clean way for it. We=20
> use sizeof() on the compat string below and it does not work on a=20
> char *.
>=20
> I had the same issue in pnv_dt_xscom()
>=20
>>
>>> +        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
>>> +                         sizeof(compat_p9)));
>>> +    } else {
>>> +        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
>>> +                         sizeof(compat_p8)));
>>> +    }
>>>      return 0;
>>>  }
>>> =20
>>> @@ -583,6 +593,306 @@ static const TypeInfo pnv_psi_power8_info =3D {
>>>      .class_init    =3D pnv_psi_power8_class_init,
>>>  };
>>> =20
>>> +
>>> +/* Common registers */
>>> +
>>> +#define PSIHB9_CR                       0x20
>>> +#define PSIHB9_SEMR                     0x28
>>> +
>>> +/* P9 registers */
>>> +
>>> +#define PSIHB9_INTERRUPT_CONTROL        0x58
>>> +#define   PSIHB9_IRQ_METHOD             PPC_BIT(0)
>>> +#define   PSIHB9_IRQ_RESET              PPC_BIT(1)
>>> +#define PSIHB9_ESB_CI_BASE              0x60
>>> +#define   PSIHB9_ESB_CI_VALID           1
>>> +#define PSIHB9_ESB_NOTIF_ADDR           0x68
>>> +#define   PSIHB9_ESB_NOTIF_VALID        1
>>> +#define PSIHB9_IVT_OFFSET               0x70
>>> +#define   PSIHB9_IVT_OFF_SHIFT          32
>>> +
>>> +#define PSIHB9_IRQ_LEVEL                0x78 /* assertion */
>>> +#define   PSIHB9_IRQ_LEVEL_PSI          PPC_BIT(0)
>>> +#define   PSIHB9_IRQ_LEVEL_OCC          PPC_BIT(1)
>>> +#define   PSIHB9_IRQ_LEVEL_FSI          PPC_BIT(2)
>>> +#define   PSIHB9_IRQ_LEVEL_LPCHC        PPC_BIT(3)
>>> +#define   PSIHB9_IRQ_LEVEL_LOCAL_ERR    PPC_BIT(4)
>>> +#define   PSIHB9_IRQ_LEVEL_GLOBAL_ERR   PPC_BIT(5)
>>> +#define   PSIHB9_IRQ_LEVEL_TPM          PPC_BIT(6)
>>> +#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ1    PPC_BIT(7)
>>> +#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ2    PPC_BIT(8)
>>> +#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ3    PPC_BIT(9)
>>> +#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ4    PPC_BIT(10)
>>> +#define   PSIHB9_IRQ_LEVEL_SBE_I2C      PPC_BIT(11)
>>> +#define   PSIHB9_IRQ_LEVEL_DIO          PPC_BIT(12)
>>> +#define   PSIHB9_IRQ_LEVEL_PSU          PPC_BIT(13)
>>> +#define   PSIHB9_IRQ_LEVEL_I2C_C        PPC_BIT(14)
>>> +#define   PSIHB9_IRQ_LEVEL_I2C_D        PPC_BIT(15)
>>> +#define   PSIHB9_IRQ_LEVEL_I2C_E        PPC_BIT(16)
>>> +#define   PSIHB9_IRQ_LEVEL_SBE          PPC_BIT(19)
>>> +
>>> +#define PSIHB9_IRQ_STAT                 0x80 /* P bit */
>>> +#define   PSIHB9_IRQ_STAT_PSI           PPC_BIT(0)
>>> +#define   PSIHB9_IRQ_STAT_OCC           PPC_BIT(1)
>>> +#define   PSIHB9_IRQ_STAT_FSI           PPC_BIT(2)
>>> +#define   PSIHB9_IRQ_STAT_LPCHC         PPC_BIT(3)
>>> +#define   PSIHB9_IRQ_STAT_LOCAL_ERR     PPC_BIT(4)
>>> +#define   PSIHB9_IRQ_STAT_GLOBAL_ERR    PPC_BIT(5)
>>> +#define   PSIHB9_IRQ_STAT_TPM           PPC_BIT(6)
>>> +#define   PSIHB9_IRQ_STAT_LPC_SIRQ1     PPC_BIT(7)
>>> +#define   PSIHB9_IRQ_STAT_LPC_SIRQ2     PPC_BIT(8)
>>> +#define   PSIHB9_IRQ_STAT_LPC_SIRQ3     PPC_BIT(9)
>>> +#define   PSIHB9_IRQ_STAT_LPC_SIRQ4     PPC_BIT(10)
>>> +#define   PSIHB9_IRQ_STAT_SBE_I2C       PPC_BIT(11)
>>> +#define   PSIHB9_IRQ_STAT_DIO           PPC_BIT(12)
>>> +#define   PSIHB9_IRQ_STAT_PSU           PPC_BIT(13)
>>> +
>>> +static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(xf);
>>> +    uint64_t notif_port =3D psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADD=
R)];
>>> +    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
>>> +    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
>>> +
>>> +    uint32_t offset =3D
>>> +        (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_S=
HIFT);
>>> +    uint64_t lisn =3D cpu_to_be64(offset + srcno);
>>> +
>>> +    if (valid) {
>>> +        cpu_physical_memory_write(notify_addr, &lisn, sizeof(lisn));
>>> +    }
>>> +}
>>> +
>>> +static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsi=
gned size)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(opaque);
>>> +    uint32_t reg =3D PSIHB_REG(addr);
>>> +    uint64_t val =3D -1;
>>> +
>>> +    switch (addr) {
>>> +    case PSIHB9_CR:
>>> +    case PSIHB9_SEMR:
>>> +        /* FSP stuff */
>>> +    case PSIHB9_INTERRUPT_CONTROL:
>>> +    case PSIHB9_ESB_CI_BASE:
>>> +    case PSIHB9_ESB_NOTIF_ADDR:
>>> +    case PSIHB9_IVT_OFFSET:
>>> +        val =3D psi->regs[reg];
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: read at 0x%" PRIx64 "\n=
", addr);
>>> +    }
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
>>> +                                  uint64_t val, unsigned size)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(opaque);
>>> +    uint32_t reg =3D PSIHB_REG(addr);
>>> +    MemoryRegion *sysmem =3D get_system_memory();
>>> +
>>> +    switch (addr) {
>>> +    case PSIHB9_CR:
>>> +    case PSIHB9_SEMR:
>>> +        /* FSP stuff */
>>> +        break;
>>> +    case PSIHB9_INTERRUPT_CONTROL:
>>> +        if (val & PSIHB9_IRQ_RESET) {
>>> +            device_reset(DEVICE(&psi->source));
>>> +        }
>>> +        psi->regs[reg] =3D val;
>>> +        break;
>>> +
>>> +    case PSIHB9_ESB_CI_BASE:
>>> +        if (!(val & PSIHB9_ESB_CI_VALID)) {
>>> +            if (psi->regs[reg] & PSIHB9_ESB_CI_VALID) {
>>> +                memory_region_del_subregion(sysmem, &psi->source.esb=
_mmio);
>>> +            }
>>> +        } else {
>>> +            if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
>>> +                memory_region_add_subregion(sysmem,
>>> +                                        val & ~PSIHB9_ESB_CI_VALID,
>>> +                                        &psi->source.esb_mmio);
>>> +            }
>>> +        }
>>> +        psi->regs[reg] =3D val;
>>> +        break;
>>> +
>>> +    case PSIHB9_ESB_NOTIF_ADDR:
>>> +        psi->regs[reg] =3D val;
>>
>> Again, not in scope for this patch, but not being able to put a
>> reg[reg] =3D val outside the switch is a pretty good sign that a regs[=
]
>> array mirroring the guest register interface is not the right model
>> for this device.
>=20
> Well, in this case, I think we could put 'psi->regs[reg] =3D val;'.
>=20
> Thanks,
>=20
> C.
>=20
>>> +        break;
>>> +    case PSIHB9_IVT_OFFSET:
>>> +        psi->regs[reg] =3D val;
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: write at 0x%" PRIx64 "\=
n", addr);
>>> +    }
>>> +}
>>> +
>>> +static const MemoryRegionOps pnv_psi_p9_mmio_ops =3D {
>>> +    .read =3D pnv_psi_p9_mmio_read,
>>> +    .write =3D pnv_psi_p9_mmio_write,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +    .valid =3D {
>>> +        .min_access_size =3D 8,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +    .impl =3D {
>>> +        .min_access_size =3D 8,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +};
>>> +
>>> +static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, uns=
igned size)
>>> +{
>>> +    /* No read are expected */
>>> +    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "=
\n", addr);
>>> +    return -1;
>>> +}
>>> +
>>> +static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
>>> +                                uint64_t val, unsigned size)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(opaque);
>>> +
>>> +    /* XSCOM is only used to set the PSIHB MMIO region */
>>> +    switch (addr >> 3) {
>>> +    case PSIHB_XSCOM_BAR:
>>> +        pnv_psi_set_bar(psi, val);
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRI=
x64 "\n",
>>> +                      addr);
>>> +    }
>>> +}
>>> +
>>> +static const MemoryRegionOps pnv_psi_p9_xscom_ops =3D {
>>> +    .read =3D pnv_psi_p9_xscom_read,
>>> +    .write =3D pnv_psi_p9_xscom_write,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +    .valid =3D {
>>> +        .min_access_size =3D 8,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +    .impl =3D {
>>> +        .min_access_size =3D 8,
>>> +        .max_access_size =3D 8,
>>> +    }
>>> +};
>>> +
>>> +static void pnv_psi_power9_irq_set(PnvPsi *psi, int irq, bool state)
>>> +{
>>> +    uint32_t irq_method =3D psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CON=
TROL)];
>>> +
>>> +    if (irq > PSIHB9_NUM_IRQS) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", =
irq);
>>> +        return;
>>> +    }
>>> +
>>> +    if (irq_method & PSIHB9_IRQ_METHOD) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no suppo=
rted\n");
>>> +        return;
>>> +    }
>>> +
>>> +    /* Update LSI levels */
>>> +    if (state) {
>>> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |=3D PPC_BIT(irq);
>>> +    } else {
>>> +        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &=3D ~PPC_BIT(irq);
>>> +    }
>>> +
>>> +    qemu_set_irq(psi->qirqs[irq], state);
>>> +}
>>> +
>>> +static void pnv_psi_power9_reset(void *dev)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(dev);
>>> +
>>> +    pnv_psi_reset(dev);
>>> +
>>> +    if (memory_region_is_mapped(&psi->source.esb_mmio)) {
>>> +        memory_region_del_subregion(get_system_memory(), &psi->sourc=
e.esb_mmio);
>>> +    }
>>> +}
>>> +
>>> +static void pnv_psi_power9_instance_init(Object *obj)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(obj);
>>> +
>>> +    object_initialize_child(obj, "source", &psi->source, sizeof(psi-=
>source),
>>> +                            TYPE_XIVE_SOURCE, &error_abort, NULL);
>>> +}
>>> +
>>> +static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    PnvPsi *psi =3D PNV9_PSI(dev);
>>> +    XiveSource *xsrc =3D &psi->source;
>>> +    Error *local_err =3D NULL;
>>> +    int i;
>>> +
>>> +    /* This is the only device with 4k ESB pages */
>>> +    object_property_set_int(OBJECT(xsrc), XIVE_ESB_4K, "shift",
>>> +                            &error_fatal);
>>> +    object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs"=
,
>>> +                            &error_fatal);
>>> +    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(psi)=
,
>>> +                                   &error_fatal);
>>> +    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_=
err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +
>>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
>>> +        xive_source_irq_set_lsi(xsrc, i);
>>> +    }
>>> +
>>> +    psi->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc, xsr=
c->nr_irqs);
>>> +
>>> +    /* XSCOM region for PSI registers */
>>> +    pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_p9=
_xscom_ops,
>>> +                psi, "xscom-psi", PNV9_XSCOM_PSIHB_SIZE);
>>> +
>>> +    /* MMIO region for PSI registers */
>>> +    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mm=
io_ops, psi,
>>> +                          "psihb", PNV9_PSIHB_SIZE);
>>> +
>>> +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
>>> +
>>> +    qemu_register_reset(pnv_psi_power9_reset, dev);
>>> +}
>>> +
>>> +static void pnv_psi_power9_class_init(ObjectClass *klass, void *data=
)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
>>> +    XiveNotifierClass *xfc =3D XIVE_NOTIFIER_CLASS(klass);
>>> +
>>> +    dc->desc    =3D "PowerNV PSI Controller POWER9";
>>> +    dc->realize =3D pnv_psi_power9_realize;
>>> +
>>> +    ppc->chip_type  =3D PNV_CHIP_POWER9;
>>> +    ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
>>> +    ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
>>> +    ppc->bar_mask   =3D PSIHB9_BAR_MASK;
>>> +    ppc->irq_set    =3D pnv_psi_power9_irq_set;
>>> +
>>> +    xfc->notify      =3D pnv_psi_notify;
>>> +}
>>> +
>>> +static const TypeInfo pnv_psi_power9_info =3D {
>>> +    .name          =3D TYPE_PNV9_PSI,
>>> +    .parent        =3D TYPE_PNV_PSI,
>>> +    .instance_init =3D pnv_psi_power9_instance_init,
>>> +    .class_init    =3D pnv_psi_power9_class_init,
>>> +    .interfaces =3D (InterfaceInfo[]) {
>>> +            { TYPE_XIVE_NOTIFIER },
>>> +            { },
>>> +    },
>>> +};
>>> +
>>>  static void pnv_psi_class_init(ObjectClass *klass, void *data)
>>>  {
>>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> @@ -611,6 +921,17 @@ static void pnv_psi_register_types(void)
>>>  {
>>>      type_register_static(&pnv_psi_info);
>>>      type_register_static(&pnv_psi_power8_info);
>>> +    type_register_static(&pnv_psi_power9_info);
>>>  }
>>> =20
>>>  type_init(pnv_psi_register_types);
>>> +
>>> +void pnv_psi_pic_print_info(PnvPsi *psi, Monitor *mon)
>>> +{
>>> +    uint32_t offset =3D
>>> +        (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_S=
HIFT);
>>> +
>>> +    monitor_printf(mon, "PSIHB Source %08x .. %08x\n",
>>> +                  offset, offset + psi->source.nr_irqs - 1);
>>> +    xive_source_pic_print_info(&psi->source, offset, mon);
>>> +}
>>
>=20
