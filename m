Received: from eggs.gnu.org ([2001:4830:134:3::10]:60232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsP-0007RZ-JT
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsM-00080x-Vy
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYsM-0007zu-Mo
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB2AC4E334
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:52:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:51:29 +0200
Message-Id: <20170906115143.27451-9-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-1-quintela@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v7 08/22] qio: Create new qio_channel_{readv,
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

The functions waits until it is able to write the full iov.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Add tests.

fix reader to check for len == 0.

make reader wait on G_IO_IN (dave)
change tests to make sure that all combinations of call work with all backends
---
 include/io/channel.h          | 44 +++++++++++++++++++++++++
 io/channel.c                  | 77 +++++++++++++++++++++++++++++++++++++++++++
 migration/qemu-file-channel.c | 29 +---------------
 tests/io-channel-helpers.c    | 36 +++++++++++++++-----
 4 files changed, 149 insertions(+), 37 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 54f3dc252f..8e8e2faf1a 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,6 +269,50 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
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
+ * Returns: the number of bytes read, or -1 on error
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
index 1cfb8b33a2..702e712798 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,6 +22,7 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -85,6 +86,82 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
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
+            qio_channel_wait(ioc, G_IO_IN);
+            continue;
+        } else if (len < 0) {
+            error_setg_errno(errp, EIO,
+                             "Channel was not able to read full iov");
+            done = -1;
+            goto cleanup;
+        } else if (len == 0) {
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
index e202d73834..457ea6c831 100644
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
index 05e5579cf8..ea7b32b4e5 100644
--- a/tests/io-channel-helpers.c
+++ b/tests/io-channel-helpers.c
@@ -83,11 +83,21 @@ static gpointer test_io_thread_writer(gpointer opaque)
     qio_channel_set_blocking(data->src, data->blocking, NULL);
 
     while (niov) {
+        int use_all;
         ssize_t ret;
-        ret = qio_channel_writev(data->src,
-                                 iov,
-                                 niov,
-                                 &data->writeerr);
+        use_all = g_test_rand_int_range(0, 2);
+
+        if (use_all) {
+            ret = qio_channel_writev_all(data->src,
+                                         iov,
+                                         niov,
+                                         &data->writeerr);
+        } else {
+            ret = qio_channel_writev(data->src,
+                                     iov,
+                                     niov,
+                                     &data->writeerr);
+        }
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             if (data->blocking) {
                 error_setg(&data->writeerr,
@@ -124,13 +134,21 @@ static gpointer test_io_thread_reader(gpointer opaque)
     qio_channel_set_blocking(data->dst, data->blocking, NULL);
 
     while (niov) {
+        int use_all;
         ssize_t ret;
+        use_all = g_test_rand_int_range(0, 2);
 
-        ret = qio_channel_readv(data->dst,
-                                iov,
-                                niov,
-                                &data->readerr);
-
+        if (use_all) {
+            ret = qio_channel_readv_all(data->dst,
+                                        iov,
+                                        niov,
+                                        &data->readerr);
+        } else {
+            ret = qio_channel_readv(data->dst,
+                                    iov,
+                                    niov,
+                                    &data->readerr);
+        }
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             if (data->blocking) {
                 error_setg(&data->readerr,
-- 
2.13.5
