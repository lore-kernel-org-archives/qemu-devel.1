Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIu-0007X9-NU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIo-0001yO-C6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:27 -0500
Message-Id: <20170901180340.30009-17-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 16/29] libqos: Use explicit QTestState for
 virtio operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

Drop one more client of global_qtest by teaching all virtio test
functionality to pass in an explicit QTestState in constructors,
where it is then reused for later access.  Adjust all callers.
This gets us one step closer to eliminating implicit use of
global_qtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/virtio-mmio.h |  3 +-
 tests/libqos/virtio.h      |  5 ++-
 tests/libqos/virtio-mmio.c | 54 +++++++++++++++++---------------
 tests/libqos/virtio-pci.c  |  3 ++
 tests/libqos/virtio.c      | 77 ++++++++++++++++++++++++++--------------------
 tests/virtio-blk-test.c    |  3 +-
 6 files changed, 84 insertions(+), 61 deletions(-)

diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index e3e52b9ce1..bd01386054 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -41,6 +41,7 @@ typedef struct QVirtioMMIODevice {

 extern const QVirtioBus qvirtio_mmio;

-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size);
+QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
+                                            uint32_t page_size);

 #endif
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 8fbcd1869c..d180d54fc4 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -19,6 +19,7 @@ typedef struct QVirtioBus QVirtioBus;

 typedef struct QVirtioDevice {
     const QVirtioBus *bus;
+    QTestState *qts;
     /* Device type */
     uint16_t device_type;
 } QVirtioDevice;
