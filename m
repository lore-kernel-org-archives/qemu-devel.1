Received: from eggs.gnu.org ([2001:4830:134:3::10]:53868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8w-0004AM-85
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpc8r-0006yT-Qs
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpc8r-0006xv-Ht
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:21:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF75806B6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:21:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed,  6 Sep 2017 10:21:10 -0500
Message-Id: <20170906152111.16958-5-eblake@redhat.com>
In-Reply-To: <20170906152111.16958-1-eblake@redhat.com>
References: <20170906152111.16958-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] io: Add new qio_channel_read{,
 v}_all_eof functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some callers want to distinguish between clean EOF (no bytes read)
vs. a short read (at least one byte read, but EOF encountered
before reaching the desired length), as it allows clients the
ability to do a graceful shutdown when a server shuts down at
defined safe points in the protocol, rather than treating all
shutdown scenarios as an error due to EOF.  However, we don't want
to require all callers to have to check for early EOF.  So add
another wrapper function that can be used by the callers that care
about the distinction.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170905191114.5959-3-eblake@redhat.com>
Acked-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 48 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 8f25893c45..3995e243a3 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -269,6 +269,36 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
                                 Error **errp);

 /**
+ * qio_channel_readv_all_eof:
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
+ * If end-of-file occurs before any data is read,
+ * no error is reported; otherwise, if it occurs
+ * before all requested data has been read, an error
+ * will be reported.
+ *
+ * Returns: 1 if all bytes were read, 0 if end-of-file
+ *          occurs without data, or -1 on error
+ */
+int qio_channel_readv_all_eof(QIOChannel *ioc,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp);
+
+/**
  * qio_channel_readv_all:
  * @ioc: the channel object
  * @iov: the array of memory regions to read data into
@@ -383,6 +413,28 @@ ssize_t qio_channel_write(QIOChannel *ioc,
                           Error **errp);

 /**
+ * qio_channel_read_all_eof:
+ * @ioc: the channel object
+ * @buf: the memory region to read data into
+ * @buflen: the number of bytes to @buf
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Reads @buflen bytes into @buf, possibly blocking or (if the
+ * channel is non-blocking) yielding from the current coroutine
+ * multiple times until the entire content is read. If end-of-file
+ * occurs immediately it is not an error, but if it occurs after
+ * data has been read it will return an error rather than a
+ * short-read. Otherwise behaves as qio_channel_read().
+ *
+ * Returns: 1 if all bytes were read, 0 if end-of-file occurs
+ *          without data, or -1 on error
+ */
+int qio_channel_read_all_eof(QIOChannel *ioc,
+                             char *buf,
+                             size_t buflen,
+                             Error **errp);
+
+/**
  * qio_channel_read_all:
  * @ioc: the channel object
  * @buf: the memory region to read data into
@@ -401,6 +453,7 @@ int qio_channel_read_all(QIOChannel *ioc,
                          char *buf,
                          size_t buflen,
                          Error **errp);
+
 /**
  * qio_channel_write_all:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 9e62794cab..ec4b86de7c 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -86,16 +86,16 @@ ssize_t qio_channel_writev_full(QIOChannel *ioc,
 }


-
-int qio_channel_readv_all(QIOChannel *ioc,
-                          const struct iovec *iov,
-                          size_t niov,
-                          Error **errp)
+int qio_channel_readv_all_eof(QIOChannel *ioc,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp)
 {
     int ret = -1;
     struct iovec *local_iov = g_new(struct iovec, niov);
     struct iovec *local_iov_head = local_iov;
     unsigned int nlocal_iov = niov;
+    bool partial = false;

     nlocal_iov = iov_copy(local_iov, nlocal_iov,
                           iov, niov,
@@ -114,21 +114,43 @@ int qio_channel_readv_all(QIOChannel *ioc,
         } else if (len < 0) {
             goto cleanup;
         } else if (len == 0) {
-            error_setg(errp,
-                       "Unexpected end-of-file before all bytes were read");
+            if (partial) {
+                error_setg(errp,
+                           "Unexpected end-of-file before all bytes were read");
+            } else {
+                ret = 0;
+            }
             goto cleanup;
         }

+        partial = true;
         iov_discard_front(&local_iov, &nlocal_iov, len);
     }

-    ret = 0;
+    ret = 1;

  cleanup:
     g_free(local_iov_head);
     return ret;
 }

+int qio_channel_readv_all(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          Error **errp)
+{
+    int ret = qio_channel_readv_all_eof(ioc, iov, niov, errp);
+
+    if (ret == 0) {
+        ret = -1;
+        error_setg(errp,
+                   "Unexpected end-of-file before all bytes were read");
+    } else if (ret == 1) {
+        ret = 0;
+    }
+    return ret;
+}
+
 int qio_channel_writev_all(QIOChannel *ioc,
                            const struct iovec *iov,
                            size_t niov,
@@ -205,6 +227,16 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 }


+int qio_channel_read_all_eof(QIOChannel *ioc,
+                             char *buf,
+                             size_t buflen,
+                             Error **errp)
+{
+    struct iovec iov = { .iov_base = buf, .iov_len = buflen };
+    return qio_channel_readv_all_eof(ioc, &iov, 1, errp);
+}
+
+
 int qio_channel_read_all(QIOChannel *ioc,
                          char *buf,
                          size_t buflen,
-- 
2.13.5
