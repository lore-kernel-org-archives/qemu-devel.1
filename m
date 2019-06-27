Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD656C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9460A2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9460A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgd2N-0006GL-TF
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 18:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgcxR-0000Oo-UA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgcxO-0004FO-Kq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgcxH-0003xn-Cc; Thu, 27 Jun 2019 18:33:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84929C18B2C1;
 Thu, 27 Jun 2019 22:33:15 +0000 (UTC)
Received: from localhost (ovpn-204-47.brq.redhat.com [10.40.204.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B623419C4F;
 Thu, 27 Jun 2019 22:33:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 00:32:52 +0200
Message-Id: <20190627223255.3789-3-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-1-mreitz@redhat.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 27 Jun 2019 22:33:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/5] iotests: Fix throttling in 030
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, TestParallelOps in 030 creates images that are too small for
job throttling to be effective.  This is reflected by the fact that it
never undoes the throttling.

Increase the image size and undo the throttling when the job should be
completed.  Also, add throttling in test_overlapping_4, or the jobs may
not be so overlapping after all.  In fact, the error usually emitted
here is that node2 simply does not exist, not that overlapping jobs are
not allowed -- the fact that this job ignores the exact error messages
and just checks the error class is something that should be fixed in a
follow-up patch.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030 | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index c6311d1825..2cf8d54dc5 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -154,7 +154,7 @@ class TestSingleDrive(iotests.QMPTestCase):
 class TestParallelOps(iotests.QMPTestCase):
     num_ops =3D 4 # Number of parallel block-stream operations
     num_imgs =3D num_ops * 2 + 1
-    image_len =3D num_ops * 512 * 1024
+    image_len =3D num_ops * 4 * 1024 * 1024
     imgs =3D []
=20
     def setUp(self):
@@ -176,11 +176,11 @@ class TestParallelOps(iotests.QMPTestCase):
         # Put data into the images we are copying data from
         odd_img_indexes =3D [x for x in reversed(range(self.num_imgs)) i=
f x % 2 =3D=3D 1]
         for i in range(len(odd_img_indexes)):
-            # Alternate between 256KB and 512KB.
+            # Alternate between 2MB and 4MB.
             # This way jobs will not finish in the same order they were =
created
-            num_kb =3D 256 + 256 * (i % 2)
+            num_mb =3D 2 + 2 * (i % 2)
             qemu_io('-f', iotests.imgfmt,
-                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),
+                    '-c', 'write -P 0xFF %dM %dM' % (i * 4, num_mb),
                     self.imgs[odd_img_indexes[i]])
=20
         # Attach the drive to the VM
@@ -213,6 +213,10 @@ class TestParallelOps(iotests.QMPTestCase):
             result =3D self.vm.qmp('block-stream', device=3Dnode_name, j=
ob_id=3Djob_id, base=3Dself.imgs[i-2], speed=3D512*1024)
             self.assert_qmp(result, 'return', {})
=20
+        for job in pending_jobs:
+            result =3D self.vm.qmp('block-job-set-speed', device=3Djob, =
speed=3D0)
+            self.assert_qmp(result, 'return', {})
+
         # Wait for all jobs to be finished.
         while len(pending_jobs) > 0:
             for event in self.vm.get_qmp_events(wait=3DTrue):
@@ -260,6 +264,9 @@ class TestParallelOps(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-commit', device=3D'drive0', base=3D=
self.imgs[0], top=3Dself.imgs[1], job_id=3D'commit-node0')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'stream-n=
ode4', speed=3D0)
+        self.assert_qmp(result, 'return', {})
+
         self.wait_until_completed(drive=3D'stream-node4')
         self.assert_no_active_block_jobs()
=20
@@ -289,6 +296,9 @@ class TestParallelOps(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-stream', device=3D'drive0', base=3D=
self.imgs[5], job_id=3D'stream-drive0')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'commit-n=
ode3', speed=3D0)
+        self.assert_qmp(result, 'return', {})
+
         self.wait_until_completed(drive=3D'commit-node3')
=20
     # Similar to test_overlapping_2, but here block-commit doesn't use t=
he 'top' parameter.
@@ -309,6 +319,9 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'commit')
         self.assert_qmp_absent(event, 'data/error')
=20
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'commit-d=
rive0', speed=3D0)
+        self.assert_qmp(result, 'return', {})
+
         result =3D self.vm.qmp('block-job-complete', device=3D'commit-dr=
ive0')
         self.assert_qmp(result, 'return', {})
=20
@@ -321,13 +334,18 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
=20
         # Commit from node2 into node0
-        result =3D self.vm.qmp('block-commit', device=3D'drive0', top=3D=
self.imgs[2], base=3Dself.imgs[0])
+        result =3D self.vm.qmp('block-commit', device=3D'drive0',
+                             top=3Dself.imgs[2], base=3Dself.imgs[0],
+                             speed=3D1024*1024)
         self.assert_qmp(result, 'return', {})
=20
         # Stream from node2 into node4
         result =3D self.vm.qmp('block-stream', device=3D'node4', base_no=
de=3D'node2', job_id=3D'node4')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'drive0',=
 speed=3D0)
+        self.assert_qmp(result, 'return', {})
+
         self.wait_until_completed()
         self.assert_no_active_block_jobs()
=20
@@ -378,6 +396,10 @@ class TestParallelOps(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-commit', device=3D'drive0', base=3D=
self.imgs[5], speed=3D1024*1024)
         self.assert_qmp(result, 'return', {})
=20
+        for job in ['drive0', 'node4']:
+            result =3D self.vm.qmp('block-job-set-speed', device=3Djob, =
speed=3D0)
+            self.assert_qmp(result, 'return', {})
+
         # Wait for all jobs to be finished.
         pending_jobs =3D ['node4', 'drive0']
         while len(pending_jobs) > 0:
--=20
2.21.0


