Received: from eggs.gnu.org ([2001:4830:134:3::10]:42093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dqL3L-0006ot-Qe
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dqL3I-0000xX-Sx
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:18:43 -0400
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-6-git-send-email-eric.auger@redhat.com>
	<20170908105214.GA16412@virtx40>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f569ace6-d8e8-b1db-6acc-0309c5b21960@redhat.com>
Date: Fri, 8 Sep 2017 17:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170908105214.GA16412@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 05/20] hw/arm/smmuv3: Skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, jean-philippe.brucker@arm.com, tn@semihalf.com, bharat.bhushan@nxp.com, mst@redhat.com, will.deacon@arm.com, qemu-devel@nongnu.org, peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org, christoffer.dall@linaro.org, linu.cherian@cavium.com, wtownsen@redhat.com, robin.murphy@arm.com, prem.mallappa@gmail.com, eric.auger.pro@gmail.com

Hi Linu,

On 08/09/2017 12:52, Linu Cherian wrote:
> Hi Eric,
> 
> On Fri Sep 01, 2017 at 07:21:08PM +0200, Eric Auger wrote:
>> From: Prem Mallappa <prem.mallappa@broadcom.com>
>>
>> This patch implements a skeleton for the smmuv3 device.
>> Datatypes and register definitions are introduced. The MMIO
>> region, the interrupts and the queue are initialized (PRI is
>> not supported).
>>
>> Only the MMIO read operation is implemented here.
>>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v6 -> v7:
>> - split into several patches
>>
>> v5 -> v6:
>> - Use IOMMUMemoryregion
>> - regs become uint32_t and fix 64b MMIO access (.impl)
>> - trace_smmuv3_write/read_mmio take the size param
>>
>> v4 -> v5:
>> - change smmuv3_translate proto (IOMMUAccessFlags flag)
>> - has_stagex replaced by is_ste_stagex
>> - smmu_cfg_populate removed
>> - added smmuv3_decode_config and reworked error management
>> - remwork the naming of IOMMU mrs
>> - fix SMMU_CMDQ_CONS offset
>>
>> v3 -> v4
>> - smmu_irq_update
>> - fix hash key allocation
>> - set smmu_iommu_ops
>> - set SMMU_REG_CR0,
>> - smmuv3_translate: ret.perm not set in bypass mode
>> - use trace events
>> - renamed STM2U64 into L1STD_L2PTR and STMSPAN into L1STD_SPAN
>> - rework smmu_find_ste
>> - fix tg2granule in TT0/0b10 corresponds to 16kB
>>
>> v2 -> v3:
>> - move creation of include/hw/arm/smmuv3.h to this patch to fix compil issue
>> - compilation allowed
>> - fix sbus allocation in smmu_init_pci_iommu
>> - restructure code into headers
>> - misc cleanups
>> ---
>>  hw/arm/Makefile.objs     |   2 +-
>>  hw/arm/smmuv3-internal.h | 201 +++++++++++++++++++++++++++++++++++++++
>>  hw/arm/smmuv3.c          | 239 +++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/trace-events      |   3 +
>>  include/hw/arm/smmuv3.h  |  79 ++++++++++++++++
>>  5 files changed, 523 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/smmuv3-internal.h
>>  create mode 100644 hw/arm/smmuv3.c
>>  create mode 100644 include/hw/arm/smmuv3.h
>>
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index 5b2d38d..a7c808b 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -19,4 +19,4 @@ obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
>>  obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
>>  obj-$(CONFIG_MPS2) += mps2.o
>> -obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
>> +obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> new file mode 100644
>> index 0000000..488acc8
>> --- /dev/null
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -0,0 +1,201 @@
>> +/*
>> + * ARM SMMUv3 support - Internal API
>> + *
>> + * Copyright (C) 2014-2016 Broadcom Corporation
>> + * Copyright (c) 2017 Red Hat, Inc.
>> + * Written by Prem Mallappa, Eric Auger
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_ARM_SMMU_V3_INTERNAL_H
>> +#define HW_ARM_SMMU_V3_INTERNAL_H
>> +
>> +#include "trace.h"
>> +#include "qemu/error-report.h"
>> +#include "hw/arm/smmu-common.h"
>> +
>> +/*****************************
>> + * MMIO Register
>> + *****************************/
>> +enum {
>> +    SMMU_REG_IDR0            = 0x0,
>> +
>> +/* IDR0 Field Values and supported features */
>> +
>> +#define SMMU_IDR0_S2P      1  /* stage 2 */
>> +#define SMMU_IDR0_S1P      1  /* stage 1 */
>> +#define SMMU_IDR0_TTF      2  /* Aarch64 only - not Aarch32 (LPAE) */
>> +#define SMMU_IDR0_COHACC   1  /* IO coherent access */
>> +#define SMMU_IDR0_HTTU     2  /* Access and Dirty flag update */
>> +#define SMMU_IDR0_HYP      0  /* Hypervisor Stage 1 contexts */
>> +#define SMMU_IDR0_ATS      0  /* PCIe RC ATS */
>> +#define SMMU_IDR0_ASID16   1  /* 16-bit ASID */
>> +#define SMMU_IDR0_PRI      0  /* Page Request Interface */
>> +#define SMMU_IDR0_VMID16   0  /* 16-bit VMID */
>> +#define SMMU_IDR0_CD2L     0  /* 2-level Context Descriptor table */
>> +#define SMMU_IDR0_STALL    1  /* Stalling fault model */
>> +#define SMMU_IDR0_TERM     1  /* Termination model behaviour */
>> +#define SMMU_IDR0_STLEVEL  1  /* Multi-level Stream Table */
>> +
>> +#define SMMU_IDR0_S2P_SHIFT      0
>> +#define SMMU_IDR0_S1P_SHIFT      1
>> +#define SMMU_IDR0_TTF_SHIFT      2
>> +#define SMMU_IDR0_COHACC_SHIFT   4
>> +#define SMMU_IDR0_HTTU_SHIFT     6
>> +#define SMMU_IDR0_HYP_SHIFT      9
>> +#define SMMU_IDR0_ATS_SHIFT      10
>> +#define SMMU_IDR0_ASID16_SHIFT   12
>> +#define SMMU_IDR0_PRI_SHIFT      16
>> +#define SMMU_IDR0_VMID16_SHIFT   18
>> +#define SMMU_IDR0_CD2L_SHIFT     19
>> +#define SMMU_IDR0_STALL_SHIFT    24
>> +#define SMMU_IDR0_TERM_SHIFT     26
>> +#define SMMU_IDR0_STLEVEL_SHIFT  27
>> +
>> +    SMMU_REG_IDR1            = 0x4,
>> +#define SMMU_IDR1_SIDSIZE 16
>> +    SMMU_REG_IDR2            = 0x8,
>> +    SMMU_REG_IDR3            = 0xc,
>> +    SMMU_REG_IDR4            = 0x10,
>> +    SMMU_REG_IDR5            = 0x14,
>> +#define SMMU_IDR5_GRAN_SHIFT 4
>> +#define SMMU_IDR5_GRAN       0b101 /* GRAN4K, GRAN64K */
>> +#define SMMU_IDR5_OAS        4     /* 44 bits */
>> +    SMMU_REG_IIDR            = 0x1c,
>> +    SMMU_REG_CR0             = 0x20,
>> +
>> +#define SMMU_CR0_SMMU_ENABLE (1 << 0)
>> +#define SMMU_CR0_PRIQ_ENABLE (1 << 1)
>> +#define SMMU_CR0_EVTQ_ENABLE (1 << 2)
>> +#define SMMU_CR0_CMDQ_ENABLE (1 << 3)
>> +#define SMMU_CR0_ATS_CHECK   (1 << 4)
>> +
>> +    SMMU_REG_CR0_ACK         = 0x24,
>> +    SMMU_REG_CR1             = 0x28,
>> +    SMMU_REG_CR2             = 0x2c,
>> +
>> +    SMMU_REG_STATUSR         = 0x40,
>> +
>> +    SMMU_REG_IRQ_CTRL        = 0x50,
>> +    SMMU_REG_IRQ_CTRL_ACK    = 0x54,
>> +
>> +#define SMMU_IRQ_CTRL_GERROR_EN (1 << 0)
>> +#define SMMU_IRQ_CTRL_EVENT_EN  (1 << 1)
>> +#define SMMU_IRQ_CTRL_PRI_EN    (1 << 2)
>> +
>> +    SMMU_REG_GERROR          = 0x60,
>> +
>> +#define SMMU_GERROR_CMDQ           (1 << 0)
>> +#define SMMU_GERROR_EVENTQ_ABT     (1 << 2)
>> +#define SMMU_GERROR_PRIQ_ABT       (1 << 3)
>> +#define SMMU_GERROR_MSI_CMDQ_ABT   (1 << 4)
>> +#define SMMU_GERROR_MSI_EVENTQ_ABT (1 << 5)
>> +#define SMMU_GERROR_MSI_PRIQ_ABT   (1 << 6)
>> +#define SMMU_GERROR_MSI_GERROR_ABT (1 << 7)
>> +#define SMMU_GERROR_SFM_ERR        (1 << 8)
>> +
>> +    SMMU_REG_GERRORN         = 0x64,
>> +    SMMU_REG_GERROR_IRQ_CFG0 = 0x68,
>> +    SMMU_REG_GERROR_IRQ_CFG1 = 0x70,
>> +    SMMU_REG_GERROR_IRQ_CFG2 = 0x74,
>> +
>> +    /* SMMU_BASE_RA Applies to STRTAB_BASE, CMDQ_BASE and EVTQ_BASE */
>> +#define SMMU_BASE_RA        (1ULL << 62)
>> +    SMMU_REG_STRTAB_BASE     = 0x80,
>> +    SMMU_REG_STRTAB_BASE_CFG = 0x88,
>> +
>> +    SMMU_REG_CMDQ_BASE       = 0x90,
>> +    SMMU_REG_CMDQ_PROD       = 0x98,
>> +    SMMU_REG_CMDQ_CONS       = 0x9c,
>> +    /* CMD Consumer (CONS) */
>> +#define SMMU_CMD_CONS_ERR_SHIFT        24
>> +#define SMMU_CMD_CONS_ERR_BITS         7
>> +
>> +    SMMU_REG_EVTQ_BASE       = 0xa0,
>> +    SMMU_REG_EVTQ_PROD       = 0xa8,
>> +    SMMU_REG_EVTQ_CONS       = 0xac,
>> +    SMMU_REG_EVTQ_IRQ_CFG0   = 0xb0,
>> +    SMMU_REG_EVTQ_IRQ_CFG1   = 0xb8,
>> +    SMMU_REG_EVTQ_IRQ_CFG2   = 0xbc,
>> +
>> +    SMMU_REG_PRIQ_BASE       = 0xc0,
>> +    SMMU_REG_PRIQ_PROD       = 0xc8,
>> +    SMMU_REG_PRIQ_CONS       = 0xcc,
>> +    SMMU_REG_PRIQ_IRQ_CFG0   = 0xd0,
>> +    SMMU_REG_PRIQ_IRQ_CFG1   = 0xd8,
>> +    SMMU_REG_PRIQ_IRQ_CFG2   = 0xdc,
>> +
>> +    SMMU_ID_REGS_OFFSET      = 0xfd0,
>> +
>> +    /* Secure registers are not used for now */
>> +    SMMU_SECURE_OFFSET       = 0x8000,
>> +};
>> +
>> +/**********************
>> + * Data Structures
>> + **********************/
>> +
>> +struct __smmu_data2 {
>> +    uint32_t word[2];
>> +};
>> +
>> +struct __smmu_data8 {
>> +    uint32_t word[8];
>> +};
>> +
>> +struct __smmu_data16 {
>> +    uint32_t word[16];
>> +};
>> +
>> +struct __smmu_data4 {
>> +    uint32_t word[4];
>> +};
>> +
>> +typedef struct __smmu_data4  Cmd; /* Command Entry */
>> +typedef struct __smmu_data8  Evt; /* Event Entry */
>> +
>> +/*****************************
>> + *  Register Access Primitives
>> + *****************************/
>> +
>> +static inline void smmu_write32_reg(SMMUV3State *s, uint32_t addr, uint32_t val)
>> +{
>> +    s->regs[addr >> 2] = val;
>> +}
>> +
>> +static inline void smmu_write64_reg(SMMUV3State *s, uint32_t addr, uint64_t val)
>> +{
>> +    addr >>= 2;
>> +    s->regs[addr] = extract64(val, 0, 32);
>> +    s->regs[addr + 1] = extract64(val, 32, 32);
>> +}
>> +
>> +static inline uint32_t smmu_read32_reg(SMMUV3State *s, uint32_t addr)
>> +{
>> +    return s->regs[addr >> 2];
>> +}
>> +
>> +static inline uint64_t smmu_read64_reg(SMMUV3State *s, uint32_t addr)
>> +{
>> +    addr >>= 2;
>> +    return s->regs[addr] | ((uint64_t)(s->regs[addr + 1]) << 32);
>> +}
>> +
>> +static inline int smmu_enabled(SMMUV3State *s)
>> +{
>> +    return smmu_read32_reg(s, SMMU_REG_CR0) & SMMU_CR0_SMMU_ENABLE;
>> +}
>> +
>> +#endif
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> new file mode 100644
>> index 0000000..0a7cd1c
>> --- /dev/null
>> +++ b/hw/arm/smmuv3.c
>> @@ -0,0 +1,239 @@
>> +/*
>> + * Copyright (C) 2014-2016 Broadcom Corporation
>> + * Copyright (c) 2017 Red Hat, Inc.
>> + * Written by Prem Mallappa, Eric Auger
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/boards.h"
>> +#include "sysemu/sysemu.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/pci/pci.h"
>> +#include "exec/address-spaces.h"
>> +#include "trace.h"
>> +#include "qemu/error-report.h"
>> +
>> +#include "hw/arm/smmuv3.h"
>> +#include "smmuv3-internal.h"
>> +
>> +static void smmuv3_init_regs(SMMUV3State *s)
>> +{
>> +    uint32_t data =
>> +        SMMU_IDR0_STLEVEL << SMMU_IDR0_STLEVEL_SHIFT |
>> +        SMMU_IDR0_TERM    << SMMU_IDR0_TERM_SHIFT    |
>> +        SMMU_IDR0_STALL   << SMMU_IDR0_STALL_SHIFT   |
>> +        SMMU_IDR0_VMID16  << SMMU_IDR0_VMID16_SHIFT  |
>> +        SMMU_IDR0_PRI     << SMMU_IDR0_PRI_SHIFT     |
>> +        SMMU_IDR0_ASID16  << SMMU_IDR0_ASID16_SHIFT  |
>> +        SMMU_IDR0_ATS     << SMMU_IDR0_ATS_SHIFT     |
>> +        SMMU_IDR0_HYP     << SMMU_IDR0_HYP_SHIFT     |
>> +        SMMU_IDR0_HTTU    << SMMU_IDR0_HTTU_SHIFT    |
>> +        SMMU_IDR0_COHACC  << SMMU_IDR0_COHACC_SHIFT  |
>> +        SMMU_IDR0_TTF     << SMMU_IDR0_TTF_SHIFT     |
>> +        SMMU_IDR0_S1P     << SMMU_IDR0_S1P_SHIFT     |
>> +        SMMU_IDR0_S2P     << SMMU_IDR0_S2P_SHIFT;
>> +
>> +    smmu_write32_reg(s, SMMU_REG_IDR0, data);
>> +
>> +#define SMMU_QUEUE_SIZE_LOG2  19
>> +    data =
>> +        1 << 27 |                    /* Attr Types override */
>> +        SMMU_QUEUE_SIZE_LOG2 << 21 | /* Cmd Q size */
>> +        SMMU_QUEUE_SIZE_LOG2 << 16 | /* Event Q size */
>> +        SMMU_QUEUE_SIZE_LOG2 << 11 | /* PRI Q size */
>> +        0  << 6 |                    /* SSID not supported */
>> +        SMMU_IDR1_SIDSIZE;
>> +
>> +    smmu_write32_reg(s, SMMU_REG_IDR1, data);
>> +
>> +    s->sid_size = SMMU_IDR1_SIDSIZE;
>> +
>> +    data = SMMU_IDR5_GRAN << SMMU_IDR5_GRAN_SHIFT | SMMU_IDR5_OAS;
> 
> For VFIO case, should we not set the granule size based on underlying 
> pagesize bitmap derived from VFIO_IOMMU_GET_INFO. Else if guest kernel
> is build with 4k page size and the host kernel is 64k we would start
> getting map errors. 

