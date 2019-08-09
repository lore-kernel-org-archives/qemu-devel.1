Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9136C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BDD20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BDD20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7no-00064M-Pw
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7YR-00044L-Qw
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7YP-0004jN-Q2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7YG-0004fm-Q2; Fri, 09 Aug 2019 12:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EDC230BD1DA;
 Fri,  9 Aug 2019 16:15:36 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABB935DC1E;
 Fri,  9 Aug 2019 16:15:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:14:01 +0200
Message-Id: <20190809161407.11920-37-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 16:15:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 36/42] iotests: Add tests for mirror
 @replaces loops
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

This adds two tests for cases where our old check_to_replace_node()
function failed to detect that executing this job with these parameters
would result in a cyclic graph.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/041     | 124 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 26bf1701eb..0c1432f189 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1067,5 +1067,129 @@ class TestOrphanedSource(iotests.QMPTestCase):
                              target=3D'dest-ro')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+# Various tests for the @replaces option (independent of quorum)
+class TestReplaces(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_drive_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'filtered',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': test_img
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        # Mirror from @source to @target in sync=3Dnone, so that @source
+        # will be @target's backing file; but replace @filtered.
+        # Then, @target's backing file will be @source, whose backing
+        # file is now @target instead of @filtered.  That is a loop.
+        # (But apart from the loop, replacing @filtered instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result =3D self.vm.qmp('drive-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3Dtarget_img,
+                             format=3Diotests.imgfmt,
+                             node_name=3D'target',
+                             sync=3D'none',
+                             replaces=3D'filtered')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive=3D'mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        try:
+            os.remove(target_img)
+        except OSError:
+            pass
+
+    def test_blockdev_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img, '1M')
+
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'middle',
+                        'driver': 'throttle',
+                        'throttle-group': 'tg',
+                        'file': {
+                            'node-name': 'bottom',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': test_img
+                            }
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'target',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': target_img
+                    },
+                    'backing': 'middle'
+                })
+
+        # Mirror from @source to @target.  With blockdev-mirror, the
+        # current (old) backing file is retained (which is @middle).
+        # By replacing @bottom, @middle's file will be @target, whose
+        # backing file is @middle again.  That is a loop.
+        # (But apart from the loop, replacing @bottom instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3D'target',
+                             sync=3D'full',
+                             replaces=3D'bottom')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive=3D'mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        os.remove(target_img)
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index e071d0b261..2c448b4239 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
................
+........................................................................=
..................
 ----------------------------------------------------------------------
-Ran 88 tests
+Ran 90 tests
=20
 OK
--=20
2.21.0


