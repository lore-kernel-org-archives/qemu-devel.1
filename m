Received: from eggs.gnu.org ([2001:4830:134:3::10]:59094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPp-0004NJ-7f
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPm-0007Qb-4W
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBCPl-0007QK-VE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:22 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 12:51:27 +0800
Message-Id: <20180425045129.17449-9-peterx@redhat.com>
In-Reply-To: <20180425045129.17449-1-peterx@redhat.com>
References: <20180425045129.17449-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device iova
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

For each VTDAddressSpace, now we maintain what IOVA ranges we have
mapped and what we have not.  With that information, now we only send
MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we know
we have already mapped the range, meanwhile we don't send UNMAP notifies
if we know we never mapped the range at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h |  2 ++
 hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
 hw/i386/trace-events          |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 486e205e79..09a2e94404 100644
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
index a19c18b8d4..8f396a5d13 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -768,12 +768,37 @@ typedef struct {
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
+            /* Skip since we have already mapped this range */
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
 
@@ -2798,6 +2823,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+        vtd_dev_as->iova_tree = it_tree_new();
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2894,6 +2920,8 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
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
2.14.3
