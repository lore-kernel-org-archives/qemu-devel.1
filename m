Received: from eggs.gnu.org ([209.51.188.92]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzZ-0003fS-DA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzY-0007zx-10
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzX-0007ow-La
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:43 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:16 -0500
Message-Id: <1547663480-547-12-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/15] virtio: add userspace migration for
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
 hw/virtio/virtio.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0bcf8a5..722a4fd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2346,6 +2346,13 @@ static bool virtio_virtqueue_needed(void *opaque)
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
@@ -2387,6 +2394,21 @@ static const VMStateDescription vmstate_virtqueue = {
     }
 };
 
+static const VMStateDescription vmstate_packed_virtqueue = {
+    .name = "packed_virtqueue_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(avail_wrap_counter, struct VirtQueue),
+        VMSTATE_BOOL(event_wrap_counter, struct VirtQueue),
+        VMSTATE_BOOL(used_wrap_counter, struct VirtQueue),
+        VMSTATE_UINT16(used_idx, struct VirtQueue),
+        VMSTATE_UINT16(shadow_avail_idx, struct VirtQueue),
+        VMSTATE_UINT32(inuse, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_virtqueues = {
     .name = "virtio/virtqueues",
     .version_id = 1,
@@ -2399,6 +2421,18 @@ static const VMStateDescription vmstate_virtio_virtqueues = {
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
@@ -2516,6 +2550,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_device_endian,
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
+        &vmstate_virtio_packed_virtqueues,
         &vmstate_virtio_ringsize,
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
@@ -2791,6 +2826,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 virtio_queue_update_rings(vdev, i);
             }
 
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                continue;
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-- 
1.8.3.1
