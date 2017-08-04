Received: from eggs.gnu.org ([2001:4830:134:3::10]:54735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJP-0005Vw-94
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007FU-Vp
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:20173 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-0007Bb-Gq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:25 +0300
Message-Id: <20170804151440.320927-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 02/17] nbd/client: refactor nbd_read_eof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Refactor nbd_read_eof to return 1 on success, 0 on eof, when no
data was read and <0 for other cases, because returned size of
read data is not actually used.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/nbd-internal.h         | 34 +++++++++++++++++++++++++---------
 nbd/client.c               |  5 -----
 tests/qemu-iotests/083.out |  4 ++--
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 396ddb4d3e..3fb0b6098a 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -77,21 +77,37 @@
 #define NBD_ESHUTDOWN  108
 
 /* nbd_read_eof
- * Tries to read @size bytes from @ioc. Returns number of bytes actually read.
- * May return a value >= 0 and < size only on EOF, i.e. when iteratively called
- * qio_channel_readv() returns 0. So, there is no need to call nbd_read_eof
- * iteratively.
+ * Tries to read @size bytes from @ioc.
+ * Returns 1 on success
+ *         0 on eof, when no data was read (errp is not set)
+ *         -EINVAL on eof, when some data < @size was read until eof
+ *         < 0 on read fail
  */
-static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
-                                   Error **errp)
+static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
+                               Error **errp)
 {
     struct iovec iov = { .iov_base = buffer, .iov_len = size };
+    ssize_t ret;
+
     /* Sockets are kept in blocking mode in the negotiation phase.  After
      * that, a non-readable socket simply means that another thread stole
      * our request/reply.  Synchronization is done with recv_coroutine, so
      * that this is coroutine-safe.
      */
-    return nbd_rwv(ioc, &iov, 1, size, true, errp);
+
+    assert(size > 0);
+
+    ret = nbd_rwv(ioc, &iov, 1, size, true, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    if (ret != size) {
+        error_setg(errp, "End of file");
+        return -EINVAL;
+    }
+
+    return 1;
 }
 
 /* nbd_read
@@ -100,9 +116,9 @@ static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
 static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
                            Error **errp)
 {
-    ssize_t ret = nbd_read_eof(ioc, buffer, size, errp);
+    int ret = nbd_read_eof(ioc, buffer, size, errp);
 
-    if (ret >= 0 && ret != size) {
+    if (ret == 0) {
         ret = -EINVAL;
         error_setg(errp, "End of file");
     }
diff --git a/nbd/client.c b/nbd/client.c
index f1c16b588f..4556056daa 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -925,11 +925,6 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
         return ret;
     }
 
-    if (ret != sizeof(buf)) {
-        error_setg(errp, "read failed");
-        return -EINVAL;
-    }
-
     /* Reply
        [ 0 ..  3]    magic   (NBD_REPLY_MAGIC)
        [ 4 ..  7]    error   (0 == no error)
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index a24c6bfece..d3bea1b2f5 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -69,12 +69,12 @@ read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-read failed
+End of file
 read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-read failed
+End of file
 read failed: Input/output error
 
 === Check disconnect before data ===
-- 
2.11.1
