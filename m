Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A357FC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E20B206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8Bzvduk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAEb-0003mR-Jw
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:32:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAm-0007Q0-4H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAl-000273-8s
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAAk-000263-RU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bv27LxzNTsoAoP0a774XWj25pMQ4oXsPv9Hw2pBNuE=;
 b=Q8BzvdukD/FtJ/TcJPWVLX4VqfEEaBYh5sPgaRkZuFpnPPSRnIKXQKYnCxXeH1pHD0aMDc
 wqso/ae6msOIZf3ScUTtyz4mS+6ukXcN7slnEcbjPqDXJB+v+uxDBuncl5OUmRERBSVaIF
 66RLporOlUu+z/4HnMZx7tS37Fd7IDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-A5Yh-wMiNN2qBpleKShTJw-1; Thu, 30 Apr 2020 10:28:16 -0400
X-MC-Unique: A5Yh-wMiNN2qBpleKShTJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19784835B44;
 Thu, 30 Apr 2020 14:28:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97B0F60C84;
 Thu, 30 Apr 2020 14:28:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/4] iotests: Backup with different source/target size
Date: Thu, 30 Apr 2020 16:27:55 +0200
Message-Id: <20200430142755.315494-5-kwolf@redhat.com>
In-Reply-To: <20200430142755.315494-1-kwolf@redhat.com>
References: <20200430142755.315494-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests that the backup job catches situations where the target node
has a different size than the source node. It must also forbid resize
operations when the job is already running.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/055     | 42 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/055.out |  4 ++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 82b9f5f47d..7753c6577a 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -48,8 +48,10 @@ class TestSingleDrive(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, blockdev_target_img, str(=
image_len))
=20
-        self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
-        self.vm.add_drive(blockdev_target_img, interface=3D"none")
+        self.vm =3D iotests.VM()
+        self.vm.add_drive('blkdebug::' + test_img, 'node-name=3Dsource')
+        self.vm.add_drive(blockdev_target_img, 'node-name=3Dtarget',
+                          interface=3D"none")
         if iotests.qemu_default_machine =3D=3D 'pc':
             self.vm.add_drive(None, 'media=3Dcdrom', 'ide')
         self.vm.launch()
@@ -112,6 +114,42 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_pause_blockdev_backup(self):
         self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_im=
g)
=20
+    def do_test_resize_blockdev_backup(self, device, node):
+        def pre_finalize():
+            result =3D self.vm.qmp('block_resize', device=3Ddevice, size=
=3D65536)
+            self.assert_qmp(result, 'error/class', 'GenericError')
+
+            result =3D self.vm.qmp('block_resize', node_name=3Dnode, size=
=3D65536)
+            self.assert_qmp(result, 'error/class', 'GenericError')
+
+        result =3D self.vm.qmp('blockdev-backup', job_id=3D'job0', device=
=3D'drive0',
+                             target=3D'drive1', sync=3D'full', auto_finali=
ze=3DFalse,
+                             auto_dismiss=3DFalse)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3Dpre_=
finalize,
+                        use_log=3DFalse)
+
+    def test_source_resize_blockdev_backup(self):
+        self.do_test_resize_blockdev_backup('drive0', 'source')
+
+    def test_target_resize_blockdev_backup(self):
+        self.do_test_resize_blockdev_backup('drive1', 'target')
+
+    def do_test_target_size(self, size):
+        result =3D self.vm.qmp('block_resize', device=3D'drive1', size=3Ds=
ize)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-backup', job_id=3D'job0', device=
=3D'drive0',
+                             target=3D'drive1', sync=3D'full')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+    def test_small_target(self):
+        self.do_test_target_size(image_len // 2)
+
+    def test_large_target(self):
+        self.do_test_target_size(image_len * 2)
+
     def test_medium_not_found(self):
         if iotests.qemu_default_machine !=3D 'pc':
             return
diff --git a/tests/qemu-iotests/055.out b/tests/qemu-iotests/055.out
index 5ce2f9a2ed..88bf7fa73a 100644
--- a/tests/qemu-iotests/055.out
+++ b/tests/qemu-iotests/055.out
@@ -1,5 +1,5 @@
-..............................
+..................................
 ----------------------------------------------------------------------
-Ran 30 tests
+Ran 34 tests
=20
 OK
--=20
2.25.3


