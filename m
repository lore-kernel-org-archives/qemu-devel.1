Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC58C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158EB2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158EB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbJK-0001A3-7u
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIaqS-0005U7-ND
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIaqR-00038J-Fv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIaqR-00037b-7d
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7996A10CC1E3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:59:14 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD8D35C1B5;
 Thu, 10 Oct 2019 15:59:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] libqos: pass full QVirtQueue to set_queue_address()
Date: Thu, 10 Oct 2019 16:58:49 +0100
Message-Id: <20191010155853.4325-4-stefanha@redhat.com>
In-Reply-To: <20191010155853.4325-1-stefanha@redhat.com>
References: <20191010155853.4325-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 10 Oct 2019 15:59:14 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of just passing the vring page frame number, pass the full
QVirtQueue.  This will allow the VIRTIO 1.0 transport to program the
fine-grained vring address registers in the future.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.h      | 2 +-
 tests/libqos/virtio-mmio.c | 6 ++++--
 tests/libqos/virtio-pci.c  | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 2cb2448f46..37f55b6ade 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -79,7 +79,7 @@ struct QVirtioBus {
     uint16_t (*get_queue_size)(QVirtioDevice *d);
=20
     /* Set the address of the selected queue */
-    void (*set_queue_address)(QVirtioDevice *d, uint32_t pfn);
+    void (*set_queue_address)(QVirtioDevice *d, QVirtQueue *vq);
=20
     /* Setup the virtqueue specified by index */
     QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator *al=
loc,
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index d0047876a8..43ca4e49c1 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -127,9 +127,11 @@ static uint16_t qvirtio_mmio_get_queue_size(QVirtioD=
evice *d)
     return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEU=
E_NUM_MAX);
 }
=20
-static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pf=
n)
+static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, QVirtQueue =
*vq)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
+    uint64_t pfn =3D vq->desc / dev->page_size;
+
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }
=20
@@ -162,7 +164,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirt=
ioDevice *d,
=20
     addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size));
     qvring_init(dev->qts, alloc, vq, addr);
-    qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
+    qvirtio_mmio_set_queue_address(d, vq);
=20
     return vq;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index c8d736f4d1..4772239b61 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -190,9 +190,11 @@ static uint16_t qvirtio_pci_get_queue_size(QVirtioDe=
vice *d)
     return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
 }
=20
-static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn=
)
+static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue *=
vq)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    uint64_t pfn =3D vq->desc / VIRTIO_PCI_VRING_ALIGN;
+
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
=20
@@ -229,7 +231,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_A=
LIGN);
+    qvirtio_pci_set_queue_address(d, &vqpci->vq);
=20
     return &vqpci->vq;
 }
--=20
2.21.0


