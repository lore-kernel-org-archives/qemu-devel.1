Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAr-0005SD-0S
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000PU-6t
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:05 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23766 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NZ-ES
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:48 +0300
Message-Id: <20170530143052.165002-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 15/19] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Move to modern errp scheme from just LOGging errors.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 257 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 150 insertions(+), 107 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0e53d3dd91..3035fb6586 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -134,7 +134,7 @@ static void nbd_client_receive_next_request(NBDClient *client);
 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
-                                      uint32_t opt, uint32_t len)
+                                      uint32_t opt, uint32_t len, Error **errp)
 {
     int ret;
     uint64_t magic;
@@ -143,30 +143,30 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
           type, opt, len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
-    ret = write_sync(ioc, &magic, sizeof(magic), NULL);
+    ret = write_sync(ioc, &magic, sizeof(magic), errp);
     if (ret < 0) {
-        LOG("write failed (rep magic)");
+        error_prepend(errp, "write failed (rep magic): ");
         return ret;
     }
 
     opt = cpu_to_be32(opt);
-    ret = write_sync(ioc, &opt, sizeof(opt), NULL);
+    ret = write_sync(ioc, &opt, sizeof(opt), errp);
     if (ret < 0) {
-        LOG("write failed (rep opt)");
+        error_prepend(errp, "write failed (rep opt): ");
         return ret;
     }
 
     type = cpu_to_be32(type);
-    ret = write_sync(ioc, &type, sizeof(type), NULL);
+    ret = write_sync(ioc, &type, sizeof(type), errp);
     if (ret < 0) {
-        LOG("write failed (rep type)");
+        error_prepend(errp, "write failed (rep type): ");
         return ret;
     }
 
     len = cpu_to_be32(len);
-    ret = write_sync(ioc, &len, sizeof(len), NULL);
+    ret = write_sync(ioc, &len, sizeof(len), errp);
     if (ret < 0) {
-        LOG("write failed (rep data length)");
+        error_prepend(errp, "write failed (rep data length): ");
         return ret;
     }
     return 0;
@@ -174,16 +174,17 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
 
 /* Send a reply header with default 0 length.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep(QIOChannel *ioc, uint32_t type, uint32_t opt)
+static int nbd_negotiate_send_rep(QIOChannel *ioc, uint32_t type, uint32_t opt,
+                                  Error **errp)
 {
-    return nbd_negotiate_send_rep_len(ioc, type, opt, 0);
+    return nbd_negotiate_send_rep_len(ioc, type, opt, 0, errp);
 }
 
 /* Send an error reply.
  * Return -errno on error, 0 on success. */
-static int GCC_FMT_ATTR(4, 5)
+static int GCC_FMT_ATTR(5, 6)
 nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
-                           uint32_t opt, const char *fmt, ...)
+                           uint32_t opt, Error **errp, const char *fmt, ...)
 {
     va_list va;
     char *msg;
@@ -196,14 +197,14 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
     len = strlen(msg);
     assert(len < 4096);
     TRACE("sending error message \"%s\"", msg);
-    ret = nbd_negotiate_send_rep_len(ioc, type, opt, len);
+    ret = nbd_negotiate_send_rep_len(ioc, type, opt, len, errp);
     if (ret < 0) {
         goto out;
     }
 
-    ret = write_sync(ioc, msg, len, NULL);
+    ret = write_sync(ioc, msg, len, errp);
     if (ret < 0) {
-        LOG("write failed (error message)");
+        error_prepend(errp, "write failed (error message): ");
     }
 
 out:
@@ -213,7 +214,8 @@ out:
 
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
+static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
+                                       Error **errp)
 {
     size_t name_len, desc_len;
     uint32_t len;
@@ -225,27 +227,28 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
     name_len = strlen(name);
     desc_len = strlen(desc);
     len = name_len + desc_len + sizeof(len);
-    ret = nbd_negotiate_send_rep_len(ioc, NBD_REP_SERVER, NBD_OPT_LIST, len);
+    ret = nbd_negotiate_send_rep_len(ioc, NBD_REP_SERVER, NBD_OPT_LIST, len,
+                                     errp);
     if (ret < 0) {
         return ret;
     }
 
     len = cpu_to_be32(name_len);
-    ret = write_sync(ioc, &len, sizeof(len), NULL);
+    ret = write_sync(ioc, &len, sizeof(len), errp);
     if (ret < 0) {
-        LOG("write failed (name length)");
+        error_prepend(errp, "write failed (name length): ");
         return ret;
     }
 
-    ret = write_sync(ioc, name, name_len, NULL);
+    ret = write_sync(ioc, name, name_len, errp);
     if (ret < 0) {
-        LOG("write failed (name buffer)");
+        error_prepend(errp, "write failed (name buffer): ");
         return ret;
     }
 
-    ret = write_sync(ioc, desc, desc_len, NULL);
+    ret = write_sync(ioc, desc, desc_len, errp);
     if (ret < 0) {
-        LOG("write failed (description buffer)");
+        error_prepend(errp, "write failed (description buffer): ");
         return ret;
     }
 
@@ -254,33 +257,36 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
 
 /* Process the NBD_OPT_LIST command, with a potential series of replies.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
+static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
+                                     Error **errp)
 {
     int ret;
     NBDExport *exp;
 
     if (length) {
-        ret = drop_sync(client->ioc, length, NULL);
+        ret = drop_sync(client->ioc, length, errp);
         if (ret < 0) {
             return ret;
         }
         return nbd_negotiate_send_rep_err(client->ioc,
                                           NBD_REP_ERR_INVALID, NBD_OPT_LIST,
+                                          errp,
                                           "OPT_LIST should not have length");
     }
 
     /* For each export, send a NBD_REP_SERVER reply. */
     QTAILQ_FOREACH(exp, &exports, next) {
-        ret = nbd_negotiate_send_rep_list(client->ioc, exp);
+        ret = nbd_negotiate_send_rep_list(client->ioc, exp, errp);
         if (ret < 0) {
             return ret;
         }
     }
     /* Finish with a NBD_REP_ACK. */
-    return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, NBD_OPT_LIST);
+    return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, NBD_OPT_LIST, errp);
 }
 
