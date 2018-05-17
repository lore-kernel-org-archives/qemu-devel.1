Received: from eggs.gnu.org ([2001:4830:134:3::10]:59350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEln-0001Ix-NB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElh-00079Z-Tq
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJElh-00077T-L5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:00:13 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:27 +0800
Message-Id: <20180517085927.24925-13-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/12] intel-iommu: new
 sync_shadow_page_table
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

Firstly, introduce the sync_shadow_page_table() helper to resync the
whole shadow page table of an IOMMU address space.  Meanwhile, when we
receive domain invalidation or similar requests (for example, context
entry invalidations, global invalidations, ...), we should not really
run the replay logic, instead we can now use the new sync shadow page
table API to resync the whole shadow page table.

There will be two major differences:

1. We don't unmap-all before walking the page table, we just sync.  The
   global unmap-all can create a very small window that the page table
   is invalid or incomplete

2. We only walk the page table once now (while replay can be triggered
   multiple times depending on how many notifiers there are)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a1a2a009c1..fbb2f763f0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1065,6 +1065,11 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
     return vtd_page_walk(&ce_cache, addr, addr + size, &info);
 }
 
+static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
+{
+    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MAX);
+}
+
 /*
  * Fetch translation type for specific device. Returns <0 if error
  * happens, otherwise return the shifted type to check against
@@ -1397,7 +1402,7 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
     VTDAddressSpace *vtd_as;
 
     QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
-        memory_region_iommu_replay_all(&vtd_as->iommu);
+        vtd_sync_shadow_page_table(vtd_as);
     }
 }
 
@@ -1470,14 +1475,13 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
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
@@ -1535,7 +1539,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
-            memory_region_iommu_replay_all(&vtd_as->iommu);
+            vtd_sync_shadow_page_table(vtd_as);
         }
     }
 }
-- 
2.17.0
