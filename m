Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4ACA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC05D20854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC05D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiby-0001br-49
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiPS-0004ap-7S
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiPQ-0004cD-Vu
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiPN-0004ZC-95; Sat, 19 Oct 2019 02:40:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CD6618C427B;
 Sat, 19 Oct 2019 06:40:12 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1101A5D9CC;
 Sat, 19 Oct 2019 06:40:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/16] libqos: extract Legacy virtio-pci.c code
Date: Sat, 19 Oct 2019 07:38:09 +0100
Message-Id: <20191019063810.6944-16-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Sat, 19 Oct 2019 06:40:12 +0000 (UTC)
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

The current libqos virtio-pci.c code implements the VIRTIO Legacy
interface.  Extract existing code in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio-pci.h |  2 --
 tests/libqos/virtio-pci.c | 29 ++++++++++++-----------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 78a1c15c2a..6b3a385b06 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -45,8 +45,6 @@ typedef struct QVirtQueuePCI {
     uint32_t msix_data;
 } QVirtQueuePCI;
=20
-extern const QVirtioBus qvirtio_pci;
-
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * =
addr);
 QVirtioPCIDevice *virtio_pci_new(QPCIBus *bus, QPCIAddress * addr);
=20
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index e9595603f5..11866f7772 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -35,14 +35,6 @@
  * original qvirtio_pci_destructor and qvirtio_pci_start_hw.
  */
=20
-static inline bool qvirtio_pci_is_big_endian(QVirtioPCIDevice *dev)
-{
-    QPCIBus *bus =3D dev->pdev->bus;
-
-    /* FIXME: virtio 1.0 is always little-endian */
-    return qtest_big_endian(bus->qts);
-}
-
 #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enable=
d))
=20
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
@@ -55,8 +47,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *=
d, uint64_t off)
  * but virtio ( < 1.0) is in guest order
  * so with a big-endian guest the order has been reversed,
  * reverse it again
- * virtio-1.0 is always little-endian, like PCI, but this
- * case will be managed inside qvirtio_pci_is_big_endian()
+ * virtio-1.0 is always little-endian, like PCI
  */
=20
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
@@ -262,7 +253,7 @@ static void qvirtio_pci_virtqueue_kick(QVirtioDevice =
*d, QVirtQueue *vq)
     qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->ind=
ex);
 }
=20
-const QVirtioBus qvirtio_pci =3D {
+static const QVirtioBus qvirtio_pci_legacy =3D {
     .config_readb =3D qvirtio_pci_config_readb,
     .config_readw =3D qvirtio_pci_config_readw,
     .config_readl =3D qvirtio_pci_config_readl,
@@ -396,17 +387,21 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
     qvirtio_start_device(&dev->vdev);
 }
=20
+static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
+{
+    dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
+    dev->bar_idx =3D 0;
+    dev->vdev.bus =3D &qvirtio_pci_legacy;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
+    dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
+}
+
 static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevi=
ce *pci_dev)
 {
     dev->pdev =3D pci_dev;
-    dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_I=
D);
-    dev->bar_idx =3D 0;
-
     dev->config_msix_entry =3D -1;
-    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
=20
-    dev->vdev.bus =3D &qvirtio_pci;
-    dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
+    qvirtio_pci_init_legacy(dev);
=20
     /* each virtio-xxx-pci device should override at least this function=
 */
     dev->obj.get_driver =3D NULL;
--=20
2.21.0