-static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
+static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
+                                            Error **errp)
 {
     int ret;
     char name[NBD_MAX_NAME_SIZE + 1];
@@ -290,13 +296,13 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
      */
     TRACE("Checking length");
     if (length >= sizeof(name)) {
-        LOG("Bad length received");
+        error_setg(errp, "Bad length received");
         return -EINVAL;
     }
 
-    ret = read_sync(client->ioc, name, length, NULL);
+    ret = read_sync(client->ioc, name, length, errp);
     if (ret < 0) {
-        LOG("read failed");
+        error_setg(errp, "read failed");
         return ret;
     }
     name[length] = '\0';
@@ -305,7 +311,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 
     client->exp = nbd_export_find(name);
     if (!client->exp) {
-        LOG("export not found");
+        error_setg(errp, "export not found");
         return -EINVAL;
     }
 
@@ -318,7 +324,8 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
 static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
-                                                 uint32_t length)
+                                                 uint32_t length,
+                                                 Error **errp)
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
@@ -327,23 +334,24 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     TRACE("Setting up TLS");
     ioc = client->ioc;
     if (length) {
-        if (drop_sync(ioc, length, NULL) < 0) {
+        if (drop_sync(ioc, length, errp) < 0) {
             return NULL;
         }
         nbd_negotiate_send_rep_err(ioc, NBD_REP_ERR_INVALID, NBD_OPT_STARTTLS,
+                                   errp,
                                    "OPT_STARTTLS should not have length");
         return NULL;
     }
 
     if (nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
-                               NBD_OPT_STARTTLS) < 0) {
+                               NBD_OPT_STARTTLS, errp) < 0) {
         return NULL;
     }
 
     tioc = qio_channel_tls_new_server(ioc,
                                       client->tlscreds,
                                       client->tlsaclname,
-                                      NULL);
+                                      errp);
     if (!tioc) {
         return NULL;
     }
