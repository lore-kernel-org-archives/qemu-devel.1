Received: from eggs.gnu.org ([2001:4830:134:3::10]:48152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNu-0008DR-DN
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNt-0004so-9D
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQuNt-0004sZ-1d
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 30 Jun 2017 12:46:31 +0100
Message-Id: <20170630114635.9286-4-stefanha@redhat.com>
In-Reply-To: <20170630114635.9286-1-stefanha@redhat.com>
References: <20170630114635.9286-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] libqos: add virtio used ring support
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

Existing tests do not touch the virtqueue used ring.  Instead they poll
the virtqueue ISR register and peek into their request's device-specific
status field.

It turns out that the virtqueue ISR register can be set to 1 more than
once for a single notification (see commit
83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
notifications").  This causes problems for tests that assume a 1:1
correspondence between the ISR being 1 and request completion.

Peeking at device-specific status fields is also problematic if the
device has no field that can be abused for EINPROGRESS polling
semantics.  This is the case if all the field's values may be set by the
device; there's no magic constant left for polling.

It's time to process the used ring for completed requests, just like a
real virtio guest driver.  This patch adds the necessary APIs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170628184724.21378-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.h |  6 ++++++
 tests/libqos/virtio.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 829de5e..8fbcd18 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -32,6 +32,7 @@ typedef struct QVirtQueue {
     uint32_t free_head;
     uint32_t num_free;
     uint32_t align;
+    uint16_t last_used_idx;
     bool indirect;
     bool event;
 } QVirtQueue;
@@ -120,6 +121,10 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
                                         QVirtQueue *vq,
                                         uint64_t addr,
                                         gint64 timeout_us);
+void qvirtio_wait_used_elem(QVirtioDevice *d,
+                            QVirtQueue *vq,
+                            uint32_t desc_idx,
+                            gint64 timeout_us);
 void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us);
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
                              QGuestAllocator *alloc, uint16_t index);
@@ -135,6 +140,7 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
                                                                     bool next);
 uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect);
 void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
+bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx);
 
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
 #endif
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index ec30cb9..9880a69 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -116,6 +116,35 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
     return val;
 }
 
+/*
+ * qvirtio_wait_used_elem:
+ * @desc_idx: The next expected vq->desc[] index in the used ring
+ * @timeout_us: How many microseconds to wait before failing
+ *
+ * This function waits for the next completed request on the used ring.
+ */
+void qvirtio_wait_used_elem(QVirtioDevice *d,
+                            QVirtQueue *vq,
+                            uint32_t desc_idx,
+                            gint64 timeout_us)
+{
+    gint64 start_time = g_get_monotonic_time();
+
+    for (;;) {
+        uint32_t got_desc_idx;
+
+        clock_step(100);
+
+        if (d->bus->get_queue_isr_status(d, vq) &&
+            qvirtqueue_get_buf(vq, &got_desc_idx)) {
+            g_assert_cmpint(got_desc_idx, ==, desc_idx);
+            return;
+        }
+
+        g_assert(g_get_monotonic_time() - start_time <= timeout_us);
+    }
+}
+
 void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
 {
     gint64 start_time = g_get_monotonic_time();
@@ -272,6 +301,37 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
     }
 }
 
+/*
+ * qvirtqueue_get_buf:
+ * @desc_idx: A pointer that is filled with the vq->desc[] index, may be NULL
+ *
+ * This function gets the next used element if there is one ready.
+ *
+ * Returns: true if an element was ready, false otherwise
+ */
+bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
+{
+    uint16_t idx;
+
+    idx = readw(vq->used + offsetof(struct vring_used, idx));
+    if (idx == vq->last_used_idx) {
+        return false;
+    }
+
+    if (desc_idx) {
+        uint64_t elem_addr;
+
+        elem_addr = vq->used +
+                    offsetof(struct vring_used, ring) +
+                    (vq->last_used_idx % vq->size) *
+                    sizeof(struct vring_used_elem);
+        *desc_idx = readl(elem_addr + offsetof(struct vring_used_elem, id));
+    }
+
+    vq->last_used_idx++;
+    return true;
+}
+
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
 {
     g_assert(vq->event);
-- 
2.9.4
