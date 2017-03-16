Received: from eggs.gnu.org ([2001:4830:134:3::10]:47030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coVpZ-0008Ej-Nn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coVpV-0006Kn-SQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:52:41 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:55150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1coVpV-0006I0-Bh
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 09:52:37 -0400
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B114D62500
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 14:52:22 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-7-git-send-email-clg@kaod.org>
	<20170315061630.GF12603@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b6948010-fe70-0fa9-89fc-ce8061b7c119@kaod.org>
Date: Thu, 16 Mar 2017 14:52:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170315061630.GF12603@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 6/8] ppc/pnv: Add cut down PSI
 bridge model and hookup external interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 03/15/2017 07:16 AM, David Gibson wrote:
> On Wed, Mar 08, 2017 at 11:52:49AM +0100, C=E9dric Le Goater wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>
>> The PSI (Processor Service Interface) Controller is one of the engines
>> of the "Bridge" unit which connects the different interfaces to the
>> Power Processor.
>>
>> This adds just enough of the PSI bridge to handle various on-chip and
>> the one external interrupt. The rest of PSI has to do with the link to
>> the IBM FSP service processor which we don't plan to emulate (not used
>> on OpenPower machines).
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> [clg: - updated for qemu-2.9
>>       - changed the XSCOM interface to fit new model
>>       - QOMified the model
>>       - reworked set_xive and worked around a skiboot bug
>>       - removed the 'psi_mmio_to_xscom' mapping array ]
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/Makefile.objs       |   2 +-
>>  hw/ppc/pnv.c               |  35 ++-
>>  hw/ppc/pnv_psi.c           | 583 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/pnv.h       |   8 +
>>  include/hw/ppc/pnv_psi.h   |  61 +++++
>>  include/hw/ppc/pnv_xscom.h |   3 +
>>  6 files changed, 685 insertions(+), 7 deletions(-)
>>  create mode 100644 hw/ppc/pnv_psi.c
>>  create mode 100644 include/hw/ppc/pnv_psi.h
>>
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 001293423c8d..dc19ee17fa57 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o=
 spapr_rtas.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_=