@@ -362,7 +370,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     g_main_loop_unref(data.loop);
     if (data.error) {
         object_unref(OBJECT(tioc));
-        error_free(data.error);
+        error_propagate(errp, data.error);
         return NULL;
     }
 
@@ -372,15 +380,16 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 /* nbd_negotiate_options
  * Process all NBD_OPT_* client option commands.
  * Return:
- * < 0 on error
- * 0   on successful negotiation
- * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
+ * < 0 on error, errp is set
+ * 0   on successful negotiation, errp is not set
+ * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect, errp is not set
  */
-static int nbd_negotiate_options(NBDClient *client)
+static int nbd_negotiate_options(NBDClient *client, Error **errp)
 {
     int ret;
     uint32_t flags;
     bool fixedNewstyle = false;
+    Error *local_err = NULL;
 
     /* Client sends:
         [ 0 ..   3]   client flags
@@ -396,9 +405,9 @@ static int nbd_negotiate_options(NBDClient *client)
         ...           Rest of request
     */
 
-    ret = read_sync(client->ioc, &flags, sizeof(flags), NULL);
+    ret = read_sync(client->ioc, &flags, sizeof(flags), errp);
     if (ret < 0) {
-        LOG("read failed");
+        error_prepend(errp, "read failed: ");
         return ret;
     }
     TRACE("Checking client flags");
@@ -414,7 +423,7 @@ static int nbd_negotiate_options(NBDClient *client)
         flags &= ~NBD_FLAG_C_NO_ZEROES;
     }
     if (flags != 0) {
-        TRACE("Unknown client flags 0x%" PRIx32 " received", flags);
+        error_setg(errp, "Unknown client flags 0x%" PRIx32 " received", flags);
         return -EIO;
     }
 
@@ -423,27 +432,27 @@ static int nbd_negotiate_options(NBDClient *client)
         uint32_t clientflags, length;
         uint64_t magic;
 
-        ret = read_sync(client->ioc, &magic, sizeof(magic), NULL);
+        ret = read_sync(client->ioc, &magic, sizeof(magic), errp);
         if (ret < 0) {
-            LOG("read failed");
+            error_prepend(errp, "read failed: ");
             return ret;
         }
         TRACE("Checking opts magic");
         if (magic != be64_to_cpu(NBD_OPTS_MAGIC)) {
-            LOG("Bad magic received");
+            error_setg(errp, "Bad magic received");
             return -EINVAL;
         }
 
-        ret = read_sync(client->ioc, &clientflags, sizeof(clientflags), NULL);
+        ret = read_sync(client->ioc, &clientflags, sizeof(clientflags), errp);
         if (ret < 0) {
-            LOG("read failed");
+            error_prepend(errp, "read failed: ");
             return ret;
         }
         clientflags = be32_to_cpu(clientflags);
 
-        ret = read_sync(client->ioc, &length, sizeof(length), NULL);
+        ret = read_sync(client->ioc, &length, sizeof(length), errp);
         if (ret < 0) {
-            LOG("read failed");
+            error_prepend(errp, "read failed: ");
             return ret;
         }
         length = be32_to_cpu(length);
