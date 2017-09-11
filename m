Received: from eggs.gnu.org ([2001:4830:134:3::10]:38322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOF-0007Av-0a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOB-00015H-Aw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:53 -0500
Message-Id: <20170911172022.4738-10-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/38] libqos: Track QTestState with
 QVirtioBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

When initializing a QVirtioDevice (which always has an associated
QVirtioBus), we want to track which QTestState to use for all
I/O processed through that bus and device.  Copy the paradigm
used for QPCIBus, and track the test state at the bus level; this
in turn requires a separate bus object per device (and associated
cleanup) rather than just sharing a const version of the dispatch
table.  Update all affected callers.

Likewise, let QVirtQueue trace back to its associated QVirtioDevice.

A later patch can then explicitly use the QTestState associated
with the bus rather than blindly relying on global_qtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/virtio-mmio.h |  6 +++---
 tests/libqos/virtio-pci.h  |  2 --
 tests/libqos/virtio.h      |  7 ++++++-
 tests/libqos/virtio-mmio.c | 12 ++++++++++--
 tests/libqos/virtio-pci.c  |  6 ++++--
 tests/libqos/virtio.c      | 10 ++++++++++
 tests/virtio-blk-test.c    |  5 +++--
 7 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index e3e52b9ce1..fe7fa636b8 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -39,8 +39,8 @@ typedef struct QVirtioMMIODevice {
     uint32_t features; /* As it cannot be read later, save it */
 } QVirtioMMIODevice;

-extern const QVirtioBus qvirtio_mmio;
-
-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size);
+QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
+                                            uint32_t page_size);
+void qvirtio_mmio_device_free(QVirtioMMIODevice *dev);

 #endif
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 6ef19094cb..bcd0594245 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -29,8 +29,6 @@ typedef struct QVirtQueuePCI {
     uint32_t msix_data;
 } QVirtQueuePCI;

-extern const QVirtioBus qvirtio_pci;
-
 QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type);
 QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
                                                uint16_t device_type, int slot);
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 8fbcd1869c..def46ad9bb 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -18,12 +18,13 @@
 typedef struct QVirtioBus QVirtioBus;

 typedef struct QVirtioDevice {
-    const QVirtioBus *bus;
+    QVirtioBus *bus;
     /* Device type */
     uint16_t device_type;
 } QVirtioDevice;

 typedef struct QVirtQueue {
+    QVirtioDevice *dev;
     uint64_t desc; /* This points to an array of struct vring_desc */
     uint64_t avail; /* This points to a struct vring_avail */
     uint64_t used; /* This points to a struct vring_used */
@@ -88,6 +89,8 @@ struct QVirtioBus {

     /* Notify changes in virtqueue */
     void (*virtqueue_kick)(QVirtioDevice *d, QVirtQueue *vq);
+
+    QTestState *qts;
 };

 static inline bool qvirtio_is_big_endian(QVirtioDevice *d)
@@ -103,6 +106,8 @@ static inline uint32_t qvring_size(uint32_t num, uint32_t align)
         + sizeof(uint16_t) * 3 + sizeof(struct vring_used_elem) * num;
 }

+QVirtioBus *qvirtio_init_bus(QTestState *qts, const QVirtioBus *base);
+
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr);
 uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr);
 uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr);
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7aa8383338..12770319cd 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -131,6 +131,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     qvirtio_mmio_queue_select(d, index);
     writel(dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);

+    vq->dev = d;
     vq->index = index;
     vq->size = qvirtio_mmio_get_queue_size(d);
     vq->free_head = 0;
@@ -187,7 +188,8 @@ const QVirtioBus qvirtio_mmio = {
     .virtqueue_kick = qvirtio_mmio_virtqueue_kick,
 };

-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
+QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
+                                            uint32_t page_size)
 {
     QVirtioMMIODevice *dev;
     uint32_t magic;
@@ -199,9 +201,15 @@ QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
     dev->addr = addr;
     dev->page_size = page_size;
     dev->vdev.device_type = readl(addr + QVIRTIO_MMIO_DEVICE_ID);
-    dev->vdev.bus = &qvirtio_mmio;
+    dev->vdev.bus = qvirtio_init_bus(qts, &qvirtio_mmio);

     writel(addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);

     return dev;
 }
+
+void qvirtio_mmio_device_free(QVirtioMMIODevice *dev)
+{
+    g_free(dev->vdev.bus);
+    g_free(dev);
+}
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c04e1..6225e6df9b 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -31,6 +31,7 @@ typedef struct QVirtioPCIForeachData {

 void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
 {
+    g_free(dev->vdev.bus);
     g_free(dev->pdev);
     g_free(dev);
 }
@@ -233,6 +234,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     feat = qvirtio_pci_get_guest_features(d);

     qvirtio_pci_queue_select(d, index);
+    vqpci->vq.dev = d;
     vqpci->vq.index = index;
     vqpci->vq.size = qvirtio_pci_get_queue_size(d);
     vqpci->vq.free_head = 0;
@@ -315,7 +317,7 @@ QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type)
     qvirtio_pci_foreach(bus, device_type, false, 0,
                         qvirtio_pci_assign_device, &dev);

-    dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.bus = qvirtio_init_bus(bus->qts, &qvirtio_pci);

     return dev;
 }
@@ -328,7 +330,7 @@ QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
     qvirtio_pci_foreach(bus, device_type, true, slot,
                         qvirtio_pci_assign_device, &dev);

-    dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.bus = qvirtio_init_bus(bus->qts, &qvirtio_pci);

     return dev;
 }
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 9880a6964e..2b7d9e62c4 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -13,6 +13,16 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"

+QVirtioBus *qvirtio_init_bus(QTestState *qts, const QVirtioBus *base)
+{
+    QVirtioBus *bus = g_new0(QVirtioBus, 1);
+
+    assert(qts);
+    *bus = *base;
+    bus->qts = qts;
+    return bus;
+}
+
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
 {
     return d->bus->config_readb(d, addr);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0576cb16ba..ca4ee645b7 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -687,7 +687,8 @@ static void mmio_basic(void)

     arm_test_start();

-    dev = qvirtio_mmio_init_device(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
+    dev = qvirtio_mmio_init_device(global_qtest, MMIO_DEV_BASE_ADDR,
+                                   MMIO_PAGE_SIZE);
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);

@@ -711,7 +712,7 @@ static void mmio_basic(void)

     /* End test */
     qvirtqueue_cleanup(dev->vdev.bus, vq, alloc);
-    g_free(dev);
+    qvirtio_mmio_device_free(dev);
     generic_alloc_uninit(alloc);
     test_end();
 }
-- 
2.13.5
