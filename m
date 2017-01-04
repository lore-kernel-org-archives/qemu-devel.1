Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliG-0007uL-4k
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliC-0000pr-9p
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOliC-0000pZ-3p
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:10 +0000
Message-Id: <20170104133414.6524-11-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] virtio: turn vq->notification into a
 nested counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Polling should disable virtqueue notifications but that requires nested
virtio_queue_set_notification() calls.  Turn vq->notification into a
counter so it is possible to do nesting.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-10-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3870411..79b5c36 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -87,8 +87,8 @@ struct VirtQueue
     /* Last used index value we have signalled on */
     bool signalled_used_valid;
 
-    /* Notification enabled? */
-    bool notification;
+    /* Nested host->guest notification disabled counter */
+    unsigned int notification_disabled;
 
     uint16_t queue_index;
 
@@ -201,7 +201,7 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
 static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 {
     hwaddr pa;
-    if (!vq->notification) {
+    if (vq->notification_disabled) {
         return;
     }
     pa = vq->vring.used + offsetof(VRingUsed, ring[vq->vring.num]);
@@ -210,7 +210,13 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
-    vq->notification = enable;
+    if (enable) {
+        assert(vq->notification_disabled > 0);
+        vq->notification_disabled--;
+    } else {
+        vq->notification_disabled++;
+    }
+
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -959,7 +965,7 @@ void virtio_reset(void *opaque)
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
-        vdev->vq[i].notification = true;
+        vdev->vq[i].notification_disabled = 0;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
     }
@@ -1770,7 +1776,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->vq[i].vring.desc = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
         vdev->vq[i].signalled_used_valid = false;
-        vdev->vq[i].notification = true;
+        vdev->vq[i].notification_disabled = 0;
 
         if (vdev->vq[i].vring.desc) {
             /* XXX virtio-1 devices */
-- 
2.9.3
