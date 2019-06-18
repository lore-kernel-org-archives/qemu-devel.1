Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F9C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B0C2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B0C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCdu-00018N-9p
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWX-00041u-AJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWV-0000N8-7t
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:58024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWU-0000Jo-Re; Tue, 18 Jun 2019 07:43:35 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWP-00016b-Fo; Tue, 18 Jun 2019 14:43:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 14:43:24 +0300
Message-Id: <20190618114328.55249-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190618114328.55249-1-vsementsov@virtuozzo.com>
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 5/9] block/nbd: refactor nbd connection
 parameters
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need some connection parameters to be available all the time to
implement nbd reconnect. So, let's refactor them: define additional
parameters in BDRVNBDState, drop them from function parameters, drop
nbd_client_init and separate options parsing instead from nbd_open.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 125 +++++++++++++++++++++++++++-------------------------
 1 file changed, 64 insertions(+), 61 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index df9b0a2c8a..68e0e168e8 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -73,9 +73,13 @@ typedef struct BDRVNBDState {
     NBDReply reply;
     BlockDriverState *bs;
 
-    /* For nbd_refresh_filename() */
+    /* Connection parameters */
+    uint32_t reconnect_delay;
     SocketAddress *saddr;
     char *export, *tlscredsid;
+    QCryptoTLSCreds *tlscreds;
+    const char *hostname;
+    char *x_dirty_bitmap;
 } BDRVNBDState;
 
 /* @ret will be used for reconnect in future */
@@ -1183,13 +1187,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     return sioc;
 }
 
-static int nbd_client_connect(BlockDriverState *bs,
-                              SocketAddress *saddr,
-                              const char *export,
-                              QCryptoTLSCreds *tlscreds,
-                              const char *hostname,
-                              const char *x_dirty_bitmap,
-                              Error **errp)
+static int nbd_client_connect(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     AioContext *aio_context = bdrv_get_aio_context(bs);
@@ -1199,33 +1197,33 @@ static int nbd_client_connect(BlockDriverState *bs,
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    QIOChannelSocket *sioc = nbd_establish_connection(saddr, errp);
+    QIOChannelSocket *sioc = nbd_establish_connection(s->saddr, errp);
 
     if (!sioc) {
         return -ECONNREFUSED;
     }
 
     /* NBD handshake */
-    trace_nbd_client_connect(export);
+    trace_nbd_client_connect(s->export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);
 
     s->info.request_sizes = true;
     s->info.structured_reply = true;
     s->info.base_allocation = true;
-    s->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
-    s->info.name = g_strdup(export ?: "");
-    ret = nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), tlscreds,
-                                hostname, &s->ioc, &s->info, errp);
+    s->info.x_dirty_bitmap = g_strdup(s->x_dirty_bitmap);
+    s->info.name = g_strdup(s->export ?: "");
+    ret = nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), s->tlscreds,
+                                s->hostname, &s->ioc, &s->info, errp);
     g_free(s->info.x_dirty_bitmap);
     g_free(s->info.name);
     if (ret < 0) {
         object_unref(OBJECT(sioc));
         return ret;
     }
-    if (x_dirty_bitmap && !s->info.base_allocation) {
+    if (s->x_dirty_bitmap && !s->info.base_allocation) {
         error_setg(errp, "requested x-dirty-bitmap %s not found",
-                   x_dirty_bitmap);
+                   s->x_dirty_bitmap);
         ret = -EINVAL;
         goto fail;
     }
@@ -1250,7 +1248,7 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(s->ioc));
     }
 
-    trace_nbd_client_connect_success(export);
+    trace_nbd_client_connect_success(s->export);
 
     return 0;
 
@@ -1270,34 +1268,9 @@ static int nbd_client_connect(BlockDriverState *bs,
     }
 }
 
-static int nbd_client_init(BlockDriverState *bs,
-                           SocketAddress *saddr,
-                           const char *export,
-                           QCryptoTLSCreds *tlscreds,
-                           const char *hostname,
-                           const char *x_dirty_bitmap,
-                           uint32_t reconnect_delay,
-                           Error **errp)
-{
-    int ret;
-    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
-
-    s->bs = bs;
-    qemu_co_mutex_init(&s->send_mutex);
-    qemu_co_queue_init(&s->free_sema);
-
-    ret = nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                             x_dirty_bitmap, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
-    bdrv_inc_in_flight(bs);
-    aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
-
-    return 0;
-}
+/*
+ * Parse nbd_open options
+ */
 
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
@@ -1617,14 +1590,12 @@ static QemuOptsList nbd_runtime_opts = {
     },
 };
 
-static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
-                    Error **errp)
+static int nbd_process_options(BlockDriverState *bs, QDict *options,
+                               Error **errp)
 {
     BDRVNBDState *s = bs->opaque;
-    QemuOpts *opts = NULL;
+    QemuOpts *opts;
     Error *local_err = NULL;
-    QCryptoTLSCreds *tlscreds = NULL;
-    const char *hostname = NULL;
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
@@ -1649,8 +1620,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
     if (s->tlscredsid) {
-        tlscreds = nbd_get_tls_creds(s->tlscredsid, errp);
-        if (!tlscreds) {
+        s->tlscreds = nbd_get_tls_creds(s->tlscredsid, errp);
+        if (!s->tlscreds) {
             goto error;
         }
 
@@ -1659,20 +1630,19 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
-        hostname = s->saddr->u.inet.host;
+        s->hostname = s->saddr->u.inet.host;
     }
 
-    /* NBD handshake */
-    ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
-                          qemu_opt_get(opts, "x-dirty-bitmap"),
-                          qemu_opt_get_number(opts, "reconnect-delay", 0),
-                          errp);
+    s->x_dirty_bitmap = g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"));
+    s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
+
+    ret = 0;
 
  error:
-    if (tlscreds) {
-        object_unref(OBJECT(tlscreds));
-    }
     if (ret < 0) {
+        if (s->tlscreds) {
+            object_unref(OBJECT(s->tlscreds));
+        }
         qapi_free_SocketAddress(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
@@ -1681,6 +1651,35 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     return ret;
 }
 
+static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
+                    Error **errp)
+{
+    int ret;
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    ret = nbd_process_options(bs, options, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->bs = bs;
+    qemu_co_mutex_init(&s->send_mutex);
+    qemu_co_queue_init(&s->free_sema);
+
+    ret = nbd_client_connect(bs, errp);
+    if (ret < 0) {
+        return ret;
+    }
+    /* successfully connected */
+    s->state = NBD_CLIENT_CONNECTED;
+
+    s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
+    bdrv_inc_in_flight(bs);
+    aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
+
+    return 0;
+}
+
 static int nbd_co_flush(BlockDriverState *bs)
 {
     return nbd_client_co_flush(bs);
@@ -1726,9 +1725,13 @@ static void nbd_close(BlockDriverState *bs)
 
     nbd_client_close(bs);
 
+    if (s->tlscreds) {
+        object_unref(OBJECT(s->tlscreds));
+    }
     qapi_free_SocketAddress(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
+    g_free(s->x_dirty_bitmap);
 }
 
 static int64_t nbd_getlength(BlockDriverState *bs)
-- 
2.18.0


