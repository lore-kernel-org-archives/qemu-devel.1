Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkj2-0002bh-HL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkeN-0007wn-Uz
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:36:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTkeN-0007wY-QF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:36:23 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  3 Dec 2018 17:35:44 +0800
Message-Id: <20181203093544.6184-5-jasowang@redhat.com>
In-Reply-To: <20181203093544.6184-1-jasowang@redhat.com>
References: <20181203093544.6184-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V3 for 3.1 4/4] virtio-net-test: add large tx
 buffer test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com, eblake@redhat.com, Jason Wang <jasowang@redhat.com>

This test tries to build a packet whose size is greater than INT_MAX
which tries to trigger integer overflow in qemu_net_queue_append_iov()
which may result OOB.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/virtio-net-test.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index f12f0afb51..22df5b6f37 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -242,6 +242,50 @@ static void pci_basic(gconstpointer data)
     g_free(dev);
     qtest_shutdown(qs);
 }
+
+static void large_tx(gconstpointer data)
+{
+    QVirtioPCIDevice *dev;
+    QOSState *qs;
+    QVirtQueuePCI *tx, *rx;
+    QVirtQueue *vq;
+    const char *cmd = "-netdev hubport,id=hp0,hubid=0 "
+                      "-device virtio-net-pci,netdev=hp0 ";
+    uint64_t req_addr;
+    uint32_t free_head;
+    size_t alloc_size = UINT_MAX / 64;
+    int i;
+
+    qs = pci_test_start(cmd);
+    dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
+
+    rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
+    tx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 1);
+
+    driver_init(&dev->vdev);
+    vq = &tx->vq;
+
+    /* Bypass the limitation by pointing several descriptors to a single
+     * smaller area */
+    req_addr = guest_alloc(qs->alloc, alloc_size);
+    free_head = qvirtqueue_add(vq, req_addr, alloc_size, false, true);
+
+    for (i = 0; i < 64; i++) {
+        qvirtqueue_add(vq, req_addr, alloc_size, false, i == 63 ?
+                       false : true);
+    }
+    qvirtqueue_kick(&dev->vdev, vq, free_head);
+
+    qvirtio_wait_used_elem(&dev->vdev, vq, free_head, NULL,
+                           QVIRTIO_NET_TIMEOUT_US);
+
+    qvirtqueue_cleanup(dev->vdev.bus, &tx->vq, qs->alloc);
+    qvirtqueue_cleanup(dev->vdev.bus, &rx->vq, qs->alloc);
+    qvirtio_pci_device_disable(dev);
+    g_free(dev->pdev);
+    g_free(dev);
+    qtest_shutdown(qs);
+}
 #endif
 
 static void hotplug(void)
@@ -267,6 +311,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/virtio/net/pci/basic", send_recv_test, pci_basic);
     qtest_add_data_func("/virtio/net/pci/rx_stop_cont",
                         stop_cont_test, pci_basic);
+    qtest_add_data_func("/virtio/net/pci/large_tx", NULL, large_tx);
 #endif
     qtest_add_func("/virtio/net/pci/hotplug", hotplug);
 
-- 
2.17.1
