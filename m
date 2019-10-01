Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D2C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411322133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411322133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOg5-0001D2-Io
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO87-0004uU-Oo
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO85-00082S-Kp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7z-0007zf-Ts; Tue, 01 Oct 2019 15:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14D643084025;
 Tue,  1 Oct 2019 19:48:07 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3139261B7;
 Tue,  1 Oct 2019 19:48:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 21/67] iotests/056: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:29 +0200
Message-Id: <20191001194715.2796-22-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 19:48:07 +0000 (UTC)
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
 tests/qemu-iotests/056 | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 98c55d8e5a..58b4103cd9 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -23,7 +23,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io, create_image
+from iotests import create_test_image, remove_test_image, qemu_io, creat=
e_image
=20
 backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
@@ -31,18 +31,12 @@ target_img =3D os.path.join(iotests.test_dir, 'target=
.img')
=20
 def img_create(img, fmt=3Diotests.imgfmt, size=3D'64M', **kwargs):
     fullname =3D os.path.join(iotests.test_dir, '%s.%s' % (img, fmt))
-    optargs =3D []
-    for k,v in kwargs.items():
-        optargs =3D optargs + ['-o', '%s=3D%s' % (k,v)]
-    args =3D ['create', '-f', fmt] + optargs + [fullname, size]
-    iotests.qemu_img(*args)
+    opts =3D []
+    for k, v in kwargs.items():
+        opts.append('%s=3D%s' % (k, v))
+    create_test_image(fullname, size, fmt=3Dfmt, opts=3Dopts)
     return fullname
=20
-def try_remove(img):
-    try:
-        os.remove(img)
-    except OSError:
-        pass
=20
 def io_write_patterns(img, patterns):
     for pattern in patterns:
@@ -54,7 +48,7 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
=20
     def setUp(self):
         create_image(backing_img, TestSyncModesNoneAndTop.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         qemu_io('-c', 'write -P0x41 0 512', test_img)
         qemu_io('-c', 'write -P0xd5 1M 32k', test_img)
         qemu_io('-c', 'write -P0xdc 32M 124k', test_img)
@@ -64,7 +58,7 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
         try:
             os.remove(target_img)
@@ -103,6 +97,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
         self.assertEqual(-1, qemu_io('-c', 'read -P0x41 0 512', target_i=
mg).find("verification failed"))
=20
 class TestBeforeWriteNotifier(iotests.QMPTestCase):
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def setUp(self):
         self.vm =3D iotests.VM().add_drive_raw("file=3Dblkdebug::null-co=
://,id=3Ddrive0,align=3D65536,driver=3Dblkdebug")
         self.vm.launch()
@@ -139,9 +135,9 @@ class BackupTest(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        try_remove(self.test_img)
-        try_remove(self.dest_img)
-        try_remove(self.ref_img)
+        remove_test_image(self.test_img)
+        remove_test_image(self.dest_img)
+        remove_test_image(self.ref_img)
=20
     def hmp_io_writes(self, drive, patterns):
         for pattern in patterns:
@@ -268,6 +264,8 @@ class BackupTest(iotests.QMPTestCase):
                                  sync=3D'full', target=3Dself.dest_img,
                                  auto_dismiss=3DFalse)
=20
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def dismissal_failure(self, dismissal_opt):
         res =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
--=20
2.21.0


