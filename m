Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QF-2T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000Pe-78
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5654 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NV-JJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:46 +0300
Message-Id: <20170530143052.165002-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 13/19] nbd/server: return original error codes
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

The code in many cases return -EINVAL or -EIO instead of original error
code from, for example, write_sync(). Following patch will need EPIPE
handling, so, let's refactor this where possible (the only exclusion
is nbd_co_receive_request, with own return-code convention)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 124 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index a47f13e4fb..30dfb81a5c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -136,30 +136,38 @@ static void nbd_client_receive_next_request(NBDClient *client);
 static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
                                       uint32_t opt, uint32_t len)
 {
+    int ret;
     uint64_t magic;
 
     TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
           type, opt, len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
-    if (write_sync(ioc, &magic, sizeof(magic), NULL) < 0) {
+    ret = write_sync(ioc, &magic, sizeof(magic), NULL);
+    if (ret < 0) {
         LOG("write failed (rep magic)");
-        return -EINVAL;
+        return ret;
     }
+
     opt = cpu_to_be32(opt);
-    if (write_sync(ioc, &opt, sizeof(opt), NULL) < 0) {
+    ret = write_sync(ioc, &opt, sizeof(opt), NULL);
+    if (ret < 0) {
         LOG("write failed (rep opt)");
-        return -EINVAL;
+        return ret;
     }
+
     type = cpu_to_be32(type);
-    if (write_sync(ioc, &type, sizeof(type), NULL) < 0) {
+    ret = write_sync(ioc, &type, sizeof(type), NULL);
+    if (ret < 0) {
         LOG("write failed (rep type)");
-        return -EINVAL;
+        return ret;
     }
+
     len = cpu_to_be32(len);
-    if (write_sync(ioc, &len, sizeof(len), NULL) < 0) {
+    ret = write_sync(ioc, &len, sizeof(len), NULL);
+    if (ret < 0) {
         LOG("write failed (rep data length)");
-        return -EINVAL;
+        return ret;
     }
     return 0;
 }
@@ -192,12 +200,12 @@ nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
     if (ret < 0) {
         goto out;
     }
-    if (write_sync(ioc, msg, len, NULL) < 0) {
+
+    ret = write_sync(ioc, msg, len, NULL);
+    if (ret < 0) {
         LOG("write failed (error message)");
-        ret = -EIO;
-    } else {
-        ret = 0;
     }
+
 out:
     g_free(msg);
     return ret;
@@ -223,18 +231,24 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
     }
 
     len = cpu_to_be32(name_len);
-    if (write_sync(ioc, &len, sizeof(len), NULL) < 0) {
+    ret = write_sync(ioc, &len, sizeof(len), NULL);
+    if (ret < 0) {
         LOG("write failed (name length)");
-        return -EINVAL;
+        return ret;
     }
-    if (write_sync(ioc, name, name_len, NULL) < 0) {
+
+    ret = write_sync(ioc, name, name_len, NULL);
+    if (ret < 0) {
         LOG("write failed (name buffer)");
-        return -EINVAL;
+        return ret;
     }
-    if (write_sync(ioc, desc, desc_len, NULL) < 0) {
+
+    ret = write_sync(ioc, desc, desc_len, NULL);
+    if (ret < 0) {
         LOG("write failed (description buffer)");
-        return -EINVAL;
+        return ret;
     }
+
     return 0;
 }
 
@@ -242,11 +256,13 @@ static int nbd_negotiate_send_rep_list(QIOChannel *ioc, NBDExport *exp)
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
 {
+    int ret;
     NBDExport *exp;
 
     if (length) {
-        if (drop_sync(client->ioc, length, NULL) < 0) {
-            return -EIO;
+        ret = drop_sync(client->ioc, length, NULL);
+        if (ret < 0) {
+            return ret;
         }
         return nbd_negotiate_send_rep_err(client->ioc,
                                           NBD_REP_ERR_INVALID, NBD_OPT_LIST,
@@ -255,8 +271,9 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
 
     /* For each export, send a NBD_REP_SERVER reply. */
     QTAILQ_FOREACH(exp, &exports, next) {
-        if (nbd_negotiate_send_rep_list(client->ioc, exp)) {
-            return -EINVAL;
+        ret = nbd_negotiate_send_rep_list(client->ioc, exp);
+        if (ret < 0) {
+            return ret;
         }
     }
     /* Finish with a NBD_REP_ACK. */
@@ -265,6 +282,7 @@ static int nbd_negotiate_handle_list(NBDClient *client, uint32_t length)
 
 static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
 {
+    int ret;
     char name[NBD_MAX_NAME_SIZE + 1];
 
     /* Client sends:
@@ -275,9 +293,11 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length)
         LOG("Bad length received");
         return -EINVAL;
     }
-    if (read_sync(client->ioc, name, length, NULL) < 0) {
+
+    ret = read_sync(client->ioc, name, length, NULL);
+    if (ret < 0) {
         LOG("read failed");
-        return -EINVAL;
+        return ret;
     }
     name[length] = '\0';
 
@@ -354,6 +374,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_options(NBDClient *client)
 {
+    int ret;
     uint32_t flags;
     bool fixedNewstyle = false;
 
@@ -371,9 +392,10 @@ static int nbd_negotiate_options(NBDClient *client)
         ...           Rest of request
     */
 
-    if (read_sync(client->ioc, &flags, sizeof(flags), NULL) < 0) {
+    ret = read_sync(client->ioc, &flags, sizeof(flags), NULL);
+    if (ret < 0) {
         LOG("read failed");
-        return -EIO;
+        return ret;
     }
     TRACE("Checking client flags");
     be32_to_cpus(&flags);
@@ -397,9 +419,10 @@ static int nbd_negotiate_options(NBDClient *client)
         uint32_t clientflags, length;
         uint64_t magic;
 
-        if (read_sync(client->ioc, &magic, sizeof(magic), NULL) < 0) {
+        ret = read_sync(client->ioc, &magic, sizeof(magic), NULL);
+        if (ret < 0) {
             LOG("read failed");
-            return -EINVAL;
+            return ret;
         }
         TRACE("Checking opts magic");
         if (magic != be64_to_cpu(NBD_OPTS_MAGIC)) {
@@ -407,17 +430,17 @@ static int nbd_negotiate_options(NBDClient *client)
             return -EINVAL;
         }
 
-        if (read_sync(client->ioc, &clientflags,
-                      sizeof(clientflags), NULL) < 0)
-        {
+        ret = read_sync(client->ioc, &clientflags, sizeof(clientflags), NULL);
+        if (ret < 0) {
             LOG("read failed");
-            return -EINVAL;
+            return ret;
         }
         clientflags = be32_to_cpu(clientflags);
 
-        if (read_sync(client->ioc, &length, sizeof(length), NULL) < 0) {
+        ret = read_sync(client->ioc, &length, sizeof(length), NULL);
+        if (ret < 0) {
             LOG("read failed");
-            return -EINVAL;
+            return ret;
         }
         length = be32_to_cpu(length);
 
@@ -445,8 +468,9 @@ static int nbd_negotiate_options(NBDClient *client)
                 return -EINVAL;
 
             default:
-                if (drop_sync(client->ioc, length, NULL) < 0) {
-                    return -EIO;
+                ret = drop_sync(client->ioc, length, NULL);
+                if (ret < 0) {
+                    return ret;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_TLS_REQD,
@@ -476,15 +500,17 @@ static int nbd_negotiate_options(NBDClient *client)
                 /* NBD spec says we must try to reply before
                  * disconnecting, but that we must also tolerate
                  * guests that don't wait for our reply. */
-                nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK, clientflags);
-                return -EINVAL;
+                ret = nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                             clientflags);
+                return ret < 0 ? ret : -EINVAL;
 
             case NBD_OPT_EXPORT_NAME:
                 return nbd_negotiate_handle_export_name(client, length);
 
             case NBD_OPT_STARTTLS:
-                if (drop_sync(client->ioc, length, NULL) < 0) {
-                    return -EIO;
+                ret = drop_sync(client->ioc, length, NULL);
+                if (ret < 0) {
+                    return ret;
                 }
                 if (client->tlscreds) {
                     ret = nbd_negotiate_send_rep_err(client->ioc,
@@ -502,8 +528,9 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 break;
             default:
-                if (drop_sync(client->ioc, length, NULL) < 0) {
-                    return -EIO;
+                ret = drop_sync(client->ioc, length, NULL);
+                if (ret < 0) {
+                    return ret;
                 }
                 ret = nbd_negotiate_send_rep_err(client->ioc,
                                                  NBD_REP_ERR_UNSUP,
@@ -584,14 +611,17 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
             TRACE("TLS cannot be enabled with oldstyle protocol");
             return -EINVAL;
         }
-        if (write_sync(client->ioc, buf, sizeof(buf), NULL) < 0) {
+
+        ret = write_sync(client->ioc, buf, sizeof(buf), NULL);
+        if (ret < 0) {
             LOG("write failed");
-            return -EINVAL;
+            return ret;
         }
     } else {
-        if (write_sync(client->ioc, buf, 18, NULL) < 0) {
+        ret = write_sync(client->ioc, buf, 18, NULL);
+        if (ret < 0) {
             LOG("write failed");
-            return -EINVAL;
+            return ret;
         }
         ret = nbd_negotiate_options(client);
         if (ret != 0) {
@@ -977,7 +1007,7 @@ static int nbd_co_send_reply(NBDRequestData *req, NBDReply *reply, int len)
         if (ret == 0) {
             ret = write_sync(client->ioc, req->data, len, NULL);
             if (ret < 0) {
-                ret = -EIO;
+                ret = ret;
             }
         }
         qio_channel_set_cork(client->ioc, false);
-- 
2.11.1
