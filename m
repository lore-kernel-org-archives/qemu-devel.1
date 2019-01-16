Received: from eggs.gnu.org ([209.51.188.92]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzY-0003f0-Vt
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzX-0007zn-V1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzX-0007vs-NB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:43 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:17 -0500
Message-Id: <1547663480-547-13-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/15] virtio: add vhost-net migration for
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
 hw/virtio/virtio.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 722a4fd..0cb912e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2991,17 +2991,34 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
 {
-    return vdev->vq[n].last_avail_idx;
+    uint16_t idx;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        idx = vdev->vq[n].last_avail_idx;
+        idx |= ((int)vdev->vq[n].avail_wrap_counter) << 15;
+    } else {
+        idx = (int)vdev->vq[n].last_avail_idx;
+    }
+    return idx;
 }
 
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
 {
-    vdev->vq[n].last_avail_idx = idx;
-    vdev->vq[n].shadow_avail_idx = idx;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        vdev->vq[n].last_avail_idx = idx & 0x7fff;
+        vdev->vq[n].avail_wrap_counter = !!(idx & 0x8000);
+    } else {
+        vdev->vq[n].last_avail_idx = idx;
+        vdev->vq[n].shadow_avail_idx = idx;
+    }
 }
 
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
 {
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return;
+    }
+
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
@@ -3012,6 +3029,10 @@ void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
 
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return;
+    }
+
     rcu_read_lock();
     if (vdev->vq[n].vring.desc) {
         vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
-- 
1.8.3.1
