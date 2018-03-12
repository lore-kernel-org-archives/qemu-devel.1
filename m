Received: from eggs.gnu.org ([2001:4830:134:3::10]:52202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGY-0000sS-Bu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evPGV-0006d7-39
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:21:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 12 Mar 2018 18:21:23 +0300
Message-Id: <20180312152126.286890-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180312152126.286890-1-vsementsov@virtuozzo.com>
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/8] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimal realization: only one extent in server answer is supported.
Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: - drop iotests changes, as server is fixed in 03
    - rebase to byte-based block status
    - use payload_advance32
    - check extent->length for zero and for alignment (not sure about
      zero, but, we do not send block status with zero-length, so
      reply should not be zero-length too)
    - handle max_block in nbd_client_co_block_status
    - handle zero-length request in nbd_client_co_block_status
    - do not use magic numbers in nbd_negotiate_simple_meta_context

    ? Hm, don't remember, what we decided about DATA/HOLE flags mapping..

 block/nbd-client.h  |   6 +++
 include/block/nbd.h |   3 ++
 block/nbd-client.c  | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/nbd.c         |   3 ++
 nbd/client.c        | 117 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 612c4c21a0..0ece76e5af 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -61,4 +61,10 @@ void nbd_client_detach_aio_context(BlockDriverState *bs);
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context);
 
+int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
+                                            bool want_zero,
+                                            int64_t offset, int64_t bytes,
+                                            int64_t *pnum, int64_t *map,
+                                            BlockDriverState **file);
+
 #endif /* NBD_CLIENT_H */
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 9f2be18186..3b34233dd4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -262,6 +262,7 @@ struct NBDExportInfo {
     /* In-out fields, set by client before nbd_receive_negotiate() and
      * updated by server results during nbd_receive_negotiate() */
     bool structured_reply;
+    bool base_allocation; /* base:allocation context for NBD_CMD_BLOCK_STATUS */
 
     /* Set by server results during nbd_receive_negotiate() */
     uint64_t size;
@@ -269,6 +270,8 @@ struct NBDExportInfo {
     uint32_t min_block;
     uint32_t opt_block;
     uint32_t max_block;
+
+    uint32_t meta_base_allocation_id;
 };
 typedef struct NBDExportInfo NBDExportInfo;
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 0d9f73a137..b7683707b0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -228,6 +228,47 @@ static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
     return 0;
 }
 
+/* nbd_parse_blockstatus_payload
+ * support only one extent in reply and only for
+ * base:allocation context
+ */
+static int nbd_parse_blockstatus_payload(NBDClientSession *client,
+                                         NBDStructuredReplyChunk *chunk,
+                                         uint8_t *payload, uint64_t orig_length,
+                                         NBDExtent *extent, Error **errp)
+{
+    uint32_t context_id;
+
+    if (chunk->length != sizeof(context_id) + sizeof(extent)) {
+        error_setg(errp, "Protocol error: invalid payload for "
+                         "NBD_REPLY_TYPE_BLOCK_STATUS");
+        return -EINVAL;
+    }
+
+    context_id = payload_advance32(&payload);
+    if (client->info.meta_base_allocation_id != context_id) {
+        error_setg(errp, "Protocol error: unexpected context id: %d for "
+                         "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
+                         "id is %d", context_id,
+                         client->info.meta_base_allocation_id);
+        return -EINVAL;
+    }
+
+    extent->length = payload_advance32(&payload);
+    extent->flags = payload_advance32(&payload);
+
+    if (extent->length == 0 ||
+        extent->length % client->info.min_block != 0 ||
+        extent->length > orig_length)
+    {
+        /* TODO: clarify in NBD spec the second requirement about min_block */
+        error_setg(errp, "Protocol error: server sent chunk of invalid length");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 /* nbd_parse_error_payload
  * on success @errp contains message describing nbd error reply
  */
@@ -642,6 +683,61 @@ static int nbd_co_receive_cmdread_reply(NBDClientSession *s, uint64_t handle,
     return iter.ret;
 }
 
+static int nbd_co_receive_blockstatus_reply(NBDClientSession *s,
+                                            uint64_t handle, uint64_t length,
+                                            NBDExtent *extent, Error **errp)
+{
+    NBDReplyChunkIter iter;
+    NBDReply reply;
+    void *payload = NULL;
+    Error *local_err = NULL;
+    bool received = false;
+
+    NBD_FOREACH_REPLY_CHUNK(s, iter, handle, s->info.structured_reply,
+                            NULL, &reply, &payload)
+    {
+        int ret;
+        NBDStructuredReplyChunk *chunk = &reply.structured;
+
+        assert(nbd_reply_is_structured(&reply));
+
+        switch (chunk->type) {
+        case NBD_REPLY_TYPE_BLOCK_STATUS:
+            if (received) {
+                s->quit = true;
+                error_setg(&local_err, "Several BLOCK_STATUS chunks in reply");
+                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+            }
+            received = true;
+
+            ret = nbd_parse_blockstatus_payload(s, &reply.structured,
+                                                payload, length, extent,
+                                                &local_err);
+            if (ret < 0) {
+                s->quit = true;
+                nbd_iter_error(&iter, true, ret, &local_err);
+            }
+            break;
+        default:
+            if (!nbd_reply_type_is_error(chunk->type)) {
+                /* not allowed reply type */
+                s->quit = true;
+                error_setg(&local_err,
+                           "Unexpected reply type: %d (%s) "
+                           "for CMD_BLOCK_STATUS",
+                           chunk->type, nbd_reply_type_lookup(chunk->type));
+                nbd_iter_error(&iter, true, -EINVAL, &local_err);
+            }
+        }
+
+        g_free(payload);
+        payload = NULL;
+    }
+
+    error_propagate(errp, iter.err);
+    return iter.ret;
+}
+
 static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
                           QEMUIOVector *write_qiov)
 {
@@ -784,6 +880,53 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     return nbd_co_request(bs, &request, NULL);
 }
 
+int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
+                                            bool want_zero,
+                                            int64_t offset, int64_t bytes,
+                                            int64_t *pnum, int64_t *map,
+                                            BlockDriverState **file)
+{
+    int64_t ret;
+    NBDExtent extent;
+    NBDClientSession *client = nbd_get_client_session(bs);
+    Error *local_err = NULL;
+
+    NBDRequest request = {
+        .type = NBD_CMD_BLOCK_STATUS,
+        .from = offset,
+        .len = MIN(bytes, MIN_NON_ZERO(INT_MAX, client->info.max_block)),
+        .flags = NBD_CMD_FLAG_REQ_ONE,
+    };
+
+    if (!bytes) {
+        *pnum = 0;
+        return 0;
+    }
+
+    if (!client->info.base_allocation) {
+        *pnum = bytes;
+        return BDRV_BLOCK_DATA;
+    }
+
+    ret = nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
+                                           &extent, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+    if (ret < 0) {
+        return ret;
+    }
+
+    *pnum = extent.length;
+    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
+           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
+}
+
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -828,6 +971,7 @@ int nbd_client_init(BlockDriverState *bs,
 
     client->info.request_sizes = true;
     client->info.structured_reply = true;
+    client->info.base_allocation = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
diff --git a/block/nbd.c b/block/nbd.c
index d4e4172c08..1e2b3ba2d3 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -585,6 +585,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_co_block_status       = nbd_client_co_block_status,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -604,6 +605,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_co_block_status       = nbd_client_co_block_status,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -623,6 +625,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_co_block_status       = nbd_client_co_block_status,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/nbd/client.c b/nbd/client.c
index dcad23a053..daf1ae2af5 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -595,6 +595,111 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }
 