rng.o
>>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
>>  # IBM PowerNV
>> -obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o
>> +obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o
>>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>>  obj-y +=3D spapr_pci_vfio.o
>>  endif
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 0ae11cc3a2ca..85b00bf235c6 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -356,15 +356,22 @@ static void ppc_powernv_reset(void)
>>   * have a CPLD that will collect the SerIRQ and shoot them as a
>>   * single level interrupt to the P8 chip. So let's setup a hook
>>   * for doing just that.
>> - *
>> - * Note: The actual interrupt input isn't emulated yet, this will
>> - * come with the PSI bridge model.
>>   */
>>  static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int lev=
el)
>>  {
>> -    /* We don't yet emulate the PSI bridge which provides the externa=
l
>> -     * interrupt, so just drop interrupts on the floor
>> -     */
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
>> +    uint32_t old_state =3D pnv->cpld_irqstate;
>> +    PnvChip *chip =3D opaque;
>> +
>> +    if (level) {
>> +        pnv->cpld_irqstate |=3D 1u << n;
>> +    } else {
>> +        pnv->cpld_irqstate &=3D ~(1u << n);
>> +    }
>> +    if (pnv->cpld_irqstate !=3D old_state) {
>> +        pnv_psi_irq_set(&chip->psi, PSIHB_IRQ_EXTERNAL,
>> +                        pnv->cpld_irqstate !=3D 0);
>> +    }
>>  }
>> =20
>>  static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
>> @@ -702,6 +709,11 @@ static void pnv_chip_init(Object *obj)
>> =20
>>      object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
>>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
>> +
>> +    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
>> +    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
>> +    object_property_add_const_link(OBJECT(&chip->psi), "xics",
>> +                                   OBJECT(qdev_get_machine()), &error=
_abort);
>>  }
>> =20
>>  static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
>> @@ -722,6 +734,8 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
>>      char *typename =3D pnv_core_typename(pcc->cpu_model);
>>      size_t typesize =3D object_type_get_instance_size(typename);
>>      int i, core_hwid;
>> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>> +    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
>> =20
>>      if (!object_class_by_name(typename)) {
>>          error_setg(errp, "Unable to find PowerNV CPU Core '%s'", type=
name);
>> @@ -797,6 +811,15 @@ static void pnv_chip_realize(DeviceState *dev, Er=
ror **errp)
>>      }
>>      g_free(typename);
>> =20
>> +
>> +    /* Processor Service Interface (PSI) Host Bridge */
>> +    object_property_set_bool(OBJECT(&chip->psi), true, "realized",
>> +                             &error_fatal);
>> +    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSI_BASE, &chip->psi.xsco=
m_regs);
>> +
>> +    /* link in the PSI ICS */
>> +    QLIST_INSERT_HEAD(&pnv->ics, &chip->psi.ics, list);
>> +
>>      /* Create LPC controller */
>>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>>                               &error_fatal);
>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>> new file mode 100644
>> index 000000000000..6ba688aac075
>> --- /dev/null
>> +++ b/hw/ppc/pnv_psi.c
>> @@ -0,0 +1,583 @@
>> +/*
>> + * QEMU PowerNV PowerPC PSI interface
>> + *
>> + * Copyright (c) 2016, IBM Corporation
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/l=
icenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/hw.h"
>> +#include "target/ppc/cpu.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +
>> +#include "exec/address-spaces.h"
>> +
>> +#include "hw/ppc/fdt.h"
>> +#include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/pnv_psi.h"
>> +
>> +#include <libfdt.h>
>> +
>> +#define PSIHB_XSCOM_FIR_RW      0x00
>> +#define PSIHB_XSCOM_FIR_AND     0x01
>> +#define PSIHB_XSCOM_FIR_OR      0x02
>> +#define PSIHB_XSCOM_FIRMASK_RW  0x03
>> +#define PSIHB_XSCOM_FIRMASK_AND 0x04
>> +#define PSIHB_XSCOM_FIRMASK_OR  0x05
>> +#define PSIHB_XSCOM_FIRACT0     0x06
>> +#define PSIHB_XSCOM_FIRACT1     0x07
>> +#define PSIHB_XSCOM_BAR         0x0a
>> +#define   PSIHB_BAR_EN                  0x0000000000000001ull
>> +#define PSIHB_XSCOM_FSPBAR      0x0b
>> +#define PSIHB_XSCOM_CR          0x0e
>> +#define   PSIHB_CR_FSP_CMD_ENABLE       0x8000000000000000ull
>> +#define   PSIHB_CR_FSP_MMIO_ENABLE      0x4000000000000000ull
>> +#define   PSIHB_CR_FSP_IRQ_ENABLE       0x1000000000000000ull
>> +#define   PSIHB_CR_FSP_ERR_RSP_ENABLE   0x0800000000000000ull
>> +#define   PSIHB_CR_PSI_LINK_ENABLE      0x0400000000000000ull
>> +#define   PSIHB_CR_FSP_RESET            0x0200000000000000ull
>> +#define   PSIHB_CR_PSIHB_RESET          0x0100000000000000ull
>> +#define   PSIHB_CR_PSI_IRQ              0x0000800000000000ull
>> +#define   PSIHB_CR_FSP_IRQ              0x0000400000000000ull
>> +#define   PSIHB_CR_FSP_LINK_ACTIVE      0x0000200000000000ull
>> +          /* and more ... */
>> +#define PSIHB_XSCOM_SEMR        0x0f
>> +#define PSIHB_XSCOM_XIVR_PSI    0x10
>> +#define   PSIHB_XIVR_SERVER_SH  40
>> +#define   PSIHB_XIVR_SERVER_MSK (0xffffull << PSIHB_XIVR_SERVER_SH)
>> +#define   PSIHB_XIVR_PRIO_SH    32
>> +#define   PSIHB_XIVR_PRIO_MSK   (0xffull << PSIHB_XIVR_PRIO_SH)
>> +#define   PSIHB_XIVR_SRC_SH             29
>> +#define   PSIHB_XIVR_SRC_MSK    (0x7ull << PSIHB_XIVR_SRC_SH)
>> +#define   PSIHB_XIVR_PENDING    0x01000000ull
>> +#define PSIHB_XSCOM_SCR         0x12
>> +#define PSIHB_XSCOM_CCR         0x13
>> +#define PSIHB_XSCOM_DMA_UPADD   0x14
>> +#define PSIHB_XSCOM_IRQ_STAT    0x15
>> +#define  PSIHB_IRQ_STAT_OCC             0x0000001000000000ull
>> +#define  PSIHB_IRQ_STAT_FSI             0x0000000800000000ull
>> +#define  PSIHB_IRQ_STAT_LPCI2C          0x0000000400000000ull
>> +#define  PSIHB_IRQ_STAT_LOCERR          0x0000000200000000ull
>> +#define  PSIHB_IRQ_STAT_EXT             0x0000000100000000ull
>> +#define PSIHB_XSCOM_XIVR_OCC    0x16
>> +#define PSIHB_XSCOM_XIVR_FSI    0x17
>> +#define PSIHB_XSCOM_XIVR_LPCI2C 0x18
>> +#define PSIHB_XSCOM_XIVR_LOCERR 0x19
>> +#define PSIHB_XSCOM_XIVR_EXT    0x1a
>> +#define PSIHB_XSCOM_IRSN        0x1b
>> +#define   PSIHB_IRSN_COMP_SH            45
>> +#define   PSIHB_IRSN_COMP_MSK           (0x7ffffull << PSIHB_IRSN_COM=
P_SH)
>> +#define   PSIHB_IRSN_IRQ_MUX            0x0000000800000000ull
>> +#define   PSIHB_IRSN_IRQ_RESET          0x0000000400000000ull
>> +#define   PSIHB_IRSN_DOWNSTREAM_EN      0x0000000200000000ull
>> +#define   PSIHB_IRSN_UPSTREAM_EN        0x0000000100000000ull
>> +#define   PSIHB_IRSN_COMPMASK_SH        13
>> +#define   PSIHB_IRSN_COMPMASK_MSK       (0x7ffffull << PSIHB_IRSN_COM=
PMASK_SH)
>> +
>> +/*
>> + * These are the values of the registers when accessed through the
>> + * MMIO region. The relation is xscom =3D (mmio + 0x50) >> 3
>> + */
>> +#define PSIHB_MMIO_BAR          0x00
>> +#define PSIHB_MMIO_FSPBAR       0x08
>> +#define PSIHB_MMIO_CR           0x20
>> +#define PSIHB_MMIO_SEMR         0x28
>> +#define PSIHB_MMIO_XIVR_PSI     0x30
>> +#define PSIHB_MMIO_SCR          0x40
>> +#define PSIHB_MMIO_CCR          0x48
>> +#define PSIHB_MMIO_DMA_UPADD    0x50
>> +#define PSIHB_MMIO_IRQ_STAT     0x58
>> +#define PSIHB_MMIO_XIVR_OCC     0x60
>> +#define PSIHB_MMIO_XIVR_FSI     0x68
>> +#define PSIHB_MMIO_XIVR_LPCI2C  0x70
>> +#define PSIHB_MMIO_XIVR_LOCERR  0x78
>> +#define PSIHB_MMIO_XIVR_EXT     0x80
>> +#define PSIHB_MMIO_IRSN         0x88
>> +#define PSIHB_MMIO_MAX          0x100
>> +
>> +static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>> +{
>> +    MemoryRegion *sysmem =3D get_system_memory();
>> +    uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
>> +
>> +    psi->regs[PSIHB_XSCOM_BAR] =3D bar & 0x0003fffffff00001;
>> +
>> +    /* Update MR, always remove it first */
>> +    if (old & PSIHB_BAR_EN) {
>> +        memory_region_del_subregion(sysmem, &psi->regs_mr);
>> +    }
>> +    /* Then add it back if needed */
>> +    if (bar & PSIHB_BAR_EN) {
>> +        uint64_t addr =3D bar & 0x0003fffffff00000;
>> +        memory_region_add_subregion(sysmem, addr, &psi->regs_mr);
>> +    }
>> +}
>> +
>> +static void pnv_psi_update_fsp_mr(PnvPsi *psi)
>> +{
>> +    /* XXX Update FSP MR if/when we support FSP BAR */
>> +}
>> +
>> +static void pnv_psi_set_cr(PnvPsi *psi, uint64_t cr)
>> +{
>> +    uint64_t old =3D psi->regs[PSIHB_XSCOM_CR];
>> +
>> +    psi->regs[PSIHB_XSCOM_CR] =3D cr & 0x0003ffff00000000;
>> +
>> +    /* Check some bit changes */
>> +    if ((old ^ psi->regs[PSIHB_XSCOM_CR]) & PSIHB_CR_FSP_MMIO_ENABLE)=
 {
>> +        pnv_psi_update_fsp_mr(psi);
>> +    }
>> +}
>> +
>> +static void pnv_psi_set_irsn(PnvPsi *psi, uint64_t val)
>> +{
>> +    uint32_t offset;
>> +    ICSState *ics =3D &psi->ics;
>> +
>> +    /* In this model we ignore the up/down enable bits for now
>> +     * as SW doesn't use them (other than setting them at boot).
>> +     * We ignore IRQ_MUX, its meaning isn't clear and we don't use
>> +     * it and finally we ignore reset (XXX fix that ?)
>> +     */
>> +    psi->regs[PSIHB_XSCOM_IRSN] =3D val & (PSIHB_IRSN_COMP_MSK |
>> +                                         PSIHB_IRSN_IRQ_MUX |
>> +                                         PSIHB_IRSN_DOWNSTREAM_EN |
>> +                                         PSIHB_IRSN_DOWNSTREAM_EN |
>> +                                         PSIHB_IRSN_DOWNSTREAM_EN);
>> +
>> +    /* We ignore the compare mask as well, our ICS emulation is too
>> +     * simplistic to make any use if it, and we extract the offset
>> +     * from the compare value
>> +     */
>> +    offset =3D (val & PSIHB_IRSN_COMP_MSK) >> PSIHB_IRSN_COMP_SH;
>> +    ics->offset =3D offset;
>> +}
>> +
>> +static bool pnv_psi_irq_bits(PnvPsi *psi, PnvPsiIrq irq,
>> +                             uint32_t *out_xivr_reg,
>> +                             uint32_t *out_stat_reg,
>> +                             uint64_t *out_stat_bit)
>=20
> Your PnvPsiIrq values are arbitrary and contiguous AFACT.  Why not
> just have a lookup table for this info, instead of a giant switch
> statement?

