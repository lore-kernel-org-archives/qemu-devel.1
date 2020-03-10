Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55EC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAEB24655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgznh5jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAEB24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdGf-0007p4-AG
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDn-0003Jm-EW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDl-0008S4-HC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDl-0008PT-Aq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6GmspIQH0sn1NbUVsEqrTbC/uxY9+h0TOVCZtvuuLU=;
 b=Cgznh5jEiR8FXF0jWItks0wz8kRnCe2Yn0/uON1F5K0GkWgXuU9ACpHHihMjYy/NBOaprU
 ctqTsT4RM9AsyKnTZXCcfYlfedR2ArtbCsRVUOYhgT7Ljzcveo306WK7wpDXZyEzwmCnpz
 npD+Muipikx8yKFE1PDcdaAvTLtGcFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Tt0fD4BPORWOwlIsw0ZSpw-1; Tue, 10 Mar 2020 07:38:45 -0400
X-MC-Unique: Tt0fD4BPORWOwlIsw0ZSpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1BF800EBD;
 Tue, 10 Mar 2020 11:38:44 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC5490A0E;
 Tue, 10 Mar 2020 11:38:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/7] iotests: Test mirror with temporarily disabled target
 backing file
Date: Tue, 10 Mar 2020 12:38:28 +0100
Message-Id: <20200310113831.27293-5-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The newly tested scenario is a common live storage migration scenario:
The target node is opened without a backing file so that the active
layer is mirrored while its backing chain can be copied in the
background.

The backing chain should be attached to the mirror target node when
finalising the job, just before switching the users of the source node
to the new copy (at which point the mirror job still has a reference to
the node). drive-mirror did this automatically, but with blockdev-mirror
this is the job of the QMP client.

This patch adds test cases for two ways to achieve the desired result,
using either x-blockdev-reopen or blockdev-snapshot.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/155     | 56 ++++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/155.out |  4 +--
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index f237868710..74ddefc849 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -45,10 +45,15 @@ target_img =3D os.path.join(iotests.test_dir, 'target.'=
 + iotests.imgfmt)
 #                      image during runtime, only makes sense if
 #                      target_blockdev_backing is not None
 #                      (None: same as target_backing)
+# target_open_with_backing: If True, the target image is added with its ba=
cking
+#                           chain opened right away. If False, blockdev-ad=
d
+#                           opens it without a backing file and job comple=
tion
+#                           is supposed to open the backing chain.
=20
 class BaseClass(iotests.QMPTestCase):
     target_blockdev_backing =3D None
     target_real_backing =3D None
+    target_open_with_backing =3D True
=20
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, back0_img, '1440K')
@@ -80,9 +85,13 @@ class BaseClass(iotests.QMPTestCase):
                 options =3D { 'node-name': 'target',
                             'driver': iotests.imgfmt,
                             'file': { 'driver': 'file',
+                                      'node-name': 'target-file',
                                       'filename': target_img } }
-                if self.target_blockdev_backing:
-                    options['backing'] =3D self.target_blockdev_backing
+
+                if not self.target_open_with_backing:
+                        options['backing'] =3D None
+                elif self.target_blockdev_backing:
+                        options['backing'] =3D self.target_blockdev_backin=
g
=20
                 result =3D self.vm.qmp('blockdev-add', **options)
                 self.assert_qmp(result, 'return', {})
@@ -147,10 +156,14 @@ class BaseClass(iotests.QMPTestCase):
 # cmd: Mirroring command to execute, either drive-mirror or blockdev-mirro=
r
=20
 class MirrorBaseClass(BaseClass):
+    def openBacking(self):
+        pass
+
     def runMirror(self, sync):
         if self.cmd =3D=3D 'blockdev-mirror':
             result =3D self.vm.qmp(self.cmd, job_id=3D'mirror-job', device=
=3D'source',
-                                 sync=3Dsync, target=3D'target')
+                                 sync=3Dsync, target=3D'target',
+                                 auto_finalize=3DFalse)
         else:
             if self.existing:
                 mode =3D 'existing'
@@ -159,11 +172,12 @@ class MirrorBaseClass(BaseClass):
             result =3D self.vm.qmp(self.cmd, job_id=3D'mirror-job', device=
=3D'source',
                                  sync=3Dsync, target=3Dtarget_img,
                                  format=3Diotests.imgfmt, mode=3Dmode,
-                                 node_name=3D'target')
+                                 node_name=3D'target', auto_finalize=3DFal=
se)
=20
         self.assert_qmp(result, 'return', {})
=20
-        self.complete_and_wait('mirror-job')
+        self.vm.run_job('mirror-job', use_log=3DFalse, auto_finalize=3DFal=
se,
+                        pre_finalize=3Dself.openBacking, auto_dismiss=3DTr=
ue)
=20
     def testFull(self):
         self.runMirror('full')
@@ -221,6 +235,38 @@ class TestBlockdevMirrorForcedBacking(MirrorBaseClass)=
:
     target_blockdev_backing =3D { 'driver': 'null-co' }
     target_real_backing =3D 'null-co://'
=20
+# Attach the backing chain only during completion, with blockdev-reopen
+class TestBlockdevMirrorReopen(MirrorBaseClass):
+    cmd =3D 'blockdev-mirror'
+    existing =3D True
+    target_backing =3D 'null-co://'
+    target_open_with_backing =3D False
+
+    def openBacking(self):
+        if not self.target_open_with_backing:
+            result =3D self.vm.qmp('blockdev-add', node_name=3D"backing",
+                                 driver=3D"null-co")
+            self.assert_qmp(result, 'return', {})
+            result =3D self.vm.qmp('x-blockdev-reopen', node_name=3D"targe=
t",
+                                 driver=3Diotests.imgfmt, file=3D"target-f=
ile",
+                                 backing=3D"backing")
+            self.assert_qmp(result, 'return', {})
+
+# Attach the backing chain only during completion, with blockdev-snapshot
+class TestBlockdevMirrorSnapshot(MirrorBaseClass):
+    cmd =3D 'blockdev-mirror'
+    existing =3D True
+    target_backing =3D 'null-co://'
+    target_open_with_backing =3D False
+
+    def openBacking(self):
+        if not self.target_open_with_backing:
+            result =3D self.vm.qmp('blockdev-add', node_name=3D"backing",
+                                 driver=3D"null-co")
+            self.assert_qmp(result, 'return', {})
+            result =3D self.vm.qmp('blockdev-snapshot', node=3D"backing",
+                                 overlay=3D"target")
+            self.assert_qmp(result, 'return', {})
=20
 class TestCommit(BaseClass):
     existing =3D False
diff --git a/tests/qemu-iotests/155.out b/tests/qemu-iotests/155.out
index 4176bb9402..4fd1c2dcd2 100644
--- a/tests/qemu-iotests/155.out
+++ b/tests/qemu-iotests/155.out
@@ -1,5 +1,5 @@
-...................
+.........................
 ----------------------------------------------------------------------
-Ran 19 tests
+Ran 25 tests
=20
 OK
--=20
2.20.1


