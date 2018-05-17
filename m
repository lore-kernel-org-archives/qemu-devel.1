Received: from eggs.gnu.org ([2001:4830:134:3::10]:59211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElK-0000rt-Oe
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElJ-0006q8-EN
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJElJ-0006q4-8s
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:49 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:20 +0800
Message-Id: <20180517085927.24925-6-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/12] intel-iommu: introduce
 vtd_page_walk_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

During the recursive page walking of IOVA page tables, some stack
variables are constant variables and never changed during the whole page
walking procedure.  Isolate them into a struct so that we don't need to
pass those contants down the stack every time and multiple times.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 84 ++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9a418abfb6..4953d02ed0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -747,9 +747,27 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
 
 typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
 
+/**
+ * Constant information used during page walking
+ *
+ * @hook_fn: hook func to be called when detected page
+ * @private: private data to be passed into hook func
+ * @notify_unmap: whether we should notify invalid entries
+ * @aw: maximum address width
+ */
+typedef struct {
+    vtd_page_walk_hook hook_fn;
+    void *private;
+    bool notify_unmap;
+    uint8_t aw;
+} vtd_page_walk_info;
+
 static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
-                             vtd_page_walk_hook hook_fn, void *private)
+                             vtd_page_walk_info *info)
 {
+    vtd_page_walk_hook hook_fn = info->hook_fn;
+    void *private = info->private;
+
     assert(hook_fn);
     trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
                             entry->addr_mask, entry->perm);
@@ -762,17 +780,13 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
  * @addr: base GPA addr to start the walk
  * @start: IOVA range start address
  * @end: IOVA range end address (start <= addr < end)
- * @hook_fn: hook func to be called when detected page
- * @private: private data to be passed into hook func
  * @read: whether parent level has read permission
  * @write: whether parent level has write permission
- * @notify_unmap: whether we should notify invalid entries
- * @aw: maximum address width
+ * @info: constant information for the page walk
  */
 static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
-                               uint64_t end, vtd_page_walk_hook hook_fn,
-                               void *private, uint32_t level, bool read,
-                               bool write, bool notify_unmap, uint8_t aw)
+                               uint64_t end, uint32_t level, bool read,
+                               bool write, vtd_page_walk_info *info)
 {
     bool read_cur, write_cur, entry_valid;
     uint32_t offset;
@@ -822,24 +836,24 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
 
         if (vtd_is_last_slpte(slpte, level)) {
             /* NOTE: this is only meaningful if entry_valid == true */
-            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
-            if (!entry_valid && !notify_unmap) {
+            entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
+            if (!entry_valid && !info->notify_unmap) {
                 trace_vtd_page_walk_skip_perm(iova, iova_next);
                 goto next;
             }
-            ret = vtd_page_walk_one(&entry, level, hook_fn, private);
+            ret = vtd_page_walk_one(&entry, level, info);
             if (ret < 0) {
                 return ret;
             }
         } else {
             if (!entry_valid) {
-                if (notify_unmap) {
+                if (info->notify_unmap) {
                     /*
                      * The whole entry is invalid; unmap it all.
                      * Translated address is meaningless, zero it.
                      */
                     entry.translated_addr = 0x0;
-                    ret = vtd_page_walk_one(&entry, level, hook_fn, private);
+                    ret = vtd_page_walk_one(&entry, level, info);
                     if (ret < 0) {
                         return ret;
                     }
@@ -848,10 +862,9 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
                 }
                 goto next;
             }
-            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw), iova,
-                                      MIN(iova_next, end), hook_fn, private,
-                                      level - 1, read_cur, write_cur,
-                                      notify_unmap, aw);
+            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
+                                      iova, MIN(iova_next, end), level - 1,
+                                      read_cur, write_cur, info);
             if (ret < 0) {
                 return ret;
             }
@@ -870,28 +883,24 @@ next:
  * @ce: context entry to walk upon
  * @start: IOVA address to start the walk
  * @end: IOVA range end address (start <= addr < end)
- * @hook_fn: the hook that to be called for each detected area
- * @private: private data for the hook function
- * @aw: maximum address width
+ * @info: page walking information struct
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
-                         vtd_page_walk_hook hook_fn, void *private,
-                         bool notify_unmap, uint8_t aw)
+                         vtd_page_walk_info *info)
 {
     dma_addr_t addr = vtd_ce_get_slpt_base(ce);
     uint32_t level = vtd_ce_get_level(ce);
 
-    if (!vtd_iova_range_check(start, ce, aw)) {
+    if (!vtd_iova_range_check(start, ce, info->aw)) {
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
-    if (!vtd_iova_range_check(end, ce, aw)) {
+    if (!vtd_iova_range_check(end, ce, info->aw)) {
         /* Fix end so that it reaches the maximum */
-        end = vtd_iova_limit(ce, aw);
+        end = vtd_iova_limit(ce, info->aw);
     }
 
-    return vtd_page_walk_level(addr, start, end, hook_fn, private,
-                               level, true, true, notify_unmap, aw);
+    return vtd_page_walk_level(addr, start, end, level, true, true, info);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1446,13 +1455,18 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
             if (vtd_as_notify_mappings(vtd_as)) {
+                vtd_page_walk_info info = {
+                    .hook_fn = vtd_page_invalidate_notify_hook,
+                    .private = (void *)&vtd_as->iommu,
+                    .notify_unmap = true,
+                    .aw = s->aw_bits,
+                };
+
                 /*
                  * For MAP-inclusive notifiers, we need to walk the
                  * page table to sync the shadow page table.
                  */
-                vtd_page_walk(&ce, addr, addr + size,
-                              vtd_page_invalidate_notify_hook,
-                              (void *)&vtd_as->iommu, true, s->aw_bits);
+                vtd_page_walk(&ce, addr, addr + size, &info);
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -2922,8 +2936,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   ce.hi, ce.lo);
         if (vtd_as_notify_mappings(vtd_as)) {
             /* This is required only for MAP typed notifiers */
-            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
-                          s->aw_bits);
+            vtd_page_walk_info info = {
+                .hook_fn = vtd_replay_hook,
+                .private = (void *)n,
+                .notify_unmap = false,
+                .aw = s->aw_bits,
+            };
+
+            vtd_page_walk(&ce, 0, ~0ULL, &info);
         }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
-- 
2.17.0
