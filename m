Received: from eggs.gnu.org ([2001:4830:134:3::10]:45325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVe-0002yU-Fg
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVb-0002wm-BL
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVb-0002wO-2V
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:03 -0400
Date: Fri, 16 Jun 2017 18:49:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-6-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] intel_iommu: cleanup
 vtd_{do_}iommu_translate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

First, let vtd_do_iommu_translate() return a status, so that we
explicitly knows whether error occured. Meanwhile, we make sure that
IOMMUTLBEntry is filled in in that.

Then, cleanup vtd_iommu_translate a bit. So even with PT we'll get a log
now. Also, remove useless assignments.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 66 +++++++++++++++++++++++++++---------------
 hw/i386/trace-events           |  1 +
 3 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 0e73a65..f50ecd8 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -384,6 +384,7 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 /* Pagesize of VTD paging structures, including root and context tables */
 #define VTD_PAGE_SHIFT              12
 #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
+#define VTD_PAGE_MASK               (VTD_PAGE_SIZE - 1)
 
 #define VTD_PAGE_SHIFT_4K           12
 #define VTD_PAGE_MASK_4K            (~((1ULL << VTD_PAGE_SHIFT_4K) - 1))
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a650151..24bdd00 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1069,8 +1069,10 @@ out:
  * @devfn: The devfn, which is the  combined of device and function number
  * @is_write: The access is a write operation
  * @entry: IOMMUTLBEntry that contain the addr to be translated and result
+ *
+ * Returns true if translation is successful, otherwise false.
  */
-static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
+static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
                                    uint8_t devfn, hwaddr addr, bool is_write,
                                    IOMMUTLBEntry *entry)
 {
@@ -1104,6 +1106,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         page_mask = iotlb_entry->mask;
         goto out;
     }
+
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
         trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
@@ -1121,7 +1124,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
             } else {
                 vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
             }
-            return;
+            goto error;
         }
         /* Update context-cache */
         trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
@@ -1136,8 +1139,9 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
     if (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH) {
+        entry->iova = addr & VTD_PAGE_MASK;
         entry->translated_addr = entry->iova;
-        entry->addr_mask = VTD_PAGE_SIZE - 1;
+        entry->addr_mask = VTD_PAGE_MASK;
         entry->perm = IOMMU_RW;
         trace_vtd_translate_pt(source_id, entry->iova);
 
@@ -1152,7 +1156,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
          */
         vtd_pt_enable_fast_path(s, source_id);
 
-        return;
+        return true;
     }
 
     ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
@@ -1164,7 +1168,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         } else {
             vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
         }
-        return;
+        goto error;
     }
 
     page_mask = vtd_slpt_level_page_mask(level);
@@ -1175,6 +1179,14 @@ out:
     entry->translated_addr = vtd_get_slpte_addr(slpte) & page_mask;
     entry->addr_mask = ~page_mask;
     entry->perm = IOMMU_ACCESS_FLAG(reads, writes);
+    return true;
+
+error:
+    entry->iova = 0;
+    entry->translated_addr = 0;
+    entry->addr_mask = 0;
+    entry->perm = IOMMU_NONE;
+    return false;
 }
 
 static void vtd_root_table_setup(IntelIOMMUState *s)
@@ -2252,32 +2264,38 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
-    IOMMUTLBEntry ret = {
+    IOMMUTLBEntry iotlb = {
+        /* We'll fill in the rest later. */
         .target_as = &address_space_memory,
-        .iova = addr,
-        .translated_addr = 0,
-        .addr_mask = ~(hwaddr)0,
-        .perm = IOMMU_NONE,
     };
+    bool success;
 
-    if (!s->dmar_enabled) {
+    if (likely(s->dmar_enabled)) {
+        success = vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn,
+                                         addr, flag & IOMMU_WO, &iotlb);
+    } else {
         /* DMAR disabled, passthrough, use 4k-page*/
-        ret.iova = addr & VTD_PAGE_MASK_4K;
-        ret.translated_addr = addr & VTD_PAGE_MASK_4K;
-        ret.addr_mask = ~VTD_PAGE_MASK_4K;
-        ret.perm = IOMMU_RW;
-        return ret;
+        iotlb.iova = addr & VTD_PAGE_MASK_4K;
+        iotlb.translated_addr = addr & VTD_PAGE_MASK_4K;
+        iotlb.addr_mask = ~VTD_PAGE_MASK_4K;
+        iotlb.perm = IOMMU_RW;
+        success = true;
     }
 
-    vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
-                           flag & IOMMU_WO, &ret);
-
-    trace_vtd_dmar_translate(pci_bus_num(vtd_as->bus),
-                             VTD_PCI_SLOT(vtd_as->devfn),
-                             VTD_PCI_FUNC(vtd_as->devfn),
-                             ret.iova, ret.translated_addr, ret.addr_mask);
+    if (likely(success)) {
+        trace_vtd_dmar_translate(pci_bus_num(vtd_as->bus),
+                                 VTD_PCI_SLOT(vtd_as->devfn),
+                                 VTD_PCI_FUNC(vtd_as->devfn),
+                                 iotlb.iova, iotlb.translated_addr,
+                                 iotlb.addr_mask);
+    } else {
+        trace_vtd_err_dmar_translate(pci_bus_num(vtd_as->bus),
+                                     VTD_PCI_SLOT(vtd_as->devfn),
+                                     VTD_PCI_FUNC(vtd_as->devfn),
+                                     iotlb.iova);
+    }
 
-    return ret;
+    return iotlb;
 }
 
 static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 8da20c3..5f111d6 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -73,6 +73,7 @@ vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
 vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
 vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
 vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64
+vtd_err_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova) "dev %02x:%02x.%02x iova 0x%"PRIx64
 vtd_err_qi_enable(uint16_t tail) "tail 0x%"PRIx16
 vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head 0x%"PRIx16" tail 0x%"PRIx16" last_desc_type %d"
 vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail 0x%"PRIx16" size 0x%"PRIx16
-- 
MST
