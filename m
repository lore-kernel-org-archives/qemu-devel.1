Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOL-0007IH-Eb
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOJ-0001C7-8T
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:56 -0500
Message-Id: <20170911172022.4738-13-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 12/38] libqos: Use explicit QTestState for
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
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

Now that QVirtioDevice and QVirtQueue point back to QVirtioBus,
we can reuse the explicit QTestState stored there rather than
relying on implicit global_qtest.  We also have to pass QTestState
through a few functions that can't trace back through
QVirtioDevice, and update those callers.

Drop some useless casts while touching things.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/virtio.h      |  6 ++--
 tests/libqos/virtio-mmio.c | 57 ++++++++++++++++++-------------
 tests/libqos/virtio-pci.c  |  8 ++---
 tests/libqos/virtio.c      | 84 ++++++++++++++++++++++++++--------------------
 tests/virtio-blk-test.c    | 11 +++---
 5 files changed, 94 insertions(+), 72 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index def46ad9bb..cc57b77de8 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -96,7 +96,7 @@ struct QVirtioBus {
 static inline bool qvirtio_is_big_endian(QVirtioDevice *d)
 {
     /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(global_qtest);
+    return qtest_big_endian(d->bus->qts);
 }

 static inline uint32_t qvring_size(uint32_t num, uint32_t align)
@@ -139,8 +139,8 @@ void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
 void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t addr);
 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t elem);
-void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t data,
-                                                    uint32_t len, bool write);
+void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+                              uint64_t data, uint32_t len, bool write);
 uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
                                                                     bool next);
 uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect);
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 12770319cd..8d256f6ac9 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -18,40 +18,45 @@
 static uint8_t qvirtio_mmio_config_readb(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readb(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readb(d->bus->qts,
+                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint16_t qvirtio_mmio_config_readw(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readw(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readw(d->bus->qts,
+                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_config_readl(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readl(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readl(d->bus->qts,
+                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint64_t qvirtio_mmio_config_readq(QVirtioDevice *d, uint64_t off)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return readq(dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
+    return qtest_readq(d->bus->qts,
+                       dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC + off);
 }

 static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
-    return readl(dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
+    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
 }

 static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     dev->features = features;
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
-    writel(dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, features);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES,
+                 features);
 }

 static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
@@ -63,13 +68,13 @@ static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 static uint8_t qvirtio_mmio_get_status(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint8_t)readl(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
+    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS);
 }

 static void qvirtio_mmio_set_status(QVirtioDevice *d, uint8_t status)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, (uint32_t)status);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_DEVICE_STATUS, status);
 }

 static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
@@ -77,9 +82,10 @@ static bool qvirtio_mmio_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
+    isr = qtest_readl(d->bus->qts,
+                      dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 1;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
+        qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 1);
         return true;
     }

@@ -91,9 +97,10 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
     uint32_t isr;

-    isr = readl(dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
+    isr = qtest_readl(d->bus->qts,
+                      dev->addr + QVIRTIO_MMIO_INTERRUPT_STATUS) & 2;
     if (isr != 0) {
-        writel(dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
+        qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_INTERRUPT_ACK, 2);
         return true;
     }

@@ -103,21 +110,22 @@ static bool qvirtio_mmio_get_config_isr_status(QVirtioDevice *d)
 static void qvirtio_mmio_queue_select(QVirtioDevice *d, uint16_t index)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_SEL, (uint32_t)index);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_SEL, index);

-    g_assert_cmphex(readl(dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
+    g_assert_cmphex(qtest_readl(d->bus->qts,
+                                dev->addr + QVIRTIO_MMIO_QUEUE_PFN), ==, 0);
 }

 static uint16_t qvirtio_mmio_get_queue_size(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    return (uint16_t)readl(dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
+    return qtest_readl(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM_MAX);
 }

 static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }

 static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
@@ -129,7 +137,8 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,

     vq = g_malloc0(sizeof(*vq));
     qvirtio_mmio_queue_select(d, index);
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->page_size);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN,
+                 dev->page_size);

     vq->dev = d;
     vq->index = index;
@@ -140,7 +149,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtioDevice *d,
     vq->indirect = (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC)) != 0;
     vq->event = (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) != 0;

-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);

     /* Check different than 0 */
     g_assert_cmpint(vq->size, !=, 0);
