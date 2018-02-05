Received: from eggs.gnu.org ([2001:4830:134:3::10]:50995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih1E-0005RQ-PX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih19-0005xe-Pk
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:41:12 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Feb 2018 14:39:21 +0100
Message-Id: <1517837972-1904-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
References: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v8 03/14] hw/arm/smmu-common: VMSAv8-64 page
 table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: tn@semihalf.com, mst@redhat.com, christoffer.dall@linaro.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, edgar.iglesias@gmail.com, linuc.decode@gmail.com, peterx@redhat.com

This patch implements the page table walk for VMSAv8-64.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- rework get_pte
- use LOG_LEVEL_ERROR
- remove error checking in get_block_pte_address
- page table walk simplified (no VFIO replay anymore)
- handle PTW error events
- use dma_memory_read

v6 -> v7:
- fix wrong error handling in walk_page_table
- check perm in smmu_translate

v5 -> v6:
- use IOMMUMemoryRegion
- remove initial_lookup_level()
- fix block replay

v4 -> v5:
- add initial level in translation config
- implement block pte
- rename must_translate into nofail
- introduce call_entry_hook
- small changes to dynamic traces
- smmu_page_walk code moved from smmuv3.c to this file
- remove smmu_translate*

v3 -> v4:
- reworked page table walk to prepare for VFIO integration
  (capability to scan a range of IOVA). Same function is used
  for translate for a single iova. This is largely inspired
  from intel_iommu.c
- as the translate function was not straightforward to me,
  I tried to stick more closely to the VMSA spec.
- remove support of nested stage (kernel driver does not
  support it anyway)
