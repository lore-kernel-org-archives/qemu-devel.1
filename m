Received: from eggs.gnu.org ([209.51.188.92]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h29G4-0003Zm-PW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h29G3-0001zo-95
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:28 -0500
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:60979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h29G3-0001qm-12
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:27 -0500
Received: from player730.ha.ovh.net (unknown [10.109.143.146])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6DFF9103A2B
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 07:45:24 +0100 (CET)
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-16-clg@kaod.org>
	<20190307041046.GI7722@umbus.fritz.box>
	<a852c265-9223-8d5f-f1de-0692e6228bc7@kaod.org>
	<20190308001722.GH7722@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e845671b-52ee-5d66-1cbf-214e63659dfb@kaod.org>
Date: Fri, 8 Mar 2019 07:45:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190308001722.GH7722@umbus.fritz.box>
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

On 3/8/19 1:17 AM, David Gibson wrote:
> On Thu, Mar 07, 2019 at 07:37:51AM +0100, C=E9dric Le Goater wrote:
>> On 3/7/19 5:10 AM, David Gibson wrote:
>>> On Wed, Mar 06, 2019 at 09:50:20AM +0100, C=E9dric Le Goater wrote:
>>>> The PSI bridge on POWER9 is very similar to POWER8. The BAR is still
>>>> set through XSCOM but the controls are now entirely done with MMIOs.
>>>> More interrupts are defined and the interrupt controller interface h=
as
>>>> changed to XIVE. The POWER9 model is a first example of the usage of
>>>> the notify() handler of the XiveNotifier interface, linking the PSI
>>>> XiveSource to its owning device model.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  include/hw/ppc/pnv.h       |   6 +
>>>>  include/hw/ppc/pnv_psi.h   |  24 +++
>>>>  include/hw/ppc/pnv_xscom.h |   3 +
>>>>  hw/ppc/pnv.c               |  17 ++
>>>>  hw/ppc/pnv_psi.c           | 325 ++++++++++++++++++++++++++++++++++=
++-
>>>>  5 files changed, 373 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>>>> index eb4bba25b3e9..57d0337219be 100644
>>>> --- a/include/hw/ppc/pnv.h
>>>> +++ b/include/hw/ppc/pnv.h
>>>> @@ -84,6 +84,7 @@ typedef struct Pnv9Chip {
>>>> =20
>>>>      /*< public >*/
>>>>      PnvXive      xive;
>>>> +    PnvPsi       psi;
>>>>  } Pnv9Chip;
>>>> =20
>>>>  typedef struct PnvChipClass {
>>>> @@ -231,11 +232,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
>>>>  #define PNV9_XIVE_PC_SIZE            0x0000001000000000ull
>>>>  #define PNV9_XIVE_PC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x0006018=
000000000ull)
>>>> =20
>>>> +#define PNV9_PSIHB_SIZE              0x0000000000100000ull
>>>> +#define PNV9_PSIHB_BASE(chip)        PNV9_CHIP_BASE(chip, 0x0006030=
203000000ull)
>>>> +
>>>>  #define PNV9_XIVE_IC_SIZE            0x0000000000080000ull
>>>>  #define PNV9_XIVE_IC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x0006030=
203100000ull)
>>>> =20
>>>>  #define PNV9_XIVE_TM_SIZE            0x0000000000040000ull
>>>>  #define PNV9_XIVE_TM_BASE(chip)      PNV9_CHIP_BASE(chip, 0x0006030=
203180000ull)
>>>> =20
>>>> +#define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
>>>> +#define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x0006030=
2031c0000ull)
>>>> =20
>>>>  #endif /* _PPC_PNV_H */
>>>> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
>>>> index 585a41cd19b6..d7e1ab282cf8 100644
>>>> --- a/include/hw/ppc/pnv_psi.h
>>>> +++ b/include/hw/ppc/pnv_psi.h
>>>> @@ -21,6 +21,7 @@
>>>> =20
>>>>  #include "hw/sysbus.h"
>>>>  #include "hw/ppc/xics.h"
>>>> +#include "hw/ppc/xive.h"
>>>> =20
>>>>  #define TYPE_PNV_PSI "pnv-psi"
>>>>  #define PNV_PSI(obj) \
>>>> @@ -28,6 +29,9 @@
>>>>  #define TYPE_PNV8_PSI TYPE_PNV_PSI "-POWER8"
>>>>  #define PNV8_PSI(obj) \
>>>>      OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV8_PSI)
>>>> +#define TYPE_PNV9_PSI TYPE_PNV_PSI "-POWER9"
>>>> +#define PNV9_PSI(obj) \
>>>> +    OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV9_PSI)
>>>> =20
>>>>  #define PSIHB_XSCOM_MAX         0x20
>>>> =20
>>>> @@ -43,6 +47,7 @@ typedef struct PnvPsi {
>>>> =20
>>>>      /* Interrupt generation */
>>>>      ICSState ics;
>>>> +    XiveSource source;
>>>
>>> Uh... surely these should move to the subtype structures, so you don'=
t
>>> have both of them.
>>
>> I did not introduce a subtype, only a subclass. But we could=20
>> possibly. It seemed overkill for one attribute.
>>
>>>
>>>>      qemu_irq *qirqs;
>>>> =20
>>>>      /* Registers */
>>>> @@ -82,4 +87,23 @@ typedef enum PnvPsiIrq {
>>>> =20
>>>>  void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
>>>> =20
>>>> +/* P9 PSI Interrupts */
>>>> +#define PSIHB9_IRQ_PSI          0
>>>> +#define PSIHB9_IRQ_OCC          1
>>>> +#define PSIHB9_IRQ_FSI          2
>>>> +#define PSIHB9_IRQ_LPCHC        3
>>>> +#define PSIHB9_IRQ_LOCAL_ERR    4
>>>> +#define PSIHB9_IRQ_GLOBAL_ERR   5
>>>> +#define PSIHB9_IRQ_TPM          6
>>>> +#define PSIHB9_IRQ_LPC_SIRQ0    7
>>>> +#define PSIHB9_IRQ_LPC_SIRQ1    8
>>>> +#define PSIHB9_IRQ_LPC_SIRQ2    9
>>>> +#define PSIHB9_IRQ_LPC_SIRQ3    10
>>>> +#define PSIHB9_IRQ_SBE_I2C      11
>>>> +#define PSIHB9_IRQ_DIO          12
>>>> +#define PSIHB9_IRQ_PSU          13
>>>> +#define PSIHB9_NUM_IRQS         14
>>>> +
>>>> +void pnv_psi_pic_print_info(PnvPsi *psi, Monitor *mon);
>>>> +
>>>>  #endif /* _PPC_PNV_PSI_H */
>>>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>>>> index 6623ec54a7a8..403a365ed274 100644
>>>> --- a/include/hw/ppc/pnv_xscom.h
>>>> +++ b/include/hw/ppc/pnv_xscom.h
>>>> @@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
>>>>  #define PNV_XSCOM_OCC_BASE        0x0066000
>>>>  #define PNV_XSCOM_OCC_SIZE        0x6000
>>>> =20
>>>> +#define PNV9_XSCOM_PSIHB_BASE     0x5012900
>>>> +#define PNV9_XSCOM_PSIHB_SIZE     0x100
>>>> +
>>>>  #define PNV9_XSCOM_XIVE_BASE      0x5013000
>>>>  #define PNV9_XSCOM_XIVE_SIZE      0x300
>>>> =20
>>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>>> index 67d40dc3eebc..4375f97c7135 100644
>>>> --- a/hw/ppc/pnv.c
>>>> +++ b/hw/ppc/pnv.c
>>>> @@ -579,6 +579,7 @@ static void pnv_chip_power9_pic_print_info(PnvCh=
ip *chip, Monitor *mon)
>>>>      Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
>>>> =20
>>>>      pnv_xive_pic_print_info(&chip9->xive, mon);
>>>> +    pnv_psi_pic_print_info(&chip9->psi, mon);
>>>>  }
>>>> =20
>>>>  static void pnv_init(MachineState *machine)
>>>> @@ -948,6 +949,11 @@ static void pnv_chip_power9_instance_init(Objec=
t *obj)
>>>>                              TYPE_PNV_XIVE, &error_abort, NULL);
>>>>      object_property_add_const_link(OBJECT(&chip9->xive), "chip", ob=
j,
>>>>                                     &error_abort);
>>>> +
>>>> +    object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9-=
>psi),
>>>> +                            TYPE_PNV9_PSI, &error_abort, NULL);
>>>> +    object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj=
,
>>>> +                                   &error_abort);
>>>>  }
>>>> =20
>>>>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>>>> @@ -980,6 +986,17 @@ static void pnv_chip_power9_realize(DeviceState=
 *dev, Error **errp)
