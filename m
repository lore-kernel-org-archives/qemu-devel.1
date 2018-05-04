Received: from eggs.gnu.org ([2001:4830:134:3::10]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5u-00020H-0Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fER5s-0005qO-EF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fER5s-0005q7-8y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:09:12 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  4 May 2018 11:08:09 +0800
Message-Id: <20180504030811.28111-9-peterx@redhat.com>
In-Reply-To: <20180504030811.28111-1-peterx@redhat.com>
References: <20180504030811.28111-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/10] intel-iommu: maintain per-device iova
 ranges
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

For each VTDAddressSpace, now we maintain what IOVA ranges we have
mapped and what we have not.  With that information, now we only send
MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we know
we have already mapped the range, meanwhile we don't send UNMAP notifies
if we know we never mapped the range at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h |  2 +
 hw/i386/intel_iommu.c         | 73 +++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |  2 +
 3 files changed, 77 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9e0a6c1c6a..5e54f4fae2 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -27,6 +27,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
+#include "qemu/interval-tree.h"
 
 #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
 #define INTEL_IOMMU_DEVICE(obj) \
@@ -95,6 +96,7 @@ struct VTDAddressSpace {
     QLIST_ENTRY(VTDAddressSpace) next;
     /* Superset of notifier flags that this address space has */
     IOMMUNotifierFlag notifier_flags;
+    ITTree *iova_tree;          /* Traces mapped IOVA ranges */
 };
 
 struct VTDBus {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83769f2b8c..16b3514afb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -765,12 +765,82 @@ typedef struct {
 static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
                              vtd_page_walk_info *info)
 {
+    VTDAddressSpace *as = info->as;
     vtd_page_walk_hook hook_fn = info->hook_fn;
     void *private = info->private;
+    ITRange *mapped = it_tree_find(as->iova_tree, entry->iova,
+                                   entry->iova + entry->addr_mask);
 
     assert(hook_fn);
+
+    /* Update local IOVA mapped ranges */
+    if (entry->perm) {
+        if (mapped) {
+            /*
+             * Skip since we have already mapped this range.
+             *
+             * NOTE: here we didn't solve the modify-PTE problem. For
+             * example:
+             *
+             * (1) map iova1 to 4K page P1
+             * (2) send PSI on (iova1, iova1 + 4k)
+             * (3) modify iova1 to 4K page P2
+             * (4) send PSI on (iova1, iova1 + 4k)
+             *
+             * Logically QEMU as emulator should atomically modify the
+             * shadow page table PTE to follow what has been changed.
+             * However here actually we will never have a way to
+             * emulate this "atomic PTE modification" procedure.
+             * Because even we know that this PTE is changed we'll
+             * still need to unmap it first then remap it (please
+             * refer to VFIO_IOMMU_MAP_DMA and VFIO_IOMMU_UNMAP_DMA
+             * VFIO APIs as an example).  And there is no such API to
+             * atomically update an IOMMU PTE on the host.  Then we'll
+             * have a small window that we still have invalid page
+             * mapping (while ideally we shoudn't).
+             *
+             * With out current code, on step (4) we just ignored the
+             * PTE update and we'll skip the map update, which will
+             * leave stale mappings.
+             *
+             * Modifying PTEs won't happen on general OSs (e.g.,
+             * Linux) - it should be prohibited since the device may
+             * be using the page table during the modification then
+             * the behavior of modifying PTEs could be undefined.
+             * However it's still possible for other guests to do so.
+             *
+             * Let's mark this as TODO.  After all it should never
+             * happen on general OSs like Linux/Windows/... Meanwhile
+             * even if the guest is running a private and problematic
+             * OS, the stale page (P1) will definitely still be a
+             * valid page for current L1 QEMU, so the worst case is
+             * that L1 guest will be at risk on its own on that single
+             * device only.  It'll never harm the rest of L1 guest,
+             * the host memory or other guests on the host.
+             *
+             * Let's solve this once-and-for-all when we really
+             * needed, and when we are capable of (for now, we can't).
+             * Though I would suspect that won't happen soon.
+             */
+            trace_vtd_page_walk_one_skip_map(entry->iova, entry->addr_mask,
+                                             mapped->start, mapped->end);
+            return 0;
+        }
+        it_tree_insert(as->iova_tree, entry->iova,
+                       entry->iova + entry->addr_mask);
+    } else {
+        if (!mapped) {
+            /* Skip since we didn't map this range at all */
+            trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask);
+            return 0;
+        }
+        it_tree_remove(as->iova_tree, entry->iova,
+                       entry->iova + entry->addr_mask);
+    }
+
     trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
                             entry->addr_mask, entry->perm);
+
     return hook_fn(entry, private);
 }
 
@@ -2804,6 +2874,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+        vtd_dev_as->iova_tree = it_tree_new();
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2900,6 +2971,8 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              VTD_PCI_FUNC(as->devfn),
                              entry.iova, size);
 
+    it_tree_remove(as->iova_tree, entry.iova, entry.iova + entry.addr_mask);
+
     memory_region_notify_one(n, &entry);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 22d44648af..677f83420d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -40,6 +40,8 @@ vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint6
 vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
 vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "detected page level 0x%"PRIx32" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
+vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t start, uint64_t end) "iova 0x%"PRIx64" mask 0x%"PRIx64" start 0x%"PRIx64" end 0x%"PRIx64
+vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"PRIx64" mask 0x%"PRIx64
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
-- 
2.17.0
