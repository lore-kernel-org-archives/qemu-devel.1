Received: from eggs.gnu.org ([2001:4830:134:3::10]:56366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPL7-0004F3-Hb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPL5-0005mk-VR
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPL5-0005mL-Mg
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:39 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF3C861B86
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:19 +0100
Message-Id: <20170313124434.1043-2-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/16] qio: create new qio_channel_write_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

The function waits until it is able to write the full iov.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/io/channel.h          | 23 +++++++++++++++++++++++
 io/channel.c                  | 39 +++++++++++++++++++++++++++++++++++++++
 migration/qemu-file-channel.c | 29 +----------------------------
 3 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5d48906..f786c4f 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,6 +269,29 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
                                 Error **errp);
 
 /**
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
index cdf7454..c5a1bd5 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,6 +22,7 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -85,6 +86,44 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 }
 
 
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
index 45c13f1..dd95e06 100644
--- a/migration/qemu-file-channel.c
+++ b/migration/qemu-file-channel.c
@@ -34,35 +34,8 @@ static ssize_t channel_writev_buffer(void *opaque,
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
 
 
-- 
2.9.3
