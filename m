Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEl-00033z-6c
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEk-0006l4-Cb
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:27 -0400
Received: from mail.kernel.org ([198.145.29.136]:59036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEk-0006kY-6X
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:26 -0400
Date: Wed, 15 Mar 2017 20:01:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-3-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] virtio: guard against NULL pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Jason Wang <jasowang@redhat.com>

To avoid access stale memory region cache after reset, this patch
check the existence of virtqueue pfn for all exported virtqueue access
helpers before trying to use them.

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index efce4b3..9164579 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -318,6 +318,10 @@ int virtio_queue_ready(VirtQueue *vq)
  * Called within rcu_read_lock().  */
 static int virtio_queue_empty_rcu(VirtQueue *vq)
 {
+    if (unlikely(!vq->vring.avail)) {
+        return 1;
+    }
+
     if (vq->shadow_avail_idx != vq->last_avail_idx) {
         return 0;
     }
@@ -329,6 +333,10 @@ int virtio_queue_empty(VirtQueue *vq)
 {
     bool empty;
 
+    if (unlikely(!vq->vring.avail)) {
+        return 1;
+    }
+
     if (vq->shadow_avail_idx != vq->last_avail_idx) {
         return 0;
     }
@@ -431,6 +439,10 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
         return;
     }
 
+    if (unlikely(!vq->vring.used)) {
+        return;
+    }
+
     idx = (idx + vq->used_idx) % vq->vring.num;
 
     uelem.id = elem->index;
@@ -448,6 +460,10 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    if (unlikely(!vq->vring.used)) {
+        return;
+    }
+
     /* Make sure buffer is written before we update index. */
     smp_wmb();
     trace_virtqueue_flush(vq, count);
@@ -546,6 +562,16 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
     int64_t len = 0;
     int rc;
 
+    if (unlikely(!vq->vring.desc)) {
+        if (in_bytes) {
+            *in_bytes = 0;
+        }
+        if (out_bytes) {
+            *out_bytes = 0;
+        }
+        return;
+    }
+
     rcu_read_lock();
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;
-- 
MST
