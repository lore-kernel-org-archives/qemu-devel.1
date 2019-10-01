Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C9C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368D2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOYx-0003eQ-Q7
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7r-0004fk-SN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7q-0007v4-8b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7m-0007qu-42; Tue, 01 Oct 2019 15:47:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 244E6302C084;
 Tue,  1 Oct 2019 19:47:53 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 858A65D9C9;
 Tue,  1 Oct 2019 19:47:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 15/67] iotests/030: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:23 +0200
Message-Id: <20191001194715.2796-16-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 01 Oct 2019 19:47:53 +0000 (UTC)
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
 tests/qemu-iotests/030 | 69 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 01aa96ed16..cddb017496 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_io
=20
 backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
 mid_img =3D os.path.join(iotests.test_dir, 'mid.img')
@@ -32,8 +32,8 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, TestSingleDrive.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % mid_img, test_img)
+        create_test_image(mid_img, backing_file=3Dbacking_img)
+        create_test_image(test_img, backing_file=3Dmid_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', m=
id_img)
         self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img,
@@ -43,8 +43,8 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
+        remove_test_image(test_img)
+        remove_test_image(mid_img)
         os.remove(backing_img)
=20
     def test_stream(self):
@@ -155,9 +155,8 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def test_read_only(self):
         # Create a new file that we can attach (we need a read-only top)
-        with iotests.FilePath('ro-top.img') as ro_top_path:
-            qemu_img('create', '-f', iotests.imgfmt, ro_top_path,
-                     str(self.image_len))
+        with iotests.ImagePath('ro-top.img') as ro_top_path:
+            create_test_image(ro_top_path, self.image_len)
=20
             result =3D self.vm.qmp('blockdev-add',
                                  node_name=3D'ro-top',
@@ -198,8 +197,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # Create all images
         iotests.create_image(self.imgs[0], self.image_len)
         for i in range(1, self.num_imgs):
-            qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=3D%s' % self.imgs[i-1], self.im=
gs[i])
+            create_test_image(self.imgs[i], backing_file=3Dself.imgs[i -=
 1])
=20
         # Put data into the images we are copying data from
         odd_img_indexes =3D [x for x in reversed(range(self.num_imgs)) i=
f x % 2 =3D=3D 1]
@@ -219,7 +217,7 @@ class TestParallelOps(iotests.QMPTestCase):
     def tearDown(self):
         self.vm.shutdown()
         for img in self.imgs:
-            os.remove(img)
+            remove_test_image(img)
=20
     # Test that it's possible to run several block-stream operations
     # in parallel in the same snapshot chain
@@ -539,11 +537,10 @@ class TestQuorum(iotests.QMPTestCase):
             backing_img =3D os.path.join(iotests.test_dir, 'backing-%d.i=
mg' % i)
             self.children.append(child_img)
             self.backing.append(backing_img)
-            qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+            create_test_image(backing_img, '1M')
             qemu_io('-f', iotests.imgfmt,
                     '-c', 'write -P 0x55 0 1024', backing_img)
-            qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'backing_file=3D%s' % backing_img, child_img)
+            create_test_image(child_img, backing_file=3Dbacking_img)
             opts.append("children.%d.file.filename=3D%s" % (i, child_img=
))
             opts.append("children.%d.node-name=3Dnode%d" % (i, i))
=20
@@ -555,9 +552,9 @@ class TestQuorum(iotests.QMPTestCase):
     def tearDown(self):
         self.vm.shutdown()
         for img in self.children:
-            os.remove(img)
+            remove_test_image(img)
         for img in self.backing:
-            os.remove(img)
+            remove_test_image(img)
=20
     def test_stream_quorum(self):
         if not iotests.supports_quorum():
@@ -587,7 +584,7 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, self.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img, str(self.image_len))
+        create_test_image(test_img, self.image_len, backing_file=3Dbacki=
ng_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
@@ -638,16 +635,15 @@ class TestEIO(TestErrors):
         self.blkdebug_file =3D backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 5)
-        qemu_img('create', '-f', iotests.imgfmt,
-                 '-o', 'backing_file=3Dblkdebug:%s:%s,backing_fmt=3Draw'
-                       % (self.blkdebug_file, backing_img),
-                 test_img)
+        create_test_image(test_img, backing_fmt=3D'raw',
+                          backing_file=3D('blkdebug:%s:%s' % (self.blkde=
bug_file,
+                                                            backing_img)=
))
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
=20
@@ -788,16 +784,15 @@ class TestENOSPC(TestErrors):
         self.blkdebug_file =3D backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "read_aio", 28)
-        qemu_img('create', '-f', iotests.imgfmt,
-                 '-o', 'backing_file=3Dblkdebug:%s:%s,backing_fmt=3Draw'
-                       % (self.blkdebug_file, backing_img),
-                 test_img)
+        create_test_image(test_img, backing_fmt=3D'raw',
+                          backing_file=3D('blkdebug:%s:%s' % (self.blkde=
bug_file,
+                                                            backing_img)=
))
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
=20
@@ -848,17 +843,17 @@ class TestStreamStop(iotests.QMPTestCase):
     image_len =3D 8 * 1024 * 1024 * 1024 # GB
=20
     def setUp(self):
-        qemu_img('create', backing_img, str(TestStreamStop.image_len))
-        qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(backing_img, TestStreamStop.image_len)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 32M', backin=
g_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test=
_img)
         self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
+        remove_test_image(test_img)
+        remove_test_image(backing_img)
=20
     def test_stream_stop(self):
         self.assert_no_active_block_jobs()
@@ -879,17 +874,17 @@ class TestSetSpeed(iotests.QMPTestCase):
     image_len =3D 80 * 1024 * 1024 # MB
=20
     def setUp(self):
-        qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 32M', backing_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(backing_img, TestSetSpeed.image_len)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 32M', backin=
g_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 32M 32M', test=
_img)
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
+        remove_test_image(test_img)
+        remove_test_image(backing_img)
=20
     # This is a short performance test which is not run by default.
     # Invoke "IMGFMT=3Dqed ./030 TestSetSpeed.perf_test_throughput"
--=20
2.21.0


