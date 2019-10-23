Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C66CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583182064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh76H5aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583182064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNE6Z-0004j8-T8
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDYG-0005V1-Fk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDYC-0003MD-8O
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDYC-0003La-3e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIN/DOYgg9BTqPmKA47VXqPwcbwf4Up/hhPqrBSgpn8=;
 b=Eh76H5ajggaGVFWGbC41oNbonwhra9r6zWte19ahZJv8/TPYGHp0ITyRQwTAPnWQwlqOPE
 8E8OzPOogfjPzhXoHrO+7kSAmGxArEE1BlhPMxaO6NGBMLVaFYUfXiX5zHCZIXGYPeve9f
 hH/AylJ3YC+GUny6YKMlCTN9Tag2QO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-uRI-Jxy9ODaBzPx1cVxgvQ-1; Wed, 23 Oct 2019 06:07:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A8781800D6B;
 Wed, 23 Oct 2019 10:07:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD43860F8C;
 Wed, 23 Oct 2019 10:07:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/16] libqos: expose common virtqueue setup/cleanup
 functions
Date: Wed, 23 Oct 2019 11:04:22 +0100
Message-Id: <20191023100425.12168-14-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uRI-Jxy9ODaBzPx1cVxgvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VIRTIO 1.0 code will need to perform additional steps but it will
reuse the common virtqueue setup/cleanup code.  Make these functions
public.

Make sure to invoke callbacks via QVirtioBus instead of directly calling
the virtio-pci Legacy versions of these functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-pci.h |  8 ++++++++
 tests/libqos/virtio-pci.c | 19 ++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 4299efc023..0e4a8b7b00 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -65,4 +65,12 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPC=
IDevice *d,
                                         QGuestAllocator *alloc, uint16_t e=
ntry);
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t e=
ntry);
+
+/* Used by Legacy and Modern virtio-pci code */
+QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t index);
+void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
+                                          QGuestAllocator *alloc);
+
 #endif
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 0725777a8d..c900742f96 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -207,8 +207,9 @@ static void qvirtio_pci_set_queue_address(QVirtioDevice=
 *d, QVirtQueue *vq)
     qpci_io_writel(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_PFN, pfn);
 }
=20
-static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirtioDevice *d,
-                                        QGuestAllocator *alloc, uint16_t i=
ndex)
+QVirtQueue *qvirtio_pci_virtqueue_setup_common(QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t index)
 {
     uint64_t feat;
     uint64_t addr;
@@ -216,12 +217,12 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     QVirtioPCIDevice *qvpcidev =3D container_of(d, QVirtioPCIDevice, vdev)=
;
=20
     vqpci =3D g_malloc0(sizeof(*vqpci));
-    feat =3D qvirtio_pci_get_guest_features(d);
+    feat =3D d->bus->get_guest_features(d);
=20
-    qvirtio_pci_queue_select(d, index);
+    d->bus->queue_select(d, index);
     vqpci->vq.vdev =3D d;
     vqpci->vq.index =3D index;
-    vqpci->vq.size =3D qvirtio_pci_get_queue_size(d);
+    vqpci->vq.size =3D d->bus->get_queue_size(d);
     vqpci->vq.free_head =3D 0;
     vqpci->vq.num_free =3D vqpci->vq.size;
     vqpci->vq.align =3D VIRTIO_PCI_VRING_ALIGN;
@@ -241,12 +242,12 @@ static QVirtQueue *qvirtio_pci_virtqueue_setup(QVirti=
oDevice *d,
     addr =3D guest_alloc(alloc, qvring_size(vqpci->vq.size,
                                           VIRTIO_PCI_VRING_ALIGN));
     qvring_init(qvpcidev->pdev->bus->qts, alloc, &vqpci->vq, addr);
-    qvirtio_pci_set_queue_address(d, &vqpci->vq);
+    d->bus->set_queue_address(d, &vqpci->vq);
=20
     return &vqpci->vq;
 }
=20
-static void qvirtio_pci_virtqueue_cleanup(QVirtQueue *vq,
+void qvirtio_pci_virtqueue_cleanup_common(QVirtQueue *vq,
                                           QGuestAllocator *alloc)
 {
     QVirtQueuePCI *vqpci =3D container_of(vq, QVirtQueuePCI, vq);
@@ -276,8 +277,8 @@ const QVirtioBus qvirtio_pci =3D {
     .queue_select =3D qvirtio_pci_queue_select,
     .get_queue_size =3D qvirtio_pci_get_queue_size,
     .set_queue_address =3D qvirtio_pci_set_queue_address,
-    .virtqueue_setup =3D qvirtio_pci_virtqueue_setup,
-    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup,
+    .virtqueue_setup =3D qvirtio_pci_virtqueue_setup_common,
+    .virtqueue_cleanup =3D qvirtio_pci_virtqueue_cleanup_common,
     .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
 };
=20
--=20
2.21.0


