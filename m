Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B5EC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE982063F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE982063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTD0-00041q-6B
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRye-00032t-6R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRya-0006qi-Fo
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRyR-0006Z3-AV; Thu, 13 Jun 2019 11:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFFE5C04BE32;
 Thu, 13 Jun 2019 15:48:54 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E77F7C56F;
 Thu, 13 Jun 2019 15:48:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:37 -0500
Message-Id: <20190613154837.21734-10-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 15:48:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 9/9] block/nbd: merge NBDClientSession struct
 back to BDRVNBDState
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

No reason to keep it separate, it differs from others block driver
behavior and therefore confuses. Instead of generic
  'state =3D (State*)bs->opaque' we have to use special helper.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190611102720.86114-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 197 +++++++++++++++++++++++++---------------------------
 1 file changed, 94 insertions(+), 103 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 1f00be2d664e..81edabbf35ed 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -53,7 +53,7 @@ typedef struct {
     bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;

-typedef struct NBDClientSession {
+typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS=
) */
     NBDExportInfo info;
@@ -67,24 +67,13 @@ typedef struct NBDClientSession {
     NBDReply reply;
     BlockDriverState *bs;
     bool quit;
-} NBDClientSession;
-
-typedef struct BDRVNBDState {
-    NBDClientSession client;

     /* For nbd_refresh_filename() */
     SocketAddress *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;

-static NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
-{
-    BDRVNBDState *s =3D bs->opaque;
-    return &s->client;
-}
-
-
-static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
+static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
 {
     int i;

@@ -99,14 +88,15 @@ static void nbd_recv_coroutines_wake_all(NBDClientSes=
sion *s)

 static void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
 }

 static void nbd_client_attach_aio_context_bh(void *opaque)
 {
     BlockDriverState *bs =3D opaque;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

     /*
      * The node is still drained, so we know the coroutine has yielded i=
n
@@ -114,15 +104,16 @@ static void nbd_client_attach_aio_context_bh(void *=
opaque)
      * entered for the first time. Both places are safe for entering the
      * coroutine.
      */
-    qemu_aio_coroutine_enter(bs->aio_context, client->connection_co);
+    qemu_aio_coroutine_enter(bs->aio_context, s->connection_co);
     bdrv_dec_in_flight(bs);
 }

 static void nbd_client_attach_aio_context(BlockDriverState *bs,
                                           AioContext *new_context)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+
+    qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);

     bdrv_inc_in_flight(bs);

@@ -136,26 +127,26 @@ static void nbd_client_attach_aio_context(BlockDriv=
erState *bs,

 static void nbd_teardown_connection(BlockDriverState *bs)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    assert(client->ioc);
+    assert(s->ioc);

     /* finish any pending coroutines */
-    qio_channel_shutdown(client->ioc,
+    qio_channel_shutdown(s->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, client->connection_co);
+    BDRV_POLL_WHILE(bs, s->connection_co);

     nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(client->sioc));
-    client->sioc =3D NULL;
-    object_unref(OBJECT(client->ioc));
-    client->ioc =3D NULL;
+    object_unref(OBJECT(s->sioc));
+    s->sioc =3D NULL;
+    object_unref(OBJECT(s->ioc));
+    s->ioc =3D NULL;
 }

 static coroutine_fn void nbd_connection_entry(void *opaque)
 {
-    NBDClientSession *s =3D opaque;
+    BDRVNBDState *s =3D opaque;
     uint64_t i;
     int ret =3D 0;
     Error *local_err =3D NULL;
@@ -223,7 +214,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                NBDRequest *request,
                                QEMUIOVector *qiov)
 {
-    NBDClientSession *s =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     int rc, i;

     qemu_co_mutex_lock(&s->send_mutex);
@@ -298,7 +289,7 @@ static inline uint64_t payload_advance64(uint8_t **pa=
yload)
     return ldq_be_p(*payload - 8);
 }

-static int nbd_parse_offset_hole_payload(NBDClientSession *client,
+static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig=
_offset,
                                          QEMUIOVector *qiov, Error **err=
p)
@@ -321,8 +312,8 @@ static int nbd_parse_offset_hole_payload(NBDClientSes=
sion *client,
                          " region");
         return -EINVAL;
     }
