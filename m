Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79015C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528F0208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528F0208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCR6-0000Gj-Gm
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBrv-0005pI-4W
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBrt-0005xF-IV
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBrq-0005n5-JO; Wed, 12 Jun 2019 18:37:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 000F1307D869;
 Wed, 12 Jun 2019 22:37:03 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 861645ED2B;
 Wed, 12 Jun 2019 22:37:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:37:01 +0200
Message-Id: <20190612223701.31456-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 12 Jun 2019 22:37:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Fix 129
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

Throttling on the BB have not affected block jobs in a while, so 129
is prone to break (at least on tmpfs with high system load).  We can
fix the problem by running the job from a throttle node.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Depends on "[PATCH v5 00/42] block: Deal with filters".

Based-on: <20190612221004.2317-1-mreitz@redhat.com>

Yes, I know, that is a long dependency chain.  For now, I just want to
show that this patch exists.
---
 tests/qemu-iotests/129 | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c8d9..c729e2bde5 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -31,52 +31,37 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, =
"1G")
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img, =
"-b", self.base_img)
         iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 1M 128=
M', self.test_img)
-        self.vm =3D iotests.VM().add_drive(self.test_img)
+        self.vm =3D iotests.VM()
+        self.vm.add_object('throttle-group,id=3Dtg0,x-bps-total=3D1024')
+        self.vm.add_drive(None, 'driver=3Dthrottle,throttle-group=3Dtg0,=
file.driver=3D%s,file.file.filename=3D%s' % (iotests.imgfmt, self.test_im=
g))
         self.vm.launch()
=20
     def tearDown(self):
-        params =3D {"device": "drive0",
-                  "bps": 0,
-                  "bps_rd": 0,
-                  "bps_wr": 0,
-                  "iops": 0,
-                  "iops_rd": 0,
-                  "iops_wr": 0,
-                 }
-        result =3D self.vm.qmp("block_set_io_throttle", conv_keys=3DFals=
e,
-                             **params)
         self.vm.shutdown()
=20
     def do_test_stop(self, cmd, **args):
         """Test 'stop' while block job is running on a throttled drive.
         The 'stop' command shouldn't drain the job"""
-        params =3D {"device": "drive0",
-                  "bps": 1024,
-                  "bps_rd": 0,
-                  "bps_wr": 0,
-                  "iops": 0,
-                  "iops_rd": 0,
-                  "iops_wr": 0,
-                 }
-        result =3D self.vm.qmp("block_set_io_throttle", conv_keys=3DFals=
e,
-                             **params)
-        self.assert_qmp(result, 'return', {})
         result =3D self.vm.qmp(cmd, **args)
         self.assert_qmp(result, 'return', {})
+
         result =3D self.vm.qmp("stop")
         self.assert_qmp(result, 'return', {})
         result =3D self.vm.qmp("query-block-jobs")
+
         self.assert_qmp(result, 'return[0]/busy', True)
         self.assert_qmp(result, 'return[0]/ready', False)
=20
+        self.vm.qmp("block-job-cancel", device=3D"drive0", force=3DTrue)
+
     def test_drive_mirror(self):
         self.do_test_stop("drive-mirror", device=3D"drive0",
-                          target=3Dself.target_img,
+                          target=3Dself.target_img, format=3Diotests.img=
fmt,
                           sync=3D"full")
=20
     def test_drive_backup(self):
         self.do_test_stop("drive-backup", device=3D"drive0",
-                          target=3Dself.target_img,
+                          target=3Dself.target_img, format=3Diotests.img=
fmt,
                           sync=3D"full")
=20
     def test_block_commit(self):
--=20
2.21.0