+/* nbd_negotiate_simple_meta_context:
+ * Set one meta context. Simple means that reply must contain zero (not
+ * negotiated) or one (negotiated) contexts. More contexts would be considered
+ * as a protocol error. It's also implied, that meta-data query equals queried
+ * context name, so, if server replies with something different then @context,
+ * it considered as error too.
+ * return 1 for successful negotiation, context_id is set
+ *        0 if operation is unsupported,
+ *        -errno with errp set for any other error
+ */
+static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
+                                             const char *export,
+                                             const char *context,
+                                             uint32_t *context_id,
+                                             Error **errp)
+{
+    int ret;
+    NBDOptionReply reply;
+    uint32_t received_id;
+    bool received;
+    uint32_t export_len = strlen(export);
+    uint32_t context_len = strlen(context);
+    uint32_t data_len = sizeof(export_len) + export_len +
+                        sizeof(uint32_t) + /* number of queries */
+                        sizeof(context_len) + context_len;
+    char *data = g_malloc(data_len);
+    char *p = data;
+
+    stl_be_p(p, export_len);
+    memcpy(p += sizeof(export_len), export, export_len);
+    stl_be_p(p += export_len, 1);
+    stl_be_p(p += sizeof(uint32_t), context_len);
+    memcpy(p += sizeof(context_len), context, context_len);
+
+    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
+                                  errp);
+    g_free(data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
+                                 errp) < 0)
+    {
+        return -1;
+    }
+
+    ret = nbd_handle_reply_err(ioc, &reply, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    if (reply.type == NBD_REP_META_CONTEXT) {
+        char *name;
+        size_t len;
+
+        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
+            return -EIO;
+        }
+        be32_to_cpus(&received_id);
+
+        len = reply.length - sizeof(received_id);
+        name = g_malloc(len + 1);
+        if (nbd_read(ioc, name, len, errp) < 0) {
+            g_free(name);
+            return -EIO;
+        }
+        name[len] = '\0';
+        if (strcmp(context, name)) {
+            error_setg(errp, "Failed to negotiate meta context '%s', server "
+                       "answered with different context '%s'", context,
+                       name);
+            g_free(name);
+            return -1;
+        }
+        g_free(name);
+
+        received = true;
+
+        /* receive NBD_REP_ACK */
+        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
+                                     errp) < 0)
+        {
+            return -1;
+        }
+
+        ret = nbd_handle_reply_err(ioc, &reply, errp);
+        if (ret <= 0) {
+            return ret;
+        }
+    }
+
+    if (reply.type != NBD_REP_ACK) {
+        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
+                   reply.type, NBD_REP_ACK);
+        return -1;
+    }
+
+    if (received) {
+        *context_id = received_id;
+        return 1;
+    }
+
+    return 0;
+}
 
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
@@ -606,10 +711,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
     int rc;
     bool zeroes = true;
     bool structured_reply = info->structured_reply;
+    bool base_allocation = info->base_allocation;
 
     trace_nbd_receive_negotiate(tlscreds, hostname ? hostname : "<null>");
 
     info->structured_reply = false;
+    info->base_allocation = false;
     rc = -EINVAL;
 
     if (outioc) {
@@ -700,6 +807,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                 info->structured_reply = result == 1;
             }
 
+            if (info->structured_reply && base_allocation) {
+                result = nbd_negotiate_simple_meta_context(
+                        ioc, name, "base:allocation",
+                        &info->meta_base_allocation_id, errp);
+                if (result < 0) {
+                    goto fail;
+                }
+                info->base_allocation = result == 1;
+            }
+
             /* Try NBD_OPT_GO first - if it works, we are done (it
              * also gives us a good message if the server requires
              * TLS).  If it is not available, fall back to
-- 
2.11.1
