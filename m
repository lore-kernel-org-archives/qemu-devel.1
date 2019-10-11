Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5752084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5752084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqpo-0002ZX-RX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIqj1-0002zG-9c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIqj0-0007rc-0a
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIqiz-0007rM-N0
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:56:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1EE31017C12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:36 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 809925D9C3;
 Fri, 11 Oct 2019 08:56:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] libqos: add MSI-X callbacks to QVirtioPCIDevice
Date: Fri, 11 Oct 2019 09:56:08 +0100
Message-Id: <20191011085611.4194-5-stefanha@redhat.com>
In-Reply-To: <20191011085611.4194-1-stefanha@redhat.com>
References: <20191011085611.4194-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 11 Oct 2019 08:56:37 +0000 (UTC)
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

The MSI-X vectors are programmed differently in the VIRTIO 1.0 and
Legacy interfaces.  Introduce callbacks so different implementations can
be used depending on the interface version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio-pci.h | 12 ++++++++++++
 tests/libqos/virtio-pci.c | 37 ++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 0d105d67b3..443e53affc 100644
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
index 4772239b61..651f6dbfc6 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -271,6 +271,31 @@ static const QVirtioBus qvirtio_pci_legacy =3D {
     .virtqueue_kick =3D qvirtio_pci_virtqueue_kick,
 };
=20
+static void qvirtio_pci_set_config_vector(QVirtioPCIDevice *d, uint16_t =
entry)
+{
+    uint16_t vector;
+
+    qpci_io_writew(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR, entry);
+    vector =3D qpci_io_readw(d->pdev, d->bar, VIRTIO_MSI_CONFIG_VECTOR);
+    g_assert_cmphex(vector, !=3D, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void qvirtio_pci_set_queue_vector(QVirtioPCIDevice *d, uint16_t v=
q_idx,
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
@@ -285,7 +310,6 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci=
,
                                         QGuestAllocator *alloc, uint16_t=
 entry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
=20
@@ -311,16 +335,12 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d,=
 QVirtQueuePCI *vqpci,
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
                                         QGuestAllocator *alloc, uint16_t=
 entry)
 {
-    uint16_t vector;
     uint32_t control;
     uint64_t off;
=20
@@ -348,9 +368,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirti=
oPCIDevice *d,
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
@@ -371,6 +389,7 @@ static void qvirtio_pci_init_legacy(QVirtioPCIDevice =
*dev)
 {
     dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
     dev->vdev.bus =3D &qvirtio_pci_legacy;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
     dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
 }
=20
--=20
2.21.0


