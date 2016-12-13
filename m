Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSh-0003F1-0s
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSf-0005wl-I3
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGhSf-0005wZ-9d
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:17 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 13 Dec 2016 15:25:03 +0800
Message-Id: <1481613903-17467-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1481613903-17467-1-git-send-email-peterx@redhat.com>
References: <1481613903-17467-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 2/2] intel_iommu: provide "aw-bits"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, famz@redhat.com, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, peterx@redhat.com

Previously vt-d codes only supports 39 bits iova address width. This
patch provide a new parameter for Intel IOMMU to extend its address
width to 48 bits.

After enabling larger address width (48), we should be able to map
larger iova addresses in the guest. To check whether 48 bits aw is
enabled, we can grep in the guest dmesg with line: "dmar: Host address
width 48".

To keep compatibility with old QEMU and most hosts, default aw bits are
set to 39 bits.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/acpi-build.c           |  8 +++++++-
 hw/i386/intel_iommu.c          | 21 ++++++++++++++++-----
 hw/i386/intel_iommu_internal.h | 11 ++++-------
 include/hw/i386/intel_iommu.h  |  1 +
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9708cdc..9dd06fd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2576,6 +2576,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
     AcpiTableDmar *dmar;
     AcpiDmarHardwareUnit *drhd;
     uint8_t dmar_flags = 0;
+    uint8_t aw_bits = VTD_HOST_ADDRESS_WIDTH;
     X86IOMMUState *iommu = x86_iommu_get_default();
     AcpiDmarDeviceScope *scope = NULL;
     /* Root complex IOAPIC use one path[0] only */
@@ -2586,8 +2587,13 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
         dmar_flags |= 0x1;      /* Flags: 0x1: INT_REMAP */
     }
 
+    if (iommu->type == TYPE_INTEL) {
+        IntelIOMMUState *intel_iommu = INTEL_IOMMU_DEVICE(iommu);
+        aw_bits = intel_iommu->aw_bits;
+    }
+
     dmar = acpi_data_push(table_data, sizeof(*dmar));
-    dmar->host_address_width = VTD_HOST_ADDRESS_WIDTH - 1;
+    dmar->host_address_width = aw_bits - 1;
     dmar->flags = dmar_flags;
 
     /* DMAR Remapping Hardware Unit Definition structure */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 517a2a3..5d4b7f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -643,7 +643,7 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
  */
 static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa, bool is_write,
                             uint64_t *slptep, uint32_t *slpte_level,
-                            bool *reads, bool *writes)
+                            bool *reads, bool *writes, uint8_t aw_bits)
 {
     dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
     uint32_t level = vtd_get_level_from_context_entry(ce);
@@ -660,7 +660,7 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa, bool is_write,
     /* Check if @gpa is above 2^X-1, where X is the minimum of MGAW in CAP_REG
      * and AW in context-entry.
      */
-    if (gpa & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
+    if (gpa & ~((1ULL << MIN(ce_agaw, aw_bits)) - 1)) {
         VTD_DPRINTF(GENERAL, "error: gpa 0x%"PRIx64 " exceeds limits", gpa);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
@@ -892,7 +892,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     ret_fr = vtd_gpa_to_slpte(&ce, addr, is_write, &slpte, &level,
-                              &reads, &writes);
+                              &reads, &writes, s->aw_bits);
     if (ret_fr) {
         ret_fr = -ret_fr;
         if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
@@ -2033,6 +2033,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
+    DEFINE_PROP_UINT32("aw-bits", IntelIOMMUState, aw_bits, 39),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2395,8 +2396,12 @@ static void vtd_init(IntelIOMMUState *s)
     s->qi_enabled = false;
     s->iq_last_desc_type = VTD_INV_DESC_NONE;
     s->next_frcd_reg = 0;
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_CAP_MGAW |
-             VTD_CAP_SAGAW | VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS;
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
+             VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
+             VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
+    if (s->aw_bits == 48) {
+        s->cap |= VTD_CAP_SAGAW_48bit;
+    }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
     if (x86_iommu->intr_supported) {
@@ -2518,6 +2523,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->aw_bits != 39 && s->aw_bits != 48) {
+        error_setg(errp, "Illegal aw-bits %d (allowed values: 39, 48)",
+                   s->aw_bits);
+        return false;
+    }
+
     return true;
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e808c67..035268d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -131,7 +131,7 @@
 #define VTD_TLB_DID(val)            (((val) >> 32) & VTD_DOMAIN_ID_MASK)
 
 /* IVA_REG */
-#define VTD_IVA_ADDR(val)       ((val) & ~0xfffULL & ((1ULL << VTD_MGAW) - 1))
+#define VTD_IVA_ADDR(val)       ((val) & ~0xfffULL)
 #define VTD_IVA_AM(val)         ((val) & 0x3fULL)
 
 /* GCMD_REG */
@@ -195,8 +195,7 @@
 #define VTD_DOMAIN_ID_SHIFT         16  /* 16-bit domain id for 64K domains */
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
-#define VTD_MGAW                    39  /* Maximum Guest Address Width */
-#define VTD_CAP_MGAW                (((VTD_MGAW - 1) & 0x3fULL) << 16)
+#define VTD_CAP_MGAW(bits)          ((((bits) - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
 #define VTD_CAP_PSI                 (1ULL << 39)
@@ -209,7 +208,6 @@
 #define VTD_CAP_SAGAW_39bit         (0x2ULL << VTD_CAP_SAGAW_SHIFT)
  /* 48-bit AGAW, 4-level page-table */
 #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
-#define VTD_CAP_SAGAW               VTD_CAP_SAGAW_39bit
 
 /* IQT_REG */
 #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
@@ -248,7 +246,7 @@
 #define VTD_FRCD_SID_MASK       0xffffULL
 #define VTD_FRCD_SID(val)       ((val) & VTD_FRCD_SID_MASK)
 /* For the low 64-bit of 128-bit */
-#define VTD_FRCD_FI(val)        ((val) & (((1ULL << VTD_MGAW) - 1) ^ 0xfffULL))
+#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 
 /* DMA Remapping Fault Conditions */
 typedef enum VTDFaultReason {
@@ -355,8 +353,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_DOMAIN       (2ULL << 4)
 #define VTD_INV_DESC_IOTLB_PAGE         (3ULL << 4)
 #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN_ID_MASK)
-#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL & \
-                                         ((1ULL << VTD_MGAW) - 1))
+#define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
 #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 405c9d1..b0bb53a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -290,6 +290,7 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
+    uint32_t aw_bits;               /* IOVA address width (in bits) */
 };
 
 /* Find the VTD Address space associated with the given bus pointer,
-- 
2.7.4
