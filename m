Received: from eggs.gnu.org ([2001:4830:134:3::10]:52526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFy-00026m-NB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqFt-0006C5-SF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqFt-0006BK-Jd
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:35:29 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:33:10 +0100
Message-Id: <1543851204-41186-58-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 57/71] tests/libqos: remove pre-qgraph
 QVirtioPCIDevice API
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

Remove the qvirtio_pci_device_find* and qvirtio_pci_device_free
APIs, now that they do not have any users.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/virtio-pci.c | 112 +++++++---------------------------------------
 tests/libqos/virtio-pci.h |   4 --
 2 files changed, 17 insertions(+), 99 deletions(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 0b58b74..993d347 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -35,14 +35,6 @@
  * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
  */
 
-typedef struct QVirtioPCIForeachData {
-    void (*func)(QVirtioDevice *d, void *data);
-    uint16_t device_type;
-    bool has_slot;
-    int slot;
-    void *user_data;
-} QVirtioPCIForeachData;
-
 static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
 {
     QPCIBus *bus = dev->pdev->bus;
@@ -51,50 +43,6 @@ static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
     return qtest_big_endian(bus->qts);
 }
 
-void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
-{
-    g_free(dev->pdev);
-}
-
-static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_dev)
-{
-    dev->pdev = pci_dev;
-    dev->vdev.device_type = qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID);
-
-    dev->config_msix_entry = -1;
-
-    dev->vdev.bus = &qvirtio_pci;
-    dev->vdev.big_endian = qvirtio_pci_is_big_endian(dev);
-
-    /* each virtio-xxx-pci device should override at least this function */
-    dev->obj.get_driver = NULL;
-    dev->obj.start_hw = qvirtio_pci_start_hw;
-    dev->obj.destructor = qvirtio_pci_destructor;
-}
-
-static void qvirtio_pci_foreach_callback(
-                        QPCIDevice *dev, int devfn, void *data)
-{
-    QVirtioPCIForeachData *d = data;
-    QVirtioPCIDevice *vpcidev = g_new0(QVirtioPCIDevice, 1);
-
-    qvirtio_pci_init_from_pcidev(vpcidev, dev);
-    if (vpcidev->vdev.device_type == d->device_type &&
-        (!d->has_slot || vpcidev->pdev->devfn == d->slot << 3)) {
-        d->func(&vpcidev->vdev, d->user_data);
-    } else {
-        qvirtio_pci_device_free(vpcidev);
-        g_free(vpcidev);
-    }
-}
-
-static void qvirtio_pci_assign_device(QVirtioDevice *d, void *data)
-{
-    QVirtioPCIDevice **vpcidev = data;
-    assert(!*vpcidev);
-    *vpcidev = container_of(d, QVirtioPCIDevice, vdev);
-}
-
 #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enabled))
 
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
@@ -317,48 +265,6 @@ const QVirtioBus qvirtio_pci = {
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
 
-/* TODO: delete this once qgraph is completed */
-static void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
-                bool has_slot, int slot,
-                void (*func)(QVirtioDevice *d, void *data), void *data)
-{
-    QVirtioPCIForeachData d = { .func = func,
-                                .device_type = device_type,
-                                .has_slot = has_slot,
-                                .slot = slot,
-                                .user_data = data };
-
-    qpci_device_foreach(bus, PCI_VENDOR_ID_REDHAT_QUMRANET, -1,
-                        qvirtio_pci_foreach_callback, &d);
-}
-
-QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type)
-{
-    QVirtioPCIDevice *dev = NULL;
-
-    qvirtio_pci_foreach(bus, device_type, false, 0,
-                        qvirtio_pci_assign_device, &dev);
-
-    if (dev) {
-        dev->vdev.bus = &qvirtio_pci;
-    }
-
-    return dev;
-}
-
-QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
-                                               uint16_t device_type, int slot)
-{
-    QVirtioPCIDevice *dev = NULL;
-
-    qvirtio_pci_foreach(bus, device_type, true, slot,
-                        qvirtio_pci_assign_device, &dev);
-
-    dev->vdev.bus = &qvirtio_pci;
-
-    return dev;
-}
-
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
@@ -445,7 +351,7 @@ void qvirtio_pci_destructor(QOSGraphObject *obj)
 {
     QVirtioPCIDevice *dev = (QVirtioPCIDevice *)obj;
     qvirtio_pci_device_disable(dev);
-    qvirtio_pci_device_free(dev);
+    g_free(dev->pdev);
 }
 
 void qvirtio_pci_start_hw(QOSGraphObject *obj)
@@ -455,6 +361,22 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
     qvirtio_start_device(&dev->vdev);
 }
 
+static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_dev)
+{
+    dev->pdev = pci_dev;
+    dev->vdev.device_type = qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID);
+
+    dev->config_msix_entry = -1;
+
+    dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.big_endian = qvirtio_pci_is_big_endian(dev);
+
+    /* each virtio-xxx-pci device should override at least this function */
+    dev->obj.get_driver = NULL;
+    dev->obj.start_hw = qvirtio_pci_start_hw;
+    dev->obj.destructor = qvirtio_pci_destructor;
+}
+
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr)
 {
     QPCIDevice *pci_dev = qpci_device_find(bus, addr->devfn);
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 5631352..728b471 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -35,10 +35,6 @@ extern const QVirtioBus qvirtio_pci;
 
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr);
 QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
-QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type);
-QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
-                                               uint16_t device_type, int slot);
-void qvirtio_pci_device_free(QVirtioPCIDevice *dev);
 
 /* virtio-pci object functions available for subclasses that
  * override the original start_hw and destroy
-- 
1.8.3.1
