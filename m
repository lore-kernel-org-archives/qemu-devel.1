Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F64C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88E520645
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88E520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTWr-0006ED-3F
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRyr-0003C2-6I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRyj-0006vy-0B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRyR-0006YT-1g; Thu, 13 Jun 2019 11:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDC8A30860C6;
 Thu, 13 Jun 2019 15:48:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68D905C6D6;
 Thu, 13 Jun 2019 15:48:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:36 -0500
Message-Id: <20190613154837.21734-9-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 15:48:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/9] block/nbd: merge nbd-client.* to nbd.c
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason for keeping driver handlers realization separate from driver
structure. We can get rid of extra header file.

While being here, fix comments style, restore forgotten comments for
NBD_FOREACH_REPLY_CHUNK and nbd_reply_chunk_iter_receive, remove extra
includes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190611102720.86114-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.h  |   62 ---
 block/nbd-client.c  | 1226 -----------------------------------------
 block/nbd.c         | 1285 +++++++++++++++++++++++++++++++++++++++++--
 block/Makefile.objs |    2 +-
 block/trace-events  |    2 +-
 5 files changed, 1255 insertions(+), 1322 deletions(-)
 delete mode 100644 block/nbd-client.h
 delete mode 100644 block/nbd-client.c

diff --git a/block/nbd-client.h b/block/nbd-client.h
deleted file mode 100644
index 570538f4c884..000000000000
--- a/block/nbd-client.h
+++ /dev/null
@@ -1,62 +0,0 @@
-#ifndef NBD_CLIENT_H
-#define NBD_CLIENT_H
-
-#include "block/nbd.h"
-#include "block/block_int.h"
-#include "io/channel-socket.h"
-
-#define MAX_NBD_REQUESTS    16
-
-typedef struct {
-    Coroutine *coroutine;
-    uint64_t offset;        /* original offset of the request */
-    bool receiving;         /* waiting for connection_co? */
-} NBDClientRequest;
-
-typedef struct NBDClientSession {
-    QIOChannelSocket *sioc; /* The master data channel */
-    QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS=
) */
-    NBDExportInfo info;
-
-    CoMutex send_mutex;
-    CoQueue free_sema;
-    Coroutine *connection_co;
-    int in_flight;
-
-    NBDClientRequest requests[MAX_NBD_REQUESTS];
-    NBDReply reply;
-    BlockDriverState *bs;
-    bool quit;
-} NBDClientSession;
-
-NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
-
-int nbd_client_init(BlockDriverState *bs,
-                    SocketAddress *saddr,
-                    const char *export_name,
-                    QCryptoTLSCreds *tlscreds,
-                    const char *hostname,
-                    const char *x_dirty_bitmap,
-                    Error **errp);
-void nbd_client_close(BlockDriverState *bs);
-
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int byt=
es);
-int nbd_client_co_flush(BlockDriverState *bs);
-int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, QEMUIOVector *qiov, int flags)=
;
-int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                int bytes, BdrvRequestFlags flags);
-int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-                         uint64_t bytes, QEMUIOVector *qiov, int flags);
-
-void nbd_client_detach_aio_context(BlockDriverState *bs);
-void nbd_client_attach_aio_context(BlockDriverState *bs,
-                                   AioContext *new_context);
-
-int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
-                                            int64_t offset, int64_t byte=
s,
-                                            int64_t *pnum, int64_t *map,
-                                            BlockDriverState **file);
-
-#endif /* NBD_CLIENT_H */
diff --git a/block/nbd-client.c b/block/nbd-client.c
deleted file mode 100644
index f89a67c23b64..000000000000
--- a/block/nbd-client.c
+++ /dev/null
@@ -1,1226 +0,0 @@
-/*
- * QEMU Block driver for  NBD
- *
- * Copyright (C) 2016 Red Hat, Inc.
- * Copyright (C) 2008 Bull S.A.S.
- *     Author: Laurent Vivier <Laurent.Vivier@bull.net>
- *
- * Some parts:
- *    Copyright (C) 2007 Anthony Liguori <anthony@codemonkey.ws>
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-
-#include "trace.h"
-#include "qapi/error.h"
-#include "nbd-client.h"
-
-#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs)=
)
-#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs)=
)
-
-static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
-{
-    int i;
-
-    for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
-        NBDClientRequest *req =3D &s->requests[i];
-
-        if (req->coroutine && req->receiving) {
-            aio_co_wake(req->coroutine);
-        }
-    }
-}
-
-static void nbd_teardown_connection(BlockDriverState *bs)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-
-    assert(client->ioc);
-
-    /* finish any pending coroutines */
-    qio_channel_shutdown(client->ioc,
-                         QIO_CHANNEL_SHUTDOWN_BOTH,
-                         NULL);
-    BDRV_POLL_WHILE(bs, client->connection_co);
-
-    nbd_client_detach_aio_context(bs);
-    object_unref(OBJECT(client->sioc));
-    client->sioc =3D NULL;
-    object_unref(OBJECT(client->ioc));
-    client->ioc =3D NULL;
-}
-
-static coroutine_fn void nbd_connection_entry(void *opaque)
-{
-    NBDClientSession *s =3D opaque;
-    uint64_t i;
-    int ret =3D 0;
-    Error *local_err =3D NULL;
-
-    while (!s->quit) {
-        /*
-         * The NBD client can only really be considered idle when it has
-         * yielded from qio_channel_readv_all_eof(), waiting for data. T=
his is
-         * the point where the additional scheduled coroutine entry happ=
ens
-         * after nbd_client_attach_aio_context().
-         *
-         * Therefore we keep an additional in_flight reference all the t=
ime and
-         * only drop it temporarily here.
-         */
-        assert(s->reply.handle =3D=3D 0);
-        ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
-
-        if (local_err) {
-            trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
-            error_free(local_err);
-        }
-        if (ret <=3D 0) {
-            break;
-        }
-
-        /* There's no need for a mutex on the receive side, because the
-         * handler acts as a synchronization point and ensures that only
-         * one coroutine is called until the reply finishes.
-         */
-        i =3D HANDLE_TO_INDEX(s, s->reply.handle);
-        if (i >=3D MAX_NBD_REQUESTS ||
-            !s->requests[i].coroutine ||
-            !s->requests[i].receiving ||
-            (nbd_reply_is_structured(&s->reply) && !s->info.structured_r=
eply))
-        {
-            break;
-        }
-
-        /* We're woken up again by the request itself.  Note that there
-         * is no race between yielding and reentering connection_co.  Th=
is
-         * is because:
-         *
-         * - if the request runs on the same AioContext, it is only
-         *   entered after we yield
-         *
-         * - if the request runs on a different AioContext, reentering
-         *   connection_co happens through a bottom half, which can only
-         *   run after we yield.
-         */
-        aio_co_wake(s->requests[i].coroutine);
-        qemu_coroutine_yield();
-    }
-
-    s->quit =3D true;
-    nbd_recv_coroutines_wake_all(s);
-    bdrv_dec_in_flight(s->bs);
-
-    s->connection_co =3D NULL;
-    aio_wait_kick();
-}
-
-static int nbd_co_send_request(BlockDriverState *bs,
-                               NBDRequest *request,
-                               QEMUIOVector *qiov)
-{
-    NBDClientSession *s =3D nbd_get_client_session(bs);
-    int rc, i;
-
-    qemu_co_mutex_lock(&s->send_mutex);
-    while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
-        qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
-    }
-    s->in_flight++;
-
-    for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
-        if (s->requests[i].coroutine =3D=3D NULL) {
-            break;
-        }
-    }
-
-    g_assert(qemu_in_coroutine());
-    assert(i < MAX_NBD_REQUESTS);
-
-    s->requests[i].coroutine =3D qemu_coroutine_self();
-    s->requests[i].offset =3D request->from;
-    s->requests[i].receiving =3D false;
-
-    request->handle =3D INDEX_TO_HANDLE(s, i);
-
-    if (s->quit) {
-        rc =3D -EIO;
-        goto err;
-    }
-    assert(s->ioc);
-
-    if (qiov) {
-        qio_channel_set_cork(s->ioc, true);
-        rc =3D nbd_send_request(s->ioc, request);
-        if (rc >=3D 0 && !s->quit) {
-            if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
-                                       NULL) < 0) {
-                rc =3D -EIO;
-            }
-        } else if (rc >=3D 0) {
-            rc =3D -EIO;
-        }
-        qio_channel_set_cork(s->ioc, false);
-    } else {
-        rc =3D nbd_send_request(s->ioc, request);
-    }
-
-err:
-    if (rc < 0) {
-        s->quit =3D true;
-        s->requests[i].coroutine =3D NULL;
-        s->in_flight--;
-        qemu_co_queue_next(&s->free_sema);
-    }
-    qemu_co_mutex_unlock(&s->send_mutex);
-    return rc;
-}
-
-static inline uint16_t payload_advance16(uint8_t **payload)
-{
-    *payload +=3D 2;
-    return lduw_be_p(*payload - 2);
-}
-
-static inline uint32_t payload_advance32(uint8_t **payload)
-{
-    *payload +=3D 4;
-    return ldl_be_p(*payload - 4);
-}
-
-static inline uint64_t payload_advance64(uint8_t **payload)
-{
-    *payload +=3D 8;
-    return ldq_be_p(*payload - 8);
-}
-
-static int nbd_parse_offset_hole_payload(NBDClientSession *client,
-                                         NBDStructuredReplyChunk *chunk,
-                                         uint8_t *payload, uint64_t orig=
_offset,
-                                         QEMUIOVector *qiov, Error **err=
p)
-{
-    uint64_t offset;
-    uint32_t hole_size;
-
-    if (chunk->length !=3D sizeof(offset) + sizeof(hole_size)) {
-        error_setg(errp, "Protocol error: invalid payload for "
-                         "NBD_REPLY_TYPE_OFFSET_HOLE");
-        return -EINVAL;
-    }
-
-    offset =3D payload_advance64(&payload);
-    hole_size =3D payload_advance32(&payload);
-
-    if (!hole_size || offset < orig_offset || hole_size > qiov->size ||
-        offset > orig_offset + qiov->size - hole_size) {
-        error_setg(errp, "Protocol error: server sent chunk exceeding re=
quested"
-                         " region");
-        return -EINVAL;
-    }
-    if (client->info.min_block &&
-        !QEMU_IS_ALIGNED(hole_size, client->info.min_block)) {
-        trace_nbd_structured_read_compliance("hole");
-    }
-
-    qemu_iovec_memset(qiov, offset - orig_offset, 0, hole_size);
-
-    return 0;
-}
-
-/* nbd_parse_blockstatus_payload
- * Based on our request, we expect only one extent in reply, for the
- * base:allocation context.
- */
-static int nbd_parse_blockstatus_payload(NBDClientSession *client,
-                                         NBDStructuredReplyChunk *chunk,
-                                         uint8_t *payload, uint64_t orig=
_length,
-                                         NBDExtent *extent, Error **errp=
)
-{
-    uint32_t context_id;
-
-    /* The server succeeded, so it must have sent [at least] one extent =
*/
-    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
-        error_setg(errp, "Protocol error: invalid payload for "
-                         "NBD_REPLY_TYPE_BLOCK_STATUS");
-        return -EINVAL;
-    }
-
-    context_id =3D payload_advance32(&payload);
-    if (client->info.context_id !=3D context_id) {
-        error_setg(errp, "Protocol error: unexpected context id %d for "
-                         "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated c=
ontext "
-                         "id is %d", context_id,
-                         client->info.context_id);
-        return -EINVAL;
-    }
-
-    extent->length =3D payload_advance32(&payload);
-    extent->flags =3D payload_advance32(&payload);
-
-    if (extent->length =3D=3D 0) {
-        error_setg(errp, "Protocol error: server sent status chunk with =
"
-                   "zero length");
-        return -EINVAL;
-    }
-
-    /*
-     * A server sending unaligned block status is in violation of the
-     * protocol, but as qemu-nbd 3.1 is such a server (at least for
-     * POSIX files that are not a multiple of 512 bytes, since qemu
-     * rounds files up to 512-byte multiples but lseek(SEEK_HOLE)
-     * still sees an implicit hole beyond the real EOF), it's nicer to
-     * work around the misbehaving server. If the request included
-     * more than the final unaligned block, truncate it back to an
-     * aligned result; if the request was only the final block, round
-     * up to the full block and change the status to fully-allocated
-     * (always a safe status, even if it loses information).
-     */
-    if (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                   client->info.min_bloc=
k)) {
-        trace_nbd_parse_blockstatus_compliance("extent length is unalign=
ed");
-        if (extent->length > client->info.min_block) {
-            extent->length =3D QEMU_ALIGN_DOWN(extent->length,
-                                             client->info.min_block);
-        } else {
-            extent->length =3D client->info.min_block;
-            extent->flags =3D 0;
-        }
-    }
-
-    /*
-     * We used NBD_CMD_FLAG_REQ_ONE, so the server should not have
-     * sent us any more than one extent, nor should it have included
-     * status beyond our request in that extent. However, it's easy
-     * enough to ignore the server's noncompliance without killing the
-     * connection; just ignore trailing extents, and clamp things to
-     * the length of our request.
-     */
-    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
-        trace_nbd_parse_blockstatus_compliance("more than one extent");
-    }
-    if (extent->length > orig_length) {
-        extent->length =3D orig_length;
-        trace_nbd_parse_blockstatus_compliance("extent length too large"=
);
-    }
-
-    return 0;
-}
-
-/* nbd_parse_error_payload
- * on success @errp contains message describing nbd error reply
- */
-static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
-                                   uint8_t *payload, int *request_ret,
-                                   Error **errp)
-{
-    uint32_t error;
-    uint16_t message_size;
-
-    assert(chunk->type & (1 << 15));
-
-    if (chunk->length < sizeof(error) + sizeof(message_size)) {
-        error_setg(errp,
-                   "Protocol error: invalid payload for structured error=
");
-        return -EINVAL;
-    }
-
-    error =3D nbd_errno_to_system_errno(payload_advance32(&payload));
-    if (error =3D=3D 0) {
-        error_setg(errp, "Protocol error: server sent structured error c=
hunk "
-                         "with error =3D 0");
-        return -EINVAL;
-    }
-
-    *request_ret =3D -error;
-    message_size =3D payload_advance16(&payload);
-
-    if (message_size > chunk->length - sizeof(error) - sizeof(message_si=
ze)) {
-        error_setg(errp, "Protocol error: server sent structured error c=
hunk "
-                         "with incorrect message size");
-        return -EINVAL;
-    }
-
-    /* TODO: Add a trace point to mention the server complaint */
-
-    /* TODO handle ERROR_OFFSET */
-
-    return 0;
-}
-
-static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
-                                              uint64_t orig_offset,
-                                              QEMUIOVector *qiov, Error =
**errp)
-{
-    QEMUIOVector sub_qiov;
-    uint64_t offset;
-    size_t data_size;
-    int ret;
-    NBDStructuredReplyChunk *chunk =3D &s->reply.structured;
-
-    assert(nbd_reply_is_structured(&s->reply));
-
-    /* The NBD spec requires at least one byte of payload */
-    if (chunk->length <=3D sizeof(offset)) {
-        error_setg(errp, "Protocol error: invalid payload for "
-                         "NBD_REPLY_TYPE_OFFSET_DATA");
-        return -EINVAL;
-    }
-
-    if (nbd_read64(s->ioc, &offset, "OFFSET_DATA offset", errp) < 0) {
-        return -EIO;
-    }
-
-    data_size =3D chunk->length - sizeof(offset);
-    assert(data_size);
-    if (offset < orig_offset || data_size > qiov->size ||
-        offset > orig_offset + qiov->size - data_size) {
-        error_setg(errp, "Protocol error: server sent chunk exceeding re=
quested"
-                         " region");
-        return -EINVAL;
-    }
-    if (s->info.min_block && !QEMU_IS_ALIGNED(data_size, s->info.min_blo=
ck)) {
-        trace_nbd_structured_read_compliance("data");
-    }
-
-    qemu_iovec_init(&sub_qiov, qiov->niov);
-    qemu_iovec_concat(&sub_qiov, qiov, offset - orig_offset, data_size);
-    ret =3D qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, e=
rrp);
-    qemu_iovec_destroy(&sub_qiov);
-
-    return ret < 0 ? -EIO : 0;
-}
-
-#define NBD_MAX_MALLOC_PAYLOAD 1000
-/* nbd_co_receive_structured_payload
- */
-static coroutine_fn int nbd_co_receive_structured_payload(
-        NBDClientSession *s, void **payload, Error **errp)
-{
-    int ret;
-    uint32_t len;
-
-    assert(nbd_reply_is_structured(&s->reply));
-
-    len =3D s->reply.structured.length;
-
-    if (len =3D=3D 0) {
-        return 0;
-    }
-
-    if (payload =3D=3D NULL) {
-        error_setg(errp, "Unexpected structured payload");
-        return -EINVAL;
-    }
-
-    if (len > NBD_MAX_MALLOC_PAYLOAD) {
-        error_setg(errp, "Payload too large");
-        return -EINVAL;
-    }
-
-    *payload =3D g_new(char, len);
-    ret =3D nbd_read(s->ioc, *payload, len, "structured payload", errp);
-    if (ret < 0) {
-        g_free(*payload);
-        *payload =3D NULL;
-        return ret;
-    }
-
-    return 0;
-}
-
-/* nbd_co_do_receive_one_chunk
- * for simple reply:
- *   set request_ret to received reply error
- *   if qiov is not NULL: read payload to @qiov
- * for structured reply chunk:
- *   if error chunk: read payload, set @request_ret, do not set @payload
- *   else if offset_data chunk: read payload data to @qiov, do not set @=
payload
- *   else: read payload to @payload
- *
- * If function fails, @errp contains corresponding error message, and th=
e
- * connection with the server is suspect.  If it returns 0, then the
- * transaction succeeded (although @request_ret may be a negative errno
- * corresponding to the server's error reply), and errp is unchanged.
- */
-static coroutine_fn int nbd_co_do_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
-        int *request_ret, QEMUIOVector *qiov, void **payload, Error **er=
rp)
-{
-    int ret;
-    int i =3D HANDLE_TO_INDEX(s, handle);
-    void *local_payload =3D NULL;
-    NBDStructuredReplyChunk *chunk;
-
-    if (payload) {
-        *payload =3D NULL;
-    }
-    *request_ret =3D 0;
-
-    /* Wait until we're woken up by nbd_connection_entry.  */
-    s->requests[i].receiving =3D true;
-    qemu_coroutine_yield();
-    s->requests[i].receiving =3D false;
-    if (s->quit) {
-        error_setg(errp, "Connection closed");
-        return -EIO;
-    }
-    assert(s->ioc);
-
-    assert(s->reply.handle =3D=3D handle);
-
-    if (nbd_reply_is_simple(&s->reply)) {
-        if (only_structured) {
-            error_setg(errp, "Protocol error: simple reply when structur=
ed "
-                             "reply chunk was expected");
-            return -EINVAL;
-        }
-
-        *request_ret =3D -nbd_errno_to_system_errno(s->reply.simple.erro=
r);
-        if (*request_ret < 0 || !qiov) {
-            return 0;
-        }
-
-        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
-                                     errp) < 0 ? -EIO : 0;
-    }
-
-    /* handle structured reply chunk */
-    assert(s->info.structured_reply);
-    chunk =3D &s->reply.structured;
-
-    if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
-        if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
-            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk =
without"
-                       " NBD_REPLY_FLAG_DONE flag set");
-            return -EINVAL;
-        }
-        if (chunk->length) {
-            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk =
with"
-                       " nonzero length");
-            return -EINVAL;
-        }
-        return 0;
-    }
-
-    if (chunk->type =3D=3D NBD_REPLY_TYPE_OFFSET_DATA) {
-        if (!qiov) {
-            error_setg(errp, "Unexpected NBD_REPLY_TYPE_OFFSET_DATA chun=
k");
-            return -EINVAL;
-        }
-
-        return nbd_co_receive_offset_data_payload(s, s->requests[i].offs=
et,
-                                                  qiov, errp);
-    }
-
-    if (nbd_reply_type_is_error(chunk->type)) {
-        payload =3D &local_payload;
-    }
-
-    ret =3D nbd_co_receive_structured_payload(s, payload, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (nbd_reply_type_is_error(chunk->type)) {
-        ret =3D nbd_parse_error_payload(chunk, local_payload, request_re=
t, errp);
-        g_free(local_payload);
-        return ret;
-    }
-
-    return 0;
-}
-
-/* nbd_co_receive_one_chunk
- * Read reply, wake up connection_co and set s->quit if needed.
- * Return value is a fatal error code or normal nbd reply error code
- */
-static coroutine_fn int nbd_co_receive_one_chunk(
-        NBDClientSession *s, uint64_t handle, bool only_structured,
-        int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **pa=
yload,
-        Error **errp)
-{
-    int ret =3D nbd_co_do_receive_one_chunk(s, handle, only_structured,
-                                          request_ret, qiov, payload, er=
rp);
-
-    if (ret < 0) {
-        s->quit =3D true;
-    } else {
-        /* For assert at loop start in nbd_connection_entry */
-        if (reply) {
-            *reply =3D s->reply;
-        }
-        s->reply.handle =3D 0;
-    }
-
-    if (s->connection_co) {
-        aio_co_wake(s->connection_co);
-    }
-
-    return ret;
-}
-
-typedef struct NBDReplyChunkIter {
-    int ret;
-    int request_ret;
-    Error *err;
-    bool done, only_structured;
-} NBDReplyChunkIter;
-
-static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
-                                   int ret, Error **local_err)
-{
-    assert(ret < 0);
-
-    if (!iter->ret) {
-        iter->ret =3D ret;
-        error_propagate(&iter->err, *local_err);
-    } else {
-        error_free(*local_err);
-    }
-
-    *local_err =3D NULL;
-}
-
-static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
-{
-    assert(ret < 0);
-
-    if (!iter->request_ret) {
-        iter->request_ret =3D ret;
-    }
-}
-
-/* NBD_FOREACH_REPLY_CHUNK
- */
-#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
-                                qiov, reply, payload) \
-    for (iter =3D (NBDReplyChunkIter) { .only_structured =3D structured =
}; \
-         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, pay=
load);)
-
-/* nbd_reply_chunk_iter_receive
- */
-static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
-                                         NBDReplyChunkIter *iter,
-                                         uint64_t handle,
-                                         QEMUIOVector *qiov, NBDReply *r=
eply,
-                                         void **payload)
-{
-    int ret, request_ret;
-    NBDReply local_reply;
-    NBDStructuredReplyChunk *chunk;
-    Error *local_err =3D NULL;
-    if (s->quit) {
-        error_setg(&local_err, "Connection closed");
-        nbd_iter_channel_error(iter, -EIO, &local_err);
-        goto break_loop;
-    }
-
-    if (iter->done) {
-        /* Previous iteration was last. */
-        goto break_loop;
-    }
-
-    if (reply =3D=3D NULL) {
-        reply =3D &local_reply;
-    }
-
-    ret =3D nbd_co_receive_one_chunk(s, handle, iter->only_structured,
-                                   &request_ret, qiov, reply, payload,
-                                   &local_err);
-    if (ret < 0) {
-        nbd_iter_channel_error(iter, ret, &local_err);
-    } else if (request_ret < 0) {
-        nbd_iter_request_error(iter, request_ret);
-    }
-
-    /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple rep=
ly. */
-    if (nbd_reply_is_simple(reply) || s->quit) {
-        goto break_loop;
-    }
-
-    chunk =3D &reply->structured;
-    iter->only_structured =3D true;
-
-    if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
-        /* NBD_REPLY_FLAG_DONE is already checked in nbd_co_receive_one_=
chunk */
-        assert(chunk->flags & NBD_REPLY_FLAG_DONE);
-        goto break_loop;
-    }
-
-    if (chunk->flags & NBD_REPLY_FLAG_DONE) {
-        /* This iteration is last. */
-        iter->done =3D true;
-    }
-
-    /* Execute the loop body */
-    return true;
-
-break_loop:
-    s->requests[HANDLE_TO_INDEX(s, handle)].coroutine =3D NULL;
-
-    qemu_co_mutex_lock(&s->send_mutex);
-    s->in_flight--;
-    qemu_co_queue_next(&s->free_sema);
-    qemu_co_mutex_unlock(&s->send_mutex);
-
-    return false;
-}
-
-static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t hand=
le,
-                                      int *request_ret, Error **errp)
-{
-    NBDReplyChunkIter iter;
-
-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) {
-        /* nbd_reply_chunk_iter_receive does all the work */
-    }
-
-    error_propagate(errp, iter.err);
-    *request_ret =3D iter.request_ret;
-    return iter.ret;
-}
-
-static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t ha=
ndle,
-                                        uint64_t offset, QEMUIOVector *q=
iov,
-                                        int *request_ret, Error **errp)
-{
-    NBDReplyChunkIter iter;
-    NBDReply reply;
-    void *payload =3D NULL;
-    Error *local_err =3D NULL;
-
-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
-                            qiov, &reply, &payload)
-    {
-        int ret;
-        NBDStructuredReplyChunk *chunk =3D &reply.structured;
-
-        assert(nbd_reply_is_structured(&reply));
-
-        switch (chunk->type) {
-        case NBD_REPLY_TYPE_OFFSET_DATA:
-            /* special cased in nbd_co_receive_one_chunk, data is alread=
y
-             * in qiov */
-            break;
-        case NBD_REPLY_TYPE_OFFSET_HOLE:
-            ret =3D nbd_parse_offset_hole_payload(s, &reply.structured, =
payload,
-                                                offset, qiov, &local_err=
);
-            if (ret < 0) {
-                s->quit =3D true;
-                nbd_iter_channel_error(&iter, ret, &local_err);
-            }
-            break;
-        default:
-            if (!nbd_reply_type_is_error(chunk->type)) {
-                /* not allowed reply type */
-                s->quit =3D true;
-                error_setg(&local_err,
-                           "Unexpected reply type: %d (%s) for CMD_READ"=
,
-                           chunk->type, nbd_reply_type_lookup(chunk->typ=
e));
-                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
-            }
-        }
-
-        g_free(payload);
-        payload =3D NULL;
-    }
-
-    error_propagate(errp, iter.err);
-    *request_ret =3D iter.request_ret;
-    return iter.ret;
-}
-
-static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
-                                            uint64_t handle, uint64_t le=
ngth,
-                                            NBDExtent *extent,
-                                            int *request_ret, Error **er=
rp)
-{
-    NBDReplyChunkIter iter;
-    NBDReply reply;
-    void *payload =3D NULL;
-    Error *local_err =3D NULL;
-    bool received =3D false;
-
-    assert(!extent->length);
-    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &paylo=
ad) {
-        int ret;
-        NBDStructuredReplyChunk *chunk =3D &reply.structured;
-
-        assert(nbd_reply_is_structured(&reply));
-
-        switch (chunk->type) {
-        case NBD_REPLY_TYPE_BLOCK_STATUS:
-            if (received) {
-                s->quit =3D true;
-                error_setg(&local_err, "Several BLOCK_STATUS chunks in r=
eply");
-                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
-            }
-            received =3D true;
-
-            ret =3D nbd_parse_blockstatus_payload(s, &reply.structured,
-                                                payload, length, extent,
-                                                &local_err);
-            if (ret < 0) {
-                s->quit =3D true;
-                nbd_iter_channel_error(&iter, ret, &local_err);
-            }
-            break;
-        default:
-            if (!nbd_reply_type_is_error(chunk->type)) {
-                s->quit =3D true;
-                error_setg(&local_err,
-                           "Unexpected reply type: %d (%s) "
-                           "for CMD_BLOCK_STATUS",
-                           chunk->type, nbd_reply_type_lookup(chunk->typ=
e));
-                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
-            }
-        }
-
-        g_free(payload);
-        payload =3D NULL;
-    }
-
-    if (!extent->length && !iter.request_ret) {
-        error_setg(&local_err, "Server did not reply with any status ext=
ents");
-        nbd_iter_channel_error(&iter, -EIO, &local_err);
-    }
-
-    error_propagate(errp, iter.err);
-    *request_ret =3D iter.request_ret;
-    return iter.ret;
-}
-
-static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
-                          QEMUIOVector *write_qiov)
-{
-    int ret, request_ret;
-    Error *local_err =3D NULL;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-
-    assert(request->type !=3D NBD_CMD_READ);
-    if (write_qiov) {
-        assert(request->type =3D=3D NBD_CMD_WRITE);
-        assert(request->len =3D=3D iov_size(write_qiov->iov, write_qiov-=
>niov));
-    } else {
-        assert(request->type !=3D NBD_CMD_WRITE);
-    }
-    ret =3D nbd_co_send_request(bs, request, write_qiov);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D nbd_co_receive_return_code(client, request->handle,
-                                     &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request->from, request->len, request->=
handle,
-                                  request->flags, request->type,
-                                  nbd_cmd_lookup(request->type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
-    return ret ? ret : request_ret;
-}
-
-int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-                         uint64_t bytes, QEMUIOVector *qiov, int flags)
-{
-    int ret, request_ret;
-    Error *local_err =3D NULL;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D {
-        .type =3D NBD_CMD_READ,
-        .from =3D offset,
-        .len =3D bytes,
-    };
-
-    assert(bytes <=3D NBD_MAX_BUFFER_SIZE);
-    assert(!flags);
-
-    if (!bytes) {
-        return 0;
-    }
-    /*
-     * Work around the fact that the block layer doesn't do
-     * byte-accurate sizing yet - if the read exceeds the server's
-     * advertised size because the block layer rounded size up, then
-     * truncate the request to the server and tail-pad with zero.
-     */
-    if (offset >=3D client->info.size) {
-        assert(bytes < BDRV_SECTOR_SIZE);
-        qemu_iovec_memset(qiov, 0, 0, bytes);
-        return 0;
-    }
-    if (offset + bytes > client->info.size) {
-        uint64_t slop =3D offset + bytes - client->info.size;
-
-        assert(slop < BDRV_SECTOR_SIZE);
-        qemu_iovec_memset(qiov, bytes - slop, 0, slop);
-        request.len -=3D slop;
-    }
-
-    ret =3D nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D nbd_co_receive_cmdread_reply(client, request.handle, offset,=
 qiov,
-                                       &request_ret, &local_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
-    return ret ? ret : request_ret;
-}
-
-int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, QEMUIOVector *qiov, int flags)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D {
-        .type =3D NBD_CMD_WRITE,
-        .from =3D offset,
-        .len =3D bytes,
-    };
-
-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (flags & BDRV_REQ_FUA) {
-        assert(client->info.flags & NBD_FLAG_SEND_FUA);
-        request.flags |=3D NBD_CMD_FLAG_FUA;
-    }
-
-    assert(bytes <=3D NBD_MAX_BUFFER_SIZE);
-
-    if (!bytes) {
-        return 0;
-    }
-    return nbd_co_request(bs, &request, qiov);
-}
-
-int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                int bytes, BdrvRequestFlags flags)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D {
-        .type =3D NBD_CMD_WRITE_ZEROES,
-        .from =3D offset,
-        .len =3D bytes,
-    };
-
-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
-        return -ENOTSUP;
-    }
-
-    if (flags & BDRV_REQ_FUA) {
-        assert(client->info.flags & NBD_FLAG_SEND_FUA);
-        request.flags |=3D NBD_CMD_FLAG_FUA;
-    }
-    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
-        request.flags |=3D NBD_CMD_FLAG_NO_HOLE;
-    }
-
-    if (!bytes) {
-        return 0;
-    }
-    return nbd_co_request(bs, &request, NULL);
-}
-
-int nbd_client_co_flush(BlockDriverState *bs)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D { .type =3D NBD_CMD_FLUSH };
-
-    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
-        return 0;
-    }
-
-    request.from =3D 0;
-    request.len =3D 0;
-
-    return nbd_co_request(bs, &request, NULL);
-}
-
-int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int byt=
es)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D {
-        .type =3D NBD_CMD_TRIM,
-        .from =3D offset,
-        .len =3D bytes,
-    };
-
-    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
-    if (!(client->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
-        return 0;
-    }
-
-    return nbd_co_request(bs, &request, NULL);
-}
-
-int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
-                                            int64_t offset, int64_t byte=
s,
-                                            int64_t *pnum, int64_t *map,
-                                            BlockDriverState **file)
-{
-    int ret, request_ret;
-    NBDExtent extent =3D { 0 };
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    Error *local_err =3D NULL;
-
-    NBDRequest request =3D {
-        .type =3D NBD_CMD_BLOCK_STATUS,
-        .from =3D offset,
-        .len =3D MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
-                                                bs->bl.request_alignment=
),
-                                client->info.max_block),
-                   MIN(bytes, client->info.size - offset)),
-        .flags =3D NBD_CMD_FLAG_REQ_ONE,
-    };
-
-    if (!client->info.base_allocation) {
-        *pnum =3D bytes;
-        *map =3D offset;
-        *file =3D bs;
-        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
-    }
-
-    /*
-     * Work around the fact that the block layer doesn't do
-     * byte-accurate sizing yet - if the status request exceeds the
-     * server's advertised size because the block layer rounded size
-     * up, we truncated the request to the server (above), or are
-     * called on just the hole.
-     */
-    if (offset >=3D client->info.size) {
-        *pnum =3D bytes;
-        assert(bytes < BDRV_SECTOR_SIZE);
-        /* Intentionally don't report offset_valid for the hole */
-        return BDRV_BLOCK_ZERO;
-    }
-
-    if (client->info.min_block) {
-        assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
-    }
-    ret =3D nbd_co_send_request(bs, &request, NULL);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D nbd_co_receive_blockstatus_reply(client, request.handle, byt=
es,
-                                           &extent, &request_ret, &local=
_err);
-    if (local_err) {
-        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
-                                  request.flags, request.type,
-                                  nbd_cmd_lookup(request.type),
-                                  ret, error_get_pretty(local_err));
-        error_free(local_err);
-    }
-    if (ret < 0 || request_ret < 0) {
-        return ret ? ret : request_ret;
-    }
-
-    assert(extent.length);
-    *pnum =3D extent.length;
-    *map =3D offset;
-    *file =3D bs;
-    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
-        (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0) |
-        BDRV_BLOCK_OFFSET_VALID;
-}
-
-void nbd_client_detach_aio_context(BlockDriverState *bs)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
-}
-
-static void nbd_client_attach_aio_context_bh(void *opaque)
-{
-    BlockDriverState *bs =3D opaque;
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-
-    /* The node is still drained, so we know the coroutine has yielded i=
n
-     * nbd_read_eof(), the only place where bs->in_flight can reach 0, o=
r it is
-     * entered for the first time. Both places are safe for entering the
-     * coroutine.*/
-    qemu_aio_coroutine_enter(bs->aio_context, client->connection_co);
-    bdrv_dec_in_flight(bs);
-}
-
-void nbd_client_attach_aio_context(BlockDriverState *bs,
-                                   AioContext *new_context)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
-
-    bdrv_inc_in_flight(bs);
-
-    /* Need to wait here for the BH to run because the BH must run while=
 the
-     * node is still drained. */
-    aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, b=
s);
-}
-
-void nbd_client_close(BlockDriverState *bs)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    NBDRequest request =3D { .type =3D NBD_CMD_DISC };
-
-    assert(client->ioc);
-
-    nbd_send_request(client->ioc, &request);
-
-    nbd_teardown_connection(bs);
-}
-
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
-{
-    QIOChannelSocket *sioc;
-    Error *local_err =3D NULL;
-
-    sioc =3D qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
-
-    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
-    if (local_err) {
-        object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
-        return NULL;
-    }
-
-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
-
-    return sioc;
-}
-
-static int nbd_client_connect(BlockDriverState *bs,
-                              SocketAddress *saddr,
-                              const char *export,
-                              QCryptoTLSCreds *tlscreds,
-                              const char *hostname,
-                              const char *x_dirty_bitmap,
-                              Error **errp)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-    int ret;
-
-    /*
-     * establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    QIOChannelSocket *sioc =3D nbd_establish_connection(saddr, errp);
-
-    if (!sioc) {
-        return -ECONNREFUSED;
-    }
-
-    /* NBD handshake */
-    trace_nbd_client_connect(export);
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
-
-    client->info.request_sizes =3D true;
-    client->info.structured_reply =3D true;
-    client->info.base_allocation =3D true;
-    client->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
-    client->info.name =3D g_strdup(export ?: "");
-    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
-                                &client->ioc, &client->info, errp);
-    g_free(client->info.x_dirty_bitmap);
-    g_free(client->info.name);
-    if (ret < 0) {
-        object_unref(OBJECT(sioc));
-        return ret;
-    }
-    if (x_dirty_bitmap && !client->info.base_allocation) {
-        error_setg(errp, "requested x-dirty-bitmap %s not found",
-                   x_dirty_bitmap);
-        ret =3D -EINVAL;
-        goto fail;
-    }
-    if (client->info.flags & NBD_FLAG_READ_ONLY) {
-        ret =3D bdrv_apply_auto_read_only(bs, "NBD export is read-only",=
 errp);
-        if (ret < 0) {
-            goto fail;
-        }
-    }
-    if (client->info.flags & NBD_FLAG_SEND_FUA) {
-        bs->supported_write_flags =3D BDRV_REQ_FUA;
-        bs->supported_zero_flags |=3D BDRV_REQ_FUA;
-    }
-    if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
-        bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
-    }
-
-    client->sioc =3D sioc;
-
-    if (!client->ioc) {
-        client->ioc =3D QIO_CHANNEL(sioc);
-        object_ref(OBJECT(client->ioc));
-    }
-
-    /* Now that we're connected, set the socket to be non-blocking and
-     * kick the reply mechanism.  */
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
-    bdrv_inc_in_flight(bs);
-    nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
-
-    trace_nbd_client_connect_success(export);
-
-    return 0;
-
- fail:
-    /*
-     * We have connected, but must fail for other reasons. The
-     * connection is still blocking; send NBD_CMD_DISC as a courtesy
-     * to the server.
-     */
-    {
-        NBDRequest request =3D { .type =3D NBD_CMD_DISC };
-
-        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
-
-        object_unref(OBJECT(sioc));
-
-        return ret;
-    }
-}
-
-int nbd_client_init(BlockDriverState *bs,
-                    SocketAddress *saddr,
-                    const char *export,
-                    QCryptoTLSCreds *tlscreds,
-                    const char *hostname,
-                    const char *x_dirty_bitmap,
-                    Error **errp)
-{
-    NBDClientSession *client =3D nbd_get_client_session(bs);
-
-    client->bs =3D bs;
-    qemu_co_mutex_init(&client->send_mutex);
-    qemu_co_queue_init(&client->free_sema);
-
-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                              x_dirty_bitmap, errp);
-}
diff --git a/block/nbd.c b/block/nbd.c
index 208be596027c..1f00be2d664e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Block driver for  NBD
  *
