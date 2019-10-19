Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73963CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B89C222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B89C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiRW-000709-7u
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiNm-0002CZ-8C
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiNl-00039j-2N
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiNi-00037V-0X; Sat, 19 Oct 2019 02:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46BE83082A8B;
 Sat, 19 Oct 2019 06:38:29 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBEDC600C8;
 Sat, 19 Oct 2019 06:38:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/16] tests/virtio-blk-test: read config space after
 feature negotiation
Date: Sat, 19 Oct 2019 07:37:55 +0100
Message-Id: <20191019063810.6944-2-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Sat, 19 Oct 2019 06:38:29 +0000 (UTC)
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

The VIRTIO Configuration Space cannot be accessed before device feature
bits have been read because a driver doesn't know the endianness until
it has checked VIRTIO_F_VERSION_1.

Fix this problem in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-blk-test.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index ed13167392..f6674fb233 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -125,10 +125,6 @@ static void test_basic(QVirtioDevice *dev, QGuestAll=
ocator *alloc,
     char *data;
     QTestState *qts =3D global_qtest;
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
                     (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -136,6 +132,9 @@ static void test_basic(QVirtioDevice *dev, QGuestAllo=
cator *alloc,
                     (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     qvirtio_set_driver_ok(dev);
=20
     /* Write and read with 3 descriptor layout */
@@ -359,9 +358,6 @@ static void indirect(void *obj, void *u_data, QGuestA=
llocator *t_alloc)
     char *data;
     QTestState *qts =3D global_qtest;
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=3D=
, 0);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
@@ -369,6 +365,9 @@ static void indirect(void *obj, void *u_data, QGuestA=
llocator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     vq =3D qvirtqueue_setup(dev, t_alloc, 0);
     qvirtio_set_driver_ok(dev);
=20
@@ -434,8 +433,16 @@ static void config(void *obj, void *data, QGuestAllo=
cator *t_alloc)
     QVirtioBlk *blk_if =3D obj;
     QVirtioDevice *dev =3D blk_if->vdev;
     int n_size =3D TEST_IMAGE_SIZE / 2;
+    uint64_t features;
     uint64_t capacity;
=20
+    features =3D qvirtio_get_features(dev);
+    features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
+                            (1u << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1u << VIRTIO_RING_F_EVENT_IDX) |
+                            (1u << VIRTIO_BLK_F_SCSI));
+    qvirtio_set_features(dev, features);
+
     capacity =3D qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
=20
@@ -475,9 +482,6 @@ static void msix(void *obj, void *u_data, QGuestAlloc=
ator *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -485,6 +489,9 @@ static void msix(void *obj, void *u_data, QGuestAlloc=
ator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     vq =3D qvirtqueue_setup(dev, t_alloc, 0);
     qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
=20
@@ -584,9 +591,6 @@ static void idx(void *obj, void *u_data, QGuestAlloca=
tor *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -594,6 +598,9 @@ static void idx(void *obj, void *u_data, QGuestAlloca=
tor *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     vq =3D qvirtqueue_setup(dev, t_alloc, 0);
     qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
=20
--=20
2.21.0