Well, I agree but at the same time, we are not gaining much in terms
of lines by using an array, and we have to check for boundaries which
the switch provide. The question would be different if we had more=20
parameters. So let's keep it that way.=20
=20
>> +{
>> +    switch (irq) {
>> +    case PSIHB_IRQ_PSI:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_PSI;
>> +        *out_stat_reg =3D PSIHB_XSCOM_CR;
>> +        *out_stat_bit =3D PSIHB_CR_PSI_IRQ;
>> +        break;
>> +    case PSIHB_IRQ_FSP:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_PSI;
>> +        *out_stat_reg =3D PSIHB_XSCOM_CR;
>> +        *out_stat_bit =3D PSIHB_CR_FSP_IRQ;
>> +        break;
>> +    case PSIHB_IRQ_OCC:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_OCC;
>> +        *out_stat_reg =3D PSIHB_XSCOM_IRQ_STAT;
>> +        *out_stat_bit =3D PSIHB_IRQ_STAT_OCC;
>> +        break;
>> +    case PSIHB_IRQ_FSI:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_FSI;
>> +        *out_stat_reg =3D PSIHB_XSCOM_IRQ_STAT;
>> +        *out_stat_bit =3D PSIHB_IRQ_STAT_FSI;
>> +        break;
>> +    case PSIHB_IRQ_LPC_I2C:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_LPCI2C;
>> +        *out_stat_reg =3D PSIHB_XSCOM_IRQ_STAT;
>> +        *out_stat_bit =3D PSIHB_IRQ_STAT_LPCI2C;
>> +        break;
>> +    case PSIHB_IRQ_LOCAL_ERR:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_LOCERR;
>> +        *out_stat_reg =3D PSIHB_XSCOM_IRQ_STAT;
>> +        *out_stat_bit =3D PSIHB_IRQ_STAT_LOCERR;
>> +        break;
>> +    case PSIHB_IRQ_EXTERNAL:
>> +        *out_xivr_reg =3D PSIHB_XSCOM_XIVR_EXT;
>> +        *out_stat_reg =3D PSIHB_XSCOM_IRQ_STAT;
>> +        *out_stat_bit =3D PSIHB_IRQ_STAT_EXT;
>> +        break;
>> +    default:
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
>> +{
>> +    ICSState *ics =3D &psi->ics;
>> +    uint32_t xivr_reg;
>> +    uint32_t stat_reg;
>> +    uint64_t stat_bit;
>> +    uint32_t src;
>> +    bool masked;
>> +
>> +    if (!pnv_psi_irq_bits(psi, irq, &xivr_reg, &stat_reg, &stat_bit))=
 {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", i=
rq);
>> +        return;
>> +    }
>> +
>> +    src =3D (psi->regs[xivr_reg] & PSIHB_XIVR_SRC_MSK) >> PSIHB_XIVR_=
SRC_SH;
>> +    masked =3D (psi->regs[xivr_reg] & PSIHB_XIVR_PRIO_MSK) =3D=3D PSI=
HB_XIVR_PRIO_MSK;
>> +    if (state) {
>> +        psi->regs[stat_reg] |=3D stat_bit;
>> +        /* XXX optimization: check mask here. That means re-evaluatin=
g
>> +         * when unmasking, thus TODO
>> +         */
>> +        qemu_irq_raise(ics->qirqs[src]);
>> +    } else {
>> +        psi->regs[stat_reg] &=3D ~stat_bit;
>> +
>> +        /* FSP and PSI are muxed so don't lower if either still set *=
/
>> +        if (stat_reg !=3D PSIHB_XSCOM_CR ||
>> +            !(psi->regs[stat_reg] & (PSIHB_CR_PSI_IRQ | PSIHB_CR_FSP_=
IRQ))) {
>> +            qemu_irq_lower(ics->qirqs[src]);
>> +        } else {
>> +            state =3D true;
>> +        }
>> +    }
>=20
> It might be cleaner to just revaluate the irq level from scratch here,
> and set the level, rather than doing this complicated dance to work
> out if it has changed.

OK. I need to take a closer look at that.

>> +
>> +    /* XXX Note about the emulation of the pending bit: This isn't
>> +     * entirely correct. The pending bit should be cleared when the
>> +     * EOI has been received. However, we don't have callbacks on
>> +     * EOI (especially not under KVM) so no way to emulate that
>> +     * properly, so instead we just set that bit as the logical
>> +     * "output" of the XIVR (ie pending & !masked)
>> +     * XXX TODO: Also update it on set_xivr
>> +     */
>> +    if (state && !masked) {
>> +        psi->regs[xivr_reg] |=3D PSIHB_XIVR_PENDING;
>> +    } else {
>> +        psi->regs[xivr_reg] &=3D ~PSIHB_XIVR_PENDING;
>> +    }
>> +}
>> +
>> +static void pnv_psi_set_xivr(PnvPsi *psi, uint32_t reg, uint64_t val)
>> +{
>> +    ICSState *ics =3D &psi->ics;
>> +    uint16_t server;
>> +    uint8_t prio;
>> +    uint8_t src;
>> +    int icp_index;
>> +
>> +    psi->regs[reg] =3D (psi->regs[reg] & PSIHB_XIVR_PENDING) |
>> +            (val & (PSIHB_XIVR_SERVER_MSK |
>> +                    PSIHB_XIVR_PRIO_MSK |
>> +                    PSIHB_XIVR_SRC_MSK));
>> +    val =3D psi->regs[reg];
>> +    server =3D (val & PSIHB_XIVR_SERVER_MSK) >> PSIHB_XIVR_SERVER_SH;
>> +    prio =3D (val & PSIHB_XIVR_PRIO_MSK) >> PSIHB_XIVR_PRIO_SH;
>> +    src =3D (val & PSIHB_XIVR_SRC_MSK) >> PSIHB_XIVR_SRC_SH;
>> +    if (src > PSIHB_IRQ_EXTERNAL) {
>> +        /* XXX Generate error ? */
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Linux fills the irq xivr with the hw processor id plus the
>> +     * link bits. shift back to get something valid.
>> +     */
>> +    server >>=3D 2;
>> +
>> +    /*
>> +     * When skiboot initializes PSIHB, it fills the xives with
>> +     * server=3D0, prio=3D0xff, but we don't have a CPU with a pir=3D=
0. So
>> +     * skip that case.
>> +     */
>> +    if (prio !=3D 0xff) {
>> +        icp_index =3D xics_get_cpu_index_by_pir(server);
>> +        assert(icp_index !=3D -1);
>> +    } else {
>> +        if (server) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "PSI: bogus server %d for =
IRQ %d\n",
>> +                          server, src);
>> +        }
>> +        icp_index =3D server;
>> +    }
>=20
> This logic doesn't seem like it belongs here.  You've received a
> server number, seems like you should just pass it on to the xics code,
> and if there can be an error, have that detect it.

I have removed all of that in a private patch. This is tracking=20
an issue in skiboot which did not clear correctly the PSI xive.=20
It is partially resolved in recent version but I still see some=20
warnings whe the guest reboots.

>> +
>> +    /* Now because of source remapping, weird things can happen
>> +     * if you change the source number dynamically, our simple ICS
>> +     * doesn't deal with remapping. So we just poke a different
>> +     * ICS entry based on what source number was written. This will
>> +     * do for now but a more accurate implementation would instead
>> +     * use a fixed server/prio and a remapper of the generated irq.
>> +     */
>> +    ics_simple_write_xive(ics, src, icp_index, prio, prio);
>> +}
>> +
>> +static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_t offset, bool m=
mio)
>> +{
>> +    uint64_t val =3D 0xffffffffffffffffull;
>> +
>> +    switch (offset) {
>> +    case PSIHB_XSCOM_FIR_RW:
>> +    case PSIHB_XSCOM_FIRACT0:
>> +    case PSIHB_XSCOM_FIRACT1:
>> +    case PSIHB_XSCOM_BAR:
>> +    case PSIHB_XSCOM_FSPBAR:
>> +    case PSIHB_XSCOM_CR:
>> +    case PSIHB_XSCOM_XIVR_PSI:
>> +    case PSIHB_XSCOM_XIVR_OCC:
>> +    case PSIHB_XSCOM_XIVR_FSI:
>> +    case PSIHB_XSCOM_XIVR_LPCI2C:
>> +    case PSIHB_XSCOM_XIVR_LOCERR:
>> +    case PSIHB_XSCOM_XIVR_EXT:
>> +    case PSIHB_XSCOM_IRQ_STAT:
>> +    case PSIHB_XSCOM_SEMR:
>> +    case PSIHB_XSCOM_DMA_UPADD:
>> +    case PSIHB_XSCOM_IRSN:
>> +        val =3D psi->regs[offset];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "PSI Unimplemented register: Ox%" PR=
Ix32 "\n",
>> +                      offset);
>=20
> As noted elsewhere, tracepoints are more usual than qemu_log() these
> days.  But either way, this really should have a distinguishable
> message from the one in the write path.

OK. Will add a read/write statement.=20

>> +    }
>> +    return val;
>> +}
>> +
>> +static void pnv_psi_reg_write(PnvPsi *psi, uint32_t offset, uint64_t =
val,
>> +                              bool mmio)
>> +{
>> +    switch (offset) {
>> +    case PSIHB_XSCOM_FIR_RW:
>> +    case PSIHB_XSCOM_FIRACT0:
>> +    case PSIHB_XSCOM_FIRACT1:
>> +    case PSIHB_XSCOM_SEMR:
>> +    case PSIHB_XSCOM_DMA_UPADD:
>> +        psi->regs[offset] =3D val;
>> +        break;
>> +    case PSIHB_XSCOM_FIR_OR:
>> +        psi->regs[PSIHB_XSCOM_FIR_RW] |=3D val;
>> +        break;
>> +    case PSIHB_XSCOM_FIR_AND:
>> +        psi->regs[PSIHB_XSCOM_FIR_RW] &=3D val;
>> +        break;
>> +    case PSIHB_XSCOM_BAR:
>> +        /* Only XSCOM can write this one */
>> +        if (!mmio) {
>> +            pnv_psi_set_bar(psi, val);
>> +        }
>> +        break;
>> +    case PSIHB_XSCOM_FSPBAR:
>> +        psi->regs[PSIHB_XSCOM_BAR] =3D val & 0x0003ffff00000000;
>=20
> Should that be PSIHB_XSCOM_FSPBAR?

yes ...

>> +        pnv_psi_update_fsp_mr(psi);
>> +        break;
>> +    case PSIHB_XSCOM_CR:
>> +        pnv_psi_set_cr(psi, val);
>> +        break;
>> +    case PSIHB_XSCOM_SCR:
>> +        pnv_psi_set_cr(psi, psi->regs[PSIHB_XSCOM_CR] | val);
>> +        break;
>> +    case PSIHB_XSCOM_CCR:
>> +        pnv_psi_set_cr(psi, psi->regs[PSIHB_XSCOM_CR] & ~val);
>> +        break;
>> +    case PSIHB_XSCOM_XIVR_PSI:
>> +    case PSIHB_XSCOM_XIVR_OCC:
>> +    case PSIHB_XSCOM_XIVR_FSI:
>> +    case PSIHB_XSCOM_XIVR_LPCI2C:
>> +    case PSIHB_XSCOM_XIVR_LOCERR:
>> +    case PSIHB_XSCOM_XIVR_EXT:
>> +        pnv_psi_set_xivr(psi, offset, val);
>> +        break;
>> +    case PSIHB_XSCOM_IRQ_STAT:
>> +        /* Read only, should we generate an error ? */
>> +        break;
>> +    case PSIHB_XSCOM_IRSN:
>> +        pnv_psi_set_irsn(psi, val);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "PSI Unimplemented register: Ox%" PR=
Ix32 "\n",
>> +                      offset);
>> +    }
>> +}
>> +
>> +static inline uint32_t psi_mmio_to_xscom(hwaddr addr)
>> +{
>> +    return (addr >> 3) + PSIHB_XSCOM_BAR;
>> +}
>> +
>> +static uint64_t pnv_psi_mmio_read(void *opaque, hwaddr addr, unsigned=
 size)
