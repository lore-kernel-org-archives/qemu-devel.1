Received: from eggs.gnu.org ([2001:4830:134:3::10]:60111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYs7-0007Dr-Fd
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYs5-0007tu-MS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYs5-0007s3-Dh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A0D45F723
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:51:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:51:22 +0200
Message-Id: <20170906115143.27451-2-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-1-quintela@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

This reverts commit d4622e55883211072621958d39ddaa73483d201e.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/io/channel.h       |  90 ---------------------------------------
 io/channel.c               |  94 -----------------------------------------
 tests/io-channel-helpers.c | 102 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 193 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 8f25893c45..54f3dc252f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,58 +269,6 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
                                 Error **errp);
 
 /**
- * qio_channel_readv_all:
- * @ioc: the channel object
- * @iov: the array of memory regions to read data into
- * @niov: the length of the @iov array
- * @errp: pointer to a NULL-initialized error object
- *
- * Read data from the IO channel, storing it in the
- * memory regions referenced by @iov. Each element
- * in the @iov will be fully populated with data
- * before the next one is used. The @niov parameter
- * specifies the total number of elements in @iov.
- *
- * The function will wait for all requested data
- * to be read, yielding from the current coroutine
- * if required.
- *
- * If end-of-file occurs before all requested data
- * has been read, an error will be reported.
- *
- * Returns: 0 if all bytes were read, or -1 on error
- */
-int qio_channel_readv_all(QIOChannel *ioc,
-                          const struct iovec *iov,
-                          size_t niov,
-                          Error **errp);
-
-
-/**
- * qio_channel_writev_all:
- * @ioc: the channel object
- * @iov: the array of memory regions to write data from
- * @niov: the length of the @iov array
- * @errp: pointer to a NULL-initialized error object
- *
- * Write data to the IO channel, reading it from the
- * memory regions referenced by @iov. Each element
- * in the @iov will be fully sent, before the next
- * one is used. The @niov parameter specifies the
- * total number of elements in @iov.
- *
- * The function will wait for all requested data
- * to be written, yielding from the current coroutine
- * if required.
- *
- * Returns: 0 if all bytes were written, or -1 on error
- */
-int qio_channel_writev_all(QIOChannel *ioc,
-                           const struct iovec *iov,
-                           size_t niov,
-                           Error **erp);
-
-/**
  * qio_channel_readv:
  * @ioc: the channel object
  * @iov: the array of memory regions to read data into
@@ -383,44 +331,6 @@ ssize_t qio_channel_write(QIOChannel *ioc,
                           Error **errp);
 
 /**
- * qio_channel_read_all:
- * @ioc: the channel object
- * @buf: the memory region to read data into
- * @buflen: the number of bytes to @buf
- * @errp: pointer to a NULL-initialized error object
- *
- * Reads @buflen bytes into @buf, possibly blocking or (if the
- * channel is non-blocking) yielding from the current coroutine
- * multiple times until the entire content is read. If end-of-file
- * occurs it will return an error rather than a short-read. Otherwise
- * behaves as qio_channel_read().
- *
- * Returns: 0 if all bytes were read, or -1 on error
- */
-int qio_channel_read_all(QIOChannel *ioc,
-                         char *buf,
-                         size_t buflen,
-                         Error **errp);
-/**
- * qio_channel_write_all:
- * @ioc: the channel object
- * @buf: the memory region to write data into
- * @buflen: the number of bytes to @buf
- * @errp: pointer to a NULL-initialized error object
- *
- * Writes @buflen bytes from @buf, possibly blocking or (if the
- * channel is non-blocking) yielding from the current coroutine
- * multiple times until the entire content is written.  Otherwise
- * behaves as qio_channel_write().
- *
- * Returns: 0 if all bytes were written, or -1 on error
- */
-int qio_channel_write_all(QIOChannel *ioc,
-                          const char *buf,
-                          size_t buflen,
-                          Error **errp);
-
-/**
  * qio_channel_set_blocking:
  * @ioc: the channel object
  * @enabled: the blocking flag state
diff --git a/io/channel.c b/io/channel.c
index 5e8c2f0a91..1cfb8b33a2 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,7 +22,6 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -86,79 +85,6 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 }
 
 
-
-int qio_channel_readv_all(QIOChannel *ioc,
-                          const struct iovec *iov,
-                          size_t niov,
-                          Error **errp)
-{
-    int ret = -1;
-    struct iovec *local_iov = g_new(struct iovec, niov);
-    struct iovec *local_iov_head = local_iov;
-    unsigned int nlocal_iov = niov;
-
-    nlocal_iov = iov_copy(local_iov, nlocal_iov,
-                          iov, niov,
-                          0, iov_size(iov, niov));
-
-    while (nlocal_iov > 0) {
-        ssize_t len;
-        len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
-        if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_IN);
-            continue;
-        } else if (len < 0) {
-            goto cleanup;
-        } else if (len == 0) {
-            error_setg(errp,
-                       "Unexpected end-of-file before all bytes were read");
-            goto cleanup;
-        }
-
-        iov_discard_front(&local_iov, &nlocal_iov, len);
-    }
-
-    ret = 0;
-
- cleanup:
-    g_free(local_iov_head);
-    return ret;
-}
-
-int qio_channel_writev_all(QIOChannel *ioc,
-                           const struct iovec *iov,
-                           size_t niov,
-                           Error **errp)
-{
-    int ret = -1;
-    struct iovec *local_iov = g_new(struct iovec, niov);
-    struct iovec *local_iov_head = local_iov;
-    unsigned int nlocal_iov = niov;
-
-    nlocal_iov = iov_copy(local_iov, nlocal_iov,
-                          iov, niov,
-                          0, iov_size(iov, niov));
-
-    while (nlocal_iov > 0) {
-        ssize_t len;
-        len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
-        if (len == QIO_CHANNEL_ERR_BLOCK) {
-            qio_channel_wait(ioc, G_IO_OUT);
-            continue;
-        }
-        if (len < 0) {
-            goto cleanup;
-        }
-
-        iov_discard_front(&local_iov, &nlocal_iov, len);
-    }
-
-    ret = 0;
- cleanup:
-    g_free(local_iov_head);
-    return ret;
-}
-
 ssize_t qio_channel_readv(QIOChannel *ioc,
                           const struct iovec *iov,
                           size_t niov,
@@ -197,26 +123,6 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 }
 
 
-int qio_channel_read_all(QIOChannel *ioc,
-                         char *buf,
-                         size_t buflen,
-                         Error **errp)
-{
-    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
-    return qio_channel_readv_all(ioc, &iov, 1, errp);
-}
-
-
-int qio_channel_write_all(QIOChannel *ioc,
-                          const char *buf,
-                          size_t buflen,
-                          Error **errp)
-{
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = buflen };
-    return qio_channel_writev_all(ioc, &iov, 1, errp);
-}
-
-
 int qio_channel_set_blocking(QIOChannel *ioc,
                               bool enabled,
                               Error **errp)
diff --git a/tests/io-channel-helpers.c b/tests/io-channel-helpers.c
index 5430e1389d..05e5579cf8 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
-#include "qemu/iov.h"
 
 struct QIOChannelTest {
     QIOChannel *src;
@@ -38,17 +37,77 @@ struct QIOChannelTest {
 };
 
 
+static void test_skip_iovec(struct iovec **iov,
+                            size_t *niov,
+                            size_t skip,
+                            struct iovec *old)
+{
+    size_t offset = 0;
+    size_t i;
+
+    for (i = 0; i < *niov; i++) {
+        if (skip < (*iov)[i].iov_len) {
+            old->iov_len = (*iov)[i].iov_len;
+            old->iov_base = (*iov)[i].iov_base;
+
+            (*iov)[i].iov_len -= skip;
+            (*iov)[i].iov_base += skip;
+            break;
+        } else {
+            skip -= (*iov)[i].iov_len;
+
+            if (i == 0 && old->iov_base) {
+                (*iov)[i].iov_len = old->iov_len;
+                (*iov)[i].iov_base = old->iov_base;
+                old->iov_len = 0;
+                old->iov_base = NULL;
+            }
+
+            offset++;
+        }
+    }
+
+    *iov = *iov + offset;
+    *niov -= offset;
+}
+
+
 /* This thread sends all data using iovecs */
 static gpointer test_io_thread_writer(gpointer opaque)
 {
     QIOChannelTest *data = opaque;
+    struct iovec *iov = data->inputv;
+    size_t niov = data->niov;
+    struct iovec old = { 0 };
 
     qio_channel_set_blocking(data->src, data->blocking, NULL);
 
-    qio_channel_writev_all(data->src,
-                           data->inputv,
-                           data->niov,
-                           &data->writeerr);
+    while (niov) {
+        ssize_t ret;
+        ret = qio_channel_writev(data->src,
+                                 iov,
+                                 niov,
+                                 &data->writeerr);
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            if (data->blocking) {
+                error_setg(&data->writeerr,
+                           "Unexpected I/O blocking");
+                break;
+            } else {
+                qio_channel_wait(data->src,
+                                 G_IO_OUT);
+                continue;
+            }
+        } else if (ret < 0) {
+            break;
+        } else if (ret == 0) {
+            error_setg(&data->writeerr,
+                       "Unexpected zero length write");
+            break;
+        }
+
+        test_skip_iovec(&iov, &niov, ret, &old);
+    }
 
     return NULL;
 }
@@ -58,13 +117,38 @@ static gpointer test_io_thread_writer(gpointer opaque)
 static gpointer test_io_thread_reader(gpointer opaque)
 {
     QIOChannelTest *data = opaque;
+    struct iovec *iov = data->outputv;
+    size_t niov = data->niov;
+    struct iovec old = { 0 };
 
     qio_channel_set_blocking(data->dst, data->blocking, NULL);
 
-    qio_channel_readv_all(data->dst,
-                          data->outputv,
-                          data->niov,
-                          &data->readerr);
+    while (niov) {
+        ssize_t ret;
+
+        ret = qio_channel_readv(data->dst,
+                                iov,
+                                niov,
+                                &data->readerr);
+
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            if (data->blocking) {
+                error_setg(&data->readerr,
+                           "Unexpected I/O blocking");
+                break;
+            } else {
+                qio_channel_wait(data->dst,
+                                 G_IO_IN);
+                continue;
+            }
+        } else if (ret < 0) {
+            break;
+        } else if (ret == 0) {
+            break;
+        }
+
+        test_skip_iovec(&iov, &niov, ret, &old);
+    }
 
     return NULL;
 }
-- 
2.13.5
