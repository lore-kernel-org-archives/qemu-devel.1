Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E50CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B0620650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+bXTYPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B0620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDoR-0007vr-SR
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDWe-0004JP-3U
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDWb-0002Fb-WB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDWb-0001sl-Rn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDAf/lhMZhR1n4KRYhD/wn+oD6KKdbWtEwZje7sPGyE=;
 b=e+bXTYPKDG4XU9m+3mMFSaH1cFsGvU8pCi2oiFPRFwtebcBvUEUJh3ZbemN9BvMErPqDh6
 +dIA9wFh3UjFkMixENZWu+ACS4wrko986umNXTpL7lr8Szpn4IuZS3vze/zUNAYqNt1uGl
 tA6OKyyNXwM6FgRmZTNCUtm8qJ9tTa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4--Ku_vsafO-ObuGqHGkTMQA-1; Wed, 23 Oct 2019 06:05:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5189F47B;
 Wed, 23 Oct 2019 10:05:19 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646371001B09;
 Wed, 23 Oct 2019 10:05:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/16] libqos: extend feature bits to 64-bit
Date: Wed, 23 Oct 2019 11:04:12 +0100
Message-Id: <20191023100425.12168-4-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -Ku_vsafO-ObuGqHGkTMQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In VIRTIO 1.0 feature bits changed from 32-bit to 64-bit.  (In fact, the
transports allow even more feature bits but nothing uses more than 64
bits today.)

Add 64-bit feature bit support to virtio-mmio and virtio-pci.  This will
be necessary for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/libqos/virtio.h      | 12 ++++++------
 tests/libqos/virtio-mmio.c | 28 ++++++++++++++++++++++------
 tests/libqos/virtio-net.c  |  6 +++---
 tests/libqos/virtio-pci.c  | 12 ++++++------
 tests/libqos/virtio.c      |  4 ++--
 tests/virtio-blk-test.c    |  8 ++++----
 6 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 2cb2448f46..a5c99fb3c9 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -13,7 +13,7 @@
 #include "libqos/malloc.h"
 #include "standard-headers/linux/virtio_ring.h"
=20
-#define QVIRTIO_F_BAD_FEATURE           0x40000000
+#define QVIRTIO_F_BAD_FEATURE           0x40000000ull
=20
 typedef struct QVirtioBus QVirtioBus;
=20
@@ -52,13 +52,13 @@ struct QVirtioBus {
     uint64_t (*config_readq)(QVirtioDevice *d, uint64_t addr);
=20
     /* Get features of the device */
-    uint32_t (*get_features)(QVirtioDevice *d);
+    uint64_t (*get_features)(QVirtioDevice *d);
=20
     /* Set features of the device */
-    void (*set_features)(QVirtioDevice *d, uint32_t features);
+    void (*set_features)(QVirtioDevice *d, uint64_t features);
=20
     /* Get features of the guest */
-    uint32_t (*get_guest_features)(QVirtioDevice *d);
+    uint64_t (*get_guest_features)(QVirtioDevice *d);
=20
     /* Get status of the device */
     uint8_t (*get_status)(QVirtioDevice *d);
@@ -103,8 +103,8 @@ uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t=
 addr);
 uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr);
 uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr);
 uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr);
-uint32_t qvirtio_get_features(QVirtioDevice *d);
-void qvirtio_set_features(QVirtioDevice *d, uint32_t features);
+uint64_t qvirtio_get_features(QVirtioDevice *d);
+void qvirtio_set_features(QVirtioDevice *d, uint64_t features);
 bool qvirtio_is_big_endian(QVirtioDevice *d);
=20
 void qvirtio_reset(QVirtioDevice *d);
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 7154b03c1d..78066e6e05 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -40,22 +40,38 @@ static uint64_t qvirtio_mmio_config_readq(QVirtioDevice=
 *d, uint64_t off)
     return qtest_readq(dev->qts, dev->addr + QVIRTIO_MMIO_DEVICE_SPECIFIC =
+ off);
 }
=20
-static uint32_t qvirtio_mmio_get_features(QVirtioDevice *d)
+static uint64_t qvirtio_mmio_get_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
+    uint64_t lo;
+    uint64_t hi =3D 0;
+
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL, 0);
-    return qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+    lo =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES);
+
+    if (dev->version >=3D 2) {
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURES_SEL,=
 1);
+        hi =3D qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_HOST_FEATURE=
S);
+    }
+
+    return (hi << 32) | lo;
 }
=20
-static void qvirtio_mmio_set_features(QVirtioDevice *d, uint32_t features)
+static void qvirtio_mmio_set_features(QVirtioDevice *d, uint64_t features)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
     dev->features =3D features;
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL, 0)=
;
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES, featur=
es);
+
+    if (dev->version >=3D 2) {
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES_SEL=
, 1);
+        qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_GUEST_FEATURES,
+                     features >> 32);
+    }
 }
=20
-static uint32_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
+static uint64_t qvirtio_mmio_get_guest_features(QVirtioDevice *d)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
     return dev->features;
