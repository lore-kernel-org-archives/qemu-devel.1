Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5957C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC8321773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC8321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2U1-00040C-O3
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:59:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PR-0000F2-Lg
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PQ-0004qb-Cl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2PQ-0004pC-4d
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76EE93001802;
	Tue, 21 May 2019 10:54:10 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46FBD6085B;
	Tue, 21 May 2019 10:54:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:39 +0200
Message-Id: <20190521105344.11637-9-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 21 May 2019 10:54:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/13] tests/hd-geo-test: Use qtest_init()
 instead of qtest_start()
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
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run.
Use qtest_init() and qtest_quit() instead.

Message-Id: <20190515174328.16361-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/hd-geo-test.c | 76 ++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index ce665f1f83..62eb624726 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -77,33 +77,35 @@ static bool is_hd(const CHST *expected_chst)
     return expected_chst && expected_chst->cyls;
 }
=20
-static void test_cmos_byte(int reg, int expected)
+static void test_cmos_byte(QTestState *qts, int reg, int expected)
 {
     enum { cmos_base =3D 0x70 };
     int actual;
=20
-    outb(cmos_base + 0, reg);
-    actual =3D inb(cmos_base + 1);
+    qtest_outb(qts, cmos_base + 0, reg);
+    actual =3D qtest_inb(qts, cmos_base + 1);
     g_assert(actual =3D=3D expected);
 }
=20
-static void test_cmos_bytes(int reg0, int n, uint8_t expected[])
+static void test_cmos_bytes(QTestState *qts, int reg0, int n,
+                            uint8_t expected[])
 {
     int i;
=20
     for (i =3D 0; i < 9; i++) {
-        test_cmos_byte(reg0 + i, expected[i]);
+        test_cmos_byte(qts, reg0 + i, expected[i]);
     }
 }
=20
-static void test_cmos_disk_data(void)
+static void test_cmos_disk_data(QTestState *qts)
 {
-    test_cmos_byte(0x12,
+    test_cmos_byte(qts, 0x12,
                    (is_hd(cur_ide[0]) ? 0xf0 : 0) |
                    (is_hd(cur_ide[1]) ? 0x0f : 0));
 }
=20
-static void test_cmos_drive_cyl(int reg0, const CHST *expected_chst)
+static void test_cmos_drive_cyl(QTestState *qts, int reg0,
+                                const CHST *expected_chst)
 {
     if (is_hd(expected_chst)) {
         int c =3D expected_chst->cyls;
@@ -113,29 +115,29 @@ static void test_cmos_drive_cyl(int reg0, const CHS=
T *expected_chst)
             c & 0xff, c >> 8, h, 0xff, 0xff, 0xc0 | ((h > 8) << 3),
             c & 0xff, c >> 8, s
         };
-        test_cmos_bytes(reg0, 9, expected_bytes);
+        test_cmos_bytes(qts, reg0, 9, expected_bytes);
     } else {
         int i;
=20
         for (i =3D 0; i < 9; i++) {
-            test_cmos_byte(reg0 + i, 0);
+            test_cmos_byte(qts, reg0 + i, 0);
         }
     }
 }
=20
-static void test_cmos_drive1(void)
+static void test_cmos_drive1(QTestState *qts)
 {
-    test_cmos_byte(0x19, is_hd(cur_ide[0]) ? 47 : 0);
-    test_cmos_drive_cyl(0x1b, cur_ide[0]);
+    test_cmos_byte(qts, 0x19, is_hd(cur_ide[0]) ? 47 : 0);
+    test_cmos_drive_cyl(qts, 0x1b, cur_ide[0]);
 }
=20
-static void test_cmos_drive2(void)
+static void test_cmos_drive2(QTestState *qts)
 {
-    test_cmos_byte(0x1a, is_hd(cur_ide[1]) ? 47 : 0);
-    test_cmos_drive_cyl(0x24, cur_ide[1]);
+    test_cmos_byte(qts, 0x1a, is_hd(cur_ide[1]) ? 47 : 0);
+    test_cmos_drive_cyl(qts, 0x24, cur_ide[1]);
 }
