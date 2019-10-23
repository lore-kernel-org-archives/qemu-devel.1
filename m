Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA29CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8BB205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAm98BDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8BB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDi2-0003Fg-7B
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDYi-0005em-F0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDYg-0003d3-DX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:08:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDYg-0003bV-8y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGXsySC3CD9/9kCq/1CSF79CJqClIPOWzVhKaZ/m5T0=;
 b=DAm98BDNkrtAcNBBsZXNBqqC8t5syFV64JqbSdS7JrD6GsSwyeSyo+YEcwtUgiC8Ob3S0F
 yqxEBaBWmWAZM+4rEzX2XElqS0geWdqPuTHPy7Sxu0KGv3H+CGDtsv4iBfQQGXLNrpJGry
 PpkgGiRkocrVbOT/oq0zN0pWr38LG9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-CyDo1OtQNbCOsOMelTkPWQ-1; Wed, 23 Oct 2019 06:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B0F8107AD31;
 Wed, 23 Oct 2019 10:07:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB5660BE1;
 Wed, 23 Oct 2019 10:07:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 15/16] libqos: extract Legacy virtio-pci.c code
Date: Wed, 23 Oct 2019 11:04:24 +0100
Message-Id: <20191023100425.12168-16-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CyDo1OtQNbCOsOMelTkPWQ-1
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

The current libqos virtio-pci.c code implements the VIRTIO Legacy
interface.  Extract existing code in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
 void virtio_pci_init(QVirtioPCIDevice *dev, QPCIBus *bus, QPCIAddress * ad=
dr);
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
 #define CONFIG_BASE(dev) (VIRTIO_PCI_CONFIG_OFF((dev)->pdev->msix_enabled)=
)
=20
 static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d, uint64_t off)
@@ -55,8 +47,7 @@ static uint8_t qvirtio_pci_config_readb(QVirtioDevice *d,=
 uint64_t off)
  * but virtio ( < 1.0) is in guest order
  * so with a big-endian guest the order has been reversed,
  * reverse it again
- * virtio-1.0 is always little-endian, like PCI, but this
- * case will be managed inside qvirtio_pci_is_big_endian()
+ * virtio-1.0 is always little-endian, like PCI
  */
=20
 static uint16_t qvirtio_pci_config_readw(QVirtioDevice *d, uint64_t off)
@@ -262,7 +253,7 @@ static void qvirtio_pci_virtqueue_kick(QVirtioDevice *d=
, QVirtQueue *vq)
     qpci_io_writew(dev->pdev, dev->bar, VIRTIO_PCI_QUEUE_NOTIFY, vq->index=
);
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
+    dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM_I=
D);
+    dev->bar_idx =3D 0;
+    dev->vdev.bus =3D &qvirtio_pci_legacy;
+    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
+    dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
+}
+
 static void qvirtio_pci_init_from_pcidev(QVirtioPCIDevice *dev, QPCIDevice=
 *pci_dev)
 {
     dev->pdev =3D pci_dev;
-    dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_ID)=
;
-    dev->bar_idx =3D 0;
-
     dev->config_msix_entry =3D -1;
-    dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
=20
-    dev->vdev.bus =3D &qvirtio_pci;
-    dev->vdev.big_endian =3D qvirtio_pci_is_big_endian(dev);
+    qvirtio_pci_init_legacy(dev);
=20
     /* each virtio-xxx-pci device should override at least this function *=
/
     dev->obj.get_driver =3D NULL;
--=20
2.21.0


