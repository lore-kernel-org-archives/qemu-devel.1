Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA42C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72421206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72421206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33141 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLYL-0000Wh-8Y
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKqD-0001Eb-Oj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKqC-0004mW-2s
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKq7-0004hf-Nz; Fri, 20 Sep 2019 11:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 839E78980F5;
 Fri, 20 Sep 2019 15:28:53 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D8EA60167;
 Fri, 20 Sep 2019 15:28:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 20/22] iotests: Add tests for invalid Quorum @replaces
Date: Fri, 20 Sep 2019 17:28:02 +0200
Message-Id: <20190920152804.12875-21-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 20 Sep 2019 15:28:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two tests to see that you cannot replace a Quorum child with the
mirror job while the child is in use by a different parent.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 57 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |  4 +--
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 20ae9750b7..148dc47ce4 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -34,6 +34,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum3=
.img')
 quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img'=
)
 quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapshot=
.img')
=20
+nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
+
 class TestSingleDrive(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
     qmp_cmd =3D 'drive-mirror'
@@ -901,7 +903,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file=
 ]:
+        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file=
,
+                                 nbd_sock_path ]:
             # Do a try/except because the test may have deleted some ima=
ges
             try:
                 os.remove(i)
@@ -1075,6 +1078,58 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node("repair0", quorum_repair_img)
         self.vm.assert_block_path('quorum0/children.1', 'repair0')
=20
+    '''
+    Check that we cannot replace a Quorum child when it has other
+    parents.
+    '''
+    def test_with_other_parent(self):
+        result =3D self.vm.qmp('nbd-server-start',
+                             addr=3D{
+                                 'type': 'unix',
+                                 'data': {'path': nbd_sock_path}
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'quorum0',
+                             sync=3D'full', node_name=3D'repair0', repla=
ces=3D'img1',
+                             target=3Dquorum_repair_img, format=3Diotest=
s.imgfmt)
+        self.assert_qmp(result, 'error/desc',
+                        "Cannot replace 'img1' by a node mirrored from "
+                        "'quorum0', because it cannot be guaranteed that=
 doing "
+                        "so would not lead to an abrupt change of visibl=
e data")
+
+    '''
+    The same as test_with_other_parent(), but add the NBD server only
+    when the mirror job is already running.
+    '''
+    def test_with_other_parents_after_mirror_start(self):
+        result =3D self.vm.qmp('nbd-server-start',
+                             addr=3D{
+                                 'type': 'unix',
+                                 'data': {'path': nbd_sock_path}
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'quorum0',
+                             sync=3D'full', node_name=3D'repair0', repla=
ces=3D'img1',
+                             target=3Dquorum_repair_img, format=3Diotest=
s.imgfmt)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
+        self.assert_qmp(result, 'return', {})
+
+        # The full error message goes to stderr, so we unfortunately
+        # cannot check it here
+        self.complete_and_wait('mirror',
+                               completion_error=3D'Operation not permitt=
ed')
+
+        # Should not have been replaced
+        self.vm.assert_block_path('quorum0/children.1', 'img1')
+
+
 # Test mirroring with a source that does not have any parents (not even =
a
 # BlockBackend)
 class TestOrphanedSource(iotests.QMPTestCase):
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index f496be9197..ffc779b4d1 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
...................
+........................................................................=
.....................
 ----------------------------------------------------------------------
-Ran 91 tests
+Ran 93 tests
=20
 OK
--=20
2.21.0