-    if (client->info.min_block &&
-        !QEMU_IS_ALIGNED(hole_size, client->info.min_block)) {
+    if (s->info.min_block &&
+        !QEMU_IS_ALIGNED(hole_size, s->info.min_block)) {
         trace_nbd_structured_read_compliance("hole");
     }

@@ -336,7 +327,7 @@ static int nbd_parse_offset_hole_payload(NBDClientSes=
sion *client,
  * Based on our request, we expect only one extent in reply, for the
  * base:allocation context.
  */
-static int nbd_parse_blockstatus_payload(NBDClientSession *client,
+static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig=
_length,
                                          NBDExtent *extent, Error **errp=
)
@@ -351,11 +342,11 @@ static int nbd_parse_blockstatus_payload(NBDClientS=
ession *client,
     }

     context_id =3D payload_advance32(&payload);
-    if (client->info.context_id !=3D context_id) {
+    if (s->info.context_id !=3D context_id) {
         error_setg(errp, "Protocol error: unexpected context id %d for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated c=
ontext "
                          "id is %d", context_id,
-                         client->info.context_id);
+                         s->info.context_id);
         return -EINVAL;
     }

@@ -380,14 +371,14 @@ static int nbd_parse_blockstatus_payload(NBDClientS=
ession *client,
      * up to the full block and change the status to fully-allocated
      * (always a safe status, even if it loses information).
      */
-    if (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                   client->info.min_bloc=
k)) {
+    if (s->info.min_block && !QEMU_IS_ALIGNED(extent->length,
+                                                   s->info.min_block)) {
         trace_nbd_parse_blockstatus_compliance("extent length is unalign=
ed");
-        if (extent->length > client->info.min_block) {
+        if (extent->length > s->info.min_block) {
             extent->length =3D QEMU_ALIGN_DOWN(extent->length,
-                                             client->info.min_block);
+                                             s->info.min_block);
         } else {
-            extent->length =3D client->info.min_block;
+            extent->length =3D s->info.min_block;
             extent->flags =3D 0;
         }
     }
@@ -453,7 +444,7 @@ static int nbd_parse_error_payload(NBDStructuredReply=
Chunk *chunk,
     return 0;
 }

-static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
+static int nbd_co_receive_offset_data_payload(BDRVNBDState *s,
                                               uint64_t orig_offset,
                                               QEMUIOVector *qiov, Error =
**errp)
 {
@@ -498,7 +489,7 @@ static int nbd_co_receive_offset_data_payload(NBDClie=
ntSession *s,

 #define NBD_MAX_MALLOC_PAYLOAD 1000
 static coroutine_fn int nbd_co_receive_structured_payload(
-        NBDClientSession *s, void **payload, Error **errp)
+        BDRVNBDState *s, void **payload, Error **errp)
 {
     int ret;
     uint32_t len;
@@ -548,7 +539,7 @@ static coroutine_fn int nbd_co_receive_structured_pay=
load(
  * corresponding to the server's error reply), and errp is unchanged.
  */
 static coroutine_fn int nbd_co_do_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t handle, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, void **payload, Error **er=
rp)
 {
     int ret;
@@ -641,7 +632,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t handle, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **pa=
yload,
         Error **errp)
 {
@@ -709,7 +700,7 @@ static void nbd_iter_request_error(NBDReplyChunkIter =
*iter, int ret)
  * nbd_reply_chunk_iter_receive
  * The pointer stored in @payload requires g_free() to free it.
  */
-static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
+static bool nbd_reply_chunk_iter_receive(BDRVNBDState *s,
                                          NBDReplyChunkIter *iter,
                                          uint64_t handle,
                                          QEMUIOVector *qiov, NBDReply *r=
eply,
@@ -776,7 +767,7 @@ break_loop:
     return false;
 }

-static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t hand=
le,
+static int nbd_co_receive_return_code(BDRVNBDState *s, uint64_t handle,
                                       int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -790,7 +781,7 @@ static int nbd_co_receive_return_code(NBDClientSessio=
n *s, uint64_t handle,
     return iter.ret;
 }

-static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t ha=
ndle,
+static int nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle=
,
                                         uint64_t offset, QEMUIOVector *q=
iov,
                                         int *request_ret, Error **errp)
 {
@@ -842,7 +833,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSess=
ion *s, uint64_t handle,
     return iter.ret;
 }

-static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
+static int nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
                                             uint64_t handle, uint64_t le=
ngth,
                                             NBDExtent *extent,
                                             int *request_ret, Error **er=
rp)
@@ -907,7 +898,7 @@ static int nbd_co_request(BlockDriverState *bs, NBDRe=
quest *request,
 {
     int ret, request_ret;
     Error *local_err =3D NULL;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

     assert(request->type !=3D NBD_CMD_READ);
     if (write_qiov) {
@@ -921,7 +912,7 @@ static int nbd_co_request(BlockDriverState *bs, NBDRe=
quest *request,
         return ret;
     }

-    ret =3D nbd_co_receive_return_code(client, request->handle,
+    ret =3D nbd_co_receive_return_code(s, request->handle,
                                      &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request->from, request->len, request->=
handle,
@@ -938,7 +929,7 @@ static int nbd_client_co_preadv(BlockDriverState *bs,=
 uint64_t offset,
 {
     int ret, request_ret;
     Error *local_err =3D NULL;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D {
         .type =3D NBD_CMD_READ,
         .from =3D offset,
@@ -957,13 +948,13 @@ static int nbd_client_co_preadv(BlockDriverState *b=
s, uint64_t offset,
      * advertised size because the block layer rounded size up, then
      * truncate the request to the server and tail-pad with zero.
      */
-    if (offset >=3D client->info.size) {
+    if (offset >=3D s->info.size) {
         assert(bytes < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, 0, 0, bytes);
         return 0;
     }
-    if (offset + bytes > client->info.size) {
-        uint64_t slop =3D offset + bytes - client->info.size;
+    if (offset + bytes > s->info.size) {
+        uint64_t slop =3D offset + bytes - s->info.size;

         assert(slop < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, bytes - slop, 0, slop);
@@ -975,7 +966,7 @@ static int nbd_client_co_preadv(BlockDriverState *bs,=
 uint64_t offset,
         return ret;
     }

-    ret =3D nbd_co_receive_cmdread_reply(client, request.handle, offset,=
 qiov,
+    ret =3D nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov=
,
                                        &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
@@ -990,16 +981,16 @@ static int nbd_client_co_preadv(BlockDriverState *b=
s, uint64_t offset,
 static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                  uint64_t bytes, QEMUIOVector *qiov, int=
 flags)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D {
         .type =3D NBD_CMD_WRITE,
         .from =3D offset,
         .len =3D bytes,
     };

-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
+    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
-        assert(client->info.flags & NBD_FLAG_SEND_FUA);
+        assert(s->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |=3D NBD_CMD_FLAG_FUA;
     }

@@ -1014,20 +1005,20 @@ static int nbd_client_co_pwritev(BlockDriverState=
 *bs, uint64_t offset,
 static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t off=
set,
                                        int bytes, BdrvRequestFlags flags=
)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D {
         .type =3D NBD_CMD_WRITE_ZEROES,
         .from =3D offset,
         .len =3D bytes,
     };

-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
+    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
     }

     if (flags & BDRV_REQ_FUA) {
-        assert(client->info.flags & NBD_FLAG_SEND_FUA);
+        assert(s->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |=3D NBD_CMD_FLAG_FUA;
     }
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
@@ -1042,10 +1033,10 @@ static int nbd_client_co_pwrite_zeroes(BlockDrive=
rState *bs, int64_t offset,

 static int nbd_client_co_flush(BlockDriverState *bs)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D { .type =3D NBD_CMD_FLUSH };

-    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
+    if (!(s->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
     }

@@ -1058,15 +1049,15 @@ static int nbd_client_co_flush(BlockDriverState *=
bs)
 static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
                                   int bytes)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D {
         .type =3D NBD_CMD_TRIM,
         .from =3D offset,
         .len =3D bytes,
     };

-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(client->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
+    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
     }

@@ -1079,7 +1070,7 @@ static int coroutine_fn nbd_client_co_block_status(
 {
     int ret, request_ret;
     NBDExtent extent =3D { 0 };
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     Error *local_err =3D NULL;

     NBDRequest request =3D {
@@ -1087,12 +1078,12 @@ static int coroutine_fn nbd_client_co_block_statu=
s(
         .from =3D offset,
         .len =3D MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
                                                 bs->bl.request_alignment=
),
-                                client->info.max_block),
-                   MIN(bytes, client->info.size - offset)),
+                                s->info.max_block),
+                   MIN(bytes, s->info.size - offset)),
         .flags =3D NBD_CMD_FLAG_REQ_ONE,
     };

-    if (!client->info.base_allocation) {
+    if (!s->info.base_allocation) {
         *pnum =3D bytes;
         *map =3D offset;
         *file =3D bs;
@@ -1106,22 +1097,22 @@ static int coroutine_fn nbd_client_co_block_statu=
s(
      * up, we truncated the request to the server (above), or are
      * called on just the hole.
      */
-    if (offset >=3D client->info.size) {
+    if (offset >=3D s->info.size) {
         *pnum =3D bytes;
         assert(bytes < BDRV_SECTOR_SIZE);
         /* Intentionally don't report offset_valid for the hole */
         return BDRV_BLOCK_ZERO;
     }

-    if (client->info.min_block) {
-        assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
+    if (s->info.min_block) {
+        assert(QEMU_IS_ALIGNED(request.len, s->info.min_block));
     }
     ret =3D nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         return ret;
     }

-    ret =3D nbd_co_receive_blockstatus_reply(client, request.handle, byt=
es,
+    ret =3D nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
                                            &extent, &request_ret, &local=
_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
@@ -1145,12 +1136,12 @@ static int coroutine_fn nbd_client_co_block_statu=
s(

 static void nbd_client_close(BlockDriverState *bs)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-    assert(client->ioc);
+    assert(s->ioc);

-    nbd_send_request(client->ioc, &request);
+    nbd_send_request(s->ioc, &request);

     nbd_teardown_connection(bs);
 }
@@ -1184,7 +1175,7 @@ static int nbd_client_connect(BlockDriverState *bs,
                               const char *x_dirty_bitmap,
                               Error **errp)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     int ret;

     /*
@@ -1201,44 +1192,44 @@ static int nbd_client_connect(BlockDriverState *b=
s,
     trace_nbd_client_connect(export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);

-    client->info.request_sizes =3D true;
-    client->info.structured_reply =3D true;
-    client->info.base_allocation =3D true;
-    client->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
-    client->info.name =3D g_strdup(export ?: "");
+    s->info.request_sizes =3D true;
+    s->info.structured_reply =3D true;
+    s->info.base_allocation =3D true;
+    s->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
+    s->info.name =3D g_strdup(export ?: "");
     ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
-                                &client->ioc, &client->info, errp);
-    g_free(client->info.x_dirty_bitmap);
-    g_free(client->info.name);
+                                &s->ioc, &s->info, errp);
+    g_free(s->info.x_dirty_bitmap);
+    g_free(s->info.name);
     if (ret < 0) {
         object_unref(OBJECT(sioc));
         return ret;
     }
-    if (x_dirty_bitmap && !client->info.base_allocation) {
+    if (x_dirty_bitmap && !s->info.base_allocation) {
         error_setg(errp, "requested x-dirty-bitmap %s not found",
                    x_dirty_bitmap);
         ret =3D -EINVAL;
         goto fail;
     }
-    if (client->info.flags & NBD_FLAG_READ_ONLY) {
+    if (s->info.flags & NBD_FLAG_READ_ONLY) {
         ret =3D bdrv_apply_auto_read_only(bs, "NBD export is read-only",=
 errp);
         if (ret < 0) {
             goto fail;
         }
     }
-    if (client->info.flags & NBD_FLAG_SEND_FUA) {
+    if (s->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags =3D BDRV_REQ_FUA;
         bs->supported_zero_flags |=3D BDRV_REQ_FUA;
     }
-    if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
+    if (s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
     }

-    client->sioc =3D sioc;
+    s->sioc =3D sioc;

-    if (!client->ioc) {
-        client->ioc =3D QIO_CHANNEL(sioc);
-        object_ref(OBJECT(client->ioc));
+    if (!s->ioc) {
+        s->ioc =3D QIO_CHANNEL(sioc);
+        object_ref(OBJECT(s->ioc));
     }

     /*
@@ -1246,7 +1237,7 @@ static int nbd_client_connect(BlockDriverState *bs,
      * kick the reply mechanism.
      */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
+    s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
     bdrv_inc_in_flight(bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));

@@ -1263,7 +1254,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     {
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+        nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);

         object_unref(OBJECT(sioc));

@@ -1279,11 +1270,11 @@ static int nbd_client_init(BlockDriverState *bs,
                            const char *x_dirty_bitmap,
                            Error **errp)
 {
-    NBDClientSession *client =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

-    client->bs =3D bs;
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
+    s->bs =3D bs;
+    qemu_co_mutex_init(&s->send_mutex);
+    qemu_co_queue_init(&s->free_sema);

     return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
                               x_dirty_bitmap, errp);
@@ -1665,7 +1656,7 @@ static int nbd_co_flush(BlockDriverState *bs)

 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    NBDClientSession *s =3D nbd_get_client_session(bs);
+    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     uint32_t min =3D s->info.min_block;
     uint32_t max =3D MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block=
);

@@ -1712,7 +1703,7 @@ static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D bs->opaque;

-    return s->client.info.size;
+    return s->info.size;
 }

 static void nbd_refresh_filename(BlockDriverState *bs)
--=20
2.20.1


