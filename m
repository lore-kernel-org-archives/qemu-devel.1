Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022p-Ra
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003KT-0r
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Jf-RV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:40 +0000
Message-Id: <20180215175044.8159-4-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] io: Fix QIOChannelFile when creating and
 opening read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

The code wrongly passes the mode to open() only if O_WRONLY is set.
Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
Linux). Fix this by always passing the mode since open() will correctly
ignore the mode if it is not needed. Add a testcase which exercises this
bug and also change the existing testcase to check that the mode of the
created file is correct.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel-file.h    |  2 +-
 io/channel-file.c            |  6 +-----
 tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index 79245f1183..ebfe54ec70 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -73,7 +73,7 @@ qio_channel_file_new_fd(int fd);
  * qio_channel_file_new_path:
  * @path: the file path
  * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
- * @mode: the file creation mode if O_WRONLY is set in @flags
+ * @mode: the file creation mode if O_CREAT is set in @flags
  * @errp: pointer to initialized error object
  *
  * Create a new IO channel object for a file represented
diff --git a/io/channel-file.c b/io/channel-file.c
index b383273201..16bf7ed270 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -50,11 +50,7 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    if (flags & O_WRONLY) {
-        ioc->fd = open(path, flags, mode);
-    } else {
-        ioc->fd = open(path, flags);
-    }
+    ioc->fd = open(path, flags, mode);
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
         error_setg_errno(errp, errno,
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 6bfede6bb7..2e94f638f2 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -24,16 +24,21 @@
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
 
-static void test_io_channel_file(void)
+#define TEST_FILE "tests/test-io-channel-file.txt"
+#define TEST_MASK 0600
+
+static void test_io_channel_file_helper(int flags)
 {
     QIOChannel *src, *dst;
     QIOChannelTest *test;
+    struct stat st;
+    mode_t mask;
+    int ret;
 
-#define TEST_FILE "tests/test-io-channel-file.txt"
     unlink(TEST_FILE);
     src = QIO_CHANNEL(qio_channel_file_new_path(
                           TEST_FILE,
-                          O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600,
+                          flags, TEST_MASK,
                           &error_abort));
     dst = QIO_CHANNEL(qio_channel_file_new_path(
                           TEST_FILE,
@@ -45,18 +50,33 @@ static void test_io_channel_file(void)
     qio_channel_test_run_reader(test, dst);
     qio_channel_test_validate(test);
 
+    /* Check that the requested mode took effect. */
+    mask = umask(0);
+    umask(mask);
+    ret = stat(TEST_FILE, &st);
+    g_assert_cmpint(ret, >, -1);
+    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0777);
+
     unlink(TEST_FILE);
     object_unref(OBJECT(src));
     object_unref(OBJECT(dst));
 }
 
+static void test_io_channel_file(void)
+{
+    test_io_channel_file_helper(O_WRONLY | O_CREAT | O_TRUNC | O_BINARY);
+}
+
+static void test_io_channel_file_rdwr(void)
+{
+    test_io_channel_file_helper(O_RDWR | O_CREAT | O_TRUNC | O_BINARY);
+}
 
 static void test_io_channel_fd(void)
 {
     QIOChannel *ioc;
     int fd = -1;
 
-#define TEST_FILE "tests/test-io-channel-file.txt"
     fd = open(TEST_FILE, O_CREAT | O_TRUNC | O_WRONLY, 0600);
     g_assert_cmpint(fd, >, -1);
 
@@ -114,6 +134,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/io/channel/file", test_io_channel_file);
+    g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
     g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
 #ifndef _WIN32
     g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
-- 
2.14.3
