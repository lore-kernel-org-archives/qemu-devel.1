Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABDCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8CF20854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8CF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiXk-0004T9-Dw
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiOk-0003cz-P6
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiOi-000405-IO
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiOa-0003ug-FZ; Sat, 19 Oct 2019 02:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71B162E95AC;
 Sat, 19 Oct 2019 06:39:23 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBF7360BF3;
 Sat, 19 Oct 2019 06:39:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/16] libqos: access VIRTIO 1.0 vring in little-endian
Date: Sat, 19 Oct 2019 07:38:03 +0100
Message-Id: <20191019063810.6944-10-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sat, 19 Oct 2019 06:39:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIRTIO 1.0 uses little-endian for the vring.  Legacy VIRTIO uses guest
endianness.  Adjust the code to handle both.

Note that qvirtio_readq() is not defined because it has no users.  All
the other accessors are really needed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.h      |   4 +-
 tests/libqos/virtio-mmio.c |   1 +
 tests/libqos/virtio-pci.c  |   1 +
 tests/libqos/virtio.c      | 131 +++++++++++++++++++++++++++----------
 tests/virtio-blk-test.c    |   8 +--
 5 files changed, 106 insertions(+), 39 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index a5c99fb3c9..5777683a2a 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -26,6 +26,7 @@ typedef struct QVirtioDevice {
 } QVirtioDevice;
=20
 typedef struct QVirtQueue {
+    QVirtioDevice *vdev;
     uint64_t desc; /* This points to an array of struct vring_desc */
     uint64_t avail; /* This points to a struct vring_avail */
     uint64_t used; /* This points to a struct vring_used */
@@ -134,7 +135,8 @@ void qvring_init(QTestState *qts, const QGuestAllocat=
or *alloc, QVirtQueue *vq,
 QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDe=
vice *d,
                                                QGuestAllocator *alloc,
                                                uint16_t elem);
-void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indir=
ect,
+void qvring_indirect_desc_add(QVirtioDevice *d, QTestState *qts,
+                              QVRingIndirectDesc *indirect,
                               uint64_t data, uint32_t len, bool write);
 uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
                         uint32_t len, bool write, bool next);
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 78066e6e05..4db1f1b8bc 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -157,6 +157,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
     uint64_t addr;
=20
     vq =3D g_malloc0(sizeof(*vq));
+    vq->vdev =3D d;
     qvirtio_mmio_queue_select(d, index);
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_ALIGN, dev->pa=
ge_size);
=20
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 1b6b760fc6..7ecf5d0a52 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -217,6 +217,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     feat =3D qvirtio_pci_get_guest_features(d);
=20
     qvirtio_pci_queue_select(d, index);
+    vqpci->vq.vdev =3D d;
     vqpci->vq.index =3D index;
     vqpci->vq.size =3D qvirtio_pci_get_queue_size(d);
     vqpci->vq.free_head =3D 0;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 57fa79373b..b9b501a3d4 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "libqtest.h"
 #include "libqos/virtio.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -19,6 +20,62 @@ static void check_features_negotiated(QVirtioDevice *d=
)
     g_assert_cmphex(d->features, !=3D, 0);
 }
=20
+/*
+ * qtest_readX/writeX() functions transfer host endian from/to guest end=
ian.
+ * This works great for Legacy VIRTIO devices where we need guest endian
+ * accesses.  For VIRTIO 1.0 the vring is little-endian so the automatic=
 guest
+ * endianness conversion is not wanted.
+ *
+ * The following qvirtio_readX/writeX() functions handle Legacy and VIRT=
IO 1.0
+ * accesses seamlessly.
+ */
+static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_=
t addr)
+{
+    uint16_t val =3D qtest_readw(qts, addr);
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {
+        val =3D bswap16(val);
+    }
+    return val;
+}
+
+static uint32_t qvirtio_readl(QVirtioDevice *d, QTestState *qts, uint64_=
t addr)
+{
+    uint32_t val =3D qtest_readl(qts, addr);
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {
+        val =3D bswap32(val);
+    }
+    return val;
+}
+
+static void qvirtio_writew(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint16_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {
+        val =3D bswap16(val);
+    }
+    qtest_writew(qts, addr, val);
+}
+
+static void qvirtio_writel(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint32_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {
+        val =3D bswap32(val);
+    }
+    qtest_writel(qts, addr, val);
+}
+
+static void qvirtio_writeq(QVirtioDevice *d, QTestState *qts,
+                           uint64_t addr, uint64_t val)
+{
+    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(q=
ts)) {
+        val =3D bswap64(val);
+    }
+    qtest_writeq(qts, addr, val);
+}
+
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
 {
     check_features_negotiated(d);
@@ -191,23 +248,23 @@ void qvring_init(QTestState *qts, const QGuestAlloc=
ator *alloc, QVirtQueue *vq,
=20
     for (i =3D 0; i < vq->size - 1; i++) {
         /* vq->desc[i].addr */
-        qtest_writeq(qts, vq->desc + (16 * i), 0);
+        qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * i), 0);
         /* vq->desc[i].next */
-        qtest_writew(qts, vq->desc + (16 * i) + 14, i + 1);
+        qvirtio_writew(vq->vdev, qts, vq->desc + (16 * i) + 14, i + 1);
     }
