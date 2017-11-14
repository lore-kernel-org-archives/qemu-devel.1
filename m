Received: from eggs.gnu.org ([2001:4830:134:3::10]:58022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eEkPF-0004QT-2V
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eEkP9-0006fV-Pf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:13 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1eEkP9-0006dL-Di
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:07 -0500
From: prasad.singamsetty@oracle.com
Date: Tue, 14 Nov 2017 18:13:49 -0500
Message-Id: <20171114231350.286025-2-prasad.singamsetty@oracle.com>
In-Reply-To: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
Subject: [Qemu-devel] [PATCH v1 1/2] intel-iommu: Redefine macros to enable
 supporting 48 bit address width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, imammedo@redhat.com
Cc: peterx@redhat.com, konrad.wilk@oracle.com

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

The current implementation of Intel IOMMU code only supports 39 bits
host/iova address width so number of macros use hard coded values based
on that. This patch is to redefine them so they can be used with
variable address widths. This patch doesn't add any new functionality
but enables adding support for 48 bit address width.

Signed-off-by: Prasad Singamsetty <prasad.singamsety@oracle.com>
---
 hw/i386/intel_iommu.c          | 54 ++++++++++++++++++++++++------------------
 hw/i386/intel_iommu_internal.h | 34 +++++++++++++++++++-------
 include/hw/i386/intel_iommu.h  |  6 +++--
 3 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0bc2e..53b3bf244d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -523,7 +523,7 @@ static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
 
 static inline uint64_t vtd_get_slpte_addr(uint64_t slpte)
 {
-    return slpte & VTD_SL_PT_BASE_ADDR_MASK;
+    return slpte & VTD_SL_PT_BASE_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
 }
 
 /* Whether the pte indicates the address of the page frame */
@@ -624,19 +624,12 @@ static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce)
     return !(iova & ~(vtd_iova_limit(ce) - 1));
 }
 
-static const uint64_t vtd_paging_entry_rsvd_field[] = {
-    [0] = ~0ULL,
-    /* For not large page */
-    [1] = 0x800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [2] = 0x800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [3] = 0x800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [4] = 0x880ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    /* For large page */
-    [5] = 0x800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [6] = 0x1ff800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [7] = 0x3ffff800ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-    [8] = 0x880ULL | ~(VTD_HAW_MASK | VTD_SL_IGN_COM),
-};
+/*
+ * Rsvd field masks for spte:
+ *     Index [1] to [4] 4k pages
+ *     Index [5] to [8] large pages
+ */
+static uint64_t vtd_paging_entry_rsvd_field[9];
 
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
@@ -874,7 +867,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return -VTD_FR_ROOT_ENTRY_P;
     }
 
-    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
+    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD(VTD_HOST_ADDRESS_WIDTH))) {
         trace_vtd_re_invalid(re.rsvd, re.val);
         return -VTD_FR_ROOT_ENTRY_RSVD;
     }
@@ -891,7 +884,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     }
 
     if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
-        (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
+               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(VTD_HOST_ADDRESS_WIDTH))) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
@@ -1207,7 +1200,7 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
     s->root_extended = s->root & VTD_RTADDR_RTT;
-    s->root &= VTD_RTADDR_ADDR_MASK;
+    s->root &= VTD_RTADDR_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
 
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
 }
@@ -1223,7 +1216,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
     uint64_t value = 0;
     value = vtd_get_quad_raw(s, DMAR_IRTA_REG);
     s->intr_size = 1UL << ((value & VTD_IRTA_SIZE_MASK) + 1);
-    s->intr_root = value & VTD_IRTA_ADDR_MASK;
+    s->intr_root = value & VTD_IRTA_ADDR_MASK(VTD_HOST_ADDRESS_WIDTH);
     s->intr_eime = value & VTD_IRTA_EIME;
 
     /* Notify global invalidation */
@@ -1479,7 +1472,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     trace_vtd_inv_qi_enable(en);
 
     if (en) {
-        s->iq = iqa_val & VTD_IQA_IQA_MASK;
+        s->iq = iqa_val & VTD_IQA_IQA_MASK(VTD_HOST_ADDRESS_WIDTH);
         /* 2^(x+8) entries */
         s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
         s->qi_enabled = true;
@@ -2772,12 +2765,12 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
      * VT-d spec), otherwise we need to consider overflow of 64 bits.
      */
 
