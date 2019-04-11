Received: from eggs.gnu.org ([209.51.188.92]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTn-0004ZK-Bq
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bh-Rf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:15 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Apr 2019 20:27:04 +0300
Message-Id: <20190411172709.205032-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v6 2/7] block/nbd-client: use non-blocking io
 channel for nbd negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

No reason to use blocking channel for negotiation and we'll benefit in
further reconnect feature, as qio_channel reads and writes will do
qemu_coroutine_yield while waiting for io completion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  3 ++-
 block/nbd-client.c  | 16 +++++++---------
 nbd/client.c        | 16 +++++++++++-----
 qemu-nbd.c          |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6d05983a55..6961835654 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -290,7 +290,8 @@ struct NBDExportInfo {
 };
 typedef struct NBDExportInfo NBDExportInfo;
 
-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                          QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp);
 void nbd_free_export_list(NBDExportInfo *info, int count);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index facf8f8099..f9cee25865 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1123,6 +1123,7 @@ static int nbd_client_connect(BlockDriverState *bs,
                               Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
 
     /*
@@ -1137,15 +1138,16 @@ static int nbd_client_connect(BlockDriverState *bs,
 
     /* NBD handshake */
     logout("session init %s\n", export);
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
+    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
+    qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
 
     client->info.request_sizes = true;
     client->info.structured_reply = true;
     client->info.base_allocation = true;
     client->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
     client->info.name = g_strdup(export ?: "");
-    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
-                                &client->ioc, &client->info, errp);
+    ret = nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), tlscreds,
+                                hostname, &client->ioc, &client->info, errp);
     g_free(client->info.x_dirty_bitmap);
     g_free(client->info.name);
     if (ret < 0) {
@@ -1180,17 +1182,13 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(client->ioc));
     }
 
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    qio_channel_attach_aio_context(client->ioc, bdrv_get_aio_context(bs));
-
     logout("Established connection with NBD server\n");
     return 0;
 
  fail:
     /*
-     * We have connected, but must fail for other reasons. The
-     * connection is still blocking; send NBD_CMD_DISC as a courtesy
-     * to the server.
+     * We have connected, but must fail for other reasons.
+     * Send NBD_CMD_DISC as a courtesy to the server.
      */
     {
         NBDRequest request = { .type = NBD_CMD_DISC };
diff --git a/nbd/client.c b/nbd/client.c
index 4de30630c7..8f524c3e35 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -867,7 +867,8 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
  */
-static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                               QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
@@ -934,6 +935,10 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                     return -EINVAL;
                 }
                 ioc = *outioc;
+                if (aio_context) {
+                    qio_channel_set_blocking(ioc, false, NULL);
+                    qio_channel_attach_aio_context(ioc, aio_context);
+                }
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
                 return -EINVAL;
@@ -998,7 +1003,8 @@ static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo *info,
  * Returns: negative errno: failure talking to server
  *          0: server is connected
  */
-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                          QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
@@ -1009,7 +1015,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);
 
-    result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
+    result = nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, outioc,
                                  info->structured_reply, &zeroes, errp);
 
     info->structured_reply = false;
@@ -1129,8 +1135,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     QIOChannel *sioc = NULL;
 
     *info = NULL;
-    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true, NULL,
-                                 errp);
+    result = nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc, true,
+                                 NULL, errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 941ba729c2..ed38b55428 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -370,7 +370,7 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }
 
-    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc),
+    ret = nbd_receive_negotiate(NULL, QIO_CHANNEL(sioc),
                                 NULL, NULL, NULL, &info, &local_error);
     if (ret < 0) {
         if (local_error) {
-- 
2.18.0
