Received: from eggs.gnu.org ([2001:4830:134:3::10]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGX0-0007RY-Qd
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGWx-0003NW-Q1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:22 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:26 +0100
Message-Id: <1521549456-14072-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 04/14] hw/arm/smmuv3: Skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

From: Prem Mallappa <prem.mallappa@broadcom.com>

This patch implements a skeleton for the smmuv3 device.
Datatypes and register definitions are introduced. The MMIO
region, the interrupts and the queue are initialized.

Only the MMIO read operation is implemented here.

Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10:
- s/hwaddr/uint64_t in trace-events
- add comments
- s->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION
- removed iidr and idr from VMState
- use VMSTATE_STRUCT for the queues
- use qemu_log_mask(LOG_UNIMP,*) for unimplemented regs
- added SMMU_CMDQS, SMMU_EVENTQS
- use ops with attributes
- split readl/readll
- put id_regs in an array
- removed smmu_read64
- removed SMMU_FEATURE_2LVL_STE and NB_REGS
- RAZ when read access at unexpected address

v8 -> v9:
- add #include "qemu/log.h"
- add parent_reset

v7 -> v8:
- remove __smmu_data structs
- revisit struct SMMUQueue
- do not advertise stage 2 support anymore
- use the register definition API and get rid of REG array
- get read of queue structs

v6 -> v7:
- split into several patches

v5 -> v6:
- Use IOMMUMemoryregion
- regs become uint32_t and fix 64b MMIO access (.impl)
- trace_smmuv3_write/read_mmio take the size param

v4 -> v5:
- change smmuv3_translate proto (IOMMUAccessFlags flag)
- has_stagex replaced by is_ste_stagex
- smmu_cfg_populate removed
- added smmuv3_decode_config and reworked error management
- remwork the naming of IOMMU mrs
- fix SMMU_CMDQ_CONS offset

v3 -> v4
- smmu_irq_update
- fix hash key allocation
- set smmu_iommu_ops
- set SMMU_REG_CR0,
- smmuv3_translate: ret.perm not set in bypass mode
- use trace events
- renamed STM2U64 into L1STD_L2PTR and STMSPAN into L1STD_SPAN
- rework smmu_find_ste
- fix tg2granule in TT0/0b10 corresponds to 16kB

v2 -> v3:
- move creation of include/hw/arm/smmuv3.h to this patch to fix compil issue
- compilation allowed
- fix sbus allocation in smmu_init_pci_iommu
- restructure code into headers
- misc cleanups

Conflicts:
	hw/arm/Makefile.objs