@@ -453,12 +462,12 @@ static int nbd_negotiate_options(NBDClient *client)
             client->ioc == (QIOChannel *)client->sioc) {
             QIOChannel *tioc;
             if (!fixedNewstyle) {
-                TRACE("Unsupported option 0x%" PRIx32, clientflags);
+                error_setg(errp, "Unsupported option 0x%" PRIx32, clientflags);
                 return -EINVAL;
             }
             switch (clientflags) {
             case NBD_OPT_STARTTLS:
-                tioc = nbd_negotiate_handle_starttls(client, length);
+                tioc = nbd_negotiate_handle_starttls(client, length, errp);
                 if (!tioc) {
                     return -EIO;
                 }
@@ -468,17 +477,18 @@ static int nbd_negotiate_options(NBDClient *client)
 
             case NBD_OPT_EXPORT_NAME:
                 /* No way to return an error to client, so drop connection */
-                TRACE("Option 0x%x not permitted before TLS", clientflags);
+                error_setg(errp, "Option 0x%x not permitted before TLS",
+                           clientflags);
                 return -EINVAL;
 
             default:
-                ret = drop_sync(client->ioc, length, NULL);
+                ret = drop_sync(client->ioc, length, errp);
                 if (ret < 0) {
                     return ret;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_TLS_REQD,
-                                                 clientflags,
+                                                 clientflags, errp,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  clientflags);
@@ -494,7 +504,7 @@ static int nbd_negotiate_options(NBDClient *client)
         } else if (fixedNewstyle) {
             switch (clientflags) {
             case NBD_OPT_LIST:
-                ret = nbd_negotiate_handle_list(client, length);
+                ret = nbd_negotiate_handle_list(client, length, errp);
                 if (ret < 0) {
                     return ret;
                 }
@@ -505,26 +515,33 @@ static int nbd_negotiate_options(NBDClient *client)
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
                 ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
-                                             clientflags);
-                return ret < 0 && ret != -EPIPE ? ret : 1;
+                                             clientflags, &local_err);
+
+                if (ret < 0 && ret != -EPIPE) {
+                    error_propagate(errp, local_err);
+                    return ret;
+                }
+
+                error_free(local_err);
+                return 1;
 
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length);
+                return nbd_negotiate_handle_export_name(client, length, errp);
 
             case NBD_OPT_STARTTLS:
-                ret = drop_sync(client->ioc, length, NULL);
+                ret = drop_sync(client->ioc, length, errp);
                 if (ret < 0) {
                     return ret;
                 }
                 if (client->tlscreds) {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
                                                      NBD_REP_ERR_INVALID,
-                                                     clientflags,
+                                                     clientflags, errp,
                                                      "TLS already enabled");
                 } else {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
                                                      NBD_REP_ERR_POLICY,
-                                                     clientflags,
+                                                     clientflags, errp,
                                                      "TLS not configured");
                 }
                 if (ret < 0) {
@@ -532,13 +549,13 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 break;
             default:
-                ret = drop_sync(client->ioc, length, NULL);
+                ret = drop_sync(client->ioc, length, errp);
                 if (ret < 0) {
                     return ret;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_UNSUP,
-                                                 clientflags,
+                                                 clientflags, errp,
                                                  "Unsupported option 0x%"
                                                  PRIx32,
                                                  clientflags);
@@ -554,10 +571,10 @@ static int nbd_negotiate_options(NBDClient *client)
              */
             switch (clientflags) {
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length);
+                return nbd_negotiate_handle_export_name(client, length, errp);
 
             default:
-                TRACE("Unsupported option 0x%" PRIx32, clientflags);
+                error_setg(errp, "Unsupported option 0x%" PRIx32, clientflags);
                 return -EINVAL;
             }
         }
@@ -566,11 +583,11 @@ static int nbd_negotiate_options(NBDClient *client)
 
 /* nbd_negotiate
  * Return:
- * < 0 on error
- * 0   on successful negotiation
- * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect
+ * < 0 on error, errp is set
+ * 0   on successful negotiation, errp is not set
+ * 1   if client sent NBD_OPT_ABORT, i.e. on legal disconnect, errp is not set
  */
-static coroutine_fn int nbd_negotiate(NBDClient *client)
+static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
     char buf[8 + 8 + 8 + 128];
     int ret;
