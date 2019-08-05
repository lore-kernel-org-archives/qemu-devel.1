Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1AFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C292064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C292064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug0g-0007cO-WB
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hufzc-0005mU-Cz
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hufzb-0005v2-5w
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:37:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hufzY-0005pG-Fq; Mon, 05 Aug 2019 12:37:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6418307CDFC;
 Mon,  5 Aug 2019 16:37:47 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D0101001B17;
 Mon,  5 Aug 2019 16:37:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 18:37:35 +0200
Message-Id: <20190805163740.23616-3-mreitz@redhat.com>
In-Reply-To: <20190805163740.23616-1-mreitz@redhat.com>
References: <20190805163740.23616-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 05 Aug 2019 16:37:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/7] iotests: Test backup job with two guest
 writes
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

Perform two guest writes to not yet backed up areas of an image, where
the former touches an inner area of the latter.

Before HEAD^, copy offloading broke this in two ways:
(1) The target image differs from the reference image (what the source
    was when the backup started).
(2) But you will not see that in the failing output, because the job
    offset is reported as being greater than the job length.  This is
    because one cluster is copied twice, and thus accounted for twice,
    but of course the job length does not increase.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190801173900.23851-3-mreitz@redhat.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/056     | 39 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out |  4 ++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index f40fc11a09..e761e465ae 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -133,6 +133,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm =3D iotests.VM()
         self.test_img =3D img_create('test')
         self.dest_img =3D img_create('dest')
+        self.ref_img =3D img_create('ref')
         self.vm.add_drive(self.test_img)
         self.vm.launch()
=20
@@ -140,6 +141,7 @@ class BackupTest(iotests.QMPTestCase):
         self.vm.shutdown()
         try_remove(self.test_img)
         try_remove(self.dest_img)
+        try_remove(self.ref_img)
=20
     def hmp_io_writes(self, drive, patterns):
         for pattern in patterns:
@@ -177,6 +179,43 @@ class BackupTest(iotests.QMPTestCase):
             self.assert_qmp(event, 'data/error', qerror)
             return False
=20
+    def test_overlapping_writes(self):
+        # Write something to back up
+        self.hmp_io_writes('drive0', [('42', '0M', '2M')])
+
+        # Create a reference backup
+        self.qmp_backup_and_wait(device=3D'drive0', format=3Diotests.img=
fmt,
+                                 sync=3D'full', target=3Dself.ref_img,
+                                 auto_dismiss=3DFalse)
+        res =3D self.vm.qmp('block-job-dismiss', id=3D'drive0')
+        self.assert_qmp(res, 'return', {})
+
+        # Now to the test backup: We simulate the following guest
+        # writes:
+        # (1) [1M + 64k, 1M + 128k): Afterwards, everything in that
+        #     area should be in the target image, and we must not copy
+        #     it again (because the source image has changed now)
+        #     (64k is the job's cluster size)
+        # (2) [1M, 2M): The backup job must not get overeager.  It
+        #     must copy [1M, 1M + 64k) and [1M + 128k, 2M) separately,
+        #     but not the area in between.
+
+        self.qmp_backup(device=3D'drive0', format=3Diotests.imgfmt, sync=
=3D'full',
+                        target=3Dself.dest_img, speed=3D1, auto_dismiss=3D=
False)
+
+        self.hmp_io_writes('drive0', [('23', '%ik' % (1024 + 64), '64k')=
,
+                                      ('66', '1M', '1M')])
+
+        # Let the job complete
+        res =3D self.vm.qmp('block-job-set-speed', device=3D'drive0', sp=
eed=3D0)
+        self.assert_qmp(res, 'return', {})
+        self.qmp_backup_wait('drive0')
+        res =3D self.vm.qmp('block-job-dismiss', id=3D'drive0')
+        self.assert_qmp(res, 'return', {})
+
+        self.assertTrue(iotests.compare_images(self.ref_img, self.dest_i=
mg),
+                        'target image does not match reference image')
+
     def test_dismiss_false(self):
         res =3D self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
diff --git a/tests/qemu-iotests/056.out b/tests/qemu-iotests/056.out
index dae404e278..36376bed87 100644
--- a/tests/qemu-iotests/056.out
+++ b/tests/qemu-iotests/056.out
@@ -1,5 +1,5 @@
-.........
+..........
 ----------------------------------------------------------------------
-Ran 9 tests
+Ran 10 tests
=20
 OK
--=20
2.21.0


