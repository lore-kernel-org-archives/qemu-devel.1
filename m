Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ABFC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDDD205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDDD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKh2-0004Wr-Bo
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXB-00030G-0a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKX8-0001xv-46
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKX1-0001gg-8k; Thu, 15 Aug 2019 14:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D75B30BC838;
 Thu, 15 Aug 2019 18:31:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9044C600CD;
 Thu, 15 Aug 2019 18:31:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:37 -0500
Message-Id: <20190815183039.4264-8-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 15 Aug 2019 18:31:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/9] block/nbd: move from quit to state
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

To implement reconnect we need several states for the client:
CONNECTED, QUIT and two different CONNECTING states. CONNECTING states
will be added in the following patches. This patch implements CONNECTED
and QUIT.

QUIT means, that we should close the connection and fail all current
and further requests (like old quit =3D true).

CONNECTED means that connection is ok, we can send requests (like old
quit =3D false).

For receiving loop we use a comparison of the current state with QUIT,
because reconnect will be in the same loop, so it should be looping
until the end.

Opposite, for requests we use a comparison of the current state with
CONNECTED, as we don't want to send requests in future CONNECTING
states.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190618114328.55249-4-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 58 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 3a243d9de96e..d03b00fc30b0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -53,6 +53,11 @@ typedef struct {
     bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;

+typedef enum NBDClientState {
+    NBD_CLIENT_CONNECTED,
+    NBD_CLIENT_QUIT
+} NBDClientState;
+
 typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS=
) */
@@ -62,17 +67,23 @@ typedef struct BDRVNBDState {
     CoQueue free_sema;
     Coroutine *connection_co;
     int in_flight;
+    NBDClientState state;

     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
-    bool quit;

     /* For nbd_refresh_filename() */
     SocketAddress *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;

+/* @ret will be used for reconnect in future */
+static void nbd_channel_error(BDRVNBDState *s, int ret)
+{
+    s->state =3D NBD_CLIENT_QUIT;
+}
+
 static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
 {
     int i;
@@ -151,7 +162,7 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
     int ret =3D 0;
     Error *local_err =3D NULL;

-    while (!s->quit) {
+    while (s->state !=3D NBD_CLIENT_QUIT) {
         /*
          * The NBD client can only really be considered idle when it has
          * yielded from qio_channel_readv_all_eof(), waiting for data. T=
his is
@@ -169,6 +180,7 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
             error_free(local_err);
         }
         if (ret <=3D 0) {
+            nbd_channel_error(s, ret ? ret : -EIO);
             break;
         }

@@ -183,6 +195,7 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
             !s->requests[i].receiving ||
             (nbd_reply_is_structured(&s->reply) && !s->info.structured_r=
eply))
         {
+            nbd_channel_error(s, -EINVAL);
             break;
         }

@@ -202,7 +215,6 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
         qemu_coroutine_yield();
     }

-    s->quit =3D true;
     nbd_recv_coroutines_wake_all(s);
     bdrv_dec_in_flight(s->bs);

@@ -215,12 +227,18 @@ static int nbd_co_send_request(BlockDriverState *bs=
,
                                QEMUIOVector *qiov)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
-    int rc, i;
+    int rc, i =3D -1;

     qemu_co_mutex_lock(&s->send_mutex);
     while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
         qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
     }
+
+    if (s->state !=3D NBD_CLIENT_CONNECTED) {
+        rc =3D -EIO;
+        goto err;
+    }
+
     s->in_flight++;

     for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
@@ -238,16 +256,12 @@ static int nbd_co_send_request(BlockDriverState *bs=
,

     request->handle =3D INDEX_TO_HANDLE(s, i);

-    if (s->quit) {
-        rc =3D -EIO;
-        goto err;
-    }
     assert(s->ioc);

     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
         rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && !s->quit) {
+        if (rc >=3D 0 && s->state =3D=3D NBD_CLIENT_CONNECTED) {
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc =3D -EIO;
@@ -262,9 +276,11 @@ static int nbd_co_send_request(BlockDriverState *bs,

 err:
     if (rc < 0) {
-        s->quit =3D true;
-        s->requests[i].coroutine =3D NULL;
-        s->in_flight--;
+        nbd_channel_error(s, rc);
+        if (i !=3D -1) {
+            s->requests[i].coroutine =3D NULL;
+            s->in_flight--;
+        }
         qemu_co_queue_next(&s->free_sema);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
@@ -556,7 +572,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (s->quit) {
+    if (s->state !=3D NBD_CLIENT_CONNECTED) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -641,7 +657,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(

     if (ret < 0) {
         memset(reply, 0, sizeof(*reply));
-        s->quit =3D true;
+        nbd_channel_error(s, ret);
     } else {
         /* For assert at loop start in nbd_connection_entry */
         *reply =3D s->reply;
@@ -709,7 +725,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState=
 *s,
     NBDReply local_reply;
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
-    if (s->quit) {
+    if (s->state !=3D NBD_CLIENT_CONNECTED) {
         error_setg(&local_err, "Connection closed");
         nbd_iter_channel_error(iter, -EIO, &local_err);
         goto break_loop;
@@ -734,7 +750,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState=
 *s,
     }

     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple rep=
ly. */
-    if (nbd_reply_is_simple(reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->state !=3D NBD_CLIENT_CONNECTED=
) {
         goto break_loop;
     }

@@ -808,14 +824,14 @@ static int nbd_co_receive_cmdread_reply(BDRVNBDStat=
e *s, uint64_t handle,
             ret =3D nbd_parse_offset_hole_payload(s, &reply.structured, =
payload,
                                                 offset, qiov, &local_err=
);
             if (ret < 0) {
-                s->quit =3D true;
+                nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
                 /* not allowed reply type */
-                s->quit =3D true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) for CMD_READ"=
,
                            chunk->type, nbd_reply_type_lookup(chunk->typ=
e));
@@ -853,7 +869,7 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBDSt=
ate *s,
         switch (chunk->type) {
         case NBD_REPLY_TYPE_BLOCK_STATUS:
             if (received) {
-                s->quit =3D true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err, "Several BLOCK_STATUS chunks in r=
eply");
                 nbd_iter_channel_error(&iter, -EINVAL, &local_err);
             }
@@ -863,13 +879,13 @@ static int nbd_co_receive_blockstatus_reply(BDRVNBD=
State *s,
                                                 payload, length, extent,
                                                 &local_err);
             if (ret < 0) {
-                s->quit =3D true;
+                nbd_channel_error(s, ret);
                 nbd_iter_channel_error(&iter, ret, &local_err);
             }
             break;
         default:
             if (!nbd_reply_type_is_error(chunk->type)) {
-                s->quit =3D true;
+                nbd_channel_error(s, -EINVAL);
                 error_setg(&local_err,
                            "Unexpected reply type: %d (%s) "
                            "for CMD_BLOCK_STATUS",
--=20
2.20.1


