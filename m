Received: from eggs.gnu.org ([2001:4830:134:3::10]:59238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElP-0000ul-Nn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElM-0006ra-Lo
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJElM-0006rM-H3
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:52 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:21 +0800
Message-Id: <20180517085927.24925-7-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/12] intel-iommu: pass in address space
 when page walk
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

We pass in the VTDAddressSpace too.  It'll be used in the follow up
patches.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4953d02ed0..fe5ee77d46 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -753,9 +753,11 @@ typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
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
@@ -1460,6 +1462,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                     .private = (void *)&vtd_as->iommu,
                     .notify_unmap = true,
                     .aw = s->aw_bits,
+                    .as = vtd_as,
                 };
 
                 /*
@@ -2941,6 +2944,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .private = (void *)n,
                 .notify_unmap = false,
                 .aw = s->aw_bits,
+                .as = vtd_as,
             };
 
             vtd_page_walk(&ce, 0, ~0ULL, &info);
-- 
2.17.0
