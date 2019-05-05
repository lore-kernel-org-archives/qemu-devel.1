Received: from eggs.gnu.org ([209.51.188.92]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQv-0004HU-8I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQr-0008Ge-Ci
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:31 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:33 +0200
Message-Id: <20190505221544.31568-3-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/13] tests/pflash-cfi02: Use the GLib API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
