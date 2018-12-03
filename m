Received: from eggs.gnu.org ([2001:4830:134:3::10]:51655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEO-00084j-Co
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEM-0004IG-UE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEM-0004Gw-LW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:54 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:28 +0100
Message-Id: <1543851204-41186-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/71] tests/libqos: introduce
 virtio_start_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This function is intended to group all the qvirtio_* functions that
start the qvirtio devices.
Applied in all tests using this combination of functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 0dad5c1..c1ff020 100644
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
index 69b5b13..2c68668 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -146,5 +146,6 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len);
 void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
 
 const char *qvirtio_get_dev_type(void);
+void qvirtio_start_device(QVirtioDevice *vdev);
 
 #endif
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 23f129f..df8edb3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -200,9 +200,7 @@ static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_ma
     g_assert_nonnull(s->dev);
 
     qvirtio_pci_device_enable(s->dev);
-    qvirtio_reset(&s->dev->vdev);
-    qvirtio_set_acknowledge(&s->dev->vdev);
-    qvirtio_set_driver(&s->dev->vdev);
+    qvirtio_start_device(&s->dev->vdev);
 
     s->alloc = pc_alloc_init(qts);
 
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index a2b3108..d275c74 100644
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
index 04c6087..f97c158 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -116,10 +116,7 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
     g_assert_cmphex(dev->pdev->devfn, ==, ((slot << 3) | PCI_FN));
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
-
+    qvirtio_start_device(&dev->vdev);
     return dev;
 }
 
@@ -333,6 +330,7 @@ static void pci_indirect(void)
     qvirtio_set_features(&dev->vdev, features);
 
     vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
+
     qvirtio_set_driver_ok(&dev->vdev);
 
     /* Write request */
@@ -720,9 +718,7 @@ static void mmio_basic(void)
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_start_device(&dev->vdev);
 
     alloc = generic_alloc_init(MMIO_RAM_ADDR, MMIO_RAM_SIZE, MMIO_PAGE_SIZE);
     vq = qvirtqueue_setup(&dev->vdev, alloc, 0);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index dcb87a8..f89e08f 100644
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
index 0d4f25d..961925c 100644
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
1.8.3.1
