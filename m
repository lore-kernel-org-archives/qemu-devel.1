Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1AC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836D9205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836D9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPVY-00081J-OC
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQv-0004HU-8I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQr-0008Ge-Ci
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPQT-0007YP-Hn; Sun, 05 May 2019 18:16:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2BF9C05E760;
	Sun,  5 May 2019 22:16:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 620FE7C386;
	Sun,  5 May 2019 22:16:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:33 +0200
Message-Id: <20190505221544.31568-3-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Sun, 05 May 2019 22:16:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/13] tests/pflash-cfi02: Use the GLib API
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505221533.dHDevDno4B8IkhTq_ii0Cv_7Iyys6eykpn259-a0nAg@z>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/pflash-cfi02-test.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 40af1bb523e..ff775618c02 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -35,8 +35,6 @@
 #define UNLOCK_BYPASS_CMD 0x20
 #define UNLOCK_BYPASS_RESET_CMD 0x00
=20
-static char image_path[] =3D "/tmp/qtest.XXXXXX";
-
 static inline void flash_write(uint64_t byte_addr, uint16_t data)
 {
     qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
@@ -103,8 +101,9 @@ static void chip_erase(void)
     flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
 }
=20
-static void test_flash(void)
+static void test_flash(const void *opaque)
 {
+    const char *image_path =3D opaque;
     global_qtest =3D qtest_initf("-M musicpal,accel=3Dqtest "
                                "-drive if=3Dpflash,file=3D%s,format=3Dra=
w,copy-on-read",
                                image_path);
@@ -195,31 +194,30 @@ static void test_flash(void)
=20
 static void cleanup(void *opaque)
 {
+    char *image_path =3D opaque;
     unlink(image_path);
+    g_free(image_path);
 }
=20
 int main(int argc, char **argv)
 {
-    int fd =3D mkstemp(image_path);
-    if (fd =3D=3D -1) {
-        g_printerr("Failed to create temporary file %s: %s\n", image_pat=
h,
-                   strerror(errno));
-        exit(EXIT_FAILURE);
-    }
+    GError *error =3D NULL;
+    char *image_path;
+    int fd =3D g_file_open_tmp("pflash-cfi02-XXXXXX.raw", &image_path, &=
error);
+    g_assert_no_error(error);
     if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
-        int error_code =3D errno;
+        g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_pat=
h,
+                   strerror(errno));
         close(fd);
         unlink(image_path);
-        g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_pat=
h,
-                   strerror(error_code));
         exit(EXIT_FAILURE);
     }
     close(fd);
=20
-    qtest_add_abrt_handler(cleanup, NULL);
+    qtest_add_abrt_handler(cleanup, image_path);
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("pflash-cfi02", test_flash);
+    qtest_add_data_func("pflash-cfi02", image_path, test_flash);
     int result =3D g_test_run();
-    cleanup(NULL);
+    cleanup(image_path);
     return result;
 }
--=20
2.20.1


