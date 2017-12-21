Received: from eggs.gnu.org ([2001:4830:134:3::10]:57965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4K4-0003TJ-Vj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4K4-0001Ji-15
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS4K3-0001In-PB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03CDFC0587F6
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 17:07:55 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 18:07:16 +0100
Message-Id: <20171221170716.10709-6-maxime.coquelin@redhat.com>
In-Reply-To: <20171221170716.10709-1-maxime.coquelin@redhat.com>
References: <20171221170716.10709-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] vhost-user-test: use init_virtio_dev in
 multiqueue test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

Now that init_virtio_dev() has been generalized to all cases,
use it in test_multiqueue() to avoid code duplication.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 65 ++++++-------------------------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 6a144e8d7e..ec6ac9dc9e 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -892,79 +892,30 @@ static void test_flags_mismatch(void)
 
 #endif
 
-static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
-{
-    QVirtioPCIDevice *dev;
-
-    dev = qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
-    g_assert(dev != NULL);
-    g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_NET);
-
-    qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
-
-    return dev;
-}
-
-static void driver_init(QVirtioDevice *dev)
-{
-    uint32_t features;
-
-    features = qvirtio_get_features(dev);
-    features = features & ~(QVIRTIO_F_BAD_FEATURE |
-                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                            (1u << VIRTIO_RING_F_EVENT_IDX));
-    qvirtio_set_features(dev, features);
-
-    qvirtio_set_driver_ok(dev);
-}
-
-#define PCI_SLOT                0x04
-
 static void test_multiqueue(void)
 {
-    const int queues = 2;
     TestServer *s = test_server_new("mq");
-    QVirtioPCIDevice *dev;
-    QPCIBus *bus;
-    QVirtQueuePCI *vq[queues * 2];
-    QGuestAllocator *alloc;
     char *cmd;
-    int i;
-
-    s->queues = queues;
+    uint32_t features_mask = ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_RING_F_EVENT_IDX));
+    s->queues = 2;
     test_server_listen(s);
 
     cmd = g_strdup_printf(QEMU_CMD_MEM QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
                           "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
                           512, 512, root, s->chr_name,
                           s->socket_path, "", s->chr_name,
-                          queues, queues * 2 + 2);
+                          s->queues, s->queues * 2 + 2);
     qtest_start(cmd);
     g_free(cmd);
 
-    bus = qpci_init_pc(NULL);
-    dev = virtio_net_pci_init(bus, PCI_SLOT);
+    init_virtio_dev(s, features_mask);
 
-    alloc = pc_alloc_init();
-    for (i = 0; i < queues * 2; i++) {
-        vq[i] = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, alloc, i);
-    }
+    wait_for_rings_started(s, s->queues * 2);
 
-    driver_init(&dev->vdev);
-    wait_for_rings_started(s, queues * 2);
+    uninit_virtio_dev(s);
 
-    /* End test */
-    for (i = 0; i < queues * 2; i++) {
-        qvirtqueue_cleanup(dev->vdev.bus, &vq[i]->vq, alloc);
-    }
-    pc_alloc_uninit(alloc);
-    qvirtio_pci_device_disable(dev);
-    g_free(dev->pdev);
-    g_free(dev);
-    qpci_free_pc(bus);
     qtest_end();
 
     test_server_free(s);
-- 
2.14.3
