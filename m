Received: from eggs.gnu.org ([2001:4830:134:3::10]:52084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEx-0000c9-QM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEw-00051Z-3E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEv-00050S-Lm
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:30 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:50 +0100
Message-Id: <1543851204-41186-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 37/71] tests/libqos: virtio-mmio driver and
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

Add virtio-mmio node in qgraph framework.
virtio-mmio produces virtio-bus, the interface consumed by all virtio-*-device
nodes.

Being a memory-mapped device, it doesn't have to provide a constructor
to qgraph, since it's always "contained" inside some other nodes.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/virtio-mmio.c | 116 +++++++++++++++++++++++++++------------------
 tests/libqos/virtio-mmio.h |   6 ++-
 tests/virtio-blk-test.c    |   3 +-
 3 files changed, 77 insertions(+), 48 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7aa8383..b46621e 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -12,74 +12,74 @@
 #include "libqos/virtio.h"
 #include "libqos/virtio-mmio.h"
 #include "libqos/malloc.h"
-#include "libqos/malloc-generic.h"
+#include "libqos/qgraph.h"
 #include "standard-headers/linux/virtio_ring.h"
 
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readb(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return qtest_readb(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint16_t qvirtio_mmio_config_readw(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readw(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return qtest_readw(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint32_t qvirtio_mmio_config_readl(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readl(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint64_t qvirtio_mmio_config_readq(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readq(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return qtest_readq(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
-    return readl(dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
+    return qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
 }
 
 static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     dev->features = features;
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
 }
 
 static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return dev->features;
 }
 
 static uint8_t qvirtio_mmio_get_status(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint8_t)readl(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return (uint8_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
 }
 
 static void qvirtio_mmio_set_status(QVirtioDevice *d, uint8_t status)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, (uint32_t)status);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, (uint32_t)status);
 }
 
 static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     uint32_t isr;
 
-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
+    isr = qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
         return true;
     }
 
@@ -88,12 +88,12 @@ static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 
 static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     uint32_t isr;
 
-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
+    isr = qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
         return true;
     }
 
@@ -102,34 +102,34 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 
 static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);
 
-    g_assert_cmphex(readl(dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
+    g_assert_cmphex(qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
 }
 
 static uint16_t qvirtio_mmio_get_queue_size(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint16_t)readl(dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
 }
 
 static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }
 
 static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t index)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     QVirtQueue *vq;
     uint64_t addr;
 
     vq = g_malloc0(sizeof(*vq));
     qvirtio_mmio_queue_select(d, index);
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
 
     vq->index = index;
     vq->size = qvirtio_mmio_get_queue_size(d);
@@ -139,7 +139,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     vq->indirect = (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC)) != 0;
     vq->event = (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) != 0;
 
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
 
     /* Check different than 0 */
     g_assert_cmpint(vq->size, !=, 0);
@@ -163,8 +163,8 @@ static void qvirtio_mmio_virtqueue_cleanup(QVirtQueue *vq,
 
 static void qvirtio_mmio_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
+    qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
 }
 
 const QVirtioBus qvirtio_mmio = {
@@ -187,21 +187,45 @@ const QVirtioBus qvirtio_mmio = {
     .virtqueue_kick = qvirtio_mmio_virtqueue_kick,
 };
 
-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
+static void *qvirtio_mmio_get_driver(void *obj, const char *interface)
 {
-    QVirtioMMIODevice *dev;
-    uint32_t magic;
-    dev = g_malloc0(sizeof(*dev));
+    QVirtioMMIODevice *virtio_mmio = obj;
+    if (!g_strcmp0(interface, "virtio-bus")) {
+        return &virtio_mmio->vdev;
+    }
+    fprintf(stderr, "%s not present in virtio-mmio\n", interface);
+    g_assert_not_reached();
+}
+
+static void qvirtio_mmio_start_hw(QOSGraphObject *obj)
+{
+    QVirtioMMIODevice *dev = (QVirtioMMIODevice *) obj;
+    qvirtio_start_device(&dev->vdev);
+}
 
-    magic = readl(addr + QVIRTIO_MMIO_MAGIC_VALUE);
+void qvirtio_mmio_init_device(QVirtioMMIODevice *dev, QTestState *qts,
+			      uint64_t addr, uint32_t page_size)
+{
+    uint32_t magic;
+    magic = qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));
 
+    dev->qts = qts;
     dev->addr = addr;
     dev->page_size = page_size;
-    dev->vdev.device_type = readl(addr + QVIRTIO_MMIO_DEVICE_ID);
+    dev->vdev.device_type = qtest_readl(qts, addr + QVIRTIO_MMIO_DEVICE_ID);
     dev->vdev.bus = &qvirtio_mmio;
 
-    writel(addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
+    qtest_writel(qts, addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
+
+    dev->obj.get_driver = qvirtio_mmio_get_driver;
+    dev->obj.start_hw = qvirtio_mmio_start_hw;
+}
 
-    return dev;
+static void virtio_mmio_register_nodes(void)
+{
+    qos_node_create_driver("virtio-mmio", NULL);
+    qos_node_produces("virtio-mmio", "virtio-bus");
 }
+
+libqos_init(virtio_mmio_register_nodes);
diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index e3e52b9..2b4198f 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -11,6 +11,7 @@
 #define LIBQOS_VIRTIO_MMIO_H
 
 #include "libqos/virtio.h"
+#include "libqos/qgraph.h"
 
 #define QVIRTIO_MMIO_MAGIC_VALUE        0x000
 #define QVIRTIO_MMIO_VERSION            0x004
@@ -33,7 +34,9 @@
 #define QVIRTIO_MMIO_DEVICE_SPECIFIC    0x100
 
 typedef struct QVirtioMMIODevice {
+    QOSGraphObject obj;
     QVirtioDevice vdev;
+    QTestState *qts;
     uint64_t addr;
     uint32_t page_size;
     uint32_t features; /* As it cannot be read later, save it */
@@ -41,6 +44,7 @@ typedef struct QVirtioMMIODevice {
 
 extern const QVirtioBus qvirtio_mmio;
 
-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size);
+void qvirtio_mmio_init_device(QVirtioMMIODevice *dev, QTestState *qts,
+			      uint64_t addr, uint32_t page_size);
 
 #endif
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index a9dcbe2..0a13a5a 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -721,7 +721,8 @@ static void mmio_basic(void)
 
     arm_test_start();
 
-    dev = qvirtio_mmio_init_device(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
+    dev = g_malloc0(sizeof(QVirtioMMIODevice));
+    qvirtio_mmio_init_device(dev, global_qtest, MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);
 
-- 
1.8.3.1
