Received: from eggs.gnu.org ([2001:4830:134:3::10]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007na-Bo
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5k-00083J-52
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37573 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-00080O-Kz
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:04 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:50 +0300
Message-Id: <20170203154757.36140-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/18] nbd: BLOCK_STATUS for bitmap export:
 server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Only one meta context type is defined: qemu-bitmap:<bitmap-name>.
Maximum one query is allowed for NBD_OPT_{SET,LIST}_META_CONTEXT,
NBD_REP_ERR_TOO_BIG is returned otherwise.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  15 ++
 nbd/nbd-internal.h  |   6 +
 nbd/server.c        | 445 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index dae2e4bd03..516a24765c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -94,6 +94,16 @@ typedef struct NBDStructuredError {
     uint16_t message_length;
 } QEMU_PACKED NBDStructuredError;
 
+typedef struct NBDStructuredMeta {
+    NBDStructuredReplyChunk h;
+    uint32_t context_id;
+} QEMU_PACKED NBDStructuredMeta;
+
+typedef struct NBDExtent {
+    uint32_t length;
+    uint32_t flags;
+} QEMU_PACKED NBDExtent;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS      (1 << 0)        /* Flags are there */
@@ -120,6 +130,7 @@ typedef struct NBDStructuredError {
 
 #define NBD_REP_ACK             (1)             /* Data sending finished. */
 #define NBD_REP_SERVER          (2)             /* Export description. */
+#define NBD_REP_META_CONTEXT    (4)
 
 #define NBD_REP_ERR_UNSUP       NBD_REP_ERR(1)  /* Unknown option */
 #define NBD_REP_ERR_POLICY      NBD_REP_ERR(2)  /* Server denied */
@@ -127,6 +138,8 @@ typedef struct NBDStructuredError {
 #define NBD_REP_ERR_PLATFORM    NBD_REP_ERR(4)  /* Not compiled in */
 #define NBD_REP_ERR_TLS_REQD    NBD_REP_ERR(5)  /* TLS required */
 #define NBD_REP_ERR_SHUTDOWN    NBD_REP_ERR(7)  /* Server shutting down */
+#define NBD_REP_ERR_TOO_BIG     NBD_REP_ERR(9)  /* The request or the reply is
+                                                   too large to process */
 
 /* Request flags, sent from client to server during transmission phase */
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
@@ -142,6 +155,7 @@ enum {
     NBD_CMD_TRIM = 4,
     /* 5 reserved for failed experiment NBD_CMD_CACHE */
     NBD_CMD_WRITE_ZEROES = 6,
+    NBD_CMD_BLOCK_STATUS = 7
 };
 
 #define NBD_DEFAULT_PORT	10809
@@ -163,6 +177,7 @@ enum {
 #define NBD_REPLY_TYPE_NONE 0
 #define NBD_REPLY_TYPE_OFFSET_DATA 1
 #define NBD_REPLY_TYPE_OFFSET_HOLE 2
+#define NBD_REPLY_TYPE_BLOCK_STATUS 5
 #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
 
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 3284bfc85a..fbbcf69925 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -83,6 +83,10 @@
 #define NBD_OPT_PEEK_EXPORT     (4)
 #define NBD_OPT_STARTTLS        (5)
 #define NBD_OPT_STRUCTURED_REPLY (8)
+#define NBD_OPT_LIST_META_CONTEXT (9)
+#define NBD_OPT_SET_META_CONTEXT  (10)
+
+#define NBD_META_NS_BITMAPS "qemu-dirty-bitmap"
 
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
  * but only a limited set of errno values is specified in the protocol.
@@ -105,6 +109,8 @@ static inline const char *nbd_opt_name(int opt)
     case NBD_OPT_PEEK_EXPORT: return "peek_export";
     case NBD_OPT_STARTTLS: return "tls";
     case NBD_OPT_STRUCTURED_REPLY: return "structured_reply";
+    case NBD_OPT_LIST_META_CONTEXT: return "list_meta_context";
+    case NBD_OPT_SET_META_CONTEXT: return "set_meta_context";
     }
 
     return "<unknown option>";
diff --git a/nbd/server.c b/nbd/server.c
index cb79a93c87..0b7b7230df 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -21,6 +21,8 @@
 #include "qapi/error.h"
 #include "nbd-internal.h"
 
+#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
+
 static int system_errno_to_nbd_errno(int err)
 {
     switch (err) {
@@ -102,6 +104,7 @@ struct NBDClient {
     bool closing;
 
     bool structured_reply;
+    BdrvDirtyBitmap *export_bitmap;
 };
 
 /* That's all folks */
@@ -421,7 +424,304 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }
 
+static int nbd_negotiate_read_size_string(QIOChannel *ioc, char **str,
+                                          uint32_t max_len)
+{
+    uint32_t len;
+
+    if (nbd_negotiate_read(ioc, &len, sizeof(len)) != sizeof(len)) {
+        LOG("read failed");
+        return -EIO;
+    }
+
+    cpu_to_be32s(&len);
+
+    if (max_len > 0 && len > max_len) {
+        LOG("Bad length received");
+        return -EINVAL;
+    }
+
+    *str = g_malloc(len + 1);
+
+    if (nbd_negotiate_read(ioc, *str, len) != len) {
+        LOG("read failed");
+        g_free(str);
+        return -EIO;
+    }
+    (*str)[len] = '\0';
+
+    return sizeof(len) + len;
+}
+
+static int nbd_negotiate_send_meta_context(QIOChannel *ioc,
+                                           const char *context,
+                                           uint32_t opt)
+{
+    int ret;
+    size_t len = strlen(context);
+    uint32_t context_id = cpu_to_be32(100);
+
+    ret = nbd_negotiate_send_rep_len(ioc, NBD_REP_META_CONTEXT, opt,
+                                     len + sizeof(context_id));
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (nbd_negotiate_write(ioc, &context_id, sizeof(context_id)) !=
+        sizeof(context_id))
+    {
+        LOG("write failed");
+        return -EIO;
+    }
+
+    if (nbd_negotiate_write(ioc, context, len) != len) {
+        LOG("write failed");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int nbd_negotiate_send_bitmap(QIOChannel *ioc, const char *bitmap_name,
+                                     uint32_t opt)
+{
+    char *context = g_strdup_printf("%s:%s", NBD_META_NS_BITMAPS, bitmap_name);
+    int ret = nbd_negotiate_send_meta_context(ioc, context, opt);
+
+    g_free(context);
+
+    return ret;
+}
+
+static int nbd_negotiate_one_bitmap_query(QIOChannel *ioc, BlockDriverState *bs,
+                                          uint32_t opt, const char *query,
+                                          BdrvDirtyBitmap **bitmap)
+{
+    BdrvDirtyBitmap *bm = bdrv_find_dirty_bitmap(bs, query);
+    if (bm != NULL) {
+        if (bitmap != NULL) {
+            *bitmap = bm;
+        }
+        return nbd_negotiate_send_bitmap(ioc, query, opt);
+    }
+
+    return 0;
+}
+
+static int nbd_negotiate_one_meta_query(QIOChannel *ioc, BlockDriverState *bs,
+                                        uint32_t opt, BdrvDirtyBitmap **bitmap)
+{
+    int ret = 0, nb_read;
+    char *query, *colon, *namespace, *subquery;
+
+    *bitmap = NULL;
 
+    nb_read = nbd_negotiate_read_size_string(ioc, &query, 0);
+    if (nb_read < 0) {
+        return nb_read;
+    }
+
+    colon = strchr(query, ':');
+    if (colon == NULL) {
+        ret = -EINVAL;
+        goto out;
+    }
+    *colon = '\0';
+    namespace = query;
+    subquery = colon + 1;
+
+    if (strcmp(namespace, NBD_META_NS_BITMAPS) == 0) {
+        ret = nbd_negotiate_one_bitmap_query(ioc, bs, opt, subquery, bitmap);
+    }
+
+out:
+    g_free(query);
+    return ret < 0 ? ret : nb_read;
+}
+
+/* start handle LIST_META_CONTEXT and SET_META_CONTEXT requests
+ * @opt          should be NBD_OPT_LIST_META_CONTEXT or NBD_OPT_SET_META_CONTEXT
+ * @length       related option data to read
+ * @nb_queries   out parameter, number of queries specified by client
+ * @bs           out parameter, bs for export, selected by client
+ *               will be zero if some not critical error occured and error reply
+ *               was sent.
+ *
+ * Returns:
+ *   Err. code < 0 on critical error
+ *   Number of bytes read otherwise (will be equal to length on non critical
+ *     error or if there no queries in request)
+ */
+static int nbd_negotiate_opt_meta_context_start(NBDClient *client, uint32_t opt,
+                                                uint32_t length,
+                                                uint32_t *nb_queries,
+                                                BlockDriverState **bs)
+{
+    int ret;
+    NBDExport *exp;
+    char *export_name;
+    int nb_read = 0;
+
+    if (!client->structured_reply) {
+        uint32_t tail = length - nb_read;
+        LOG("Structured reply is not negotiated");
+
+        if (nbd_negotiate_drop_sync(client->ioc, tail) != tail) {
+            return -EIO;
+        }
+        ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
+                                         "Structured reply is not negotiated");
+        g_free(export_name);
+
+        if (ret < 0) {
+            return ret;
+        } else {
+            *bs = NULL;
+            *nb_queries = 0;
+            return length;
+        }
+    }
+
+    nb_read = nbd_negotiate_read_size_string(client->ioc, &export_name,
+                                             NBD_MAX_NAME_SIZE);
+    if (nb_read < 0) {
+        return nb_read;
+    }
+
+    exp = nbd_export_find(export_name);
+    if (exp == NULL) {
+        uint32_t tail = length - nb_read;
+        LOG("export '%s' is not found", export_name);
+
+        if (nbd_negotiate_drop_sync(client->ioc, tail) != tail) {
+            return -EIO;
+        }
+        ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
+                                         "export '%s' is not found",
+                                         export_name);
+        g_free(export_name);
+
+        if (ret < 0) {
+            return ret;
+        } else {
+            *bs = NULL;
+            *nb_queries = 0;
+            return length;
+        }
+    }
+    g_free(export_name);
+
+    *bs = blk_bs(exp->blk);
+    if (*bs == NULL) {
+        LOG("export without bs");
+        return -EINVAL;
+    }
+
+    if (nbd_negotiate_read(client->ioc, nb_queries,
+                           sizeof(*nb_queries)) != sizeof(*nb_queries))
+    {
+        LOG("read failed");
+        return -EIO;
+    }
+    cpu_to_be32s(nb_queries);
+
+    nb_read += sizeof(*nb_queries);
+
+    return nb_read;
+}
+
+static int nbd_negotiate_list_meta_context(NBDClient *client, uint32_t length)
+{
+    int ret;
+    BlockDriverState *bs;
+    uint32_t nb_queries;
+    int i;
+    int nb_read;
+
+    nb_read = nbd_negotiate_opt_meta_context_start(client,
+                                                   NBD_OPT_LIST_META_CONTEXT,
+                                                   length, &nb_queries, &bs);
+    if (nb_read < 0) {
+        return nb_read;
+    }
+    if (bs == NULL) {
+        /* error reply was already sent by nbd_negotiate_opt_meta_context_start
+         * */
+        return 0;
+    }
+
+    if (nb_queries == 0) {
+        BdrvDirtyBitmap *bm = NULL;
+
+        if (nb_read != length) {
+            return -EINVAL;
+        }
+
+        while ((bm = bdrv_dirty_bitmap_next(bs, bm)) != 0) {
+            nbd_negotiate_send_bitmap(client->ioc, bdrv_dirty_bitmap_name(bm),
+                                      NBD_OPT_LIST_META_CONTEXT);
+        }
+    }
+
+    for (i = 0; i < nb_queries; ++i) {
+        ret = nbd_negotiate_one_meta_query(client->ioc, bs,
+                                           NBD_OPT_LIST_META_CONTEXT, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+
+        nb_read += ret;
+    }
+
+    if (nb_read != length) {
+        return -EINVAL;
+    }
+
+    return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                  NBD_OPT_LIST_META_CONTEXT);
+}
+
+static int nbd_negotiate_set_meta_context(NBDClient *client, uint32_t length)
+{
+    int ret;
+    BlockDriverState *bs;
+    uint32_t nb_queries;
+    int nb_read;
+
+    nb_read = nbd_negotiate_opt_meta_context_start(client,
+                                                   NBD_OPT_SET_META_CONTEXT,
+                                                   length, &nb_queries, &bs);
+    if (nb_read < 0) {
+        return nb_read;
+    }
+    if (bs == NULL) {
+        /* error reply was already sent by nbd_negotiate_opt_meta_context_start
+         * */
+        return 0;
+    }
+
+    if (nb_queries == 0) {
+        return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                      NBD_OPT_SET_META_CONTEXT);
+    }
+
+    if (nb_queries > 1) {
+        return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_TOO_BIG,
+                                          NBD_OPT_SET_META_CONTEXT,
+                                          "Only one exporting context is"
+                                          "supported");
+    }
+
+    ret = nbd_negotiate_one_meta_query(client->ioc, bs,
+                                       NBD_OPT_SET_META_CONTEXT,
+                                       &client->export_bitmap);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
+                                  NBD_OPT_SET_META_CONTEXT);
+}
 /* Process all NBD_OPT_* client option commands.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_options(NBDClient *client)
@@ -585,6 +885,20 @@ static int nbd_negotiate_options(NBDClient *client)
                 }
                 break;
 
+            case NBD_OPT_LIST_META_CONTEXT:
+                ret = nbd_negotiate_list_meta_context(client, length);
+                if (ret < 0) {
+                    return ret;
+                }
+                break;
+
+            case NBD_OPT_SET_META_CONTEXT:
+                ret = nbd_negotiate_set_meta_context(client, length);
+                if (ret < 0) {
+                    return ret;
+                }
+                break;
+
             default:
                 if (nbd_negotiate_drop_sync(client->ioc, length) != length) {
                     return -EIO;
@@ -1159,6 +1473,124 @@ static int nbd_co_send_structured_none(NBDClient *client, uint64_t handle)
     return nbd_co_send_buf(client, &chunk, sizeof(chunk));
 }
 
+#define MAX_EXTENT_LENGTH UINT32_MAX
+
+static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
+                            uint64_t length, uint32_t flags)
+{
+    unsigned i = 0;
+    uint32_t big_chunk = (MAX_EXTENT_LENGTH >> 9) << 9;
+    uint32_t big_chunk_be = cpu_to_be32(big_chunk);
+    uint32_t flags_be = cpu_to_be32(flags);
+
+    for (i = 0; i < nb_extents && length > MAX_EXTENT_LENGTH;
+         i++, length -= big_chunk)
+    {
+        extents[i].length = big_chunk_be;
+        extents[i].flags = flags_be;
+    }
+
+    if (length > 0 && i < nb_extents) {
+        extents[i].length = cpu_to_be32(length);
+        extents[i].flags = flags_be;
+        i++;
+    }
+
+    return i;
+}
+
+static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
+                                  uint64_t length, NBDExtent *extents,
+                                  unsigned nb_extents)
+{
+    uint64_t begin, end; /* dirty region */
+    uint64_t start_sector = offset >> BDRV_SECTOR_BITS;
+    uint64_t last_sector = (offset + length - 1) >> BDRV_SECTOR_BITS;
+    unsigned i = 0;
+    uint64_t len;
+    uint32_t ma = -1;
+    ma = (ma / bdrv_dirty_bitmap_granularity(bitmap)) *
+        bdrv_dirty_bitmap_granularity(bitmap);
+
+    BdrvDirtyBitmapIter *it = bdrv_dirty_iter_new(bitmap, start_sector);
+
+    assert(nb_extents > 0);
+
+    begin = bdrv_dirty_iter_next(it);
+    if (begin == -1) {
+        begin = last_sector + 1;
+    }
+    if (begin > start_sector) {
+        len = (begin - start_sector) << BDRV_SECTOR_BITS;
+        i += add_extents(extents + i, nb_extents - i, len, 0);
+    }
+
+    while (begin != -1 && begin <= last_sector && i < nb_extents) {
+        end = bdrv_dirty_bitmap_next_zero(bitmap, begin + 1);
+
+        i += add_extents(extents + i, nb_extents - i,
+                         (end - begin) << BDRV_SECTOR_BITS, 1);
+
+        if (end > last_sector || i >= nb_extents) {
+            break;
+        }
+
+        bdrv_set_dirty_iter(it, end);
+        begin = bdrv_dirty_iter_next(it);
+        if (begin == -1) {
+            begin = last_sector + 1;
+        }
+        if (begin > end) {
+            i += add_extents(extents + i, nb_extents - i,
+                             (begin - end) << BDRV_SECTOR_BITS, 0);
+        }
+    }
+
+    bdrv_dirty_iter_free(it);
+
+    extents[0].length =
+        cpu_to_be32(be32_to_cpu(extents[0].length) -
+                    (offset - (start_sector << BDRV_SECTOR_BITS)));
+
+    return i;
+}
+
+static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
+                               NBDExtent *extents, unsigned nb_extents,
+                               uint32_t context_id)
+{
+    NBDStructuredMeta chunk;
+
+    struct iovec iov[] = {
+        {.iov_base = &chunk, .iov_len = sizeof(chunk)},
+        {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
+    };
+
+    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_BLOCK_STATUS,
+                 handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
+    stl_be_p(&chunk.context_id, context_id);
+
+    return nbd_co_send_iov(client, iov, 2);
+}
+
+static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
+                              BdrvDirtyBitmap *bitmap, uint64_t offset,
+                              uint64_t length, uint32_t context_id)
+{
+    int ret;
+    unsigned nb_extents;
+    NBDExtent *extents = g_new(NBDExtent, NBD_MAX_BITMAP_EXTENTS);
+
+    nb_extents = bitmap_to_extents(bitmap, offset, length, extents,
+                                   NBD_MAX_BITMAP_EXTENTS);
+
+    ret = nbd_co_send_extents(client, handle, extents, nb_extents, context_id);
+
+    g_free(extents);
+
+    return ret;
+}
+
 /* Collect a client request.  Return 0 if request looks valid, -EAGAIN
  * to keep trying the collection, -EIO to drop connection right away,
  * and any other negative value to report an error to the client
@@ -1437,6 +1869,19 @@ static void nbd_trip(void *opaque)
             goto out;
         }
         break;
+    case NBD_CMD_BLOCK_STATUS:
+        TRACE("Request type is BLOCK_STATUS");
+        if (client->export_bitmap == NULL) {
+            reply.error = EINVAL;
+            goto error_reply;
+        }
+        ret = nbd_co_send_bitmap(req->client, request.handle,
+                                 client->export_bitmap, request.from,
+                                 request.len, 0);
+        if (ret < 0) {
+            goto out;
+        }
+        break;
     default:
         LOG("invalid request type (%" PRIu32 ") received", request.type);
         reply.error = EINVAL;
-- 
2.11.0
