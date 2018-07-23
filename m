Received: from eggs.gnu.org ([2001:4830:134:3::10]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJ0-0002Br-Kt
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIx-0003eM-S1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:42 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:42 -0500
Message-Id: <20180723201748.25573-34-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 33/99] intel-iommu: rework the page walk logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

This patch fixes a potential small window that the DMA page table might
be incomplete or invalid when the guest sends domain/context
invalidations to a device.  This can cause random DMA errors for
assigned devices.

This is a major change to the VT-d shadow page walking logic. It
includes but is not limited to:

- For each VTDAddressSpace, now we maintain what IOVA ranges we have
  mapped and what we have not.  With that information, now we only send
  MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we
  know we have already mapped the range, meanwhile we don't send UNMAP
  notifies if we know we never mapped the range at all.

- Introduce vtd_sync_shadow_page_table[_range] APIs so that we can call
  in any places to resync the shadow page table for a device.

- When we receive domain/context invalidation, we should not really run
  the replay logic, instead we use the new sync shadow page table API to
  resync the whole shadow page table without unmapping the whole
  region.  After this change, we'll only do the page walk once for each
  domain invalidations (before this, it can be multiple, depending on
  number of notifiers per address space).

While at it, the page walking logic is also refactored to be simpler.

CC: QEMU Stable <qemu-stable@nongnu.org>
Reported-by: Jintack Lim <jintack@cs.columbia.edu>
Tested-by: Jintack Lim <jintack@cs.columbia.edu>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 63b88968f139b6a77f2f81e6f1eedf70c0170a85)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c         | 213 +++++++++++++++++++++++++---------
 hw/i386/trace-events          |   3 +-
 include/hw/i386/intel_iommu.h |   2 +
 3 files changed, 159 insertions(+), 59 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 61bb3d31e7..b5a09b7908 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -769,10 +769,77 @@ typedef struct {
 
 static int vtd_page_walk_one(IOMMUTLBEntry *entry, vtd_page_walk_info *info)
 {
+    VTDAddressSpace *as = info->as;
     vtd_page_walk_hook hook_fn = info->hook_fn;
     void *private = info->private;
+    DMAMap target = {
+        .iova = entry->iova,
+        .size = entry->addr_mask,
+        .translated_addr = entry->translated_addr,
+        .perm = entry->perm,
+    };
+    DMAMap *mapped = iova_tree_find(as->iova_tree, &target);
+
+    if (entry->perm == IOMMU_NONE && !info->notify_unmap) {
+        trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask);
+        return 0;
+    }
 
     assert(hook_fn);
+
+    /* Update local IOVA mapped ranges */
+    if (entry->perm) {
+        if (mapped) {
+            /* If it's exactly the same translation, skip */
+            if (!memcmp(mapped, &target, sizeof(target))) {
+                trace_vtd_page_walk_one_skip_map(entry->iova, entry->addr_mask,
+                                                 entry->translated_addr);
+                return 0;
+            } else {
+                /*
+                 * Translation changed.  Normally this should not
+                 * happen, but it can happen when with buggy guest
+                 * OSes.  Note that there will be a small window that
+                 * we don't have map at all.  But that's the best
+                 * effort we can do.  The ideal way to emulate this is
+                 * atomically modify the PTE to follow what has
+                 * changed, but we can't.  One example is that vfio
+                 * driver only has VFIO_IOMMU_[UN]MAP_DMA but no
+                 * interface to modify a mapping (meanwhile it seems
+                 * meaningless to even provide one).  Anyway, let's
+                 * mark this as a TODO in case one day we'll have
+                 * a better solution.
+                 */
+                IOMMUAccessFlags cache_perm = entry->perm;
+                int ret;
+
+                /* Emulate an UNMAP */
+                entry->perm = IOMMU_NONE;
+                trace_vtd_page_walk_one(info->domain_id,
+                                        entry->iova,
+                                        entry->translated_addr,
+                                        entry->addr_mask,
+                                        entry->perm);
+                ret = hook_fn(entry, private);
+                if (ret) {
+                    return ret;
+                }
+                /* Drop any existing mapping */
+                iova_tree_remove(as->iova_tree, &target);
+                /* Recover the correct permission */
+                entry->perm = cache_perm;
+            }
+        }
+        iova_tree_insert(as->iova_tree, &target);
+    } else {
+        if (!mapped) {
+            /* Skip since we didn't map this range at all */
+            trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask);
+            return 0;
+        }
+        iova_tree_remove(as->iova_tree, &target);
+    }
+
     trace_vtd_page_walk_one(info->domain_id, entry->iova,
                             entry->translated_addr, entry->addr_mask,
                             entry->perm);
@@ -834,45 +901,34 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
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
@@ -964,6 +1020,58 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
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
+static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
+{
+    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MAX);
+}
+
 /*
  * Fetch translation type for specific device. Returns <0 if error
  * happens, otherwise return the shifted type to check against
@@ -1296,7 +1404,7 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
     VTDAddressSpace *vtd_as;
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        memory_region_iommu_replay_all(&vtd_as->iommu);
+        vtd_sync_shadow_page_table(vtd_as);
     }
 }
 
@@ -1371,14 +1479,13 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 vtd_switch_address_space(vtd_as);
                 /*
                  * So a device is moving out of (or moving into) a
-                 * domain, a replay() suites here to notify all the
-                 * IOMMU_NOTIFIER_MAP registers about this change.
+                 * domain, resync the shadow page table.
                  * This won't bring bad even if we have no such
                  * notifier registered - the IOMMU notification
                  * framework will skip MAP notifications if that
                  * happened.
                  */
-                memory_region_iommu_replay_all(&vtd_as->iommu);
+                vtd_sync_shadow_page_table(vtd_as);
             }
         }
     }
@@ -1436,18 +1543,11 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
-            memory_region_iommu_replay_all(&vtd_as->iommu);
+            vtd_sync_shadow_page_table(vtd_as);
         }
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
@@ -1462,21 +1562,12 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
             if (vtd_as_has_map_notifier(vtd_as)) {
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
                  * As long as we have MAP notifications registered in
                  * any of our IOMMU notifiers, we need to sync the
                  * shadow page table.
                  */
-                vtd_page_walk(&ce, addr, addr + size, &info);
+                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -2806,6 +2897,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+        vtd_dev_as->iova_tree = iova_tree_new();
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2858,6 +2950,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
+    DMAMap map;
 
     /*
      * Note: all the codes in this function has a assumption that IOVA
@@ -2902,6 +2995,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              VTD_PCI_FUNC(as->devfn),
                              entry.iova, size);
 
+    map.iova = entry.iova;
+    map.size = entry.addr_mask;
+    iova_tree_remove(as->iova_tree, &map);
+
     memory_region_notify_one(n, &entry);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ca23ba9fad..e14d06ec83 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -40,8 +40,9 @@ vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint6
 vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
 vtd_page_walk_one(uint16_t domain, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "domain 0x%"PRIu16" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
+vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t translated) "iova 0x%"PRIx64" mask 0x%"PRIx64" translated 0x%"PRIx64
+vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"PRIx64" mask 0x%"PRIx64
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
-vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 156f35e919..fbfedcb1c0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -27,6 +27,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
+#include "qemu/iova-tree.h"
 
 #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
 #define INTEL_IOMMU_DEVICE(obj) \
@@ -95,6 +96,7 @@ struct VTDAddressSpace {
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
+    IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
 };
 
 struct VTDBus {
-- 
2.17.1
