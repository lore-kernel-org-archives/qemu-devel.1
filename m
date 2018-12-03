Received: from eggs.gnu.org ([2001:4830:134:3::10]:52064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEw-0000ZY-Fc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEt-0004xm-14
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEs-0004wl-PB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:26 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:48 +0100
Message-Id: <1543851204-41186-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 35/71] tests/libqos: virtio-pci driver and
 interface nodes
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

Add QOSGraphObject to QVirtioPCIDevice structure, with a basic
constructor. virtio-pci is not present in qgraph, since it
will be used as starting point by its subclasses (virtio-*-pci)

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include    |   1 +
 tests/libqos/virtio-pci.c | 106 ++++++++++++++++++++++++++++++++++------------
 tests/libqos/virtio-pci.h |  14 ++++++
 tests/virtio-blk-test.c   |   6 +++
 4 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index dc40b10..1d4e147 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -676,6 +676,7 @@ qos-test-obj-y = tests/qos-test.o $(libqgraph-obj-y)
 qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 qos-test-obj-y += tests/libqos/e1000e.o
 qos-test-obj-y += tests/libqos/sdhci.o
+qos-test-obj-y += $(libqos-virtio-obj-y)
 
 # Machines
 qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 550dede..6bcdbbb 100644
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
+ * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
+ */
+
 typedef struct QVirtioPCIForeachData {
     void (*func)(QVirtioDevice *d, void *data);
     uint16_t device_type;
@@ -32,36 +46,36 @@ typedef struct QVirtioPCIForeachData {
 void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
 {
     g_free(dev->pdev);
-    g_free(dev);
 }
 
-static QVirtioPCIDevice *qpcidevice_to_qvirtiodevice(QPCIDevice *pdev)
+static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice *pci_dev)
 {
-    QVirtioPCIDevice *vpcidev;
-    vpcidev = g_malloc0(sizeof(*vpcidev));
+    dev->pdev = pci_dev;
+    dev->vdev.device_type = qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID);
 
-    if (pdev) {
-        vpcidev->pdev = pdev;
-        vpcidev->vdev.device_type =
-                            qpci_config_readw(vpcidev->pdev, PCI_SUBSYSTEM_ID);
-    }
+    dev->config_msix_entry = -1;
 
-    vpcidev->config_msix_entry = -1;
+    dev->vdev.bus = &qvirtio_pci;
 
-    return vpcidev;
+    /* each virtio-xxx-pci device should override at least this function */
+    dev->obj.get_driver = NULL;
+    dev->obj.start_hw = qvirtio_pci_start_hw;
+    dev->obj.destructor = qvirtio_pci_destructor;
 }
 
 static void qvirtio_pci_foreach_callback(
                         QPCIDevice *dev, int devfn, void *data)
 {
     QVirtioPCIForeachData *d = data;
-    QVirtioPCIDevice *vpcidev = qpcidevice_to_qvirtiodevice(dev);
+    QVirtioPCIDevice *vpcidev = g_new0(QVirtioPCIDevice, 1);
 
+    qvirtio_pci_init_from_pcidev(vpcidev, dev);
     if (vpcidev->vdev.device_type == d->device_type &&
         (!d->has_slot || vpcidev->pdev->devfn == d->slot << 3)) {
         d->func(&vpcidev->vdev, d->user_data);
     } else {
         qvirtio_pci_device_free(vpcidev);
+        g_free(vpcidev);
     }
 }
 
@@ -69,14 +83,14 @@ static void qvirtio_pci_assign_device(QVirtioDevice *d, void *data)
 {
     QVirtioPCIDevice **vpcidev = data;
     assert(!*vpcidev);
-    *vpcidev = (QVirtioPCIDevice *)d;
+    *vpcidev = container_of(d, QVirtioPCIDevice, vdev);
 }
 
 #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enabled))
 
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readb(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
 }
 
