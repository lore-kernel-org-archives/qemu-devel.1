Received: from eggs.gnu.org ([2001:4830:134:3::10]:49074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUzA-00025D-3C
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUz9-0000un-5c
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:28 -0400
Date: Wed, 23 May 2018 17:43:25 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-26-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/28] intel-iommu: pass in address space when
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

We pass in the VTDAddressSpace too.  It'll be used in the follow up
patches.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e247269..a882894 100644
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
MST
