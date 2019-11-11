Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B5220674
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG8+q6VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B5220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCds-0001me-TE
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUCA9-0000NL-Rk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUCA7-000399-9n
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUCA5-00038R-FC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjOmMb8SbuE3Eau+JWgFrpKa9d+ujZ1o70YXIj/vuCw=;
 b=ZG8+q6VNNFhX+EY4QQOVWcPv5JQAfkOvonxPKfhdW44tUb/asfO/KDWNqN4o35N1txC7P1
 OZG5bEJcMp3velKF7zoYEXkpxUzr53d7clH1pmCxjIwiwXOgFZmJp+yFtZAW7i7LkNB8Jn
 XF6M5zhKwk9Onclw7VuMSJSP7HBcGgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-EClod1VRMXayYki6wpUtwg-1; Mon, 11 Nov 2019 11:03:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B5792CA60;
 Mon, 11 Nov 2019 16:03:24 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FEDD3DBB;
 Mon, 11 Nov 2019 16:03:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 21/23] iotests: Add tests for invalid Quorum
 @replaces
Date: Mon, 11 Nov 2019 17:02:14 +0100
Message-Id: <20191111160216.197086-22-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EClod1VRMXayYki6wpUtwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two tests to see that you cannot replace a Quorum child with the
mirror job while the child is in use by a different parent.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 70 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |  4 +--
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 0c1af45639..ab0cb5b42f 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -20,6 +20,7 @@
=20
 import time
 import os
+import re
 import iotests
 from iotests import qemu_img, qemu_io
=20
@@ -34,6 +35,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum3.i=
mg')
 quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img')
 quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapshot.i=
mg')
=20
+nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
+
 class TestSingleDrive(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
     qmp_cmd =3D 'drive-mirror'
@@ -901,7 +904,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file ]=
:
+        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_file,
+                                 nbd_sock_path ]:
             # Do a try/except because the test may have deleted some image=
s
             try:
                 os.remove(i)
@@ -1042,6 +1046,70 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node("repair0", quorum_repair_img)
         self.vm.assert_block_path('quorum0', '/children.1', 'repair0')
=20
+    """
+    Check that we cannot replace a Quorum child when it has other
+    parents.
+    """
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
+                             sync=3D'full', node_name=3D'repair0', replace=
s=3D'img1',
+                             target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
+        self.assert_qmp(result, 'error/desc',
+                        "Cannot replace 'img1' by a node mirrored from "
+                        "'quorum0', because it cannot be guaranteed that d=
oing "
+                        "so would not lead to an abrupt change of visible =
data")
+
+    """
+    The same as test_with_other_parent(), but add the NBD server only
+    when the mirror job is already running.
+    """
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
+                             sync=3D'full', node_name=3D'repair0', replace=
s=3D'img1',
+                             target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
+        self.assert_qmp(result, 'return', {})
+
+        # The full error message goes to stderr, we will check it later
+        self.complete_and_wait('mirror',
+                               completion_error=3D'Operation not permitted=
')
+
+        # Should not have been replaced
+        self.vm.assert_block_path('quorum0', '/children.1', 'img1')
+
+        # Check the full error message now
+        self.vm.shutdown()
+        log =3D self.vm.get_log()
+        log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
+        log =3D re.sub(r'^Formatting.*\n', '', log)
+        log =3D re.sub(r'\n\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        log =3D re.sub(r'^qemu-system-[^:]*: ', '', log)
+
+        self.assertEqual(log,
+                         "Can no longer replace 'img1' by 'repair0', becau=
se " +
+                         "it can no longer be guaranteed that doing so wou=
ld " +
+                         "not lead to an abrupt change of visible data")
+
+
 # Test mirroring with a source that does not have any parents (not even a
 # BlockBackend)
 class TestOrphanedSource(iotests.QMPTestCase):
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index f496be9197..ffc779b4d1 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..........................................................................=
.................
+..........................................................................=
...................
 ----------------------------------------------------------------------
-Ran 91 tests
+Ran 93 tests
=20
 OK
--=20
2.23.0


