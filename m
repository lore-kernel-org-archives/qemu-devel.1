Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUz6-0001ya-1n
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUz5-0000tE-6i
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:24 -0400
Date: Wed, 23 May 2018 17:43:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-24-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/28] intel-iommu: only do page walk for MAP
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Peter Xu <peterx@redhat.com>

For UNMAP-only IOMMU notifiers, we don't need to walk the page tables.
Fasten that procedure by skipping the page table walk.  That should
boost performance for UNMAP-only notifiers like vhost.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h |  2 ++
 hw/i386/intel_iommu.c         | 44 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 016e74b..156f35e 100644
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
index 8d4069d..38ccc74 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -138,6 +138,12 @@ static inline void vtd_iommu_unlock(IntelIOMMUState *s)
     qemu_mutex_unlock(&s->iommu_lock);
 }
 
+/* Whether the address space needs to notify new mappings */
+static inline gboolean vtd_as_has_map_notifier(VTDAddressSpace *as)
+{
+    return as->notifier_flags & IOMMU_NOTIFIER_MAP;
+}
+
 /* GHashTable functions */
 static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
 {
@@ -1436,14 +1442,36 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
     int ret;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
-            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
-                          vtd_page_invalidate_notify_hook,
-                          (void *)&vtd_as->iommu, true, s->aw_bits);
+            if (vtd_as_has_map_notifier(vtd_as)) {
+                /*
+                 * As long as we have MAP notifications registered in
+                 * any of our IOMMU notifiers, we need to sync the
+                 * shadow page table.
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
@@ -2383,6 +2411,9 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
         exit(1);
     }
 
+    /* Update per-address-space notifier flags */
+    vtd_as->notifier_flags = new;
+
     if (old == IOMMU_NOTIFIER_NONE) {
         QLIST_INSERT_HEAD(&s->vtd_as_with_notifiers, vtd_as, next);
     } else if (new == IOMMU_NOTIFIER_NONE) {
@@ -2891,8 +2922,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   PCI_FUNC(vtd_as->devfn),
                                   VTD_CONTEXT_ENTRY_DID(ce.hi),
                                   ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
-                      s->aw_bits);
+        if (vtd_as_has_map_notifier(vtd_as)) {
+            /* This is required only for MAP typed notifiers */
+            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
+                          s->aw_bits);
+        }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
-- 
MST
