Received: from eggs.gnu.org ([2001:4830:134:3::10]:59018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPa-0004CV-Ky
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPZ-0007Mh-Oi
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBCPZ-0007MV-J6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:09 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 12:51:25 +0800
Message-Id: <20180425045129.17449-7-peterx@redhat.com>
In-Reply-To: <20180425045129.17449-1-peterx@redhat.com>
References: <20180425045129.17449-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] intel-iommu: pass in address space when
 page walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We pass in the VTDAddressSpace to replace the aw bits when doing page
walk.  The VTDAddressSpace contains the aw bits information, meanwhile
we'll need to do something more in the follow up patches regarding to
the address spaces.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 42f607676c..a19c18b8d4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -756,13 +756,13 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
  * @hook_fn: hook func to be called when detected page
  * @private: private data to be passed into hook func
  * @notify_unmap: whether we should notify invalid entries
- * @aw: maximum address width
+ * @as: VT-d address space of the device
  */
 typedef struct {
+    VTDAddressSpace *as;
     vtd_page_walk_hook hook_fn;
     void *private;
     bool notify_unmap;
-    uint8_t aw;
 } vtd_page_walk_info;
 
 static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
@@ -799,6 +799,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
     uint64_t iova = start;
     uint64_t iova_next;
     int ret = 0;
+    uint8_t aw = info->as->iommu_state->aw_bits;
 
     trace_vtd_page_walk_level(addr, level, start, end);
 
@@ -839,7 +840,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
 
         if (vtd_is_last_slpte(slpte, level)) {
             /* NOTE: this is only meaningful if entry_valid == true */
-            entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
+            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
             if (!entry_valid && !info->notify_unmap) {
                 trace_vtd_page_walk_skip_perm(iova, iova_next);
                 goto next;
@@ -865,7 +866,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
                 }
                 goto next;
             }
-            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
+            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw),
                                       iova, MIN(iova_next, end), level - 1,
                                       read_cur, write_cur, info);
             if (ret < 0) {
@@ -888,19 +889,20 @@ next:
  * @end: IOVA range end address (start <= addr < end)
  * @hook_fn: the hook that to be called for each detected area
  * @private: private data for the hook function
- * @aw: maximum address width
+ * @as: the VT-d address space of the device
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
                          vtd_page_walk_hook hook_fn, void *private,
-                         bool notify_unmap, uint8_t aw)
+                         bool notify_unmap, VTDAddressSpace *as)
 {
     dma_addr_t addr = vtd_ce_get_slpt_base(ce);
     uint32_t level = vtd_ce_get_level(ce);
+    uint8_t aw = as->iommu_state->aw_bits;
     vtd_page_walk_info info = {
         .hook_fn = hook_fn,
         .private = private,
         .notify_unmap = notify_unmap,
-        .aw = aw,
+        .as = as,
     };
 
     if (!vtd_iova_range_check(start, ce, aw)) {
@@ -1464,7 +1466,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                  */
                 vtd_page_walk(&ce, addr, addr + size,
                               vtd_page_invalidate_notify_hook,
-                              (void *)&vtd_as->iommu, true, s->aw_bits);
+                              (void *)&vtd_as->iommu, true, vtd_as);
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -2935,7 +2937,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
         if (vtd_as_notify_mappings(vtd_as)) {
             /* This is required only for MAP typed notifiers */
             vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
-                          s->aw_bits);
+                          vtd_as);
         }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
-- 
2.14.3
