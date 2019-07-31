Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A93C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746222067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746222067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvcZ-00065P-QQ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hsvQM-0003nS-ST
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hsvQL-0005ml-Iz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hsvQI-0005kj-NT; Wed, 31 Jul 2019 16:42:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BE4F300C72A;
 Wed, 31 Jul 2019 20:42:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-122.ams2.redhat.com
 [10.36.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF14A5C207;
 Wed, 31 Jul 2019 20:42:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 31 Jul 2019 22:42:02 +0200
Message-Id: <20190731204203.10732-3-kwolf@redhat.com>
In-Reply-To: <20190731204203.10732-1-kwolf@redhat.com>
References: <20190731204203.10732-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 31 Jul 2019 20:42:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] iotests/118: Create test classes
 dynamically
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're getting a ridiculous number of child classes of
TestInitiallyFilled and TestInitiallyEmpty that differ only in a few
attributes that we want to test in all combinations.

Instead of explicitly writing down every combination, let's use a loop
and create those classes dynamically.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/118 | 69 +++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 3c20d2d61f..c281259215 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -294,15 +294,15 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
 class TestInitiallyFilled(GeneralChangeTestsBaseClass):
     was_empty =3D False
=20
-    def setUp(self, media, interface):
+    def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm =3D iotests.VM()
-        self.vm.add_drive(old_img, 'media=3D%s' % media, 'none')
-        if interface =3D=3D 'scsi':
+        self.vm.add_drive(old_img, 'media=3D%s' % self.media, 'none')
+        if self.interface =3D=3D 'scsi':
             self.vm.add_device('virtio-scsi-pci')
         self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
-                           (interface_to_device_name(interface),
+                           (interface_to_device_name(self.interface),
                             self.device_name))
         self.vm.launch()
=20
@@ -331,13 +331,13 @@ class TestInitiallyFilled(GeneralChangeTestsBaseCla=
ss):
 class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
     was_empty =3D True
=20
-    def setUp(self, media, interface):
+    def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
-        self.vm =3D iotests.VM().add_drive(None, 'media=3D%s' % media, '=
none')
-        if interface =3D=3D 'scsi':
+        self.vm =3D iotests.VM().add_drive(None, 'media=3D%s' % self.med=
ia, 'none')
+        if self.interface =3D=3D 'scsi':
             self.vm.add_device('virtio-scsi-pci')
         self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
-                           (interface_to_device_name(interface),
+                           (interface_to_device_name(self.interface),
                             self.device_name))
         self.vm.launch()
=20
@@ -355,50 +355,23 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClas=
s):
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
=20
-class TestCDInitiallyFilled(TestInitiallyFilled):
-    TestInitiallyFilled =3D TestInitiallyFilled
-    has_real_tray =3D True
-
-    def setUp(self):
-        self.TestInitiallyFilled.setUp(self, 'cdrom', 'ide')
-
-class TestCDInitiallyEmpty(TestInitiallyEmpty):
-    TestInitiallyEmpty =3D TestInitiallyEmpty
-    has_real_tray =3D True
-
-    def setUp(self):
-        self.TestInitiallyEmpty.setUp(self, 'cdrom', 'ide')
+# Do this in a function to avoid leaking variables like case into the gl=
obal
+# name space (otherwise tests would be run for the abstract base classes=
)
+def create_basic_test_classes():
+    for (media, interface, has_real_tray) in [ ('cdrom', 'ide', True),
+                                               ('cdrom', 'scsi', True),
+                                               ('disk', 'floppy', False)=
 ]:
=20
-class TestSCSICDInitiallyFilled(TestInitiallyFilled):
-    TestInitiallyFilled =3D TestInitiallyFilled
-    has_real_tray =3D True
+        for case in [ TestInitiallyFilled, TestInitiallyEmpty ]:
=20
-    def setUp(self):
-        self.TestInitiallyFilled.setUp(self, 'cdrom', 'scsi')
+            attr =3D { 'media': media,
+                     'interface': interface,
+                     'has_real_tray': has_real_tray }
=20
-class TestSCSICDInitiallyEmpty(TestInitiallyEmpty):
-    TestInitiallyEmpty =3D TestInitiallyEmpty
-    has_real_tray =3D True
+            name =3D '%s_%s_%s' % (case.__name__, media, interface)
+            globals()[name] =3D type(name, (case, ), attr)
=20
-    def setUp(self):
-        self.TestInitiallyEmpty.setUp(self, 'cdrom', 'scsi')
-
-class TestFloppyInitiallyFilled(TestInitiallyFilled):
-    TestInitiallyFilled =3D TestInitiallyFilled
-    has_real_tray =3D False
-
-    def setUp(self):
-        self.TestInitiallyFilled.setUp(self, 'disk', 'floppy')
-
-class TestFloppyInitiallyEmpty(TestInitiallyEmpty):
-    TestInitiallyEmpty =3D TestInitiallyEmpty
-    has_real_tray =3D False
-
-    def setUp(self):
-        self.TestInitiallyEmpty.setUp(self, 'disk', 'floppy')
-        # FDDs not having a real tray and there not being a medium insid=
e the
-        # tray at startup means the tray will be considered open
-        self.has_opened =3D True
+create_basic_test_classes()
=20
 class TestChangeReadOnly(ChangeBaseClass):
     device_name =3D 'qdev0'
--=20
2.20.1


