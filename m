Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB2AC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821F12083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821F12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKjc-0007VH-Dy
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXD-000310-Pr
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKXA-00020s-AQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKX1-0001id-PR; Thu, 15 Aug 2019 14:31:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FE6B317556D;
 Thu, 15 Aug 2019 18:31:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3143600CD;
 Thu, 15 Aug 2019 18:31:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:39 -0500
Message-Id: <20190815183039.4264-10-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 15 Aug 2019 18:31:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 9/9] block/nbd: refactor nbd connection
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We'll need some connection parameters to be available all the time to
implement nbd reconnect. So, let's refactor them: define additional
parameters in BDRVNBDState, drop them from function parameters, drop
nbd_client_init and separate options parsing instead from nbd_open.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190618114328.55249-6-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: Drop useless 'if' before object_unref]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 121 ++++++++++++++++++++++++++--------------------------
 1 file changed, 60 insertions(+), 61 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index de2a26097bf9..00b8d86783d9 100644
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
@@ -1182,13 +1186,7 @@ static QIOChannelSocket *nbd_establish_connection(=
SocketAddress *saddr,
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
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     AioContext *aio_context =3D bdrv_get_aio_context(bs);
@@ -1198,33 +1196,33 @@ static int nbd_client_connect(BlockDriverState *b=
s,
      * establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    QIOChannelSocket *sioc =3D nbd_establish_connection(saddr, errp);
+    QIOChannelSocket *sioc =3D nbd_establish_connection(s->saddr, errp);

     if (!sioc) {
         return -ECONNREFUSED;
     }

     /* NBD handshake */
-    trace_nbd_client_connect(export);
+    trace_nbd_client_connect(s->export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);

     s->info.request_sizes =3D true;
     s->info.structured_reply =3D true;
     s->info.base_allocation =3D true;
-    s->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
-    s->info.name =3D g_strdup(export ?: "");
-    ret =3D nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), tlscre=
ds,
-                                hostname, &s->ioc, &s->info, errp);
+    s->info.x_dirty_bitmap =3D g_strdup(s->x_dirty_bitmap);
+    s->info.name =3D g_strdup(s->export ?: "");
+    ret =3D nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), s->tls=
creds,
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
         ret =3D -EINVAL;
         goto fail;
     }
@@ -1249,7 +1247,7 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(s->ioc));
     }

-    trace_nbd_client_connect_success(export);
+    trace_nbd_client_connect_success(s->export);

     return 0;

@@ -1269,34 +1267,9 @@ static int nbd_client_connect(BlockDriverState *bs=
,
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
-    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
-
-    s->bs =3D bs;
-    qemu_co_mutex_init(&s->send_mutex);
-    qemu_co_queue_init(&s->free_sema);
-
-    ret =3D nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                             x_dirty_bitmap, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
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
@@ -1616,14 +1589,12 @@ static QemuOptsList nbd_runtime_opts =3D {
     },
 };

-static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
-                    Error **errp)
+static int nbd_process_options(BlockDriverState *bs, QDict *options,
+                               Error **errp)
 {
     BDRVNBDState *s =3D bs->opaque;
-    QemuOpts *opts =3D NULL;
+    QemuOpts *opts;
     Error *local_err =3D NULL;
-    QCryptoTLSCreds *tlscreds =3D NULL;
-    const char *hostname =3D NULL;
     int ret =3D -EINVAL;

     opts =3D qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
@@ -1648,8 +1619,8 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,

     s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
     if (s->tlscredsid) {
-        tlscreds =3D nbd_get_tls_creds(s->tlscredsid, errp);
-        if (!tlscreds) {
+        s->tlscreds =3D nbd_get_tls_creds(s->tlscredsid, errp);
+        if (!s->tlscreds) {
             goto error;
         }

@@ -1658,20 +1629,17 @@ static int nbd_open(BlockDriverState *bs, QDict *=
options, int flags,
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
-        hostname =3D s->saddr->u.inet.host;
+        s->hostname =3D s->saddr->u.inet.host;
     }

-    /* NBD handshake */
-    ret =3D nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
-                          qemu_opt_get(opts, "x-dirty-bitmap"),
-                          qemu_opt_get_number(opts, "reconnect-delay", 0=
),
-                          errp);
+    s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"))=
;
+    s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay", =
0);
+
+    ret =3D 0;

  error:
-    if (tlscreds) {
-        object_unref(OBJECT(tlscreds));
-    }
     if (ret < 0) {
+        object_unref(OBJECT(s->tlscreds));
         qapi_free_SocketAddress(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
@@ -1680,6 +1648,35 @@ static int nbd_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     return ret;
 }

+static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
+                    Error **errp)
+{
+    int ret;
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    ret =3D nbd_process_options(bs, options, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->bs =3D bs;
+    qemu_co_mutex_init(&s->send_mutex);
+    qemu_co_queue_init(&s->free_sema);
+
+    ret =3D nbd_client_connect(bs, errp);
+    if (ret < 0) {
+        return ret;
+    }
+    /* successfully connected */
+    s->state =3D NBD_CLIENT_CONNECTED;
+
+    s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
+    bdrv_inc_in_flight(bs);
+    aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
+
+    return 0;
+}
+
 static int nbd_co_flush(BlockDriverState *bs)
 {
     return nbd_client_co_flush(bs);
@@ -1725,9 +1722,11 @@ static void nbd_close(BlockDriverState *bs)

     nbd_client_close(bs);

+    object_unref(OBJECT(s->tlscreds));
     qapi_free_SocketAddress(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
+    g_free(s->x_dirty_bitmap);
 }

 static int64_t nbd_getlength(BlockDriverState *bs)
--=20
2.20.1


