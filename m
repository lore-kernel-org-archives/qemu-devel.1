Received: from eggs.gnu.org ([2001:4830:134:3::10]:33821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAg-000850-4u
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAe-0005qe-Mi
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:34 -0500
Received: from mail.kernel.org ([198.145.29.136]:48342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAe-0005q4-99
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:32 -0500
Date: Tue, 10 Jan 2017 07:40:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-28-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 27/41] virtio: Introduce virtqueue_drop_all
 procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Add procedure for fast drop of queued packets, acting like
pop and push without mapping the buffers into memory.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  1 +
 hw/virtio/virtio.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index e15c064..e5541c6 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -173,6 +173,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
+unsigned int virtqueue_drop_all(VirtQueue *vq);
 void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
 void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index baffff7..aa4f38f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -783,6 +783,44 @@ err_undo_map:
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
-- 
MST
