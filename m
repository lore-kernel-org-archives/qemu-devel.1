Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D8ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FD82133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FD82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOR6-0004il-RO
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7y-0004mz-4B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7w-0007xw-21
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7q-0007us-MN; Tue, 01 Oct 2019 15:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4D48A44AF8;
 Tue,  1 Oct 2019 19:47:57 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F0835D9C9;
 Tue,  1 Oct 2019 19:47:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 17/67] iotests/041: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:25 +0200
Message-Id: <20191001194715.2796-18-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 01 Oct 2019 19:47:57 +0000 (UTC)
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
 tests/qemu-iotests/041 | 108 +++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8568426311..5cf2e2cb52 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -21,7 +21,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_img, qemu=
_io
=20
 backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img =3D os.path.join(iotests.test_dir, 'target-backing.im=
g')
@@ -41,7 +41,7 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,ba=
cking.node-name=3Dbase")
         if iotests.qemu_default_machine =3D=3D 'pc':
             self.vm.add_drive(None, 'media=3Dcdrom', 'ide')
@@ -49,12 +49,9 @@ class TestSingleDrive(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
-        try:
-            os.remove(target_img)
-        except OSError:
-            pass
+        remove_test_image(target_img)
=20
     def test_complete(self):
         self.assert_no_active_block_jobs()
@@ -138,8 +135,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_small_buffer2(self):
         self.assert_no_active_block_jobs()
=20
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%=
d,size=3D%d'
-                        % (self.image_len, self.image_len), target_img)
+        create_test_image(target_img, self.image_len,
+                          opts=3D['cluster_size=3D%d' % self.image_len])
         result =3D self.vm.qmp(self.qmp_cmd, device=3D'drive0', sync=3D'=
full',
                              buf_size=3D65536, mode=3D'existing', target=
=3Dself.qmp_target)
         self.assert_qmp(result, 'return', {})
@@ -154,8 +151,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_large_cluster(self):
         self.assert_no_active_block_jobs()
=20
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%=
d,backing_file=3D%s'
-                        % (self.image_len, backing_img), target_img)
+        create_test_image(target_img, backing_file=3Dbacking_img,
+                          opts=3D['cluster_size=3D%d' % self.image_len])
         result =3D self.vm.qmp(self.qmp_cmd, device=3D'drive0', sync=3D'=
full',
                              mode=3D'existing', target=3Dself.qmp_target=
)
         self.assert_qmp(result, 'return', {})
@@ -227,7 +224,7 @@ class TestSingleBlockdev(TestSingleDrive):
=20
     def setUp(self):
         TestSingleDrive.setUp(self)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, target_img)
+        create_test_image(target_img, backing_file=3Dbacking_img)
         args =3D {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
                 'file': { 'filename': target_img, 'driver': 'file' } }
@@ -265,24 +262,21 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, TestMirrorNoBacking.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
-        try:
-            os.remove(target_backing_img)
-        except:
-            pass
-        os.remove(target_img)
+        remove_test_image(target_backing_img)
+        remove_test_image(target_img)
=20
     def test_complete(self):
         self.assert_no_active_block_jobs()
=20
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, target_img)
+        create_test_image(target_img, backing_file=3Dbacking_img)
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D=
'full',
                              mode=3D'existing', target=3Dtarget_img)
         self.assert_qmp(result, 'return', {})
@@ -297,7 +291,7 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
     def test_cancel(self):
         self.assert_no_active_block_jobs()
=20
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, target_img)
+        create_test_image(target_img, backing_file=3Dbacking_img)
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D=
'full',
                              mode=3D'existing', target=3Dtarget_img)
         self.assert_qmp(result, 'return', {})
@@ -313,10 +307,9 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
=20
         # qemu-img create fails if the image is not there
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'size=3D%d'
-                        %(TestMirrorNoBacking.image_len), target_backing=
_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D%=
d,backing_file=3D%s'
-                        % (TestMirrorNoBacking.image_len, target_backing=
_img), target_img)
+        create_test_image(target_backing_img, TestMirrorNoBacking.image_=
len)
+        create_test_image(target_img, backing_file=3Dtarget_backing_img,
+                          opts=3D['cluster_size=3D%d' % TestMirrorNoBack=
ing.image_len])
=20
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D=
'full',
                              mode=3D'existing', target=3Dtarget_img)
