Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4814CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FDC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT/finZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FDC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCVN-0001cK-OU
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9v-00009c-Od
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9u-00031u-Fc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9s-000302-QP
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cl4SYAw3Ga27eigSjmrt5Kp5SAtVG9rNF6zj/H4oMMo=;
 b=DT/finZNUFSfg4rsNlHoGUfHScp+4njtyT6zqhM0Vmx8lXThrTRGB9cUC0H/PwodCW2VkG
 vVol9x0lIyNOYIRcZpoYRMUhySZVSKpTxWY0afTSNMB9OyxfFM9Ke9jRJqg7BJYIq9aH6n
 O/bbjN9PpFPJKYHJjZEKGC2P3dFAJ30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-TY9MFZjTMkuavyJqBKb5hA-1; Mon, 11 Nov 2019 11:03:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ECAC10753F3;
 Mon, 11 Nov 2019 16:03:12 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BED485DDAA;
 Mon, 11 Nov 2019 16:03:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 17/23] iotests: Use skip_if_unsupported decorator
 in 041
Date: Mon, 11 Nov 2019 17:02:10 +0100
Message-Id: <20191111160216.197086-18-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TY9MFZjTMkuavyJqBKb5hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

We can use this decorator above TestRepairQuorum.setUp() to skip all
quorum tests with a single line.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 3c60c07b01..2ab59e9c53 100755
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
@@ -894,9 +895,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -909,9 +909,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -928,9 +925,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -945,9 +939,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -964,9 +955,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -992,9 +980,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -1006,9 +991,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -1016,9 +998,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
     def test_device_not_found(self):
-        if not iotests.supports_quorum():
-            return
-
         result =3D self.vm.qmp('drive-mirror', job_id=3D'job0',
                              device=3D'nonexistent', sync=3D'full',
                              node_name=3D'repair0',
@@ -1027,9 +1006,6 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
@@ -1037,27 +1013,18 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
--=20
2.23.0


