Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B2CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3EB2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeJK+Lgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3EB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3zZ-0005NA-00
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vf-0001JL-VK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vd-0001FQ-RQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vd-0001F0-ON
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pjfgNJz2k72QEAD4z+ODEgWsNy3o8hO+FNn9sL+rQI=;
 b=WeJK+LgqW4XofimM5WRZTZ9DE5zKyboEGMUS0fjNr9/Yubhe0J382sPOCc02AFcnWEvv8W
 X7kagaqHYA6NR5wEJ7O64qMK5org4gkFVFQOb3JjWkHdwfnViDpGQyrpyfY7/+kCMkicBo
 c7Ppu4yn/6G29vaVY1bVCB6muJDg8Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-77lUsRrcMeuFOCK66w99Ig-1; Mon, 28 Oct 2019 08:15:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 659CA10052E0;
 Mon, 28 Oct 2019 12:15:16 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0987C5DA8C;
 Mon, 28 Oct 2019 12:15:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/69] iotests: Test driver whitelisting in 136
Date: Mon, 28 Oct 2019 13:13:58 +0100
Message-Id: <20191028121501.15279-7-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 77lUsRrcMeuFOCK66w99Ig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  Skip all test cases that require it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190917092004.999-7-mreitz@redhat.com
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/136 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index a46a7b7630..012ea111ac 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -30,7 +30,7 @@ bad_offset =3D bad_sector * 512
 blkdebug_file =3D os.path.join(iotests.test_dir, 'blkdebug.conf')
=20
 class BlockDeviceStatsTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     total_rd_bytes =3D 0
     total_rd_ops =3D 0
     total_wr_bytes =3D 0
@@ -67,6 +67,10 @@ sector =3D "%d"
 ''' % (bad_sector, bad_sector))
         file.close()
=20
+    def required_drivers(self):
+        return [self.test_driver]
+
+    @iotests.skip_if_unsupported(required_drivers)
     def setUp(self):
         drive_args =3D []
         drive_args.append("stats-intervals.0=3D%d" % interval_length)
@@ -76,8 +80,8 @@ sector =3D "%d"
                           (self.account_failed and "on" or "off"))
         drive_args.append("file.image.read-zeroes=3Don")
         self.create_blkdebug_file()
-        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s' %
-                                         (blkdebug_file, self.test_img),
+        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s://' %
+                                         (blkdebug_file, self.test_driver)=
,
                                          ','.join(drive_args))
         self.vm.launch()
         # Set an initial value for the clock
@@ -337,7 +341,9 @@ class BlockDeviceStatsTestAccountBoth(BlockDeviceStatsT=
estCase):
     account_failed =3D True
=20
 class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in iotests.supported_formats():
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0


