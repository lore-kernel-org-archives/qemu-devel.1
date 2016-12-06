Received: from eggs.gnu.org ([2001:4830:134:3::10]:54937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7g-0007ho-5T
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED7f-00023W-7z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED7f-00023B-0J
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:37:19 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:28 +0800
Message-Id: <1481020588-4245-14-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 13/13] intel_iommu: use page_walk for iotlb
 inv notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

Instead of translate() every page for iotlb invalidations (which is
slower), we walk the pages when needed and notify in a hook function.
This will also simplify the code a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 64 +++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0220e63..226dbcd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -149,23 +149,6 @@ static uint64_t vtd_set_clear_mask_quad(IntelIOMMUState *s, hwaddr addr,
     return new_val;
 }
 
-static int vtd_get_did_dev(IntelIOMMUState *s, uint8_t bus_num, uint8_t devfn,
-                           uint16_t *domain_id)
-{
-    VTDContextEntry ce;
-    int ret_fr;
-
-    assert(domain_id);
-
-    ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
-    if (ret_fr) {
-        return -1;
-    }
-
-    *domain_id =  VTD_CONTEXT_ENTRY_DID(ce.hi);
-    return 0;
-}
-
 /* GHashTable functions */
 static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
 {
@@ -868,7 +851,8 @@ next:
  * @private: private data for the hook function
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
-                         vtd_page_walk_hook hook_fn, void *private)
+                         vtd_page_walk_hook hook_fn, void *private,
+                         bool notify_unmap)
 {
     dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
     uint32_t level = vtd_get_level_from_context_entry(ce);
@@ -887,7 +871,7 @@ static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
     trace_vtd_page_walk(ce->hi, ce->lo, start, end);
 
     return vtd_page_walk_level(addr, start, end, hook_fn, private,
-                               level, true, true, NULL, false);
+                               level, true, true, NULL, notify_unmap);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1238,39 +1222,29 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
                                 &domain_id);
 }
 
+static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
+                                           void *private)
+{
+    memory_region_notify_iommu((MemoryRegion *)private, *entry);
+    return 0;
+}
+
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint16_t domain_id, hwaddr addr,
                                            uint8_t am)
 {
     IntelIOMMUNotifierNode *node;
+    VTDContextEntry ce;
+    int ret;
 
     QLIST_FOREACH(node, &(s->notifiers_list), next) {
         VTDAddressSpace *vtd_as = node->vtd_as;
-        uint16_t vfio_domain_id;
-        int ret = vtd_get_did_dev(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
-                                  &vfio_domain_id);
-        if (!ret && domain_id == vfio_domain_id) {
-            hwaddr original_addr = addr;
-
-            while (addr < original_addr + (1 << am) * VTD_PAGE_SIZE) {
-                IOMMUTLBEntry entry = s->iommu_ops.translate(
-                                                         &node->vtd_as->iommu,
-                                                         addr,
-                                                         IOMMU_NO_FAIL);
-
-                if (entry.perm == IOMMU_NONE &&
-                        node->notifier_flag & IOMMU_NOTIFIER_UNMAP) {
-                    entry.target_as = &address_space_memory;
-                    entry.iova = addr & VTD_PAGE_MASK_4K;
-                    entry.translated_addr = 0;
-                    entry.addr_mask = ~VTD_PAGE_MASK(VTD_PAGE_SHIFT);
-                    memory_region_notify_iommu(&node->vtd_as->iommu, entry);
-                    addr += VTD_PAGE_SIZE;
-                } else if (node->notifier_flag & IOMMU_NOTIFIER_MAP) {
-                        memory_region_notify_iommu(&node->vtd_as->iommu, entry);
-                        addr += entry.addr_mask + 1;
-                }
-            }
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
+                          vtd_page_invalidate_notify_hook,
+                          (void *)&vtd_as->iommu, true);
         }
     }
 }
@@ -2623,7 +2597,7 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
          */
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn), ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
+        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
-- 
2.7.4
