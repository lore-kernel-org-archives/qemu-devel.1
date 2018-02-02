Received: from eggs.gnu.org ([2001:4830:134:3::10]:53573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe5Q-0000zW-Mw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe4C-0004CA-Pg
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe4B-00049y-C5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GJ68w009007
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:54 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvsskct67-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:52 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:33 +0100
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
Message-Id: <20180202161935.20803-9-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 08/10] libqos/virtio: return length written
 into used descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

When a 9p request is flushed (ie, cancelled) by the guest, the device
is expected to simply mark the request as used, without sending a 9p
reply (ie, without writing anything into the used buffer).

To be able to test this, we need access to the length written by the
device into the used descriptor. This patch adds a uint32_t * argument
to qvirtqueue_get_buf() and qvirtio_wait_used_elem() for this purpose.

All existing users are updated accordingly.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.c    | 25 +++++++++++++++++--------
 tests/libqos/virtio.h    |  3 ++-
 tests/virtio-9p-test.c   |  2 +-
 tests/virtio-blk-test.c  | 24 +++++++++++++-----------
 tests/virtio-net-test.c  |  6 +++---
 tests/virtio-scsi-test.c |  3 ++-
 6 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 0879a621c8af..0dad5c19acde 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -119,6 +119,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
 /*
  * qvirtio_wait_used_elem:
  * @desc_idx: The next expected vq->desc[] index in the used ring
+ * @len: A pointer that is filled with the length written into the buffer, may
+ *       be NULL
  * @timeout_us: How many microseconds to wait before failing
  *
  * This function waits for the next completed request on the used ring.
@@ -126,6 +128,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
 void qvirtio_wait_used_elem(QVirtioDevice *d,
                             QVirtQueue *vq,
                             uint32_t desc_idx,
+                            uint32_t *len,
                             gint64 timeout_us)
 {
     gint64 start_time = g_get_monotonic_time();
@@ -136,7 +139,7 @@ void qvirtio_wait_used_elem(QVirtioDevice *d,
         clock_step(100);
 
         if (d->bus->get_queue_isr_status(d, vq) &&
-            qvirtqueue_get_buf(vq, &got_desc_idx)) {
+            qvirtqueue_get_buf(vq, &got_desc_idx, len)) {
             g_assert_cmpint(got_desc_idx, ==, desc_idx);
             return;
         }
@@ -304,30 +307,36 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
 /*
  * qvirtqueue_get_buf:
  * @desc_idx: A pointer that is filled with the vq->desc[] index, may be NULL
+ * @len: A pointer that is filled with the length written into the buffer, may
+ *       be NULL
  *
  * This function gets the next used element if there is one ready.
  *
  * Returns: true if an element was ready, false otherwise
  */
-bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
+bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len)
 {
     uint16_t idx;
+    uint64_t elem_addr;
 
     idx = readw(vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
 
-    if (desc_idx) {
-        uint64_t elem_addr;
+    elem_addr = vq->used +
+        offsetof(struct vring_used, ring) +
+        (vq->last_used_idx % vq->size) *
+        sizeof(struct vring_used_elem);
 
-        elem_addr = vq->used +
-                    offsetof(struct vring_used, ring) +
-                    (vq->last_used_idx % vq->size) *
-                    sizeof(struct vring_used_elem);
+    if (desc_idx) {
         *desc_idx = readl(elem_addr + offsetof(struct vring_used_elem, id));
     }
 
+    if (len) {
+        *len = readw(elem_addr + offsetof(struct vring_used_elem, len));
+    }
+
     vq->last_used_idx++;
     return true;
 }
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 0a04740adfe1..69b5b13840e7 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -124,6 +124,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
 void qvirtio_wait_used_elem(QVirtioDevice *d,
                             QVirtQueue *vq,
                             uint32_t desc_idx,
+                            uint32_t *len,
                             gint64 timeout_us);
 void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us);
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
@@ -140,7 +141,7 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
                                                                     bool next);
 uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect);
 void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
-bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx);
+bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len);
 
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
 
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 12315aeb4e5b..0d0341491e79 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -254,7 +254,7 @@ static void v9fs_req_wait_for_reply(P9Req *req)
 {
     QVirtIO9P *v9p = req->v9p;
 
-    qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head,
+    qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head, NULL,
                            QVIRTIO_9P_TIMEOUT_US);
 }
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 45f368dcd966..2ac64e5e2559 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -193,7 +193,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -215,7 +215,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -243,7 +243,8 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
         qvirtqueue_add(vq, req_addr + 528, 1, true, false);
         qvirtqueue_kick(dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
+        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
 
@@ -264,7 +265,8 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         qvirtqueue_kick(dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
+        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
 
@@ -345,7 +347,7 @@ static void pci_indirect(void)
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -370,7 +372,7 @@ static void pci_indirect(void)
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -481,7 +483,7 @@ static void pci_msix(void)
     qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -506,7 +508,7 @@ static void pci_msix(void)
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -580,7 +582,7 @@ static void pci_idx(void)
     qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     /* Write request */
@@ -627,9 +629,9 @@ static void pci_idx(void)
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
     /* We get just one notification for both requests */
-    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, write_head,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, write_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
-    g_assert(qvirtqueue_get_buf(&vqpci->vq, &desc_idx));
+    g_assert(qvirtqueue_get_buf(&vqpci->vq, &desc_idx, NULL));
     g_assert_cmpint(desc_idx, ==, free_head);
 
     status = readb(req_addr + 528);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 635b942c3601..ea634dc05a60 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -108,7 +108,7 @@ static void rx_test(QVirtioDevice *dev,
     ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
     g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
 
-    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
@@ -131,7 +131,7 @@ static void tx_test(QVirtioDevice *dev,
     free_head = qvirtqueue_add(vq, req_addr, 64, false, false);
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
     guest_free(alloc, req_addr);
 
     ret = qemu_recv(socket, &len, sizeof(len), 0);
@@ -182,7 +182,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     rsp = qmp("{ 'execute' : 'cont'}");
     QDECREF(rsp);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 2934305b2bff..bcf408fbb637 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -121,7 +121,8 @@ static uint8_t virtio_scsi_do_command(QVirtIOSCSI *vs, const uint8_t *cdb,
     }
 
     qvirtqueue_kick(vs->dev, vq, free_head);
-    qvirtio_wait_used_elem(vs->dev, vq, free_head, QVIRTIO_SCSI_TIMEOUT_US);
+    qvirtio_wait_used_elem(vs->dev, vq, free_head, NULL,
+                           QVIRTIO_SCSI_TIMEOUT_US);
 
     response = readb(resp_addr +
                      offsetof(struct virtio_scsi_cmd_resp, response));
-- 
2.13.6
