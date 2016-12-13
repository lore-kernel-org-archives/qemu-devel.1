Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSe-0003Dr-Le
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGhSd-0005wG-Ir
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGhSd-0005w9-DV
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:25:15 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 13 Dec 2016 15:25:02 +0800
Message-Id: <1481613903-17467-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1481613903-17467-1-git-send-email-peterx@redhat.com>
References: <1481613903-17467-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 1/2] intel_iommu: check validity for
 GAW bits in CE
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

Currently vt-d Context Entry (CE) only allows 39/48 bits address width.
If guest software configured more than that, we complain and report.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 17 ++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f3e351..517a2a3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -599,9 +599,19 @@ static inline uint32_t vtd_get_level_from_context_entry(VTDContextEntry *ce)
     return 2 + (ce->hi & VTD_CONTEXT_ENTRY_AW);
 }
 
+/* Return 0 if failed to fetch valid aw */
 static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
 {
-    return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
+    uint8_t aw = (ce->hi & VTD_CONTEXT_ENTRY_AW);
+    /*
+     * According to vt-d spec 10.4.2 bits 12:8, SAGAW only allows
+     * 39/48 bits.
+     */
+    if (aw > VTD_CE_AW_48BIT) {
+        error_report("Context entry address width not supported (aw=%d)" , aw);
+        return 0;
+    }
+    return 30 + aw * 9;
 }
 
 static const uint64_t vtd_paging_entry_rsvd_field[] = {
@@ -642,6 +652,11 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa, bool is_write,
     uint32_t ce_agaw = vtd_get_agaw_from_context_entry(ce);
     uint64_t access_right_check;
 
+    if (!ce_agaw) {
+        error_report("Illegal context entry AGAW");
+        return -VTD_FR_CONTEXT_ENTRY_INV;
+    }
+
     /* Check if @gpa is above 2^X-1, where X is the minimum of MGAW in CAP_REG
      * and AW in context-entry.
      */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 11abfa2..e808c67 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -406,6 +406,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
 /* hi */
 #define VTD_CONTEXT_ENTRY_AW        7ULL /* Adjusted guest-address-width */
+#define VTD_CE_AW_39BIT             1
+#define VTD_CE_AW_48BIT             2
 #define VTD_CONTEXT_ENTRY_DID(val)  (((val) >> 8) & VTD_DOMAIN_ID_MASK)
 #define VTD_CONTEXT_ENTRY_RSVD_HI   0xffffffffff000080ULL
 
-- 
2.7.4
