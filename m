Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE327C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEF121882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEF121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijAx-0005X6-QX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3q-0007VJ-BK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3p-0008LV-4C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3j-000897-R1; Wed, 03 Jul 2019 13:28:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 548463083394;
 Wed,  3 Jul 2019 17:28:41 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5F6E1001B14;
 Wed,  3 Jul 2019 17:28:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:12 +0200
Message-Id: <20190703172813.6868-12-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 17:28:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 11/12] iotests: Add read-only test case to
 030
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

This tests that the stream job exits cleanly (without abort) when the
top node is read-only and cannot be reopened read/write.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030     | 29 ++++++++++++++++++++++++++++-
 tests/qemu-iotests/030.out |  4 ++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index a0397072bc..1b69f318c6 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -36,7 +36,9 @@ class TestSingleDrive(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % mid_img, test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0x1 0 512', backing_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 524288 512', m=
id_img)
-        self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img, "bac=
king.node-name=3Dmid")
+        self.vm =3D iotests.VM().add_drive("blkdebug::" + test_img,
+                                         "backing.node-name=3Dmid," +
+                                         "backing.backing.node-name=3Dba=
se")
         self.vm.launch()
=20
     def tearDown(self):
@@ -151,6 +153,31 @@ class TestSingleDrive(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-stream', device=3D'mid')
         self.assert_qmp(result, 'error/desc', "Invalid job ID ''")
=20
+    def test_read_only(self):
+        # Create a new file that we can attach (we need a read-only top)
+        with iotests.FilePath('ro-top.img') as ro_top_path:
+            qemu_img('create', '-f', iotests.imgfmt, ro_top_path,
+                     str(self.image_len))
+
+            result =3D self.vm.qmp('blockdev-add',
+                                 node_name=3D'ro-top',
+                                 driver=3Diotests.imgfmt,
+                                 read_only=3DTrue,
+                                 file=3D{
+                                     'driver': 'file',
+                                     'filename': ro_top_path,
+                                     'read-only': True
+                                 },
+                                 backing=3D'mid')
+            self.assert_qmp(result, 'return', {})
+
+            result =3D self.vm.qmp('block-stream', job_id=3D'stream',
+                                 device=3D'ro-top', base_node=3D'base')
+            self.assert_qmp(result, 'error/desc', 'Block node is read-on=
ly')
+
+            result =3D self.vm.qmp('blockdev-del', node_name=3D'ro-top')
+            self.assert_qmp(result, 'return', {})
+
=20
 class TestParallelOps(iotests.QMPTestCase):
     num_ops =3D 4 # Number of parallel block-stream operations
diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
index 5eb508de07..6d9bee1a4b 100644
--- a/tests/qemu-iotests/030.out
+++ b/tests/qemu-iotests/030.out
@@ -1,5 +1,5 @@
-..........................
+...........................
 ----------------------------------------------------------------------
-Ran 26 tests
+Ran 27 tests
=20
 OK
--=20
2.21.0