@@ -149,8 +165,8 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtio=
Device *d,
     vq->free_head =3D 0;
     vq->num_free =3D vq->size;
     vq->align =3D dev->page_size;
-    vq->indirect =3D (dev->features & (1u << VIRTIO_RING_F_INDIRECT_DESC))=
 !=3D 0;
-    vq->event =3D (dev->features & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D 0=
;
+    vq->indirect =3D dev->features & (1ull << VIRTIO_RING_F_INDIRECT_DESC)=
;
+    vq->event =3D dev->features & (1ull << VIRTIO_RING_F_EVENT_IDX);
=20
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_NUM, vq->size);
=20
diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 6567beb553..710d440c3d 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -44,11 +44,11 @@ static void virtio_net_setup(QVirtioNet *interface)
=20
     features =3D qvirtio_get_features(vdev);
     features &=3D ~(QVIRTIO_F_BAD_FEATURE |
-                  (1u << VIRTIO_RING_F_INDIRECT_DESC) |
-                  (1u << VIRTIO_RING_F_EVENT_IDX));
+                  (1ull << VIRTIO_RING_F_INDIRECT_DESC) |
+                  (1ull << VIRTIO_RING_F_EVENT_IDX));
     qvirtio_set_features(vdev, features);
=20
-    if (features & (1u << VIRTIO_NET_F_MQ)) {
+    if (features & (1ull << VIRTIO_NET_F_MQ)) {
         interface->n_queues =3D qvirtio_config_readw(vdev, 8) * 2;
     } else {
         interface->n_queues =3D 2;
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 50499e75ef..1b6b760fc6 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -96,19 +96,19 @@ static uint64_t qvirtio_pci_config_readq(QVirtioDevice =
*d, uint64_t off)
     return val;
 }
=20
-static uint32_t qvirtio_pci_get_features(QVirtioDevice *d)
+static uint64_t qvirtio_pci_get_features(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_HOST_FEATURES);
 }
=20
-static void qvirtio_pci_set_features(QVirtioDevice *d, uint32_t features)
+static void qvirtio_pci_set_features(QVirtioDevice *d, uint64_t features)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES, feature=
s);
 }
=20
-static uint32_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
+static uint64_t qvirtio_pci_get_guest_features(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
     return qpci_io_readl(dev->pdev, dev->bar, VIRTIO_PCI_GUEST_FEATURES);
@@ -208,7 +208,7 @@ static void qvirtio_pci_set_queue_address(QVirtioDevice=
 *d, uint32_t pfn)
 static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
                                         QGuestAllocator *alloc, uint16_t i=
ndex)
 {
-    uint32_t feat;
+    uint64_t feat;
     uint64_t addr;
     QVirtQueuePCI *vqpci;
     QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
@@ -222,8 +222,8 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioD=
evice *d,
     vqpci->vq.free_head =3D 0;
     vqpci->vq.num_free =3D vqpci->vq.size;
     vqpci->vq.align =3D VIRTIO_PCI_VRING_ALIGN;
-    vqpci->vq.indirect =3D (feat & (1u << VIRTIO_RING_F_INDIRECT_DESC)) !=
=3D 0;
-    vqpci->vq.event =3D (feat & (1u << VIRTIO_RING_F_EVENT_IDX)) !=3D 0;
+    vqpci->vq.indirect =3D feat & (1ull << VIRTIO_RING_F_INDIRECT_DESC);
+    vqpci->vq.event =3D feat & (1ull << VIRTIO_RING_F_EVENT_IDX);
=20
     vqpci->msix_entry =3D -1;
     vqpci->msix_addr =3D 0;
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 0ae9956fc8..4f7e6bb8a1 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -33,12 +33,12 @@ uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_=
t addr)
     return d->bus->config_readq(d, addr);
 }
=20
-uint32_t qvirtio_get_features(QVirtioDevice *d)
+uint64_t qvirtio_get_features(QVirtioDevice *d)
 {
     return d->bus->get_features(d);
 }
=20
-void qvirtio_set_features(QVirtioDevice *d, uint32_t features)
+void qvirtio_set_features(QVirtioDevice *d, uint64_t features)
 {
     d->features =3D features;
     d->bus->set_features(d, features);
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index f6674fb233..31680cc159 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -119,7 +119,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAlloca=
tor *alloc,
     QVirtioBlkReq req;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -352,7 +352,7 @@ static void indirect(void *obj, void *u_data, QGuestAll=
ocator *t_alloc)
     QVRingIndirectDesc *indirect;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -467,7 +467,7 @@ static void msix(void *obj, void *u_data, QGuestAllocat=
or *t_alloc)
     int n_size =3D TEST_IMAGE_SIZE / 2;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint8_t status;
     char *data;
@@ -574,7 +574,7 @@ static void idx(void *obj, void *u_data, QGuestAllocato=
r *t_alloc)
     QVirtioBlkReq req;
     uint64_t req_addr;
     uint64_t capacity;
-    uint32_t features;
+    uint64_t features;
     uint32_t free_head;
     uint32_t write_head;
     uint32_t desc_idx;
--=20
2.21.0