>> +{
>> +    return pnv_psi_reg_read(opaque, psi_mmio_to_xscom(addr), true);
>> +}
>> +
>> +static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
>> +                              uint64_t val, unsigned size)
>> +{
>> +    pnv_psi_reg_write(opaque, psi_mmio_to_xscom(addr), val, true);
>> +}
>> +
>> +static const MemoryRegionOps psi_mmio_ops =3D {
>> +    .read =3D pnv_psi_mmio_read,
>> +    .write =3D pnv_psi_mmio_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_psi_xscom_read(void *opaque, hwaddr addr, unsigne=
d size)
>> +{
>> +    PnvPsi *psi =3D PNV_PSI(opaque);
>> +    uint32_t offset =3D addr >> 3;
>> +
>> +    return pnv_psi_reg_read(psi, offset, false);
>> +}
>> +
>> +static void pnv_psi_xscom_write(void *opaque, hwaddr addr,
>> +                                uint64_t val, unsigned size)
>> +{
>> +    PnvPsi *psi =3D PNV_PSI(opaque);
>> +    uint32_t offset =3D addr >> 3;
>> +
>> +    pnv_psi_reg_write(psi, offset, val, false);
>> +}
>> +
>> +static const MemoryRegionOps pnv_psi_xscom_ops =3D {
>> +    .read =3D pnv_psi_xscom_read,
>> +    .write =3D pnv_psi_xscom_write,
>> +    .valid.min_access_size =3D 8,
>> +    .valid.max_access_size =3D 8,
>> +    .impl.min_access_size =3D 8,
>> +    .impl.max_access_size =3D 8,
>=20
> Consistent nesting format of the two MemoryRegionOps would be good.

OK.
=20
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void pnv_psi_init(Object *obj)
>> +{
>> +    PnvPsi *psi =3D PNV_PSI(obj);
>> +
>> +    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
>> +    qdev_set_parent_bus(DEVICE(&psi->ics), sysbus_get_default());
>> +    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL=
);
>> +}
>> +
>> +static void pnv_psi_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvPsi *psi =3D PNV_PSI(dev);
>> +    ICSState *ics =3D &psi->ics;
>> +    Object *obj;
>> +    Error *err =3D NULL, *local_err =3D NULL;
>> +    unsigned int i;
>> +
>> +    /* Initialize MMIO region */
>> +    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, =
psi,
>> +                          "psihb", PNV_PSIHB_BAR_SIZE);
>> +
>> +    /* Default BAR. Use object properties ? */
>> +    pnv_psi_set_bar(psi, PNV_PSIHB_BAR | PSIHB_BAR_EN);
>> +
>> +    /* Default sources in XIVR */
>> +    psi->regs[PSIHB_XSCOM_XIVR_PSI] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (0ull << PSIHB_XIVR_SRC_SH);
>> +    psi->regs[PSIHB_XSCOM_XIVR_OCC] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (1ull << PSIHB_XIVR_SRC_SH);
>> +    psi->regs[PSIHB_XSCOM_XIVR_FSI] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (2ull << PSIHB_XIVR_SRC_SH);
>> +    psi->regs[PSIHB_XSCOM_XIVR_LPCI2C] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (3ull << PSIHB_XIVR_SRC_SH);
>> +    psi->regs[PSIHB_XSCOM_XIVR_LOCERR] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (4ull << PSIHB_XIVR_SRC_SH);
>> +    psi->regs[PSIHB_XSCOM_XIVR_EXT] =3D PSIHB_XIVR_PRIO_MSK |
>> +            (5ull << PSIHB_XIVR_SRC_SH);
>> +
>> +    /* get XICSFabric from chip */
>> +    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
>> +    if (!obj) {
>> +        error_setg(errp, "%s: required link 'xics' not found: %s",
>> +                   __func__, error_get_pretty(err));
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * PSI interrupt control source
>> +     */
>> +    object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs=
", &err);
>> +    object_property_add_const_link(OBJECT(ics), "xics", obj, &err);
>> +    object_property_set_bool(OBJECT(ics), true, "realized",  &local_e=
rr);
>> +    error_propagate(&err, local_err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>> +    for (i =3D 0; i < ics->nr_irqs; i++) {
>> +        ics_set_irq_type(ics, i, true);
>> +    }
>> +
>> +    /* XScom region for PSI registers */
>> +    pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xsc=
om_ops,
>> +                psi, "xscom-psi", PNV_XSCOM_PSI_SIZE);
>> +}
>> +
>> +static int pnv_psi_populate(PnvXScomInterface *dev, void *fdt, int xs=
com_offset)
>> +{
>> +    const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
>> +    char *name;
>> +    int offset;
>> +    uint32_t lpc_pcba =3D PNV_XSCOM_PSI_BASE;
>> +    uint32_t reg[] =3D {
>> +        cpu_to_be32(lpc_pcba),
>> +        cpu_to_be32(PNV_XSCOM_PSI_SIZE)
>> +    };
>> +
>> +    name =3D g_strdup_printf("psihb@%x", lpc_pcba);
>> +    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
>> +    _FDT(offset);
>> +    g_free(name);
>> +
>> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
>> +
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
>> +    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
>> +    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
>> +                      sizeof(compat))));
>> +    return 0;
>> +}
>> +
>> +
>> +static void pnv_psi_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
>> +
>> +    xdc->populate =3D pnv_psi_populate;
>> +
>> +    dc->realize =3D pnv_psi_realize;
>> +}
>> +
>> +static const TypeInfo pnv_psi_info =3D {
>> +    .name          =3D TYPE_PNV_PSI,
>> +    .parent        =3D TYPE_DEVICE,
>=20
> Since the PSI has an MMIO presence, it probably should be a
> SysBusDevice, rather than a raw descendent of TYPE_DEVICE.

Yes indeed.=20

So I will resend the patchset with just the XICS part. I want to=20
take a look at pnv_psi_irq_set() first.

Thanks,

C.=20

>> +    .instance_size =3D sizeof(PnvPsi),
>> +    .instance_init =3D pnv_psi_init,
>> +    .class_init    =3D pnv_psi_class_init,
>> +    .interfaces    =3D (InterfaceInfo[]) {
>> +        { TYPE_PNV_XSCOM_INTERFACE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pnv_psi_register_types(void)
>> +{
>> +    type_register_static(&pnv_psi_info);
>> +}
>> +
>> +type_init(pnv_psi_register_types)
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index f11215ea31f2..f93ec32603b7 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -23,6 +23,7 @@
>>  #include "hw/sysbus.h"
>>  #include "hw/ppc/pnv_lpc.h"
>>  #include "hw/ppc/xics.h"
>> +#include "hw/ppc/pnv_psi.h"
>> =20
>>  #define TYPE_PNV_CHIP "powernv-chip"
>>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
>> @@ -58,6 +59,7 @@ typedef struct PnvChip {
>>      MemoryRegion icp_mmio;
>> =20
>>      PnvLpcController lpc;
>> +    PnvPsi       psi;
>>  } PnvChip;
>> =20
>>  typedef struct PnvChipClass {
>> @@ -119,6 +121,8 @@ typedef struct PnvMachineState {
>>      ICPState     *icps;
>>      uint32_t     nr_servers;
>>      QLIST_HEAD(, ICSState) ics;
>> +
>> +    uint32_t     cpld_irqstate;
>>  } PnvMachineState;
>> =20
>>  #define PNV_FDT_ADDR          0x01000000
>> @@ -150,4 +154,8 @@ typedef struct PnvMachineState {
>>  #define PNV_ICP_BASE(chip)   0x0003ffff80000000ull
>>  #define PNV_ICP_SIZE         0x0000000000100000ull
>> =20
>> +#define PNV_PSIHB_BAR         0x0003fffe80000000ull
>> +#define PNV_PSIHB_BAR_SIZE    0x0000000000100000ull
>> +
>> +
>>  #endif /* _PPC_PNV_H */
>> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
>> new file mode 100644
>> index 000000000000..ac3c5f8362e3
>> --- /dev/null
>> +++ b/include/hw/ppc/pnv_psi.h
>> @@ -0,0 +1,61 @@
>> +/*
>> + * QEMU PowerPC PowerNV PSI controller
>> + *
>> + * Copyright (c) 2016, IBM Corporation.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/l=
icenses/>.
>> + */
>> +#ifndef _PPC_PNV_PSI_H
>> +#define _PPC_PNV_PSI_H
>> +
>> +#define TYPE_PNV_PSI "pnv-psi"
>> +#define PNV_PSI(obj) \
>> +     OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI)
>> +
>> +#define PSIHB_XSCOM_MAX         0x20
>> +
>> +typedef struct XICSState XICSState;
>> +
>> +typedef struct PnvPsi {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion regs_mr;
>> +
>> +    /* FSP region not supported */
>> +    /* MemoryRegion fsp_mr; */
>> +
>> +    /* Interrupt generation */
>> +    ICSState ics;
>> +
>> +    /* Registers */
>> +    uint64_t regs[PSIHB_XSCOM_MAX];
>> +
>> +    MemoryRegion xscom_regs;
>> +} PnvPsi;
>> +
>> +typedef enum PnvPsiIrq {
>> +    PSIHB_IRQ_PSI, /* internal use only */
>> +    PSIHB_IRQ_FSP, /* internal use only */
>> +    PSIHB_IRQ_OCC,
>> +    PSIHB_IRQ_FSI,
>> +    PSIHB_IRQ_LPC_I2C,
>> +    PSIHB_IRQ_LOCAL_ERR,
>> +    PSIHB_IRQ_EXTERNAL,
>> +} PnvPsiIrq;
>> +
>> +#define PSI_NUM_INTERRUPTS 6
>> +
>> +extern void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state);
>> +
>> +#endif /* _PPC_PNV_PSI_H */
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 0faa1847bf13..2938abd74955 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -60,6 +60,9 @@ typedef struct PnvXScomInterfaceClass {
>>  #define PNV_XSCOM_LPC_BASE        0xb0020
>>  #define PNV_XSCOM_LPC_SIZE        0x4
>> =20
>> +#define PNV_XSCOM_PSI_BASE        0x2010900
>> +#define PNV_XSCOM_PSI_SIZE        0x20
>> +
>>  extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
>>  extern int pnv_xscom_populate(PnvChip *chip, void *fdt, int offset);
>> =20
>=20
