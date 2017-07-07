Received: from eggs.gnu.org ([2001:4830:134:3::10]:40412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCM-0000sd-9e
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCG-0001EO-Ma
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27852 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCG-0001DH-0q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:11 +0300
Message-Id: <20170707152918.23086-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 03/10] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Move to modern errp scheme from just LOGging errors.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 266 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 160 insertions(+), 106 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index a6a57ce7c1..00a7c606ae 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -134,7 +134,7 @@ static void nbd_client_receive_next_request(NBDClient *client);
 /* Send a reply header, including length, but no payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
-                                      uint32_t opt, uint32_t len)
+                                      uint32_t opt, uint32_t len, Error **errp)
 {
     uint64_t magic;
 
@@ -142,23 +142,26 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
           type, opt, len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
-    if (nbd_write(ioc, &magic, sizeof(magic), NULL) < 0) {
-        LOG("write failed (rep magic)");
+    if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
+        error_prepend(errp, "write failed (rep magic): ");
         return -EINVAL;
     }
+
     opt = cpu_to_be32(opt);
-    if (nbd_write(ioc, &opt, sizeof(opt), NULL) < 0) {
-        LOG("write failed (rep opt)");
+    if (nbd_write(ioc, &opt, sizeof(opt), errp) < 0) {
+        error_prepend(errp, "write failed (rep opt): ");
         return -EINVAL;
     }
+
     type = cpu_to_be32(type);
-    if (nbd_write(ioc, &type, sizeof(type), NULL) < 0) {
-        LOG("write failed (rep type)");
+    if (nbd_write(ioc, &type, sizeof(type), errp) < 0) {
+        error_prepend(errp, "write failed (rep type): ");
         return -EINVAL;
     }
+
     len = cpu_to_be32(len);
-    if (nbd_write(ioc, &len, sizeof(len), NULL) < 0) {
-        LOG("write failed (rep data length)");
+    if (nbd_write(ioc, &len, sizeof(len), errp) < 0) {
+        error_prepend(errp, "write failed (rep data length): ");
         return -EINVAL;
     }
     return 0;
@@ -166,16 +169,17 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
 
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
@@ -188,16 +192,17 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
     len = strlen(msg);
     assert(len < 4096);
     TRACE("sending error message \"%s\"", msg);
-    ret = nbd_negotiate_send_rep_len(ioc, type, opt, len);
+    ret = nbd_negotiate_send_rep_len(ioc, type, opt, len, errp);
     if (ret < 0) {
         goto out;
     }
-    if (nbd_write(ioc, msg, len, NULL) < 0) {
-        LOG("write failed (error message)");
+    if (nbd_write(ioc, msg, len, errp) < 0) {
+        error_prepend(errp, "write failed (error message): ");
         ret = -EIO;
     } else {
         ret = 0;
     }
+
 out:
     g_free(msg);
     return ret;
@@ -205,7 +210,8 @@ out:
 
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
+static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp,
+                                       Error **errp)
 {
     size_t name_len, desc_len;
     uint32_t len;
@@ -217,53 +223,60 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
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
-    if (nbd_write(ioc, &len, sizeof(len), NULL) < 0) {
-        LOG("write failed (name length)");
+    if (nbd_write(ioc, &len, sizeof(len), errp) < 0) {
+        error_prepend(errp, "write failed (name length): ");
         return -EINVAL;
     }
-    if (nbd_write(ioc, name, name_len, NULL) < 0) {
-        LOG("write failed (name buffer)");
+
+    if (nbd_write(ioc, name, name_len, errp) < 0) {
+        error_prepend(errp, "write failed (name buffer): ");
         return -EINVAL;
     }
-    if (nbd_write(ioc, desc, desc_len, NULL) < 0) {
-        LOG("write failed (description buffer)");
+
+    if (nbd_write(ioc, desc, desc_len, errp) < 0) {
+        error_prepend(errp, "write failed (description buffer): ");
         return -EINVAL;
     }
+
     return 0;
 }
 
 /* Process the NBD_OPT_LIST command, with a potential series of replies.
  * Return -errno on error, 0 on success. */
