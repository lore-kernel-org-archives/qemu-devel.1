Received: from eggs.gnu.org ([2001:4830:134:3::10]:48194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuO2-0008KH-U5
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuO1-0004xM-OC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQuO1-0004x9-Ft
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 30 Jun 2017 12:46:33 +0100
Message-Id: <20170630114635.9286-6-stefanha@redhat.com>
In-Reply-To: <20170630114635.9286-1-stefanha@redhat.com>
References: <20170630114635.9286-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] tests: fix virtio-blk-test ISR dependence
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

Use the new used ring APIs instead of assuming ISR being set means the
request has completed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170628184724.21378-5-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-blk-test.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index fd2078c..0576cb1 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -196,7 +196,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -218,7 +218,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     qvirtqueue_kick(dev, vq, free_head);
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -246,7 +246,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
         qvirtqueue_add(vq, req_addr + 528, 1, true, false);
         qvirtqueue_kick(dev, vq, free_head);
 
-        qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
+        qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
 
@@ -267,7 +267,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         qvirtqueue_kick(dev, vq, free_head);
 
-        qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
+        qvirtio_wait_used_elem(dev, vq, free_head, QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
 
@@ -348,7 +348,7 @@ static void pci_indirect(void)
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -373,7 +373,7 @@ static void pci_indirect(void)
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -484,7 +484,7 @@ static void pci_msix(void)
     qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -509,7 +509,7 @@ static void pci_msix(void)
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq,
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -540,6 +540,8 @@ static void pci_idx(void)
     uint64_t capacity;
     uint32_t features;
     uint32_t free_head;
+    uint32_t write_head;
+    uint32_t desc_idx;
     uint8_t status;
     char *data;
 
@@ -581,7 +583,8 @@ static void pci_idx(void)
     qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, free_head,
+                           QVIRTIO_BLK_TIMEOUT_US);
 
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
@@ -600,6 +603,7 @@ static void pci_idx(void)
     qvirtqueue_add(&vqpci->vq, req_addr + 16, 512, false, true);
     qvirtqueue_add(&vqpci->vq, req_addr + 528, 1, true, false);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
+    write_head = free_head;
 
     /* No notification expected */
     status = qvirtio_wait_status_byte_no_isr(&dev->vdev,
@@ -625,8 +629,11 @@ static void pci_idx(void)
 
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);
 
-    qvirtio_wait_queue_isr(&dev->vdev, &vqpci->vq,
+    /* We get just one notification for both requests */
+    qvirtio_wait_used_elem(&dev->vdev, &vqpci->vq, write_head,
                            QVIRTIO_BLK_TIMEOUT_US);
+    g_assert(qvirtqueue_get_buf(&vqpci->vq, &desc_idx));
+    g_assert_cmpint(desc_idx, ==, free_head);
 
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
-- 
2.9.4