=20
-static void test_cmos_disktransflag(void)
+static void test_cmos_disktransflag(QTestState *qts)
 {
     int val, i;
=20
@@ -145,15 +147,15 @@ static void test_cmos_disktransflag(void)
             val |=3D cur_ide[i]->trans << (2 * i);
         }
     }
-    test_cmos_byte(0x39, val);
+    test_cmos_byte(qts, 0x39, val);
 }
=20
-static void test_cmos(void)
+static void test_cmos(QTestState *qts)
 {
-    test_cmos_disk_data();
-    test_cmos_drive1();
-    test_cmos_drive2();
-    test_cmos_disktransflag();
+    test_cmos_disk_data(qts);
+    test_cmos_drive1(qts);
+    test_cmos_drive2(qts);
+    test_cmos_disktransflag(qts);
 }
=20
 static int append_arg(int argc, char *argv[], int argv_sz, char *arg)
@@ -238,14 +240,15 @@ static void test_ide_none(void)
 {
     char **argv =3D g_new0(char *, ARGV_SIZE);
     char *args;
+    QTestState *qts;
=20
     setup_common(argv, ARGV_SIZE);
     args =3D g_strjoinv(" ", argv);
-    qtest_start(args);
+    qts =3D qtest_init(args);
     g_strfreev(argv);
     g_free(args);
-    test_cmos();
-    qtest_end();
+    test_cmos(qts);
+    qtest_quit(qts);
 }
=20
 static void test_ide_mbr(bool use_device, MBRcontents mbr)
@@ -255,6 +258,7 @@ static void test_ide_mbr(bool use_device, MBRcontents=
 mbr)
     int argc;
     Backend i;
     const char *dev;
+    QTestState *qts;
=20
     argc =3D setup_common(argv, ARGV_SIZE);
     for (i =3D 0; i < backend_last; i++) {
@@ -263,11 +267,11 @@ static void test_ide_mbr(bool use_device, MBRconten=
ts mbr)
         argc =3D setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr);
     }
     args =3D g_strjoinv(" ", argv);
-    qtest_start(args);
+    qts =3D qtest_init(args);
     g_strfreev(argv);
     g_free(args);
-    test_cmos();
-    qtest_end();
+    test_cmos(qts);
+    qtest_quit(qts);
 }
=20
 /*
@@ -325,6 +329,7 @@ static void test_ide_drive_user(const char *dev, bool=
 trans)
     int argc;
     int secs =3D img_secs[backend_small];
     const CHST expected_chst =3D { secs / (4 * 32) , 4, 32, trans };
+    QTestState *qts;
=20
     argc =3D setup_common(argv, ARGV_SIZE);
     opts =3D g_strdup_printf("%s,%scyls=3D%d,heads=3D%d,secs=3D%d",
@@ -335,11 +340,11 @@ static void test_ide_drive_user(const char *dev, bo=
ol trans)
     argc =3D setup_ide(argc, argv, ARGV_SIZE, 0, opts, backend_small, mb=
r_chs);
     g_free(opts);
     args =3D g_strjoinv(" ", argv);
-    qtest_start(args);
+    qts =3D qtest_init(args);
     g_strfreev(argv);
     g_free(args);
-    test_cmos();
-    qtest_end();
+    test_cmos(qts);
+    qtest_quit(qts);
 }
=20
 /*
@@ -367,6 +372,7 @@ static void test_ide_drive_cd_0(void)
     char *args;
     int argc, ide_idx;
     Backend i;
+    QTestState *qts;
=20
     argc =3D setup_common(argv, ARGV_SIZE);
     for (i =3D 0; i <=3D backend_empty; i++) {
@@ -375,11 +381,11 @@ static void test_ide_drive_cd_0(void)
         argc =3D setup_ide(argc, argv, ARGV_SIZE, ide_idx, NULL, i, mbr_=
blank);
     }
     args =3D g_strjoinv(" ", argv);
-    qtest_start(args);
+    qts =3D qtest_init(args);
     g_strfreev(argv);
     g_free(args);
-    test_cmos();
-    qtest_end();
+    test_cmos(qts);
+    qtest_quit(qts);
 }
=20
 int main(int argc, char **argv)
--=20
2.21.0


