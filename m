Received: from eggs.gnu.org ([2001:4830:134:3::10]:58986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPW-0004BA-B1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPT-0007JL-7q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBCPT-0007IV-3K
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 12:51:23 +0800
Message-Id: <20180425045129.17449-5-peterx@redhat.com>
In-Reply-To: <20180425045129.17449-1-peterx@redhat.com>
References: <20180425045129.17449-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] intel-iommu: only do page walk for MAP
 notifiers
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

For UNMAP-only IOMMU notifiers, we don't really need to walk the page
tables.  Fasten that procedure by skipping the page table walk.  That
should boost performance for UNMAP-only notifiers like vhost.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h |  2 ++
 hw/i386/intel_iommu.c         | 43 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1a8ba8e415..486e205e79 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -93,6 +93,8 @@ struct VTDAddressSpace {
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
     QLIST_ENTRY(VTDAddressSpace) next;
+    /* Superset of notifier flags that this address space has */
+    IOMMUNotifierFlag notifier_flags;
 };
 
 struct VTDBus {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e4ee211dde..1c252414a9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -138,6 +138,12 @@ static inline void vtd_iommu_unlock(IntelIOMMUState *s)
     qemu_mutex_unlock(&s->iommu_lock);
 }
 
+/* Whether the address space needs to notify new mappings */
+static inline gboolean vtd_as_notify_mappings(VTDAddressSpace *as)
+{
+    return as->notifier_flags & IOMMU_NOTIFIER_MAP;
+}
+
 /* GHashTable functions */
 static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
 {
@@ -1427,14 +1433,35 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
     int ret;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->notifiers_list), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
-            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
-                          vtd_page_invalidate_notify_hook,
-                          (void *)&vtd_as->iommu, true, s->aw_bits);
+            if (vtd_as_notify_mappings(vtd_as)) {
+                /*
+                 * For MAP-inclusive notifiers, we need to walk the
+                 * page table to sync the shadow page table.
+                 */
+                vtd_page_walk(&ce, addr, addr + size,
+                              vtd_page_invalidate_notify_hook,
+                              (void *)&vtd_as->iommu, true, s->aw_bits);
+            } else {
+                /*
+                 * For UNMAP-only notifiers, we don't need to walk the
+                 * page tables.  We just deliver the PSI down to
+                 * invalidate caches.
+                 */
+                IOMMUTLBEntry entry = {
+                    .target_as = &address_space_memory,
+                    .iova = addr,
+                    .translated_addr = 0,
+                    .addr_mask = size - 1,
+                    .perm = IOMMU_NONE,
+                };
+                memory_region_notify_iommu(&vtd_as->iommu, entry);
+            }
         }
     }
 }
@@ -2374,6 +2401,9 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
         exit(1);
     }
 
+    /* Update per-address-space notifier flags */
+    vtd_as->notifier_flags = new;
+
     if (old == IOMMU_NOTIFIER_NONE) {
         /* Insert new ones */
         QLIST_INSERT_HEAD(&s->notifiers_list, vtd_as, next);
@@ -2884,8 +2914,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   PCI_FUNC(vtd_as->devfn),
                                   VTD_CONTEXT_ENTRY_DID(ce.hi),
                                   ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
-                      s->aw_bits);
+        if (vtd_as_notify_mappings(vtd_as)) {
+            /* This is required only for MAP typed notifiers */
+            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
+                          s->aw_bits);
+        }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
-- 
2.14.3