=20
     /* vq->avail->flags */
-    qtest_writew(qts, vq->avail, 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail, 0);
     /* vq->avail->idx */
-    qtest_writew(qts, vq->avail + 2, 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 2, 0);
     /* vq->avail->used_event */
-    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), 0);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), 0);
=20
     /* vq->used->flags */
-    qtest_writew(qts, vq->used, 0);
+    qvirtio_writew(vq->vdev, qts, vq->used, 0);
     /* vq->used->avail_event */
-    qtest_writew(qts, vq->used + 2 + sizeof(struct vring_used_elem) * vq=
->size,
-                 0);
+    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
+            sizeof(struct vring_used_elem) * vq->size, 0);
 }
=20
 QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDe=
vice *d,
@@ -223,35 +280,39 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTes=
tState *qs, QVirtioDevice *d,
=20
     for (i =3D 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        qtest_writeq(qs, indirect->desc + (16 * i), 0);
+        qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        qtest_writew(qs, indirect->desc + (16 * i) + 12, VRING_DESC_F_NE=
XT);
+        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
+                       VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        qtest_writew(qs, indirect->desc + (16 * i) + 14, i + 1);
+        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
     }
=20
     return indirect;
 }
=20
-void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indir=
ect,
+void qvring_indirect_desc_add(QVirtioDevice *d, QTestState *qts,
+                              QVRingIndirectDesc *indirect,
                               uint64_t data, uint32_t len, bool write)
 {
     uint16_t flags;
=20
     g_assert_cmpint(indirect->index, <, indirect->elem);
=20
-    flags =3D qtest_readw(qts, indirect->desc + (16 * indirect->index) +=
 12);
+    flags =3D qvirtio_readw(d, qts, indirect->desc +
+                                  (16 * indirect->index) + 12);
=20
     if (write) {
         flags |=3D VRING_DESC_F_WRITE;
     }
=20
     /* indirect->desc[indirect->index].addr */
-    qtest_writeq(qts, indirect->desc + (16 * indirect->index), data);
+    qvirtio_writeq(d, qts, indirect->desc + (16 * indirect->index), data=
);
     /* indirect->desc[indirect->index].len */
-    qtest_writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
+    qvirtio_writel(d, qts, indirect->desc + (16 * indirect->index) + 8, =
len);
     /* indirect->desc[indirect->index].flags */
-    qtest_writew(qts, indirect->desc + (16 * indirect->index) + 12, flag=
s);
+    qvirtio_writew(d, qts, indirect->desc + (16 * indirect->index) + 12,
+                   flags);
=20
     indirect->index++;
 }
@@ -271,11 +332,11 @@ uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue=
 *vq, uint64_t data,
     }
=20
     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(qts, vq->desc + (16 * vq->free_head), data);
+    qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * vq->free_head), data)=
;
     /* vq->desc[vq->free_head].len */
-    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8, len);
+    qvirtio_writel(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 8, l=
en);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12, flags);
+    qvirtio_writew(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 12, =
flags);
=20
     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -290,13 +351,14 @@ uint32_t qvirtqueue_add_indirect(QTestState *qts, Q=
VirtQueue *vq,
     vq->num_free--;
=20
     /* vq->desc[vq->free_head].addr */
-    qtest_writeq(qts, vq->desc + (16 * vq->free_head), indirect->desc);
+    qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * vq->free_head),
+                   indirect->desc);
     /* vq->desc[vq->free_head].len */
