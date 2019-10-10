Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C997C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739612067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739612067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbEx-0004EX-K4
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIaqi-0005sn-KV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIaqh-0003L4-Is
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIaqh-0003Ko-DS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A66CDA76C
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:59:30 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE855DD64;
 Thu, 10 Oct 2019 15:59:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] libqos: make the virtio-pci BAR index configurable
Date: Thu, 10 Oct 2019 16:58:52 +0100
Message-Id: <20191010155853.4325-7-stefanha@redhat.com>
In-Reply-To: <20191010155853.4325-1-stefanha@redhat.com>
References: <20191010155853.4325-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 10 Oct 2019 15:59:30 +0000 (UTC)
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

The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
to use a different BAR index, so make it configurable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio-pci.h | 2 ++
 tests/libqos/virtio-pci.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index b620c30451..f2d53aa377 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
     uint16_t config_msix_entry;
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
+
+    uint8_t bar_idx;
 } QVirtioPCIDevice;
=20
 struct QVirtioPCIMSIXOps {
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index 9625a262bd..08451cb7f7 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -299,7 +299,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_l=
egacy =3D {
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
-    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
+    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
 }
=20
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
@@ -388,6 +388,7 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
 static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
 {
     dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_SUBSYSTEM=
_ID);
+    dev->bar_idx =3D 0;
     dev->vdev.bus =3D &qvirtio_pci_legacy;
     dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
     dev->vdev.big_endian =3D qtest_big_endian(dev->pdev->bus->qts);
--=20
2.21.0


