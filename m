Received: from eggs.gnu.org ([2001:4830:134:3::10]:54409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3I-0001VH-VA
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3F-0004w2-73
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37408 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dAZ3E-0004ud-CX
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:45:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 May 2017 12:45:32 +0300
Message-Id: <20170516094533.6160-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170516094533.6160-1-vsementsov@virtuozzo.com>
References: <20170516094533.6160-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/5] nbd: add errp to read_sync,
 write_sync and drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

There a lot of calls of these functions, which already have errp, which
they are filling themselves. On the other hand, nbd_wr_syncv has errp
parameter too, so it would be great to connect them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c       | 76 +++++++++++++++++++++++++++---------------------------
 nbd/nbd-internal.h | 16 +++++++-----
 nbd/server.c       | 12 ++++-----
 3 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 6b74a628f1..f102375504 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -88,7 +88,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
 /* Discard length bytes from channel.  Return -errno on failure and 0 on
  * success*/
-static int drop_sync(QIOChannel *ioc, size_t size)
+static int drop_sync(QIOChannel *ioc, size_t size, Error **errp)
 {
     ssize_t ret = 0;
     char small[1024];
@@ -97,7 +97,7 @@ static int drop_sync(QIOChannel *ioc, size_t size)
     buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
     while (size > 0) {
         ssize_t count = MIN(65536, size);
-        ret = read_sync(ioc, buffer, MIN(65536, size));
+        ret = read_sync(ioc, buffer, MIN(65536, size), errp);
 
         if (ret < 0) {
             goto cleanup;
@@ -135,13 +135,13 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
     stl_be_p(&req.option, opt);
     stl_be_p(&req.length, len);
 
-    if (write_sync(ioc, &req, sizeof(req)) < 0) {
-        error_setg(errp, "Failed to send option request header");
+    if (write_sync(ioc, &req, sizeof(req), errp) < 0) {
+        error_prepend(errp, "Failed to send option request header");
         return -1;
     }
 
-    if (len && write_sync(ioc, (char *) data, len) < 0) {
-        error_setg(errp, "Failed to send option request data");
+    if (len && write_sync(ioc, (char *) data, len, errp) < 0) {
+        error_prepend(errp, "Failed to send option request data");
         return -1;
     }
 
@@ -169,8 +169,8 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
                                     nbd_opt_reply *reply, Error **errp)
 {
     QEMU_BUILD_BUG_ON(sizeof(*reply) != 20);
-    if (read_sync(ioc, reply, sizeof(*reply)) < 0) {
-        error_setg(errp, "failed to read option reply");
+    if (read_sync(ioc, reply, sizeof(*reply), errp) < 0) {
+        error_prepend(errp, "failed to read option reply");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -218,8 +218,8 @@ static int nbd_handle_reply_err(QIOChannel *ioc, nbd_opt_reply *reply,
             goto cleanup;
         }
         msg = g_malloc(reply->length + 1);
-        if (read_sync(ioc, msg, reply->length) < 0) {
-            error_setg(errp, "failed to read option error message");
+        if (read_sync(ioc, msg, reply->length, errp) < 0) {
+            error_prepend(errp, "failed to read option error message");
             goto cleanup;
         }
         msg[reply->length] = '\0';
@@ -320,8 +320,8 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         nbd_send_opt_abort(ioc);
         return -1;
     }
-    if (read_sync(ioc, &namelen, sizeof(namelen)) < 0) {
-        error_setg(errp, "failed to read option name length");
+    if (read_sync(ioc, &namelen, sizeof(namelen), errp) < 0) {
+        error_prepend(errp, "failed to read option name length");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -333,8 +333,8 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         return -1;
     }
     if (namelen != strlen(want)) {
-        if (drop_sync(ioc, len) < 0) {
-            error_setg(errp, "failed to skip export name with wrong length");
+        if (drop_sync(ioc, len, errp) < 0) {
+            error_prepend(errp, "failed to skip export name with wrong length");
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -342,15 +342,15 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     }
 
     assert(namelen < sizeof(name));
-    if (read_sync(ioc, name, namelen) < 0) {
-        error_setg(errp, "failed to read export name");
+    if (read_sync(ioc, name, namelen, errp) < 0) {
+        error_prepend(errp, "failed to read export name");
         nbd_send_opt_abort(ioc);
         return -1;
     }
     name[namelen] = '\0';
     len -= namelen;
-    if (drop_sync(ioc, len) < 0) {
-        error_setg(errp, "failed to read export description");
+    if (drop_sync(ioc, len, errp) < 0) {
+        error_prepend(errp, "failed to read export description");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -476,8 +476,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    if (read_sync(ioc, buf, 8) < 0) {
-        error_setg(errp, "Failed to read data");
+    if (read_sync(ioc, buf, 8, errp) < 0) {
+        error_prepend(errp, "Failed to read data");
         goto fail;
     }
 
@@ -502,8 +502,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    if (read_sync(ioc, &magic, sizeof(magic)) < 0) {
-        error_setg(errp, "Failed to read magic");
+    if (read_sync(ioc, &magic, sizeof(magic), errp) < 0) {
+        error_prepend(errp, "Failed to read magic");
         goto fail;
     }
     magic = be64_to_cpu(magic);
@@ -514,8 +514,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         uint16_t globalflags;
         bool fixedNewStyle = false;
 
-        if (read_sync(ioc, &globalflags, sizeof(globalflags)) < 0) {
-            error_setg(errp, "Failed to read server flags");
+        if (read_sync(ioc, &globalflags, sizeof(globalflags), errp) < 0) {
+            error_prepend(errp, "Failed to read server flags");
             goto fail;
         }
         globalflags = be16_to_cpu(globalflags);
@@ -532,8 +532,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }
         /* client requested flags */
         clientflags = cpu_to_be32(clientflags);
-        if (write_sync(ioc, &clientflags, sizeof(clientflags)) < 0) {
-            error_setg(errp, "Failed to send clientflags field");
+        if (write_sync(ioc, &clientflags, sizeof(clientflags), errp) < 0) {
+            error_prepend(errp, "Failed to send clientflags field");
             goto fail;
         }
         if (tlscreds) {
@@ -570,14 +570,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }
 
         /* Read the response */
-        if (read_sync(ioc, &s, sizeof(s)) < 0) {
-            error_setg(errp, "Failed to read export length");
+        if (read_sync(ioc, &s, sizeof(s), errp) < 0) {
+            error_prepend(errp, "Failed to read export length");
             goto fail;
         }
         *size = be64_to_cpu(s);
 
-        if (read_sync(ioc, flags, sizeof(*flags)) < 0) {
-            error_setg(errp, "Failed to read export flags");
+        if (read_sync(ioc, flags, sizeof(*flags), errp) < 0) {
+            error_prepend(errp, "Failed to read export flags");
             goto fail;
         }
         be16_to_cpus(flags);
@@ -593,15 +593,15 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
 
-        if (read_sync(ioc, &s, sizeof(s)) < 0) {
-            error_setg(errp, "Failed to read export length");
+        if (read_sync(ioc, &s, sizeof(s), errp) < 0) {
+            error_prepend(errp, "Failed to read export length");
             goto fail;
         }
         *size = be64_to_cpu(s);
         TRACE("Size is %" PRIu64, *size);
 
-        if (read_sync(ioc, &oldflags, sizeof(oldflags)) < 0) {
-            error_setg(errp, "Failed to read export flags");
+        if (read_sync(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
+            error_prepend(errp, "Failed to read export flags");
             goto fail;
         }
         be32_to_cpus(&oldflags);
@@ -616,8 +616,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
     }
 
     TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags);
-    if (zeroes && drop_sync(ioc, 124) < 0) {
-        error_setg(errp, "Failed to read reserved block");
+    if (zeroes && drop_sync(ioc, 124, errp) < 0) {
+        error_prepend(errp, "Failed to read reserved block");
         goto fail;
     }
     rc = 0;
@@ -755,7 +755,7 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     stq_be_p(buf + 16, request->from);
     stl_be_p(buf + 24, request->len);
 
-    return write_sync(ioc, buf, sizeof(buf));
+    return write_sync(ioc, buf, sizeof(buf), NULL);
 }
 
 ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
@@ -764,7 +764,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
     uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync_eof(ioc, buf, sizeof(buf));
+    ret = read_sync_eof(ioc, buf, sizeof(buf), NULL);
     if (ret <= 0) {
         return ret;
     }
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 1d479fe135..d6071640a0 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -100,7 +100,8 @@
  * qio_channel_readv() returns 0. So, there are no needs to call read_sync_eof
  * iteratively.
  */
-static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size)
+static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size,
+                                    Error **errp)
 {
     struct iovec iov = { .iov_base = buffer, .iov_len = size };
     /* Sockets are kept in blocking mode in the negotiation phase.  After
@@ -108,18 +109,20 @@ static inline ssize_t read_sync_eof(QIOChannel *ioc, void *buffer, size_t size)
      * our request/reply.  Synchronization is done with recv_coroutine, so
      * that this is coroutine-safe.
      */
-    return nbd_wr_syncv(ioc, &iov, 1, size, true, NULL);
+    return nbd_wr_syncv(ioc, &iov, 1, size, true, errp);
 }
 
 /* read_sync
  * Reads @size bytes from @ioc. Returns 0 on success.
  */
-static inline int read_sync(QIOChannel *ioc, void *buffer, size_t size)
+static inline int read_sync(QIOChannel *ioc, void *buffer, size_t size,
+                            Error **errp)
 {
-    ssize_t ret = read_sync_eof(ioc, buffer, size);
+    ssize_t ret = read_sync_eof(ioc, buffer, size, errp);
 
     if (ret >= 0 && ret != size) {
         ret = -EINVAL;
+        error_setg(errp, "End of file");
     }
 
     return ret < 0 ? ret : 0;
@@ -128,11 +131,12 @@ static inline int read_sync(QIOChannel *ioc, void *buffer, size_t size)
 /* write_sync
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
-static inline int write_sync(QIOChannel *ioc, const void *buffer, size_t size)
+static inline int write_sync(QIOChannel *ioc, const void *buffer, size_t size,
+                             Error **errp)
 {
     struct iovec iov = { .iov_base = (void *) buffer, .iov_len = size };
 
-    ssize_t ret = nbd_wr_syncv(ioc, &iov, 1, size, false, NULL);
+    ssize_t ret = nbd_wr_syncv(ioc, &iov, 1, size, false, errp);
 
     assert(ret < 0 || ret == size);
 
diff --git a/nbd/server.c b/nbd/server.c
index 1e1096c762..ee59e5d234 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -124,7 +124,7 @@ static int nbd_negotiate_read(QIOChannel *ioc, void *buffer, size_t size)
                                   nbd_negotiate_continue,
                                   qemu_coroutine_self(),
                                   NULL);
-    ret = read_sync(ioc, buffer, size);
+    ret = read_sync(ioc, buffer, size, NULL);
     g_source_remove(watch);
     return ret;
 
@@ -142,7 +142,7 @@ static int nbd_negotiate_write(QIOChannel *ioc, const void *buffer, size_t size)
                                   nbd_negotiate_continue,
                                   qemu_coroutine_self(),
                                   NULL);
-    ret = write_sync(ioc, buffer, size);
+    ret = write_sync(ioc, buffer, size, NULL);
     g_source_remove(watch);
     return ret;
 }
@@ -694,7 +694,7 @@ static ssize_t nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
     uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync(ioc, buf, sizeof(buf));
+    ret = read_sync(ioc, buf, sizeof(buf), NULL);
     if (ret < 0) {
         return ret;
     }
@@ -745,7 +745,7 @@ static ssize_t nbd_send_reply(QIOChannel *ioc, NBDReply *reply)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);
 
-    return write_sync(ioc, buf, sizeof(buf));
+    return write_sync(ioc, buf, sizeof(buf), NULL);
 }
 
 #define MAX_NBD_REQUESTS 16
@@ -1048,7 +1048,7 @@ static ssize_t nbd_co_send_reply(NBDRequestData *req, NBDReply *reply,
         qio_channel_set_cork(client->ioc, true);
         rc = nbd_send_reply(client->ioc, reply);
         if (rc >= 0) {
-            ret = write_sync(client->ioc, req->data, len);
+            ret = write_sync(client->ioc, req->data, len, NULL);
             if (ret < 0) {
                 rc = -EIO;
             }
@@ -1123,7 +1123,7 @@ static ssize_t nbd_co_receive_request(NBDRequestData *req,
     if (request->type == NBD_CMD_WRITE) {
         TRACE("Reading %" PRIu32 " byte(s)", request->len);
 
-        if (read_sync(client->ioc, req->data, request->len) < 0) {
+        if (read_sync(client->ioc, req->data, request->len, NULL) < 0) {
             LOG("reading from socket failed");
             rc = -EIO;
             goto out;
-- 
2.11.1