-static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
+static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length,
+                                     Error **errp)
 {
     NBDExport *exp;
 
     if (length) {
-        if (nbd_drop(client->ioc, length, NULL) < 0) {
+        if (nbd_drop(client->ioc, length, errp) < 0) {
             return -EIO;
         }
         return nbd_negotiate_send_rep_err(client->ioc,
                                           NBD_REP_ERR_INVALID, NBD_OPT_LIST,
+                                          errp,
                                           "OPT_LIST should not have length");
     }
 
     /* For each export, send a NBD_REP_SERVER reply. */
     QTAILQ_FOREACH(exp, &exports, next) {
-        if (nbd_negotiate_send_rep_list(client->ioc, exp)) {
+        if (nbd_negotiate_send_rep_list(client->ioc, exp, errp)) {
             return -EINVAL;
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
     char name[NBD_MAX_NAME_SIZE + 1];
 
@@ -272,11 +285,11 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
      */
     TRACE("Checking length");
     if (length >= sizeof(name)) {
-        LOG("Bad length received");
+        error_setg(errp, "Bad length received");
         return -EINVAL;
     }
-    if (nbd_read(client->ioc, name, length, NULL) < 0) {
-        LOG("read failed");
+    if (nbd_read(client->ioc, name, length, errp) < 0) {
+        error_prepend(errp, "read failed: ");
         return -EINVAL;
     }
     name[length] = '\0';
@@ -285,7 +298,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 
     client->exp = nbd_export_find(name);
     if (!client->exp) {
-        LOG("export not found");
+        error_setg(errp, "export not found");
         return -EINVAL;
     }
 
@@ -298,7 +311,8 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
 static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
-                                                 uint32_t length)
+                                                 uint32_t length,
+                                                 Error **errp)
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
@@ -307,23 +321,24 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     TRACE("Setting up TLS");
     ioc = client->ioc;
     if (length) {
-        if (nbd_drop(ioc, length, NULL) < 0) {
+        if (nbd_drop(ioc, length, errp) < 0) {
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
@@ -342,7 +357,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     g_main_loop_unref(data.loop);
     if (data.error) {
         object_unref(OBJECT(tioc));
-        error_free(data.error);
+        error_propagate(errp, data.error);
         return NULL;
     }
 
@@ -352,14 +367,16 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 /* nbd_negotiate_options
  * Process all NBD_OPT_* client option commands.
  * Return:
- * -errno  on error
- * 0       on successful negotiation
- * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect
+ * -errno  on error, errp is set
+ * 0       on successful negotiation, errp is not set
+ * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
+ *         errp is not set
  */
-static int nbd_negotiate_options(NBDClient *client)
+static int nbd_negotiate_options(NBDClient *client, Error **errp)
 {
     uint32_t flags;
     bool fixedNewstyle = false;
+    Error *local_err = NULL;
 
     /* Client sends:
         [ 0 ..   3]   client flags
@@ -375,8 +392,8 @@ static int nbd_negotiate_options(NBDClient *client)
         ...           Rest of request
     */
 
-    if (nbd_read(client->ioc, &flags, sizeof(flags), NULL) < 0) {
-        LOG("read failed");
+    if (nbd_read(client->ioc, &flags, sizeof(flags), errp) < 0) {
+        error_prepend(errp, "read failed: ");
         return -EIO;
     }
     TRACE("Checking client flags");
@@ -392,7 +409,7 @@ static int nbd_negotiate_options(NBDClient *client)
         flags &= ~NBD_FLAG_C_NO_ZEROES;
     }
     if (flags != 0) {
-        TRACE("Unknown client flags 0x%" PRIx32 " received", flags);
+        error_setg(errp, "Unknown client flags 0x%" PRIx32 " received", flags);
         return -EIO;
     }
 
@@ -401,26 +418,25 @@ static int nbd_negotiate_options(NBDClient *client)
         uint32_t clientflags, length;
         uint64_t magic;
 
-        if (nbd_read(client->ioc, &magic, sizeof(magic), NULL) < 0) {
-            LOG("read failed");
+        if (nbd_read(client->ioc, &magic, sizeof(magic), errp) < 0) {
+            error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
         TRACE("Checking opts magic");
         if (magic != be64_to_cpu(NBD_OPTS_MAGIC)) {
-            LOG("Bad magic received");
+            error_setg(errp, "Bad magic received");
             return -EINVAL;
         }
 
         if (nbd_read(client->ioc, &clientflags,
-                      sizeof(clientflags), NULL) < 0)
-        {
-            LOG("read failed");
+                     sizeof(clientflags), errp) < 0) {
+            error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
         clientflags = be32_to_cpu(clientflags);
 
-        if (nbd_read(client->ioc, &length, sizeof(length), NULL) < 0) {
-            LOG("read failed");
+        if (nbd_read(client->ioc, &length, sizeof(length), errp) < 0) {
+            error_prepend(errp, "read failed: ");
             return -EINVAL;
         }
         length = be32_to_cpu(length);
@@ -430,12 +446,12 @@ static int nbd_negotiate_options(NBDClient *client)
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
@@ -445,16 +461,17 @@ static int nbd_negotiate_options(NBDClient *client)
 
             case NBD_OPT_EXPORT_NAME:
                 /* No way to return an error to client, so drop connection */
-                TRACE("Option 0x%x not permitted before TLS", clientflags);
+                error_setg(errp, "Option 0x%x not permitted before TLS",
+                           clientflags);
                 return -EINVAL;
 
             default:
-                if (nbd_drop(client->ioc, length, NULL) < 0) {
+                if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_TLS_REQD,
-                                                 clientflags,
+                                                 clientflags, errp,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  clientflags);
@@ -470,7 +487,7 @@ static int nbd_negotiate_options(NBDClient *client)
         } else if (fixedNewstyle) {
             switch (clientflags) {
             case NBD_OPT_LIST:
-                ret = nbd_negotiate_handle_list(client, length);
+                ret = nbd_negotiate_handle_list(client, length, errp);
                 if (ret < 0) {
                     return ret;
                 }
@@ -480,25 +497,33 @@ static int nbd_negotiate_options(NBDClient *client)
                 /* NBD spec says we must try to reply before
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
-                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags);
+                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags,
+                                       &local_err);
+
+                if (local_err != NULL) {
+                    TRACE("Reply to NBD_OPT_ABORT request failed: %s",
+                          error_get_pretty(local_err));
+                    error_free(local_err);
+                }
+
                 return 1;
 
             case NBD_OPT_EXPORT_NAME:
-                return nbd_negotiate_handle_export_name(client, length);
+                return nbd_negotiate_handle_export_name(client, length, errp);
 
             case NBD_OPT_STARTTLS:
-                if (nbd_drop(client->ioc, length, NULL) < 0) {
+                if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
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
@@ -506,12 +531,12 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 break;
             default:
-                if (nbd_drop(client->ioc, length, NULL) < 0) {
+                if (nbd_drop(client->ioc, length, errp) < 0) {
                     return -EIO;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_UNSUP,
-                                                 clientflags,
+                                                 clientflags, errp,
                                                  "Unsupported option 0x%"
                                                  PRIx32,
                                                  clientflags);
@@ -527,10 +552,10 @@ static int nbd_negotiate_options(NBDClient *client)
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
@@ -539,11 +564,12 @@ static int nbd_negotiate_options(NBDClient *client)
 
 /* nbd_negotiate
  * Return:
- * -errno  on error
- * 0       on successful negotiation
- * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect
+ * -errno  on error, errp is set
+ * 0       on successful negotiation, errp is not set
+ * 1       if client sent NBD_OPT_ABORT, i.e. on valid disconnect,
+ *         errp is not set
  */
-static coroutine_fn int nbd_negotiate(NBDClient *client)
+static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
     char buf[8 + 8 + 8 + 128];
     int ret;
@@ -585,21 +611,23 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 16, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
 
-        if (nbd_write(client->ioc, buf, sizeof(buf), NULL) < 0) {
-            LOG("write failed");
+        if (nbd_write(client->ioc, buf, sizeof(buf), errp) < 0) {
+            error_prepend(errp, "write failed: ");
             return -EINVAL;
         }
     } else {
         stq_be_p(buf + 8, NBD_OPTS_MAGIC);
         stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
 
-        if (nbd_write(client->ioc, buf, 18, NULL) < 0) {
-            LOG("write failed");
+        if (nbd_write(client->ioc, buf, 18, errp) < 0) {
+            error_prepend(errp, "write failed: ");
             return -EINVAL;
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
 
@@ -608,9 +636,9 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        ret = nbd_write(client->ioc, buf + 18, len, NULL);
+        ret = nbd_write(client->ioc, buf + 18, len, errp);
         if (ret < 0) {
-            LOG("write failed");
+            error_prepend(errp, "write failed: ");
             return ret;
         }
     }
@@ -620,13 +648,14 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
     return 0;
 }
 
-static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
+static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request,
+                               Error **errp)
 {
     uint8_t buf[NBD_REQUEST_SIZE];
     uint32_t magic;
     int ret;
 
-    ret = nbd_read(ioc, buf, sizeof(buf), NULL);
+    ret = nbd_read(ioc, buf, sizeof(buf), errp);
     if (ret < 0) {
         return ret;
     }
@@ -652,7 +681,7 @@ static int nbd_receive_request(QIOChannel *ioc, NBDRequest *request)
           magic, request->flags, request->type, request->from, request->len);
 
     if (magic != NBD_REQUEST_MAGIC) {
-        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
     return 0;
@@ -998,13 +1027,14 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
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
 
@@ -1026,27 +1056,29 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
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
 
-        if (nbd_read(client->ioc, req->data, request->len, NULL) < 0) {
-            LOG("reading from socket failed");
+        if (nbd_read(client->ioc, req->data, request->len, errp) < 0) {
+            error_prepend(errp, "reading from socket failed: ");
             return -EIO;
         }
         req->complete = true;
@@ -1054,18 +1086,18 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request)
 
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
 
@@ -1083,6 +1115,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     int ret;
     int flags;
     int reply_data_len = 0;
+    Error *local_err = NULL;
 
     TRACE("Reading request.");
     if (client->closing) {
@@ -1091,7 +1124,7 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     req = nbd_request_get(client);
-    ret = nbd_co_receive_request(req, &request);
+    ret = nbd_co_receive_request(req, &request, &local_err);
     client->recv_coroutine = NULL;
     nbd_client_receive_next_request(client);
     if (ret == -EIO) {
@@ -1122,7 +1155,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         if (request.flags & NBD_CMD_FLAG_FUA) {
             ret = blk_co_flush(exp->blk);
             if (ret < 0) {
-                LOG("flush failed");
+                error_setg_errno(&local_err, -ret, "flush failed");
                 reply.error = -ret;
                 break;
             }
@@ -1131,7 +1164,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pread(exp->blk, request.from + exp->dev_offset,
                         req->data, request.len);
         if (ret < 0) {
-            LOG("reading from file failed");
+            error_setg_errno(&local_err, -ret, "reading from file failed");
             reply.error = -ret;
             break;
         }
@@ -1158,7 +1191,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pwrite(exp->blk, request.from + exp->dev_offset,
                          req->data, request.len, flags);
         if (ret < 0) {
-            LOG("writing to file failed");
+            error_setg_errno(&local_err, -ret, "writing to file failed");
             reply.error = -ret;
         }
 
@@ -1167,7 +1200,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         TRACE("Request type is WRITE_ZEROES");
 
         if (exp->nbdflags & NBD_FLAG_READ_ONLY) {
-            TRACE("Server is read-only, return error");
+            error_setg(&local_err, "Server is read-only, return error");
             reply.error = EROFS;
             break;
         }
@@ -1184,7 +1217,7 @@ static coroutine_fn void nbd_trip(void *opaque)
         ret = blk_pwrite_zeroes(exp->blk, request.from + exp->dev_offset,
                                 request.len, flags);
         if (ret < 0) {
-            LOG("writing to file failed");
+            error_setg_errno(&local_err, -ret, "writing to file failed");
             reply.error = -ret;
         }
 
@@ -1198,7 +1231,7 @@ static coroutine_fn void nbd_trip(void *opaque)
 
         ret = blk_co_flush(exp->blk);
         if (ret < 0) {
-            LOG("flush failed");
+            error_setg_errno(&local_err, -ret, "flush failed");
             reply.error = -ret;
         }
 
@@ -1208,21 +1241,35 @@ static coroutine_fn void nbd_trip(void *opaque)
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
+        /* If we are here local_err is not fatal error, already stored in
+         * reply.error */
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
 
@@ -1234,6 +1281,9 @@ done:
     return;
 
 disconnect:
+    if (local_err) {
+        error_reportf_err(local_err, "Disconnect client, due to: ");
+    }
     nbd_request_put(req);
     client_close(client, true);
     nbd_client_put(client);
@@ -1252,6 +1302,7 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 {
     NBDClient *client = opaque;
     NBDExport *exp = client->exp;
+    Error *local_err = NULL;
 
     if (exp) {
         nbd_export_get(exp);
@@ -1259,7 +1310,10 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
     }
     qemu_co_mutex_init(&client->send_lock);
 
-    if (nbd_negotiate(client)) {
+    if (nbd_negotiate(client, &local_err)) {
+        if (local_err) {
+            error_report_err(local_err);
+        }
         client_close(client, false);
         return;
     }
-- 
2.11.1