+ * Copyright (C) 2016 Red Hat, Inc.
  * Copyright (C) 2008 Bull S.A.S.
  *     Author: Laurent Vivier <Laurent.Vivier@bull.net>
  *
@@ -27,21 +28,46 @@
  */

 #include "qemu/osdep.h"
-#include "nbd-client.h"
-#include "block/qdict.h"
-#include "qapi/error.h"
+
+#include "trace.h"
 #include "qemu/uri.h"
-#include "block/block_int.h"
-#include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
+
 #include "qapi/qapi-visit-sockets.h"
-#include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "qemu/cutils.h"
+
+#include "block/qdict.h"
+#include "block/nbd.h"
+#include "block/block_int.h"

 #define EN_OPTSTR ":exportname=3D"
+#define MAX_NBD_REQUESTS    16
+
+#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs)=
)
+#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs)=
)
+
+typedef struct {
+    Coroutine *coroutine;
+    uint64_t offset;        /* original offset of the request */
+    bool receiving;         /* waiting for connection_co? */
+} NBDClientRequest;
+
+typedef struct NBDClientSession {
+    QIOChannelSocket *sioc; /* The master data channel */
+    QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS=
) */
+    NBDExportInfo info;
+
+    CoMutex send_mutex;
+    CoQueue free_sema;
+    Coroutine *connection_co;
+    int in_flight;
+
+    NBDClientRequest requests[MAX_NBD_REQUESTS];
+    NBDReply reply;
+    BlockDriverState *bs;
+    bool quit;
+} NBDClientSession;

 typedef struct BDRVNBDState {
     NBDClientSession client;
@@ -51,6 +77,1218 @@ typedef struct BDRVNBDState {
     char *export, *tlscredsid;
 } BDRVNBDState;

+static NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
+{
+    BDRVNBDState *s =3D bs->opaque;
+    return &s->client;
+}
+
+
+static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
+{
+    int i;
+
+    for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
+        NBDClientRequest *req =3D &s->requests[i];
+
+        if (req->coroutine && req->receiving) {
+            aio_co_wake(req->coroutine);
+        }
+    }
+}
+
+static void nbd_client_detach_aio_context(BlockDriverState *bs)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
+}
+
+static void nbd_client_attach_aio_context_bh(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    /*
+     * The node is still drained, so we know the coroutine has yielded i=
n
+     * nbd_read_eof(), the only place where bs->in_flight can reach 0, o=
r it is
+     * entered for the first time. Both places are safe for entering the
+     * coroutine.
+     */
+    qemu_aio_coroutine_enter(bs->aio_context, client->connection_co);
+    bdrv_dec_in_flight(bs);
+}
+
+static void nbd_client_attach_aio_context(BlockDriverState *bs,
+                                          AioContext *new_context)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
+
+    bdrv_inc_in_flight(bs);
+
+    /*
+     * Need to wait here for the BH to run because the BH must run while=
 the
+     * node is still drained.
+     */
+    aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, b=
s);
+}
+
+
+static void nbd_teardown_connection(BlockDriverState *bs)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    assert(client->ioc);
+
+    /* finish any pending coroutines */
+    qio_channel_shutdown(client->ioc,
+                         QIO_CHANNEL_SHUTDOWN_BOTH,
+                         NULL);
+    BDRV_POLL_WHILE(bs, client->connection_co);
+
+    nbd_client_detach_aio_context(bs);
+    object_unref(OBJECT(client->sioc));
+    client->sioc =3D NULL;
+    object_unref(OBJECT(client->ioc));
+    client->ioc =3D NULL;
+}
+
+static coroutine_fn void nbd_connection_entry(void *opaque)
+{
+    NBDClientSession *s =3D opaque;
+    uint64_t i;
+    int ret =3D 0;
+    Error *local_err =3D NULL;
+
+    while (!s->quit) {
+        /*
+         * The NBD client can only really be considered idle when it has
+         * yielded from qio_channel_readv_all_eof(), waiting for data. T=
his is
+         * the point where the additional scheduled coroutine entry happ=
ens
+         * after nbd_client_attach_aio_context().
+         *
+         * Therefore we keep an additional in_flight reference all the t=
ime and
+         * only drop it temporarily here.
+         */
+        assert(s->reply.handle =3D=3D 0);
+        ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err);
+
+        if (local_err) {
+            trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
+            error_free(local_err);
+        }
+        if (ret <=3D 0) {
+            break;
+        }
+
+        /*
+         * There's no need for a mutex on the receive side, because the
+         * handler acts as a synchronization point and ensures that only
+         * one coroutine is called until the reply finishes.
+         */
+        i =3D HANDLE_TO_INDEX(s, s->reply.handle);
+        if (i >=3D MAX_NBD_REQUESTS ||
+            !s->requests[i].coroutine ||
+            !s->requests[i].receiving ||
+            (nbd_reply_is_structured(&s->reply) && !s->info.structured_r=
eply))
+        {
+            break;
+        }
+
+        /*
+         * We're woken up again by the request itself.  Note that there
+         * is no race between yielding and reentering connection_co.  Th=
is
+         * is because:
+         *
+         * - if the request runs on the same AioContext, it is only
+         *   entered after we yield
+         *
+         * - if the request runs on a different AioContext, reentering
+         *   connection_co happens through a bottom half, which can only
+         *   run after we yield.
+         */
+        aio_co_wake(s->requests[i].coroutine);
+        qemu_coroutine_yield();
+    }
+
+    s->quit =3D true;
+    nbd_recv_coroutines_wake_all(s);
+    bdrv_dec_in_flight(s->bs);
+
+    s->connection_co =3D NULL;
+    aio_wait_kick();
+}
+
+static int nbd_co_send_request(BlockDriverState *bs,
+                               NBDRequest *request,
+                               QEMUIOVector *qiov)
+{
+    NBDClientSession *s =3D nbd_get_client_session(bs);
+    int rc, i;
+
+    qemu_co_mutex_lock(&s->send_mutex);
+    while (s->in_flight =3D=3D MAX_NBD_REQUESTS) {
+        qemu_co_queue_wait(&s->free_sema, &s->send_mutex);
+    }
+    s->in_flight++;
+
+    for (i =3D 0; i < MAX_NBD_REQUESTS; i++) {
+        if (s->requests[i].coroutine =3D=3D NULL) {
+            break;
+        }
+    }
+
+    g_assert(qemu_in_coroutine());
+    assert(i < MAX_NBD_REQUESTS);
+
+    s->requests[i].coroutine =3D qemu_coroutine_self();
+    s->requests[i].offset =3D request->from;
+    s->requests[i].receiving =3D false;
+
+    request->handle =3D INDEX_TO_HANDLE(s, i);
+
+    if (s->quit) {
+        rc =3D -EIO;
+        goto err;
+    }
+    assert(s->ioc);
+
+    if (qiov) {
+        qio_channel_set_cork(s->ioc, true);
+        rc =3D nbd_send_request(s->ioc, request);
+        if (rc >=3D 0 && !s->quit) {
+            if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
+                                       NULL) < 0) {
+                rc =3D -EIO;
+            }
+        } else if (rc >=3D 0) {
+            rc =3D -EIO;
+        }
+        qio_channel_set_cork(s->ioc, false);
+    } else {
+        rc =3D nbd_send_request(s->ioc, request);
+    }
+
+err:
+    if (rc < 0) {
+        s->quit =3D true;
+        s->requests[i].coroutine =3D NULL;
+        s->in_flight--;
+        qemu_co_queue_next(&s->free_sema);
+    }
+    qemu_co_mutex_unlock(&s->send_mutex);
+    return rc;
+}
+
+static inline uint16_t payload_advance16(uint8_t **payload)
+{
+    *payload +=3D 2;
+    return lduw_be_p(*payload - 2);
+}
+
+static inline uint32_t payload_advance32(uint8_t **payload)
+{
+    *payload +=3D 4;
+    return ldl_be_p(*payload - 4);
+}
+
+static inline uint64_t payload_advance64(uint8_t **payload)
+{
+    *payload +=3D 8;
+    return ldq_be_p(*payload - 8);
+}
+
+static int nbd_parse_offset_hole_payload(NBDClientSession *client,
+                                         NBDStructuredReplyChunk *chunk,
+                                         uint8_t *payload, uint64_t orig=
_offset,
+                                         QEMUIOVector *qiov, Error **err=
p)
+{
+    uint64_t offset;
+    uint32_t hole_size;
+
+    if (chunk->length !=3D sizeof(offset) + sizeof(hole_size)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_OFFSET_HOLE");
+        return -EINVAL;
+    }
+
+    offset =3D payload_advance64(&payload);
+    hole_size =3D payload_advance32(&payload);
+
+    if (!hole_size || offset < orig_offset || hole_size > qiov->size ||
+        offset > orig_offset + qiov->size - hole_size) {
+        error_setg(errp, "Protocol error: server sent chunk exceeding re=
quested"
+                         " region");
+        return -EINVAL;
+    }
+    if (client->info.min_block &&
+        !QEMU_IS_ALIGNED(hole_size, client->info.min_block)) {
+        trace_nbd_structured_read_compliance("hole");
+    }
+
+    qemu_iovec_memset(qiov, offset - orig_offset, 0, hole_size);
+
+    return 0;
+}
+
+/*
+ * nbd_parse_blockstatus_payload
+ * Based on our request, we expect only one extent in reply, for the
+ * base:allocation context.
+ */
+static int nbd_parse_blockstatus_payload(NBDClientSession *client,
+                                         NBDStructuredReplyChunk *chunk,
+                                         uint8_t *payload, uint64_t orig=
_length,
+                                         NBDExtent *extent, Error **errp=
)
+{
+    uint32_t context_id;
+
+    /* The server succeeded, so it must have sent [at least] one extent =
*/
+    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_BLOCK_STATUS");
+        return -EINVAL;
+    }
+
+    context_id =3D payload_advance32(&payload);
+    if (client->info.context_id !=3D context_id) {
+        error_setg(errp, "Protocol error: unexpected context id %d for "
+                         "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated c=
ontext "
+                         "id is %d", context_id,
+                         client->info.context_id);
+        return -EINVAL;
+    }
+
+    extent->length =3D payload_advance32(&payload);
+    extent->flags =3D payload_advance32(&payload);
+
+    if (extent->length =3D=3D 0) {
+        error_setg(errp, "Protocol error: server sent status chunk with =
"
+                   "zero length");
+        return -EINVAL;
+    }
+
+    /*
+     * A server sending unaligned block status is in violation of the
+     * protocol, but as qemu-nbd 3.1 is such a server (at least for
+     * POSIX files that are not a multiple of 512 bytes, since qemu
+     * rounds files up to 512-byte multiples but lseek(SEEK_HOLE)
+     * still sees an implicit hole beyond the real EOF), it's nicer to
+     * work around the misbehaving server. If the request included
+     * more than the final unaligned block, truncate it back to an
+     * aligned result; if the request was only the final block, round
+     * up to the full block and change the status to fully-allocated
+     * (always a safe status, even if it loses information).
+     */
+    if (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
+                                                   client->info.min_bloc=
k)) {
+        trace_nbd_parse_blockstatus_compliance("extent length is unalign=
ed");
+        if (extent->length > client->info.min_block) {
+            extent->length =3D QEMU_ALIGN_DOWN(extent->length,
+                                             client->info.min_block);
+        } else {
+            extent->length =3D client->info.min_block;
+            extent->flags =3D 0;
+        }
+    }
+
+    /*
+     * We used NBD_CMD_FLAG_REQ_ONE, so the server should not have
+     * sent us any more than one extent, nor should it have included
+     * status beyond our request in that extent. However, it's easy
+     * enough to ignore the server's noncompliance without killing the
+     * connection; just ignore trailing extents, and clamp things to
+     * the length of our request.
+     */
+    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
+        trace_nbd_parse_blockstatus_compliance("more than one extent");
+    }
+    if (extent->length > orig_length) {
+        extent->length =3D orig_length;
+        trace_nbd_parse_blockstatus_compliance("extent length too large"=
);
+    }
+
+    return 0;
+}
+
+/*
+ * nbd_parse_error_payload
+ * on success @errp contains message describing nbd error reply
+ */
+static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
+                                   uint8_t *payload, int *request_ret,
+                                   Error **errp)
+{
+    uint32_t error;
+    uint16_t message_size;
+
+    assert(chunk->type & (1 << 15));
+
+    if (chunk->length < sizeof(error) + sizeof(message_size)) {
+        error_setg(errp,
+                   "Protocol error: invalid payload for structured error=
");
+        return -EINVAL;
+    }
+
+    error =3D nbd_errno_to_system_errno(payload_advance32(&payload));
+    if (error =3D=3D 0) {
+        error_setg(errp, "Protocol error: server sent structured error c=
hunk "
+                         "with error =3D 0");
+        return -EINVAL;
+    }
+
+    *request_ret =3D -error;
+    message_size =3D payload_advance16(&payload);
+
+    if (message_size > chunk->length - sizeof(error) - sizeof(message_si=
ze)) {
+        error_setg(errp, "Protocol error: server sent structured error c=
hunk "
+                         "with incorrect message size");
+        return -EINVAL;
+    }
+
+    /* TODO: Add a trace point to mention the server complaint */
+
+    /* TODO handle ERROR_OFFSET */
+
+    return 0;
+}
+
+static int nbd_co_receive_offset_data_payload(NBDClientSession *s,
+                                              uint64_t orig_offset,
+                                              QEMUIOVector *qiov, Error =
**errp)
+{
+    QEMUIOVector sub_qiov;
+    uint64_t offset;
+    size_t data_size;
+    int ret;
+    NBDStructuredReplyChunk *chunk =3D &s->reply.structured;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    /* The NBD spec requires at least one byte of payload */
+    if (chunk->length <=3D sizeof(offset)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_OFFSET_DATA");
+        return -EINVAL;
+    }
+
+    if (nbd_read64(s->ioc, &offset, "OFFSET_DATA offset", errp) < 0) {
+        return -EIO;
+    }
+
+    data_size =3D chunk->length - sizeof(offset);
+    assert(data_size);
+    if (offset < orig_offset || data_size > qiov->size ||
+        offset > orig_offset + qiov->size - data_size) {
+        error_setg(errp, "Protocol error: server sent chunk exceeding re=
quested"
+                         " region");
+        return -EINVAL;
+    }
+    if (s->info.min_block && !QEMU_IS_ALIGNED(data_size, s->info.min_blo=
ck)) {
+        trace_nbd_structured_read_compliance("data");
+    }
+
+    qemu_iovec_init(&sub_qiov, qiov->niov);
+    qemu_iovec_concat(&sub_qiov, qiov, offset - orig_offset, data_size);
+    ret =3D qio_channel_readv_all(s->ioc, sub_qiov.iov, sub_qiov.niov, e=
rrp);
+    qemu_iovec_destroy(&sub_qiov);
+
+    return ret < 0 ? -EIO : 0;
+}
+
+#define NBD_MAX_MALLOC_PAYLOAD 1000
+static coroutine_fn int nbd_co_receive_structured_payload(
+        NBDClientSession *s, void **payload, Error **errp)
+{
+    int ret;
+    uint32_t len;
+
+    assert(nbd_reply_is_structured(&s->reply));
+
+    len =3D s->reply.structured.length;
+
+    if (len =3D=3D 0) {
+        return 0;
+    }
+
+    if (payload =3D=3D NULL) {
+        error_setg(errp, "Unexpected structured payload");
+        return -EINVAL;
+    }
+
+    if (len > NBD_MAX_MALLOC_PAYLOAD) {
+        error_setg(errp, "Payload too large");
+        return -EINVAL;
+    }
+
+    *payload =3D g_new(char, len);
+    ret =3D nbd_read(s->ioc, *payload, len, "structured payload", errp);
+    if (ret < 0) {
+        g_free(*payload);
+        *payload =3D NULL;
+        return ret;
+    }
+
+    return 0;
+}
+
+/*
+ * nbd_co_do_receive_one_chunk
+ * for simple reply:
+ *   set request_ret to received reply error
+ *   if qiov is not NULL: read payload to @qiov
+ * for structured reply chunk:
+ *   if error chunk: read payload, set @request_ret, do not set @payload
+ *   else if offset_data chunk: read payload data to @qiov, do not set @=
payload
+ *   else: read payload to @payload
+ *
+ * If function fails, @errp contains corresponding error message, and th=
e
+ * connection with the server is suspect.  If it returns 0, then the
+ * transaction succeeded (although @request_ret may be a negative errno
+ * corresponding to the server's error reply), and errp is unchanged.
+ */
+static coroutine_fn int nbd_co_do_receive_one_chunk(
+        NBDClientSession *s, uint64_t handle, bool only_structured,
+        int *request_ret, QEMUIOVector *qiov, void **payload, Error **er=
rp)
+{
+    int ret;
+    int i =3D HANDLE_TO_INDEX(s, handle);
+    void *local_payload =3D NULL;
+    NBDStructuredReplyChunk *chunk;
+
+    if (payload) {
+        *payload =3D NULL;
+    }
+    *request_ret =3D 0;
+
+    /* Wait until we're woken up by nbd_connection_entry.  */
+    s->requests[i].receiving =3D true;
+    qemu_coroutine_yield();
+    s->requests[i].receiving =3D false;
+    if (s->quit) {
+        error_setg(errp, "Connection closed");
+        return -EIO;
+    }
+    assert(s->ioc);
+
+    assert(s->reply.handle =3D=3D handle);
+
+    if (nbd_reply_is_simple(&s->reply)) {
+        if (only_structured) {
+            error_setg(errp, "Protocol error: simple reply when structur=
ed "
+                             "reply chunk was expected");
+            return -EINVAL;
+        }
+
+        *request_ret =3D -nbd_errno_to_system_errno(s->reply.simple.erro=
r);
+        if (*request_ret < 0 || !qiov) {
+            return 0;
+        }
+
+        return qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
+                                     errp) < 0 ? -EIO : 0;
+    }
+
+    /* handle structured reply chunk */
+    assert(s->info.structured_reply);
+    chunk =3D &s->reply.structured;
+
+    if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
+        if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
+            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk =
without"
+                       " NBD_REPLY_FLAG_DONE flag set");
+            return -EINVAL;
+        }
+        if (chunk->length) {
+            error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk =
with"
+                       " nonzero length");
+            return -EINVAL;
+        }
+        return 0;
+    }
+
+    if (chunk->type =3D=3D NBD_REPLY_TYPE_OFFSET_DATA) {
+        if (!qiov) {
+            error_setg(errp, "Unexpected NBD_REPLY_TYPE_OFFSET_DATA chun=
k");
+            return -EINVAL;
+        }
+
+        return nbd_co_receive_offset_data_payload(s, s->requests[i].offs=
et,
+                                                  qiov, errp);
+    }
+
+    if (nbd_reply_type_is_error(chunk->type)) {
+        payload =3D &local_payload;
+    }
+
+    ret =3D nbd_co_receive_structured_payload(s, payload, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (nbd_reply_type_is_error(chunk->type)) {
+        ret =3D nbd_parse_error_payload(chunk, local_payload, request_re=
t, errp);
+        g_free(local_payload);
+        return ret;
+    }
+
+    return 0;
+}
+
+/*
+ * nbd_co_receive_one_chunk
+ * Read reply, wake up connection_co and set s->quit if needed.
+ * Return value is a fatal error code or normal nbd reply error code
+ */
+static coroutine_fn int nbd_co_receive_one_chunk(
+        NBDClientSession *s, uint64_t handle, bool only_structured,
+        int *request_ret, QEMUIOVector *qiov, NBDReply *reply, void **pa=
yload,
+        Error **errp)
+{
+    int ret =3D nbd_co_do_receive_one_chunk(s, handle, only_structured,
+                                          request_ret, qiov, payload, er=
rp);
+
+    if (ret < 0) {
+        s->quit =3D true;
+    } else {
+        /* For assert at loop start in nbd_connection_entry */
+        if (reply) {
+            *reply =3D s->reply;
+        }
+        s->reply.handle =3D 0;
+    }
+
+    if (s->connection_co) {
+        aio_co_wake(s->connection_co);
+    }
+
+    return ret;
+}
+
+typedef struct NBDReplyChunkIter {
+    int ret;
+    int request_ret;
+    Error *err;
+    bool done, only_structured;
+} NBDReplyChunkIter;
+
+static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
+                                   int ret, Error **local_err)
+{
+    assert(ret < 0);
+
+    if (!iter->ret) {
+        iter->ret =3D ret;
+        error_propagate(&iter->err, *local_err);
+    } else {
+        error_free(*local_err);
+    }
+
+    *local_err =3D NULL;
+}
+
+static void nbd_iter_request_error(NBDReplyChunkIter *iter, int ret)
+{
+    assert(ret < 0);
+
+    if (!iter->request_ret) {
+        iter->request_ret =3D ret;
+    }
+}
+
+/*
+ * NBD_FOREACH_REPLY_CHUNK
+ * The pointer stored in @payload requires g_free() to free it.
+ */
+#define NBD_FOREACH_REPLY_CHUNK(s, iter, handle, structured, \
+                                qiov, reply, payload) \
+    for (iter =3D (NBDReplyChunkIter) { .only_structured =3D structured =
}; \
+         nbd_reply_chunk_iter_receive(s, &iter, handle, qiov, reply, pay=
load);)
+
+/*
+ * nbd_reply_chunk_iter_receive
+ * The pointer stored in @payload requires g_free() to free it.
+ */
+static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
+                                         NBDReplyChunkIter *iter,
+                                         uint64_t handle,
+                                         QEMUIOVector *qiov, NBDReply *r=
eply,
+                                         void **payload)
+{
+    int ret, request_ret;
+    NBDReply local_reply;
+    NBDStructuredReplyChunk *chunk;
+    Error *local_err =3D NULL;
+    if (s->quit) {
+        error_setg(&local_err, "Connection closed");
+        nbd_iter_channel_error(iter, -EIO, &local_err);
+        goto break_loop;
+    }
+
+    if (iter->done) {
+        /* Previous iteration was last. */
+        goto break_loop;
+    }
+
+    if (reply =3D=3D NULL) {
+        reply =3D &local_reply;
+    }
+
+    ret =3D nbd_co_receive_one_chunk(s, handle, iter->only_structured,
+                                   &request_ret, qiov, reply, payload,
+                                   &local_err);
+    if (ret < 0) {
+        nbd_iter_channel_error(iter, ret, &local_err);
+    } else if (request_ret < 0) {
+        nbd_iter_request_error(iter, request_ret);
+    }
+
+    /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple rep=
ly. */
+    if (nbd_reply_is_simple(reply) || s->quit) {
+        goto break_loop;
+    }
+
+    chunk =3D &reply->structured;
+    iter->only_structured =3D true;
+
+    if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
+        /* NBD_REPLY_FLAG_DONE is already checked in nbd_co_receive_one_=
chunk */
+        assert(chunk->flags & NBD_REPLY_FLAG_DONE);
+        goto break_loop;
+    }
+
+    if (chunk->flags & NBD_REPLY_FLAG_DONE) {
+        /* This iteration is last. */
+        iter->done =3D true;
+    }
+
+    /* Execute the loop body */
+    return true;
+
+break_loop:
+    s->requests[HANDLE_TO_INDEX(s, handle)].coroutine =3D NULL;
+
+    qemu_co_mutex_lock(&s->send_mutex);
+    s->in_flight--;
+    qemu_co_queue_next(&s->free_sema);
+    qemu_co_mutex_unlock(&s->send_mutex);
+
+    return false;
+}
+
+static int nbd_co_receive_return_code(NBDClientSession *s, uint64_t hand=
le,
+                                      int *request_ret, Error **errp)
+{
+    NBDReplyChunkIter iter;
+
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, NULL, NULL) {
+        /* nbd_reply_chunk_iter_receive does all the work */
+    }
+
+    error_propagate(errp, iter.err);
+    *request_ret =3D iter.request_ret;
+    return iter.ret;
+}
+
+static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t ha=
ndle,
+                                        uint64_t offset, QEMUIOVector *q=
iov,
+                                        int *request_ret, Error **errp)
+{
+    NBDReplyChunkIter iter;
+    NBDReply reply;
+    void *payload =3D NULL;
+    Error *local_err =3D NULL;
+
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
+                            qiov, &reply, &payload)
+    {
+        int ret;
+        NBDStructuredReplyChunk *chunk =3D &reply.structured;
+
+        assert(nbd_reply_is_structured(&reply));
+
+        switch (chunk->type) {
+        case NBD_REPLY_TYPE_OFFSET_DATA:
+            /*
+             * special cased in nbd_co_receive_one_chunk, data is alread=
y
+             * in qiov
+             */
+            break;
+        case NBD_REPLY_TYPE_OFFSET_HOLE:
+            ret =3D nbd_parse_offset_hole_payload(s, &reply.structured, =
payload,
+                                                offset, qiov, &local_err=
);
+            if (ret < 0) {
+                s->quit =3D true;
+                nbd_iter_channel_error(&iter, ret, &local_err);
+            }
+            break;
+        default:
+            if (!nbd_reply_type_is_error(chunk->type)) {
+                /* not allowed reply type */
+                s->quit =3D true;
+                error_setg(&local_err,
+                           "Unexpected reply type: %d (%s) for CMD_READ"=
,
+                           chunk->type, nbd_reply_type_lookup(chunk->typ=
e));
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
+            }
+        }
+
+        g_free(payload);
+        payload =3D NULL;
+    }
+
+    error_propagate(errp, iter.err);
+    *request_ret =3D iter.request_ret;
+    return iter.ret;
+}
+
+static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
+                                            uint64_t handle, uint64_t le=
ngth,
+                                            NBDExtent *extent,
+                                            int *request_ret, Error **er=
rp)
+{
+    NBDReplyChunkIter iter;
+    NBDReply reply;
+    void *payload =3D NULL;
+    Error *local_err =3D NULL;
+    bool received =3D false;
+
+    assert(!extent->length);
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, false, NULL, &reply, &paylo=
ad) {
+        int ret;
+        NBDStructuredReplyChunk *chunk =3D &reply.structured;
+
+        assert(nbd_reply_is_structured(&reply));
+
+        switch (chunk->type) {
+        case NBD_REPLY_TYPE_BLOCK_STATUS:
+            if (received) {
+                s->quit =3D true;
+                error_setg(&local_err, "Several BLOCK_STATUS chunks in r=
eply");
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
+            }
+            received =3D true;
+
+            ret =3D nbd_parse_blockstatus_payload(s, &reply.structured,
+                                                payload, length, extent,
+                                                &local_err);
+            if (ret < 0) {
+                s->quit =3D true;
+                nbd_iter_channel_error(&iter, ret, &local_err);
+            }
+            break;
+        default:
+            if (!nbd_reply_type_is_error(chunk->type)) {
+                s->quit =3D true;
+                error_setg(&local_err,
+                           "Unexpected reply type: %d (%s) "
+                           "for CMD_BLOCK_STATUS",
+                           chunk->type, nbd_reply_type_lookup(chunk->typ=
e));
+                nbd_iter_channel_error(&iter, -EINVAL, &local_err);
+            }
+        }
+
+        g_free(payload);
+        payload =3D NULL;
+    }
+
+    if (!extent->length && !iter.request_ret) {
+        error_setg(&local_err, "Server did not reply with any status ext=
ents");
+        nbd_iter_channel_error(&iter, -EIO, &local_err);
+    }
+
+    error_propagate(errp, iter.err);
+    *request_ret =3D iter.request_ret;
+    return iter.ret;
+}
+
+static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
+                          QEMUIOVector *write_qiov)
+{
+    int ret, request_ret;
+    Error *local_err =3D NULL;
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    assert(request->type !=3D NBD_CMD_READ);
+    if (write_qiov) {
+        assert(request->type =3D=3D NBD_CMD_WRITE);
+        assert(request->len =3D=3D iov_size(write_qiov->iov, write_qiov-=
>niov));
+    } else {
+        assert(request->type !=3D NBD_CMD_WRITE);
+    }
+    ret =3D nbd_co_send_request(bs, request, write_qiov);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D nbd_co_receive_return_code(client, request->handle,
+                                     &request_ret, &local_err);
+    if (local_err) {
+        trace_nbd_co_request_fail(request->from, request->len, request->=
handle,
+                                  request->flags, request->type,
+                                  nbd_cmd_lookup(request->type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
+    }
+    return ret ? ret : request_ret;
+}
+
+static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
+                                uint64_t bytes, QEMUIOVector *qiov, int =
flags)
+{
+    int ret, request_ret;
+    Error *local_err =3D NULL;
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D {
+        .type =3D NBD_CMD_READ,
+        .from =3D offset,
+        .len =3D bytes,
+    };
+
+    assert(bytes <=3D NBD_MAX_BUFFER_SIZE);
+    assert(!flags);
+
+    if (!bytes) {
+        return 0;
+    }
+    /*
+     * Work around the fact that the block layer doesn't do
+     * byte-accurate sizing yet - if the read exceeds the server's
+     * advertised size because the block layer rounded size up, then
+     * truncate the request to the server and tail-pad with zero.
+     */
+    if (offset >=3D client->info.size) {
+        assert(bytes < BDRV_SECTOR_SIZE);
+        qemu_iovec_memset(qiov, 0, 0, bytes);
+        return 0;
+    }
+    if (offset + bytes > client->info.size) {
+        uint64_t slop =3D offset + bytes - client->info.size;
+
+        assert(slop < BDRV_SECTOR_SIZE);
+        qemu_iovec_memset(qiov, bytes - slop, 0, slop);
+        request.len -=3D slop;
+    }
+
+    ret =3D nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D nbd_co_receive_cmdread_reply(client, request.handle, offset,=
 qiov,
+                                       &request_ret, &local_err);
+    if (local_err) {
+        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
+    }
+    return ret ? ret : request_ret;
+}
+
+static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
+                                 uint64_t bytes, QEMUIOVector *qiov, int=
 flags)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D {
+        .type =3D NBD_CMD_WRITE,
+        .from =3D offset,
+        .len =3D bytes,
+    };
+
+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
+    if (flags & BDRV_REQ_FUA) {
+        assert(client->info.flags & NBD_FLAG_SEND_FUA);
+        request.flags |=3D NBD_CMD_FLAG_FUA;
+    }
+
+    assert(bytes <=3D NBD_MAX_BUFFER_SIZE);
+
+    if (!bytes) {
+        return 0;
+    }
+    return nbd_co_request(bs, &request, qiov);
+}
+
+static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t off=
set,
+                                       int bytes, BdrvRequestFlags flags=
)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D {
+        .type =3D NBD_CMD_WRITE_ZEROES,
+        .from =3D offset,
+        .len =3D bytes,
+    };
+
+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
+        return -ENOTSUP;
+    }
+
+    if (flags & BDRV_REQ_FUA) {
+        assert(client->info.flags & NBD_FLAG_SEND_FUA);
+        request.flags |=3D NBD_CMD_FLAG_FUA;
+    }
+    if (!(flags & BDRV_REQ_MAY_UNMAP)) {
+        request.flags |=3D NBD_CMD_FLAG_NO_HOLE;
+    }
+
+    if (!bytes) {
+        return 0;
+    }
+    return nbd_co_request(bs, &request, NULL);
+}
+
+static int nbd_client_co_flush(BlockDriverState *bs)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D { .type =3D NBD_CMD_FLUSH };
+
+    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
+        return 0;
+    }
+
+    request.from =3D 0;
+    request.len =3D 0;
+
+    return nbd_co_request(bs, &request, NULL);
+}
+
+static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
+                                  int bytes)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D {
+        .type =3D NBD_CMD_TRIM,
+        .from =3D offset,
+        .len =3D bytes,
+    };
+
+    assert(!(client->info.flags & NBD_FLAG_READ_ONLY));
+    if (!(client->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
+        return 0;
+    }
+
+    return nbd_co_request(bs, &request, NULL);
+}
+
+static int coroutine_fn nbd_client_co_block_status(
+        BlockDriverState *bs, bool want_zero, int64_t offset, int64_t by=
tes,
+        int64_t *pnum, int64_t *map, BlockDriverState **file)
+{
+    int ret, request_ret;
+    NBDExtent extent =3D { 0 };
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    Error *local_err =3D NULL;
+
+    NBDRequest request =3D {
+        .type =3D NBD_CMD_BLOCK_STATUS,
+        .from =3D offset,
+        .len =3D MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
+                                                bs->bl.request_alignment=
),
+                                client->info.max_block),
+                   MIN(bytes, client->info.size - offset)),
+        .flags =3D NBD_CMD_FLAG_REQ_ONE,
+    };
+
+    if (!client->info.base_allocation) {
+        *pnum =3D bytes;
+        *map =3D offset;
+        *file =3D bs;
+        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+    }
+
+    /*
+     * Work around the fact that the block layer doesn't do
+     * byte-accurate sizing yet - if the status request exceeds the
+     * server's advertised size because the block layer rounded size
+     * up, we truncated the request to the server (above), or are
+     * called on just the hole.
+     */
+    if (offset >=3D client->info.size) {
+        *pnum =3D bytes;
+        assert(bytes < BDRV_SECTOR_SIZE);
+        /* Intentionally don't report offset_valid for the hole */
+        return BDRV_BLOCK_ZERO;
+    }
+
+    if (client->info.min_block) {
+        assert(QEMU_IS_ALIGNED(request.len, client->info.min_block));
+    }
+    ret =3D nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D nbd_co_receive_blockstatus_reply(client, request.handle, byt=
es,
+                                           &extent, &request_ret, &local=
_err);
+    if (local_err) {
+        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
+    }
+    if (ret < 0 || request_ret < 0) {
+        return ret ? ret : request_ret;
+    }
+
+    assert(extent.length);
+    *pnum =3D extent.length;
+    *map =3D offset;
+    *file =3D bs;
+    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
+        (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0) |
+        BDRV_BLOCK_OFFSET_VALID;
+}
+
+static void nbd_client_close(BlockDriverState *bs)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    NBDRequest request =3D { .type =3D NBD_CMD_DISC };
+
+    assert(client->ioc);
+
+    nbd_send_request(client->ioc, &request);
+
+    nbd_teardown_connection(bs);
+}
+
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+                                                  Error **errp)
+{
+    QIOChannelSocket *sioc;
+    Error *local_err =3D NULL;
+
+    sioc =3D qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+
+    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
+    if (local_err) {
+        object_unref(OBJECT(sioc));
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+
+    return sioc;
+}
+
+static int nbd_client_connect(BlockDriverState *bs,
+                              SocketAddress *saddr,
+                              const char *export,
+                              QCryptoTLSCreds *tlscreds,
+                              const char *hostname,
+                              const char *x_dirty_bitmap,
+                              Error **errp)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+    int ret;
+
+    /*
+     * establish TCP connection, return error if it fails
+     * TODO: Configurable retry-until-timeout behaviour.
+     */
+    QIOChannelSocket *sioc =3D nbd_establish_connection(saddr, errp);
+
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
+    /* NBD handshake */
+    trace_nbd_client_connect(export);
+    qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
+
+    client->info.request_sizes =3D true;
+    client->info.structured_reply =3D true;
+    client->info.base_allocation =3D true;
+    client->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
+    client->info.name =3D g_strdup(export ?: "");
+    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
+                                &client->ioc, &client->info, errp);
+    g_free(client->info.x_dirty_bitmap);
+    g_free(client->info.name);
+    if (ret < 0) {
+        object_unref(OBJECT(sioc));
+        return ret;
+    }
+    if (x_dirty_bitmap && !client->info.base_allocation) {
+        error_setg(errp, "requested x-dirty-bitmap %s not found",
+                   x_dirty_bitmap);
+        ret =3D -EINVAL;
+        goto fail;
+    }
+    if (client->info.flags & NBD_FLAG_READ_ONLY) {
+        ret =3D bdrv_apply_auto_read_only(bs, "NBD export is read-only",=
 errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+    if (client->info.flags & NBD_FLAG_SEND_FUA) {
+        bs->supported_write_flags =3D BDRV_REQ_FUA;
+        bs->supported_zero_flags |=3D BDRV_REQ_FUA;
+    }
+    if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
+        bs->supported_zero_flags |=3D BDRV_REQ_MAY_UNMAP;
+    }
+
+    client->sioc =3D sioc;
+
+    if (!client->ioc) {
+        client->ioc =3D QIO_CHANNEL(sioc);
+        object_ref(OBJECT(client->ioc));
+    }
+
+    /*
+     * Now that we're connected, set the socket to be non-blocking and
+     * kick the reply mechanism.
+     */
+    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
+    client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
+    bdrv_inc_in_flight(bs);
+    nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
+
+    trace_nbd_client_connect_success(export);
+
+    return 0;
+
+ fail:
+    /*
+     * We have connected, but must fail for other reasons. The
+     * connection is still blocking; send NBD_CMD_DISC as a courtesy
+     * to the server.
+     */
+    {
+        NBDRequest request =3D { .type =3D NBD_CMD_DISC };
+
+        nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+
+        object_unref(OBJECT(sioc));
+
+        return ret;
+    }
+}
+
+static int nbd_client_init(BlockDriverState *bs,
+                           SocketAddress *saddr,
+                           const char *export,
+                           QCryptoTLSCreds *tlscreds,
+                           const char *hostname,
+                           const char *x_dirty_bitmap,
+                           Error **errp)
+{
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    client->bs =3D bs;
+    qemu_co_mutex_init(&client->send_mutex);
+    qemu_co_queue_init(&client->free_sema);
+
+    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                              x_dirty_bitmap, errp);
+}
+
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
     URI *uri;
