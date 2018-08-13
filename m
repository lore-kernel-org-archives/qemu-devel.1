Received: from eggs.gnu.org ([2001:4830:134:3::10]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sr-0007PB-8b
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fp9sq-0002Is-4b
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:15:33 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 13 Aug 2018 12:14:33 +0200
Message-Id: <20180813101453.10200-14-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
References: <20180813101453.10200-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 13/33] tests/qgraph: virtio_start_device
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This function is intended to group all the qvirtio_* functions that
start the qvirtio devices.
Applied in all tests using this combination of functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/virtio.c    |  7 +++++++
 tests/libqos/virtio.h    |  1 +
 tests/vhost-user-test.c  |  4 +---
 tests/virtio-9p-test.c   |  4 +---
 tests/virtio-blk-test.c  | 10 +++-------
 tests/virtio-net-test.c  |  4 +---
 tests/virtio-scsi-test.c |  4 +---
 7 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 0dad5c19ac..c1ff0206d5 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -365,3 +365,10 @@ const char *qvirtio_get_dev_type(void)
         return "pci";
     }
 }
+
+void qvirtio_start_device(QVirtioDevice *vdev)
+{
+    qvirtio_reset(vdev);
+    qvirtio_set_acknowledge(vdev);
+    qvirtio_set_driver(vdev);
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
index a976808eba..d43d09a013 100644
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
 
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index a2b31085f6..d275c74106 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -65,9 +65,7 @@ static QVirtIO9P *qvirtio_9p_pci_start(void)
     v9p->dev = (QVirtioDevice *) dev;
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(v9p->dev);
-    qvirtio_set_acknowledge(v9p->dev);
-    qvirtio_set_driver(v9p->dev);
+    qvirtio_start_device(v9p->dev);
 
     v9p->vq = qvirtqueue_setup(v9p->dev, v9p->qs->alloc, 0);
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 9be9ffb378..66797d0348 100644
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
 
@@ -329,6 +326,7 @@ static void pci_indirect(void)
     qvirtio_set_features(&dev->vdev, features);
 
     vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
+
     qvirtio_set_driver_ok(&dev->vdev);
 
     /* Write request */
@@ -715,9 +713,7 @@ static void mmio_basic(void)
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_start_device(&dev->vdev);
 
     alloc = generic_alloc_init(MMIO_RAM_ADDR, MMIO_RAM_SIZE, MMIO_PAGE_SIZE);
     vq = qvirtqueue_setup(&dev->vdev, alloc, 0);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index b285a262e9..72728acf66 100644
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
