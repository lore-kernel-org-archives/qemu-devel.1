Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF78D2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF78D2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYgR-00035X-Mv
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdJ-0008Ia-St
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdI-0003a3-DK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdF-0003VR-7u; Fri, 16 Aug 2019 05:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44D0B4ACA7;
 Fri, 16 Aug 2019 09:34:47 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E1EF5C1D6;
 Fri, 16 Aug 2019 09:34:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:26 +0200
Message-Id: <20190816093439.14262-4-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 16 Aug 2019 09:34:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/16] iotests/118: Add -blockdev based tests
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code path for -device drive=3D<node-name> or without a drive=3D...
option for empty drives, which is supposed to be used with -blockdev
differs enough from the -drive based path with a user-owned
BlockBackend, so we want to test both paths at least for the basic tests
implemented by TestInitiallyFilled and TestInitiallyEmpty.

This would have caught the bug recently fixed for inserting read-only
nodes into a scsi-cd created without a drive=3D... option.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/118     | 43 ++++++++++++++++++++++++++------------
 tests/qemu-iotests/118.out |  4 ++--
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index c281259215..6f45779ee9 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -42,10 +42,14 @@ class ChangeBaseClass(iotests.QMPTestCase):
     has_opened =3D False
     has_closed =3D False
=20
+    device_name =3D 'qdev0'
+    use_drive =3D False
+
     def process_events(self):
         for event in self.vm.get_qmp_events(wait=3DFalse):
             if (event['event'] =3D=3D 'DEVICE_TRAY_MOVED' and
-                event['data']['device'] =3D=3D 'drive0'):
+                (event['data']['device'] =3D=3D 'drive0' or
+                 event['data']['id'] =3D=3D self.device_name)):
                 if event['data']['tray-open'] =3D=3D False:
                     self.has_closed =3D True
                 else:
@@ -69,9 +73,11 @@ class ChangeBaseClass(iotests.QMPTestCase):
=20
 class GeneralChangeTestsBaseClass(ChangeBaseClass):
=20
-    device_name =3D 'qdev0'
-
     def test_change(self):
+        # 'change' requires a drive name, so skip the test for blockdev
+        if not self.use_drive:
+            return
+
         result =3D self.vm.qmp('change', device=3D'drive0', target=3Dnew=
_img,
                                        arg=3Diotests.imgfmt)
         self.assert_qmp(result, 'return', {})
@@ -298,7 +304,13 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClas=
s):
         qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm =3D iotests.VM()
-        self.vm.add_drive(old_img, 'media=3D%s' % self.media, 'none')
+        if self.use_drive:
+            self.vm.add_drive(old_img, 'media=3D%s' % self.media, 'none'=
)
+        else:
+            self.vm.add_blockdev([ 'node-name=3Ddrive0',
+                                   'driver=3D%s' % iotests.imgfmt,
+                                   'file.driver=3Dfile',
+                                   'file.filename=3D%s' % old_img ])
         if self.interface =3D=3D 'scsi':
             self.vm.add_device('virtio-scsi-pci')
         self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
@@ -333,11 +345,14 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClas=
s):
=20
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
-        self.vm =3D iotests.VM().add_drive(None, 'media=3D%s' % self.med=
ia, 'none')
+        self.vm =3D iotests.VM()
+        if self.use_drive:
+            self.vm.add_drive(None, 'media=3D%s' % self.media, 'none')
         if self.interface =3D=3D 'scsi':
             self.vm.add_device('virtio-scsi-pci')
-        self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
+        self.vm.add_device('%s,%sid=3D%s' %
                            (interface_to_device_name(self.interface),
+                            'drive=3Ddrive0,' if self.use_drive else '',
                             self.device_name))
         self.vm.launch()
=20
@@ -363,13 +378,15 @@ def create_basic_test_classes():
                                                ('disk', 'floppy', False)=
 ]:
=20
         for case in [ TestInitiallyFilled, TestInitiallyEmpty ]:
-
-            attr =3D { 'media': media,
-                     'interface': interface,
-                     'has_real_tray': has_real_tray }
-
-            name =3D '%s_%s_%s' % (case.__name__, media, interface)
-            globals()[name] =3D type(name, (case, ), attr)
+            for use_drive in [ True, False ]:
+                attr =3D { 'media': media,
+                         'interface': interface,
+                         'has_real_tray': has_real_tray,
+                         'use_drive': use_drive }
+
+                name =3D '%s_%s_%s_%s' % (case.__name__, media, interfac=
e,
+                                        'drive' if use_drive else 'block=
dev')
+                globals()[name] =3D type(name, (case, ), attr)
=20
 create_basic_test_classes()
=20
diff --git a/tests/qemu-iotests/118.out b/tests/qemu-iotests/118.out
index b4ff997a8c..bf5bfd5aca 100644
--- a/tests/qemu-iotests/118.out
+++ b/tests/qemu-iotests/118.out
@@ -1,5 +1,5 @@
-........................................................................=
.................
+........................................................................=
.........................................................................=
......................
 ----------------------------------------------------------------------
-Ran 89 tests
+Ran 167 tests
=20
 OK
--=20
2.20.1


