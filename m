Received: from eggs.gnu.org ([2001:4830:134:3::10]:41079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIh-0001oo-BU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhId-000354-MV
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:23 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:34 -0500
Message-Id: <20180723201748.25573-26-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 25/99] intel-iommu: send PSI always even if
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
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

SECURITY IMPLICATION: without this patch, any guest with both assigned
device and a vIOMMU might encounter stale IO page mappings even if guest
has already unmapped the page, which may lead to guest memory
corruption.  The stale mappings will only be limited to the guest's own
memory range, so it should not affect the host memory or other guests on
the host.

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

CC: QEMU Stable <qemu-stable@nongnu.org>
Acked-by: Jason Wang <jasowang@redhat.com>
[peterx: rewrite the commit message]
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

(cherry picked from commit 36d2d52bdb45f5b753a61fdaf0fe7891f1f5b61d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