-    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8,
-           sizeof(struct vring_desc) * indirect->elem);
+    qvirtio_writel(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 8,
+                   sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12,
-                 VRING_DESC_F_INDIRECT);
+    qvirtio_writew(vq->vdev, qts, vq->desc + (16 * vq->free_head) + 12,
+                   VRING_DESC_F_INDIRECT);
=20
     return vq->free_head++; /* Return and increase, in this order */
 }
@@ -305,21 +367,21 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice=
 *d, QVirtQueue *vq,
                      uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx =3D qtest_readw(qts, vq->avail + 2);
+    uint16_t idx =3D qvirtio_readw(d, qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
     uint16_t avail_event;
=20
     /* vq->avail->ring[idx % vq->size] */
-    qtest_writew(qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head)=
;
+    qvirtio_writew(d, qts, vq->avail + 4 + (2 * (idx % vq->size)), free_=
head);
     /* vq->avail->idx */
-    qtest_writew(qts, vq->avail + 2, idx + 1);
+    qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
=20
     /* Must read after idx is updated */
-    flags =3D qtest_readw(qts, vq->avail);
-    avail_event =3D qtest_readw(qts, vq->used + 4 +
-                                   sizeof(struct vring_used_elem) * vq->=
size);
+    flags =3D qvirtio_readw(d, qts, vq->avail);
+    avail_event =3D qvirtio_readw(d, qts, vq->used + 4 +
+                                sizeof(struct vring_used_elem) * vq->siz=
e);
=20
     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) =3D=3D 0 &&
@@ -344,7 +406,8 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *=
vq, uint32_t *desc_idx,
     uint16_t idx;
     uint64_t elem_addr, addr;
=20
-    idx =3D qtest_readw(qts, vq->used + offsetof(struct vring_used, idx)=
);
+    idx =3D qvirtio_readw(vq->vdev, qts,
+                        vq->used + offsetof(struct vring_used, idx));
     if (idx =3D=3D vq->last_used_idx) {
         return false;
     }
@@ -356,12 +419,12 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue=
 *vq, uint32_t *desc_idx,
=20
     if (desc_idx) {
         addr =3D elem_addr + offsetof(struct vring_used_elem, id);
-        *desc_idx =3D qtest_readl(qts, addr);
+        *desc_idx =3D qvirtio_readl(vq->vdev, qts, addr);
     }
=20
     if (len) {
         addr =3D elem_addr + offsetof(struct vring_used_elem, len);
-        *len =3D qtest_readw(qts, addr);
+        *len =3D qvirtio_readw(vq->vdev, qts, addr);
     }
=20
     vq->last_used_idx++;
@@ -373,7 +436,7 @@ void qvirtqueue_set_used_event(QTestState *qts, QVirt=
Queue *vq, uint16_t idx)
     g_assert(vq->event);
=20
     /* vq->avail->used_event */
-    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), idx);
+    qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), idx);
 }
=20
 void qvirtio_start_device(QVirtioDevice *vdev)
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index fe0dc4a896..2a23698211 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -388,8 +388,8 @@ static void indirect(void *obj, void *u_data, QGuestA=
llocator *t_alloc)
     g_free(req.data);
=20
     indirect =3D qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
-    qvring_indirect_desc_add(qts, indirect, req_addr, 528, false);
-    qvring_indirect_desc_add(qts, indirect, req_addr + 528, 1, true);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 528, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 528, 1, true=
);
     free_head =3D qvirtqueue_add_indirect(qts, vq, indirect);
     qvirtqueue_kick(qts, dev, vq, free_head);
=20
@@ -413,8 +413,8 @@ static void indirect(void *obj, void *u_data, QGuestA=
llocator *t_alloc)
     g_free(req.data);
=20
     indirect =3D qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
-    qvring_indirect_desc_add(qts, indirect, req_addr, 16, false);
-    qvring_indirect_desc_add(qts, indirect, req_addr + 16, 513, true);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr, 16, false);
+    qvring_indirect_desc_add(dev, qts, indirect, req_addr + 16, 513, tru=
e);
     free_head =3D qvirtqueue_add_indirect(qts, vq, indirect);
     qvirtqueue_kick(qts, dev, vq, free_head);
=20
--=20
2.21.0


