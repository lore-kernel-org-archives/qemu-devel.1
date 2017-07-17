Received: from eggs.gnu.org ([2001:4830:134:3::10]:45979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6Ia-0003o1-Gr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IZ-0005Kf-1J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6IY-0005KN-OC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA21F356D4
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:42:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:24 +0200
Message-Id: <20170717134238.1966-4-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/17] qio: Create new qio_channel_{readv,
 writev}_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

The functions waits until it is able to write the full iov.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Add tests.
---
 include/io/channel.h           | 46 +++++++++++++++++++++++++
 io/channel.c                   | 76 ++++++++++++++++++++++++++++++++++++++++++
 migration/qemu-file-channel.c  | 29 +---------------
 tests/io-channel-helpers.c     | 55 ++++++++++++++++++++++++++++++
 tests/io-channel-helpers.h     |  4 +++
 tests/test-io-channel-buffer.c | 55 ++++++++++++++++++++++++++++--
 6 files changed, 234 insertions(+), 31 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index db9bb02..bfc97e2 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,6 +269,52 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
                                 Error **errp);
 
 /**
+ * qio_channel_readv_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Read data from the IO channel, storing it in the
+ * memory regions referenced by @iov. Each element
+ * in the @iov will be fully populated with data
+ * before the next one is used. The @niov parameter
+ * specifies the total number of elements in @iov.
+ *
+ * Returns: the number of bytes read, or -1 on error,
+ * or QIO_CHANNEL_ERR_BLOCK if no data is available
+ * and the channel is non-blocking
+ */
+ssize_t qio_channel_readv_all(QIOChannel *ioc,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp);
+
+
+/**
+ * qio_channel_writev_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Write data to the IO channel, reading it from the
+ * memory regions referenced by @iov. Each element
+ * in the @iov will be fully sent, before the next
+ * one is used. The @niov parameter specifies the
+ * total number of elements in @iov.
+ *
+ * It is required for all @iov data to be fully
+ * sent.
+ *
+ * Returns: the number of bytes sent, or -1 on error,
+ */
+ssize_t qio_channel_writev_all(QIOChannel *ioc,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **erp);
+
+/**
  * qio_channel_readv:
  * @ioc: the channel object
  * @iov: the array of memory regions to read data into
diff --git a/io/channel.c b/io/channel.c
index cdf7454..82203ef 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,6 +22,7 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -85,6 +86,81 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 }
 
 
+
+ssize_t qio_channel_readv_all(QIOChannel *ioc,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp)
+{
+    ssize_t done = 0;
+    struct iovec *local_iov = g_new(struct iovec, niov);
+    struct iovec *local_iov_head = local_iov;
+    unsigned int nlocal_iov = niov;
+
+    nlocal_iov = iov_copy(local_iov, nlocal_iov,
+                          iov, niov,
+                          0, iov_size(iov, niov));
+
+    while (nlocal_iov > 0) {
+        ssize_t len;
+        len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait(ioc, G_IO_OUT);
+            continue;
+        }
+        if (len < 0) {
+            error_setg_errno(errp, EIO,
+                             "Channel was not able to read full iov");
+            done = -1;
+            goto cleanup;
+        }
+
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+        done += len;
+    }
+
+ cleanup:
+    g_free(local_iov_head);
+    return done;
+}
+
+ssize_t qio_channel_writev_all(QIOChannel *ioc,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **errp)
+{
+    ssize_t done = 0;
+    struct iovec *local_iov = g_new(struct iovec, niov);
+    struct iovec *local_iov_head = local_iov;
+    unsigned int nlocal_iov = niov;
+
+    nlocal_iov = iov_copy(local_iov, nlocal_iov,
+                          iov, niov,
+                          0, iov_size(iov, niov));
+
+    while (nlocal_iov > 0) {
+        ssize_t len;
+        len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_wait(ioc, G_IO_OUT);
+            continue;
+        }
+        if (len < 0) {
+            error_setg_errno(errp, EIO,
+                             "Channel was not able to write full iov");
+            done = -1;
+            goto cleanup;
+        }
+
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+        done += len;
+    }
+
+ cleanup:
+    g_free(local_iov_head);
+    return done;
+}
+
 ssize_t qio_channel_readv(QIOChannel *ioc,
                           const struct iovec *iov,
                           size_t niov,
diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
index e202d73..457ea6c 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -36,35 +36,8 @@ static ssize_t channel_writev_buffer(void *opaque,
                                      int64_t pos)
 {
     QIOChannel *ioc = QIO_CHANNEL(opaque);
-    ssize_t done = 0;
-    struct iovec *local_iov = g_new(struct iovec, iovcnt);
-    struct iovec *local_iov_head = local_iov;
-    unsigned int nlocal_iov = iovcnt;
 
-    nlocal_iov = iov_copy(local_iov, nlocal_iov,
-                          iov, iovcnt,
-                          0, iov_size(iov, iovcnt));
-
-    while (nlocal_iov > 0) {
-        ssize_t len;
-        len = qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
-        if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_OUT);
-            continue;
-        }
-        if (len < 0) {
-            /* XXX handle Error objects */
-            done = -EIO;
-            goto cleanup;
-        }
-
-        iov_discard_front(&local_iov, &nlocal_iov, len);
-        done += len;
-    }
-
- cleanup:
-    g_free(local_iov_head);
-    return done;
+    return qio_channel_writev_all(ioc, iov, iovcnt, NULL);
 }
 
 
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index 05e5579..3d76d95 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
+#include "qemu/iov.h"
 
 struct QIOChannelTest {
     QIOChannel *src;
@@ -153,6 +154,45 @@ static gpointer test_io_thread_reader(gpointer opaque)
     return NULL;
 }
 
