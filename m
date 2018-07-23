Received: from eggs.gnu.org ([2001:4830:134:3::10]:41220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIq-0001vg-9R
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIp-0003ML-0J
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:32 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:39 -0500
Message-Id: <20180723201748.25573-31-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 30/99] intel-iommu: pass in address space when
 page walk
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

We pass in the VTDAddressSpace too.  It'll be used in the follow up
patches.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2f764fa87d2a81812b313dd6d998e10126292653)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e247269659..a882894f49 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -754,9 +754,11 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
  * @hook_fn: hook func to be called when detected page
  * @private: private data to be passed into hook func
  * @notify_unmap: whether we should notify invalid entries
+ * @as: VT-d address space of the device
  * @aw: maximum address width
  */
 typedef struct {
+    VTDAddressSpace *as;
     vtd_page_walk_hook hook_fn;
     void *private;
     bool notify_unmap;
@@ -1463,6 +1465,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                     .private = (void *)&vtd_as->iommu,
                     .notify_unmap = true,
                     .aw = s->aw_bits,
+                    .as = vtd_as,
                 };
 
                 /*
@@ -2943,6 +2946,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .private = (void *)n,
                 .notify_unmap = false,
                 .aw = s->aw_bits,
+                .as = vtd_as,
             };
 
             vtd_page_walk(&ce, 0, ~0ULL, &info);
-- 
2.17.1