-    if (end > VTD_ADDRESS_SIZE) {
+    if (end > VTD_ADDRESS_SIZE(VTD_HOST_ADDRESS_WIDTH)) {
         /*
          * Don't need to unmap regions that is bigger than the whole
          * VT-d supported address space size
          */
-        end = VTD_ADDRESS_SIZE;
+        end = VTD_ADDRESS_SIZE(VTD_HOST_ADDRESS_WIDTH);
     }
 
     assert(start <= end);
@@ -2866,6 +2859,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
 static void vtd_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+    uint8_t aw_bits = VTD_HOST_ADDRESS_WIDTH;
 
     memset(s->csr, 0, DMAR_REG_SIZE);
     memset(s->wmask, 0, DMAR_REG_SIZE);
@@ -2882,10 +2876,24 @@ static void vtd_init(IntelIOMMUState *s)
     s->qi_enabled = false;
     s->iq_last_desc_type = VTD_INV_DESC_NONE;
     s->next_frcd_reg = 0;
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_CAP_MGAW |
-             VTD_CAP_SAGAW | VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS;
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
+             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
+             VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(VTD_HOST_ADDRESS_WIDTH);
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
+    /*
+     * Rsvd field masks for spte
+     */
+    vtd_paging_entry_rsvd_field[0] = ~0ULL;
+    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(aw_bits);
+    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(aw_bits);
+
     if (x86_iommu->intr_supported) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
         if (s->intr_eim == ON_OFF_AUTO_ON) {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 0e73a65bf2..77e4a9833a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -172,10 +172,10 @@
 
 /* RTADDR_REG */
 #define VTD_RTADDR_RTT              (1ULL << 11)
-#define VTD_RTADDR_ADDR_MASK        (VTD_HAW_MASK ^ 0xfffULL)
+#define VTD_RTADDR_ADDR_MASK(aw)    (VTD_HAW_MASK(aw) ^ 0xfffULL)
 
 /* IRTA_REG */
-#define VTD_IRTA_ADDR_MASK          (VTD_HAW_MASK ^ 0xfffULL)
+#define VTD_IRTA_ADDR_MASK(aw)      (VTD_HAW_MASK(aw) ^ 0xfffULL)
 #define VTD_IRTA_EIME               (1ULL << 11)
 #define VTD_IRTA_SIZE_MASK          (0xfULL)
 
@@ -198,8 +198,8 @@
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
 #define VTD_MGAW                    39  /* Maximum Guest Address Width */
-#define VTD_ADDRESS_SIZE            (1ULL << VTD_MGAW)
-#define VTD_CAP_MGAW                (((VTD_MGAW - 1) & 0x3fULL) << 16)
+#define VTD_ADDRESS_SIZE(aw)        (1ULL << (aw))
+#define VTD_CAP_MGAW(aw)            ((((aw) - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
 #define VTD_CAP_PSI                 (1ULL << 39)
@@ -219,7 +219,7 @@
 #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
 
 /* IQA_REG */
-#define VTD_IQA_IQA_MASK            (VTD_HAW_MASK ^ 0xfffULL)
+#define VTD_IQA_IQA_MASK(aw)        (VTD_HAW_MASK(aw) ^ 0xfffULL)
 #define VTD_IQA_QS                  0x7ULL
 
 /* IQH_REG */
@@ -373,6 +373,24 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
 
+/* Rsvd field masks for spte */
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_PAGE_L3_RSVD_MASK(aw) \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
+        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
+        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
+        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
+        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
+        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -403,7 +421,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_ROOT_ENTRY_CTP          (~0xfffULL)
 
 #define VTD_ROOT_ENTRY_NR           (VTD_PAGE_SIZE / sizeof(VTDRootEntry))
-#define VTD_ROOT_ENTRY_RSVD         (0xffeULL | ~VTD_HAW_MASK)
+#define VTD_ROOT_ENTRY_RSVD(aw)     (0xffeULL | ~VTD_HAW_MASK(aw))
 
 /* Masks for struct VTDContextEntry */
 /* lo */
@@ -415,7 +433,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CONTEXT_TT_PASS_THROUGH (2ULL << 2)
 /* Second Level Page Translation Pointer*/
 #define VTD_CONTEXT_ENTRY_SLPTPTR   (~0xfffULL)
-#define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
+#define VTD_CONTEXT_ENTRY_RSVD_LO(aw) (0xff0ULL | ~VTD_HAW_MASK(aw))
 /* hi */
 #define VTD_CONTEXT_ENTRY_AW        7ULL /* Adjusted guest-address-width */
 #define VTD_CONTEXT_ENTRY_DID(val)  (((val) >> 8) & VTD_DOMAIN_ID_MASK)
@@ -439,7 +457,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_RW_MASK              3ULL
 #define VTD_SL_R                    1ULL
 #define VTD_SL_W                    (1ULL << 1)
-#define VTD_SL_PT_BASE_ADDR_MASK    (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK)
+#define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
 
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index ac15e6be14..372b06df45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -46,8 +46,10 @@
 #define VTD_SID_TO_DEVFN(sid)       ((sid) & 0xff)
 
 #define DMAR_REG_SIZE               0x230
-#define VTD_HOST_ADDRESS_WIDTH      39
-#define VTD_HAW_MASK                ((1ULL << VTD_HOST_ADDRESS_WIDTH) - 1)
+#define VTD_HOST_AW_39BIT           39
+#define VTD_HOST_AW_48BIT           48
+#define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
+#define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
 
-- 
2.14.0-rc1
