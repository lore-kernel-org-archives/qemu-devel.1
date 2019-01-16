Received: from eggs.gnu.org ([209.51.188.92]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpyp-00036t-7i
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpyk-0007ML-Jd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpyk-0007LB-Cu
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:31:54 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:09 -0500
Message-Id: <1547663480-547-5-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/15] virtio: add memory region init for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 112845c..454da3d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -156,10 +156,8 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     VRingMemoryRegionCaches *old = vq->vring.caches;
     VRingMemoryRegionCaches *new = NULL;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
-
-    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+    bool attr;
 
     addr = vq->vring.desc;
     if (!addr) {
@@ -167,14 +165,16 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
     }
     new = g_new0(VRingMemoryRegionCaches, 1);
     size = virtio_queue_get_desc_size(vdev, n);
+    attr = virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED) ?
+                                   true : false;
     len = address_space_cache_init(&new->desc, vdev->dma_as,
-                                   addr, size, false);
+                                   addr, size, attr);
     if (len < size) {
         virtio_error(vdev, "Cannot map desc");
         goto err_desc;
     }
 
-    size = virtio_queue_get_used_size(vdev, n) + event_size;
+    size = virtio_queue_get_used_size(vdev, n);
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -182,7 +182,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev, int n)
         goto err_used;
     }
 
-    size = virtio_queue_get_avail_size(vdev, n) + event_size;
+    size = virtio_queue_get_avail_size(vdev, n);
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-- 
1.8.3.1