@@ -165,7 +174,7 @@ static void qvirtio_mmio_virtqueue_cleanup(QVirtQueue *vq,
 static void qvirtio_mmio_virtqueue_kick(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioMMIODevice *dev = (QVirtioMMIODevice *)d;
-    writel(dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
+    qtest_writel(d->bus->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NOTIFY, vq->index);
 }

 const QVirtioBus qvirtio_mmio = {
@@ -195,15 +204,15 @@ QVirtioMMIODevice *qvirtio_mmio_init_device(QTestState *qts, uint64_t addr,
     uint32_t magic;
     dev = g_malloc0(sizeof(*dev));

-    magic = readl(addr + QVIRTIO_MMIO_MAGIC_VALUE);
+    magic = qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic == ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));

     dev->addr = addr;
     dev->page_size = page_size;
-    dev->vdev.device_type = readl(addr + QVIRTIO_MMIO_DEVICE_ID);
+    dev->vdev.device_type = qtest_readl(qts, addr + QVIRTIO_MMIO_DEVICE_ID);
     dev->vdev.bus = qvirtio_init_bus(qts, &qvirtio_mmio);

-    writel(addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);
+    qtest_writel(qts, addr + QVIRTIO_MMIO_GUEST_PAGE_SIZE, page_size);

     return dev;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 6225e6df9b..a7b17b3ba2 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -168,9 +168,9 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = readl(vqpci->msix_addr);
+            data = qtest_readl(d->bus->qts, vqpci->msix_addr);
             if (data == vqpci->msix_data) {
-                writel(vqpci->msix_addr, 0);
+                qtest_writel(d->bus->qts, vqpci->msix_addr, 0);
                 return true;
             } else {
                 return false;
@@ -192,9 +192,9 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = readl(dev->config_msix_addr);
+            data = qtest_readl(d->bus->qts, dev->config_msix_addr);
             if (data == dev->config_msix_data) {
-                writel(dev->config_msix_addr, 0);
+                qtest_writel(d->bus->qts, dev->config_msix_addr, 0);
                 return true;
             } else {
                 return false;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 2b7d9e62c4..2212830742 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -97,7 +97,7 @@ void qvirtio_wait_queue_isr(QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        clock_step(100);
+        qtest_clock_step(d->bus->qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
@@ -118,8 +118,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();
     uint8_t val;

-    while ((val = readb(addr)) == 0xff) {
-        clock_step(100);
+    while ((val = qtest_readb(d->bus->qts, addr)) == 0xff) {
+        qtest_clock_step(d->bus->qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
@@ -143,7 +143,7 @@ void qvirtio_wait_used_elem(QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;

-        clock_step(100);
+        qtest_clock_step(d->bus->qts, 100);

         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(vq, &got_desc_idx)) {
@@ -160,7 +160,7 @@ void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
     gint64 start_time = g_get_monotonic_time();

     for (;;) {
-        clock_step(100);
+        qtest_clock_step(d->bus->qts, 100);
         if (d->bus->get_config_isr_status(d)) {
             return;
         }
@@ -179,22 +179,23 @@ void qvring_init(const QGuestAllocator *alloc, QVirtQueue *vq, uint64_t addr)

     for (i = 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        writeq(vq->desc + (16 * i), 0);
+        qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        writew(vq->desc + (16 * i) + 14, i + 1);
+        qtest_writew(vq->dev->bus->qts, vq->desc + (16 * i) + 14, i + 1);
     }

     /* vq->avail->flags */
-    writew(vq->avail, 0);
+    qtest_writew(vq->dev->bus->qts, vq->avail, 0);
     /* vq->avail->idx */
-    writew(vq->avail + 2, 0);
+    qtest_writew(vq->dev->bus->qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), 0);
+    qtest_writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), 0);

     /* vq->used->flags */
-    writew(vq->used, 0);
+    qtest_writew(vq->dev->bus->qts, vq->used, 0);
     /* vq->used->avail_event */
-    writew(vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
+    qtest_writew(vq->dev->bus->qts,
+                 vq->used + 2 + sizeof(struct vring_used_elem) * vq->size, 0);
 }

 QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
@@ -209,35 +210,36 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,

     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        writeq(indirect->desc + (16 * i), 0);
+        qtest_writeq(d->bus->qts, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
+        qtest_writew(d->bus->qts, indirect->desc + (16 * i) + 12,
+                     VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        writew(indirect->desc + (16 * i) + 14, i + 1);
+        qtest_writew(d->bus->qts, indirect->desc + (16 * i) + 14, i + 1);
     }

     return indirect;
 }

-void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t data,
-                                                    uint32_t len, bool write)
+void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+                              uint64_t data, uint32_t len, bool write)
 {
     uint16_t flags;

     g_assert_cmpint(indirect->index, <, indirect->elem);

-    flags = readw(indirect->desc + (16 * indirect->index) + 12);
+    flags = qtest_readw(qts, indirect->desc + (16 * indirect->index) + 12);

     if (write) {
         flags |= VRING_DESC_F_WRITE;
     }

     /* indirect->desc[indirect->index].addr */
-    writeq(indirect->desc + (16 * indirect->index), data);
+    qtest_writeq(qts, indirect->desc + (16 * indirect->index), data);
     /* indirect->desc[indirect->index].len */
-    writel(indirect->desc + (16 * indirect->index) + 8, len);
+    qtest_writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
     /* indirect->desc[indirect->index].flags */
-    writew(indirect->desc + (16 * indirect->index) + 12, flags);
+    qtest_writew(qts, indirect->desc + (16 * indirect->index) + 12, flags);

     indirect->index++;
 }
@@ -257,11 +259,12 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
     }

     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), data);
+    qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head), data);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8, len);
+    qtest_writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8, len);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, flags);
+    qtest_writew(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 12,
+                 flags);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -275,12 +278,14 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
     vq->num_free--;

     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), indirect->desc);
