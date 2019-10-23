Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81975CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7D52084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxhnoL0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D52084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDbw-000752-Td
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDWd-0004J3-NX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDWc-0002Fo-3W
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDWb-0001ar-Ur
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KplCgtoUX18u/KqaA+dv9ZMhPI8gImaSkBohz9iZAQc=;
 b=FxhnoL0fTceZd9dnkBoyZNm0hfLpoDKUfbnAO5VP3r5XHdfBDty6InrZ9ddCun0aNxA/6T
 r1b9Kx5vUtfYWQa+VoyNirGmTDgNChaAP9Vn78AFrpA6MLav0eK9OYKUoDbOw6QizrVyiM
 acMjzRunpMhkTPQ8lC4eDGlVJrig/AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-1YLClgQhPs6IwtrjbxQPUA-1; Wed, 23 Oct 2019 06:04:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE201005500;
 Wed, 23 Oct 2019 10:04:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF1531001B33;
 Wed, 23 Oct 2019 10:04:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/16] tests/virtio-blk-test: read config space after
 feature negotiation
Date: Wed, 23 Oct 2019 11:04:10 +0100
Message-Id: <20191023100425.12168-2-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1YLClgQhPs6IwtrjbxQPUA-1
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

The VIRTIO Configuration Space cannot be accessed before device feature
bits have been read because a driver doesn't know the endianness until
it has checked VIRTIO_F_VERSION_1.

Fix this problem in preparation for VIRTIO 1.0 support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/virtio-blk-test.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index ed13167392..f6674fb233 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -125,10 +125,6 @@ static void test_basic(QVirtioDevice *dev, QGuestAlloc=
ator *alloc,
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
@@ -136,6 +132,9 @@ static void test_basic(QVirtioDevice *dev, QGuestAlloca=
tor *alloc,
                     (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     qvirtio_set_driver_ok(dev);
=20
     /* Write and read with 3 descriptor layout */
@@ -359,9 +358,6 @@ static void indirect(void *obj, void *u_data, QGuestAll=
ocator *t_alloc)
     char *data;
     QTestState *qts =3D global_qtest;
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=3D, =
0);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
@@ -369,6 +365,9 @@ static void indirect(void *obj, void *u_data, QGuestAll=
ocator *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     vq =3D qvirtqueue_setup(dev, t_alloc, 0);
     qvirtio_set_driver_ok(dev);
=20
@@ -434,8 +433,16 @@ static void config(void *obj, void *data, QGuestAlloca=
tor *t_alloc)
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
@@ -475,9 +482,6 @@ static void msix(void *obj, void *u_data, QGuestAllocat=
or *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -485,6 +489,9 @@ static void msix(void *obj, void *u_data, QGuestAllocat=
or *t_alloc)
                             (1u << VIRTIO_BLK_F_SCSI));
     qvirtio_set_features(dev, features);
=20
+    capacity =3D qvirtio_config_readq(dev, 0);
+    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
+
     vq =3D qvirtqueue_setup(dev, t_alloc, 0);
     qvirtqueue_pci_msix_setup(pdev, (QVirtQueuePCI *)vq, t_alloc, 1);
=20
@@ -584,9 +591,6 @@ static void idx(void *obj, void *u_data, QGuestAllocato=
r *t_alloc)
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
=20
-    capacity =3D qvirtio_config_readq(dev, 0);
-    g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
-
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
                             (1u << VIRTIO_RING_F_INDIRECT_DESC) |
@@ -594,6 +598,9 @@ static void idx(void *obj, void *u_data, QGuestAllocato=
r *t_alloc)
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


