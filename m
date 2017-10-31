Received: from eggs.gnu.org ([2001:4830:134:3::10]:55086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47063d443=ross.lagerwall@citrix.com>)
	id 1e9Z7h-0002At-3B
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47063d443=ross.lagerwall@citrix.com>)
	id 1e9Z7a-00067M-RE
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:10:39 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:26517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47063d443=ross.lagerwall@citrix.com>)
	id 1e9Z7a-00066Q-Kr
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:10:34 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 31 Oct 2017 16:09:02 +0000
Message-ID: <20171031160902.6874-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] io: Fix QIOChannelFile when creating and
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

The code wrongly passes the mode to open() only if O_WRONLY is set.
Instead, the mode should be passed when O_CREAT is set (or O_TMPFILE on
Linux). Fix this by always passing the mode since open() will correctly
ignore the mode if it is not needed. Add a testcase which exercises this
bug.

While at it, add /dev/fdset/ support to QIOChannelFile by calling
qemu_open() instead open(). There is a subtle semantic change since
qemu_open() automatically sets O_CLOEXEC, but this doesn't affect any of
the users of the function.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 include/io/channel-file.h    |  2 +-
 io/channel-file.c            |  6 +-----
 tests/test-io-channel-file.c | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

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
index b383273..ae8fb62 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -50,11 +50,7 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    if (flags & O_WRONLY) {
-        ioc->fd = open(path, flags, mode);
-    } else {
-        ioc->fd = open(path, flags);
-    }
+    ioc->fd = qemu_open(path, flags, mode);
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
         error_setg_errno(errp, errno,
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 6bfede6..0c7303d 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -50,6 +50,32 @@ static void test_io_channel_file(void)
     object_unref(OBJECT(dst));
 }
 
+static void test_io_channel_file_rdwr(void)
+{
+    QIOChannel *src, *dst;
+    QIOChannelTest *test;
+
+#define TEST_FILE "tests/test-io-channel-file.txt"
+    unlink(TEST_FILE);
+    src = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDWR | O_CREAT | O_TRUNC | O_BINARY, 0600,
+                          &error_abort));
+    dst = QIO_CHANNEL(qio_channel_file_new_path(
+                          TEST_FILE,
+                          O_RDONLY | O_BINARY, 0,
+                          &error_abort));
+
+    test = qio_channel_test_new();
+    qio_channel_test_run_writer(test, src);
+    qio_channel_test_run_reader(test, dst);
+    qio_channel_test_validate(test);
+
+    unlink(TEST_FILE);
+    object_unref(OBJECT(src));
+    object_unref(OBJECT(dst));
+}
+
 
 static void test_io_channel_fd(void)
 {
@@ -114,6 +140,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/io/channel/file", test_io_channel_file);
+    g_test_add_func("/io/channel/file/rdwr", test_io_channel_file_rdwr);
     g_test_add_func("/io/channel/file/fd", test_io_channel_fd);
 #ifndef _WIN32
     g_test_add_func("/io/channel/pipe/sync", test_io_channel_pipe_sync);
-- 
2.9.5