@@ -35,12 +36,14 @@ typedef struct QVirtQueue {
     uint16_t last_used_idx;
     bool indirect;
     bool event;
+    QTestState *qts;
 } QVirtQueue;

 typedef struct QVRingIndirectDesc {
     uint64_t desc; /* This points to an array fo struct vring_desc */
     uint16_t index;
     uint16_t elem;
+    QTestState *qts;
 } QVRingIndirectDesc;

 struct QVirtioBus {
@@ -93,7 +96,7 @@ struct QVirtioBus {
 static inline bool qvirtio_is_big_endian(QVirtioDevice *d)
 {
     /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(global_qtest);
+    return qtest_big_endian(d->qts);
 }

 static inline uint32_t qvring_size(uint32_t num, uint32_t align)
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7aa8383338..d151209d8e 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -18,40 +18,40 @@
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readb(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readb(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint16_t qvirtio_mmio_config_readw(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readw(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readw(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_config_readl(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readl(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint64_t qvirtio_mmio_config_readq(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readq(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readq(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
-    return readl(dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
+    return qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
 }

 static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     dev->features = features;
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
 }

 static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
@@ -63,13 +63,14 @@ static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 static uint8_t qvirtio_mmio_get_status(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint8_t)readl(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
+    return (uint8_t)qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
 }

 static void qvirtio_mmio_set_status(QVirtioDevice *d, uint8_t status)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, (uint32_t)status);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS,
+                 (uint32_t)status);
 }

 static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
@@ -77,9 +78,9 @@ static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
+    isr = qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
+        qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
         return true;
     }

@@ -91,9 +92,9 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
+    isr = qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
+        qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
         return true;
     }

@@ -103,21 +104,23 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);

-    g_assert_cmphex(readl(dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
+    g_assert_cmphex(qtest_readl(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN),
+                    ==, 0);
 }

 static uint16_t qvirtio_mmio_get_queue_size(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint16_t)readl(dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
+    return (uint16_t)qtest_readl(d->qts,
+                                 dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
 }

 static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }

 static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
@@ -128,8 +131,9 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     uint64_t addr;

     vq = g_malloc0(sizeof(*vq));
+    vq->qts = d->qts;
     qvirtio_mmio_queue_select(d, index);
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);

     vq->index = index;
     vq->size = qvirtio_mmio_get_queue_size(d);
@@ -139,7 +143,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     vq->indirect = (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC)) != 0;
     vq->event = (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) != 0;

-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);

     /* Check different than 0 */
     g_assert_cmpint(vq->size, !=, 0);
@@ -164,7 +168,7 @@ static void qvirtio_mmio_virtqueue_cleanup(QVirtQueue *vq,
 static void qvirtio_mmio_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
+    qtest_writel(d->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
 }

 const QVirtioBus qvirtio_mmio = {
@@ -187,21 +191,23 @@ const QVirtioBus qvirtio_mmio = {
     .virtqueue_kick = qvirtio_mmio_virtqueue_kick,
 };

-QVirtioMMIODevice *qvirtio_mmio_init_device(uint64_t addr, uint32_t page_size)
+QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
+                                            uint32_t page_size)
 {
     QVirtioMMIODevice *dev;
     uint32_t magic;
     dev = g_malloc0(sizeof(*dev));

-    magic = readl(addr + QVIRTIO_MMIO_MAGIC_VALUE);
+    magic = qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));

     dev->addr = addr;
     dev->page_size = page_size;
     dev->vdev.device_type = readl(addr + QVIRTIO_MMIO_DEVICE_ID);
     dev->vdev.bus = &qvirtio_mmio;
+    dev->vdev.qts = qts;

-    writel(addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
+    qtest_writel(qts, addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);

     return dev;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ac15c04e1..f15971220c 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -240,6 +240,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
     vqpci->vq.align = VIRTIO_PCI_VRING_ALIGN;
     vqpci->vq.indirect = (feat & (1u << VIRTIO_RING_F_INDIRECT_DESC)) != 0;
     vqpci->vq.event = (feat & (1u << VIRTIO_RING_F_EVENT_IDX)) != 0;
+    vqpci->vq.qts = d->qts;

     vqpci->msix_entry = -1;
     vqpci->msix_addr = 0;
@@ -316,6 +317,7 @@ QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_type)
                         qvirtio_pci_assign_device, &dev);

     dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.qts = bus->qts;

     return dev;
 }
@@ -329,6 +331,7 @@ QVirtioPCIDevice *qvirtio_pci_device_find_slot(QPCIBus *bus,
                         qvirtio_pci_assign_device, &dev);

     dev->vdev.bus = &qvirtio_pci;
+    dev->vdev.qts = bus->qts;

     return dev;
 }
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 9880a6964e..064a82f0f3 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -87,7 +87,7 @@ void qvirtio_wait_queue_isr(QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        clock_step(100);
+        qtest_clock_step(d->qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
@@ -109,7 +109,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
     uint8_t val;

     while ((val = readb(addr)) == 0xff) {
-        clock_step(100);
+        qtest_clock_step(d->qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
@@ -133,7 +133,7 @@ void qvirtio_wait_used_elem(QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;

-        clock_step(100);
+        qtest_clock_step(d->qts, 100);

         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(vq, &got_desc_idx)) {
@@ -150,7 +150,7 @@ void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        clock_step(100);
+        qtest_clock_step(d->qts, 100);
         if (d->bus->get_config_isr_status(d)) {
             return;
         }
@@ -169,22 +169,23 @@ void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t addr)

     for (i = 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        writeq(vq->desc + (16 * i), 0);
+        qtest_writeq(vq->qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        writew(vq->desc + (16 * i) + 14, i + 1);
+        qtest_writew(vq->qts, vq->desc + (16 * i) + 14, i + 1);
     }

     /* vq->avail->flags */
-    writew(vq->avail, 0);
+    qtest_writew(vq->qts, vq->avail, 0);
     /* vq->avail->idx */
-    writew(vq->avail + 2, 0);
+    qtest_writew(vq->qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), 0);
+    qtest_writew(vq->qts, vq->avail + 4 + (2 * vq->size), 0);

     /* vq->used->flags */
-    writew(vq->used, 0);
+    qtest_writew(vq->qts, vq->used, 0);
     /* vq->used->avail_event */
-    writew(vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
+    qtest_writew(vq->qts,
+                 vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
 }

 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
@@ -196,14 +197,15 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
     indirect->index = 0;
     indirect->elem = elem;
     indirect->desc = guest_alloc(alloc, sizeof(struct vring_desc) * elem);
+    indirect->qts = d->qts;

     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        writeq(indirect->desc + (16 * i), 0);
+        qtest_writeq(d->qts, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
+        qtest_writew(d->qts, indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        writew(indirect->desc + (16 * i) + 14, i + 1);
+        qtest_writew(d->qts, indirect->desc + (16 * i) + 14, i + 1);
     }

     return indirect;
@@ -216,18 +218,21 @@ void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t data,

     g_assert_cmpint(indirect->index, <, indirect->elem);

-    flags = readw(indirect->desc + (16 * indirect->index) + 12);
+    flags = qtest_readw(indirect->qts,
+                        indirect->desc + (16 * indirect->index) + 12);

     if (write) {
         flags |= VRING_DESC_F_WRITE;
     }

     /* indirect->desc[indirect->index].addr */
-    writeq(indirect->desc + (16 * indirect->index), data);
+    qtest_writeq(indirect->qts, indirect->desc + (16 * indirect->index), data);
     /* indirect->desc[indirect->index].len */
-    writel(indirect->desc + (16 * indirect->index) + 8, len);
+    qtest_writel(indirect->qts,
+                 indirect->desc + (16 * indirect->index) + 8, len);
     /* indirect->desc[indirect->index].flags */
-    writew(indirect->desc + (16 * indirect->index) + 12, flags);
+    qtest_writew(indirect->qts,
+                 indirect->desc + (16 * indirect->index) + 12, flags);

     indirect->index++;
 }
@@ -247,11 +252,11 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
     }

     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), data);
+    qtest_writeq(vq->qts, vq->desc + (16 * vq->free_head), data);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8, len);
+    qtest_writel(vq->qts, vq->desc + (16 * vq->free_head) + 8, len);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, flags);
+    qtest_writew(vq->qts, vq->desc + (16 * vq->free_head) + 12, flags);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -265,12 +270,13 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
     vq->num_free--;

     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), indirect->desc);