---
 hw/arm/Makefile.objs     |   2 +-
 hw/arm/smmuv3-internal.h | 167 +++++++++++++++++++++
 hw/arm/smmuv3.c          | 368 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   3 +
 include/hw/arm/smmuv3.h  |  88 ++++++++++++
 5 files changed, 627 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmuv3.h

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 558436f..d51fcec 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,4 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
-obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
+obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
new file mode 100644
index 0000000..a6461fe
--- /dev/null
+++ b/hw/arm/smmuv3-internal.h
@@ -0,0 +1,167 @@
+/*
+ * ARM SMMUv3 support - Internal API
+ *
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_SMMU_V3_INTERNAL_H
+#define HW_ARM_SMMU_V3_INTERNAL_H
+
+#include "qemu/log.h"
+#include "trace.h"
+#include "qemu/error-report.h"
+#include "hw/arm/smmu-common.h"
+
+/* MMIO Registers */
+
+REG32(IDR0,                0x0)
+    FIELD(IDR0, S1P,         1 , 1)
+    FIELD(IDR0, TTF,         2 , 2)
+    FIELD(IDR0, COHACC,      4 , 1)
+    FIELD(IDR0, ASID16,      12, 1)
+    FIELD(IDR0, TTENDIAN,    21, 2)
+    FIELD(IDR0, STALL_MODEL, 24, 2)
+    FIELD(IDR0, TERM_MODEL,  26, 1)
+    FIELD(IDR0, STLEVEL,     27, 2)
+
+REG32(IDR1,                0x4)
+    FIELD(IDR1, SIDSIZE,      0 , 6)
+    FIELD(IDR1, EVENTQS,      16, 5)
+    FIELD(IDR1, CMDQS,        21, 5)
+
+#define SMMU_IDR1_SIDSIZE 16
+#define SMMU_CMDQS   19
+#define SMMU_EVENTQS 19
+
+REG32(IDR2,                0x8)
+REG32(IDR3,                0xc)
+REG32(IDR4,                0x10)
+REG32(IDR5,                0x14)
+     FIELD(IDR5, OAS,         0, 3);
+     FIELD(IDR5, GRAN4K,      4, 1);
+     FIELD(IDR5, GRAN16K,     5, 1);
+     FIELD(IDR5, GRAN64K,     6, 1);
+
+#define SMMU_IDR5_OAS 4
+
+REG32(IIDR,                0x1c)
+REG32(CR0,                 0x20)
+    FIELD(CR0, SMMU_ENABLE,   0, 1)
+    FIELD(CR0, EVENTQEN,      2, 1)
+    FIELD(CR0, CMDQEN,        3, 1)
+
+REG32(CR0ACK,              0x24)
+REG32(CR1,                 0x28)
+REG32(CR2,                 0x2c)
+REG32(STATUSR,             0x40)
+REG32(IRQ_CTRL,            0x50)
+    FIELD(IRQ_CTRL, GERROR_IRQEN,        0, 1)
+    FIELD(IRQ_CTRL, PRI_IRQEN,           1, 1)
+    FIELD(IRQ_CTRL, EVENTQ_IRQEN,        2, 1)
+
+REG32(IRQ_CTRL_ACK,        0x54)
+REG32(GERROR,              0x60)
+    FIELD(GERROR, CMDQ_ERR,           0, 1)
+    FIELD(GERROR, EVENTQ_ABT_ERR,     2, 1)
+    FIELD(GERROR, PRIQ_ABT_ERR,       3, 1)
+    FIELD(GERROR, MSI_CMDQ_ABT_ERR,   4, 1)
+    FIELD(GERROR, MSI_EVENTQ_ABT_ERR, 5, 1)
+    FIELD(GERROR, MSI_PRIQ_ABT_ERR,   6, 1)
+    FIELD(GERROR, MSI_GERROR_ABT_ERR, 7, 1)
+    FIELD(GERROR, MSI_SFM_ERR,        8, 1)
+
+REG32(GERRORN,             0x64)
+
+#define A_GERROR_IRQ_CFG0  0x68 /* 64b */
+REG32(GERROR_IRQ_CFG1, 0x70)
+REG32(GERROR_IRQ_CFG2, 0x74)
+
+#define A_STRTAB_BASE      0x80 /* 64b */
+
+#define SMMU_BASE_ADDR_MASK 0xffffffffffe0
+
+REG32(STRTAB_BASE_CFG,     0x88)
+    FIELD(STRTAB_BASE_CFG, FMT,      16, 2)
+    FIELD(STRTAB_BASE_CFG, SPLIT,    6 , 5)
+    FIELD(STRTAB_BASE_CFG, LOG2SIZE, 0 , 6)
+
+#define A_CMDQ_BASE        0x90 /* 64b */
+REG32(CMDQ_PROD,           0x98)
+REG32(CMDQ_CONS,           0x9c)
+    FIELD(CMDQ_CONS, ERR, 24, 7)
+
+#define A_EVENTQ_BASE      0xa0 /* 64b */
+REG32(EVENTQ_PROD,         0xa8)
+REG32(EVENTQ_CONS,         0xac)
+
+#define A_EVENTQ_IRQ_CFG0  0xb0 /* 64b */
+REG32(EVENTQ_IRQ_CFG1,     0xb8)
+REG32(EVENTQ_IRQ_CFG2,     0xbc)
+
+#define A_IDREGS           0xfd0
+
+static inline int smmu_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
+}
+
+/* Command Queue Entry */
+typedef struct Cmd {
+    uint32_t word[4];
+} Cmd;
+
+/* Event Queue Entry */
+typedef struct Evt  {
+    uint32_t word[8];
+} Evt;
+
+/**
+ * smmu_read64 - 64-bit register read utility function supporting
+ * aligned 32-bit word access to both 32-bit halves and aligned 64-bit
+ * access.
+ *
+ * @r: register address
+ * @offset: byte offset if 32-bit access
+ * @size: read byte size
+ */
+static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
+                                   unsigned size)
+{
+    if (size == 8) {
+        return r;
+    }
+
+    /* 32 bit access */
+    assert(!offset || offset == 4);
+
+    return extract64(r, offset << 3, 32);
+}
+
+static inline uint32_t smmuv3_idreg(int regoffset)
+{
+    /*
+     * Return the value of the Primecell/Corelink ID registers at the
+     * specified offset from the first ID register.
+     * These value indicate an ARM implementation of MMU600 p1
+     */
+    static const uint8_t smmuv3_ids[] = {
+        0x4, 0, 0, 0, 0x84, 0xB4, 0xF0, 0x10, 0x0D, 0xF0, 0x05, 0xB1
+    };
+    return smmuv3_ids[regoffset / 4];
+}
+
+#endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
new file mode 100644
index 0000000..3472163
--- /dev/null
+++ b/hw/arm/smmuv3.c
@@ -0,0 +1,368 @@
+/*
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/boards.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-core.h"
+#include "hw/pci/pci.h"
+#include "exec/address-spaces.h"
+#include "trace.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-internal.h"
+
+static void smmuv3_init_regs(SMMUv3State *s)
+{
+    /**
+     * IDR0: stage1 only, AArch64 only, coherent access, 16b ASID,
+     *       multi-level stream table
+     */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1); /* stage 1 supported */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW only */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little endian */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No stall */
+    /* terminated transaction will always be aborted/error returned */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, 1);
+    /* 2-level stream table supported */
+    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, STLEVEL, 1);
+
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
+
+   /* 4K and 64K granule support */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+
+    s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
+    s->cmdq.prod = 0;
+    s->cmdq.cons = 0;
+    s->cmdq.entry_size = sizeof(struct Cmd);
+    s->eventq.base = deposit64(s->eventq.base, 0, 5, SMMU_EVENTQS);
+    s->eventq.prod = 0;
+    s->eventq.cons = 0;
+    s->eventq.entry_size = sizeof(struct Evt);
+
+    s->features = 0;
+    s->sid_split = 0;
+}
+
+static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
+                                   unsigned size, MemTxAttrs attrs)
+{
+    /* not yet implemented */
+    return MEMTX_ERROR;
+}
+
+static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
+                               uint64_t *data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_GERROR_IRQ_CFG0:
+        *data = s->gerror_irq_cfg0;
+        return MEMTX_OK;
+    case A_STRTAB_BASE:
+        *data = s->strtab_base;
+        return MEMTX_OK;
+    case A_CMDQ_BASE:
+        *data = s->cmdq.base;
+        return MEMTX_OK;
+    case A_EVENTQ_BASE:
+        *data = s->eventq.base;
+        return MEMTX_OK;
+    default:
+        *data = 0;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s Unexpected 64-bit access to 0x%"PRIx64" (RAZ)\n",
+                      __func__, offset);
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
+                              uint64_t *data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_IDREGS ... A_IDREGS + 0x1f:
+        *data = smmuv3_idreg(offset - A_IDREGS);
+        return MEMTX_OK;
+    case A_IDR0 ... A_IDR5:
+        *data = s->idr[(offset - A_IDR0) / 4];
+        return MEMTX_OK;
+    case A_IIDR:
+        *data = s->iidr;
+        return MEMTX_OK;
+    case A_CR0:
+        *data = s->cr[0];
+        return MEMTX_OK;
+    case A_CR0ACK:
+        *data = s->cr0ack;
+        return MEMTX_OK;
+    case A_CR1:
+        *data = s->cr[1];
+        return MEMTX_OK;
+    case A_CR2:
+        *data = s->cr[2];
+        return MEMTX_OK;
+    case A_STATUSR:
+        *data = s->statusr;
+        return MEMTX_OK;
+    case A_IRQ_CTRL:
+        *data = s->irq_ctrl;
+        return MEMTX_OK;
+    case A_IRQ_CTRL_ACK:
+        *data = s->irq_ctrl_ack;
+        return MEMTX_OK;
+    case A_GERROR:
+        *data = s->gerror;
+        return MEMTX_OK;
+    case A_GERRORN:
+        *data = s->gerrorn;
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0: /* 64b */
+        *data = extract64(s->gerror_irq_cfg0, 0, 32);
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0 + 4:
+        *data = extract64(s->gerror_irq_cfg0, 32, 32);
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG1:
+        *data = s->gerror_irq_cfg1;
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG2:
+        *data = s->gerror_irq_cfg2;
+        return MEMTX_OK;
+    case A_STRTAB_BASE: /* 64b */
+        *data = extract64(s->strtab_base, 0, 32);
+        return MEMTX_OK;
+    case A_STRTAB_BASE + 4: /* 64b */
+        *data = extract64(s->strtab_base, 32, 32);
+        return MEMTX_OK;
+    case A_STRTAB_BASE_CFG:
+        *data = s->strtab_base_cfg;
+        return MEMTX_OK;
+    case A_CMDQ_BASE: /* 64b */
+        *data = extract64(s->cmdq.base, 0, 32);
+        return MEMTX_OK;
+    case A_CMDQ_BASE + 4:
+        *data = extract64(s->cmdq.base, 32, 32);
+        return MEMTX_OK;
+    case A_CMDQ_PROD:
+        *data = s->cmdq.prod;
+        return MEMTX_OK;
+    case A_CMDQ_CONS:
+        *data = s->cmdq.cons;
+        return MEMTX_OK;
+    case A_EVENTQ_BASE: /* 64b */
+        *data = extract64(s->eventq.base, 0, 32);
+        return MEMTX_OK;
+    case A_EVENTQ_BASE + 4: /* 64b */
+        *data = extract64(s->eventq.base, 32, 32);
+        return MEMTX_OK;
+    case A_EVENTQ_PROD:
+        *data = s->eventq.prod;
+        return MEMTX_OK;
+    case A_EVENTQ_CONS:
+        *data = s->eventq.cons;
+        return MEMTX_OK;
+    default:
+        *data = 0;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
+                      __func__, offset);
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
+                                  unsigned size, MemTxAttrs attrs)
+{
+    SMMUState *sys = opaque;
+    SMMUv3State *s = ARM_SMMUV3(sys);
+    MemTxResult r;
+
+    /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
+    offset &= ~0x10000;
+
+    switch (size) {
+    case 8:
+        r = smmu_readll(s, offset, data, attrs);
+        break;
+    case 4:
+        r = smmu_readl(s, offset, data, attrs);
+        break;
+    default:
+        r = MEMTX_ERROR;
+        break;
+    }
+
+    trace_smmuv3_read_mmio(offset, *data, size, r);
+    return r;
+}
+
+static const MemoryRegionOps smmu_mem_ops = {
+    .read_with_attrs = smmu_read_mmio,
+    .write_with_attrs = smmu_write_mmio,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+        sysbus_init_irq(dev, &s->irq[i]);
+    }
+}
+
+static void smmu_reset(DeviceState *dev)
+{
+    SMMUv3State *s = ARM_SMMUV3(dev);
+    SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
+
+    c->parent_reset(dev);
+
+    smmuv3_init_regs(s);
+}
+
+static void smmu_realize(DeviceState *d, Error **errp)
+{
+    SMMUState *sys = ARM_SMMU(d);
+    SMMUv3State *s = ARM_SMMUV3(sys);
+    SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
+    Error *local_err = NULL;
+
+    c->parent_realize(d, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_init_io(&sys->iomem, OBJECT(s),
+                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
+
+    sys->mrtypename = TYPE_SMMUV3_IOMMU_MEMORY_REGION;
+
+    sysbus_init_mmio(dev, &sys->iomem);
+
+    smmu_init_irq(s, dev);
+}
+
+static const VMStateDescription vmstate_smmuv3_queue = {
+    .name = "smmuv3_queue",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(base, SMMUQueue),
+        VMSTATE_UINT32(prod, SMMUQueue),
+        VMSTATE_UINT32(cons, SMMUQueue),
+        VMSTATE_UINT8(log2size, SMMUQueue),
+    },
+};
+
+static const VMStateDescription vmstate_smmuv3 = {
+    .name = "smmuv3",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(features, SMMUv3State),
+        VMSTATE_UINT8(sid_size, SMMUv3State),
+        VMSTATE_UINT8(sid_split, SMMUv3State),
+
+        VMSTATE_UINT32_ARRAY(cr, SMMUv3State, 3),
+        VMSTATE_UINT32(cr0ack, SMMUv3State),
+        VMSTATE_UINT32(statusr, SMMUv3State),
+        VMSTATE_UINT32(irq_ctrl, SMMUv3State),
+        VMSTATE_UINT32(irq_ctrl_ack, SMMUv3State),
+        VMSTATE_UINT32(gerror, SMMUv3State),
+        VMSTATE_UINT32(gerrorn, SMMUv3State),
+        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3State),
+        VMSTATE_UINT64(strtab_base, SMMUv3State),
+        VMSTATE_UINT32(strtab_base_cfg, SMMUv3State),
+        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3State),
+        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3State),
+        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3State),
+
+        VMSTATE_STRUCT(cmdq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(eventq, SMMUv3State, 0, vmstate_smmuv3_queue, SMMUQueue),
+
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void smmuv3_instance_init(Object *obj)
+{
+    /* Nothing much to do here as of now */
+}
+
+static void smmuv3_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
+
+    dc->vmsd = &vmstate_smmuv3;
+    device_class_set_parent_reset(dc, smmu_reset, &c->parent_reset);
+    c->parent_realize = dc->realize;
+    dc->realize = smmu_realize;
+}
+
+static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
+                                                  void *data)
+{
+}
+
+static const TypeInfo smmuv3_type_info = {
+    .name          = TYPE_ARM_SMMUV3,
+    .parent        = TYPE_ARM_SMMU,
+    .instance_size = sizeof(SMMUv3State),
+    .instance_init = smmuv3_instance_init,
+    .class_size    = sizeof(SMMUv3Class),
+    .class_init    = smmuv3_class_init,
+};
+
+static const TypeInfo smmuv3_iommu_memory_region_info = {
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .name = TYPE_SMMUV3_IOMMU_MEMORY_REGION,
+    .class_init = smmuv3_iommu_memory_region_class_init,
+};
+
+static void smmuv3_register_types(void)
+{
+    type_register(&smmuv3_type_info);
+    type_register(&smmuv3_iommu_memory_region_info);
+}
+
+type_init(smmuv3_register_types)
+
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 524964a..2f3d74a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -12,3 +12,6 @@ smmu_ptw_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr,
 smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+
