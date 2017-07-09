Received: from eggs.gnu.org ([2001:4830:134:3::10]:58720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJBw-0001tw-2U
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJBr-0005qn-42
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:52:32 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun,  9 Jul 2017 22:51:27 +0200
Message-Id: <1499633493-19865-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 2/8] hw/arm/smmuv3: smmuv3 emulation model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

From: Prem Mallappa <prem.mallappa@broadcom.com>

Introduces the SMMUv3 derived model. This is based on
System MMUv3 specification (v17).

Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
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
---
 hw/arm/Makefile.objs     |    2 +-
 hw/arm/smmu-internal.h   |    8 -
 hw/arm/smmuv3-internal.h |  651 ++++++++++++++++++++++++++
 hw/arm/smmuv3.c          | 1133 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   34 ++
 include/hw/arm/smmuv3.h  |   87 ++++
 6 files changed, 1906 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/smmuv3-internal.h
 create mode 100644 hw/arm/smmuv3.c
 create mode 100644 include/hw/arm/smmuv3.h

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 6c7d4af..02cd23f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -18,4 +18,4 @@ obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
-obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
+obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 5e890bb..3b1e222 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -86,12 +86,4 @@ uint64_t iova_level_offset(uint64_t iova, int level, int granule_sz)
             ((1ULL << (granule_sz - 3)) - 1);
 }
 