- use error_report and trace events
- add aa64[] field in SMMUTransCfg
---
 hw/arm/smmu-common.c         | 220 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmu-internal.h       | 104 ++++++++++++++++++++
 hw/arm/trace-events          |  12 +++
 include/hw/arm/smmu-common.h |   6 ++
 4 files changed, 342 insertions(+)
 create mode 100644 hw/arm/smmu-internal.h

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7bf8e57..cb1855f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -31,6 +31,226 @@
 
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
+#include "smmu-internal.h"
+
+/* VMSAv8-64 Translation */
+
+/**
+ * get_pte - Get the content of a page table entry located t
+ * @base_addr[@index]
+ */
+static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
+                   SMMUPTWEventInfo *info)
+{
+    int ret;
+    dma_addr_t addr = baseaddr + index * sizeof(*pte);
+
+    ret = dma_memory_read(&address_space_memory, addr,
+                          (uint8_t *)pte, sizeof(*pte));
+
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
+        info->type = SMMU_PTW_ERR_WALK_EABT;
+        info->addr = addr;
+        return -EINVAL;
+    }
+    trace_smmu_get_pte(baseaddr, index, addr, *pte);
+    return 0;
+}
+
+/* VMSAv8-64 Translation Table Format Descriptor Decoding */
+
+#define PTE_ADDRESS(pte, shift) (extract64(pte, shift, 47 - shift) << shift)
+
+/**
+ * get_page_pte_address - returns the L3 descriptor output address,
+ * ie. the page frame
+ * ARM ARM spec: Figure D4-17 VMSAv8-64 level 3 descriptor format
+ */
+static inline hwaddr get_page_pte_address(uint64_t pte, int granule_sz)
+{
+    return PTE_ADDRESS(pte, granule_sz);
+}
+
+/**
+ * get_table_pte_address - return table descriptor output address,
+ * ie. address of next level table
+ * ARM ARM Figure D4-16 VMSAv8-64 level0, level1, and level 2 descriptor formats
+ */
+static inline hwaddr get_table_pte_address(uint64_t pte, int granule_sz)
+{
+    return PTE_ADDRESS(pte, granule_sz);
+}
+
+/**
+ * get_block_pte_address - return block descriptor output address and block size
+ * ARM ARM Figure D4-16 VMSAv8-64 level0, level1, and level 2 descriptor formats
+ */
+static hwaddr get_block_pte_address(uint64_t pte, int level, int granule_sz,
+                                    uint64_t *bsz)
+{
+    int n = 0;
+
+    switch (granule_sz) {
+    case 12:
+        if (level == 1) {
+            n = 30;
+        } else if (level == 2) {
+            n = 21;
+        }
+        break;
+    case 14:
+        if (level == 2) {
+            n = 25;
+        }
+        break;
+    case 16:
+        if (level == 2) {
+            n = 29;
+        }
+        break;
+    }
+    if (!n) {
+        error_setg(&error_fatal,
+                   "wrong granule/level combination (%d/%d)",
+                   granule_sz, level);
+    }
+    *bsz = 1 << n;
+    return PTE_ADDRESS(pte, n);
+}
+
+static inline bool check_perm(int access_attrs, int mem_attrs)
+{
+    if (((access_attrs & IOMMU_RO) && !(mem_attrs & IOMMU_RO)) ||
+        ((access_attrs & IOMMU_WO) && !(mem_attrs & IOMMU_WO))) {
+        return false;
+    }
+    return true;
+}
+
+SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
+{
+    if (!extract64(iova, 64 - cfg->tt[0].tsz, cfg->tt[0].tsz - cfg->tbi)) {
+        return &cfg->tt[0];
+    }
+    return &cfg->tt[1];
+}
+
+/**
+ * smmu_ptw_64 - VMSAv8-64 Walk of the page tables for a given IOVA
+ * @cfg: translation config
+ * @tlbe: pre-filled IOMMUTLBEntry
+ * @info: handle to an error info
+ *
+ * Return 0 on success, < 0 on error. In case of error @info is filled
+ */
+static int smmu_ptw_64(SMMUTransCfg *cfg, IOMMUTLBEntry *tlbe,
+                       SMMUPTWEventInfo *info)
+{
+    dma_addr_t baseaddr;
+    int stage = cfg->stage;
+    dma_addr_t iova = tlbe->iova;
+    SMMUTransTableInfo *tt = select_tt(cfg, iova);
+    uint8_t level;
+    uint8_t granule_sz;
+
+    if (tt->disabled) {
+        info->type = SMMU_PTW_ERR_TRANSLATION;
+        goto error;
+    }
+
+    level = tt->initial_level;
+    granule_sz = tt->granule_sz;
+    baseaddr = extract64(tt->ttb, 0, 48);
+
+    tlbe->addr_mask = (1 << tt->granule_sz) - 1;
+
+    while (level <= 3) {
+        uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
+        uint64_t mask = subpage_size - 1;
+        uint32_t offset = iova_level_offset(iova, level, granule_sz);
+        uint64_t pte;
+        dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
+
+        trace_smmu_page_walk_level(level, iova, subpage_size,
+                                   baseaddr, offset, pte);
+
+        if (get_pte(baseaddr, offset, &pte, info)) {
+                info->type = SMMU_PTW_ERR_WALK_EABT;
+                info->addr = pte_addr;
+                goto error;
+        }
+        if (is_invalid_pte(pte) || is_reserved_pte(pte, level)) {
+            trace_smmu_page_walk_level_res_invalid_pte(stage, level, baseaddr,
+                                                       pte_addr, offset, pte);
+            info->type = SMMU_PTW_ERR_TRANSLATION;
+            goto error;
+        }
+
+        if (is_page_pte(pte, level)) {
+            uint64_t gpa = get_page_pte_address(pte, granule_sz);
+            if (is_fault(tlbe->perm, pte, true)) {
+                info->type = SMMU_PTW_ERR_PERMISSION;
+                goto error;
+            }
+
+            tlbe->translated_addr = gpa + (iova & mask);
+            trace_smmu_page_walk_level_page_pte(stage, level, iova,
+                                                baseaddr, pte_addr, pte, gpa);
+            return 0;
+        }
+        if (is_block_pte(pte, level)) {
+            uint64_t block_size;
+            hwaddr gpa = get_block_pte_address(pte, level, granule_sz,
+                                               &block_size);
+            if (is_fault(tlbe->perm, pte, true)) {
+                info->type = SMMU_PTW_ERR_PERMISSION;
+                goto error;
+            }
+
+            trace_smmu_page_walk_level_block_pte(stage, level, baseaddr,
+                                                 pte_addr, pte, iova, gpa,
+                                                 (int)(block_size >> 20));
+
+            tlbe->translated_addr = gpa + (iova & mask);
+            return 0;
+        }
+
+        /* table pte */
+        if (is_fault(tlbe->perm, pte, false)) {
+            info->type = SMMU_PTW_ERR_PERMISSION;
+            goto error;
+        }
+        baseaddr = get_table_pte_address(pte, granule_sz);
+        level++;
+    }
+
+    info->type = SMMU_PTW_ERR_TRANSLATION;
+
+error:
+    return -EINVAL;
+}
+
+/**
+ * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
+ *
+ * @cfg: translation configuration
+ * @tlbe: pre-filled entry
+ * @info: ptw event handle
+ *
+ * return 0 on success
+ */
+int smmu_ptw(SMMUTransCfg *cfg, IOMMUTLBEntry *tlbe,
+             SMMUPTWEventInfo *info)
+{
+    if (!cfg->aa64) {
+        error_setg(&error_fatal,
+                   "SMMUv3 model does not support VMSAv8-32 page walk yet");
+    }
+
+    return smmu_ptw_64(cfg, tlbe, info);
+}
 
 SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num)
 {
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
new file mode 100644
index 0000000..7dd3a53
--- /dev/null
+++ b/hw/arm/smmu-internal.h
@@ -0,0 +1,104 @@
+/*
+ * ARM SMMU support - Internal API
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_SMMU_INTERNAL_H
+#define HW_ARM_SMMU_INTERNAL_H
+
+#define ARM_LPAE_MAX_ADDR_BITS          48
+#define ARM_LPAE_MAX_LEVELS             4
+
+/* PTE Manipulation */
+
+#define ARM_LPAE_PTE_TYPE_SHIFT         0
+#define ARM_LPAE_PTE_TYPE_MASK          0x3
+
+#define ARM_LPAE_PTE_TYPE_BLOCK         1
+#define ARM_LPAE_PTE_TYPE_TABLE         3
+
+#define ARM_LPAE_L3_PTE_TYPE_RESERVED      1
+#define ARM_LPAE_L3_PTE_TYPE_PAGE          3
+
+#define ARM_LPAE_PTE_VALID              (1 << 0)
+
+static inline bool is_invalid_pte(uint64_t pte)
+{
+    return !(pte & ARM_LPAE_PTE_VALID);
+}
+
+static inline bool is_reserved_pte(uint64_t pte, int level)
+{
+    return (level == 3) &&
+            ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_RESERVED);
+}
+
+static inline bool is_block_pte(uint64_t pte, int level)
+{
+    return (level < 3) &&
+            ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_PTE_TYPE_BLOCK);
+}
+
+static inline bool is_table_pte(uint64_t pte, int level)
+{
+    return (level < 3) &&
+            ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_PTE_TYPE_TABLE);
+}
+
+static inline bool is_page_pte(uint64_t pte, int level)
+{
+    return (level == 3) &&
+            ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE);
+}
+
+static inline bool is_fault(int perm, uint64_t pte, bool leaf)
+{
+    uint64_t ap; /* AP or APTable */
+
+    if (leaf) {
+        ap = extract64(pte, 6, 2);
+    } else {
+        ap = extract64(pte, 61, 2);
+    }
+    return (perm & IOMMU_WO) && (ap & 0x2);
+}
+
+/* Level Indexing */
+
+static inline int level_shift(int level, int granule_sz)
+{
+    return granule_sz + (3 - level) * (granule_sz - 3);
+}
+
+static inline uint64_t level_page_mask(int level, int granule_sz)
+{
+    return ~((1ULL << level_shift(level, granule_sz)) - 1);
+}
+
+/**
+ * TODO: handle the case where the level resolves less than
+ * granule_sz -3 IA bits.
+ */
+static inline
+uint64_t iova_level_offset(uint64_t iova, int level, int granule_sz)
+{
+    return (iova >> level_shift(level, granule_sz)) &
+            ((1ULL << (granule_sz - 3)) - 1);
+}
+
+#endif
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 193063e..c67cd39 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -2,3 +2,15 @@
 
 # hw/arm/virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+
