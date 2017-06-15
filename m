Received: from eggs.gnu.org ([2001:4830:134:3::10]:40987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPF-0008SK-JJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPD-0007dC-4R
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:41 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPC-0007cw-Qf
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:39 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so16396187wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:44 +0200
Message-Id: <1497523981-38449-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/41] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename
  nbd_wr_syncv -> nbd_rwv
  read_sync -> nbd_read
  read_sync_eof -> nbd_read_eof
  write_sync -> nbd_write
  drop_sync -> nbd_drop

1. nbd_ prefix
   read_sync and write_sync are already shared, so it is good to have a
   namespace prefix. drop_sync will be shared, and read_sync_eof is
   related to read_sync, so let's rename them all.

2. _sync suffix
   _sync is related to the fact that nbd_wr_syncv doesn't return if a
   write to socket returns EAGAIN. The first implementation of
   nbd_wr_syncv (was wr_sync in 7a5ca8648b) just loops while getting
   EAGAIN, the current implementation yields in this case.
   Why we want to get rid of it:
   - it is normal for r/w functions to be synchronous, so having an
     additional suffix for it looks redundant (contrariwise, we have
     _aio suffix for async functions)
   - _sync suffix in block layer is used when function does flush (so
     using it for other thing is confusing a bit)
   - keep function names short after adding nbd_ prefix

3. for nbd_wr_syncv let's use more common notation 'rw'

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170602150150.258222-2-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c  |  8 ++++----
 include/block/nbd.h |  8 ++------
 nbd/client.c        | 42 +++++++++++++++++++++---------------------
 nbd/common.c        |  8 ++------
 nbd/nbd-internal.h  | 26 +++++++++++++-------------
 nbd/server.c        | 12 ++++++------
 6 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 87d19c7..d64e775 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -144,8 +144,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0) {
-            ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
-                               false, NULL);
+            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, false,
+                          NULL);
             if (ret != request->len) {
                 rc = -EIO;
             }
@@ -173,8 +173,8 @@ static void nbd_co_receive_reply(NBDClientSession *s,
         reply->error = EIO;
     } else {
         if (qiov && reply->error == 0) {
-            ret = nbd_wr_syncv(s->ioc, qiov->iov, qiov->niov, request->len,
-                               true, NULL);
+            ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
+                          NULL);
             if (ret != request->len) {
                 reply->error = EIO;
             }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 8fa5ce5..6d75d5a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -123,12 +123,8 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
 
-ssize_t nbd_wr_syncv(QIOChannel *ioc,
-                     struct iovec *iov,
-                     size_t niov,
-                     size_t length,
-                     bool do_read,
-                     Error **errp);
+ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
+                bool do_read, Error **errp);
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
diff --git a/nbd/client.c b/nbd/client.c
index 595d99e..17ac85f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -88,7 +88,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
  * success*/
