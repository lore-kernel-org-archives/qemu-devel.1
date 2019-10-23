Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F65CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611F120679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzldFOKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611F120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDvA-00040b-HX
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDY2-0005Qr-EH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDY0-0003FK-3c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDXz-0003Di-Vm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqLry4Ki6u2h7xn3uagKAxOS0sqBOly9DaQ+AXZ+604=;
 b=gzldFOKxmiahIT1+Zl9EBal7nWmnFTK0XLlTK4WifVsta2h1xyPZIa4WF+Q8RBpHkC6YKQ
 DlDvtJYtM/dvyroTN4cRP1ZJ/kxsaV2lMXAxDULncqYIZSf8qAJKzpbIc56PKAGuoLC8ZI
 MrjyrBq0tlnjTjWhRH+0AGMFF/260fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-lk7PHi-YMcepJdRpEHNjpw-1; Wed, 23 Oct 2019 06:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ACE5107AD31;
 Wed, 23 Oct 2019 10:07:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1FA1001B08;
 Wed, 23 Oct 2019 10:07:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/16] libqos: add MSI-X callbacks to QVirtioPCIDevice
Date: Wed, 23 Oct 2019 11:04:21 +0100
Message-Id: <20191023100425.12168-13-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lk7PHi-YMcepJdRpEHNjpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The MSI-X vectors are programmed differently in the VIRTIO 1.0 and
Legacy interfaces.  Introduce callbacks so different implementations can
be used depending on the interface version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-pci.h | 12 ++++++++++++
 tests/libqos/virtio-pci.c | 37 ++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 728b4715f1..4299efc023 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -14,16 +14,28 @@
 #include "libqos/pci.h"
 #include "libqos/qgraph.h"
=20
+typedef struct QVirtioPCIMSIXOps QVirtioPCIMSIXOps;
+
 typedef struct QVirtioPCIDevice {
     QOSGraphObject obj;
     QVirtioDevice vdev;
     QPCIDevice *pdev;
     QPCIBar bar;
+    const QVirtioPCIMSIXOps *msix_ops;
     uint16_t config_msix_entry;
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 } QVirtioPCIDevice;
=20
+struct QVirtioPCIMSIXOps {
+    /* Set the Configuration Vector for MSI-X */
+    void (*set_config_vector)(QVirtioPCIDevice *d, uint16_t entry);
+
+    /* Set the Queue Vector for MSI-X */
+    void (*set_queue_vector)(QVirtioPCIDevice *d, uint16_t vq_idx,
+                             uint16_t entry);
+};
+
 typedef struct QVirtQueuePCI {
     QVirtQueue vq;
     uint16_t msix_entry;
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index e4fa318dcc..0725777a8d 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -281,6 +281,31 @@ const QVirtioBus qvirtio_pci =3D {
     .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
 };
=20
+static void qvirtio_pci_set_config_vector(QVirtioPCIDevice *d, uint16_t en=
try)
+{
+    uint16_t vector;
+
+    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
+    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
+    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void qvirtio_pci_set_queue_vector(QVirtioPCIDevice *d, uint16_t vq_=
idx,
+                                         uint16_t entry)
+{
+    uint16_t vector;
+
+    qvirtio_pci_queue_select(&d->vdev, vq_idx);
+    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
+    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
+    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+}
+
+static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_legacy =3D {
+    .set_config_vector =3D qvirtio_pci_set_config_vector,
+    .set_queue_vector =3D qvirtio_pci_set_queue_vector,
+};
+
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
@@ -295,7 +320,6 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t e=
ntry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
=20
@@ -321,16 +345,12 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, Q=
VirtQueuePCI *vqpci,
                    off + PCI_MSIX_ENTRY_VECTOR_CTRL,
                    control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
=20
-    qvirtio_pci_queue_select(&d->vdev, vqpci->vq.index);
-    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR, entry);
-    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_QUEUE_VECTOR);
-    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+    d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
 }
=20
 void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t e=
ntry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
=20
@@ -358,9 +378,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioP=
CIDevice *d,
                    off + PCI_MSIX_ENTRY_VECTOR_CTRL,
                    control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
=20
-    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
-    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
-    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+    d->msix_ops->set_config_vector(d, entry);
 }
=20
 void qvirtio_pci_destructor(QOSGraphObject *obj)
@@ -383,6 +401,7 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevi=
ce *dev, QPCIDevice *pci_
     dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID)=
;
=20
     dev->config_msix_entry =3D -1;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
=20
     dev->vdev.bus =3D &qvirtio_pci;
     dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
--=20
2.21.0


