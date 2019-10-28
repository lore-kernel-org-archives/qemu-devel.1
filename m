Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697DCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3057720717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBI9lVCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3057720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP43F-0003Up-Uz
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vh-0001K3-T5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vf-0001GG-VI
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vf-0001FY-Qv
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6HzeEpFuvx1s/KTUCZtpigth3fiHipwxY43BzIrOrA=;
 b=ZBI9lVCuphdvWLGeXHR0Ut3w1r1Dy202lg/8Csh2QOxfYSnmb5mkxE6TaA5pznGwjopGgq
 CEn4xJxOM9A9W3+l4+bItZQr/4Dw+8ewFbFKG5Mv/m2X2PHQ4F3rLcgEO+mSLtxXw6rWRM
 OQ3NeJPlsb+87J5JshD0yIV8oxO3kos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-a0n2Vi_aN4-Apw-U4dIW4w-1; Mon, 28 Oct 2019 08:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5790180183E;
 Mon, 28 Oct 2019 12:15:14 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E601926186;
 Mon, 28 Oct 2019 12:15:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/69] iotests: Test driver whitelisting in 093
Date: Mon, 28 Oct 2019 13:13:57 +0100
Message-Id: <20191028121501.15279-6-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: a0n2Vi_aN4-Apw-U4dIW4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  Skip all test cases that require it.

(And skip the whole test if null-co is not whitelisted.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190917092004.999-6-mreitz@redhat.com
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/093 | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 50c1e7f2ec..f03fa24a07 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -24,7 +24,7 @@ import iotests
 nsec_per_sec =3D 1000000000
=20
 class ThrottleTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     max_drives =3D 3
=20
     def blockstats(self, device):
@@ -35,10 +35,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
                 return stat['rd_bytes'], stat['rd_operations'], stat['wr_b=
ytes'], stat['wr_operations']
         raise Exception("Device not found for blockstats: %s" % device)
=20
+    def required_drivers(self):
+        return [self.test_driver]
+
+    @iotests.skip_if_unsupported(required_drivers)
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img, "file.read-zeroes=3Don")
+            self.vm.add_drive(self.test_driver + "://", "file.read-zeroes=
=3Don")
         self.vm.launch()
=20
     def tearDown(self):
@@ -264,7 +268,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         self.assertEqual(self.blockstats('drive1')[0], 4096)
=20
 class ThrottleTestCoroutine(ThrottleTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 class ThrottleTestGroupNames(iotests.QMPTestCase):
     max_drives =3D 3
@@ -425,4 +429,6 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
=20
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in iotests.supported_formats():
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0