+    qtest_writeq(vq->dev->bus->qts, vq->desc + (16 * vq->free_head),
+                 indirect->desc);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8,
-           sizeof(struct vring_desc) * indirect->elem);
+    qtest_writel(vq->dev->bus->qts, vq->desc + (16 * vq->free_head) + 8,
+                 sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);
+    qtest_writew(vq->dev->bus->qts,
+                 vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);

     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -288,21 +293,24 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
 void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx = readw(vq->avail + 2);
+    uint16_t idx = qtest_readw(d->bus->qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
     uint16_t avail_event;

+    assert(vq->dev == d);
+
     /* vq->avail->ring[idx % vq->size] */
-    writew(vq->avail + 4 + (2 * (idx % vq->size)), free_head);
+    qtest_writew(d->bus->qts, vq->avail + 4 + (2 * (idx % vq->size)),
+                 free_head);
     /* vq->avail->idx */
-    writew(vq->avail + 2, idx + 1);
+    qtest_writew(d->bus->qts, vq->avail + 2, idx + 1);

     /* Must read after idx is updated */
-    flags = readw(vq->avail);
-    avail_event = readw(vq->used + 4 +
-                                sizeof(struct vring_used_elem) * vq->size);
+    flags = qtest_readw(d->bus->qts, vq->avail);
+    avail_event = qtest_readw(d->bus->qts, vq->used + 4 +
+                              sizeof(struct vring_used_elem) * vq->size);

     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
@@ -323,7 +331,8 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
 {
     uint16_t idx;

-    idx = readw(vq->used + offsetof(struct vring_used, idx));
+    idx = qtest_readw(vq->dev->bus->qts,
+                      vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
@@ -335,7 +344,8 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx)
                     offsetof(struct vring_used, ring) +
                     (vq->last_used_idx % vq->size) *
                     sizeof(struct vring_used_elem);
-        *desc_idx = readl(elem_addr + offsetof(struct vring_used_elem, id));
+        *desc_idx = qtest_readl(vq->dev->bus->qts, elem_addr +
+                                offsetof(struct vring_used_elem, id));
     }

     vq->last_used_idx++;
@@ -347,5 +357,5 @@ void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
     g_assert(vq->event);

     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), idx);
+    qtest_writew(vq->dev->bus->qts, vq->avail + 4 + (2 * vq->size), idx);
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 2d38c49bfe..99bb6f26cd 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -343,8 +343,10 @@ static void pci_indirect(void)
     g_free(req.data);

     indirect = qvring_indirect_desc_setup(&dev->vdev, qs->alloc, 2);
-    qvring_indirect_desc_add(indirect, req_addr, 528, false);
-    qvring_indirect_desc_add(indirect, req_addr + 528, 1, true);
+    qvring_indirect_desc_add(dev->vdev.bus->qts, indirect, req_addr, 528,
+                             false);
+    qvring_indirect_desc_add(dev->vdev.bus->qts, indirect, req_addr + 528, 1,
+                             true);
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);

@@ -368,8 +370,9 @@ static void pci_indirect(void)
     g_free(req.data);

     indirect = qvring_indirect_desc_setup(&dev->vdev, qs->alloc, 2);
-    qvring_indirect_desc_add(indirect, req_addr, 16, false);
-    qvring_indirect_desc_add(indirect, req_addr + 16, 513, true);
+    qvring_indirect_desc_add(dev->vdev.bus->qts, indirect, req_addr, 16, false);
+    qvring_indirect_desc_add(dev->vdev.bus->qts, indirect, req_addr + 16, 513,
+                             true);
     free_head = qvirtqueue_add_indirect(&vqpci->vq, indirect);
     qvirtqueue_kick(&dev->vdev, &vqpci->vq, free_head);

-- 
2.13.5
