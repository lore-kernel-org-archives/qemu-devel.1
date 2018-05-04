Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER6C-0002ID-SO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER68-00061f-LV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fER68-00061R-FH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:28 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  4 May 2018 11:08:11 +0800
Message-Id: <20180504030811.28111-11-peterx@redhat.com>
In-Reply-To: <20180504030811.28111-1-peterx@redhat.com>
References: <20180504030811.28111-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/10] intel-iommu: remove notify_unmap for
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
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Now after previous changes, we will always pass that parameter as true
now.  Remove it. After removing that variable, now we can greatly
simplify the page walking logic.

No functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 70 +++++++++++++++++--------------------------
 hw/i386/trace-events  |  1 -
 2 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9439103cac..c156235135 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -759,7 +759,6 @@ typedef struct {
     VTDAddressSpace *as;
     vtd_page_walk_hook hook_fn;
     void *private;
-    bool notify_unmap;
 } vtd_page_walk_info;
 
 static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
@@ -900,45 +899,34 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
          */
         entry_valid = read_cur | write_cur;
 
-        entry.target_as = &address_space_memory;
-        entry.iova = iova & subpage_mask;
-        entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
-        entry.addr_mask = ~subpage_mask;
-
-        if (vtd_is_last_slpte(slpte, level)) {
-            /* NOTE: this is only meaningful if entry_valid == true */
-            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
-            if (!entry_valid && !info->notify_unmap) {
-                trace_vtd_page_walk_skip_perm(iova, iova_next);
-                goto next;
-            }
-            ret = vtd_page_walk_one(&entry, level, info);
-            if (ret < 0) {
-                return ret;
-            }
-        } else {
-            if (!entry_valid) {
-                if (info->notify_unmap) {
-                    /*
-                     * The whole entry is invalid; unmap it all.
-                     * Translated address is meaningless, zero it.
-                     */
-                    entry.translated_addr = 0x0;
-                    ret = vtd_page_walk_one(&entry, level, info);
-                    if (ret < 0) {
-                        return ret;
-                    }
-                } else {
-                    trace_vtd_page_walk_skip_perm(iova, iova_next);
-                }
-                goto next;
-            }
+        if (!vtd_is_last_slpte(slpte, level) && entry_valid) {
+            /*
+             * This is a valid PDE (or even bigger than PDE).  We need
+             * to walk one further level.
+             */
             ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw),
                                       iova, MIN(iova_next, end), level - 1,
                                       read_cur, write_cur, info);
-            if (ret < 0) {
-                return ret;
-            }
+        } else {
+            /*
+             * This means we are either:
+             *
+             * (1) the real page entry (either 4K page, or huge page)
+             * (2) the whole range is invalid
+             *
+             * In either case, we send an IOTLB notification down.
+             */
+            entry.target_as = &address_space_memory;
+            entry.iova = iova & subpage_mask;
+            entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
+            entry.addr_mask = ~subpage_mask;
+            /* NOTE: this is only meaningful if entry_valid == true */
+            entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
+            ret = vtd_page_walk_one(&entry, level, info);
+        }
+
+        if (ret < 0) {
+            return ret;
         }
 
 next:
@@ -960,7 +948,7 @@ next:
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
                          vtd_page_walk_hook hook_fn, void *private,
-                         bool notify_unmap, VTDAddressSpace *as)
+                         VTDAddressSpace *as)
 {
     dma_addr_t addr = vtd_ce_get_slpt_base(ce);
     uint32_t level = vtd_ce_get_level(ce);
@@ -968,7 +956,6 @@ static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
     vtd_page_walk_info info = {
         .hook_fn = hook_fn,
         .private = private,
-        .notify_unmap = notify_unmap,
         .as = as,
     };
 
@@ -1542,7 +1529,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                  */
                 vtd_page_walk(&ce, addr, addr + size,
                               vtd_page_invalidate_notify_hook,
-                              (void *)&vtd_as->iommu, true, vtd_as);
+                              (void *)&vtd_as->iommu, vtd_as);
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -3013,8 +3000,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   ce.hi, ce.lo);
         if (vtd_as_notify_mappings(vtd_as)) {
             /* This is required only for MAP typed notifiers */
-            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, true,
-                          vtd_as);
+            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, vtd_as);
         } else {
             vtd_address_space_unmap(vtd_as, n);
         }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 677f83420d..eb23ace5fb 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -43,7 +43,6 @@ vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, in
 vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t start, uint64_t end) "iova 0x%"PRIx64" mask 0x%"PRIx64" start 0x%"PRIx64" end 0x%"PRIx64
 vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"PRIx64" mask 0x%"PRIx64
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
-vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
-- 
2.17.0
