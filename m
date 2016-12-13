Received: from eggs.gnu.org ([2001:4830:134:3::10]:52116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDh-0001kH-5i
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDg-0003zb-7E
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1cGiDg-0003v6-14
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so16643915wme.2
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:13:29 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Dec 2016 10:12:07 +0200
Message-Id: <1481616728-148412-4-git-send-email-yuri.benditovich@daynix.com>
In-Reply-To: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
References: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v3 3/4] virtio: Introduce virtqueue_drop_all
 procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Add procedure for fast drop of queued packets, acting like
pop and push without mapping the buffers into memory.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/virtio.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 45536e4..6fdba50 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -765,6 +765,44 @@ err_undo_map:
     return NULL;
 }
 
+/* virtqueue_drop_all:
+ * @vq: The #VirtQueue
+ * Drops all queued buffers and indicates them to the guest
+ * as if they are done. Useful when buffers can not be
+ * processed but must be returned to the guest.
+ */
+unsigned int virtqueue_drop_all(VirtQueue *vq)
+{
+    unsigned int dropped = 0;
+    VirtQueueElement elem = {};
+    VirtIODevice *vdev = vq->vdev;
+    bool fEventIdx = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+    if (unlikely(vdev->broken)) {
+        return 0;
+    }
+
+    while (!virtio_queue_empty(vq) && vq->inuse < vq->vring.num) {
+        /* works similar to virtqueue_pop but does not map buffers
+        * and does not allocate any memory */
+        smp_rmb();
+        if (!virtqueue_get_head(vq, vq->last_avail_idx, &elem.index)) {
+            break;
+        }
+        vq->inuse++;
+        vq->last_avail_idx++;
+        if (fEventIdx) {
+            vring_set_avail_event(vq, vq->last_avail_idx);
+        }
+        /* immediately push the element, nothing to unmap
+         * as both in_num and out_num are set to 0 */
+        virtqueue_push(vq, &elem, 0);
+        dropped++;
+    }
+
+    return dropped;
+}
+
 /* Reading and writing a structure directly to QEMUFile is *awful*, but
  * it is what QEMU has always done by mistake.  We can change it sooner
  * or later by bumping the version number of the affected vm states.
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index a1a75ed..eb0ea4c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -172,6 +172,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 
 void virtqueue_map(VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
+unsigned int virtqueue_drop_all(VirtQueue *vq);
 void *qemu_get_virtqueue_element(QEMUFile *f, size_t sz);
 void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
-- 
1.9.1