@@ -335,14 +328,14 @@ class TestMirrorResized(iotests.QMPTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, TestMirrorResized.backing_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         qemu_img('resize', test_img, '2M')
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(backing_img)
         try:
             os.remove(target_img)
@@ -407,14 +400,15 @@ new_state =3D "1"
 ''' % (event, errno, self.MIRROR_GRANULARITY // 512, event, event))
         file.close()
=20
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def setUp(self):
         self.blkdebug_file =3D backing_img + ".blkdebug"
         iotests.create_image(backing_img, TestReadErrors.image_len)
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
         # Write something for tests that use sync=3D'top'
         qemu_io('-c', 'write %d 512' % (self.MIRROR_GRANULARITY + 65536)=
,
                         test_img)
@@ -423,8 +417,8 @@ new_state =3D "1"
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
+        remove_test_image(test_img)
+        remove_test_image(target_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
=20
@@ -483,7 +477,8 @@ new_state =3D "1"
         # Test COW into the target image.  The first half of the
         # cluster at MIRROR_GRANULARITY has to be copied from
         # backing_img, even though sync=3D'top'.
-        qemu_img('create', '-f', iotests.imgfmt, '-ocluster_size=3D13107=
2,backing_file=3D%s' %(backing_img), target_img)
+        create_test_image(target_img, backing_file=3Dbacking_img,
+                          opts=3D['cluster_size=3D131072'])
         result =3D self.vm.qmp('drive-mirror', device=3D'drive0', sync=3D=
'top',
                              on_source_error=3D'ignore',
                              mode=3D'existing', target=3Dtarget_img)
@@ -572,20 +567,22 @@ new_state =3D "1"
 ''' % (event, errno, self.MIRROR_GRANULARITY // 512, event, event))
         file.close()
=20
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def setUp(self):
         self.blkdebug_file =3D target_img + ".blkdebug"
         iotests.create_image(backing_img, TestWriteErrors.image_len)
         self.create_blkdebug_file(self.blkdebug_file, "write_aio", 5)
-        qemu_img('create', '-f', iotests.imgfmt, '-obacking_file=3D%s' %=
(backing_img), test_img)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.target_img =3D 'blkdebug:%s:%s' % (self.blkdebug_file, targ=
et_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-osize=3D%d' %(TestWri=
teErrors.image_len), target_img)
+        create_test_image(target_img, TestWriteErrors.image_len)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
+        remove_test_image(test_img)
+        remove_test_image(target_img)
         os.remove(backing_img)
         os.remove(self.blkdebug_file)
=20
@@ -673,15 +670,15 @@ class TestSetSpeed(iotests.QMPTestCase):
     image_len =3D 80 * 1024 * 1024 # MB
=20
     def setUp(self):
-        qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, test_img)
+        create_test_image(backing_img, TestSetSpeed.image_len)
+        create_test_image(test_img, backing_file=3Dbacking_img)
         self.vm =3D iotests.VM().add_drive(test_img)
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(backing_img)
+        remove_test_image(test_img)
+        remove_test_image(backing_img)
         os.remove(target_img)
=20
     def test_set_speed(self):
@@ -739,8 +736,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
     image_len =3D 2 * 1024 * 1024 # MB
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img,
-                 str(TestUnbackedSource.image_len))
+        create_test_image(test_img, TestUnbackedSource.image_len)
         self.vm =3D iotests.VM()
         self.vm.launch()
         result =3D self.vm.qmp('blockdev-add', node_name=3D'drive0',
@@ -753,8 +749,8 @@ class TestUnbackedSource(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(target_img)
+        remove_test_image(test_img)
+        remove_test_image(target_img)
=20
     def test_absolute_paths_full(self):
         self.assert_no_active_block_jobs()
@@ -784,8 +780,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
=20
     def test_existing_full(self):
-        qemu_img('create', '-f', iotests.imgfmt, target_img,
-                 str(self.image_len))
+        create_test_image(target_img, self.image_len)
         qemu_io('-c', 'write -P 42 0 64k', target_img)
=20
         self.assert_no_active_block_jobs()
@@ -802,8 +797,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
                         'target image does not match source after mirror=
ing')
=20
     def test_blockdev_full(self):
-        qemu_img('create', '-f', iotests.imgfmt, target_img,
-                 str(self.image_len))
+        create_test_image(target_img, self.image_len)
         qemu_io('-c', 'write -P 42 0 64k', target_img)
=20
         result =3D self.vm.qmp('blockdev-add', node_name=3D'target',
@@ -834,8 +828,7 @@ class TestGranularity(iotests.QMPTestCase):
     image_len =3D 10 * 1024 * 1024 # MB
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img,
-                 str(TestGranularity.image_len))
+        create_test_image(test_img, TestGranularity.image_len)
         qemu_io('-c', 'write 0 %d' % (self.image_len),
                 test_img)
         self.vm =3D iotests.VM().add_drive(test_img)
@@ -845,7 +838,7 @@ class TestGranularity(iotests.QMPTestCase):
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirror=
ing')
-        os.remove(test_img)
+        remove_test_image(test_img)
         os.remove(target_img)
=20
     def test_granularity(self):
@@ -879,8 +872,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
         # Add each individual quorum images
         for i in self.IMAGES:
-            qemu_img('create', '-f', iotests.imgfmt, i,
-                     str(TestSingleDrive.image_len))
+            create_test_image(i, TestSingleDrive.image_len)
             # Assign a node name to each quorum image in order to manipu=
late
             # them
             opts =3D "node-name=3Dimg%i" % self.IMAGES.index(i)
@@ -898,8 +890,10 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file=
 ]:
-            # Do a try/except because the test may have deleted some ima=
ges
+        for i in self.IMAGES:
+            remove_test_image(i)
+
+        for i in [ quorum_repair_img, quorum_snapshot_file ]:
             try:
                 os.remove(i)
             except OSError:
--=20
2.21.0


