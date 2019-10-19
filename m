Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DCCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B74222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B74222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiSL-0008EE-P6
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiO7-0002jg-Mm
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiO6-0003WT-IF
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiO4-0003To-55; Sat, 19 Oct 2019 02:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 670D810CC200;
 Sat, 19 Oct 2019 06:38:51 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECD7260BF3;
 Sat, 19 Oct 2019 06:38:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/16] tests/virtio-blk-test: set up virtqueue after
 feature negotiation
Date: Sat, 19 Oct 2019 07:37:59 +0100
Message-Id: <20191019063810.6944-6-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Sat, 19 Oct 2019 06:38:51 +0000 (UTC)
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

VIRTIO Device Initialization requires that feature negotiation has
completed before virtqueues are set up.  This makes sense because the
driver must know whether it is operating in Legacy or VIRTIO 1.0 mode
before it can access vring fields with the correct endianness.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-blk-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 31680cc159..fe0dc4a896 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -113,8 +113,8 @@ static uint64_t virtio_blk_request(QGuestAllocator *a=
lloc, QVirtioDevice *d,
     return addr;
 }
=20
-static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
-                       QVirtQueue *vq)
+/* Returns the request virtqueue so the caller can perform further tests=
 */
+static QVirtQueue *test_basic(QVirtioDevice *dev, QGuestAllocator *alloc=
)
 {
     QVirtioBlkReq req;
     uint64_t req_addr;
@@ -124,6 +124,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllo=
cator *alloc,
     uint8_t status;
     char *data;
     QTestState *qts =3D global_qtest;
+    QVirtQueue *vq;
=20
     features =3D qvirtio_get_features(dev);
     features =3D features & ~(QVIRTIO_F_BAD_FEATURE |
@@ -135,6 +136,8 @@ static void test_basic(QVirtioDevice *dev, QGuestAllo=
cator *alloc,
     capacity =3D qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, =3D=3D, TEST_IMAGE_SIZE / 512);
=20
+    vq =3D qvirtqueue_setup(dev, alloc, 0);
+
     qvirtio_set_driver_ok(dev);
=20
     /* Write and read with 3 descriptor layout */
@@ -331,14 +334,16 @@ static void test_basic(QVirtioDevice *dev, QGuestAl=
locator *alloc,
=20
         guest_free(alloc, req_addr);
     }
+
+    return vq;
 }
=20
 static void basic(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtioBlk *blk_if =3D obj;
     QVirtQueue *vq;
-    vq =3D qvirtqueue_setup(blk_if->vdev, t_alloc, 0);
-    test_basic(blk_if->vdev, t_alloc, vq);
+
+    vq =3D test_basic(blk_if->vdev, t_alloc);
     qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
=20
 }
@@ -746,9 +751,7 @@ static void resize(void *obj, void *data, QGuestAlloc=
ator *t_alloc)
     QVirtQueue *vq;
     QTestState *qts =3D global_qtest;
=20
-    vq =3D qvirtqueue_setup(dev, t_alloc, 0);
-
-    test_basic(dev, t_alloc, vq);
+    vq =3D test_basic(dev, t_alloc);
=20
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
--=20
2.21.0