@@ -289,12 +1527,6 @@ done:
     return saddr;
 }

-NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
-{
-    BDRVNBDState *s =3D bs->opaque;
-    return &s->client;
-}
-
 static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 {
     Object *obj;
@@ -483,17 +1715,6 @@ static int64_t nbd_getlength(BlockDriverState *bs)
     return s->client.info.size;
 }

-static void nbd_detach_aio_context(BlockDriverState *bs)
-{
-    nbd_client_detach_aio_context(bs);
-}
-
-static void nbd_attach_aio_context(BlockDriverState *bs,
-                                   AioContext *new_context)
-{
-    nbd_client_attach_aio_context(bs, new_context);
-}
-
 static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D bs->opaque;
@@ -559,8 +1780,8 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
-    .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
-    .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
+    .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
+    .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
@@ -581,8 +1802,8 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
-    .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
-    .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
+    .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
+    .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
@@ -603,8 +1824,8 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
-    .bdrv_detach_aio_context    =3D nbd_detach_aio_context,
-    .bdrv_attach_aio_context    =3D nbd_attach_aio_context,
+    .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
+    .bdrv_attach_aio_context    =3D nbd_client_attach_aio_context,
     .bdrv_refresh_filename      =3D nbd_refresh_filename,
     .bdrv_co_block_status       =3D nbd_client_co_block_status,
     .bdrv_dirname               =3D nbd_dirname,
diff --git a/block/Makefile.objs b/block/Makefile.objs
index ae11605c9f23..dbd15227221c 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -22,7 +22,7 @@ block-obj-y +=3D null.o mirror.o commit.o io.o create.o
 block-obj-y +=3D throttle-groups.o
 block-obj-$(CONFIG_LINUX) +=3D nvme.o

-block-obj-y +=3D nbd.o nbd-client.o
+block-obj-y +=3D nbd.o
 block-obj-$(CONFIG_SHEEPDOG) +=3D sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) +=3D iscsi.o
 block-obj-$(if $(CONFIG_LIBISCSI),y,n) +=3D iscsi-opts.o
diff --git a/block/trace-events b/block/trace-events
index 01fa5eb081be..f6e43ee0231a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -160,7 +160,7 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, int=
 pages) "s %p iov[%d] %p pa
 # iscsi.c
 iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst=
_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p of=
fset %"PRIu64" bytes %"PRIu64" ret %d"

-# nbd-client.c
+# nbd.c
 nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data f=
rom non-compliant server: %s"
 nbd_structured_read_compliance(const char *type) "server sent non-compli=
ant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret =3D %d, err: %s=
"
--=20
2.20.1


