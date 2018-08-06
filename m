Received: from eggs.gnu.org ([2001:4830:134:3::10]:35655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb1-00051t-3M
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgaz-0000sX-PU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:55 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgaz-0000sJ-GC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:53 -0400
Received: by mail-ed1-x543.google.com with SMTP id r4-v6so5237518edp.9
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:53 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:51 +0200
Message-Id: <20180806143412.27722-14-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 13/34] test/qgraph: virtio_start_device
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This function is intended to group all the qvirtio_* functions that
start the qvirtio devices.
Applied in all tests using this combination of functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/virtio.c    |  8 ++++++++
 tests/libqos/virtio.h    |  1 +
 tests/vhost-user-test.c  |  5 +----
 tests/virtio-9p-test.c   |  6 +-----
 tests/virtio-blk-test.c  | 18 ++----------------
 tests/virtio-net-test.c  |  6 +-----
 tests/virtio-scsi-test.c |  4 +---
 7 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 0dad5c19ac..56007ef11b 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -365,3 +365,11 @@ const char *qvirtio_get_dev_type(void)
         return "pci";
     }
 }
+
+void qvirtio_start_device(QVirtioDevice *vdev)
+{
+    qvirtio_reset(vdev);
+    qvirtio_set_acknowledge(vdev);
+    qvirtio_set_driver(vdev);
+    qvirtio_set_driver_ok(vdev);
+}
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 69b5b13840..2c68668de0 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -146,5 +146,6 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len);
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
 
 const char *qvirtio_get_dev_type(void);
+void qvirtio_start_device(QVirtioDevice *vdev);
 
 #endif
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index a01b81d342..c8270fa6ed 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -198,9 +198,7 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     g_assert_nonnull(s->dev);
 
     qvirtio_pci_device_enable(s->dev);
-    qvirtio_reset(&s->dev->vdev);
-    qvirtio_set_acknowledge(&s->dev->vdev);
-    qvirtio_set_driver(&s->dev->vdev);
+    qvirtio_start_device(&s->dev->vdev);
 
     s->alloc = pc_alloc_init(global_qtest);
 
@@ -212,7 +210,6 @@ static void init_virtio_dev(TestServer *s, uint32_t features_mask)
     features = features & features_mask;
     qvirtio_set_features(&s->dev->vdev, features);
 
-    qvirtio_set_driver_ok(&s->dev->vdev);
 }
 
 static void uninit_virtio_dev(TestServer *s)
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index a2b31085f6..4f4a1fb8b4 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -65,14 +65,10 @@ static QVirtIO9P *qvirtio_9p_pci_start(void)
     v9p->dev = (QVirtioDevice *) dev;
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(v9p->dev);
-    qvirtio_set_acknowledge(v9p->dev);
-    qvirtio_set_driver(v9p->dev);
+    qvirtio_start_device(v9p->dev);
 
     v9p->vq = qvirtqueue_setup(v9p->dev, v9p->qs->alloc, 0);
 
-    qvirtio_set_driver_ok(v9p->dev);
-
     return v9p;
 }
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 9be9ffb378..3e8f98e528 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -112,10 +112,7 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
     g_assert_cmphex(dev->pdev->devfn, ==, ((slot << 3) | PCI_FN));
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
-
+    qvirtio_start_device(&dev->vdev);
     return dev;
 }
 
@@ -174,8 +171,6 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
                     (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
 
-    qvirtio_set_driver_ok(dev);
-
     /* Write and read with 3 descriptor layout */
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
@@ -329,7 +324,6 @@ static void pci_indirect(void)
     qvirtio_set_features(&dev->vdev, features);
 
     vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
-    qvirtio_set_driver_ok(&dev->vdev);
 
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
@@ -407,8 +401,6 @@ static void pci_config(void)
     capacity = qvirtio_config_readq(&dev->vdev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
 
-    qvirtio_set_driver_ok(&dev->vdev);
-
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
@@ -457,8 +449,6 @@ static void pci_msix(void)
     vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
     qvirtqueue_pci_msix_setup(dev, vqpci, qs->alloc, 1);
 
-    qvirtio_set_driver_ok(&dev->vdev);
-
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
@@ -565,8 +555,6 @@ static void pci_idx(void)
     vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
     qvirtqueue_pci_msix_setup(dev, vqpci, qs->alloc, 1);
 
-    qvirtio_set_driver_ok(&dev->vdev);
-
     /* Write request */
     req.type = VIRTIO_BLK_T_OUT;
     req.ioprio = 1;
@@ -715,9 +703,7 @@ static void mmio_basic(void)
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_start_device(&dev->vdev);
 
     alloc = generic_alloc_init(MMIO_RAM_ADDR, MMIO_RAM_SIZE, MMIO_PAGE_SIZE);
     vq = qvirtqueue_setup(&dev->vdev, alloc, 0);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index b285a262e9..b2a5f5a350 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -45,9 +45,7 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_NET);
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_start_device(&dev->vdev);
 
     return dev;
 }
@@ -80,8 +78,6 @@ static void driver_init(QVirtioDevice *dev)
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
                             (1u << VIRTIO_RING_F_EVENT_IDX));
     qvirtio_set_features(dev, features);
-
-    qvirtio_set_driver_ok(dev);
 }
 
 static void rx_test(QVirtioDevice *dev,
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 037872bb98..1581b6926c 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -159,9 +159,7 @@ static QVirtIOSCSI *qvirtio_scsi_pci_init(int slot)
     g_assert_cmphex(vs->dev->device_type, ==, VIRTIO_ID_SCSI);
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(vs->dev);
-    qvirtio_set_acknowledge(vs->dev);
-    qvirtio_set_driver(vs->dev);
+    qvirtio_start_device(vs->dev);
 
     vs->num_queues = qvirtio_config_readl(vs->dev, 0);
 
-- 
2.17.1
