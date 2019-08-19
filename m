Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFAC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5581622CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5581622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkXK-0000vu-D1
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkMF-0003MZ-03
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkMD-0006Y0-AB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkM6-0006SS-NQ; Mon, 19 Aug 2019 12:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D39A93001834;
 Mon, 19 Aug 2019 16:17:58 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B7A79A060;
 Mon, 19 Aug 2019 16:17:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:18 +0200
Message-Id: <20190819161723.7746-13-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 19 Aug 2019 16:17:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/17] iotests: Full mirror to existing non-zero
 image
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The result of a sync=3Dfull mirror should always be the equal to the
input.  Therefore, existing images should be treated as potentially
non-zero and thus should be explicitly initialized to be zero
beforehand.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190724171239.8764-12-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 62 +++++++++++++++++++++++++++++++++++---
 tests/qemu-iotests/041.out |  4 +--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 26bf1701eb..8bc8f81db7 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -741,8 +741,15 @@ class TestUnbackedSource(iotests.QMPTestCase):
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, test_img,
                  str(TestUnbackedSource.image_len))
-        self.vm =3D iotests.VM().add_drive(test_img)
+        self.vm =3D iotests.VM()
         self.vm.launch()
+        result =3D self.vm.qmp('blockdev-add', node_name=3D'drive0',
+                             driver=3Diotests.imgfmt,
+                             file=3D{
+                                 'driver': 'file',
+                                 'filename': test_img,
+                             })
+        self.assert_qmp(result, 'return', {})
=20
     def tearDown(self):
         self.vm.shutdown()
@@ -751,7 +758,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
=20
     def test_absolute_paths_full(self):
         self.assert_no_active_block_jobs()
-        result =3D self.vm.qmp('drive-mirror', device=3D'drive0',
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'drive0', device=
=3D'drive0',
                              sync=3D'full', target=3Dtarget_img,
                              mode=3D'absolute-paths')
         self.assert_qmp(result, 'return', {})
@@ -760,7 +767,7 @@ class TestUnbackedSource(iotests.QMPTestCase):
=20
     def test_absolute_paths_top(self):
         self.assert_no_active_block_jobs()
-        result =3D self.vm.qmp('drive-mirror', device=3D'drive0',
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'drive0', device=
=3D'drive0',
                              sync=3D'top', target=3Dtarget_img,
                              mode=3D'absolute-paths')
         self.assert_qmp(result, 'return', {})
@@ -769,13 +776,60 @@ class TestUnbackedSource(iotests.QMPTestCase):
=20
     def test_absolute_paths_none(self):
         self.assert_no_active_block_jobs()
-        result =3D self.vm.qmp('drive-mirror', device=3D'drive0',
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'drive0', device=
=3D'drive0',
                              sync=3D'none', target=3Dtarget_img,
                              mode=3D'absolute-paths')
         self.assert_qmp(result, 'return', {})
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
=20
+    def test_existing_full(self):
+        qemu_img('create', '-f', iotests.imgfmt, target_img,
+                 str(self.image_len))
+        qemu_io('-c', 'write -P 42 0 64k', target_img)
+
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('drive-mirror', job_id=3D'drive0', device=
=3D'drive0',
+                             sync=3D'full', target=3Dtarget_img, mode=3D=
'existing')
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait()
+        self.assert_no_active_block_jobs()
+
+        result =3D self.vm.qmp('blockdev-del', node_name=3D'drive0')
+        self.assert_qmp(result, 'return', {})
+
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirror=
ing')
+
+    def test_blockdev_full(self):
+        qemu_img('create', '-f', iotests.imgfmt, target_img,
+                 str(self.image_len))
+        qemu_io('-c', 'write -P 42 0 64k', target_img)
+
+        result =3D self.vm.qmp('blockdev-add', node_name=3D'target',
+                             driver=3Diotests.imgfmt,
+                             file=3D{
+                                 'driver': 'file',
+                                 'filename': target_img,
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'drive0', dev=
ice=3D'drive0',
+                             sync=3D'full', target=3D'target')
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait()
+        self.assert_no_active_block_jobs()
+
+        result =3D self.vm.qmp('blockdev-del', node_name=3D'drive0')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-del', node_name=3D'target')
+        self.assert_qmp(result, 'return', {})
+
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirror=
ing')
+
 class TestGranularity(iotests.QMPTestCase):
     image_len =3D 10 * 1024 * 1024 # MB
=20
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


