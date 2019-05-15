Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23374C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D066C20873
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0PY-0002eN-UL
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:22:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0JK-0005wX-GR
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hR0JJ-0007xB-2M
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hR0JF-0007c1-Cp; Wed, 15 May 2019 16:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C31373002738;
	Wed, 15 May 2019 20:15:15 +0000 (UTC)
Received: from localhost (unknown [10.40.205.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 585311001959;
	Wed, 15 May 2019 20:15:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 15 May 2019 22:15:03 +0200
Message-Id: <20190515201503.19069-5-mreitz@redhat.com>
In-Reply-To: <20190515201503.19069-1-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 20:15:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] iotests: Make 245 faster and more reliable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes, 245 fails for me because some stream job has already finished
while the test expects it to still be active.  (With -c none, it fails
basically every time.) The most reliable way to fix this is to simply
set auto_finalize=3Dfalse so the job will remain in the block graph as
long as we need it.  This allows us to drop the rate limiting, too,
which makes the test faster.

The only problem with this is that there is a single place that yields a
different error message depending on whether the stream job is still
copying data (so COR is enabled) or not (COR has been disabled, but the
job still has the WRITE_UNCHANGED permission on the target node).  We
can easily address that by expecting either error message.

Note that we do not need auto_finalize=3Dfalse (or rate limiting) for the
active commit job, because It never completes without an explicit
block-job-complete anyway.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/245     | 22 ++++++++++++++--------
 tests/qemu-iotests/245.out | 12 ++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a04c6235c1..349b94aace 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -862,7 +862,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
         # hd2 <- hd0
         result =3D self.vm.qmp('block-stream', conv_keys =3D True, job_i=
d =3D 'stream0',
-                             device =3D 'hd0', base_node =3D 'hd2', spee=
d =3D 512 * 1024)
+                             device =3D 'hd0', base_node =3D 'hd2',
+                             auto_finalize =3D False)
         self.assert_qmp(result, 'return', {})
=20
         # We can't remove hd2 while the stream job is ongoing
@@ -873,7 +874,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts['backing'] =3D None
         self.reopen(opts, {}, "Cannot change 'backing' link from 'hd0' t=
o 'hd1'")
=20
-        self.wait_until_completed(drive =3D 'stream0')
+        self.vm.run_job('stream0', auto_finalize =3D False, auto_dismiss=
 =3D True)
=20
     # Reopen the chain during a block-stream job (from hd2 to hd1)
     def test_block_stream_4(self):
@@ -886,12 +887,16 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
         # hd1 <- hd0
         result =3D self.vm.qmp('block-stream', conv_keys =3D True, job_i=
d =3D 'stream0',
-                             device =3D 'hd1', speed =3D 512 * 1024)
+                             device =3D 'hd1', auto_finalize =3D False)
         self.assert_qmp(result, 'return', {})
=20
         # We can't reopen with the original options because that would
         # make hd1 read-only and block-stream requires it to be read-wri=
te
-        self.reopen(opts, {}, "Can't set node 'hd1' to r/o with copy-on-=
read enabled")
+        # (Which error message appears depends on whether the stream job=
 is
+        # already done with copying at this point.)
+        self.reopen(opts, {},
+            ["Can't set node 'hd1' to r/o with copy-on-read enabled",
+             "Cannot make block node read-only, there is a writer on it"=
])
=20
         # We can't remove hd2 while the stream job is ongoing
         opts['backing']['backing'] =3D None
@@ -901,7 +906,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts['backing'] =3D None
         self.reopen(opts)
=20
-        self.wait_until_completed(drive =3D 'stream0')
+        self.vm.run_job('stream0', auto_finalize =3D False, auto_dismiss=
 =3D True)
=20
     # Reopen the chain during a block-commit job (from hd0 to hd2)
     def test_block_commit_1(self):
@@ -913,7 +918,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
         result =3D self.vm.qmp('block-commit', conv_keys =3D True, job_i=
d =3D 'commit0',
-                             device =3D 'hd0', speed =3D 1024 * 1024)
+                             device =3D 'hd0')
         self.assert_qmp(result, 'return', {})
=20
         # We can't remove hd2 while the commit job is ongoing
@@ -944,7 +949,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
         result =3D self.vm.qmp('block-commit', conv_keys =3D True, job_i=
d =3D 'commit0',
-                             device =3D 'hd0', top_node =3D 'hd1', speed=
 =3D 1024 * 1024)
+                             device =3D 'hd0', top_node =3D 'hd1',
+                             auto_finalize =3D False)
         self.assert_qmp(result, 'return', {})
=20
         # We can't remove hd2 while the commit job is ongoing
@@ -956,7 +962,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {}, "Cannot change backing link if 'hd0' has a=
n implicit backing file")
=20
         # hd2 <- hd0
-        self.wait_until_completed(drive =3D 'commit0')
+        self.vm.run_job('commit0', auto_finalize =3D False, auto_dismiss=
 =3D True)
=20
         self.assert_qmp(self.get_node('hd0'), 'ro', False)
         self.assertEqual(self.get_node('hd1'), None)
diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
index 71009c239f..a19de5214d 100644
--- a/tests/qemu-iotests/245.out
+++ b/tests/qemu-iotests/245.out
@@ -3,3 +3,15 @@
 Ran 18 tests
=20
 OK
+{"execute": "job-finalize", "arguments": {"id": "commit0"}}
+{"return": {}}
+{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
--=20
2.21.0