>>>>      }
>>>>      pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
>>>>                              &chip9->xive.xscom_regs);
>>>> +
>>>> +    /* Processor Service Interface (PSI) Host Bridge */
>>>> +    object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(ch=
ip),
>>>> +                            "bar", &error_fatal);
>>>> +    object_property_set_bool(OBJECT(&chip9->psi), true, "realized",=
 &local_err);
>>>> +    if (local_err) {
>>>> +        error_propagate(errp, local_err);
>>>> +        return;
>>>> +    }
>>>> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
>>>> +                            &chip9->psi.xscom_regs);
>>>>  }
>>>> =20
>>>>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *da=
ta)
>>>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>>>> index e56b455a61b1..3f995a0e0d7f 100644
>>>> --- a/hw/ppc/pnv_psi.c
>>>> +++ b/hw/ppc/pnv_psi.c
>>>> @@ -22,6 +22,7 @@
>>>>  #include "target/ppc/cpu.h"
>>>>  #include "qemu/log.h"
>>>>  #include "qapi/error.h"
>>>> +#include "monitor/monitor.h"
>>>> =20
>>>>  #include "exec/address-spaces.h"
>>>> =20
>>>> @@ -114,6 +115,9 @@
>>>>  #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
>>>>  #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
>>>> =20
>>>> +#define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
>>>> +#define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
>>>> +
>>>>  #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
>>>> =20
>>>>  static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>>>> @@ -531,6 +535,7 @@ static void pnv_psi_power8_realize(DeviceState *=
dev, Error **errp)
>>>>  }
>>>> =20
>>>>  static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x"=
;
>>>> +static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x"=
;
>>>> =20
>>>>  static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int =
xscom_offset)
>>>>  {
>>>> @@ -550,8 +555,13 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *=
dev, void *fdt, int xscom_offset)
>>>>      _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
>>>>      _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
>>>>      _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
>>>> -    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
>>>> -                     sizeof(compat_p8)));
>>>> +    if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
>>>
>>> Ew.  You already have subclasses - put the compatible in there, rathe=
r
>>> than more explicit tests against chip type.
>>
>> I would also prefer to move the compat string to PnvPsiClass instead=20
>> of using a chip_type field but I didn't find a clean way for it. We=20
>> use sizeof() on the compat string below and it does not work on a=20
>> char *.
>=20
> Ah, right.  There are ways to do that, but they're also ugly in their
> own different ways.  Ok, well let's leave it as is for now, and
> consider cleaning that up something for another day.
>=20
> [snip]
>>> Again, not in scope for this patch, but not being able to put a
>>> reg[reg] =3D val outside the switch is a pretty good sign that a regs=
[]
>>> array mirroring the guest register interface is not the right model
>>> for this device.
>>
>> Well, in this case, I think we could put 'psi->regs[reg] =3D val;'.
>=20
> It feels like that sentence is unfinished.

... at the end of the switch case.=20

I will add it to my list of fixes for QEMU4.0

Thanks,=20

C.=20

=20
