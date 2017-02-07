Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CT-0007v5-LZ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6CS-00085E-FJ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6CS-00084p-7q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:52 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E412C04B952
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:53 +0400
Message-Id: <20170207135211.15870-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/28] tests: fix hd-geo-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/hd-geo-test.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 6176e81ab2..88f8d76d32 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -19,6 +19,8 @@
 #include "qemu-common.h"
 #include "libqtest.h"
=20
+#define ARGV_SIZE 256
+
 static char *create_test_img(int secs)
 {
     char *template =3D strdup("/tmp/qtest.XXXXXX");
@@ -66,7 +68,7 @@ static const CHST hd_chst[backend_last][mbr_last] =3D {
     },
 };
=20
-static const char *img_file_name[backend_last];
+static char *img_file_name[backend_last];
=20
 static const CHST *cur_ide[4];
=20
@@ -234,28 +236,34 @@ static int setup_ide(int argc, char *argv[], int ar=
gv_sz,
  */
 static void test_ide_none(void)
 {
-    char *argv[256];
+    char **argv =3D g_new0(char *, ARGV_SIZE);
+    char *tmp;
=20
-    setup_common(argv, ARRAY_SIZE(argv));
-    qtest_start(g_strjoinv(" ", argv));
+    setup_common(argv, ARGV_SIZE);
+    qtest_start(tmp =3D g_strjoinv(" ", argv));
+    g_strfreev(argv);
+    g_free(tmp);
     test_cmos();
     qtest_end();
 }
=20
 static void test_ide_mbr(bool use_device, MBRcontents mbr)
 {
-    char *argv[256];
+    char **argv =3D g_new0(char *, ARGV_SIZE);
+    char *tmp;
     int argc;
     Backend i;
     const char *dev;
=20
-    argc =3D setup_common(argv, ARRAY_SIZE(argv));
+    argc =3D setup_common(argv, ARGV_SIZE);
     for (i =3D 0; i < backend_last; i++) {
         cur_ide[i] =3D &hd_chst[i][mbr];
         dev =3D use_device ? (is_hd(cur_ide[i]) ? "ide-hd" : "ide-cd") :=
 NULL;
-        argc =3D setup_ide(argc, argv, ARRAY_SIZE(argv), i, dev, i, mbr,=
 "");
+        argc =3D setup_ide(argc, argv, ARGV_SIZE, i, dev, i, mbr, "");
     }
-    qtest_start(g_strjoinv(" ", argv));
+    qtest_start(tmp =3D g_strjoinv(" ", argv));
+    g_strfreev(argv);
+    g_free(tmp);
     test_cmos();
     qtest_end();
 }
@@ -310,12 +318,13 @@ static void test_ide_device_mbr_chs(void)
=20
 static void test_ide_drive_user(const char *dev, bool trans)
 {
-    char *argv[256], *opts;
+    char **argv =3D g_new0(char *, ARGV_SIZE);
+    char *tmp, *opts;
     int argc;
     int secs =3D img_secs[backend_small];
     const CHST expected_chst =3D { secs / (4 * 32) , 4, 32, trans };
=20
-    argc =3D setup_common(argv, ARRAY_SIZE(argv));
+    argc =3D setup_common(argv, ARGV_SIZE);
     opts =3D g_strdup_printf("%s,%s%scyls=3D%d,heads=3D%d,secs=3D%d",
                            dev ?: "",
                            trans && dev ? "bios-chs-" : "",
@@ -323,11 +332,13 @@ static void test_ide_drive_user(const char *dev, bo=
ol trans)
                            expected_chst.cyls, expected_chst.heads,
                            expected_chst.secs);
     cur_ide[0] =3D &expected_chst;
-    argc =3D setup_ide(argc, argv, ARRAY_SIZE(argv),
+    argc =3D setup_ide(argc, argv, ARGV_SIZE,
                      0, dev ? opts : NULL, backend_small, mbr_chs,
                      dev ? "" : opts);
     g_free(opts);
-    qtest_start(g_strjoinv(" ", argv));
+    qtest_start(tmp =3D g_strjoinv(" ", argv));
+    g_strfreev(argv);
+    g_free(tmp);
     test_cmos();
     qtest_end();
 }
@@ -369,18 +380,21 @@ static void test_ide_device_user_chst(void)
  */
 static void test_ide_drive_cd_0(void)
 {
-    char *argv[256];
+    char **argv =3D g_new0(char *, ARGV_SIZE);
+    char *tmp;
     int argc, ide_idx;
     Backend i;
=20
-    argc =3D setup_common(argv, ARRAY_SIZE(argv));
+    argc =3D setup_common(argv, ARGV_SIZE);
     for (i =3D 0; i <=3D backend_empty; i++) {
         ide_idx =3D backend_empty - i;
         cur_ide[ide_idx] =3D &hd_chst[i][mbr_blank];
-        argc =3D setup_ide(argc, argv, ARRAY_SIZE(argv),
+        argc =3D setup_ide(argc, argv, ARGV_SIZE,
                          ide_idx, NULL, i, mbr_blank, "");
     }
-    qtest_start(g_strjoinv(" ", argv));
+    qtest_start(tmp =3D g_strjoinv(" ", argv));
+    g_strfreev(argv);
+    g_free(tmp);
     test_cmos();
     qtest_end();
 }
@@ -418,6 +432,7 @@ int main(int argc, char **argv)
     for (i =3D 0; i < backend_last; i++) {
         if (img_file_name[i]) {
             unlink(img_file_name[i]);
+            free(img_file_name[i]);
         }
     }
=20
--=20
2.11.0.295.gd7dffce1c.dirty