yes at the moment this is not implemented (1st target of the series is
virtio/vhost).

On Intel if I understand correctly the minimum requested is 4K, 2MB.
1GB is optional. I understand the emulated model does not expose 1GB
(FL1GP = 0).

On ARM nothing is mandatory although 4K and 64K minimal granules are
"strongly recommended", leading to the following additional sizes.

        if (reg & IDR5_GRAN64K)
                smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
        if (reg & IDR5_GRAN16K)
                smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
        if (reg & IDR5_GRAN4K)
                smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;

Maybe we can override the ID5 values using the vfio_memory_listener. I
will try to prototype this idea.

Thanks

Eric


> 
> 
> 
>> +
>> +    smmu_write32_reg(s, SMMU_REG_IDR5, data);
>> +}
>> +
>> +static void smmuv3_init_queues(SMMUV3State *s)
>> +{
>> +    s->cmdq.prod = 0;
>> +    s->cmdq.cons = 0;
>> +    s->cmdq.wrap.prod = 0;
>> +    s->cmdq.wrap.cons = 0;
>> +
>> +    s->evtq.prod = 0;
>> +    s->evtq.cons = 0;
>> +    s->evtq.wrap.prod = 0;
>> +    s->evtq.wrap.cons = 0;
>> +
>> +    s->cmdq.entries = SMMU_QUEUE_SIZE_LOG2;
>> +    s->cmdq.ent_size = sizeof(Cmd);
>> +    s->evtq.entries = SMMU_QUEUE_SIZE_LOG2;
>> +    s->evtq.ent_size = sizeof(Evt);
>> +}
>> +
>> +static void smmuv3_init(SMMUV3State *s)
>> +{
>> +    smmuv3_init_regs(s);
>> +    smmuv3_init_queues(s);
>> +}
>> +
>> +static inline void smmu_update_base_reg(SMMUV3State *s, uint64_t *base,
>> +                                        uint64_t val)
>> +{
>> +    *base = val & ~(SMMU_BASE_RA | 0x3fULL);
>> +}
>> +
>> +static void smmu_write_mmio_fixup(SMMUV3State *s, hwaddr *addr)
>> +{
>> +    switch (*addr) {
>> +    case 0x100a8: case 0x100ac:         /* Aliasing => page0 registers */
>> +    case 0x100c8: case 0x100cc:
>> +        *addr ^= (hwaddr)0x10000;
>> +    }
>> +}
>> +
>> +static void smmu_write_mmio(void *opaque, hwaddr addr,
>> +                            uint64_t val, unsigned size)
>> +{
>> +}
>> +
>> +static uint64_t smmu_read_mmio(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    SMMUState *sys = opaque;
>> +    SMMUV3State *s = SMMU_V3_DEV(sys);
>> +    uint64_t val;
>> +
>> +    smmu_write_mmio_fixup(s, &addr);
>> +
>> +    /* Primecell/Corelink ID registers */
>> +    switch (addr) {
>> +    case 0xFF0 ... 0xFFC:
>> +    case 0xFDC ... 0xFE4:
>> +        val = 0;
>> +        error_report("addr:0x%"PRIx64" val:0x%"PRIx64, addr, val);
>> +        break;
>> +    case SMMU_REG_STRTAB_BASE ... SMMU_REG_CMDQ_BASE:
>> +    case SMMU_REG_EVTQ_BASE:
>> +    case SMMU_REG_PRIQ_BASE ... SMMU_REG_PRIQ_IRQ_CFG1:
>> +        val = smmu_read64_reg(s, addr);
>> +        break;
>> +    default:
>> +        val = (uint64_t)smmu_read32_reg(s, addr);
>> +        break;
>> +    }
>> +
>> +    trace_smmuv3_read_mmio(addr, val, size);
>> +    return val;
>> +}
>> +
>> +static const MemoryRegionOps smmu_mem_ops = {
>> +    .read = smmu_read_mmio,
>> +    .write = smmu_write_mmio,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static void smmu_init_irq(SMMUV3State *s, SysBusDevice *dev)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
>> +        sysbus_init_irq(dev, &s->irq[i]);
>> +    }
>> +}
>> +
>> +static void smmu_reset(DeviceState *dev)
>> +{
>> +    SMMUV3State *s = SMMU_V3_DEV(dev);
>> +    smmuv3_init(s);
>> +}
>> +
>> +static void smmu_realize(DeviceState *d, Error **errp)
>> +{
>> +    SMMUState *sys = SMMU_SYS_DEV(d);
>> +    SMMUV3State *s = SMMU_V3_DEV(sys);
>> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
>> +
>> +    memory_region_init_io(&sys->iomem, OBJECT(s),
>> +                          &smmu_mem_ops, sys, TYPE_SMMU_V3_DEV, 0x20000);
>> +
>> +    sys->mrtypename = g_strdup(TYPE_SMMUV3_IOMMU_MEMORY_REGION);
>> +
>> +    sysbus_init_mmio(dev, &sys->iomem);
>> +
>> +    smmu_init_irq(s, dev);
>> +}
>> +
>> +static const VMStateDescription vmstate_smmuv3 = {
>> +    .name = "smmuv3",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(regs, SMMUV3State, SMMU_NREGS),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static void smmuv3_instance_init(Object *obj)
>> +{
>> +    /* Nothing much to do here as of now */
>> +}
>> +
>> +static void smmuv3_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->reset   = smmu_reset;
>> +    dc->vmsd    = &vmstate_smmuv3;
>> +    dc->realize = smmu_realize;
>> +}
>> +
>> +static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>> +                                                  void *data)
>> +{
>> +}
>> +
>> +static const TypeInfo smmuv3_type_info = {
>> +    .name          = TYPE_SMMU_V3_DEV,
>> +    .parent        = TYPE_SMMU_DEV_BASE,
>> +    .instance_size = sizeof(SMMUV3State),
>> +    .instance_init = smmuv3_instance_init,
>> +    .class_data    = NULL,
>> +    .class_size    = sizeof(SMMUV3Class),
>> +    .class_init    = smmuv3_class_init,
>> +};
>> +
>> +static const TypeInfo smmuv3_iommu_memory_region_info = {
>> +    .parent = TYPE_IOMMU_MEMORY_REGION,
>> +    .name = TYPE_SMMUV3_IOMMU_MEMORY_REGION,
>> +    .class_init = smmuv3_iommu_memory_region_class_init,
>> +};
>> +
>> +static void smmuv3_register_types(void)
>> +{
>> +    type_register(&smmuv3_type_info);
>> +    type_register(&smmuv3_iommu_memory_region_info);
>> +}
>> +
>> +type_init(smmuv3_register_types)
>> +
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index c67cd39..8affbf7 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -14,3 +14,6 @@ smmu_page_walk_level_block_pte(int stage, int level, uint64_t baseaddr, uint64_t
>>  smmu_page_walk_level_table_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d, level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" next table address = 0x%"PRIx64
>>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>>  smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova = 0x%"PRIx64" -> pa = 0x%"PRIx64
>> +
>> +#hw/arm/smmuv3.c
>> +smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> new file mode 100644
>> index 0000000..0c8973d
>> --- /dev/null
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -0,0 +1,79 @@
>> +/*
>> + * Copyright (C) 2014-2016 Broadcom Corporation
>> + * Copyright (c) 2017 Red Hat, Inc.
>> + * Written by Prem Mallappa, Eric Auger
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef HW_ARM_SMMUV3_H
>> +#define HW_ARM_SMMUV3_H
>> +
>> +#include "hw/arm/smmu-common.h"
>> +
>> +#define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
>> +
>> +#define SMMU_NREGS            0x200
>> +
>> +typedef struct SMMUQueue {
>> +     hwaddr base;
>> +     uint32_t prod;
>> +     uint32_t cons;
>> +     union {
>> +          struct {
>> +               uint8_t prod:1;
>> +               uint8_t cons:1;
>> +          };
>> +          uint8_t unused;
>> +     } wrap;
>> +
>> +     uint16_t entries;           /* Number of entries */
>> +     uint8_t  ent_size;          /* Size of entry in bytes */
>> +     uint8_t  shift;             /* Size in log2 */
>> +} SMMUQueue;
>> +
>> +typedef struct SMMUV3State {
>> +    SMMUState     smmu_state;
>> +
>> +    /* Local cache of most-frequently used registers */
>> +#define SMMU_FEATURE_2LVL_STE (1 << 0)
>> +    uint32_t     features;
>> +    uint16_t     sid_size;
>> +    uint16_t     sid_split;
>> +    uint64_t     strtab_base;
>> +
>> +    uint32_t    regs[SMMU_NREGS];
>> +
>> +    qemu_irq     irq[4];
>> +    SMMUQueue    cmdq, evtq;
>> +
>> +} SMMUV3State;
>> +
>> +typedef enum {
>> +    SMMU_IRQ_EVTQ,
>> +    SMMU_IRQ_PRIQ,
>> +    SMMU_IRQ_CMD_SYNC,
>> +    SMMU_IRQ_GERROR,
>> +} SMMUIrq;
>> +
>> +typedef struct {
>> +    SMMUBaseClass smmu_base_class;
>> +} SMMUV3Class;
>> +
>> +#define TYPE_SMMU_V3_DEV   "smmuv3"
>> +#define SMMU_V3_DEV(obj) OBJECT_CHECK(SMMUV3State, (obj), TYPE_SMMU_V3_DEV)
>> +#define SMMU_V3_DEVICE_GET_CLASS(obj)                              \
>> +    OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_SMMU_V3_DEV)
>> +
>> +#endif
>> -- 
>> 2.5.5
>>
>>
> 
