Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B05C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9E0216FD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9E0216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZom-0007Tj-JH
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:10:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZmx-00068u-5D
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZbk-00064e-Aa
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRZbi-00060H-Pq; Fri, 17 May 2019 05:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17DDC307D96F;
	Fri, 17 May 2019 09:56:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1F4348F5;
	Fri, 17 May 2019 09:56:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 11:56:28 +0200
Message-Id: <20190517095628.10119-5-mreitz@redhat.com>
In-Reply-To: <20190517095628.10119-1-mreitz@redhat.com>
References: <20190517095628.10119-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 17 May 2019 09:56:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] iotests: Test driver whitelisting in 136
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  If it is not, fall back to null-co.
This may run tests twice in the same configuration, but this is the
simplest way to effectively skip the tests in setUp() (without changing
the output, and while having the respective driver in a class
attribute).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/136 | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index af7ffa4540..44e3bc1575 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -28,9 +28,11 @@ op_latency =3D nsec_per_sec // 1000 # See qtest_latenc=
y_ns in accounting.c
 bad_sector =3D 8192
 bad_offset =3D bad_sector * 512
 blkdebug_file =3D os.path.join(iotests.test_dir, 'blkdebug.conf')
+supported_null_drivers =3D list(filter(lambda f: f.startswith('null-'),
+                                     iotests.supported_formats()))
=20
 class BlockDeviceStatsTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     total_rd_bytes =3D 0
     total_rd_ops =3D 0
     total_wr_bytes =3D 0
@@ -68,6 +70,11 @@ sector =3D "%d"
         file.close()
=20
     def setUp(self):
+        global supported_null_drivers
+        if self.test_driver not in supported_null_drivers:
+            # Silently fall back to supported driver
+            self.test_driver =3D supported_null_drivers[0]
+
         drive_args =3D []
         drive_args.append("stats-intervals.0=3D%d" % interval_length)
         drive_args.append("stats-account-invalid=3D%s" %
@@ -75,8 +82,8 @@ sector =3D "%d"
         drive_args.append("stats-account-failed=3D%s" %
                           (self.account_failed and "on" or "off"))
         self.create_blkdebug_file()
-        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s' %
-                                         (blkdebug_file, self.test_img),
+        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s://' %
+                                         (blkdebug_file, self.test_drive=
r),
                                          ','.join(drive_args))
         self.vm.launch()
         # Set an initial value for the clock
@@ -336,7 +343,9 @@ class BlockDeviceStatsTestAccountBoth(BlockDeviceStat=
sTestCase):
     account_failed =3D True
=20
 class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in supported_null_drivers:
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0


