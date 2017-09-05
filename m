Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4J-0001GE-U7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4E-0002oH-IT
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA4E-0002nK-9Q
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:46 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:29 +0100
Message-Id: <20170905092230.8243-9-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 8/9] io: add new qio_channel_{readv, writev,
 read, write}_all functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

These functions wait until they are able to read / write the full
requested data buffer(s).

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel.h       |  90 +++++++++++++++++++++++++++++++++++++++
 io/channel.c               |  94 +++++++++++++++++++++++++++++++++++++++++
 tests/io-channel-helpers.c | 102 ++++-----------------------------------------
 3 files changed, 193 insertions(+), 93 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 54f3dc252f..8f25893c45 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,6 +269,58 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
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
+ * The function will wait for all requested data
+ * to be read, yielding from the current coroutine
+ * if required.
+ *
+ * If end-of-file occurs before all requested data
+ * has been read, an error will be reported.
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int qio_channel_readv_all(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          Error **errp);
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
+ * The function will wait for all requested data
+ * to be written, yielding from the current coroutine
+ * if required.
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int qio_channel_writev_all(QIOChannel *ioc,
+                           const struct iovec *iov,
+                           size_t niov,
+                           Error **erp);
+
+/**
  * qio_channel_readv:
  * @ioc: the channel object
  * @iov: the array of memory regions to read data into
@@ -331,6 +383,44 @@ ssize_t qio_channel_write(QIOChannel *ioc,
                           Error **errp);
 
 /**
+ * qio_channel_read_all:
+ * @ioc: the channel object
+ * @buf: the memory region to read data into
+ * @buflen: the number of bytes to @buf
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads @buflen bytes into @buf, possibly blocking or (if the
+ * channel is non-blocking) yielding from the current coroutine
+ * multiple times until the entire content is read. If end-of-file
+ * occurs it will return an error rather than a short-read. Otherwise
+ * behaves as qio_channel_read().
+ *
+ * Returns: 0 if all bytes were read, or -1 on error
+ */
+int qio_channel_read_all(QIOChannel *ioc,
+                         char *buf,
+                         size_t buflen,
+                         Error **errp);
+/**
+ * qio_channel_write_all:
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Writes @buflen bytes from @buf, possibly blocking or (if the
+ * channel is non-blocking) yielding from the current coroutine
+ * multiple times until the entire content is written.  Otherwise
+ * behaves as qio_channel_write().
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+int qio_channel_write_all(QIOChannel *ioc,
+                          const char *buf,
+                          size_t buflen,
+                          Error **errp);
+
+/**
  * qio_channel_set_blocking:
  * @ioc: the channel object
  * @enabled: the blocking flag state
diff --git a/io/channel.c b/io/channel.c
index 1cfb8b33a2..5e8c2f0a91 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,6 +22,7 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -85,6 +86,79 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 }
 
 
+
+int qio_channel_readv_all(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          Error **errp)
+{
+    int ret = -1;
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
+            qio_channel_wait(ioc, G_IO_IN);
+            continue;
+        } else if (len < 0) {
+            goto cleanup;
+        } else if (len == 0) {
+            error_setg(errp,
+                       "Unexpected end-of-file before all bytes were read");
+            goto cleanup;
+        }
+
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+    }
+
+    ret = 0;
+
+ cleanup:
+    g_free(local_iov_head);
+    return ret;
+}
+
+int qio_channel_writev_all(QIOChannel *ioc,
+                           const struct iovec *iov,
+                           size_t niov,
+                           Error **errp)
+{
+    int ret = -1;
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
+            goto cleanup;
+        }
+
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+    }
+
+    ret = 0;
+ cleanup:
+    g_free(local_iov_head);
+    return ret;
+}
+
 ssize_t qio_channel_readv(QIOChannel *ioc,
                           const struct iovec *iov,
                           size_t niov,
@@ -123,6 +197,26 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 }
 
 
+int qio_channel_read_all(QIOChannel *ioc,
+                         char *buf,
+                         size_t buflen,
+                         Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
+    return qio_channel_readv_all(ioc, &iov, 1, errp);
+}
+
+
+int qio_channel_write_all(QIOChannel *ioc,
+                          const char *buf,
+                          size_t buflen,
+                          Error **errp)
+{
+    struct iovec iov = { .iov_base = (char *)buf, .iov_len = buflen };
+    return qio_channel_writev_all(ioc, &iov, 1, errp);
+}
+
+
 int qio_channel_set_blocking(QIOChannel *ioc,
                               bool enabled,
                               Error **errp)
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index 05e5579cf8..5430e1389d 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
+#include "qemu/iov.h"
 
 struct QIOChannelTest {
     QIOChannel *src;
@@ -37,77 +38,17 @@ struct QIOChannelTest {
 };
 
 
-static void test_skip_iovec(struct iovec **iov,
-                            size_t *niov,
-                            size_t skip,
-                            struct iovec *old)
-{
-    size_t offset = 0;
-    size_t i;
-
-    for (i = 0; i < *niov; i++) {
-        if (skip < (*iov)[i].iov_len) {
-            old->iov_len = (*iov)[i].iov_len;
-            old->iov_base = (*iov)[i].iov_base;
-
-            (*iov)[i].iov_len -= skip;
-            (*iov)[i].iov_base += skip;
-            break;
-        } else {
-            skip -= (*iov)[i].iov_len;
-
-            if (i == 0 && old->iov_base) {
-                (*iov)[i].iov_len = old->iov_len;
-                (*iov)[i].iov_base = old->iov_base;
-                old->iov_len = 0;
-                old->iov_base = NULL;
-            }
-
-            offset++;
-        }
-    }
-
-    *iov = *iov + offset;
-    *niov -= offset;
-}
-
-
 /* This thread sends all data using iovecs */
 static gpointer test_io_thread_writer(gpointer opaque)
 {
     QIOChannelTest *data = opaque;
-    struct iovec *iov = data->inputv;
-    size_t niov = data->niov;
-    struct iovec old = { 0 };
 
     qio_channel_set_blocking(data->src, data->blocking, NULL);
 
-    while (niov) {
-        ssize_t ret;
-        ret = qio_channel_writev(data->src,
-                                 iov,
-                                 niov,
-                                 &data->writeerr);
-        if (ret == QIO_CHANNEL_ERR_BLOCK) {
-            if (data->blocking) {
-                error_setg(&data->writeerr,
-                           "Unexpected I/O blocking");
-                break;
-            } else {
-                qio_channel_wait(data->src,
-                                 G_IO_OUT);
-                continue;
-            }
-        } else if (ret < 0) {
-            break;
-        } else if (ret == 0) {
-            error_setg(&data->writeerr,
-                       "Unexpected zero length write");
-            break;
-        }
-
-        test_skip_iovec(&iov, &niov, ret, &old);
-    }
+    qio_channel_writev_all(data->src,
+                           data->inputv,
+                           data->niov,
+                           &data->writeerr);
 
     return NULL;
 }
@@ -117,38 +58,13 @@ static gpointer test_io_thread_writer(gpointer opaque)
 static gpointer test_io_thread_reader(gpointer opaque)
 {
     QIOChannelTest *data = opaque;
-    struct iovec *iov = data->outputv;
-    size_t niov = data->niov;
-    struct iovec old = { 0 };
 
     qio_channel_set_blocking(data->dst, data->blocking, NULL);
 
-    while (niov) {
-        ssize_t ret;
-
-        ret = qio_channel_readv(data->dst,
-                                iov,
-                                niov,
-                                &data->readerr);
-
-        if (ret == QIO_CHANNEL_ERR_BLOCK) {
-            if (data->blocking) {
-                error_setg(&data->readerr,
-                           "Unexpected I/O blocking");
-                break;
-            } else {
-                qio_channel_wait(data->dst,
-                                 G_IO_IN);
-                continue;
-            }
-        } else if (ret < 0) {
-            break;
-        } else if (ret == 0) {
-            break;
-        }
-
-        test_skip_iovec(&iov, &niov, ret, &old);
-    }
+    qio_channel_readv_all(data->dst,
+                          data->outputv,
+                          data->niov,
+                          &data->readerr);
 
     return NULL;
 }
-- 
2.13.5
