Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5351C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5C0206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5C0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hae2z-00043P-QE
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae06-0002E8-VL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae00-0001DO-Jo
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:27:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:45594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hadzz-0001AZ-Ca; Tue, 11 Jun 2019 06:27:28 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hadzt-00083J-Rg; Tue, 11 Jun 2019 13:27:21 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 11 Jun 2019 13:27:20 +0300
Message-Id: <20190611102720.86114-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190611102720.86114-1-vsementsov@virtuozzo.com>
References: <20190611102720.86114-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/3] block/nbd: merge NBDClientSession struct
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to keep it separate, it differs from others block driver
behavior and therefor confuses. Instead of generic
  'state = (State*)bs->opaque' we have to use special helper.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 197 +++++++++++++++++++++++++---------------------------
 1 file changed, 94 insertions(+), 103 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 1f00be2d66..81edabbf35 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -53,7 +53,7 @@ typedef struct {
     bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;
 
-typedef struct NBDClientSession {
+typedef struct BDRVNBDState {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
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
-    BDRVNBDState *s = bs->opaque;
-    return &s->client;
-}
-
-
-static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
+static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
 {
     int i;
 
@@ -99,14 +88,15 @@ static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 
 static void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
-    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
 }
 
 static void nbd_client_attach_aio_context_bh(void *opaque)
 {
     BlockDriverState *bs = opaque;
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
     /*
      * The node is still drained, so we know the coroutine has yielded in
@@ -114,15 +104,16 @@ static void nbd_client_attach_aio_context_bh(void *opaque)
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
-    NBDClientSession *client = nbd_get_client_session(bs);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+
+    qio_channel_attach_aio_context(QIO_CHANNEL(s->ioc), new_context);
 
     bdrv_inc_in_flight(bs);
 
@@ -136,26 +127,26 @@ static void nbd_client_attach_aio_context(BlockDriverState *bs,
 
 static void nbd_teardown_connection(BlockDriverState *bs)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
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
-    client->sioc = NULL;
-    object_unref(OBJECT(client->ioc));
-    client->ioc = NULL;
+    object_unref(OBJECT(s->sioc));
+    s->sioc = NULL;
+    object_unref(OBJECT(s->ioc));
+    s->ioc = NULL;
 }
 
 static coroutine_fn void nbd_connection_entry(void *opaque)
 {
-    NBDClientSession *s = opaque;
+    BDRVNBDState *s = opaque;
     uint64_t i;
     int ret = 0;
     Error *local_err = NULL;
@@ -223,7 +214,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                NBDRequest *request,
                                QEMUIOVector *qiov)
 {
-    NBDClientSession *s = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     int rc, i;
 
     qemu_co_mutex_lock(&s->send_mutex);
@@ -298,7 +289,7 @@ static inline uint64_t payload_advance64(uint8_t **payload)
     return ldq_be_p(*payload - 8);
 }
 
-static int nbd_parse_offset_hole_payload(NBDClientSession *client,
+static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_offset,
                                          QEMUIOVector *qiov, Error **errp)
@@ -321,8 +312,8 @@ static int nbd_parse_offset_hole_payload(NBDClientSession *client,
                          " region");
         return -EINVAL;
     }
-    if (client->info.min_block &&
-        !QEMU_IS_ALIGNED(hole_size, client->info.min_block)) {
+    if (s->info.min_block &&
+        !QEMU_IS_ALIGNED(hole_size, s->info.min_block)) {
         trace_nbd_structured_read_compliance("hole");
     }
 
@@ -336,7 +327,7 @@ static int nbd_parse_offset_hole_payload(NBDClientSession *client,
  * Based on our request, we expect only one extent in reply, for the
  * base:allocation context.
  */
-static int nbd_parse_blockstatus_payload(NBDClientSession *client,
+static int nbd_parse_blockstatus_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_length,
                                          NBDExtent *extent, Error **errp)
@@ -351,11 +342,11 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
     }
 
     context_id = payload_advance32(&payload);
-    if (client->info.context_id != context_id) {
+    if (s->info.context_id != context_id) {
         error_setg(errp, "Protocol error: unexpected context id %d for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
                          "id is %d", context_id,
-                         client->info.context_id);
+                         s->info.context_id);
         return -EINVAL;
     }
 
@@ -380,14 +371,14 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
      * up to the full block and change the status to fully-allocated
      * (always a safe status, even if it loses information).
      */
-    if (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                   client->info.min_block)) {
+    if (s->info.min_block && !QEMU_IS_ALIGNED(extent->length,
+                                                   s->info.min_block)) {
         trace_nbd_parse_blockstatus_compliance("extent length is unaligned");
-        if (extent->length > client->info.min_block) {
+        if (extent->length > s->info.min_block) {
             extent->length = QEMU_ALIGN_DOWN(extent->length,
-                                             client->info.min_block);
+                                             s->info.min_block);
         } else {
-            extent->length = client->info.min_block;
+            extent->length = s->info.min_block;
             extent->flags = 0;
         }
     }
@@ -453,7 +444,7 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
     return 0;
 }
 
-static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
+static int nbd_co_receive_offset_data_payload(BDRVNBDState *s,
                                               uint64_t orig_offset,
                                               QEMUIOVector *qiov, Error **errp)
 {
@@ -498,7 +489,7 @@ static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
 
 #define NBD_MAX_MALLOC_PAYLOAD 1000
 static coroutine_fn int nbd_co_receive_structured_payload(
-        NBDClientSession *s, void **payload, Error **errp)
+        BDRVNBDState *s, void **payload, Error **errp)
 {
     int ret;
     uint32_t len;
@@ -548,7 +539,7 @@ static coroutine_fn int nbd_co_receive_structured_payload(
  * corresponding to the server's error reply), and errp is unchanged.
  */
 static coroutine_fn int nbd_co_do_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t handle, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, void **payload, Error **errp)
 {
     int ret;
@@ -641,7 +632,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
+        BDRVNBDState *s, uint64_t handle, bool only_structured,
         int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **payload,
         Error **errp)
 {
@@ -709,7 +700,7 @@ static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
  * nbd_reply_chunk_iter_receive
  * The pointer stored in @payload requires g_free() to free it.
  */
-static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
+static bool nbd_reply_chunk_iter_receive(BDRVNBDState *s,
                                          NBDReplyChunkIter *iter,
                                          uint64_t handle,
                                          QEMUIOVector *qiov, NBDReply *reply,
@@ -776,7 +767,7 @@ break_loop:
     return false;
 }
 
-static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
+static int nbd_co_receive_return_code(BDRVNBDState *s, uint64_t handle,
                                       int *request_ret, Error **errp)
 {
     NBDReplyChunkIter iter;
@@ -790,7 +781,7 @@ static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t handle,
     return iter.ret;
 }
 
-static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
+static int nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t handle,
                                         uint64_t offset, QEMUIOVector *qiov,
                                         int *request_ret, Error **errp)
 {
@@ -842,7 +833,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
     return iter.ret;
 }
 
-static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
+static int nbd_co_receive_blockstatus_reply(BDRVNBDState *s,
                                             uint64_t handle, uint64_t length,
                                             NBDExtent *extent,
                                             int *request_ret, Error **errp)
@@ -907,7 +898,7 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
 {
     int ret, request_ret;
     Error *local_err = NULL;
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
     assert(request->type != NBD_CMD_READ);
     if (write_qiov) {
@@ -921,7 +912,7 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
         return ret;
     }
 
-    ret = nbd_co_receive_return_code(client, request->handle,
+    ret = nbd_co_receive_return_code(s, request->handle,
                                      &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request->from, request->len, request->handle,
@@ -938,7 +929,7 @@ static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
 {
     int ret, request_ret;
     Error *local_err = NULL;
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
         .type = NBD_CMD_READ,
         .from = offset,
@@ -957,13 +948,13 @@ static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
      * advertised size because the block layer rounded size up, then
      * truncate the request to the server and tail-pad with zero.
      */
-    if (offset >= client->info.size) {
+    if (offset >= s->info.size) {
         assert(bytes < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, 0, 0, bytes);
         return 0;
     }
-    if (offset + bytes > client->info.size) {
-        uint64_t slop = offset + bytes - client->info.size;
+    if (offset + bytes > s->info.size) {
+        uint64_t slop = offset + bytes - s->info.size;
 
         assert(slop < BDRV_SECTOR_SIZE);
         qemu_iovec_memset(qiov, bytes - slop, 0, slop);
@@ -975,7 +966,7 @@ static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
         return ret;
     }
 
-    ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
+    ret = nbd_co_receive_cmdread_reply(s, request.handle, offset, qiov,
                                        &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.handle,
@@ -990,16 +981,16 @@ static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
 static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                  uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
         .type = NBD_CMD_WRITE,
         .from = offset,
         .len = bytes,
     };
 
-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
+    assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (flags & BDRV_REQ_FUA) {
-        assert(client->info.flags & NBD_FLAG_SEND_FUA);
+        assert(s->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }
 
@@ -1014,20 +1005,20 @@ static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
 static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                        int bytes, BdrvRequestFlags flags)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
         .type = NBD_CMD_WRITE_ZEROES,
         .from = offset,
         .len = bytes,
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
         request.flags |= NBD_CMD_FLAG_FUA;
     }
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
@@ -1042,10 +1033,10 @@ static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
 
 static int nbd_client_co_flush(BlockDriverState *bs)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = { .type = NBD_CMD_FLUSH };
 
-    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
+    if (!(s->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
     }
 
@@ -1058,15 +1049,15 @@ static int nbd_client_co_flush(BlockDriverState *bs)
 static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
                                   int bytes)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
         .type = NBD_CMD_TRIM,
         .from = offset,
         .len = bytes,
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
     NBDExtent extent = { 0 };
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     Error *local_err = NULL;
 
     NBDRequest request = {
@@ -1087,12 +1078,12 @@ static int coroutine_fn nbd_client_co_block_status(
         .from = offset,
         .len = MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
                                                 bs->bl.request_alignment),
-                                client->info.max_block),
-                   MIN(bytes, client->info.size - offset)),
+                                s->info.max_block),
+                   MIN(bytes, s->info.size - offset)),
         .flags = NBD_CMD_FLAG_REQ_ONE,
     };
 
-    if (!client->info.base_allocation) {
+    if (!s->info.base_allocation) {
         *pnum = bytes;
         *map = offset;
         *file = bs;
@@ -1106,22 +1097,22 @@ static int coroutine_fn nbd_client_co_block_status(
      * up, we truncated the request to the server (above), or are
      * called on just the hole.
      */
-    if (offset >= client->info.size) {
+    if (offset >= s->info.size) {
         *pnum = bytes;
         assert(bytes < BDRV_SECTOR_SIZE);
         /* Intentionally don't report offset_valid for the hole */
         return BDRV_BLOCK_ZERO;
     }
 
-    if (client->info.min_block) {
-        assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
+    if (s->info.min_block) {
+        assert(QEMU_IS_ALIGNED(request.len, s->info.min_block));
     }
     ret = nbd_co_send_request(bs, &request, NULL);
     if (ret < 0) {
         return ret;
     }
 
-    ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
+    ret = nbd_co_receive_blockstatus_reply(s, request.handle, bytes,
                                            &extent, &request_ret, &local_err);
     if (local_err) {
         trace_nbd_co_request_fail(request.from, request.len, request.handle,
@@ -1145,12 +1136,12 @@ static int coroutine_fn nbd_client_co_block_status(
 
 static void nbd_client_close(BlockDriverState *bs)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = { .type = NBD_CMD_DISC };
 
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
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     int ret;
 
     /*
@@ -1201,44 +1192,44 @@ static int nbd_client_connect(BlockDriverState *bs,
     trace_nbd_client_connect(export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
-    client->info.request_sizes = true;
-    client->info.structured_reply = true;
-    client->info.base_allocation = true;
-    client->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
-    client->info.name = g_strdup(export ?: "");
+    s->info.request_sizes = true;
+    s->info.structured_reply = true;
+    s->info.base_allocation = true;
+    s->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
+    s->info.name = g_strdup(export ?: "");
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
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
         ret = -EINVAL;
         goto fail;
     }
-    if (client->info.flags & NBD_FLAG_READ_ONLY) {
+    if (s->info.flags & NBD_FLAG_READ_ONLY) {
         ret = bdrv_apply_auto_read_only(bs, "NBD export is read-only", errp);
         if (ret < 0) {
             goto fail;
         }
     }
-    if (client->info.flags & NBD_FLAG_SEND_FUA) {
+    if (s->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
         bs->supported_zero_flags |= BDRV_REQ_FUA;
     }
-    if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
+    if (s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
 
-    client->sioc = sioc;
+    s->sioc = sioc;
 
-    if (!client->ioc) {
-        client->ioc = QIO_CHANNEL(sioc);
-        object_ref(OBJECT(client->ioc));
+    if (!s->ioc) {
+        s->ioc = QIO_CHANNEL(sioc);
+        object_ref(OBJECT(s->ioc));
     }
 
     /*
@@ -1246,7 +1237,7 @@ static int nbd_client_connect(BlockDriverState *bs,
      * kick the reply mechanism.
      */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
+    s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
     bdrv_inc_in_flight(bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
@@ -1263,7 +1254,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     {
         NBDRequest request = { .type = NBD_CMD_DISC };
 
-        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+        nbd_send_request(s->ioc ?: QIO_CHANNEL(sioc), &request);
 
         object_unref(OBJECT(sioc));
 
@@ -1279,11 +1270,11 @@ static int nbd_client_init(BlockDriverState *bs,
                            const char *x_dirty_bitmap,
                            Error **errp)
 {
-    NBDClientSession *client = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
-    client->bs = bs;
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
+    s->bs = bs;
+    qemu_co_mutex_init(&s->send_mutex);
+    qemu_co_queue_init(&s->free_sema);
 
     return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
                               x_dirty_bitmap, errp);
@@ -1665,7 +1656,7 @@ static int nbd_co_flush(BlockDriverState *bs)
 
 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    NBDClientSession *s = nbd_get_client_session(bs);
+    BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     uint32_t min = s->info.min_block;
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);
 
@@ -1712,7 +1703,7 @@ static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
 
-    return s->client.info.size;
+    return s->info.size;
 }
 
 static void nbd_refresh_filename(BlockDriverState *bs)
-- 
2.18.0


