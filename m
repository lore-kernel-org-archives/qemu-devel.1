Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncie-0007QA-FP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cncid-0002UT-N0
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cncid-0002UJ-Hm
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:01:51 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2017 11:01:40 +0800
Message-Id: <1489460502-6686-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V3 1/3] virtio: guard against NULL pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

To avoid access stale memory region cache after reset, this patch
check the existence of virtqueue pfn for all exported virtqueue access
helpers before trying to use them.

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V2:
- return 1 instead of 0 for virtio_queue_empty_*(), and return as
  early as possible
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
2.7.4
