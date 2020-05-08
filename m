Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FF4208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EY2ifV02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FF4208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2NY-0005mX-JH
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KB-0008RB-Op
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KA-0007xT-LV
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TszdQ2ktFpW0gdOfVVNS21f7NO5mQ6NURobsLnXgct0=;
 b=EY2ifV02rK0sN9tAC7WylUUQ+qRwdq/FOo1Y68v7ZFkyj3dg3SEwaER/8kL07vHoj939/2
 MQA3oVWIVff1SANbI0woFUeEV8QOs3kXfWT5OiA6VcU1gABxVlLVTJTJfaZzse/xM8wU9J
 xwy0vMaS8oqHxuV6L7fofZpgakIm7M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-ZCvniW-pOMeKyG36HoZguQ-1; Fri, 08 May 2020 08:41:49 -0400
X-MC-Unique: ZCvniW-pOMeKyG36HoZguQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E832A835B8B;
 Fri,  8 May 2020 12:41:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA96619167;
 Fri,  8 May 2020 12:41:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/30] iotests/055: refactor compressed backup to vmdk
Date: Fri,  8 May 2020 14:41:10 +0200
Message-Id: <20200508124135.252565-6-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Instead of looping in each test, let's better refactor vmdk target case
as a subclass.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200430124713.3067-6-vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/055     | 70 ++++++++++++++++++++------------------
 tests/qemu-iotests/055.out |  4 +--
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 4175fff5e4..d9e8985167 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -450,10 +450,9 @@ class TestSingleTransaction(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
=20
=20
-class TestDriveCompression(iotests.QMPTestCase):
+class TestCompressedToQcow2(iotests.QMPTestCase):
     image_len =3D 64 * 1024 * 1024 # MB
-    fmt_supports_compression =3D [{'type': 'qcow2', 'args': ()},
-                                {'type': 'vmdk', 'args': ('-o', 'subformat=
=3DstreamOptimized')}]
+    target_fmt =3D {'type': 'qcow2', 'args': ()}
=20
     def tearDown(self):
         self.vm.shutdown()
@@ -463,19 +462,20 @@ class TestDriveCompression(iotests.QMPTestCase):
         except OSError:
             pass
=20
-    def do_prepare_drives(self, fmt, args, attach_target):
+    def do_prepare_drives(self, attach_target):
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
=20
-        qemu_img('create', '-f', fmt, blockdev_target_img,
-                 str(TestDriveCompression.image_len), *args)
+        qemu_img('create', '-f', self.target_fmt['type'], blockdev_target_=
img,
+                 str(self.image_len), *self.target_fmt['args'])
         if attach_target:
             self.vm.add_drive(blockdev_target_img,
-                              img_format=3Dfmt, interface=3D"none")
+                              img_format=3Dself.target_fmt['type'],
+                              interface=3D"none")
=20
         self.vm.launch()
=20
-    def do_test_compress_complete(self, cmd, format, attach_target, **args=
):
-        self.do_prepare_drives(format['type'], format['args'], attach_targ=
et)
+    def do_test_compress_complete(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
=20
         self.assert_no_active_block_jobs()
=20
@@ -486,21 +486,21 @@ class TestDriveCompression(iotests.QMPTestCase):
=20
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, blockdev_target_i=
mg,
-                                               iotests.imgfmt, format['typ=
e']),
+                                               iotests.imgfmt,
+                                               self.target_fmt['type']),
                         'target image does not match source after backup')
=20
     def test_complete_compress_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('drive-backup', format, False,
-                                           target=3Dblockdev_target_img, m=
ode=3D'existing')
+        self.do_test_compress_complete('drive-backup', False,
+                                       target=3Dblockdev_target_img,
+                                       mode=3D'existing')
=20
     def test_complete_compress_blockdev_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_complete('blockdev-backup', format, True=
,
-                                           target=3D'drive1')
+        self.do_test_compress_complete('blockdev-backup',
+                                       True, target=3D'drive1')
=20
-    def do_test_compress_cancel(self, cmd, format, attach_target, **args):
-        self.do_prepare_drives(format['type'], format['args'], attach_targ=
et)
+    def do_test_compress_cancel(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
=20
         self.assert_no_active_block_jobs()
=20
@@ -514,17 +514,16 @@ class TestDriveCompression(iotests.QMPTestCase):
         self.vm.shutdown()
=20
     def test_compress_cancel_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('drive-backup', format, False,
-                                         target=3Dblockdev_target_img, mod=
e=3D'existing')
+        self.do_test_compress_cancel('drive-backup', False,
+                                     target=3Dblockdev_target_img,
+                                     mode=3D'existing')
=20
     def test_compress_cancel_blockdev_backup(self):
-       for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_cancel('blockdev-backup', format, True,
-                                         target=3D'drive1')
+        self.do_test_compress_cancel('blockdev-backup', True,
+                                     target=3D'drive1')
=20
-    def do_test_compress_pause(self, cmd, format, attach_target, **args):
-        self.do_prepare_drives(format['type'], format['args'], attach_targ=
et)
+    def do_test_compress_pause(self, cmd, attach_target, **args):
+        self.do_prepare_drives(attach_target)
=20
         self.assert_no_active_block_jobs()
=20
@@ -550,18 +549,23 @@ class TestDriveCompression(iotests.QMPTestCase):
=20
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, blockdev_target_i=
mg,
-                                               iotests.imgfmt, format['typ=
e']),
+                                               iotests.imgfmt,
+                                               self.target_fmt['type']),
                         'target image does not match source after backup')
=20
     def test_compress_pause_drive_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('drive-backup', format, False,
-                                        target=3Dblockdev_target_img, mode=
=3D'existing')
+        self.do_test_compress_pause('drive-backup', False,
+                                    target=3Dblockdev_target_img,
+                                    mode=3D'existing')
=20
     def test_compress_pause_blockdev_backup(self):
-        for format in TestDriveCompression.fmt_supports_compression:
-            self.do_test_compress_pause('blockdev-backup', format, True,
-                                        target=3D'drive1')
+        self.do_test_compress_pause('blockdev-backup', True,
+                                    target=3D'drive1')
+
+
+class TestCompressedToVmdk(TestCompressedToQcow2):
+    target_fmt =3D {'type': 'vmdk', 'args': ('-o', 'subformat=3DstreamOpti=
mized')}
+
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['raw', 'qcow2'],
diff --git a/tests/qemu-iotests/055.out b/tests/qemu-iotests/055.out
index 5ce2f9a2ed..5c26d15c0d 100644
--- a/tests/qemu-iotests/055.out
+++ b/tests/qemu-iotests/055.out
@@ -1,5 +1,5 @@
-..............................
+....................................
 ----------------------------------------------------------------------
-Ran 30 tests
+Ran 36 tests
=20
 OK
--=20
2.25.3