+    qtest_writeq(vq->qts, vq->desc + (16 * vq->free_head), indirect->desc);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8,
-           sizeof(struct vring_desc) * indirect->elem);
+    qtest_writel(vq->qts, vq->desc + (16 * vq->free_head) + 8,
+                 sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);
+    qtest_writew(vq->qts,
+                 vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -278,21 +284,23 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
 void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx = readw(vq->avail + 2);
+    uint16_t idx = qtest_readw(d->qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
     uint16_t avail_event;

+    assert(d->qts == vq->qts);
+
     /* vq->avail->ring[idx % vq->size] */
-    writew(vq->avail + 4 + (2 * (idx % vq->size)), free_head);
+    qtest_writew(d->qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
     /* vq->avail->idx */
-    writew(vq->avail + 2, idx + 1);
+    qtest_writew(d->qts, vq->avail + 2, idx + 1);

     /* Must read after idx is updated */
-    flags = readw(vq->avail);
-    avail_event = readw(vq->used + 4 +
-                                sizeof(struct vring_used_elem) * vq->size);
+    flags = qtest_readw(d->qts, vq->avail);
+    avail_event = qtest_readw(d->qts, vq->used + 4 +
+                              sizeof(struct vring_used_elem) * vq->size);

     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
@@ -313,7 +321,7 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
 {
     uint16_t idx;

-    idx = readw(vq->used + offsetof(struct vring_used, idx));
+    idx = qtest_readw(vq->qts, vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
@@ -325,7 +333,8 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
                     offsetof(struct vring_used, ring) +
                     (vq->last_used_idx % vq->size) *
                     sizeof(struct vring_used_elem);
-        *desc_idx = readl(elem_addr + offsetof(struct vring_used_elem, id));
+        *desc_idx = qtest_readl(vq->qts, elem_addr +
+                                offsetof(struct vring_used_elem, id));
     }

     vq->last_used_idx++;
@@ -337,5 +346,5 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     g_assert(vq->event);

     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), idx);
+    qtest_writew(vq->qts, vq->avail + 4 + (2 * vq->size), idx);
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0576cb16ba..26d0a7e9af 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -687,7 +687,8 @@ static void mmio_basic(void)

     arm_test_start();

-    dev = qvirtio_mmio_init_device(MMIO_DEV_BASE_ADDR, MMIO_PAGE_SIZE);
+    dev = qvirtio_mmio_init_device(global_qtest, MMIO_DEV_BASE_ADDR,
+                                   MMIO_PAGE_SIZE);
     g_assert(dev != NULL);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_BLOCK);

-- 
2.13.5