@@ -90,7 +104,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
 
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint16_t value;
 
     value = qpci_io_readw(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -102,7 +116,7 @@ static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
 
 static uint32_t qvirtio_pci_config_readl(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint32_t value;
 
     value = qpci_io_readl(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -114,7 +128,7 @@ static uint32_t qvirtio_pci_config_readl(QVirtioDevice *d, uint64_t off)
 
 static uint64_t qvirtio_pci_config_readq(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint64_t val;
 
     val = qpci_io_readq(dev->pdev, dev->bar, CONFIG_BASE(dev) + off);
@@ -127,37 +141,37 @@ static uint64_t qvirtio_pci_config_readq(QVirtioDevice *d, uint64_t off)
 
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
 
@@ -182,7 +196,7 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 
 static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     uint32_t data;
 
     if (dev->pdev->msix_enabled) {
@@ -206,19 +220,19 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 
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
 
@@ -270,7 +284,7 @@ static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
 
 static void qvirtio_pci_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)d;
+    QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->index);
 }
 
@@ -294,6 +308,7 @@ const QVirtioBus qvirtio_pci = {
     .virtqueue_kick = qvirtio_pci_virtqueue_kick,
 };
 
+/* TODO: delete this once qgraph is completed */
 static void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
                 bool has_slot, int slot,
                 void (*func)(QVirtioDevice *d, void *data), void *data)
@@ -416,3 +431,38 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
     vector = qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
     g_assert_cmphex(vector, !=, VIRTIO_MSI_NO_VECTOR);
 }
+
+void qvirtio_pci_destructor(QOSGraphObject *obj)
+{
+    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)obj;
+    qvirtio_pci_device_disable(dev);
+    qvirtio_pci_device_free(dev);
+}
+
+void qvirtio_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtioPCIDevice *dev = (QVirtioPCIDevice *)obj;
+    qvirtio_pci_device_enable(dev);
+    qvirtio_start_device(&dev->vdev);
+}
+
+void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr)
+{
+    QPCIDevice *pci_dev = qpci_device_find(bus, addr->devfn);
+    g_assert_nonnull(pci_dev);
+    qvirtio_pci_init_from_pcidev(dev, pci_dev);
+}
+
+QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr)
+{
+    QVirtioPCIDevice *dev;
+    QPCIDevice *pci_dev = qpci_device_find(bus, addr->devfn);
+    if (!pci_dev) {
+        return NULL;
+    }
+
+    dev = g_new0(QVirtioPCIDevice, 1);
+    qvirtio_pci_init_from_pcidev(dev, pci_dev);
+    dev->obj.free = g_free;
+    return dev;
+}
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 6ef1909..5631352 100644
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
@@ -31,11 +33,23 @@ typedef struct QVirtQueuePCI {
 
 extern const QVirtioBus qvirtio_pci;
 
+void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * addr);
+QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
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
+void qvirtio_pci_destructor(QOSGraphObject *obj);
+void qvirtio_pci_start_hw(QOSGraphObject *obj);
+
+
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d);
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d);
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 77457f7..a9dcbe2 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -299,6 +299,7 @@ static void pci_basic(void)
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
     qtest_shutdown(qs);
 }
 
@@ -393,6 +394,7 @@ static void pci_indirect(void)
     qvirtqueue_cleanup(dev->vdev.bus, &vqpci->vq, &qs->alloc);
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
     qtest_shutdown(qs);
 }
 
@@ -422,6 +424,7 @@ static void pci_config(void)
 
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
 
     qtest_shutdown(qs);
 }
@@ -530,6 +533,7 @@ static void pci_msix(void)
     qpci_msix_disable(dev->pdev);
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
     qtest_shutdown(qs);
 }
 
@@ -653,6 +657,7 @@ static void pci_idx(void)
     qpci_msix_disable(dev->pdev);
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
     qtest_shutdown(qs);
 }
 
@@ -673,6 +678,7 @@ static void pci_hotplug(void)
     g_assert(dev);
     qvirtio_pci_device_disable(dev);
     qvirtio_pci_device_free(dev);
+    g_free(dev);
 
     /* unplug secondary disk */
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-- 
1.8.3.1
