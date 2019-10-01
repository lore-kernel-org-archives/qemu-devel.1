Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0536C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04492133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04492133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPLL-0003t7-2z
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8X-0005HX-Bm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8W-0008HW-3K
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8T-0008Fw-N9; Tue, 01 Oct 2019 15:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAEB6316D797;
 Tue,  1 Oct 2019 19:48:36 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86E9D601B3;
 Tue,  1 Oct 2019 19:48:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 34/67] iotests/155: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:42 +0200
Message-Id: <20191001194715.2796-35-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 01 Oct 2019 19:48:37 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/155 | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index e19485911c..4efe0e2237 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -23,7 +23,7 @@
=20
 import os
 import iotests
-from iotests import qemu_img
+from iotests import create_test_image, remove_test_image
=20
 back0_img =3D os.path.join(iotests.test_dir, 'back0.' + iotests.imgfmt)
 back1_img =3D os.path.join(iotests.test_dir, 'back1.' + iotests.imgfmt)
@@ -51,10 +51,10 @@ class BaseClass(iotests.QMPTestCase):
     target_real_backing =3D None
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, back0_img, '1440K')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back0_img, back1_=
img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back1_img, back2_=
img)
-        qemu_img('create', '-f', iotests.imgfmt, '-b', back2_img, source=
_img)
+        create_test_image(back0_img, '1440K')
+        create_test_image(back1_img, backing_file=3Dback0_img)
+        create_test_image(back2_img, backing_file=3Dback1_img)
+        create_test_image(source_img, backing_file=3Dback2_img)
=20
         self.vm =3D iotests.VM()
         # Add the BDS via blockdev-add so it stays around after the mirr=
or block
@@ -71,10 +71,10 @@ class BaseClass(iotests.QMPTestCase):
=20
         if self.existing:
             if self.target_backing:
-                qemu_img('create', '-f', iotests.imgfmt,
-                         '-b', self.target_backing, target_img, '1440K')
+                create_test_image(target_img, '1440K', \
+                                  backing_file=3Dself.target_backing)
             else:
-                qemu_img('create', '-f', iotests.imgfmt, target_img, '14=
40K')
+                create_test_image(target_img, '1440K')
=20
             if self.cmd =3D=3D 'blockdev-mirror':
                 options =3D { 'node-name': 'target',
@@ -89,14 +89,11 @@ class BaseClass(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(source_img)
-        os.remove(back2_img)
-        os.remove(back1_img)
-        os.remove(back0_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        remove_test_image(source_img)
+        remove_test_image(back2_img)
+        remove_test_image(back1_img)
+        remove_test_image(back0_img)
+        remove_test_image(target_img)
=20
     def findBlockNode(self, node_name, qdev=3DNone):
         if qdev:
--=20
2.21.0


