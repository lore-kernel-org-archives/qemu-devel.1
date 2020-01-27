Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069C820CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsBQdCvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069C820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8fN-0006ik-H0
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cR-00025Z-3I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cP-0002kF-HZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cP-0002k7-Eh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhNYikyggMXNLapw/CC2IM7fX9UYRW8lpBkJAnDhDX4=;
 b=LsBQdCvtzeAoj/1TenWhwEkaY9uAWgr23jYyxH13cm5N2iB6CqDNNx0DoGpYuzf8FqN9QR
 udS/7jwUhTZz0icYhPcDmgmSxU82CoohMeWhiFoRDD0bOQ3hziawE1UFlQKxYXengm15PT
 breZtwDkOadTn8+WCqqIAto4GwSnR2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-qjDZron4MDGlfGLOY3BkBQ-1; Mon, 27 Jan 2020 12:56:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 130FF804C24;
 Mon, 27 Jan 2020 17:56:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC9E863CE;
 Mon, 27 Jan 2020 17:56:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/13] iotests: Add more "skip_if_unsupported" statements to
 the python tests
Date: Mon, 27 Jan 2020 18:55:48 +0100
Message-Id: <20200127175559.18173-3-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qjDZron4MDGlfGLOY3BkBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The python code already contains a possibility to skip tests if the
corresponding driver is not available in the qemu binary - use it
in more spots to avoid that the tests are failing if the driver has
been disabled.

While we're at it, we can now also remove some of the old checks that
were using iotests.supports_quorum() - and which were apparently not
working as expected since the tests aborted instead of being skipped
when "quorum" was missing in the QEMU binary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030 |  4 +---
 tests/qemu-iotests/040 |  2 ++
 tests/qemu-iotests/041 | 39 +++------------------------------------
 tests/qemu-iotests/245 |  2 ++
 4 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index be35bde06f..0990681c1e 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
     children =3D []
     backing =3D []
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         opts =3D ['driver=3Dquorum', 'vote-threshold=3D2']
=20
@@ -560,9 +561,6 @@ class TestQuorum(iotests.QMPTestCase):
             os.remove(img)
=20
     def test_stream_quorum(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assertNotEqual(qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'ma=
p', self.children[0]),
                             qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'ma=
p', self.backing[0]),
                             'image file map matches backing file before st=
reaming')
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 762ad1ebcb..74f62c3c4a 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -106,6 +106,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 52=
4288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 5242=
88 524288', backing_img).find("verification failed"))
=20
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_with_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
@@ -125,6 +126,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.has_quit =3D True
=20
     # Same as above, but this time we add the filter after starting the jo=
b
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_plus_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index d7be30b62b..c07437fda1 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -871,6 +871,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
     IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         self.vm =3D iotests.VM()
=20
@@ -891,9 +892,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
         #assemble the quorum block device from the individual files
         args =3D { "driver": "quorum", "node-name": "quorum0",
                  "vote-threshold": 2, "children": [ "img0", "img1", "img2"=
 ] }
-        if iotests.supports_quorum():
-            result =3D self.vm.qmp("blockdev-add", **args)
-            self.assert_qmp(result, 'return', {})
+        result =3D self.vm.qmp("blockdev-add", **args)
+        self.assert_qmp(result, 'return', {})
=20
=20
     def tearDown(self):
@@ -906,9 +906,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                 pass
=20
     def test_complete(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -925,9 +922,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_cancel(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -942,9 +936,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.vm.shutdown()
=20
     def test_cancel_after_ready(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -961,9 +952,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_pause(self):
-        if not iotests.supports_quorum():
-            return
-
         self.assert_no_active_block_jobs()
=20
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
@@ -989,9 +977,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirrorin=
g')
=20
     def test_medium_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         if iotests.qemu_default_machine !=3D 'pc':
             return
=20
@@ -1003,9 +988,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_image_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', node_name=3D'repair0', replace=
s=3D'img1',
                              mode=3D'existing', target=3Dquorum_repair_img=
,
@@ -1013,9 +995,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_device_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0',
                              device=3D'nonexistent', sync=3D'full',
                              node_name=3D'repair0',
@@ -1024,9 +1003,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_wrong_sync_mode(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', device=3D'quorum0', job_id=
=3D'job0',
                              node_name=3D'repair0',
                              replaces=3D'img1',
@@ -1034,27 +1010,18 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_no_node_name(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', replaces=3D'img1',
                              target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_nonexistent_replaces(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0', device=3D'=
quorum0',
                              sync=3D'full', node_name=3D'repair0', replace=
s=3D'img77',
                              target=3Dquorum_repair_img, format=3Diotests.=
imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_after_a_quorum_snapshot(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('blockdev-snapshot-sync', node_name=3D'img1=
',
                              snapshot_file=3Dquorum_snapshot_file,
                              snapshot_node_name=3D"snap1");
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index e66a23c5f0..d12b253065 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -478,6 +478,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     # This test verifies that we can't change the children of a block
     # device during a reopen operation in a way that would create
     # cycles in the node graph
+    @iotests.skip_if_unsupported(['blkverify'])
     def test_graph_cycles(self):
         opts =3D []
=20
@@ -534,6 +535,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
     # Misc reopen tests with different block drivers
+    @iotests.skip_if_unsupported(['quorum', 'throttle'])
     def test_misc_drivers(self):
         ####################
         ###### quorum ######
--=20
2.20.1


