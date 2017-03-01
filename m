Received: from eggs.gnu.org ([2001:4830:134:3::10]:40889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7Ys-0003q6-03
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj7Yo-0000Jo-Hj
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:57:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cj7Yo-0000JN-87
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:57:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21Gt9Qq068848
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 11:57:04 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxrb46ga-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:57:04 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Mar 2017 16:57:01 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed,  1 Mar 2017 17:56:56 +0100
Message-Id: <20170301165656.80456-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, borntraeger@de.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

Switching to vring caches exposed an existing bug in
virtio_queue_set_notification(): We can't access vring structures
if they have not been set up yet. This may happen, for example,
for virtio-blk devices with multiple queues: The code will try to
switch notifiers for every queue, but the guest may have only set up
a subset of them.

Fix this by (1) guarding access to the vring memory by checking
for vring.desc and (2) triggering an update to the vring flags
for consistency with the configured notification state once the
queue is actually configured AND the device is in a state that
the rings may be actually accessed (i.e. DRIVER_OK has been set
or a legacy device kicks for the first time).

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
v1->v2:
- Don't touch queues before DRIVER_OK or first kick
- Migration stuff

Only very lightly tested.

---
 hw/virtio/virtio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e487e36..b467290 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -99,6 +99,9 @@ struct VirtQueue
     /* Notification enabled? */
     bool notification;
 
+    /* Delayed setup of flags for notifications */
+    bool delayed_notification_setup;
+
     uint16_t queue_index;
 
     unsigned int inuse;
@@ -284,10 +287,15 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
     virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
 }
 
-void virtio_queue_set_notification(VirtQueue *vq, int enable)
+static void vring_set_notification(VirtQueue *vq, int enable)
 {
-    vq->notification = enable;
-
+    if (!vq->vring.desc ||
+        (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_VERSION_1) &&
+         !(vq->vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
+        vq->delayed_notification_setup = true;
+        return;
+    }
+    vq->delayed_notification_setup = false;
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
@@ -303,6 +311,13 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
     rcu_read_unlock();
 }
 
+void virtio_queue_set_notification(VirtQueue *vq, int enable)
+{
+    vq->notification = enable;
+
+    vring_set_notification(vq, enable);
+}
+
 int virtio_queue_ready(VirtQueue *vq)
 {
     return vq->vring.avail != 0;
@@ -1087,6 +1102,17 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     if (k->set_status) {
         k->set_status(vdev, val);
     }
+    if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+        val & VIRTIO_CONFIG_S_FEATURES_OK) {
+        int i;
+
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (!virtio_queue_get_num(vdev, i)) {
+                break;
+            }
+            vring_set_notification(&vdev->vq[i], vdev->vq[i].notification);
+        }
+    }
     vdev->status = val;
     return 0;
 }
@@ -1152,6 +1178,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
+        vdev->vq[i].delayed_notification_setup = false;
     }
 }
 
@@ -1671,6 +1698,19 @@ static bool virtio_broken_needed(void *opaque)
     return vdev->broken;
 }
 
+static bool virtio_delayed_notification_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    int i;
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        if (vdev->vq[i].delayed_notification_setup) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static const VMStateDescription vmstate_virtqueue = {
     .name = "virtqueue_state",
     .version_id = 1,
@@ -1799,6 +1839,29 @@ static const VMStateDescription vmstate_virtio_broken = {
     }
 };
 
+static const VMStateDescription vmstate_delayed_notification = {
+    .name = "delayed_notification_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(delayed_notification_setup, struct VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_virtio_delayed_notification = {
+    .name = "virtio/delayed_notification",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_delayed_notification_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
+                      VIRTIO_QUEUE_MAX, 0, vmstate_delayed_notification,
+                      VirtQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -1814,6 +1877,7 @@ static const VMStateDescription vmstate_virtio = {
         &vmstate_virtio_ringsize,
         &vmstate_virtio_broken,
         &vmstate_virtio_extra_state,
+        &vmstate_virtio_delayed_notification,
         NULL
     }
 };
@@ -2273,6 +2337,10 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq)
 static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
 {
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
+
+    if (unlikely(vq->delayed_notification_setup)) {
+        vring_set_notification(vq, vq->notification);
+    }
     if (event_notifier_test_and_clear(n)) {
         virtio_queue_notify_aio_vq(vq);
     }
-- 
2.8.4