-/* TODO: check this for stage 2 and table concatenation */
-static inline int initial_lookup_level(int tnsz, int granule_sz)
-{
-    return 4 - (64 - tnsz - 4) / (granule_sz - 3);
-}
-
-
-
 #endif
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
new file mode 100644
index 0000000..740327c
--- /dev/null
+++ b/hw/arm/smmuv3-internal.h
@@ -0,0 +1,651 @@
+/*
+ * ARM SMMUv3 support - Internal API
+ *
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
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
+#include "trace.h"
+#include "qemu/error-report.h"
+#include "hw/arm/smmu-common.h"
+
+/*****************************
+ * MMIO Register
+ *****************************/
+enum {
+    SMMU_REG_IDR0            = 0x0,
+
+/* IDR0 Field Values and supported features */
+
+#define SMMU_IDR0_S2P      1  /* stage 2 */
+#define SMMU_IDR0_S1P      1  /* stage 1 */
+#define SMMU_IDR0_TTF      2  /* Aarch64 only - not Aarch32 (LPAE) */
+#define SMMU_IDR0_COHACC   1  /* IO coherent access */
+#define SMMU_IDR0_HTTU     2  /* Access and Dirty flag update */
+#define SMMU_IDR0_HYP      0  /* Hypervisor Stage 1 contexts */
+#define SMMU_IDR0_ATS      0  /* PCIe RC ATS */
+#define SMMU_IDR0_ASID16   1  /* 16-bit ASID */
+#define SMMU_IDR0_PRI      0  /* Page Request Interface */
+#define SMMU_IDR0_VMID16   0  /* 16-bit VMID */
+#define SMMU_IDR0_CD2L     0  /* 2-level Context Descriptor table */
+#define SMMU_IDR0_STALL    1  /* Stalling fault model */
+#define SMMU_IDR0_TERM     1  /* Termination model behaviour */
+#define SMMU_IDR0_STLEVEL  1  /* Multi-level Stream Table */
+
+#define SMMU_IDR0_S2P_SHIFT      0
+#define SMMU_IDR0_S1P_SHIFT      1
+#define SMMU_IDR0_TTF_SHIFT      2
+#define SMMU_IDR0_COHACC_SHIFT   4
+#define SMMU_IDR0_HTTU_SHIFT     6
+#define SMMU_IDR0_HYP_SHIFT      9
+#define SMMU_IDR0_ATS_SHIFT      10
+#define SMMU_IDR0_ASID16_SHIFT   12
+#define SMMU_IDR0_PRI_SHIFT      16
+#define SMMU_IDR0_VMID16_SHIFT   18
+#define SMMU_IDR0_CD2L_SHIFT     19
+#define SMMU_IDR0_STALL_SHIFT    24
+#define SMMU_IDR0_TERM_SHIFT     26
+#define SMMU_IDR0_STLEVEL_SHIFT  27
+
+    SMMU_REG_IDR1            = 0x4,
+#define SMMU_IDR1_SIDSIZE 16
+    SMMU_REG_IDR2            = 0x8,
+    SMMU_REG_IDR3            = 0xc,
+    SMMU_REG_IDR4            = 0x10,
+    SMMU_REG_IDR5            = 0x14,
+#define SMMU_IDR5_GRAN_SHIFT 4
+#define SMMU_IDR5_GRAN       0b101 /* GRAN4K, GRAN64K */
+#define SMMU_IDR5_OAS        4     /* 44 bits */
+    SMMU_REG_IIDR            = 0x1c,
+    SMMU_REG_CR0             = 0x20,
+
+#define SMMU_CR0_SMMU_ENABLE (1 << 0)
+#define SMMU_CR0_PRIQ_ENABLE (1 << 1)
+#define SMMU_CR0_EVTQ_ENABLE (1 << 2)
+#define SMMU_CR0_CMDQ_ENABLE (1 << 3)
+#define SMMU_CR0_ATS_CHECK   (1 << 4)
+
+    SMMU_REG_CR0_ACK         = 0x24,
+    SMMU_REG_CR1             = 0x28,
+    SMMU_REG_CR2             = 0x2c,
+
+    SMMU_REG_STATUSR         = 0x40,
+
+    SMMU_REG_IRQ_CTRL        = 0x50,
+    SMMU_REG_IRQ_CTRL_ACK    = 0x54,
+
+#define SMMU_IRQ_CTRL_GERROR_EN (1 << 0)
+#define SMMU_IRQ_CTRL_EVENT_EN  (1 << 1)
+#define SMMU_IRQ_CTRL_PRI_EN    (1 << 2)
+
+    SMMU_REG_GERROR          = 0x60,
+
+#define SMMU_GERROR_CMDQ       (1 << 0)
+#define SMMU_GERROR_EVENTQ     (1 << 2)
+#define SMMU_GERROR_PRIQ       (1 << 3)
+#define SMMU_GERROR_MSI_CMDQ   (1 << 4)
+#define SMMU_GERROR_MSI_EVENTQ (1 << 5)
+#define SMMU_GERROR_MSI_PRIQ   (1 << 6)
+#define SMMU_GERROR_MSI_GERROR (1 << 7)
+#define SMMU_GERROR_SFM_ERR    (1 << 8)
+
+    SMMU_REG_GERRORN         = 0x64,
+    SMMU_REG_GERROR_IRQ_CFG0 = 0x68,
+    SMMU_REG_GERROR_IRQ_CFG1 = 0x70,
+    SMMU_REG_GERROR_IRQ_CFG2 = 0x74,
+
+    /* SMMU_BASE_RA Applies to STRTAB_BASE, CMDQ_BASE and EVTQ_BASE */
+#define SMMU_BASE_RA        (1ULL << 62)
+    SMMU_REG_STRTAB_BASE     = 0x80,
+    SMMU_REG_STRTAB_BASE_CFG = 0x88,
+
+    SMMU_REG_CMDQ_BASE       = 0x90,
+    SMMU_REG_CMDQ_PROD       = 0x98,
+    SMMU_REG_CMDQ_CONS       = 0x9c,
+    /* CMD Consumer (CONS) */
+#define SMMU_CMD_CONS_ERR_SHIFT        24
+#define SMMU_CMD_CONS_ERR_BITS         7
+
+    SMMU_REG_EVTQ_BASE       = 0xa0,
+    SMMU_REG_EVTQ_PROD       = 0xa8,
+    SMMU_REG_EVTQ_CONS       = 0xac,
+    SMMU_REG_EVTQ_IRQ_CFG0   = 0xb0,
+    SMMU_REG_EVTQ_IRQ_CFG1   = 0xb8,
+    SMMU_REG_EVTQ_IRQ_CFG2   = 0xbc,
+
+    SMMU_REG_PRIQ_BASE       = 0xc0,
+    SMMU_REG_PRIQ_PROD       = 0xc8,
+    SMMU_REG_PRIQ_CONS       = 0xcc,
+    SMMU_REG_PRIQ_IRQ_CFG0   = 0xd0,
+    SMMU_REG_PRIQ_IRQ_CFG1   = 0xd8,
+    SMMU_REG_PRIQ_IRQ_CFG2   = 0xdc,
+
+    SMMU_ID_REGS_OFFSET      = 0xfd0,
+
+    /* Secure registers are not used for now */
+    SMMU_SECURE_OFFSET       = 0x8000,
+};
+
+/**********************
+ * Data Structures
+ **********************/
+
+struct __smmu_data2 {
+    uint32_t word[2];
+};
+
+struct __smmu_data8 {
+    uint32_t word[8];
+};
+
+struct __smmu_data16 {
+    uint32_t word[16];
+};
+
+struct __smmu_data4 {
+    uint32_t word[4];
+};
+
+typedef struct __smmu_data2  STEDesc; /* STE Level 1 Descriptor */
+typedef struct __smmu_data16 Ste;     /* Stream Table Entry(STE) */
+typedef struct __smmu_data2  CDDesc;  /* CD Level 1 Descriptor */
+typedef struct __smmu_data16 Cd;      /* Context Descriptor(CD) */
+
+typedef struct __smmu_data4  Cmd; /* Command Entry */
+typedef struct __smmu_data8  Evt; /* Event Entry */
+typedef struct __smmu_data4  Pri; /* PRI entry */
+
+/*****************************
+ * STE fields
+ *****************************/
+
+#define STE_VALID(x)   extract32((x)->word[0], 0, 1) /* 0 */
+#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
+enum {
+    STE_CONFIG_NONE      = 0,
+    STE_CONFIG_BYPASS    = 4,       /* S1 Bypass    , S2 Bypass */
+    STE_CONFIG_S1        = 5,       /* S1 Translate , S2 Bypass */
+    STE_CONFIG_S2        = 6,       /* S1 Bypass    , S2 Translate */
+    STE_CONFIG_NESTED    = 7,       /* S1 Translate , S2 Translate */
+};
+#define STE_S1FMT(x)   extract32((x)->word[0], 4, 2)
+#define STE_S1CDMAX(x) extract32((x)->word[1], 27, 5)
+#define STE_EATS(x)    extract32((x)->word[2], 28, 2)
+#define STE_STRW(x)    extract32((x)->word[2], 30, 2)
+#define STE_S2VMID(x)  extract32((x)->word[4], 0, 16)
+#define STE_S2T0SZ(x)  extract32((x)->word[5], 0, 6)
+#define STE_S2SL0(x)   extract32((x)->word[5], 6, 2)
+#define STE_S2TG(x)    extract32((x)->word[5], 14, 2)
+#define STE_S2PS(x)    extract32((x)->word[5], 16, 3)
+#define STE_S2AA64(x)  extract32((x)->word[5], 19, 1)
+#define STE_S2HD(x)    extract32((x)->word[5], 24, 1)
+#define STE_S2HA(x)    extract32((x)->word[5], 25, 1)
+#define STE_S2S(x)     extract32((x)->word[5], 26, 1)
+#define STE_CTXPTR(x)                                           \
+    ({                                                          \
+        unsigned long addr;                                     \
+        addr = (uint64_t)extract32((x)->word[1], 0, 16) << 32;  \
+        addr |= (uint64_t)((x)->word[0] & 0xffffffc0);          \
+        addr;                                                   \
+    })
+
+#define STE_S2TTB(x)                                            \
+    ({                                                          \
+        unsigned long addr;                                     \
+        addr = (uint64_t)extract32((x)->word[7], 0, 16) << 32;  \
+        addr |= (uint64_t)((x)->word[6] & 0xfffffff0);          \
+        addr;                                                   \
+    })
+
+static inline int is_ste_bypass(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_BYPASS;
+}
+
+static inline bool is_ste_stage1(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_S1;
+}
+
+static inline bool is_ste_stage2(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_S2;
+}
+
+/**
+ * is_s2granule_valid - Check the stage 2 translation granule size
+ * advertised in the STE matches any IDR5 supported value
+ */
+static inline bool is_s2granule_valid(Ste *ste)
+{
+    int idr5_format = 0;
+
+    switch (STE_S2TG(ste)) {
+    case 0: /* 4kB */
+        idr5_format = 0x1;
+        break;
+    case 1: /* 64 kB */
+        idr5_format = 0x4;
+        break;
+    case 2: /* 16 kB */
+        idr5_format = 0x2;
+        break;
+    case 3: /* reserved */
+        break;
+    }
+    idr5_format &= SMMU_IDR5_GRAN;
+    return idr5_format;
+}
+
+static inline int oas2bits(int oas_field)
+{
+    switch (oas_field) {
+    case 0b011:
+        return 42;
+    case 0b100:
+        return 44;
+    default:
+        return 32 + (1 << oas_field);
+   }
+}
+
+static inline int pa_range(Ste *ste)
+{
+    int oas_field = MIN(STE_S2PS(ste), SMMU_IDR5_OAS);
+
+    if (!STE_S2AA64(ste)) {
+        return 40;
+    }
+
+    return oas2bits(oas_field);
+}
+
+#define MAX_PA(ste) ((1 << pa_range(ste)) - 1)
+
+/*****************************
+ * CD fields
+ *****************************/
+#define CD_VALID(x)   extract32((x)->word[0], 30, 1)
+#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
+#define CD_TTB(x, sel)                                      \
+    ({                                                      \
+        uint64_t hi, lo;                                    \
+        hi = extract32((x)->word[(sel) * 2 + 3], 0, 16);    \
+        hi <<= 32;                                          \
+        lo = (x)->word[(sel) * 2 + 2] & ~0xf;               \
+        hi | lo;                                            \
+    })
+
+#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
+#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
+#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
+
+#define CD_T0SZ(x)    CD_TSZ((x), 0)
+#define CD_T1SZ(x)    CD_TSZ((x), 1)
+#define CD_TG0(x)     CD_TG((x), 0)
+#define CD_TG1(x)     CD_TG((x), 1)
+#define CD_EPD0(x)    CD_EPD((x), 0)
+#define CD_EPD1(x)    CD_EPD((x), 1)
+#define CD_IPS(x)     extract32((x)->word[1], 0, 3)
+#define CD_AARCH64(x) extract32((x)->word[1], 9, 1)
+#define CD_TTB0(x)    CD_TTB((x), 0)
+#define CD_TTB1(x)    CD_TTB((x), 1)
+
+#define CDM_VALID(x)    ((x)->word[0] & 0x1)
+
+static inline int is_cd_valid(SMMUV3State *s, Ste *ste, Cd *cd)
+{
+    return CD_VALID(cd);
+}
+
+/*****************************
+ * Commands
+ *****************************/
+enum {
+    SMMU_CMD_PREFETCH_CONFIG = 0x01,
+    SMMU_CMD_PREFETCH_ADDR,
+    SMMU_CMD_CFGI_STE,
+    SMMU_CMD_CFGI_STE_RANGE,
+    SMMU_CMD_CFGI_CD,
+    SMMU_CMD_CFGI_CD_ALL,
+    SMMU_CMD_CFGI_ALL,
+    SMMU_CMD_TLBI_NH_ALL     = 0x10,
+    SMMU_CMD_TLBI_NH_ASID,
+    SMMU_CMD_TLBI_NH_VA,
+    SMMU_CMD_TLBI_NH_VAA,
+    SMMU_CMD_TLBI_EL3_ALL    = 0x18,
+    SMMU_CMD_TLBI_EL3_VA     = 0x1a,
+    SMMU_CMD_TLBI_EL2_ALL    = 0x20,
+    SMMU_CMD_TLBI_EL2_ASID,
+    SMMU_CMD_TLBI_EL2_VA,
+    SMMU_CMD_TLBI_EL2_VAA,  /* 0x23 */
+    SMMU_CMD_TLBI_S12_VMALL  = 0x28,
+    SMMU_CMD_TLBI_S2_IPA     = 0x2a,
+    SMMU_CMD_TLBI_NSNH_ALL   = 0x30,
+    SMMU_CMD_ATC_INV         = 0x40,
+    SMMU_CMD_PRI_RESP,
+    SMMU_CMD_RESUME          = 0x44,
+    SMMU_CMD_STALL_TERM,
+    SMMU_CMD_SYNC,          /* 0x46 */
+};
+
+static const char *cmd_stringify[] = {
+    [SMMU_CMD_PREFETCH_CONFIG] = "SMMU_CMD_PREFETCH_CONFIG",
+    [SMMU_CMD_PREFETCH_ADDR]   = "SMMU_CMD_PREFETCH_ADDR",
+    [SMMU_CMD_CFGI_STE]        = "SMMU_CMD_CFGI_STE",
+    [SMMU_CMD_CFGI_STE_RANGE]  = "SMMU_CMD_CFGI_STE_RANGE",
+    [SMMU_CMD_CFGI_CD]         = "SMMU_CMD_CFGI_CD",
+    [SMMU_CMD_CFGI_CD_ALL]     = "SMMU_CMD_CFGI_CD_ALL",
+    [SMMU_CMD_CFGI_ALL]        = "SMMU_CMD_CFGI_ALL",
+    [SMMU_CMD_TLBI_NH_ALL]     = "SMMU_CMD_TLBI_NH_ALL",
+    [SMMU_CMD_TLBI_NH_ASID]    = "SMMU_CMD_TLBI_NH_ASID",
+    [SMMU_CMD_TLBI_NH_VA]      = "SMMU_CMD_TLBI_NH_VA",
+    [SMMU_CMD_TLBI_NH_VAA]     = "SMMU_CMD_TLBI_NH_VAA",
+    [SMMU_CMD_TLBI_EL3_ALL]    = "SMMU_CMD_TLBI_EL3_ALL",
+    [SMMU_CMD_TLBI_EL3_VA]     = "SMMU_CMD_TLBI_EL3_VA",
+    [SMMU_CMD_TLBI_EL2_ALL]    = "SMMU_CMD_TLBI_EL2_ALL",
+    [SMMU_CMD_TLBI_EL2_ASID]   = "SMMU_CMD_TLBI_EL2_ASID",
+    [SMMU_CMD_TLBI_EL2_VA]     = "SMMU_CMD_TLBI_EL2_VA",
+    [SMMU_CMD_TLBI_EL2_VAA]    = "SMMU_CMD_TLBI_EL2_VAA",
+    [SMMU_CMD_TLBI_S12_VMALL]  = "SMMU_CMD_TLBI_S12_VMALL",
+    [SMMU_CMD_TLBI_S2_IPA]     = "SMMU_CMD_TLBI_S2_IPA",
+    [SMMU_CMD_TLBI_NSNH_ALL]   = "SMMU_CMD_TLBI_NSNH_ALL",
+    [SMMU_CMD_ATC_INV]         = "SMMU_CMD_ATC_INV",
+    [SMMU_CMD_PRI_RESP]        = "SMMU_CMD_PRI_RESP",
+    [SMMU_CMD_RESUME]          = "SMMU_CMD_RESUME",
+    [SMMU_CMD_STALL_TERM]      = "SMMU_CMD_STALL_TERM",
+    [SMMU_CMD_SYNC]            = "SMMU_CMD_SYNC",
+};
+
+/*****************************
+ *  Register Access Primitives
+ *****************************/
+
+static inline void smmu_write64_reg(SMMUV3State *s, uint32_t addr, uint64_t val)
+{
+    addr >>= 2;
+    s->regs[addr] = val & 0xFFFFFFFFULL;
+    s->regs[addr + 1] = val & ~0xFFFFFFFFULL;
+}
+
+static inline void smmu_write_reg(SMMUV3State *s, uint32_t addr, uint64_t val)
+{
+    s->regs[addr >> 2] = val;
+}
+
+static inline uint32_t smmu_read_reg(SMMUV3State *s, uint32_t addr)
+{
+    return s->regs[addr >> 2];
+}
+
+static inline uint64_t smmu_read64_reg(SMMUV3State *s, uint32_t addr)
+{
+    addr >>= 2;
+    return s->regs[addr] | (s->regs[addr + 1] << 32);
+}
+
+#define smmu_read32_reg smmu_read_reg
+#define smmu_write32_reg smmu_write_reg
+
+/*****************************
+ * CMDQ fields
+ *****************************/
+
+enum { /* Command Errors */
+    SMMU_CMD_ERR_NONE = 0,
+    SMMU_CMD_ERR_ILLEGAL,
+    SMMU_CMD_ERR_ABORT
+};
+
+enum { /* Command completion notification */
+    CMD_SYNC_SIG_NONE,
+    CMD_SYNC_SIG_IRQ,
+    CMD_SYNC_SIG_SEV,
+};
+
+#define CMD_TYPE(x)  extract32((x)->word[0], 0, 8)
+#define CMD_SEC(x)   extract32((x)->word[0], 9, 1)
+#define CMD_SEV(x)   extract32((x)->word[0], 10, 1)
+#define CMD_AC(x)    extract32((x)->word[0], 12, 1)
+#define CMD_AB(x)    extract32((x)->word[0], 13, 1)
+#define CMD_CS(x)    extract32((x)->word[0], 12, 2)
+#define CMD_SSID(x)  extract32((x)->word[0], 16, 16)
+#define CMD_SID(x)   ((x)->word[1])
+#define CMD_VMID(x)  extract32((x)->word[1], 0, 16)
+#define CMD_ASID(x)  extract32((x)->word[1], 16, 16)
+#define CMD_STAG(x)  extract32((x)->word[2], 0, 16)
+#define CMD_RESP(x)  extract32((x)->word[2], 11, 2)
+#define CMD_GRPID(x) extract32((x)->word[3], 0, 8)
+#define CMD_SIZE(x)  extract32((x)->word[3], 0, 16)
+#define CMD_LEAF(x)  extract32((x)->word[3], 0, 1)
+#define CMD_SPAN(x)  extract32((x)->word[3], 0, 5)
+#define CMD_ADDR(x) ({                                  \
+            uint64_t addr = (uint64_t)(x)->word[3];     \
+            addr <<= 32;                                \
+            addr |=  extract32((x)->word[3], 12, 20);   \
+            addr;                                       \
+        })
+
+/***************************
+ * Queue Handling
+ ***************************/
+
+typedef enum {
+    CMD_Q_EMPTY,
+    CMD_Q_FULL,
+    CMD_Q_INUSE,
+} SMMUQStatus;
+
+#define Q_ENTRY(q, idx)  (q->base + q->ent_size * idx)
+#define Q_WRAP(q, pc)    ((pc) >> (q)->shift)
+#define Q_IDX(q, pc)     ((pc) & ((1 << (q)->shift) - 1))
+
+static inline SMMUQStatus __smmu_queue_status(SMMUV3State *s, SMMUQueue *q)
+{
+    uint32_t prod = Q_IDX(q, q->prod);
+    uint32_t cons = Q_IDX(q, q->cons);
+
+    if ((prod == cons) && (q->wrap.prod != q->wrap.cons)) {
+        return CMD_Q_FULL;
+    } else if ((prod == cons) && (q->wrap.prod == q->wrap.cons)) {
+        return CMD_Q_EMPTY;
+    }
+    return CMD_Q_INUSE;
+}
+#define smmu_is_q_full(s, q) (__smmu_queue_status(s, q) == CMD_Q_FULL)
+#define smmu_is_q_empty(s, q) (__smmu_queue_status(s, q) == CMD_Q_EMPTY)
+
+static inline int __smmu_q_enabled(SMMUV3State *s, uint32_t q)
+{
+    return smmu_read32_reg(s, SMMU_REG_CR0) & q;
+}
+#define smmu_cmd_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_CMDQ_ENABLE)
+#define smmu_evt_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_EVTQ_ENABLE)
+
+#define SMMU_CMDQ_ERR(s) ((smmu_read32_reg(s, SMMU_REG_GERROR) ^    \
+                           smmu_read32_reg(s, SMMU_REG_GERRORN)) &  \
+                          SMMU_GERROR_CMDQ)
+
+static inline void smmuv3_init_queues(SMMUV3State *s)
+{
+    s->cmdq.prod = 0;
+    s->cmdq.cons = 0;
+    s->cmdq.wrap.prod = 0;
+    s->cmdq.wrap.cons = 0;
+
+    s->evtq.prod = 0;
+    s->evtq.cons = 0;
+    s->evtq.wrap.prod = 0;
+    s->evtq.wrap.cons = 0;
+
+    s->priq.prod = 0;
+    s->priq.cons = 0;
+    s->priq.wrap.prod = 0;
+    s->priq.wrap.cons = 0;
+}
+
+/*****************************
+ * EVTQ fields
+ *****************************/
+
+#define EVT_Q_OVERFLOW        (1 << 31)
+
+#define EVT_SET_TYPE(x, t)    deposit32((x)->word[0], 0, 8, t)
+#define EVT_SET_SID(x, s)     ((x)->word[1] =  s)
+#define EVT_SET_INPUT_ADDR(x, addr) ({                    \
+            (x)->word[5] = (uint32_t)(addr >> 32);        \
+            (x)->word[4] = (uint32_t)(addr & 0xffffffff); \
+            addr;                                         \
+        })
+
+/*****************************
+ * Events
+ *****************************/
+
+enum evt_err {
+    SMMU_EVT_F_UUT    = 0x1,
+    SMMU_EVT_C_BAD_SID,
+    SMMU_EVT_F_STE_FETCH,
+    SMMU_EVT_C_BAD_STE,
+    SMMU_EVT_F_BAD_ATS_REQ,
+    SMMU_EVT_F_STREAM_DISABLED,
+    SMMU_EVT_F_TRANS_FORBIDDEN,
+    SMMU_EVT_C_BAD_SSID,
+    SMMU_EVT_F_CD_FETCH,
+    SMMU_EVT_C_BAD_CD,
+    SMMU_EVT_F_WALK_EXT_ABRT,
+    SMMU_EVT_F_TRANS        = 0x10,
+    SMMU_EVT_F_ADDR_SZ,
+    SMMU_EVT_F_ACCESS,
+    SMMU_EVT_F_PERM,
+    SMMU_EVT_F_TLB_CONFLICT = 0x20,
+    SMMU_EVT_F_CFG_CONFLICT = 0x21,
+    SMMU_EVT_E_PAGE_REQ     = 0x24,
+};
+
+typedef enum evt_err SMMUEvtErr;
+
+/*****************************
+ * Interrupts
+ *****************************/
+
+static inline int __smmu_irq_enabled(SMMUV3State *s, uint32_t q)
+{
+    return smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & q;
+}
+#define smmu_evt_irq_enabled(s)                   \
+    __smmu_irq_enabled(s, SMMU_IRQ_CTRL_EVENT_EN)
+#define smmu_gerror_irq_enabled(s)                  \
+    __smmu_irq_enabled(s, SMMU_IRQ_CTRL_GERROR_EN)
+#define smmu_pri_irq_enabled(s)                 \
+    __smmu_irq_enabled(s, SMMU_IRQ_CTRL_PRI_EN)
+
+static inline bool
+smmu_is_irq_pending(SMMUV3State *s, int irq)
+{
+    return smmu_read32_reg(s, SMMU_REG_GERROR) ^
+        smmu_read32_reg(s, SMMU_REG_GERRORN);
+}
+
+/*****************************
+ * Hash Table
+ *****************************/
+
+static inline gboolean smmu_uint64_equal(gconstpointer v1, gconstpointer v2)
+{
+    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
+}
+
+static inline guint smmu_uint64_hash(gconstpointer v)
+{
+    return (guint)*(const uint64_t *)v;
+}
+
+/*****************************
+ * Misc
+ *****************************/
+
+/**
+ * tg2granule - Decodes the CD translation granule size field according
+ * to the TT in use
+ * @bits: TG0/1 fiels
+ * @tg1: if set, @bits belong to TG1, otherwise belong to TG0
+ */
+static inline int tg2granule(int bits, bool tg1)
+{
+    switch (bits) {
+    case 1:
+        return tg1 ? 14 : 16;
+    case 2:
+        return tg1 ? 12 : 14;
+    case 3:
+        return tg1 ? 16 : 12;
+    default:
+        return 12;
+    }
+}
+
+#define L1STD_L2PTR(stm) ({                                 \
+            uint64_t hi, lo;                            \
+            hi = (stm)->word[1];                        \
+            lo = (stm)->word[0] & ~(uint64_t)0x1f;      \
+            hi << 32 | lo;                              \
+        })
+
+#define L1STD_SPAN(stm) (extract32((stm)->word[0], 0, 4))
+
+/*****************************
+ * Debug
+ *****************************/
+#define ARM_SMMU_DEBUG
+
+#ifdef ARM_SMMU_DEBUG
+static inline void dump_ste(Ste *ste)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(ste->word); i += 2) {
+        trace_smmuv3_dump_ste(i, ste->word[i], i + 1, ste->word[i + 1]);
+    }
+}
+
+static inline void dump_cd(Cd *cd)
+{
+    int i;
+    for (i = 0; i < ARRAY_SIZE(cd->word); i += 2) {
+        trace_smmuv3_dump_cd(i, cd->word[i], i + 1, cd->word[i + 1]);
+    }
+}
+
+static inline void dump_cmd(Cmd *cmd)
+{
+    int i;
+    for (i = 0; i < ARRAY_SIZE(cmd->word); i += 2) {
+        trace_smmuv3_dump_cmd(i, cmd->word[i], i + 1, cmd->word[i + 1]);
+    }
+}
+
+#else
+#define dump_ste(...) do {} while (0)
+#define dump_cd(...) do {} while (0)
+#define dump_cmd(...) do {} while (0)
+#endif /* ARM_SMMU_DEBUG */
+
+#endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
new file mode 100644
index 0000000..639f682
--- /dev/null
+++ b/hw/arm/smmuv3.c
@@ -0,0 +1,1133 @@
+/*
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
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
+#include "hw/pci/pci.h"
+#include "exec/address-spaces.h"
+#include "trace.h"
+#include "qemu/error-report.h"
+
+#include "hw/arm/smmuv3.h"
+#include "smmuv3-internal.h"
+
+static inline int smmu_enabled(SMMUV3State *s)
+{
+    return smmu_read32_reg(s, SMMU_REG_CR0) & SMMU_CR0_SMMU_ENABLE;
+}
+
+/**
+ * smmu_irq_update - update the GERROR register according to
+ * the IRQ and the enable state
+ *
+ * return > 0 when IRQ is supposed to be raised
+ */
+static int smmu_irq_update(SMMUV3State *s, int irq, uint64_t data)
+{
+    uint32_t error = 0;
+
+    if (!smmu_gerror_irq_enabled(s)) {
+        return 0;
+    }
+
+    switch (irq) {
+    case SMMU_IRQ_EVTQ:
+        if (smmu_evt_irq_enabled(s)) {
+            error = SMMU_GERROR_EVENTQ;
+        }
+        break;
+    case SMMU_IRQ_CMD_SYNC:
+        if (smmu_gerror_irq_enabled(s)) {
+            uint32_t err_type = (uint32_t)data;
+
+            if (err_type) {
+                uint32_t regval = smmu_read32_reg(s, SMMU_REG_CMDQ_CONS);
+                smmu_write32_reg(s, SMMU_REG_CMDQ_CONS,
+                                 regval | err_type << SMMU_CMD_CONS_ERR_SHIFT);
+            }
+            error = SMMU_GERROR_CMDQ;
+        }
+        break;
+    case SMMU_IRQ_PRIQ:
+        if (smmu_pri_irq_enabled(s)) {
+            error = SMMU_GERROR_PRIQ;
+        }
+        break;
+    }
+
+    if (error) {
+        uint32_t gerror = smmu_read32_reg(s, SMMU_REG_GERROR);
+        uint32_t gerrorn = smmu_read32_reg(s, SMMU_REG_GERRORN);
+
+        trace_smmuv3_irq_update(error, gerror, gerrorn);
+
+        /* only toggle GERROR if the interrupt is not active */
+        if (!((gerror ^ gerrorn) & error)) {
+            smmu_write32_reg(s, SMMU_REG_GERROR, gerror ^ error);
+        }
+    }
+
+    return error;
+}
+
+static void smmu_irq_raise(SMMUV3State *s, int irq, uint64_t data)
+{
+    trace_smmuv3_irq_raise(irq);
+    if (smmu_irq_update(s, irq, data)) {
+            qemu_irq_raise(s->irq[irq]);
+    }
+}
+
+static MemTxResult smmu_q_read(SMMUQueue *q, void *data)
+{
+    uint64_t addr = Q_ENTRY(q, Q_IDX(q, q->cons));
+    MemTxResult ret;
+
+    ret = smmu_read_sysmem(addr, data, q->ent_size, false);
+    /* TODO if (ret != MEMTX_OK ) handle error */
+
+    q->cons++;
+    if (q->cons == q->entries) {
+        q->cons = 0;
+        q->wrap.cons++;     /* this will toggle */
+    }
+
+    return ret;
+}
+
+static MemTxResult smmu_q_write(SMMUQueue *q, void *data)
+{
+    uint64_t addr = Q_ENTRY(q, Q_IDX(q, q->prod));
+
+    if (q->prod == q->entries) {
+        q->prod = 0;
+        q->wrap.prod++;     /* this will toggle */
+    }
+
+    q->prod++;
+
+    smmu_write_sysmem(addr, data, q->ent_size, false);
+
+    return MEMTX_OK;
+}
+
+static MemTxResult smmu_read_cmdq(SMMUV3State *s, Cmd *cmd)
+{
+    SMMUQueue *q = &s->cmdq;
+    MemTxResult ret = smmu_q_read(q, cmd);
+    uint32_t val = 0;
+
+    val |= (q->wrap.cons << q->shift) | q->cons;
+
+    /* Update consumer pointer */
+    smmu_write32_reg(s, SMMU_REG_CMDQ_CONS, val);
+
+    return ret;
+}
+
+static int smmu_cmdq_consume(SMMUV3State *s)
+{
+    uint32_t error = SMMU_CMD_ERR_NONE;
+
+    trace_smmuv3_cmdq_consume(SMMU_CMDQ_ERR(s), smmu_cmd_q_enabled(s),
+                              s->cmdq.prod, s->cmdq.cons,
+                              s->cmdq.wrap.prod, s->cmdq.wrap.cons);
+
+    if (!smmu_cmd_q_enabled(s)) {
+        return 0;
+    }
+
+    while (!SMMU_CMDQ_ERR(s) && !smmu_is_q_empty(s, &s->cmdq)) {
+        uint32_t type;
+        Cmd cmd;
+
+        if (smmu_read_cmdq(s, &cmd) != MEMTX_OK) {
+            error = SMMU_CMD_ERR_ABORT;
+            break;
+        }
+
+        type = CMD_TYPE(&cmd);
+
+        trace_smmuv3_cmdq_opcode(cmd_stringify[type]);
+
+        switch (CMD_TYPE(&cmd)) {
+        case SMMU_CMD_SYNC:     /* Fallthrough */
+            if (CMD_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
+                smmu_irq_raise(s, SMMU_IRQ_CMD_SYNC, SMMU_CMD_ERR_NONE);
+            } else if (CMD_CS(&cmd) & CMD_SYNC_SIG_SEV) {
+                trace_smmuv3_cmdq_consume_sev();
+            }
+            break;
+        case SMMU_CMD_PREFETCH_CONFIG:
+        case SMMU_CMD_PREFETCH_ADDR:
+        case SMMU_CMD_CFGI_STE:
+        {
+             uint32_t streamid = cmd.word[1];
+
+             trace_smmuv3_cmdq_cfgi_ste(streamid);
+            break;
+        }
+        case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
+        {
+            uint32_t start = cmd.word[1], range, end;
+
+            range = extract32(cmd.word[2], 0, 5);
+            end = start + (1 << (range + 1)) - 1;
+            trace_smmuv3_cmdq_cfgi_ste_range(start, end);
+            break;
+        }
+        case SMMU_CMD_CFGI_CD:
+        case SMMU_CMD_CFGI_CD_ALL:
+            break;
+        case SMMU_CMD_TLBI_NH_ALL:
+        case SMMU_CMD_TLBI_NH_ASID:
+            printf("%s TLBI* replay\n", __func__);
+            break;
+        case SMMU_CMD_TLBI_NH_VA:
+        {
+            int asid = extract32(cmd.word[1], 16, 16);
+            int vmid = extract32(cmd.word[1], 0, 16);
+            uint64_t low = extract32(cmd.word[2], 12, 20);
+            uint64_t high = cmd.word[3];
+            uint64_t addr = high << 32 | (low << 12);
+
+            trace_smmuv3_cmdq_tlbi_nh_va(asid, vmid, addr);
+            break;
+        }
+        case SMMU_CMD_TLBI_NH_VAA:
+        case SMMU_CMD_TLBI_EL3_ALL:
+        case SMMU_CMD_TLBI_EL3_VA:
+        case SMMU_CMD_TLBI_EL2_ALL:
+        case SMMU_CMD_TLBI_EL2_ASID:
+        case SMMU_CMD_TLBI_EL2_VA:
+        case SMMU_CMD_TLBI_EL2_VAA:
+        case SMMU_CMD_TLBI_S12_VMALL:
+        case SMMU_CMD_TLBI_S2_IPA:
+        case SMMU_CMD_TLBI_NSNH_ALL:
+            break;
+        case SMMU_CMD_ATC_INV:
+        case SMMU_CMD_PRI_RESP:
+        case SMMU_CMD_RESUME:
+        case SMMU_CMD_STALL_TERM:
+            trace_smmuv3_unhandled_cmd(type);
+            break;
+        default:
+            error = SMMU_CMD_ERR_ILLEGAL;
+            error_report("Illegal command type: %d, ignoring", CMD_TYPE(&cmd));
+            dump_cmd(&cmd);
+            break;
+        }
+
+        if (error != SMMU_CMD_ERR_NONE) {
+            error_report("CMD Error");
+            break;
+        }
+    }
+
+    if (error) {
+        smmu_irq_raise(s, SMMU_IRQ_GERROR, error);
+    }
+
+    trace_smmuv3_cmdq_consume_out(s->cmdq.wrap.prod, s->cmdq.prod,
+                                  s->cmdq.wrap.cons, s->cmdq.cons);
+
+    return 0;
+}
+
+/**
+ * GERROR is updated when raising an interrupt, GERRORN will be updated
+ * by SW and should match GERROR before normal operation resumes.
+ */
+static void smmu_irq_clear(SMMUV3State *s, uint64_t gerrorn)
+{
+    int irq = SMMU_IRQ_GERROR;
+    uint32_t toggled;
+
+    toggled = smmu_read32_reg(s, SMMU_REG_GERRORN) ^ gerrorn;
+
+    while (toggled) {
+        irq = ctz32(toggled);
+
+        qemu_irq_lower(s->irq[irq]);
+
+        toggled &= toggled - 1;
+    }
+}
+
+static int smmu_evtq_update(SMMUV3State *s)
+{
+    if (!smmu_enabled(s)) {
+        return 0;
+    }
+
+    if (!smmu_is_q_empty(s, &s->evtq)) {
+        if (smmu_evt_irq_enabled(s)) {
+            smmu_irq_raise(s, SMMU_IRQ_EVTQ, 0);
+        }
+    }
+
+    if (smmu_is_q_empty(s, &s->evtq)) {
+        smmu_irq_clear(s, SMMU_GERROR_EVENTQ);
+    }
+
+    return 1;
+}
+
+static void smmu_create_event(SMMUV3State *s, hwaddr iova,
+                              uint32_t sid, bool is_write, int error);
+
+static void smmu_update(SMMUV3State *s)
+{
+    int error = 0;
+
+    /* SMMU starts processing commands even when not enabled */
+    if (!smmu_enabled(s)) {
+        goto check_cmdq;
+    }
+
+    /* EVENT Q updates takes more priority */
+    if ((smmu_evt_q_enabled(s)) && !smmu_is_q_empty(s, &s->evtq)) {
+        trace_smmuv3_update(smmu_is_q_empty(s, &s->evtq), s->evtq.prod,
+                            s->evtq.cons, s->evtq.wrap.prod, s->evtq.wrap.cons);
+        error = smmu_evtq_update(s);
+    }
+
+    if (error) {
+        /* TODO: May be in future we create proper event queue entry */
+        /* an error condition is not a recoverable event, like other devices */
+        error_report("An unfavourable condition");
+        smmu_create_event(s, 0, 0, 0, error);
+    }
+
+check_cmdq:
+    if (smmu_cmd_q_enabled(s) && !SMMU_CMDQ_ERR(s)) {
+        smmu_cmdq_consume(s);
+    } else {
+        trace_smmuv3_update_check_cmd(SMMU_CMDQ_ERR(s));
+    }
+
+}
+
+static void smmu_update_irq(SMMUV3State *s, uint64_t addr, uint64_t val)
+{
+    smmu_irq_clear(s, val);
+
+    smmu_write32_reg(s, SMMU_REG_GERRORN, val);
+
+    trace_smmuv3_update_irq(smmu_is_irq_pending(s, 0),
+                          smmu_read32_reg(s, SMMU_REG_GERROR),
+                          smmu_read32_reg(s, SMMU_REG_GERRORN));
+
+    /* Clear only when no more left */
+    if (!smmu_is_irq_pending(s, 0)) {
+        qemu_irq_lower(s->irq[0]);
+    }
+}
+
+#define SMMU_ID_REG_INIT(s, reg, d) do {        \
+    s->regs[reg >> 2] = d;                      \
+    } while (0)
+
+static void smmuv3_id_reg_init(SMMUV3State *s)
+{
+    uint32_t data =
+        SMMU_IDR0_STLEVEL << SMMU_IDR0_STLEVEL_SHIFT |
+        SMMU_IDR0_TERM    << SMMU_IDR0_TERM_SHIFT    |
+        SMMU_IDR0_STALL   << SMMU_IDR0_STALL_SHIFT   |
+        SMMU_IDR0_VMID16  << SMMU_IDR0_VMID16_SHIFT  |
+        SMMU_IDR0_PRI     << SMMU_IDR0_PRI_SHIFT     |
+        SMMU_IDR0_ASID16  << SMMU_IDR0_ASID16_SHIFT  |
+        SMMU_IDR0_ATS     << SMMU_IDR0_ATS_SHIFT     |
+        SMMU_IDR0_HYP     << SMMU_IDR0_HYP_SHIFT     |
+        SMMU_IDR0_HTTU    << SMMU_IDR0_HTTU_SHIFT    |
+        SMMU_IDR0_COHACC  << SMMU_IDR0_COHACC_SHIFT  |
+        SMMU_IDR0_TTF     << SMMU_IDR0_TTF_SHIFT     |
+        SMMU_IDR0_S1P     << SMMU_IDR0_S1P_SHIFT     |
+        SMMU_IDR0_S2P     << SMMU_IDR0_S2P_SHIFT;
+
+    SMMU_ID_REG_INIT(s, SMMU_REG_IDR0, data);
+
+#define SMMU_QUEUE_SIZE_LOG2  19
+    data =
+        1 << 27 |                    /* Attr Types override */
+        SMMU_QUEUE_SIZE_LOG2 << 21 | /* Cmd Q size */
+        SMMU_QUEUE_SIZE_LOG2 << 16 | /* Event Q size */
+        SMMU_QUEUE_SIZE_LOG2 << 11 | /* PRI Q size */
+        0  << 6 |                    /* SSID not supported */
+        SMMU_IDR1_SIDSIZE;
+
+    SMMU_ID_REG_INIT(s, SMMU_REG_IDR1, data);
+
+    data =
+        SMMU_IDR5_GRAN << SMMU_IDR5_GRAN_SHIFT | SMMU_IDR5_OAS;
+
+    SMMU_ID_REG_INIT(s, SMMU_REG_IDR5, data);
+
+}
+
+static void smmuv3_init(SMMUV3State *s)
+{
+    smmuv3_id_reg_init(s);      /* Update ID regs alone */
+
+    s->sid_size = SMMU_IDR1_SIDSIZE;
+
+    s->cmdq.entries = (smmu_read32_reg(s, SMMU_REG_IDR1) >> 21) & 0x1f;
+    s->cmdq.ent_size = sizeof(Cmd);
+    s->evtq.entries = (smmu_read32_reg(s, SMMU_REG_IDR1) >> 16) & 0x1f;
+    s->evtq.ent_size = sizeof(Evt);
+}
+
+/*
+ * All SMMU data structures are little endian, and are aligned to 8 bytes
+ * L1STE/STE/L1CD/CD, Queue entries in CMDQ/EVTQ/PRIQ
+ */
+static inline int smmu_get_ste(SMMUV3State *s, hwaddr addr, Ste *buf)
+{
+    int ret;
+
+    trace_smmuv3_get_ste(addr);
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+    dump_ste(buf);
+    return ret;
+}
+
+/*
+ * For now we only support CD with a single entry, 'ssid' is used to identify
+ * otherwise
+ */
+static inline int smmu_get_cd(SMMUV3State *s, Ste *ste, uint32_t ssid, Cd *buf)
+{
+    hwaddr addr = STE_CTXPTR(ste);
+    int ret;
+
+    if (STE_S1CDMAX(ste) != 0) {
+        error_report("Multilevel Ctx Descriptor not supported yet");
+    }
+
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+
+    trace_smmuv3_get_cd(addr);
+    dump_cd(buf);
+
+    return ret;
+}
+
+/**
+ * is_ste_consistent - Check validity of STE
+ * according to 6.2.1 Validty of STE
+ * TODO: check the relevance of each check and compliance
+ * with this spec chapter
+ */
+static int is_ste_consistent(SMMUV3State *s, Ste *ste)
+{
+    uint32_t _config = STE_CONFIG(ste);
+    uint32_t ste_vmid, ste_eats, ste_s2s, ste_s1fmt, ste_s2aa64, ste_s1cdmax;
+    uint32_t ste_strw;
+    bool strw_unused, addr_out_of_range, granule_supported;
+    bool config[] = {_config & 0x1, _config & 0x2, _config & 0x3};
+
+    ste_vmid = STE_S2VMID(ste);
+    ste_eats = STE_EATS(ste); /* Enable PCIe ATS trans */
+    ste_s2s = STE_S2S(ste);
+    ste_s1fmt = STE_S1FMT(ste);
+    ste_s2aa64 = STE_S2AA64(ste);
+    ste_s1cdmax = STE_S1CDMAX(ste); /*CD bit # S1ContextPtr */
+    ste_strw = STE_STRW(ste); /* stream world control */
+
+    if (!STE_VALID(ste)) {
+        error_report("STE NOT valid");
+        return false;
+    }
+
+    granule_supported = is_s2granule_valid(ste);
+
+    /* As S1/S2 combinations are supported do not check
+     * corresponding STE config values */
+
+    if (!config[2]) {
+        /* Report abort to device, no event recorded */
+        error_report("STE config 0b000 not implemented");
+        return false;
+    }
+
+    if (!SMMU_IDR1_SIDSIZE && ste_s1cdmax && config[0] &&
+        !SMMU_IDR0_CD2L && (ste_s1fmt == 1 || ste_s1fmt == 2)) {
+        error_report("STE inconsistant, CD mismatch");
+        return false;
+    }
+    if (SMMU_IDR0_ATS && ((_config & 0x3) == 0) &&
+        ((ste_eats == 2 && (_config != 0x7 || ste_s2s)) ||
+        (ste_eats == 1 && !ste_s2s))) {
+        error_report("STE inconsistant, EATS/S2S mismatch");
+        return false;
+    }
+    if (config[0] && (SMMU_IDR1_SIDSIZE &&
+        (ste_s1cdmax > SMMU_IDR1_SIDSIZE))) {
+        error_report("STE inconsistant, SSID out of range");
+        return false;
+    }
+
+    strw_unused = (!SMMU_IDR0_S1P || !SMMU_IDR0_HYP || (_config == 4));
+
+    addr_out_of_range = STE_S2TTB(ste) > MAX_PA(ste);
+
+    if (is_ste_stage2(ste)) {
+        if ((ste_s2aa64 && !is_s2granule_valid(ste)) ||
+            (!ste_s2aa64 && !(SMMU_IDR0_TTF & 0x1)) ||
+            (ste_s2aa64 && !(SMMU_IDR0_TTF & 0x2))  ||
+            ((STE_S2HA(ste) || STE_S2HD(ste)) && !ste_s2aa64) ||
+            ((STE_S2HA(ste) || STE_S2HD(ste)) && !SMMU_IDR0_HTTU) ||
+            (STE_S2HD(ste) && (SMMU_IDR0_HTTU == 1)) || addr_out_of_range) {
+            error_report("STE inconsistant");
+            trace_smmuv3_is_ste_consistent(config[1], granule_supported,
+                                           addr_out_of_range, ste_s2aa64,
+                                           STE_S2HA(ste), STE_S2HD(ste),
+                                           STE_S2TTB(ste));
+            return false;
+        }
+    }
+    if (SMMU_IDR0_S2P && (config[0] == 0 && config[1]) &&
+        (strw_unused || !ste_strw) && !SMMU_IDR0_VMID16 && !(ste_vmid >> 8)) {
+        error_report("STE inconsistant, VMID out of range");
+        return false;
+    }
+
+    return true;
+}
+
+/**
+ * smmu_find_ste - Return the stream table entry associated
+ * to the sid
+ *
+ * @s: smmuv3 handle
+ * @sid: stream ID
+ * @ste: returned stream table entry
+ * Supports linear and 2-level stream table
+ */
+static int smmu_find_ste(SMMUV3State *s, uint16_t sid, Ste *ste)
+{
+    hwaddr addr;
+
+    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
+    /* Check SID range */
+    if (sid > (1 << s->sid_size)) {
+        return SMMU_EVT_C_BAD_SID;
+    }
+    if (s->features & SMMU_FEATURE_2LVL_STE) {
+        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
+        hwaddr l1ptr, l2ptr;
+        STEDesc l1std;
+
+        l1_ste_offset = sid >> s->sid_split;
+        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1ptr = (hwaddr)(s->strtab_base + l1_ste_offset * sizeof(l1std));
+        smmu_read_sysmem(l1ptr, &l1std, sizeof(l1std), false);
+        span = L1STD_SPAN(&l1std);
+
+        if (!span) {
+            /* l2ptr is not valid */
+            error_report("invalid sid=%d (L1STD span=0)", sid);
+            return SMMU_EVT_C_BAD_SID;
+        }
+        max_l2_ste = (1 << span) - 1;
+        l2ptr = L1STD_L2PTR(&l1std);
+        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+                                   l2ptr, l2_ste_offset, max_l2_ste);
+        if (l2_ste_offset > max_l2_ste) {
+            error_report("l2_ste_offset=%d > max_l2_ste=%d",
+                         l2_ste_offset, max_l2_ste);
+            return SMMU_EVT_C_BAD_STE;
+        }
+        addr = L1STD_L2PTR(&l1std) + l2_ste_offset * sizeof(*ste);
+    } else {
+        addr = s->strtab_base + sid * sizeof(*ste);
+    }
+
+    if (smmu_get_ste(s, addr, ste)) {
+        error_report("Unable to Fetch STE");
+        return SMMU_EVT_F_UUT;
+    }
+
+    return 0;
+}
+
+/**
+ * smmu_cfg_populate_s1 - Populate the stage 1 translation config
+ * from the context descriptor
+ */
+static int smmu_cfg_populate_s1(SMMUTransCfg *cfg, Cd *cd)
+{
+    bool s1a64 = CD_AARCH64(cd);
+    int epd0 = CD_EPD0(cd);
+    int tg;
+
+    cfg->stage   = 1;
+    tg           = epd0 ? CD_TG1(cd) : CD_TG0(cd);
+    cfg->tsz     = epd0 ? CD_T1SZ(cd) : CD_T0SZ(cd);
+    cfg->ttbr    = epd0 ? CD_TTB1(cd) : CD_TTB0(cd);
+    cfg->oas     = oas2bits(CD_IPS(cd));
+
+    if (s1a64) {
+        cfg->tsz = MIN(cfg->tsz, 39);
+        cfg->tsz = MAX(cfg->tsz, 16);
+    }
+    cfg->granule_sz = tg2granule(tg, epd0);
+
+    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    /* fix ttbr - make top bits zero*/
+    cfg->ttbr = extract64(cfg->ttbr, 0, cfg->oas);
+    cfg->aa64 = s1a64;
+    cfg->initial_level  = 4 - (64 - cfg->tsz - 4) / (cfg->granule_sz - 3);
+
+    trace_smmuv3_cfg_stage(cfg->stage, cfg->oas, cfg->tsz, cfg->ttbr,
+                           cfg->aa64, cfg->granule_sz, cfg->initial_level);
+
+    return 0;
+}
+
+/**
+ * smmu_cfg_populate_s2 - Populate the stage 2 translation config
+ * from the Stream Table Entry
+ */
+static int smmu_cfg_populate_s2(SMMUTransCfg *cfg, Ste *ste)
+{
+    bool s2a64 = STE_S2AA64(ste);
+    int default_initial_level;
+    int tg;
+
+    cfg->stage = 2;
+
+    tg           = STE_S2TG(ste);
+    cfg->tsz     = STE_S2T0SZ(ste);
+    cfg->ttbr    = STE_S2TTB(ste);
+    cfg->oas     = pa_range(ste);
+
+    cfg->aa64    = s2a64;
+
+    if (s2a64) {
+        cfg->tsz = MIN(cfg->tsz, 39);
+        cfg->tsz = MAX(cfg->tsz, 16);
+    }
+    cfg->granule_sz = tg2granule(tg, 0);
+
+    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    /* fix ttbr - make top bits zero*/
+    cfg->ttbr = extract64(cfg->ttbr, 0, cfg->oas);
+
+    default_initial_level = 4 - (64 - cfg->tsz - 4) / (cfg->granule_sz - 3);
+    cfg->initial_level = ~STE_S2SL0(ste);
+    if (cfg->initial_level  != default_initial_level) {
+        error_report("%s concatenated translation tables at initial S2 lookup"
+                     " not supported", __func__);
+        return -1;
+    }
+
+    trace_smmuv3_cfg_stage(cfg->stage, cfg->oas, cfg->tsz, cfg->ttbr,
+                           cfg->aa64, cfg->granule_sz, cfg->initial_level);
+
+    return 0;
+}
+
+static MemTxResult smmu_write_evtq(SMMUV3State *s, Evt *evt)
+{
+    SMMUQueue *q = &s->evtq;
+    int ret = smmu_q_write(q, evt);
+    uint32_t val = 0;
+
+    val |= (q->wrap.prod << q->shift) | q->prod;
+
+    smmu_write32_reg(s, SMMU_REG_EVTQ_PROD, val);
+
+    return ret;
+}
+
+/*
+ * Events created on the EventQ
+ */
+static void smmu_create_event(SMMUV3State *s, hwaddr iova,
+                              uint32_t sid, bool is_write, int error)
+{
+    SMMUQueue *q = &s->evtq;
+    uint64_t head;
+    Evt evt;
+
+    if (!smmu_evt_q_enabled(s)) {
+        return;
+    }
+
+    EVT_SET_TYPE(&evt, error);
+    EVT_SET_SID(&evt, sid);
+
+    switch (error) {
+    case SMMU_EVT_F_UUT:
+    case SMMU_EVT_C_BAD_STE:
+        break;
+    case SMMU_EVT_C_BAD_CD:
+    case SMMU_EVT_F_CD_FETCH:
+        break;
+    case SMMU_EVT_F_TRANS_FORBIDDEN:
+    case SMMU_EVT_F_WALK_EXT_ABRT:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+    default:
+        break;
+    }
+
+    smmu_write_evtq(s, &evt);
+
+    head = Q_IDX(q, q->prod);
+
+    if (smmu_is_q_full(s, &s->evtq)) {
+        head = q->prod ^ (1 << 31);     /* Set overflow */
+    }
+
+    smmu_write32_reg(s, SMMU_REG_EVTQ_PROD, head);
+
+    smmu_irq_raise(s, SMMU_IRQ_EVTQ, 0);
+}
+
+/**
+ * smmuv3_config_config - Prepare the translation configuration
+ * for the @mr iommu region
+ * @mr: iommu memory region the translation config must be prepared for
+ * @cfg: output translation configuration
+ *
+ * return 0 on success or error code on failure
+ */
+static int smmuv3_decode_config(MemoryRegion *mr, SMMUTransCfg *cfg)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    int sid = smmu_get_sid(sdev);
+    SMMUV3State *s = sdev->smmu;
+    Ste ste;
+    Cd cd;
+    int ret = 0;
+
+    if (!smmu_enabled(s)) {
+        cfg->disabled = true;
+        return 0;
+    }
+    ret = smmu_find_ste(s, sid, &ste);
+    if (ret) {
+        return ret;
+    }
+
+    if (!STE_VALID(&ste)) {
+        return SMMU_EVT_C_BAD_STE;
+    }
+
+    switch (STE_CONFIG(&ste)) {
+    case STE_CONFIG_BYPASS:
+        cfg->bypassed = true;
+        return 0;
+    case STE_CONFIG_S1:
+         break;
+    case STE_CONFIG_S2:
+         break;
+    default: /* reserved, abort, nested */
+        return -1;
+    }
+
+    /* S1 or S2 */
+
+    if (!is_ste_consistent(s, &ste)) {
+        return SMMU_EVT_C_BAD_STE;
+    }
+
+    if (is_ste_stage1(&ste)) {
+        ret = smmu_get_cd(s, &ste, 0, &cd); /* We dont have SSID yet */
+        if (ret) {
+            return ret;
+        }
+
+        if (!is_cd_valid(s, &ste, &cd)) {
+            return SMMU_EVT_C_BAD_CD;
+        }
+        return smmu_cfg_populate_s1(cfg, &cd);
+    }
+
+    return smmu_cfg_populate_s2(cfg, &ste);
+}
+
+static IOMMUTLBEntry smmuv3_translate(MemoryRegion *mr, hwaddr addr,
+                                      IOMMUAccessFlags flag)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    SMMUV3State *s = sdev->smmu;
+    SMMUState *sys = SMMU_SYS_DEV(s);
+    bool is_write = flag & IOMMU_WO;
+    uint16_t sid = 0;
+    SMMUEvtErr ret;
+    SMMUTransCfg cfg = {};
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+
+    ret = smmuv3_decode_config(mr, &cfg);
+    if (ret || cfg.disabled || cfg.bypassed) {
+        goto out;
+    }
+
+    ret = smmu_page_walk(sys, &cfg, &entry, is_write);
+
+    entry.perm = is_write ? IOMMU_RW : IOMMU_RO;
+
+    trace_smmuv3_translate_ok(mr->name, sid, addr,
+                              entry.translated_addr, entry.perm);
+out:
+    if (ret) {
+        error_report("%s translation failed for iova=0x%"PRIx64,
+                     mr->name, addr);
+        smmu_create_event(s, entry.iova, sid, is_write, ret);
+    }
+    return entry;
+}
+
+
+static inline void smmu_update_base_reg(SMMUV3State *s, uint64_t *base,
+                                        uint64_t val)
+{
+    *base = val & ~(SMMU_BASE_RA | 0x3fULL);
+}
+
+static void smmu_update_qreg(SMMUV3State *s, SMMUQueue *q, hwaddr reg,
+                             uint32_t off, uint64_t val, unsigned size)
+{
+   if (size == 8 && off == 0) {
+        smmu_write64_reg(s, reg, val);
+    } else {
+        smmu_write_reg(s, reg, val);
+    }
+
+    switch (off) {
+    case 0:                             /* BASE register */
+        val = smmu_read64_reg(s, reg);
+        q->shift = val & 0x1f;
+        q->entries = 1 << (q->shift);
+        smmu_update_base_reg(s, &q->base, val);
+        break;
+
+    case 8:                             /* PROD */
+        q->prod = Q_IDX(q, val);
+        q->wrap.prod = val >> q->shift;
+    break;
+
+    case 12:                             /* CONS */
+        q->cons = Q_IDX(q, val);
+        q->wrap.cons = val >> q->shift;
+        trace_smmuv3_update_qreg(q->cons, val);
+        break;
+
+    }
+
+    switch (reg) {
+    case SMMU_REG_CMDQ_PROD:            /* should be only for CMDQ_PROD */
+    case SMMU_REG_CMDQ_CONS:            /* but we do it anyway */
+        smmu_update(s);
+        break;
+    }
+}
+
+static void smmu_write_mmio_fixup(SMMUV3State *s, hwaddr *addr)
+{
+    switch (*addr) {
+    case 0x100a8: case 0x100ac:         /* Aliasing => page0 registers */
+    case 0x100c8: case 0x100cc:
+        *addr ^= (hwaddr)0x10000;
+    }
+}
+
+static void smmu_write_mmio(void *opaque, hwaddr addr,
+                            uint64_t val, unsigned size)
+{
+    SMMUState *sys = opaque;
+    SMMUV3State *s = SMMU_V3_DEV(sys);
+    bool update = false;
+
+    smmu_write_mmio_fixup(s, &addr);
+
+    trace_smmuv3_write_mmio(addr, val);
+
+    switch (addr) {
+    case 0xFDC ... 0xFFC:
+    case SMMU_REG_IDR0 ... SMMU_REG_IDR5:
+        trace_smmuv3_write_mmio_idr(addr, val);
+        return;
+
+    case SMMU_REG_GERRORN:
+        smmu_update_irq(s, addr, val);
+        return;
+
+    case SMMU_REG_CR0:
+        smmu_write32_reg(s, SMMU_REG_CR0, val);
+        smmu_write32_reg(s, SMMU_REG_CR0_ACK, val);
+        update = true;
+        break;
+
+    case SMMU_REG_IRQ_CTRL:
+        smmu_write32_reg(s, SMMU_REG_IRQ_CTRL_ACK, val);
+        update = true;
+        break;
+
+    case SMMU_REG_STRTAB_BASE:
+        smmu_update_base_reg(s, &s->strtab_base, val);
+        return;
+
+    case SMMU_REG_STRTAB_BASE_CFG:
+        if (((val >> 16) & 0x3) == 0x1) {
+            s->sid_split = (val >> 6) & 0x1f;
+            s->features |= SMMU_FEATURE_2LVL_STE;
+        }
+        break;
+
+    case SMMU_REG_CMDQ_PROD:
+    case SMMU_REG_CMDQ_CONS:
+    case SMMU_REG_CMDQ_BASE:
+    case SMMU_REG_CMDQ_BASE + 4:
+        smmu_update_qreg(s, &s->cmdq, addr, addr - SMMU_REG_CMDQ_BASE,
+                         val, size);
+        return;
+
+    case SMMU_REG_EVTQ_CONS:            /* fallthrough */
+    {
+        SMMUQueue *evtq = &s->evtq;
+        evtq->cons = Q_IDX(evtq, val);
+        evtq->wrap.cons = Q_WRAP(evtq, val);
+
+        trace_smmuv3_write_mmio_evtq_cons_bef_clear(evtq->prod, evtq->cons,
+                                                    evtq->wrap.prod,
+                                                    evtq->wrap.cons);
+        if (smmu_is_q_empty(s, &s->evtq)) {
+            trace_smmuv3_write_mmio_evtq_cons_after_clear(evtq->prod,
+                                                          evtq->cons,
+                                                          evtq->wrap.prod,
+                                                          evtq->wrap.cons);
+            qemu_irq_lower(s->irq[SMMU_IRQ_EVTQ]);
+        }
+    }
+    case SMMU_REG_EVTQ_BASE:
+    case SMMU_REG_EVTQ_BASE + 4:
+    case SMMU_REG_EVTQ_PROD:
+        smmu_update_qreg(s, &s->evtq, addr, addr - SMMU_REG_EVTQ_BASE,
+                         val, size);
+        return;
+
+    case SMMU_REG_PRIQ_CONS:
+    case SMMU_REG_PRIQ_BASE:
+    case SMMU_REG_PRIQ_BASE + 4:
+    case SMMU_REG_PRIQ_PROD:
+        smmu_update_qreg(s, &s->priq, addr, addr - SMMU_REG_PRIQ_BASE,
+                         val, size);
+        return;
+    }
+
+    if (size == 8) {
+        smmu_write_reg(s, addr, val);
+    } else {
+        smmu_write32_reg(s, addr, (uint32_t)val);
+    }
+
+    if (update) {
+        smmu_update(s);
+    }
+}
+
+static uint64_t smmu_read_mmio(void *opaque, hwaddr addr, unsigned size)
+{
+    SMMUState *sys = opaque;
+    SMMUV3State *s = SMMU_V3_DEV(sys);
+    uint64_t val;
+
+    smmu_write_mmio_fixup(s, &addr);
+
+    /* Primecell/Corelink ID registers */
+    switch (addr) {
+    case 0xFF0 ... 0xFFC:
+    case 0xFDC ... 0xFE4:
+        val = 0;
+        error_report("addr:0x%"PRIx64" val:0x%"PRIx64, addr, val);
+        break;
+
+    default:
+        val = (uint64_t)smmu_read32_reg(s, addr);
+        break;
+
+    case SMMU_REG_STRTAB_BASE ... SMMU_REG_CMDQ_BASE:
+    case SMMU_REG_EVTQ_BASE:
+    case SMMU_REG_PRIQ_BASE ... SMMU_REG_PRIQ_IRQ_CFG1:
+        val = smmu_read64_reg(s, addr);
+        break;
+    }
+
+    trace_smmuv3_read_mmio(addr, val, s->cmdq.cons);
+    return val;
+}
+
+static const MemoryRegionOps smmu_mem_ops = {
+    .read = smmu_read_mmio,
+    .write = smmu_write_mmio,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static void smmu_init_irq(SMMUV3State *s, SysBusDevice *dev)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+        sysbus_init_irq(dev, &s->irq[i]);
+    }
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    uintptr_t key = (uintptr_t)bus;
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_as_by_busptr, &key);
+    SMMUDevice *sdev;
+
+    if (!sbus) {
+        uintptr_t *new_key = g_malloc(sizeof(*new_key));
+
+        *new_key = (uintptr_t)bus;
+        sbus = g_malloc0(sizeof(SMMUPciBus) +
+                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->smmu_as_by_busptr, new_key, sbus);
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        char *name = g_strdup_printf("%s-%d-%d", TYPE_SMMU_V3_DEV,
+                                      pci_bus_num(bus), devfn);
+        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(SMMUDevice));
+
+        sdev->smmu = s;
+        sdev->bus = bus;
+        sdev->devfn = devfn;
+
+        memory_region_init_iommu(&sdev->iommu, OBJECT(s),
+                                 &s->iommu_ops, name, 1ULL << 48);
+        address_space_init(&sdev->as, &sdev->iommu, TYPE_SMMU_V3_DEV);
+    }
+
+    return &sdev->as;
+
+}
+
+static void smmu_init_iommu_as(SMMUV3State *sys)
+{
+    SMMUState *s = SMMU_SYS_DEV(sys);
+    PCIBus *pcibus = pci_find_primary_bus();
+
+    if (pcibus) {
+        pci_setup_iommu(pcibus, smmu_find_add_as, s);
+    } else {
+        error_report("No PCI bus, SMMU is not registered");
+    }
+}
+
+static void smmu_reset(DeviceState *dev)
+{
+    SMMUV3State *s = SMMU_V3_DEV(dev);
+    smmuv3_init(s);
+}
+
+static int smmu_populate_internal_state(void *opaque, int version_id)
+{
+    SMMUV3State *s = opaque;
+
+    smmu_update(s);
+    return 0;
+}
+
+static void smmu_realize(DeviceState *d, Error **errp)
+{
+    SMMUState *sys = SMMU_SYS_DEV(d);
+    SMMUV3State *s = SMMU_V3_DEV(sys);
+    SysBusDevice *dev = SYS_BUS_DEVICE(d);
+
+    sys->iommu_ops.translate = smmuv3_translate;
+    /* Register Access */
+    memset(sys->smmu_as_by_bus_num, 0, sizeof(sys->smmu_as_by_bus_num));
+    memory_region_init_io(&sys->iomem, OBJECT(s),
+                          &smmu_mem_ops, sys, TYPE_SMMU_V3_DEV, 0x20000);
+
+    sys->smmu_as_by_busptr = g_hash_table_new_full(smmu_uint64_hash,
+                                                   smmu_uint64_equal,
+                                                   g_free, g_free);
+    sysbus_init_mmio(dev, &sys->iomem);
+
+    smmuv3_init_queues(s);
+
+    smmu_init_irq(s, dev);
+
+    smmu_init_iommu_as(s);
+}
+
+static const VMStateDescription vmstate_smmuv3 = {
+    .name = "smmuv3",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = smmu_populate_internal_state,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, SMMUV3State, SMMU_NREGS),
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
+
+    dc->reset   = smmu_reset;
+    dc->vmsd    = &vmstate_smmuv3;
+    dc->realize = smmu_realize;
+}
+
+static const TypeInfo smmuv3_type_info = {
+    .name          = TYPE_SMMU_V3_DEV,
+    .parent        = TYPE_SMMU_DEV_BASE,
+    .instance_size = sizeof(SMMUV3State),
+    .instance_init = smmuv3_instance_init,
+    .class_data    = NULL,
+    .class_size    = sizeof(SMMUV3Class),
+    .class_init    = smmuv3_class_init,
+};
+
+static void smmuv3_register_types(void)
+{
+    type_register(&smmuv3_type_info);
+}
+
+type_init(smmuv3_register_types)
+
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7a92f8c..30a817b 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -16,3 +16,37 @@ smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "base
 smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova = 0x%"PRIx64" -> pa = 0x%"PRIx64
 smmu_walk_pgtable(hwaddr iova, bool is_write) "Input addr: 0x%"PRIx64", is_write=%d"
 smmu_walk_pgtable_out(hwaddr addr, uint32_t mask, int perm) "DONE: o/p addr:0x%"PRIx64" mask:0x%x perm:%d"
