Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A767DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805432083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805432083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPBR-0008Fz-G9
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hoPAa-00051O-Qb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hoPAZ-0006OP-LQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hoPAW-0006MD-Tz; Fri, 19 Jul 2019 05:27:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3ECC2A3B66;
 Fri, 19 Jul 2019 09:27:12 +0000 (UTC)
Received: from localhost (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C848F51DF6;
 Fri, 19 Jul 2019 09:27:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 11:26:18 +0200
Message-Id: <20190719092618.24891-11-mreitz@redhat.com>
In-Reply-To: <20190719092618.24891-1-mreitz@redhat.com>
References: <20190719092618.24891-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 19 Jul 2019 09:27:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 10/10] iotests: Test commit with a filter on
 the chain
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before the previous patches, the first case resulted in a failed
assertion (which is noted as qemu receiving a SIGABRT in the test
output), and the second usually triggered a segmentation fault.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/040     | 40 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |  4 ++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index b81133a474..aa0b1847e3 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -92,9 +92,10 @@ class TestSingleDrive(ImageCommitTestCase):
=20
         self.vm.add_device("scsi-hd,id=3Dscsi0,drive=3Ddrive0")
         self.vm.launch()
+        self.has_quit =3D False
=20
     def tearDown(self):
-        self.vm.shutdown()
+        self.vm.shutdown(has_quit=3Dself.has_quit)
         os.remove(test_img)
         os.remove(mid_img)
         os.remove(backing_img)
@@ -109,6 +110,43 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 =
524288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 52=
4288 524288', backing_img).find("verification failed"))
=20
+    def test_commit_with_filter_and_quit(self):
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        # Add a filter outside of the backing chain
+        result =3D self.vm.qmp('blockdev-add', driver=3D'throttle', node=
_name=3D'filter', throttle_group=3D'tg', file=3D'mid')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('block-commit', device=3D'drive0')
+        self.assert_qmp(result, 'return', {})
+
+        # Quit immediately, thus forcing a simultaneous cancel of the
+        # block job and a bdrv_drain_all()
+        result =3D self.vm.qmp('quit')
+        self.assert_qmp(result, 'return', {})
+
+        self.has_quit =3D True
+
+    # Same as above, but this time we add the filter after starting the =
job
+    def test_commit_plus_filter_and_quit(self):
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('block-commit', device=3D'drive0')
+        self.assert_qmp(result, 'return', {})
+
+        # Add a filter outside of the backing chain
+        result =3D self.vm.qmp('blockdev-add', driver=3D'throttle', node=
_name=3D'filter', throttle_group=3D'tg', file=3D'mid')
+        self.assert_qmp(result, 'return', {})
+
+        # Quit immediately, thus forcing a simultaneous cancel of the
+        # block job and a bdrv_drain_all()
+        result =3D self.vm.qmp('quit')
+        self.assert_qmp(result, 'return', {})
+
+        self.has_quit =3D True
+
     def test_device_not_found(self):
         result =3D self.vm.qmp('block-commit', device=3D'nonexistent', t=
op=3D'%s' % mid_img)
         self.assert_qmp(result, 'error/class', 'DeviceNotFound')
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 802ffaa0c0..220a5fa82c 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...........................................
+...............................................
 ----------------------------------------------------------------------
-Ran 43 tests
+Ran 47 tests
=20
 OK
--=20
2.21.0