-static int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
+static int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
 {
     ssize_t ret = 0;
     char small[1024];
@@ -97,7 +97,7 @@ static int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
     buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
     while (size > 0) {
         ssize_t count = MIN(65536, size);
-        ret = read_sync(ioc, buffer, MIN(65536, size), errp);
+        ret = nbd_read(ioc, buffer, MIN(65536, size), errp);
 
         if (ret < 0) {
             goto cleanup;
@@ -135,12 +135,12 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     stl_be_p(&req.option, opt);
     stl_be_p(&req.length, len);
 
-    if (write_sync(ioc, &req, sizeof(req), errp) < 0) {
+    if (nbd_write(ioc, &req, sizeof(req), errp) < 0) {
         error_prepend(errp, "Failed to send option request header");
         return -1;
     }
 
-    if (len && write_sync(ioc, (char *) data, len, errp) < 0) {
+    if (len && nbd_write(ioc, (char *) data, len, errp) < 0) {
         error_prepend(errp, "Failed to send option request data");
         return -1;
     }
@@ -169,7 +169,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
                                     nbd_opt_reply *reply, Error **errp)
 {
     QEMU_BUILD_BUG_ON(sizeof(*reply) != 20);
-    if (read_sync(ioc, reply, sizeof(*reply), errp) < 0) {
+    if (nbd_read(ioc, reply, sizeof(*reply), errp) < 0) {
         error_prepend(errp, "failed to read option reply");
         nbd_send_opt_abort(ioc);
         return -1;
@@ -218,7 +218,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
             goto cleanup;
         }
         msg = g_malloc(reply->length + 1);
-        if (read_sync(ioc, msg, reply->length, errp) < 0) {
+        if (nbd_read(ioc, msg, reply->length, errp) < 0) {
             error_prepend(errp, "failed to read option error message");
             goto cleanup;
         }
@@ -320,7 +320,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (read_sync(ioc, &namelen, sizeof(namelen), errp) < 0) {
+    if (nbd_read(ioc, &namelen, sizeof(namelen), errp) < 0) {
         error_prepend(errp, "failed to read option name length");
         nbd_send_opt_abort(ioc);
         return -1;
@@ -333,7 +333,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         return -1;
     }
     if (namelen != strlen(want)) {
-        if (drop_sync(ioc, len, errp) < 0) {
+        if (nbd_drop(ioc, len, errp) < 0) {
             error_prepend(errp, "failed to skip export name with wrong length");
             nbd_send_opt_abort(ioc);
             return -1;
@@ -342,14 +342,14 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     }
 
     assert(namelen < sizeof(name));
-    if (read_sync(ioc, name, namelen, errp) < 0) {
+    if (nbd_read(ioc, name, namelen, errp) < 0) {
         error_prepend(errp, "failed to read export name");
         nbd_send_opt_abort(ioc);
         return -1;
     }
     name[namelen] = '\0';
     len -= namelen;
-    if (drop_sync(ioc, len, errp) < 0) {
+    if (nbd_drop(ioc, len, errp) < 0) {
         error_prepend(errp, "failed to read export description");
         nbd_send_opt_abort(ioc);
         return -1;
@@ -476,7 +476,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    if (read_sync(ioc, buf, 8, errp) < 0) {
+    if (nbd_read(ioc, buf, 8, errp) < 0) {
         error_prepend(errp, "Failed to read data");
         goto fail;
     }
@@ -502,7 +502,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    if (read_sync(ioc, &magic, sizeof(magic), errp) < 0) {
+    if (nbd_read(ioc, &magic, sizeof(magic), errp) < 0) {
         error_prepend(errp, "Failed to read magic");
         goto fail;
     }
@@ -514,7 +514,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         uint16_t globalflags;
         bool fixedNewStyle = false;
 
-        if (read_sync(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
+        if (nbd_read(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
             error_prepend(errp, "Failed to read server flags");
             goto fail;
         }
@@ -532,7 +532,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }
         /* client requested flags */
         clientflags = cpu_to_be32(clientflags);
-        if (write_sync(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
+        if (nbd_write(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
             error_prepend(errp, "Failed to send clientflags field");
             goto fail;
         }
@@ -570,13 +570,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }
 
         /* Read the response */
-        if (read_sync(ioc, &s, sizeof(s), errp) < 0) {
+        if (nbd_read(ioc, &s, sizeof(s), errp) < 0) {
             error_prepend(errp, "Failed to read export length");
             goto fail;
         }
         *size = be64_to_cpu(s);
 
-        if (read_sync(ioc, flags, sizeof(*flags), errp) < 0) {
+        if (nbd_read(ioc, flags, sizeof(*flags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags");
             goto fail;
         }
@@ -593,14 +593,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
 
-        if (read_sync(ioc, &s, sizeof(s), errp) < 0) {
+        if (nbd_read(ioc, &s, sizeof(s), errp) < 0) {
             error_prepend(errp, "Failed to read export length");
             goto fail;
         }
         *size = be64_to_cpu(s);
         TRACE("Size is %" PRIu64, *size);
 
-        if (read_sync(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
+        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags");
             goto fail;
         }
@@ -616,7 +616,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
     }
 
     TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags);
-    if (zeroes && drop_sync(ioc, 124, errp) < 0) {
+    if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block");
         goto fail;
     }
@@ -759,7 +759,7 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     stq_be_p(buf + 16, request->from);
     stl_be_p(buf + 24, request->len);
 
-    return write_sync(ioc, buf, sizeof(buf), NULL);
+    return nbd_write(ioc, buf, sizeof(buf), NULL);
 }
 
 ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
@@ -768,7 +768,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync_eof(ioc, buf, sizeof(buf), errp);
+    ret = nbd_read_eof(ioc, buf, sizeof(buf), errp);
     if (ret <= 0) {
         return ret;
     }
diff --git a/nbd/common.c b/nbd/common.c
index bd81637..d6b719d 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -24,12 +24,8 @@
  * The function may be called from coroutine or from non-coroutine context.
  * When called from non-coroutine context @ioc must be in blocking mode.
  */
-ssize_t nbd_wr_syncv(QIOChannel *ioc,
-                     struct iovec *iov,
-                     size_t niov,
-                     size_t length,
-                     bool do_read,
-                     Error **errp)
+ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
+                bool do_read, Error **errp)
 {
     ssize_t done = 0;
     struct iovec *local_iov = g_new(struct iovec, niov);
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index d607164..753cb9d 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -94,14 +94,14 @@
 #define NBD_ENOSPC     28
 #define NBD_ESHUTDOWN  108
 
-/* read_sync_eof
+/* nbd_read_eof
  * Tries to read @size bytes from @ioc. Returns number of bytes actually read.
  * May return a value >= 0 and < size only on EOF, i.e. when iteratively called
- * qio_channel_readv() returns 0. So, there are no needs to call read_sync_eof
+ * qio_channel_readv() returns 0. So, there is no need to call nbd_read_eof
  * iteratively.
  */
-static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size,
-                                    Error **errp)
+static inline ssize_t nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
+                                   Error **errp)
 {
     struct iovec iov = { .iov_base = buffer, .iov_len = size };
     /* Sockets are kept in blocking mode in the negotiation phase.  After
@@ -109,16 +109,16 @@ static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size,
      * our request/reply.  Synchronization is done with recv_coroutine, so
      * that this is coroutine-safe.
      */
-    return nbd_wr_syncv(ioc, &iov, 1, size, true, errp);
+    return nbd_rwv(ioc, &iov, 1, size, true, errp);
 }
 
-/* read_sync
+/* nbd_read
  * Reads @size bytes from @ioc. Returns 0 on success.
  */
-static inline int read_sync(QIOChannel *ioc, void *buffer, size_t size,
-                            Error **errp)
+static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
+                           Error **errp)
 {
-    ssize_t ret = read_sync_eof(ioc, buffer, size, errp);
+    ssize_t ret = nbd_read_eof(ioc, buffer, size, errp);
 
     if (ret >= 0 && ret != size) {
         ret = -EINVAL;
@@ -128,15 +128,15 @@ static inline int read_sync(QIOChannel *ioc, void *buffer, size_t size,
     return ret < 0 ? ret : 0;
 }
 
-/* write_sync
+/* nbd_write
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
-static inline int write_sync(QIOChannel *ioc, const void *buffer, size_t size,
-                             Error **errp)
+static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
+                            Error **errp)
 {
     struct iovec iov = { .iov_base = (void *) buffer, .iov_len = size };
 
-    ssize_t ret = nbd_wr_syncv(ioc, &iov, 1, size, false, errp);
+    ssize_t ret = nbd_rwv(ioc, &iov, 1, size, false, errp);
 
     assert(ret < 0 || ret == size);
 
diff --git a/nbd/server.c b/nbd/server.c
index f2b1aa4..d8bd927 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,7 +124,7 @@ static int nbd_negotiate_read(QIOChannel *ioc, void *buffer, size_t size)
                                   nbd_negotiate_continue,
                                   qemu_coroutine_self(),
                                   NULL);
-    ret = read_sync(ioc, buffer, size, NULL);
+    ret = nbd_read(ioc, buffer, size, NULL);
     g_source_remove(watch);
     return ret;
 
@@ -142,7 +142,7 @@ static int nbd_negotiate_write(QIOChannel *ioc, const void *buffer, size_t size)
                                   nbd_negotiate_continue,
                                   qemu_coroutine_self(),
                                   NULL);
-    ret = write_sync(ioc, buffer, size, NULL);
+    ret = nbd_write(ioc, buffer, size, NULL);
     g_source_remove(watch);
     return ret;
 }
@@ -694,7 +694,7 @@ static ssize_t nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
     uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync(ioc, buf, sizeof(buf), NULL);
+    ret = nbd_read(ioc, buf, sizeof(buf), NULL);
     if (ret < 0) {
         return ret;
     }
@@ -745,7 +745,7 @@ static ssize_t nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
-    return write_sync(ioc, buf, sizeof(buf), NULL);
+    return nbd_write(ioc, buf, sizeof(buf), NULL);
 }
 
 #define MAX_NBD_REQUESTS 16
@@ -1048,7 +1048,7 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
         qio_channel_set_cork(client->ioc, true);
         rc = nbd_send_reply(client->ioc, reply);
         if (rc >= 0) {
-            ret = write_sync(client->ioc, req->data, len, NULL);
+            ret = nbd_write(client->ioc, req->data, len, NULL);
             if (ret < 0) {
                 rc = -EIO;
             }
@@ -1123,7 +1123,7 @@ static ssize_t nbd_co_receive_request(NBDRequestData *req,
     if (request->type == NBD_CMD_WRITE) {
         TRACE("Reading %" PRIu32 " byte(s)", request->len);
 
-        if (read_sync(client->ioc, req->data, request->len, NULL) < 0) {
+        if (nbd_read(client->ioc, req->data, request->len, NULL) < 0) {
             LOG("reading from socket failed");
             rc = -EIO;
             goto out;
-- 
1.8.3.1
