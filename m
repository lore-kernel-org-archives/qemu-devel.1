Received: from eggs.gnu.org ([2001:4830:134:3::10]:35687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb4-00053I-7r
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb1-0000t1-2p
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:58 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb0-0000sc-OB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:54 -0400
Received: by mail-ed1-x544.google.com with SMTP id j21-v6so2834475edp.10
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:54 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:52 +0200
Message-Id: <20180806143412.27722-15-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 14/34] test/qgraph: virtio-pci driver and
 interface nodes
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

Add QOSGraphObject to QVirtioPCIDevice structure, with a basic
constructor. virtio-pci is not present in qgraph, since it
will be used as starting point by its subclasses (virtio-*-pci)

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include    |  2 +-
 tests/libqos/virtio-pci.c | 80 +++++++++++++++++++++++++++++++--------
 tests/libqos/virtio-pci.h | 12 ++++++
 3 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 50f1af34be..8dfbe049e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -771,7 +771,7 @@ libqgraph-machines-obj-y = tests/libqos/x86_64_pc-machine.o
 libqgraph-machines-obj-y += tests/libqos/raspi2-machine.o
 libqgraph-machines-obj-y += tests/libqos/ppc64_pseries-machine.o
 
-libqgraph-pci-obj-y = $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqgraph-pci-obj-y = $(libqos-virtio-obj-y)
 libqgraph-pci-obj-y += $(libqgraph-machines-obj-y)
 libqgraph-pci-obj-y += tests/libqos/sdhci.o
 libqgraph-pci-obj-y += tests/libqos/e1000e.o
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 550dede0a2..02aac77c88 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -15,12 +15,26 @@
 #include "libqos/pci-pc.h"
 #include "libqos/malloc.h"
 #include "libqos/malloc-pc.h"
+#include "libqos/qgraph.h"
 #include "standard-headers/linux/virtio_ring.h"
 #include "standard-headers/linux/virtio_pci.h"
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_regs.h"
 
+/* virtio-pci is a superclass of all virtio-xxx-pci devices;
+ * the relation between virtio-pci and virtio-xxx-pci is implicit,
+ * and therefore virtio-pci does not produce virtio and is not
+ * reached by any edge, not even as a "contains" edge.
+ * In facts, every device is a QVirtioPCIDevice with
+ * additional fields, since every one has its own
+ * number of queues and various attributes.
+ * Virtio-pci provides default functions to start the
+ * hw and destroy the object, and nodes that want to
+ * override them should always remember to call the
+ * original qvirtio_pci_destroy and qvirtio_pci_start_hw.
+ */
+
 typedef struct QVirtioPCIForeachData {
     void (*func)(QVirtioDevice *d, void *data);
     uint16_t device_type;
@@ -32,7 +46,6 @@ typedef struct QVirtioPCIForeachData {
 void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
 {
     g_free(dev->pdev);
-    g_free(dev);
 }
 
 static QVirtioPCIDevice *qpcidevice_to_qvirtiodevice(QPCIDevice *pdev)
@@ -76,7 +89,7 @@ static void qvirtio_pci_assign_device(QVirtioDevice *d, void *data)
 
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readb(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
 }
 
@@ -90,7 +103,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
 
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint16_t value;
 
     value = qpci_io_readw(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -102,7 +115,7 @@ static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
 
 static uint32_t qvirtio_pci_config_readl(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint32_t value;
 
     value = qpci_io_readl(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -114,7 +127,7 @@ static uint32_t qvirtio_pci_config_readl(QVirtioDevice *d, uint64_t off)
 
 static uint64_t qvirtio_pci_config_readq(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint64_t val;
 
     val = qpci_io_readq(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -127,37 +140,37 @@ static uint64_t qvirtio_pci_config_readq(QVirtioDevice *d, uint64_t off)
 
 static uint32_t qvirtio_pci_get_features(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_HOST_FEATURES);
 }
 
 static void qvirtio_pci_set_features(QVirtioDevice *d, uint32_t features)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES, features);
 }
 
 static uint32_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES);
 }
 
 static uint8_t qvirtio_pci_get_status(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_STATUS);
 }
 
 static void qvirtio_pci_set_status(QVirtioDevice *d, uint8_t status)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writeb(dev->pdev, dev->bar, VIRTIO_PCI_STATUS, status);
 }
 
 static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
     uint32_t data;
 
@@ -182,7 +195,7 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 
 static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint32_t data;
 
     if (dev->pdev->msix_enabled) {
@@ -206,19 +219,19 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 
 static void qvirtio_pci_queue_select(QVirtioDevice *d, uint16_t index)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writeb(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_SEL, index);
 }
 
 static uint16_t qvirtio_pci_get_queue_size(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
 }
 
 static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
 
@@ -270,7 +283,7 @@ static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
 
 static void qvirtio_pci_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->index);
 }
 
@@ -294,6 +307,7 @@ const QVirtioBus qvirtio_pci = {
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
 
+/* TODO: delete this once qgraph is completed */
 static void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
                 bool has_slot, int slot,
                 void (*func)(QVirtioDevice *d, void *data), void *data)
@@ -416,3 +430,37 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
     vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
     g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
 }
+
+void qvirtio_pci_destroy(QOSGraphObject *obj)
+{
+    QVirtioPCIDevice *v9p = (QVirtioPCIDevice *)obj;
+    qvirtio_pci_device_disable(v9p);
+    qvirtio_pci_device_free(v9p);
+}
+
+void qvirtio_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtioPCIDevice *v9p = (QVirtioPCIDevice *)obj;
+    qvirtio_pci_device_enable(v9p);
+    qvirtio_start_device(&v9p->vdev);
+}
+
+void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr)
+{
+    QPCIDevice *pci_dev;
+    QVirtioPCIDevice *tmp;
+
+    pci_dev = qpci_device_find(bus, addr->devfn);
+    g_assert_nonnull(pci_dev);
+    tmp = qpcidevice_to_qvirtiodevice(pci_dev);
+    memcpy(dev, tmp, sizeof(QVirtioPCIDevice));
+    dev->pdev = pci_dev;
+    dev->vdev.bus = &qvirtio_pci;
+
+    /* each virtio-xxx-pci device should override at least this function */
+    dev->obj.get_driver = NULL;
+    dev->obj.start_hw = qvirtio_pci_start_hw;
+    dev->obj.destructor = qvirtio_pci_destroy;
+
+    g_free(tmp);
+}
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 6ef19094cb..2df71861bf 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -12,8 +12,10 @@
 
 #include "libqos/virtio.h"
 #include "libqos/pci.h"
+#include "libqos/qgraph.h"
 
 typedef struct QVirtioPCIDevice {
+    QOSGraphObject obj;
     QVirtioDevice vdev;
     QPCIDevice *pdev;
     QPCIBar bar;
@@ -31,10 +33,20 @@ typedef struct QVirtQueuePCI {
 
 extern const QVirtioBus qvirtio_pci;
 
+void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr);
 QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type);
 QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
                                                uint16_t device_type, int slot);
 void qvirtio_pci_device_free(QVirtioPCIDevice *dev);
+/* virtio-pci object functions available for subclasses that
+ * override the original start_hw and destroy
+ * function. All virtio-xxx-pci subclass that override must
+ * take care of calling these two functions in the respective
+ * places
+ */
+void qvirtio_pci_destroy(QOSGraphObject *obj);
+void qvirtio_pci_start_hw(QOSGraphObject *obj);
+
 
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d);
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d);
-- 
2.17.1
