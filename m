Received: from eggs.gnu.org ([2001:4830:134:3::10]:59320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElh-0001AQ-6q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElb-0006yD-3v
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJEla-0006xt-PK
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:07 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:25 +0800
Message-Id: <20180517085927.24925-11-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/12] intel-iommu: simplify page walk logic
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

Let's move the notify_unmap check into the new vtd_page_walk_one()
function so that we can greatly simplify the vtd_page_walk_level()
logic.

No functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 66 ++++++++++++++++++++-----------------------
 hw/i386/trace-events  |  1 -
 2 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5a5175a4ed..272e49ff66 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -779,6 +779,11 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry, vtd_page_walk_info *info)
     };
     DMAMap *mapped = iova_tree_find(as->iova_tree, &target);
 
+    if (entry->perm == IOMMU_NONE && !info->notify_unmap) {
+        trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask);
+        return 0;
+    }
+
     assert(hook_fn);
 
     /* Update local IOVA mapped ranges */
@@ -894,45 +899,34 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
          */
         entry_valid = read_cur | write_cur;
 
-        entry.target_as = &address_space_memory;
-        entry.iova = iova & subpage_mask;
-        entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
-        entry.addr_mask = ~subpage_mask;
-
-        if (vtd_is_last_slpte(slpte, level)) {
-            /* NOTE: this is only meaningful if entry_valid == true */
-            entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
-            if (!entry_valid && !info->notify_unmap) {
-                trace_vtd_page_walk_skip_perm(iova, iova_next);
-                goto next;
-            }
-            ret = vtd_page_walk_one(&entry, info);
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
-                    ret = vtd_page_walk_one(&entry, info);
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
             ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
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
+            entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
+            ret = vtd_page_walk_one(&entry, info);
+        }
+
+        if (ret < 0) {
+            return ret;
         }
 
 next:
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d8194b80e3..e14d06ec83 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -43,7 +43,6 @@ vtd_page_walk_one(uint16_t domain, uint64_t iova, uint64_t gpa, uint64_t mask, i
 vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t translated) "iova 0x%"PRIx64" mask 0x%"PRIx64" translated 0x%"PRIx64
 vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"PRIx64" mask 0x%"PRIx64
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
-vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
-- 
2.17.0
