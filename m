Received: from eggs.gnu.org ([2001:4830:134:3::10]:42650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJs-0002Hp-U7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJr-0003FN-U2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJr-0003EO-4z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:35 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:08:03 -0400
Message-Id: <1528225683-11413-9-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 8/8] virtio: guest driver reload for vhost-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

last_avail, avail_wrap_count, used_idx and used_wrap_count are
needed to support vhost-net backend, all these are either 16 or
bool variables, since state.num is 64bit wide, so here it is
possible to put them to the 'num' without introducing a new case
while handling ioctl.

Unload/Reload test has been done successfully with a patch in vhost kernel.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4543974..153f6d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2862,33 +2862,59 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
     }
 }
 
-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
+uint64_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
 {
-    return vdev->vq[n].last_avail_idx;
+    uint64_t num;
+
+    num = vdev->vq[n].last_avail_idx;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        num |= ((uint64_t)vdev->vq[n].avail_wrap_counter) << 16;
+        num |= ((uint64_t)vdev->vq[n].used_idx) << 32;
+        num |= ((uint64_t)vdev->vq[n].used_wrap_counter) << 48;
+    }
+
+    return num;
 }
 
-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint64_t num)
 {
-    vdev->vq[n].last_avail_idx = idx;
-    vdev->vq[n].shadow_avail_idx = idx;
+    vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx = (uint16_t)(num);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        vdev->vq[n].avail_wrap_counter = (uint16_t)(num >> 16);
+        vdev->vq[n].used_idx = (uint16_t)(num >> 32);
+        vdev->vq[n].used_wrap_counter = (uint16_t)(num >> 48);
+    }
 }
 
 void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
 {
     rcu_read_lock();
-    if (vdev->vq[n].vring.desc) {
+    if (!vdev->vq[n].vring.desc) {
+        goto out;
+    }
+
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
-        vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
     }
+    vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
+
+out:
     rcu_read_unlock();
 }
 
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
     rcu_read_lock();
-    if (vdev->vq[n].vring.desc) {
+    if (!vdev->vq[n].vring.desc) {
+        goto out;
+    }
+
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
     }
+
+out:
     rcu_read_unlock();
 }
 
-- 
1.8.3.1
