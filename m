Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED60720663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7arMzuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNE0w-0007tv-F0
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDXo-0005Lm-U3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDXn-00037g-Nn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDXn-00036I-Hj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1+p4tcQY08BVFyjCo72mvhJJ+wYreWjS/AeXVIm/U0=;
 b=B7arMzukbeiSkrUPUKweRSnmRg+HT7lJzbvirHE0GeCX63dK+3RwUp5M9QsyB87fYSghil
 ngTcS2kBj+rqXh+Dtbmu1GyddiYTXkC1oE5OImlmvWw7qTveUrHGb8v+lD0HfJstg99RI0
 S/WhY01sRDW2D4x22XgGgtdnZmOj1qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-aql1H7JMNE-mMvMUVgS2Gw-1; Wed, 23 Oct 2019 06:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE9BB80183D;
 Wed, 23 Oct 2019 10:07:01 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8D6860629;
 Wed, 23 Oct 2019 10:06:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/16] libqos: pass full QVirtQueue to set_queue_address()
Date: Wed, 23 Oct 2019 11:04:20 +0100
Message-Id: <20191023100425.12168-12-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: aql1H7JMNE-mMvMUVgS2Gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Instead of just passing the vring page frame number, pass the full
QVirtQueue.  This will allow the VIRTIO 1.0 transport to program the
fine-grained vring address registers in the future.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/libqos/virtio.h      | 2 +-
 tests/libqos/virtio-mmio.c | 6 ++++--
 tests/libqos/virtio-pci.c  | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index ebbff5193b..529ef7555a 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -81,7 +81,7 @@ struct QVirtioBus {
     uint16_t (*get_queue_size)(QVirtioDevice *d);
=20
     /* Set the address of the selected queue */
-    void (*set_queue_address)(QVirtioDevice *d, uint32_t pfn);
+    void (*set_queue_address)(QVirtioDevice *d, QVirtQueue *vq);
=20
     /* Setup the virtqueue specified by index */
     QVirtQueue *(*virtqueue_setup)(QVirtioDevice *d, QGuestAllocator *allo=
c,
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 4db1f1b8bc..e0a2bd7bc6 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -143,9 +143,11 @@ static uint16_t qvirtio_mmio_get_queue_size(QVirtioDev=
ice *d)
     return (uint16_t)qtest_readl(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_=
NUM_MAX);
 }
=20
-static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, uint32_t pfn)
+static void qvirtio_mmio_set_queue_address(QVirtioDevice *d, QVirtQueue *v=
q)
 {
     QVirtioMMIODevice *dev =3D container_of(d, QVirtioMMIODevice, vdev);
+    uint64_t pfn =3D vq->desc / dev->page_size;
+
     qtest_writel(dev->qts, dev->addr + QVIRTIO_MMIO_QUEUE_PFN, pfn);
 }
=20
@@ -179,7 +181,7 @@ static QVirtQueue *qvirtio_mmio_virtqueue_setup(QVirtio=
Device *d,
=20
     addr =3D guest_alloc(alloc, qvring_size(vq->size, dev->page_size));
     qvring_init(dev->qts, alloc, vq, addr);
-    qvirtio_mmio_set_queue_address(d, vq->desc / dev->page_size);
+    qvirtio_mmio_set_queue_address(d, vq);
=20
     return vq;
 }
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 7ecf5d0a52..e4fa318dcc 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -199,9 +199,11 @@ static uint16_t qvirtio_pci_get_queue_size(QVirtioDevi=
ce *d)
     return qpci_io_readw(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NUM);
 }
=20
-static void qvirtio_pci_set_queue_address(QVirtioDevice *d, uint32_t pfn)
+static void qvirtio_pci_set_queue_address(QVirtioDevice *d, QVirtQueue *vq=
)
 {
     QVirtioPCIDevice *dev =3D container_of(d, QVirtioPCIDevice, vdev);
+    uint64_t pfn =3D vq->desc / VIRTIO_PCI_VRING_ALIGN;
+
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
=20
@@ -239,7 +241,7 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioD=
evice *d,
     addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, vqpci->vq.desc / VIRTIO_PCI_VRING_ALI=
GN);
+    qvirtio_pci_set_queue_address(d, &vqpci->vq);
=20
     return &vqpci->vq;
 }
--=20
2.21.0