+# hw/arm/smmu-common.c
+
+smmu_page_walk(int stage, uint64_t baseaddr, int first_level, uint64_t start, uint64_t end) "stage=%d, baseaddr=0x%"PRIx64", first level=%d, start=0x%"PRIx64", end=0x%"PRIx64
+smmu_page_walk_level_in(int level, uint64_t baseaddr, int granule_sz, uint64_t start, uint64_t end, int flags, uint64_t subpage_size) "level=%d baseaddr=0x%"PRIx64" granule=%d, start=0x%"PRIx64" end=0x%"PRIx64" flags=%d subpage_size=0x%lx"
+smmu_page_walk_level(int level, uint64_t iova, size_t subpage_size, uint64_t baseaddr, uint32_t offset, uint64_t pte) "level=%d iova=0x%lx subpage_sz=0x%lx baseaddr=0x%"PRIx64" offset=%d => pte=0x%lx"
+smmu_page_walk_level_res_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint32_t offset, uint64_t pte) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" offset=%d pte=0x%lx"
+smmu_page_walk_level_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
+smmu_page_walk_level_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
+smmu_page_walk_level_table_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d, level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" next table address = 0x%"PRIx64
+smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova = 0x%"PRIx64" -> pa = 0x%"PRIx64
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1495bce..e29ea00 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -129,4 +129,10 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
     return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
 }
+
+int smmu_ptw(SMMUTransCfg *cfg, IOMMUTLBEntry *tlbe,
+             SMMUPTWEventInfo *info);
+
+SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
+
 #endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