+#hw/arm/smmuv3.c
+smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
new file mode 100644
index 0000000..6a5ead8
--- /dev/null
+++ b/include/hw/arm/smmuv3.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_SMMUV3_H
+#define HW_ARM_SMMUV3_H
+
+#include "hw/arm/smmu-common.h"
+#include "hw/registerfields.h"
+
+#define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
+
+typedef struct SMMUQueue {
+     uint64_t base; /* base register */
+     uint32_t prod;
+     uint32_t cons;
+     uint8_t entry_size;
+     uint8_t log2size;
+} SMMUQueue;
+
+typedef struct SMMUv3State {
+    SMMUState     smmu_state;
+
+    uint32_t features;
+    uint8_t sid_size;
+    uint8_t sid_split;
+
+    uint32_t idr[6];
+    uint32_t iidr;
+    uint32_t cr[3];
+    uint32_t cr0ack;
+    uint32_t statusr;
+    uint32_t irq_ctrl;
+    uint32_t irq_ctrl_ack;
+    uint32_t gerror;
+    uint32_t gerrorn;
+    uint64_t gerror_irq_cfg0;
+    uint32_t gerror_irq_cfg1;
+    uint32_t gerror_irq_cfg2;
+    uint64_t strtab_base;
+    uint32_t strtab_base_cfg;
+    uint64_t eventq_irq_cfg0;
+    uint32_t eventq_irq_cfg1;
+    uint32_t eventq_irq_cfg2;
+
+    SMMUQueue eventq, cmdq;
+
+    qemu_irq     irq[4];
+} SMMUv3State;
+
+typedef enum {
+    SMMU_IRQ_EVTQ,
+    SMMU_IRQ_PRIQ,
+    SMMU_IRQ_CMD_SYNC,
+    SMMU_IRQ_GERROR,
+} SMMUIrq;
+
+typedef struct {
+    /*< private >*/
+    SMMUBaseClass smmu_base_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+    DeviceReset   parent_reset;
+} SMMUv3Class;
+
+#define TYPE_ARM_SMMUV3   "arm-smmuv3"
+#define ARM_SMMUV3(obj) OBJECT_CHECK(SMMUv3State, (obj), TYPE_ARM_SMMUV3)
+#define ARM_SMMUV3_CLASS(klass)                              \
+    OBJECT_CLASS_CHECK(SMMUv3Class, (klass), TYPE_ARM_SMMUV3)
+#define ARM_SMMUV3_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(SMMUv3Class, (obj), TYPE_ARM_SMMUV3)
+
+#endif
-- 
2.5.5