+
+#hw/arm/smmuv3.c
+smmuv3_irq_update(uint32_t error, uint32_t gerror, uint32_t gerrorn) "<<<< error:0x%x gerror:0x%x gerrorn:0x%x"
+smmuv3_irq_raise(int irq) "irq:%d"
+smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
+smmuv3_cmdq_consume(int error, bool enabled, uint32_t prod, uint32_t cons, uint8_t wrap_prod, uint8_t wrap_cons) "error=%d, enabled=%d prod=%d cons=%d wrap.prod=%d wrap.cons=%d"
+smmuv3_cmdq_consume_details(hwaddr base, uint32_t cons, uint32_t prod, uint32_t word, uint8_t wrap_cons) "CMDQ base: 0x%"PRIx64" cons:%d prod:%d val:0x%x wrap:%d"
+smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
+smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
+smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
+smmuv3_cmdq_tlbi_nh_va(int asid, int vmid, uint64_t addr) "     |_ asid =%d vmid =%d addr=0x%"PRIx64
+smmuv3_cmdq_consume_sev(void) "CMD_SYNC CS=SEV not supported, ignoring"
+smmuv3_cmdq_consume_out(uint8_t prod_wrap, uint32_t prod, uint8_t cons_wrap, uint32_t cons) "prod_wrap:%d, prod:0x%x cons_wrap:%d cons:0x%x"
+smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
+smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
+smmuv3_update_irq(bool is_pending, uint32_t gerror, uint32_t gerrorn) "irq pend: %d gerror:0x%x gerrorn:0x%x"
+smmuv3_is_ste_consistent(bool cfg, bool granule_supported, bool addr_oor, uint32_t aa64, int s2ha, int s2hd, uint64_t s2ttb ) "config[1]:%d gran:%d addr:%d aa64:%d s2ha:%d s2hd:%d s2ttb:0x%"PRIx64
+smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "SID:0x%x features:0x%x, sid_split:0x%x"
+smmuv3_find_ste_2lvl(uint64_t strtab_base, hwaddr l1ptr, int l1_ste_offset, hwaddr l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:%lx l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
+smmuv3_get_ste(hwaddr addr) "STE addr: 0x%"PRIx64
+smmuv3_translate_bypass(const char *n, uint16_t sid, hwaddr addr, bool is_write) "%s sid=%d bypass iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_in(uint16_t sid, int pci_bus_num, hwaddr strtab_base) "SID:0x%x bus:%d strtab_base:0x%"PRIx64
+smmuv3_get_cd(hwaddr addr) "CD addr: 0x%"PRIx64
+smmuv3_translate_ok(const char *n, uint16_t sid, hwaddr iova, hwaddr translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
+smmuv3_update_qreg(uint32_t cons, uint64_t val) "cons written : %d val:0x%"PRIx64
+smmuv3_write_mmio(hwaddr addr, uint64_t val) "addr: 0x%"PRIx64" val:0x%"PRIx64
+smmuv3_write_mmio_idr(hwaddr addr, uint64_t val) "write to RO/Unimpl reg %lx val64:%lx"
+smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_read_mmio(hwaddr addr, uint64_t val, uint32_t cons) "addr: 0x%"PRIx64" val:0x%"PRIx64" cmdq cons:%d"
+smmuv3_dump_ste(int i, uint32_t word0, int j,  uint32_t word1) "STE[%2d]: %#010x\t STE[%2d]: %#010x"
+smmuv3_dump_cd(int i, uint32_t word0, int j,  uint32_t word1) "CD[%2d]: %#010x\t CD[%2d]: %#010x"
+smmuv3_dump_cmd(int i, uint32_t word0, int j,  uint32_t word1) "CMD[%2d]: %#010x\t CMD[%2d]: %#010x"
+smmuv3_cfg_stage(int s, uint32_t oas, uint32_t tsz, uint64_t ttbr, bool aa64, uint32_t granule_sz, int initial_level) "TransCFG stage:%d oas:%d tsz:%d ttbr:0x%"PRIx64"  aa64:%d granule_sz:%d, initial_level = %d"
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
new file mode 100644
index 0000000..1f7d78e
--- /dev/null
+++ b/include/hw/arm/smmuv3.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
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
+
+#define SMMU_NREGS            0x200
+
+typedef struct SMMUQueue {
+     hwaddr base;
+     uint32_t prod;
+     uint32_t cons;
+     union {
+          struct {
+               uint8_t prod:1;
+               uint8_t cons:1;
+          };
+          uint8_t unused;
+     } wrap;
+
+     uint16_t entries;           /* Number of entries */
+     uint8_t  ent_size;          /* Size of entry in bytes */
+     uint8_t  shift;             /* Size in log2 */
+} SMMUQueue;
+
+typedef struct SMMUV3State {
+    SMMUState     smmu_state;
+
+#define SMMU_FEATURE_2LVL_STE (1 << 0)
+    /* Local cache of most-frequently used register */
+    uint32_t     features;
+    uint16_t     sid_size;
+    uint16_t     sid_split;
+    uint64_t     strtab_base;
+
+    uint64_t    regs[SMMU_NREGS];
+
+    qemu_irq     irq[4];
+
+    SMMUQueue    cmdq, evtq, priq;
+
+    /* IOMMU Address space */
+    MemoryRegion iommu;
+    AddressSpace iommu_as;
+    /*
+     * Bus number is not populated in the beginning, hence we need
+     * a mechanism to retrieve the corresponding address space for each
+     * pci device.
+    */
+    GHashTable   *smmu_as_by_busptr;
+} SMMUV3State;
+
+typedef enum {
+    SMMU_IRQ_GERROR,
+    SMMU_IRQ_PRIQ,
+    SMMU_IRQ_EVTQ,
+    SMMU_IRQ_CMD_SYNC,
+} SMMUIrq;
+
+typedef struct {
+    SMMUBaseClass smmu_base_class;
+} SMMUV3Class;
+
+#define TYPE_SMMU_V3_DEV   "smmuv3"
+#define SMMU_V3_DEV(obj) OBJECT_CHECK(SMMUV3State, (obj), TYPE_SMMU_V3_DEV)
+#define SMMU_V3_DEVICE_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_SMMU_V3_DEV)
+
+#endif
-- 
2.5.5
