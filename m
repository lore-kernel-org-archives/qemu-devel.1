Received: from eggs.gnu.org ([2001:4830:134:3::10]:35699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb5-000540-3q
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb3-0000v3-P3
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:59 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb3-0000uK-Dp
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:57 -0400
Received: by mail-ed1-x541.google.com with SMTP id e6-v6so5262682edr.2
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:57 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:54 +0200
Message-Id: <20180806143412.27722-17-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 16/34] test/qgraph: virtio-mmio driver and
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

Add virtio-mmio node in qgraph framework.
virtio-mmio produces virtio, the interface consumed by all virtio-*-device
nodes.

Being a memory-mapped device, it doesn't have to provide a constructor
to qgraph, since it's always "contained" inside some other nodes.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/virtio-mmio.c | 70 ++++++++++++++++++++++++++++----------
 tests/libqos/virtio-mmio.h |  4 +++
 2 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 6f4c1b0955..68bceb9a17 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -13,42 +13,43 @@
 #include "libqos/virtio-mmio.h"
 #include "libqos/malloc.h"
 #include "libqos/malloc-generic.h"
+#include "libqos/qgraph.h"
 #include "standard-headers/linux/virtio_ring.h"
 
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return readb(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint16_t qvirtio_mmio_config_readw(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return readw(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint32_t qvirtio_mmio_config_readl(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return readl(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint64_t qvirtio_mmio_config_readq(QVirtioDevice *d, uint64_t off)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return readq(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }
 
 static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     writel(dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
     return readl(dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
 }
 
 static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     dev->features = features;
     writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
     writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
@@ -56,25 +57,25 @@ static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 
 static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return dev->features;
 }
 
 static uint8_t qvirtio_mmio_get_status(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return (uint8_t)readl(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
 }
 
 static void qvirtio_mmio_set_status(QVirtioDevice *d, uint8_t status)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     writel(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, (uint32_t)status);
 }
 
 static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     uint32_t isr;
 
     isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
@@ -88,7 +89,7 @@ static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 
 static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     uint32_t isr;
 
     isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
@@ -102,7 +103,7 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 
 static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     writel(dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);
 
     g_assert_cmphex(readl(dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
@@ -110,20 +111,20 @@ static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 
 static uint16_t qvirtio_mmio_get_queue_size(QVirtioDevice *d)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     return (uint16_t)readl(dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
 }
 
 static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     writel(dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }
 
 static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t index)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     QVirtQueue *vq;
     uint64_t addr;
 
@@ -163,7 +164,7 @@ static void qvirtio_mmio_virtqueue_cleanup(QVirtQueue *vq,
 
 static void qvirtio_mmio_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
-    QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
+    QVirtioMMIODevice *dev = container_of(d, QVirtioMMIODevice, vdev);
     writel(dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
 }
 
@@ -187,12 +188,36 @@ const QVirtioBus qvirtio_mmio = {
     .virtqueue_kick = qvirtio_mmio_virtqueue_kick,
 };
 
+static void *qvirtio_mmio_get_driver(void *obj, const char *interface)
+{
+    QVirtioMMIODevice *virtio_mmio = obj;
+    if (!g_strcmp0(interface, "virtio")) {
+        return &virtio_mmio->vdev;
+    }
+    printf("%s not present in virtio-mmio\n", interface);
+    abort();
+}
+
 QVirtioMMIODevice *qvirtio_mmio_device_new(uint64_t addr, uint32_t page_size)
 {
     QVirtioMMIODevice *dev;
-    uint32_t magic;
     dev = g_malloc0(sizeof(*dev));
 
+    qvirtio_mmio_init_device(dev, addr, page_size);
+
+    return dev;
+}
+
+static void qvirtio_mmio_start_hw(QOSGraphObject *obj)
+{
+    QVirtioMMIODevice *dev = (QVirtioMMIODevice *) obj;
+    qvirtio_start_device(&dev->vdev);
+}
+
+void qvirtio_mmio_init_device(QVirtioMMIODevice *dev, uint64_t addr,
+                             uint32_t page_size)
+{
+    uint32_t magic;
     magic = readl(addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));
 
@@ -203,5 +228,14 @@ QVirtioMMIODevice *qvirtio_mmio_device_new(uint64_t addr, uint32_t page_size)
 
     writel(addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
 
-    return dev;
+    dev->obj.get_driver = qvirtio_mmio_get_driver;
+    dev->obj.start_hw = qvirtio_mmio_start_hw;
 }
+
+static void virtio_mmio(void)
+{
+    qos_node_create_driver("virtio-mmio", NULL);
+    qos_node_produces("virtio-mmio", "virtio");
+}
+
+libqos_init(virtio_mmio);
diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index bcc09895fd..9d5af70cfc 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -11,6 +11,7 @@
 #define LIBQOS_VIRTIO_MMIO_H
 
 #include "libqos/virtio.h"
+#include "libqos/qgraph.h"
 
 #define QVIRTIO_MMIO_MAGIC_VALUE        0x000
 #define QVIRTIO_MMIO_VERSION            0x004
@@ -33,6 +34,7 @@
 #define QVIRTIO_MMIO_DEVICE_SPECIFIC    0x100
 
 typedef struct QVirtioMMIODevice {
+    QOSGraphObject obj;
     QVirtioDevice vdev;
     uint64_t addr;
     uint32_t page_size;
@@ -42,5 +44,7 @@ typedef struct QVirtioMMIODevice {
 extern const QVirtioBus qvirtio_mmio;
 
 QVirtioMMIODevice *qvirtio_mmio_device_new(uint64_t addr, uint32_t page_size);
+void qvirtio_mmio_init_device(QVirtioMMIODevice *dev, uint64_t addr,
+                             uint32_t page_size);
 
 #endif
-- 
2.17.1
