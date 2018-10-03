Received: from eggs.gnu.org ([2001:4830:134:3::10]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXk-0001aB-8D
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXh-0001dx-2b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 Oct 2018 20:02:28 +0300
Message-Id: <20181003170228.95973-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181003170228.95973-1-vsementsov@virtuozzo.com>
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] nbd/server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

After the previous commit, nbd_client_new first parameter is always
NULL. Let's drop it with all corresponding old-style negotiation code
path which is unreachable now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  3 +--
 blockdev-nbd.c      |  2 +-
 nbd/server.c        | 53 +++++++++++++--------------------------------
 qemu-nbd.c          |  2 +-
 4 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4638c839f5..0129d1a4b4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -308,8 +308,7 @@ void nbd_export_set_name(NBDExport *exp, const char *name);
 void nbd_export_set_description(NBDExport *exp, const char *description);
 void nbd_export_close_all(void);
 
-void nbd_client_new(NBDExport *exp,
-                    QIOChannelSocket *sioc,
+void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
                     void (*close_fn)(NBDClient *, bool));
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1ef11041a7..8913d8ff73 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -36,7 +36,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
                        gpointer opaque)
 {
     qio_channel_set_name(QIO_CHANNEL(cioc), "nbd-server");
-    nbd_client_new(NULL, cioc,
+    nbd_client_new(cioc,
                    nbd_server->tlscreds, NULL,
                    nbd_blockdev_client_closed);
 }
diff --git a/nbd/server.c b/nbd/server.c
index 1fba21414b..e87f881525 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1253,7 +1253,6 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     const uint16_t myflags = (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_TRIM |
                               NBD_FLAG_SEND_FLUSH | NBD_FLAG_SEND_FUA |
                               NBD_FLAG_SEND_WRITE_ZEROES | NBD_FLAG_SEND_CACHE);
-    bool oldStyle;
 
     /* Old style negotiation header, no room for options
         [ 0 ..   7]   passwd       ("NBDMAGIC")
@@ -1274,33 +1273,19 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
     trace_nbd_negotiate_begin();
     memcpy(buf, "NBDMAGIC", 8);
 
-    oldStyle = client->exp != NULL && !client->tlscreds;
-    if (oldStyle) {
-        trace_nbd_negotiate_old_style(client->exp->size,
-                                      client->exp->nbdflags | myflags);
-        stq_be_p(buf + 8, NBD_CLIENT_MAGIC);
-        stq_be_p(buf + 16, client->exp->size);
-        stl_be_p(buf + 24, client->exp->nbdflags | myflags);
+    stq_be_p(buf + 8, NBD_OPTS_MAGIC);
+    stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
 
-        if (nbd_write(client->ioc, buf, sizeof(buf), errp) < 0) {
-            error_prepend(errp, "write failed: ");
-            return -EINVAL;
-        }
-    } else {
-        stq_be_p(buf + 8, NBD_OPTS_MAGIC);
-        stw_be_p(buf + 16, NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES);
-
-        if (nbd_write(client->ioc, buf, 18, errp) < 0) {
-            error_prepend(errp, "write failed: ");
-            return -EINVAL;
-        }
-        ret = nbd_negotiate_options(client, myflags, errp);
-        if (ret != 0) {
-            if (ret < 0) {
-                error_prepend(errp, "option negotiation failed: ");
-            }
-            return ret;
+    if (nbd_write(client->ioc, buf, 18, errp) < 0) {
+        error_prepend(errp, "write failed: ");
+        return -EINVAL;
+    }
+    ret = nbd_negotiate_options(client, myflags, errp);
+    if (ret != 0) {
+        if (ret < 0) {
+            error_prepend(errp, "option negotiation failed: ");
         }
+        return ret;
     }
 
     assert(!client->optlen);
@@ -2396,13 +2381,8 @@ static void nbd_client_receive_next_request(NBDClient *client)
 static coroutine_fn void nbd_co_client_start(void *opaque)
 {
     NBDClient *client = opaque;
-    NBDExport *exp = client->exp;
     Error *local_err = NULL;
 
-    if (exp) {
-        nbd_export_get(exp);
-        QTAILQ_INSERT_TAIL(&exp->clients, client, next);
-    }
     qemu_co_mutex_init(&client->send_lock);
 
     if (nbd_negotiate(client, &local_err)) {
@@ -2417,13 +2397,11 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
 }
 
 /*
- * Create a new client listener on the given export @exp, using the
- * given channel @sioc.  Begin servicing it in a coroutine.  When the
- * connection closes, call @close_fn with an indication of whether the
- * client completed negotiation.
+ * Create a new client listener using the given channel @sioc.
+ * Begin servicing it in a coroutine.  When the connection closes, call
+ * @close_fn with an indication of whether the client completed negotiation.
  */
-void nbd_client_new(NBDExport *exp,
-                    QIOChannelSocket *sioc,
+void nbd_client_new(QIOChannelSocket *sioc,
                     QCryptoTLSCreds *tlscreds,
                     const char *tlsaclname,
                     void (*close_fn)(NBDClient *, bool))
@@ -2433,7 +2411,6 @@ void nbd_client_new(NBDExport *exp,
 
     client = g_new0(NBDClient, 1);
     client->refcount = 1;
-    client->exp = exp;
     client->tlscreds = tlscreds;
     if (tlscreds) {
         object_ref(OBJECT(client->tlscreds));
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 57e79e30ea..aad0b88723 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -353,7 +353,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 
     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(NULL, cioc, tlscreds, NULL, nbd_client_closed);
+    nbd_client_new(cioc, tlscreds, NULL, nbd_client_closed);
 }
 
 static void nbd_update_server_watch(void)
-- 
2.18.0
