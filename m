Received: from eggs.gnu.org ([2001:4830:134:3::10]:59331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElj-0001Cz-8q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEle-00072D-GI
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJEle-00070R-5z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:10 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:26 +0800
Message-Id: <20180517085927.24925-12-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/12] intel-iommu: new
 vtd_sync_shadow_page_table_range
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

I pick part of the page walk implementation out into this single
function.  It was only used now for PSIs, but actually it can be used
not only for invalidations but for any place that we want to synchronize
the shadow page table.  No functional change at all.

Here I passed in context entry explicit to avoid fetching it again.
However I enhanced the helper to even be able to fetch it on its own,
since in follow up patches we might call without context entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 65 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 272e49ff66..a1a2a009c1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1018,6 +1018,53 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
+static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
+                                     void *private)
+{
+    memory_region_notify_iommu((IOMMUMemoryRegion *)private, *entry);
+    return 0;
+}
+
+/* If context entry is NULL, we'll try to fetch it on our own. */
+static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
+                                            VTDContextEntry *ce,
+                                            hwaddr addr, hwaddr size)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    vtd_page_walk_info info = {
+        .hook_fn = vtd_sync_shadow_page_hook,
+        .private = (void *)&vtd_as->iommu,
+        .notify_unmap = true,
+        .aw = s->aw_bits,
+        .as = vtd_as,
+    };
+    VTDContextEntry ce_cache;
+    int ret;
+
+    if (ce) {
+        /* If the caller provided context entry, use it */
+        ce_cache = *ce;
+    } else {
+        /* If the caller didn't provide ce, try to fetch */
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce_cache);
+        if (ret) {
+            /*
+             * This should not really happen, but in case it happens,
+             * we just skip the sync for this time.  After all we even
+             * don't have the root table pointer!
+             */
+            trace_vtd_err("Detected invalid context entry when "
+                          "trying to sync shadow page table");
+            return 0;
+        }
+    }
+
+    info.domain_id = VTD_CONTEXT_ENTRY_DID(ce_cache.hi);
+
+    return vtd_page_walk(&ce_cache, addr, addr + size, &info);
+}
+
 /*
  * Fetch translation type for specific device. Returns <0 if error
  * happens, otherwise return the shifted type to check against
@@ -1493,13 +1540,6 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     }
 }
 
-static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
-                                           void *private)
-{
-    memory_region_notify_iommu((IOMMUMemoryRegion *)private, *entry);
-    return 0;
-}
-
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint16_t domain_id, hwaddr addr,
                                            uint8_t am)
@@ -1514,20 +1554,11 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
             if (vtd_as_notify_mappings(vtd_as)) {
-                vtd_page_walk_info info = {
-                    .hook_fn = vtd_page_invalidate_notify_hook,
-                    .private = (void *)&vtd_as->iommu,
-                    .notify_unmap = true,
-                    .aw = s->aw_bits,
-                    .as = vtd_as,
-                    .domain_id = domain_id,
-                };
-
                 /*
                  * For MAP-inclusive notifiers, we need to walk the
                  * page table to sync the shadow page table.
                  */
-                vtd_page_walk(&ce, addr, addr + size, &info);
+                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
-- 
2.17.0
