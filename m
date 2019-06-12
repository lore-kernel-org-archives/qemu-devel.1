Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47602C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B57208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B57208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCNi-0005ol-DW
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBTN-0000kh-Ga
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBTM-00004y-6l
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBTJ-0008Ts-6y; Wed, 12 Jun 2019 18:11:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 795C06EB83;
 Wed, 12 Jun 2019 22:11:56 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B4060CCD;
 Wed, 12 Jun 2019 22:11:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:10:04 +0200
Message-Id: <20190612221004.2317-43-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-1-mreitz@redhat.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 12 Jun 2019 22:11:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 42/42] iotests: Test committing to
 overridden backing
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/040     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |  4 +--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 31c2a8da3b..5cbbd30ee3 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -609,5 +609,66 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         # 3 has been comitted into 2
         self.pattern_files[3] =3D self.img2
=20
+class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
+    img_base_a =3D os.path.join(iotests.test_dir, 'base_a.img')
+    img_base_b =3D os.path.join(iotests.test_dir, 'base_b.img')
+    img_top =3D os.path.join(iotests.test_dir, 'top.img')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_a, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_b, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.img_base_a, =
\
+                 self.img_top)
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+        # Use base_b instead of base_a as the backing of top
+        result =3D self.vm.qmp('blockdev-add', **{
+                                'node-name': 'top',
+                                'driver': iotests.imgfmt,
+                                'file': {
+                                    'driver': 'file',
+                                    'filename': self.img_top
+                                },
+                                'backing': {
+                                    'node-name': 'base',
+                                    'driver': iotests.imgfmt,
+                                    'file': {
+                                        'driver': 'file',
+                                        'filename': self.img_base_b
+                                    }
+                                }
+                            })
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(self.img_top)
+        os.remove(self.img_base_a)
+        os.remove(self.img_base_b)
+
+    def test_commit_to_a(self):
+        # Try committing to base_a (which should fail, as top's
+        # backing image is base_b instead)
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top',
+                             base=3Dself.img_base_a)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+    def test_commit_to_b(self):
+        # Try committing to base_b (which should work, since that is
+        # actually top's backing image)
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top',
+                             base=3Dself.img_base_b)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.event_wait('BLOCK_JOB_READY')
+        self.vm.qmp('block-job-complete', device=3D'commit')
+        self.vm.event_wait('BLOCK_JOB_COMPLETED')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index fe58934d7a..499af0e2ff 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...................................................
+.....................................................
 ----------------------------------------------------------------------
-Ran 51 tests
+Ran 53 tests
=20
 OK
--=20
2.21.0


