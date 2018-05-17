Received: from eggs.gnu.org ([2001:4830:134:3::10]:59284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEla-00012d-7K
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElX-0006w6-4t
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJElW-0006w1-TE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:24 +0800
Message-Id: <20180517085927.24925-10-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/12] intel-iommu: maintain per-device iova
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
 include/hw/i386/intel_iommu.h |  2 ++
 hw/i386/intel_iommu.c         | 67 +++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |  2 ++
 3 files changed, 71 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9e0a6c1c6a..90190bfaa1 100644
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
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 29fcf2b3a8..5a5175a4ed 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -768,10 +768,71 @@ typedef struct {
 
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
+                 * Translation changed.  This should not happen with
+                 * "intel_iommu=on,strict", but it can happen when
+                 * delayed flushing is used in guest IOMMU driver
+                 * (when without "strict") when page A is reused
+                 * before its previous unmap (the unmap can still be
+                 * queued in the delayed flushing queue).  Now we do
+                 * our best to remap.  Note that there will be a small
+                 * window that we don't have map at all.  But that's
+                 * the best effort we can do, and logically
+                 * well-behaved guests should not really using this
+                 * DMA region yet so we should be very safe.
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
@@ -2804,6 +2865,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+        vtd_dev_as->iova_tree = iova_tree_new();
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2856,6 +2918,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
+    DMAMap map;
 
     /*
      * Note: all the codes in this function has a assumption that IOVA
@@ -2900,6 +2963,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              VTD_PCI_FUNC(as->devfn),
                              entry.iova, size);
 
+    map.iova = entry.iova;
+    map.size = entry.addr_mask;
+    iova_tree_remove(as->iova_tree, &map);
+
     memory_region_notify_one(n, &entry);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ca23ba9fad..d8194b80e3 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -40,6 +40,8 @@ vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint6
 vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
 vtd_page_walk_one(uint16_t domain, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "domain 0x%"PRIu16" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
+vtd_page_walk_one_skip_map(uint64_t iova, uint64_t mask, uint64_t translated) "iova 0x%"PRIx64" mask 0x%"PRIx64" translated 0x%"PRIx64
+vtd_page_walk_one_skip_unmap(uint64_t iova, uint64_t mask) "iova 0x%"PRIx64" mask 0x%"PRIx64
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
-- 
2.17.0
