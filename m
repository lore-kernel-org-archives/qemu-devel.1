Received: from eggs.gnu.org ([2001:4830:134:3::10]:59132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEl7-0000hz-97
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEl6-0006cG-CT
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJEl6-0006c7-77
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:36 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:16 +0800
Message-Id: <20180517085927.24925-2-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/12] intel-iommu: send PSI always even if
 across PDEs
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

During IOVA page table walking, there is a special case when the PSI
covers one whole PDE (Page Directory Entry, which contains 512 Page
Table Entries) or more.  In the past, we skip that entry and we don't
notify the IOMMU notifiers.  This is not correct.  We should send UNMAP
notification to registered UNMAP notifiers in this case.

For UNMAP only notifiers, this might cause IOTLBs cached in the devices
even if they were already invalid.  For MAP/UNMAP notifiers like
vfio-pci, this will cause stale page mappings.

This special case doesn't trigger often, but it is very easy to be
triggered by nested device assignments, since in that case we'll
possibly map the whole L2 guest RAM region into the device's IOVA
address space (several GBs at least), which is far bigger than normal
kernel driver usages of the device (tens of MBs normally).

Without this patch applied to L1 QEMU, nested device assignment to L2
guests will dump some errors like:

qemu-system-x86_64: VFIO_MAP_DMA: -17
qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
                    0x7f89a920d000) = -17 (File exists)

Acked-by: Jason Wang <jasowang@redhat.com>
[peterx: rewrite the commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fb31de9416..b359efd6f9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -722,6 +722,15 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
 
 typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
 
+static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
+                             vtd_page_walk_hook hook_fn, void *private)
+{
+    assert(hook_fn);
+    trace_vtd_page_walk_one(level, entry->iova, entry->translated_addr,
+                            entry->addr_mask, entry->perm);
+    return hook_fn(entry, private);
+}
+
 /**
  * vtd_page_walk_level - walk over specific level for IOVA range
  *
@@ -781,28 +790,37 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
          */
         entry_valid = read_cur | write_cur;
 
+        entry.target_as = &address_space_memory;
+        entry.iova = iova & subpage_mask;
+        entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
+        entry.addr_mask = ~subpage_mask;
+
         if (vtd_is_last_slpte(slpte, level)) {
-            entry.target_as = &address_space_memory;
-            entry.iova = iova & subpage_mask;
             /* NOTE: this is only meaningful if entry_valid == true */
             entry.translated_addr = vtd_get_slpte_addr(slpte, aw);
-            entry.addr_mask = ~subpage_mask;
-            entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
             if (!entry_valid && !notify_unmap) {
                 trace_vtd_page_walk_skip_perm(iova, iova_next);
                 goto next;
             }
-            trace_vtd_page_walk_one(level, entry.iova, entry.translated_addr,
-                                    entry.addr_mask, entry.perm);
-            if (hook_fn) {
-                ret = hook_fn(&entry, private);
-                if (ret < 0) {
-                    return ret;
-                }
+            ret = vtd_page_walk_one(&entry, level, hook_fn, private);
+            if (ret < 0) {
+                return ret;
             }
         } else {
             if (!entry_valid) {
-                trace_vtd_page_walk_skip_perm(iova, iova_next);
+                if (notify_unmap) {
+                    /*
+                     * The whole entry is invalid; unmap it all.
+                     * Translated address is meaningless, zero it.
+                     */
+                    entry.translated_addr = 0x0;
+                    ret = vtd_page_walk_one(&entry, level, hook_fn, private);
+                    if (ret < 0) {
+                        return ret;
+                    }
+                } else {
+                    trace_vtd_page_walk_skip_perm(iova, iova_next);
+                }
                 goto next;
             }
             ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, aw), iova,
-- 
2.17.0
