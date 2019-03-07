Received: from eggs.gnu.org ([209.51.188.92]:39185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqQ-0002jH-IQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqP-0007lE-KH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqP-0007kI-Bb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id f65so10066460wma.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:09 +0100
Message-Id: <1551979804-6060-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/57] tests/libqos: introduce
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
Cc: thuth@redhat.com, lviver@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

This function is intended to group all the qvirtio_* functions that
start the qvirtio devices.
Applied in all tests using this combination of functions.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/virtio.c    | 7 +++++++
 tests/libqos/virtio.h    | 1 +
 tests/vhost-user-test.c  | 4 +---
 tests/virtio-9p-test.c   | 4 +---
 tests/virtio-blk-test.c  | 9 ++-------
 tests/virtio-net-test.c  | 4 +---
 tests/virtio-scsi-test.c | 4 +---
 7 files changed, 14 insertions(+), 19 deletions(-)

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
index 4cd0a97..770e1e6 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -204,9 +204,7 @@ static void init_virtio_dev(QTestState *qts, TestServer *s, uint32_t features_ma
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
index 8d2fc9c..0680bd0 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -122,10 +122,7 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
     g_assert_cmphex(dev->pdev->devfn, ==, ((slot << 3) | PCI_FN));
 
     qvirtio_pci_device_enable(dev);
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
-
+    qvirtio_start_device(&dev->vdev);
     return dev;
 }
 
@@ -833,9 +830,7 @@ static void mmio_basic(void)
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-    qvirtio_reset(&dev->vdev);
-    qvirtio_set_acknowledge(&dev->vdev);
-    qvirtio_set_driver(&dev->vdev);
+    qvirtio_start_device(&dev->vdev);
 
     alloc = generic_alloc_init(MMIO_RAM_ADDR, MMIO_RAM_SIZE, MMIO_PAGE_SIZE);
     vq = qvirtqueue_setup(&dev->vdev, alloc, 0);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index e9783e6..d4a32a4 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -44,9 +44,7 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
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