+static gpointer test_io_thread_writer_all(gpointer opaque)
+{
+    QIOChannelTest *data = opaque;
+    size_t niov = data->niov;
+    ssize_t ret;
+
+    qio_channel_set_blocking(data->src, data->blocking, NULL);
+
+    ret = qio_channel_writev_all(data->src,
+                                 data->inputv,
+                                 niov,
+                                 &data->writeerr);
+    if (ret != iov_size(data->inputv, data->niov)) {
+        error_setg(&data->writeerr, "Unexpected I/O error");
+    }
+
+    return NULL;
+}
+
+/* This thread receives all data using iovecs */
+static gpointer test_io_thread_reader_all(gpointer opaque)
+{
+    QIOChannelTest *data = opaque;
+    size_t niov = data->niov;
+    ssize_t ret;
+
+    qio_channel_set_blocking(data->dst, data->blocking, NULL);
+
+    ret = qio_channel_readv_all(data->dst,
+                                data->outputv,
+                                niov,
+                                &data->readerr);
+
+    if (ret != iov_size(data->inputv, data->niov)) {
+        error_setg(&data->readerr, "Unexpected I/O error");
+    }
+
+    return NULL;
+}
 
 QIOChannelTest *qio_channel_test_new(void)
 {
@@ -231,6 +271,21 @@ void qio_channel_test_run_reader(QIOChannelTest *test,
     test->dst = NULL;
 }
 
+void qio_channel_test_run_writer_all(QIOChannelTest *test,
+                                     QIOChannel *src)
+{
+    test->src = src;
+    test_io_thread_writer_all(test);
+    test->src = NULL;
+}
+
+void qio_channel_test_run_reader_all(QIOChannelTest *test,
+                                     QIOChannel *dst)
+{
+    test->dst = dst;
+    test_io_thread_reader_all(test);
+    test->dst = NULL;
+}
 
 void qio_channel_test_validate(QIOChannelTest *test)
 {
diff --git a/tests/io-channel-helpers.h b/tests/io-channel-helpers.h
index fedc64f..17b9647 100644
--- a/tests/io-channel-helpers.h
+++ b/tests/io-channel-helpers.h
@@ -36,6 +36,10 @@ void qio_channel_test_run_writer(QIOChannelTest *test,
                                  QIOChannel *src);
 void qio_channel_test_run_reader(QIOChannelTest *test,
                                  QIOChannel *dst);
+void qio_channel_test_run_writer_all(QIOChannelTest *test,
+                                     QIOChannel *src);
+void qio_channel_test_run_reader_all(QIOChannelTest *test,
+                                     QIOChannel *dst);
 
 void qio_channel_test_validate(QIOChannelTest *test);
 
diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
index 64722a2..4bf64ae 100644
--- a/tests/test-io-channel-buffer.c
+++ b/tests/test-io-channel-buffer.c
@@ -22,8 +22,7 @@
 #include "io/channel-buffer.h"
 #include "io-channel-helpers.h"
 
-
-static void test_io_channel_buf(void)
+static void test_io_channel_buf1(void)
 {
     QIOChannelBuffer *buf;
     QIOChannelTest *test;
@@ -39,6 +38,53 @@ static void test_io_channel_buf(void)
     object_unref(OBJECT(buf));
 }
 
+static void test_io_channel_buf2(void)
+{
+    QIOChannelBuffer *buf;
+    QIOChannelTest *test;
+
+    buf = qio_channel_buffer_new(0);
+
+    test = qio_channel_test_new();
+    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
+    buf->offset = 0;
+    qio_channel_test_run_reader(test, QIO_CHANNEL(buf));
+    qio_channel_test_validate(test);
+
+    object_unref(OBJECT(buf));
+}
+
+static void test_io_channel_buf3(void)
+{
+    QIOChannelBuffer *buf;
+    QIOChannelTest *test;
+
+    buf = qio_channel_buffer_new(0);
+
+    test = qio_channel_test_new();
+    qio_channel_test_run_writer(test, QIO_CHANNEL(buf));
+    buf->offset = 0;
+    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
+    qio_channel_test_validate(test);
+
+    object_unref(OBJECT(buf));
+}
+
+static void test_io_channel_buf4(void)
+{
+    QIOChannelBuffer *buf;
+    QIOChannelTest *test;
+
+    buf = qio_channel_buffer_new(0);
+
+    test = qio_channel_test_new();
+    qio_channel_test_run_writer_all(test, QIO_CHANNEL(buf));
+    buf->offset = 0;
+    qio_channel_test_run_reader_all(test, QIO_CHANNEL(buf));
+    qio_channel_test_validate(test);
+
+    object_unref(OBJECT(buf));
+}
 
 int main(int argc, char **argv)
 {
@@ -46,6 +92,9 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    g_test_add_func("/io/channel/buf", test_io_channel_buf);
+    g_test_add_func("/io/channel/buf1", test_io_channel_buf1);
+    g_test_add_func("/io/channel/buf2", test_io_channel_buf2);
+    g_test_add_func("/io/channel/buf3", test_io_channel_buf3);
+    g_test_add_func("/io/channel/buf4", test_io_channel_buf4);
     return g_test_run();
 }
-- 
2.9.4