@@ -618,24 +635,26 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
 
     if (oldStyle) {
         if (client->tlscreds) {
-            TRACE("TLS cannot be enabled with oldstyle protocol");
+            error_setg(errp, "TLS cannot be enabled with oldstyle protocol");
             return -EINVAL;
         }
 
-        ret = write_sync(client->ioc, buf, sizeof(buf), NULL);
+        ret = write_sync(client->ioc, buf, sizeof(buf), errp);
         if (ret < 0) {
-            LOG("write failed");
+            error_prepend(errp, "write failed: ");
             return ret;
         }
     } else {
-        ret = write_sync(client->ioc, buf, 18, NULL);
+        ret = write_sync(client->ioc, buf, 18, errp);
         if (ret < 0) {
-            LOG("write failed");
+            error_prepend(errp, "write failed: ");
             return ret;
         }
-        ret = nbd_negotiate_options(client);
+        ret = nbd_negotiate_options(client, errp);
         if (ret != 0) {
-            LOG("option negotiation failed");
+            if (ret < 0) {
+                error_prepend(errp, "option negotiation failed: ");
+            }
             return ret;
         }
 
@@ -644,9 +663,9 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        ret = write_sync(client->ioc, buf + 18, len, NULL);
+        ret = write_sync(client->ioc, buf + 18, len, errp);
         if (ret < 0) {
-            LOG("write failed");
+            error_prepend(errp, "write failed: ");
             return ret;
         }
     }
@@ -656,13 +675,14 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
     return 0;
 }
 
