Received: from eggs.gnu.org ([2001:4830:134:3::10]:33294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJGA-0000Yd-Gk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJG4-0005cF-Qd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:11:42 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  5 Sep 2017 14:11:14 -0500
Message-Id: <20170905191114.5959-4-eblake@redhat.com>
In-Reply-To: <20170905191114.5959-1-eblake@redhat.com>
References: <20170905191114.5959-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] nbd: Use new qio_channel_*_all() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Rather than open-coding our own read/write-all functions, we
can make use of the recently-added qio code.  It slightly
changes the error message in one of the iotests.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h        |  2 --
 nbd/nbd-internal.h         | 41 +++++++----------------------------------
 block/nbd-client.c         | 15 +++++++--------
 nbd/common.c               | 45 ---------------------------------------------
 tests/qemu-iotests/083.out |  8 ++++----
 5 files changed, 18 insertions(+), 93 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 040cdd2e60..707fd37575 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -155,8 +155,6 @@ struct NBDExportInfo {
 };
 typedef struct NBDExportInfo NBDExportInfo;

-ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
-                bool do_read, Error **errp);
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc, NBDExportInfo *info,
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 03549e3f39..8a609a227f 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -85,28 +85,14 @@
 static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
                                Error **errp)
 {
-    struct iovec iov = { .iov_base = buffer, .iov_len = size };
-    ssize_t ret;
-
-    /* Sockets are kept in blocking mode in the negotiation phase.  After
-     * that, a non-readable socket simply means that another thread stole
-     * our request/reply.  Synchronization is done with recv_coroutine, so
-     * that this is coroutine-safe.
-     */
+    int ret;

     assert(size);
-
-    ret = nbd_rwv(ioc, &iov, 1, size, true, errp);
-    if (ret <= 0) {
-        return ret;
+    ret = qio_channel_read_all_eof(ioc, buffer, size, errp);
+    if (ret < 0) {
+        ret = -EIO;
     }
-
-    if (ret != size) {
-        error_setg(errp, "End of file");
-        return -EINVAL;
-    }
-
-    return 1;
+    return ret;
 }

 /* nbd_read
@@ -115,14 +101,7 @@ static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
 static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
                            Error **errp)
 {
-    int ret = nbd_read_eof(ioc, buffer, size, errp);
-
-    if (ret == 0) {
-        ret = -EINVAL;
-        error_setg(errp, "End of file");
-    }
-
-    return ret < 0 ? ret : 0;
+    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 }

 /* nbd_write
@@ -131,13 +110,7 @@ static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
 static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
                             Error **errp)
 {
-    struct iovec iov = { .iov_base = (void *) buffer, .iov_len = size };
-
-    ssize_t ret = nbd_rwv(ioc, &iov, 1, size, false, errp);
-
-    assert(ret < 0 || ret == size);
-
-    return ret < 0 ? ret : 0;
+    return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 }

 struct NBDTLSHandshakeData {
diff --git a/block/nbd-client.c b/block/nbd-client.c
index f0dbea24d3..ee7f758e68 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -121,7 +121,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                QEMUIOVector *qiov)
 {
     NBDClientSession *s = nbd_get_client_session(bs);
-    int rc, ret, i;
+    int rc, i;

     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight == MAX_NBD_REQUESTS) {
@@ -156,9 +156,9 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0 && !s->quit) {
-            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
-                          NULL);
-            if (ret != request->len) {
+            assert(request->len == iov_size(qiov->iov, qiov->niov));
+            if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
+                                       NULL) < 0) {
                 rc = -EIO;
             }
         }
@@ -184,7 +184,6 @@ static void nbd_co_receive_reply(NBDClientSession *s,
                                  QEMUIOVector *qiov)
 {
     int i = HANDLE_TO_INDEX(s, request->handle);
-    int ret;

     /* Wait until we're woken up by nbd_read_reply_entry.  */
     s->requests[i].receiving = true;
@@ -195,9 +194,9 @@ static void nbd_co_receive_reply(NBDClientSession *s,
         reply->error = EIO;
     } else {
         if (qiov && reply->error == 0) {
-            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
-                          NULL);
-            if (ret != request->len) {
+            assert(request->len == iov_size(qiov->iov, qiov->niov));
+            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+                                      NULL) < 0) {
                 reply->error = EIO;
                 s->quit = true;
             }
diff --git a/nbd/common.c b/nbd/common.c
index e288d1b972..59a5316be9 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -20,51 +20,6 @@
 #include "qapi/error.h"
 #include "nbd-internal.h"

-/* nbd_wr_syncv
- * The function may be called from coroutine or from non-coroutine context.
- * When called from non-coroutine context @ioc must be in blocking mode.
- */
-ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
-                bool do_read, Error **errp)
-{
-    ssize_t done = 0;
-    struct iovec *local_iov = g_new(struct iovec, niov);
-    struct iovec *local_iov_head = local_iov;
-    unsigned int nlocal_iov = niov;
-
-    nlocal_iov = iov_copy(local_iov, nlocal_iov, iov, niov, 0, length);
-
-    while (nlocal_iov > 0) {
-        ssize_t len;
-        if (do_read) {
-            len = qio_channel_readv(ioc, local_iov, nlocal_iov, errp);
-        } else {
-            len = qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
-        }
-        if (len == QIO_CHANNEL_ERR_BLOCK) {
-            /* errp should not be set */
-            assert(qemu_in_coroutine());
-            qio_channel_yield(ioc, do_read ? G_IO_IN : G_IO_OUT);
-            continue;
-        }
-        if (len < 0) {
-            done = -EIO;
-            goto cleanup;
-        }
-
-        if (do_read && len == 0) {
-            break;
-        }
-
-        iov_discard_front(&local_iov, &nlocal_iov, len);
-        done += len;
-    }
-
- cleanup:
-    g_free(local_iov_head);
-    return done;
-}
-
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
  * success */
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index fb71b6f8ad..25dde519e3 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -69,12 +69,12 @@ read failed: Input/output error

 === Check disconnect 4 reply ===

-End of file
+Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 === Check disconnect 8 reply ===

-End of file
+Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 === Check disconnect before data ===
@@ -180,12 +180,12 @@ read failed: Input/output error

 === Check disconnect 4 reply ===

-End of file
+Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 === Check disconnect 8 reply ===

-End of file
+Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 === Check disconnect before data ===
-- 
2.13.5
