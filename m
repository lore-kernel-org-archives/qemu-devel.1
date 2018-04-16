Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83ry-0007ck-8D
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83rw-0003NW-Hj
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:08:30 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:36546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f83rw-0003Ms-99
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:08:28 -0400
Received: by mail-ot0-x22d.google.com with SMTP id p2-v6so430125otf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 06:08:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-5-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 14:08:07 +0100
Message-ID: <CAFEAcA979S2Hxdv6t+sODtyV8Z_G0kuJGUSe7P63psVMwTun3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 04/17] hw/arm/smmuv3: Skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
> From: Prem Mallappa <prem.mallappa@broadcom.com>
>
> This patch implements a skeleton for the smmuv3 device.
> Datatypes and register definitions are introduced. The MMIO
> region, the interrupts and the queue are initialized.
>
> Only the MMIO read operation is implemented here.
>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v10 -> v11:
> - remove irq_ctrl_ack and return irq_ctrl on A_IRQ_CTRL_ACK
>   read
>
> v9 -> v10:
> - s/hwaddr/uint64_t in trace-events
> - add comments
> - s->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION
> - removed iidr and idr from VMState
> - use VMSTATE_STRUCT for the queues
> - use qemu_log_mask(LOG_UNIMP,*) for unimplemented regs
> - added SMMU_CMDQS, SMMU_EVENTQS
> - use ops with attributes
> - split readl/readll
> - put id_regs in an array
> - removed smmu_read64
> - removed SMMU_FEATURE_2LVL_STE and NB_REGS
> - RAZ when read access at unexpected address
>
> v8 -> v9:
> - add #include "qemu/log.h"
> - add parent_reset
>
> v7 -> v8:
> - remove __smmu_data structs
> - revisit struct SMMUQueue
> - do not advertise stage 2 support anymore
> - use the register definition API and get rid of REG array
> - get read of queue structs
>
> v6 -> v7:
> - split into several patches
>
> v5 -> v6:
> - Use IOMMUMemoryregion
> - regs become uint32_t and fix 64b MMIO access (.impl)
> - trace_smmuv3_write/read_mmio take the size param
>
> v4 -> v5:
> - change smmuv3_translate proto (IOMMUAccessFlags flag)
> - has_stagex replaced by is_ste_stagex
> - smmu_cfg_populate removed
> - added smmuv3_decode_config and reworked error management
> - remwork the naming of IOMMU mrs
> - fix SMMU_CMDQ_CONS offset
>
> v3 -> v4
> - smmu_irq_update
> - fix hash key allocation
> - set smmu_iommu_ops
> - set SMMU_REG_CR0,
> - smmuv3_translate: ret.perm not set in bypass mode
> - use trace events
> - renamed STM2U64 into L1STD_L2PTR and STMSPAN into L1STD_SPAN
> - rework smmu_find_ste
> - fix tg2granule in TT0/0b10 corresponds to 16kB
>
> v2 -> v3:
> - move creation of include/hw/arm/smmuv3.h to this patch to fix compil issue
> - compilation allowed
> - fix sbus allocation in smmu_init_pci_iommu
> - restructure code into headers
> - misc cleanups
>
> Conflicts:
>         hw/arm/Makefile.objs
> ---
>  hw/arm/Makefile.objs     |   2 +-
>  hw/arm/smmuv3-internal.h | 167 ++++++++++++++++++++++
>  hw/arm/smmuv3.c          | 365 +++++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |   3 +
>  include/hw/arm/smmuv3.h  |  87 +++++++++++
>  5 files changed, 623 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/smmuv3-internal.h
>  create mode 100644 hw/arm/smmuv3.c
>  create mode 100644 include/hw/arm/smmuv3.h
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 558436f..d51fcec 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -35,4 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
>  obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
>  obj-$(CONFIG_IOTKIT) += iotkit.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
> -obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
> +obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> new file mode 100644
> index 0000000..a6461fe
> --- /dev/null
> +++ b/hw/arm/smmuv3-internal.h
> @@ -0,0 +1,167 @@
> +/*
> + * ARM SMMUv3 support - Internal API
> + *
> + * Copyright (C) 2014-2016 Broadcom Corporation
> + * Copyright (c) 2017 Red Hat, Inc.
> + * Written by Prem Mallappa, Eric Auger
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_ARM_SMMU_V3_INTERNAL_H
> +#define HW_ARM_SMMU_V3_INTERNAL_H
> +
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "qemu/error-report.h"

I don't think you use these headers in this .h file -- they should
probably be included from the .c file(s) instead.

> +#include "hw/arm/smmu-common.h"
> +
> +/* MMIO Registers */
> +
> +REG32(IDR0,                0x0)
> +    FIELD(IDR0, S1P,         1 , 1)
> +    FIELD(IDR0, TTF,         2 , 2)
> +    FIELD(IDR0, COHACC,      4 , 1)
> +    FIELD(IDR0, ASID16,      12, 1)
> +    FIELD(IDR0, TTENDIAN,    21, 2)
> +    FIELD(IDR0, STALL_MODEL, 24, 2)
> +    FIELD(IDR0, TERM_MODEL,  26, 1)
> +    FIELD(IDR0, STLEVEL,     27, 2)
> +
> +REG32(IDR1,                0x4)
> +    FIELD(IDR1, SIDSIZE,      0 , 6)
> +    FIELD(IDR1, EVENTQS,      16, 5)
> +    FIELD(IDR1, CMDQS,        21, 5)
> +
> +#define SMMU_IDR1_SIDSIZE 16
> +#define SMMU_CMDQS   19
> +#define SMMU_EVENTQS 19
> +
> +REG32(IDR2,                0x8)
> +REG32(IDR3,                0xc)
> +REG32(IDR4,                0x10)
> +REG32(IDR5,                0x14)
> +     FIELD(IDR5, OAS,         0, 3);
> +     FIELD(IDR5, GRAN4K,      4, 1);
> +     FIELD(IDR5, GRAN16K,     5, 1);
> +     FIELD(IDR5, GRAN64K,     6, 1);
> +
> +#define SMMU_IDR5_OAS 4
> +
> +REG32(IIDR,                0x1c)
> +REG32(CR0,                 0x20)
> +    FIELD(CR0, SMMU_ENABLE,   0, 1)
> +    FIELD(CR0, EVENTQEN,      2, 1)
> +    FIELD(CR0, CMDQEN,        3, 1)
> +
> +REG32(CR0ACK,              0x24)
> +REG32(CR1,                 0x28)
> +REG32(CR2,                 0x2c)
> +REG32(STATUSR,             0x40)
> +REG32(IRQ_CTRL,            0x50)
> +    FIELD(IRQ_CTRL, GERROR_IRQEN,        0, 1)
> +    FIELD(IRQ_CTRL, PRI_IRQEN,           1, 1)
> +    FIELD(IRQ_CTRL, EVENTQ_IRQEN,        2, 1)
> +
> +REG32(IRQ_CTRL_ACK,        0x54)
> +REG32(GERROR,              0x60)
> +    FIELD(GERROR, CMDQ_ERR,           0, 1)
> +    FIELD(GERROR, EVENTQ_ABT_ERR,     2, 1)
> +    FIELD(GERROR, PRIQ_ABT_ERR,       3, 1)
> +    FIELD(GERROR, MSI_CMDQ_ABT_ERR,   4, 1)
> +    FIELD(GERROR, MSI_EVENTQ_ABT_ERR, 5, 1)
> +    FIELD(GERROR, MSI_PRIQ_ABT_ERR,   6, 1)
> +    FIELD(GERROR, MSI_GERROR_ABT_ERR, 7, 1)
> +    FIELD(GERROR, MSI_SFM_ERR,        8, 1)
> +
> +REG32(GERRORN,             0x64)
> +
> +#define A_GERROR_IRQ_CFG0  0x68 /* 64b */
> +REG32(GERROR_IRQ_CFG1, 0x70)
> +REG32(GERROR_IRQ_CFG2, 0x74)
> +
> +#define A_STRTAB_BASE      0x80 /* 64b */

Why do this constant and A_GERROR_IRQ_CFG0 have different values
but the same cryptic comment ?


> +static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
> +                                   unsigned size)

Looks like this function is unused now ?


> +    /*
> +     * Return the value of the Primecell/Corelink ID registers at the
> +     * specified offset from the first ID register.
> +     * These value indicate an ARM implementation of MMU600 p1
> +     */
> +    static const uint8_t smmuv3_ids[] = {
> +        0x4, 0, 0, 0, 0x84, 0xB4, 0xF0, 0x10, 0x0D, 0xF0, 0x05, 0xB1

Can you be consistent about whether you put the leading 0 in
for hex values less than 0x10 (0x4 vs 0x0D) ?


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
