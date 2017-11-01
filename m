Received: from eggs.gnu.org ([2001:4830:134:3::10]:37731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1f-0005WS-Ah
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00084i-PU
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:45989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00083e-Bh
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:47 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 1 Nov 2017 14:25:24 +0000
Message-ID: <20171101142526.1006-3-ross.lagerwall@citrix.com>
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/4] io: Fix QIOChannelFile when creating
 and opening read-write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P. Berrange" <berrange@redhat.com>

The code wrongly passes the mode to open() only if O_WRONLY is set.
Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
Linux). Fix this by always passing the mode since open() will correctly
ignore the mode if it is not needed. Add a testcase which exercises this
bug and also change the existing testcase to check that the mode of the
created file is correct.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
Changed in v2:
* Separated from qemu_open() change.

 include/io/channel-file.h    |  2 +-
 io/channel-file.c            |  6 +-----
 tests/test-io-channel-file.c | 29 +++++++++++++++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index 79245f1..ebfe54e 100644
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
index b383273..16bf7ed 100644
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
index 6bfede6..2e94f63 100644
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
2.9.5
