Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10068C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C596D20674
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C596D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4s8J-0006rm-O8
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 15:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4s59-0004MR-C9
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4s57-000743-Dl
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4s53-0006zn-AO; Mon, 02 Sep 2019 15:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A209D1027003;
 Mon,  2 Sep 2019 19:33:36 +0000 (UTC)
Received: from localhost (ovpn-204-221.brq.redhat.com [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BE360BF3;
 Mon,  2 Sep 2019 19:33:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  2 Sep 2019 21:33:18 +0200
Message-Id: <20190902193320.32233-4-mreitz@redhat.com>
In-Reply-To: <20190902193320.32233-1-mreitz@redhat.com>
References: <20190902193320.32233-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 02 Sep 2019 19:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/5] iotests: Restrict file Python tests to
 file
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of our Python unittest-style tests only support the file protocol.
You can run them with any other protocol, but the test will simply
ignore your choice and use file anyway.

We should let them signal that they require the file protocol so they
are skipped when you want to test some other protocol.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030 | 3 ++-
 tests/qemu-iotests/040 | 3 ++-
 tests/qemu-iotests/041 | 3 ++-
 tests/qemu-iotests/044 | 3 ++-
 tests/qemu-iotests/045 | 3 ++-
 tests/qemu-iotests/055 | 3 ++-
 tests/qemu-iotests/056 | 3 ++-
 tests/qemu-iotests/057 | 3 ++-
 tests/qemu-iotests/065 | 3 ++-
 tests/qemu-iotests/096 | 3 ++-
 tests/qemu-iotests/118 | 3 ++-
 tests/qemu-iotests/124 | 3 ++-
 tests/qemu-iotests/129 | 3 ++-
 tests/qemu-iotests/132 | 3 ++-
 tests/qemu-iotests/139 | 3 ++-
 tests/qemu-iotests/148 | 3 ++-
 tests/qemu-iotests/151 | 3 ++-
 tests/qemu-iotests/152 | 3 ++-
 tests/qemu-iotests/155 | 3 ++-
 tests/qemu-iotests/163 | 3 ++-
 tests/qemu-iotests/165 | 3 ++-
 tests/qemu-iotests/169 | 3 ++-
 tests/qemu-iotests/196 | 3 ++-
 tests/qemu-iotests/199 | 3 ++-
 tests/qemu-iotests/245 | 3 ++-
 tests/qemu-iotests/257 | 3 ++-
 26 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1b69f318c6..f3766f2a81 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -957,4 +957,5 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.cancel_and_wait(resume=3DTrue)
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2', 'qed'])
+    iotests.main(supported_fmts=3D['qcow2', 'qed'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 6db9abf8e6..762ad1ebcb 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -429,4 +429,5 @@ class TestReopenOverlay(ImageCommitTestCase):
         self.run_commit_test(self.img1, self.img0)
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2', 'qed'])
+    iotests.main(supported_fmts=3D['qcow2', 'qed'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8bc8f81db7..8568426311 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1122,4 +1122,5 @@ class TestOrphanedSource(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2', 'qed'])
+    iotests.main(supported_fmts=3D['qcow2', 'qed'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 9ec3dba734..05ea1f49c5 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -118,4 +118,5 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
         pass
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index d5484a0ee1..01cc038884 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -175,4 +175,5 @@ class TestSCMFd(iotests.QMPTestCase):
             "File descriptor named '%s' not found" % fdname)
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['raw'])
+    iotests.main(supported_fmts=3D['raw'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 3437c11507..c732a112d6 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -563,4 +563,5 @@ class TestDriveCompression(iotests.QMPTestCase):
                                         target=3D'drive1')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['raw', 'qcow2'])
+    iotests.main(supported_fmts=3D['raw', 'qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index e761e465ae..98c55d8e5a 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -335,4 +335,5 @@ class BackupTest(iotests.QMPTestCase):
         self.dismissal_failure(True)
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2', 'qed'])
+    iotests.main(supported_fmts=3D['qcow2', 'qed'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9f0a5a3057..9fbba759b6 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -256,4 +256,5 @@ class TestSnapshotDelete(ImageSnapshotTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 8bac383ea7..5b21eb96bd 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -129,4 +129,5 @@ TestQemuImgInfo =3D None
 TestQMP =3D None
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index a69439602d..ab9cb47822 100755
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -67,4 +67,5 @@ class TestLiveSnapshot(iotests.QMPTestCase):
         self.checkConfig('target')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 6f45779ee9..ea0b326ae0 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -717,4 +717,5 @@ if __name__ =3D=3D '__main__':
                        iotests.qemu_default_machine)
     # Need to support image creation
     iotests.main(supported_fmts=3D['vpc', 'parallels', 'qcow', 'vdi', 'q=
cow2',
-                                 'vmdk', 'raw', 'vhdx', 'qed'])
+                                 'vmdk', 'raw', 'vhdx', 'qed'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 3440f54781..ca40ba3be2 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -779,4 +779,5 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBa=
ckupBase):
=20
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c8d9..cd6b9e9ce7 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -83,4 +83,5 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         self.do_test_stop("block-commit", device=3D"drive0")
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D["qcow2"])
+    iotests.main(supported_fmts=3D["qcow2"],
+                 supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index f53ef6e391..0f2a106c81 100755
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -56,4 +56,5 @@ class TestSingleDrive(iotests.QMPTestCase):
                         'target image does not match source after mirror=
ing')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['raw', 'qcow2'])
+    iotests.main(supported_fmts=3D['raw', 'qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 2176ea51ba..cbb5a76530 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -358,4 +358,5 @@ class TestBlockdevDel(iotests.QMPTestCase):
=20
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D["qcow2"])
+    iotests.main(supported_fmts=3D["qcow2"],
+                 supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index e01b061fe7..8c11c53cba 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -137,4 +137,5 @@ class TestFifoQuorumEvents(TestQuorumEvents):
=20
 if __name__ =3D=3D '__main__':
     iotests.verify_quorum()
-    iotests.main(supported_fmts=3D["raw"])
+    iotests.main(supported_fmts=3D["raw"],
+                 supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index ad7359fc8d..76ae265cc1 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -142,4 +142,5 @@ class TestActiveMirror(iotests.QMPTestCase):
=20
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2', 'raw'])
+    iotests.main(supported_fmts=3D['qcow2', 'raw'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index fec546d033..732bf5f062 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -59,4 +59,5 @@ class TestUnaligned(iotests.QMPTestCase):
=20
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['raw', 'qcow2'])
+    iotests.main(supported_fmts=3D['raw', 'qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 63a5b5e2c0..e19485911c 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -258,4 +258,5 @@ BaseClass =3D None
 MirrorBaseClass =3D None
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 158ba5d092..081ccc8ac1 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -170,4 +170,5 @@ class TestShrink1M(ShrinkBaseClass):
 ShrinkBaseClass =3D None
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['raw', 'qcow2'])
+    iotests.main(supported_fmts=3D['raw', 'qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 88f62d3c6d..5650dc7c87 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -103,4 +103,5 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         self.vm.shutdown()
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 7e06cc1145..8c204caf20 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -227,4 +227,5 @@ for cmb in list(itertools.product((True, False), repe=
at=3D2)):
                      'do_test_migration_resume_source', *list(cmb))
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
index 4116ebc92b..92fe9244f8 100755
--- a/tests/qemu-iotests/196
+++ b/tests/qemu-iotests/196
@@ -63,4 +63,5 @@ class TestInvalidateAutoclear(iotests.QMPTestCase):
             self.assertEqual(f.read(1), b'\x00')
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'])
+    iotests.main(supported_fmts=3D['qcow2'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 651e8df5d9..a2c8ecab5a 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -115,4 +115,5 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTes=
tCase):
         self.assert_qmp(result, 'return/sha256', sha256);
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['qcow2'], supported_cache_modes=3D['n=
one'])
+    iotests.main(supported_fmts=3D['qcow2'], supported_cache_modes=3D['n=
one'],
+                 supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index bc1ceb9792..41218d5f1d 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1000,4 +1000,5 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {'backing': 'hd2'})
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D["qcow2"])
+    iotests.main(supported_fmts=3D["qcow2"],
+                 supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index c2a72c577a..4a636d8ab2 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -557,4 +557,5 @@ def main():
     test_backup_api()
=20
 if __name__ =3D=3D '__main__':
-    iotests.script_main(main, supported_fmts=3D['qcow2'])
+    iotests.script_main(main, supported_fmts=3D['qcow2'],
+                        supported_protocols=3D['file'])
--=20
2.21.0


