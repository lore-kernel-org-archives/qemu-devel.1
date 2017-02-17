Received: from eggs.gnu.org ([2001:4830:134:3::10]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocJ-0004Vf-Rz
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocH-0005th-KM
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:55 -0500
Received: from mail.kernel.org ([198.145.29.136]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocH-0005sY-9n
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:53 -0500
Date: Fri, 17 Feb 2017 21:54:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-18-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 17/23] vfio: allow to notify unmap for very
 large region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Peter Xu <peterx@redhat.com>

Linux vfio driver supports to do VFIO_IOMMU_UNMAP_DMA for a very big
region. This can be leveraged by QEMU IOMMU implementation to cleanup
existing page mappings for an entire iova address space (by notifying
with an IOTLB with extremely huge addr_mask). However current
vfio_iommu_map_notify() does not allow that. It make sure that all the
translated address in IOTLB is falling into RAM range.

The check makes sense, but it should only be a sensible checker for
mapping operations, and mean little for unmap operations.

This patch moves this check into map logic only, so that we'll get
faster unmap handling (no need to translate again), and also we can then
better support unmapping a very big region when it covers non-ram ranges
or even not-existing ranges.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 42c4790..f3ba9b9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -352,11 +352,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 
     rcu_read_lock();
 
-    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
-        goto out;
-    }
-
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
+        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
+            goto out;
+        }
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
-- 
MST
