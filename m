Received: from eggs.gnu.org ([209.51.188.92]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dK-0001OS-Ui
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gu8dG-0005Ch-74
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gu8dF-0004rW-M0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 23:28:18 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 23:26:41 -0500
Message-Id: <1550118402-4057-11-git-send-email-wexu@redhat.com>
In-Reply-To: <1550118402-4057-1-git-send-email-wexu@redhat.com>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/11] virtio: migration support for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Both userspace and vhost-net/user are supported with this patch.

A new subsection is introduced for packed ring, only 'last_avail_idx'
and 'last_avail_wrap_counter' are saved/loaded presumably based on
all the others relevant data(inuse, used/avail index and wrap count
should be the same.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8cfc7b6..7c5de07 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2349,6 +2349,13 @@ static bool virtio_virtqueue_needed(void *opaque)
     return virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1);
 }
 
+static bool virtio_packed_virtqueue_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static bool virtio_ringsize_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -2390,6 +2397,17 @@ static const VMStateDescription vmstate_virtqueue = {
     }
 };
 
+static const VMStateDescription vmstate_packed_virtqueue = {
+    .name = "packed_virtqueue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(last_avail_idx, struct VirtQueue),
+        VMSTATE_BOOL(last_avail_wrap_counter, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_virtqueues = {
     .name = "virtio/virtqueues",
     .version_id = 1,
@@ -2402,6 +2420,18 @@ static const VMStateDescription vmstate_virtio_virtqueues = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_packed_virtqueues = {
+    .name = "virtio/packed_virtqueues",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_packed_virtqueue_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
+                      VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ringsize = {
     .name = "ringsize_state",
     .version_id = 1,
@@ -2522,6 +2552,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_ringsize,
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
+        &vmstate_virtio_packed_virtqueues,
         NULL
     }
 };
@@ -2794,6 +2825,17 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 virtio_queue_update_rings(vdev, i);
             }
 
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                vdev->vq[i].shadow_avail_idx = vdev->vq[i].last_avail_idx;
+                vdev->vq[i].avail_wrap_counter =
+                                        vdev->vq[i].last_avail_wrap_counter;
+
+                vdev->vq[i].used_idx = vdev->vq[i].last_avail_idx;
+                vdev->vq[i].used_wrap_counter =
+                                        vdev->vq[i].last_avail_wrap_counter;
+                continue;
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
@@ -2955,17 +2997,34 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 
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
@@ -2976,6 +3035,10 @@ void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
 
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
