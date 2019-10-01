Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F752C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120C920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120C920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOs5-0002WS-JH
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO83-0004qa-PM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO81-00080o-Hz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7x-0007yO-GQ; Tue, 01 Oct 2019 15:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2508A44AE1;
 Tue,  1 Oct 2019 19:48:04 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D72A60619;
 Tue,  1 Oct 2019 19:48:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 20/67] iotests/055: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:28 +0200
Message-Id: <20191001194715.2796-21-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 01 Oct 2019 19:48:04 +0000 (UTC)
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
 tests/qemu-iotests/055 | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index c732a112d6..e44f18570d 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -23,7 +23,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_io
=20
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
 target_img =3D os.path.join(iotests.test_dir, 'target.img')
@@ -32,7 +32,7 @@ blockdev_target_img =3D os.path.join(iotests.test_dir, =
'blockdev-target.img')
 image_len =3D 64 * 1024 * 1024 # MB
=20
 def setUpModule():
-    qemu_img('create', '-f', iotests.imgfmt, test_img, str(image_len))
+    create_test_image(test_img, image_len)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x11 0 64k', test_img)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x00 64k 128k', test_im=
g)
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x22 162k 32k', test_im=
g)
@@ -41,12 +41,12 @@ def setUpModule():
     qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x33 67043328 64k', tes=
t_img)
=20
 def tearDownModule():
-    os.remove(test_img)
+    remove_test_image(test_img)
=20
=20
 class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, st=
r(image_len))
+        create_test_image(blockdev_target_img, image_len)
=20
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.add_drive(blockdev_target_img, interface=3D"none")
@@ -56,7 +56,7 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
+        remove_test_image(blockdev_target_img)
         try:
             os.remove(target_img)
         except OSError:
@@ -163,7 +163,7 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
 class TestSetSpeed(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, st=
r(image_len))
+        create_test_image(blockdev_target_img, image_len)
=20
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.add_drive(blockdev_target_img, interface=3D"none")
@@ -171,7 +171,7 @@ class TestSetSpeed(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
+        remove_test_image(blockdev_target_img)
         try:
             os.remove(target_img)
         except OSError:
@@ -249,7 +249,7 @@ class TestSetSpeed(iotests.QMPTestCase):
 #       would stall.  Instead, we limit the block job speed here.
 class TestSingleTransaction(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, st=
r(image_len))
+        create_test_image(blockdev_target_img, image_len)
=20
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.add_drive(blockdev_target_img, interface=3D"none")
@@ -259,7 +259,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
+        remove_test_image(blockdev_target_img)
         try:
             os.remove(target_img)
         except OSError:
@@ -452,29 +452,34 @@ class TestSingleTransaction(iotests.QMPTestCase):
=20
 class TestDriveCompression(iotests.QMPTestCase):
     image_len =3D 64 * 1024 * 1024 # MB
-    fmt_supports_compression =3D [{'type': 'qcow2', 'args': ()},
-                                {'type': 'vmdk', 'args': ('-o', 'subform=
at=3DstreamOptimized')}]
+    fmt_supports_compression =3D [{'type': 'qcow2', 'opts': []},
+                                {'type': 'vmdk', 'opts': ['subformat=3Ds=
treamOptimized']}]
+
+    # Compression does not work with external data files
+    @iotests.skip_for_imgopts(['data_file'])
+    def setUp(self):
+        pass
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(blockdev_target_img)
+        remove_test_image(blockdev_target_img)
         try:
             os.remove(target_img)
         except OSError:
             pass
=20
-    def do_prepare_drives(self, fmt, args, attach_target):
+    def do_prepare_drives(self, fmt, opts, attach_target):
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
=20
-        qemu_img('create', '-f', fmt, blockdev_target_img,
-                 str(TestDriveCompression.image_len), *args)
+        create_test_image(blockdev_target_img, TestDriveCompression.imag=
e_len,
+                          fmt=3Dfmt, opts=3Dopts)
         if attach_target:
             self.vm.add_drive(blockdev_target_img, format=3Dfmt, interfa=
ce=3D"none")
=20
         self.vm.launch()
=20
     def do_test_compress_complete(self, cmd, format, attach_target, **ar=
gs):
-        self.do_prepare_drives(format['type'], format['args'], attach_ta=
rget)
+        self.do_prepare_drives(format['type'], format['opts'], attach_ta=
rget)
=20
         self.assert_no_active_block_jobs()
=20
@@ -499,7 +504,7 @@ class TestDriveCompression(iotests.QMPTestCase):
                                            target=3D'drive1')
=20
     def do_test_compress_cancel(self, cmd, format, attach_target, **args=
):
-        self.do_prepare_drives(format['type'], format['args'], attach_ta=
rget)
+        self.do_prepare_drives(format['type'], format['opts'], attach_ta=
rget)
=20
         self.assert_no_active_block_jobs()
=20
@@ -523,7 +528,7 @@ class TestDriveCompression(iotests.QMPTestCase):
                                          target=3D'drive1')
=20
     def do_test_compress_pause(self, cmd, format, attach_target, **args)=
:
-        self.do_prepare_drives(format['type'], format['args'], attach_ta=
rget)
+        self.do_prepare_drives(format['type'], format['opts'], attach_ta=
rget)
=20
         self.assert_no_active_block_jobs()
=20
--=20
2.21.0