-static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
+static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
+                               Error **errp)
 {
     uint8_t buf[NBD_REQUEST_SIZE];
     uint32_t magic;
     int ret;
 
-    ret = read_sync(ioc, buf, sizeof(buf), NULL);
+    ret = read_sync(ioc, buf, sizeof(buf), errp);
     if (ret < 0) {
         return ret;
     }
@@ -688,7 +708,7 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
           magic, request->flags, request->type, request->from, request->len);
 
     if (magic != NBD_REQUEST_MAGIC) {
-        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
     return 0;
@@ -1034,13 +1054,14 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
  * the client (although the caller may still need to disconnect after reporting
  * the error).
  */
-static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
+static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
+                                  Error **errp)
 {
     NBDClient *client = req->client;
 
     g_assert(qemu_in_coroutine());
     assert(client->recv_coroutine == qemu_coroutine_self());
-    if (nbd_receive_request(client->ioc, request) < 0) {
+    if (nbd_receive_request(client->ioc, request, errp) < 0) {
         return -EIO;
     }
 
@@ -1062,27 +1083,29 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
      * checks as possible until after reading any NBD_CMD_WRITE
      * payload, so we can try and keep the connection alive.  */
     if ((request->from + request->len) < request->from) {
-        LOG("integer overflow detected, you're probably being attacked");
+        error_setg(errp,
+                   "integer overflow detected, you're probably being attacked");
         return -EINVAL;
     }
 
     if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE) {
         if (request->len > NBD_MAX_BUFFER_SIZE) {
-            LOG("len (%" PRIu32" ) is larger than max len (%u)",
-                request->len, NBD_MAX_BUFFER_SIZE);
+            error_setg(errp, "len (%" PRIu32" ) is larger than max len (%u)",
+                       request->len, NBD_MAX_BUFFER_SIZE);
             return -EINVAL;
         }
 
         req->data = blk_try_blockalign(client->exp->blk, request->len);
         if (req->data == NULL) {
+            error_setg(errp, "No memory");
             return -ENOMEM;
         }
     }
     if (request->type == NBD_CMD_WRITE) {
         TRACE("Reading %" PRIu32 " byte(s)", request->len);
 
-        if (read_sync(client->ioc, req->data, request->len, NULL) < 0) {
-            LOG("reading from socket failed");
+        if (read_sync(client->ioc, req->data, request->len, errp) < 0) {
+            error_prepend(errp, "reading from socket failed: ");
             return -EIO;
         }
         req->complete = true;
@@ -1090,18 +1113,18 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 
     /* Sanity checks, part 2. */
     if (request->from + request->len > client->exp->size) {
-        LOG("operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
-            ", Size: %" PRIu64, request->from, request->len,
-            (uint64_t)client->exp->size);
+        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
+                   ", Size: %" PRIu64, request->from, request->len,
+                   (uint64_t)client->exp->size);
         return request->type == NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
     }
     if (request->flags & ~(NBD_CMD_FLAG_FUA | NBD_CMD_FLAG_NO_HOLE)) {
-        LOG("unsupported flags (got 0x%x)", request->flags);
+        error_setg(errp, "unsupported flags (got 0x%x)", request->flags);
         return -EINVAL;
     }
     if (request->type != NBD_CMD_WRITE_ZEROES &&
         (request->flags & NBD_CMD_FLAG_NO_HOLE)) {
-        LOG("unexpected flags (got 0x%x)", request->flags);
+        error_setg(errp, "unexpected flags (got 0x%x)", request->flags);
         return -EINVAL;
     }
 
@@ -1119,6 +1142,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     int ret;
     int flags;
     int reply_data_len = 0;
+    Error *local_err = NULL;
 
     TRACE("Reading request.");
     if (client->closing) {
@@ -1127,7 +1151,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     req = nbd_request_get(client);
-    ret = nbd_co_receive_request(req, &request);
+    ret = nbd_co_receive_request(req, &request, &local_err);
     client->recv_coroutine = NULL;
     nbd_client_receive_next_request(client);
     if (ret == -EIO) {
@@ -1158,7 +1182,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (request.flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
             if (ret < 0) {
-                LOG("flush failed");
+                error_setg_errno(&local_err, -ret, "flush failed");
                 reply.error = -ret;
                 break;
             }
@@ -1167,7 +1191,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pread(exp->blk, request.from + exp->dev_offset,
                         req->data, request.len);
         if (ret < 0) {
-            LOG("reading from file failed");
+            error_setg_errno(&local_err, -ret, "reading from file failed");
             reply.error = -ret;
             break;
         }
@@ -1194,7 +1218,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
                          req->data, request.len, flags);
         if (ret < 0) {
-            LOG("writing to file failed");
+            error_setg_errno(&local_err, -ret, "writing to file failed");
             reply.error = -ret;
         }
 
@@ -1203,7 +1227,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         TRACE("Request type is WRITE_ZEROES");
 
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            TRACE("Server is read-only, return error");
+            error_setg(&local_err, "Server is read-only, return error");
             reply.error = EROFS;
             break;
         }
@@ -1220,7 +1244,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pwrite_zeroes(exp->blk, request.from + exp->dev_offset,
                                 request.len, flags);
         if (ret < 0) {
-            LOG("writing to file failed");
+            error_setg_errno(&local_err, -ret, "writing to file failed");
             reply.error = -ret;
         }
 
@@ -1234,7 +1258,7 @@ static coroutine_fn void nbd_trip(void *opaque)
 
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
-            LOG("flush failed");
+            error_setg_errno(&local_err, -ret, "flush failed");
             reply.error = -ret;
         }
 
@@ -1244,21 +1268,33 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_co_pdiscard(exp->blk, request.from + exp->dev_offset,
                               request.len);
         if (ret < 0) {
-            LOG("discard failed");
+            error_setg_errno(&local_err, -ret, "discard failed");
             reply.error = -ret;
         }
 
         break;
     default:
-        LOG("invalid request type (%" PRIu32 ") received", request.type);
+        error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
+                   request.type);
         reply.error = EINVAL;
     }
 
 reply:
+    if (local_err) {
+        error_report_err(local_err);
+        local_err = NULL;
+    }
+
+    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
+        error_setg(&local_err, "Failed to send reply");
+        goto disconnect;
+    }
+
     /* We must disconnect after NBD_CMD_WRITE if we did not
      * read the payload.
      */
-    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0 || !req->complete) {
+    if (!req->complete) {
+        error_setg(&local_err, "Request handling failed in intermediate state");
         goto disconnect;
     }
 
@@ -1270,6 +1306,9 @@ done:
     return;
 
 disconnect:
+    if (local_err) {
+        error_reportf_err(local_err, "Disconnect client, due to: ");
+    }
     nbd_request_put(req);
     client_close(client);
     nbd_client_put(client);
@@ -1288,11 +1327,15 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 {
     NBDClient *client = opaque;
     NBDExport *exp = client->exp;
+    Error *local_err = NULL;
 
     if (exp) {
         nbd_export_get(exp);
     }
-    if (nbd_negotiate(client)) {
+    if (nbd_negotiate(client, &local_err)) {
+        if (local_err) {
+            error_report_err(local_err);
+        }
         client_close(client);
         return;
     }
-- 
2.11.1
