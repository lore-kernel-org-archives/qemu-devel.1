Received: from eggs.gnu.org ([2001:4830:134:3::10]:51121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxU-0001pp-BD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxP-0000yO-Jj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:20 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:41 +0300
Message-Id: <1518702707-7077-4-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/9] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  33 ++++++
 nbd/common.c        |  10 ++
 nbd/server.c        | 310 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 352 insertions(+), 1 deletion(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index ef1698914b..b16215d17a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -41,6 +41,12 @@ struct NBDOptionReply {
 } QEMU_PACKED;
 typedef struct NBDOptionReply NBDOptionReply;
 
+typedef struct NBDOptionReplyMetaContext {
+    NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 4 */
+    uint32_t context_id;
+    /* meta context name follows */
+} QEMU_PACKED NBDOptionReplyMetaContext;
+
 /* Transmission phase structs
  *
  * Note: these are _NOT_ the same as the network representation of an NBD
@@ -105,6 +111,19 @@ typedef struct NBDStructuredError {
     uint16_t message_length;
 } QEMU_PACKED NBDStructuredError;
 
+/* Header of NBD_REPLY_TYPE_BLOCK_STATUS */
+typedef struct NBDStructuredMeta {
+    NBDStructuredReplyChunk h; /* h.length >= 12 (at least one extent) */
+    uint32_t context_id;
+    /* extents follows */
+} QEMU_PACKED NBDStructuredMeta;
+
+/* Extent chunk for NBD_REPLY_TYPE_BLOCK_STATUS */
+typedef struct NBDExtent {
+    uint32_t length;
+    uint32_t flags; /* NBD_STATE_* */
+} QEMU_PACKED NBDExtent;
+
 /* Transmission (export) flags: sent from server to client during handshake,
    but describe what will happen during transmission */
 #define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
@@ -136,6 +155,8 @@ typedef struct NBDStructuredError {
 #define NBD_OPT_INFO              (6)
 #define NBD_OPT_GO                (7)
 #define NBD_OPT_STRUCTURED_REPLY  (8)
+#define NBD_OPT_LIST_META_CONTEXT (9)
+#define NBD_OPT_SET_META_CONTEXT  (10)
 
 /* Option reply types. */
 #define NBD_REP_ERR(value) ((UINT32_C(1) << 31) | (value))
@@ -143,6 +164,7 @@ typedef struct NBDStructuredError {
 #define NBD_REP_ACK             (1)    /* Data sending finished. */
 #define NBD_REP_SERVER          (2)    /* Export description. */
 #define NBD_REP_INFO            (3)    /* NBD_OPT_INFO/GO. */
+#define NBD_REP_META_CONTEXT    (4)    /* NBD_OPT_{LIST,SET}_META_CONTEXT */
 
 #define NBD_REP_ERR_UNSUP           NBD_REP_ERR(1)  /* Unknown option */
 #define NBD_REP_ERR_POLICY          NBD_REP_ERR(2)  /* Server denied */
@@ -163,6 +185,10 @@ typedef struct NBDStructuredError {
 #define NBD_CMD_FLAG_FUA        (1 << 0) /* 'force unit access' during write */
 #define NBD_CMD_FLAG_NO_HOLE    (1 << 1) /* don't punch hole on zero run */
 #define NBD_CMD_FLAG_DF         (1 << 2) /* don't fragment structured read */
+#define NBD_CMD_FLAG_REQ_ONE    (1 << 3) /* only one extent in BLOCK_STATUS
+                                          * reply chunk */
+
+#define NBD_META_ID_BASE_ALLOCATION 0
 
 /* Supported request types */
 enum {
@@ -173,6 +199,7 @@ enum {
     NBD_CMD_TRIM = 4,
     /* 5 reserved for failed experiment NBD_CMD_CACHE */
     NBD_CMD_WRITE_ZEROES = 6,
+    NBD_CMD_BLOCK_STATUS = 7,
 };
 
 #define NBD_DEFAULT_PORT	10809
@@ -200,9 +227,15 @@ enum {
 #define NBD_REPLY_TYPE_NONE          0
 #define NBD_REPLY_TYPE_OFFSET_DATA   1
 #define NBD_REPLY_TYPE_OFFSET_HOLE   2
+#define NBD_REPLY_TYPE_BLOCK_STATUS  5
 #define NBD_REPLY_TYPE_ERROR         NBD_REPLY_ERR(1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET  NBD_REPLY_ERR(2)
 
+/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
+ * for base:allocation meta context */
+#define NBD_STATE_HOLE (1 << 0)
+#define NBD_STATE_ZERO (1 << 1)
+
 static inline bool nbd_reply_type_is_error(int type)
 {
     return type & (1 << 15);
diff --git a/nbd/common.c b/nbd/common.c
index 6295526dd1..8c95c1d606 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -75,6 +75,10 @@ const char *nbd_opt_lookup(uint32_t opt)
         return "go";
     case NBD_OPT_STRUCTURED_REPLY:
         return "structured reply";
+    case NBD_OPT_LIST_META_CONTEXT:
+        return "list meta context";
+    case NBD_OPT_SET_META_CONTEXT:
+        return "set meta context";
     default:
         return "<unknown>";
     }
@@ -90,6 +94,8 @@ const char *nbd_rep_lookup(uint32_t rep)
         return "server";
     case NBD_REP_INFO:
         return "info";
+    case NBD_REP_META_CONTEXT:
+        return "meta context";
     case NBD_REP_ERR_UNSUP:
         return "unsupported";
     case NBD_REP_ERR_POLICY:
@@ -144,6 +150,8 @@ const char *nbd_cmd_lookup(uint16_t cmd)
         return "trim";
     case NBD_CMD_WRITE_ZEROES:
         return "write zeroes";
+    case NBD_CMD_BLOCK_STATUS:
+        return "block status";
     default:
         return "<unknown>";
     }
@@ -159,6 +167,8 @@ const char *nbd_reply_type_lookup(uint16_t type)
         return "data";
     case NBD_REPLY_TYPE_OFFSET_HOLE:
         return "hole";
+    case NBD_REPLY_TYPE_BLOCK_STATUS:
+        return "block status";
     case NBD_REPLY_TYPE_ERROR:
         return "generic error";
     case NBD_REPLY_TYPE_ERROR_OFFSET:
diff --git a/nbd/server.c b/nbd/server.c
index b9860a6dcf..f2a750eb97 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -82,6 +82,15 @@ struct NBDExport {
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
+/* NBDExportMetaContexts represents list of selected by
+ * NBD_OPT_SET_META_CONTEXT contexts to be exported. */
+typedef struct NBDExportMetaContexts {
+    char export_name[NBD_MAX_NAME_SIZE + 1];
+    bool valid; /* means that negotiation of the option finished without
+                   errors */
+    bool base_allocation; /* export base:allocation context (block status) */
+} NBDExportMetaContexts;
+
 struct NBDClient {
     int refcount;
     void (*close_fn)(NBDClient *client, bool negotiated);
@@ -102,6 +111,7 @@ struct NBDClient {
     bool closing;
 
     bool structured_reply;
+    NBDExportMetaContexts export_meta;
 
     uint32_t opt; /* Current option being negotiated */
     uint32_t optlen; /* remaining length of data in ioc for the option being
@@ -636,6 +646,201 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }
 
+/* nbd_alloc_read_size_string
+ *
+ * Read string in format
+ *   uint32_t len
+ *   len bytes string (not 0-terminated)
+ * String is allocated and pointer returned as @buf
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_alloc_read_size_string(NBDClient *client, char **buf,
+                                      Error **errp)
+{
+    int ret;
+    uint32_t len;
+
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&len);
+
+    *buf = g_try_malloc(len + 1);
+    if (*buf == NULL) {
+        error_setg(errp, "No memory");
+        return -ENOMEM;
+    }
+    (*buf)[len] = '\0';
+
+    ret = nbd_opt_read(client, *buf, len, errp);
+    if (ret <= 0) {
+        g_free(*buf);
+        *buf = NULL;
+    }
+
+    return ret;
+}
+
+/* nbd_read_size_string
+ *
+ * Read string in format
+ *   uint32_t len
+ *   len bytes string (not 0-terminated)
+ *
+ * @buf should be enough to store @max_len+1
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_read_size_string(NBDClient *client, char *buf,
+                                uint32_t max_len, Error **errp)
+{
+    int ret;
+    uint32_t len;
+
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&len);
+
+    if (len > max_len) {
+        return nbd_opt_invalid(client, errp, "Invalid string length: %u", len);
+    }
+
+    ret = nbd_opt_read(client, buf, len, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    buf[len] = '\0';
+
+    return 1;
+}
+
+static int nbd_negotiate_send_meta_context(NBDClient *client,
+                                           const char *context,
+                                           uint32_t context_id,
+                                           Error **errp)
+{
+    NBDOptionReplyMetaContext opt;
+    struct iovec iov[] = {
+        {.iov_base = &opt, .iov_len = sizeof(opt)},
+        {.iov_base = (void *)context, .iov_len = strlen(context)}
+    };
+
+    set_be_option_rep(&opt.h, client->opt, NBD_REP_META_CONTEXT,
+                      sizeof(opt) - sizeof(opt.h) + iov[1].iov_len);
+    stl_be_p(&opt.context_id, context_id);
+
+    return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
+}
+
+static void nbd_meta_base_query(NBDExportMetaContexts *meta, const char *query)
+{
+    if (query[0] == '\0' || strcmp(query, "allocation") == 0) {
+        /* Note: empty query should select all contexts within base
+         * namespace. */
+        meta->base_allocation = true;
+    }
+}
+
+/* nbd_negotiate_meta_query
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_negotiate_meta_query(NBDClient *client,
+                                    NBDExportMetaContexts *meta, Error **errp)
+{
+    int ret;
+    char *query, *colon, *namespace, *subquery;
+
+    ret = nbd_alloc_read_size_string(client, &query, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    colon = strchr(query, ':');
+    if (colon == NULL) {
+        ret = nbd_opt_invalid(client, errp, "no colon in query");
+        goto out;
+    }
+    *colon = '\0';
+    namespace = query;
+    subquery = colon + 1;
+
+    if (strcmp(namespace, "base") == 0) {
+        nbd_meta_base_query(meta, subquery);
+    }
+
+out:
+    g_free(query);
+    return ret;
+}
+
+/* nbd_negotiate_meta_queries
+ * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_negotiate_meta_queries(NBDClient *client,
+                                      NBDExportMetaContexts *meta, Error **errp)
+{
+    int ret;
+    NBDExport *exp;
+    NBDExportMetaContexts local_meta;
+    uint32_t nb_queries;
+    int i;
+
+    assert(client->structured_reply);
+
+    if (meta == NULL) {
+        meta = &local_meta;
+    }
+
+    memset(meta, 0, sizeof(*meta));
+
+    ret = nbd_read_size_string(client, meta->export_name,
+                               NBD_MAX_NAME_SIZE, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    exp = nbd_export_find(meta->export_name);
+    if (exp == NULL) {
+        return nbd_opt_invalid(client, errp,
+                               "export '%s' not present", meta->export_name);
+    }
+
+    ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&nb_queries);
+
+    for (i = 0; i < nb_queries; ++i) {
+        ret = nbd_negotiate_meta_query(client, meta, errp);
+        if (ret <= 0) {
+            return ret;
+        }
+    }
+
+    if (meta->base_allocation) {
+        ret = nbd_negotiate_send_meta_context(client, "base:allocation",
+                                              NBD_META_ID_BASE_ALLOCATION,
+                                              errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
+    if (ret == 0) {
+        meta->valid = true;
+    }
+
+    return ret;
+}
+
 /* nbd_negotiate_options
  * Process all NBD_OPT_* client option commands, during fixed newstyle
  * negotiation.
@@ -826,6 +1031,22 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 }
                 break;
 
+            case NBD_OPT_LIST_META_CONTEXT:
+            case NBD_OPT_SET_META_CONTEXT:
+                if (!client->structured_reply) {
+                    ret = nbd_opt_invalid(
+                            client, errp,
+                            "request option '%s' when structured reply "
+                            "is not negotiated", nbd_opt_lookup(option));
+                } else if (option == NBD_OPT_LIST_META_CONTEXT) {
+                    ret = nbd_negotiate_meta_queries(client, NULL, errp);
+                } else {
+                    ret = nbd_negotiate_meta_queries(client,
+                                                     &client->export_meta,
+                                                     errp);
+                }
+                break;
+
             default:
                 ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
                                    "Unsupported option 0x%" PRIx32 " (%s)",
@@ -1446,6 +1667,78 @@ static int coroutine_fn nbd_co_send_structured_error(NBDClient *client,
     return nbd_co_send_iov(client, iov, 1 + !!iov[1].iov_len, errp);
 }
 
+static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
+                                    uint64_t bytes, NBDExtent *extent)
+{
+    uint64_t tail_bytes = bytes;
+
+    while (tail_bytes) {
+        uint32_t flags;
+        int64_t num;
+        int ret = bdrv_block_status_above(bs, NULL, offset, tail_bytes, &num,
+                                          NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+
+        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
+                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
+
+        if (tail_bytes == bytes) {
+            extent->flags = flags;
+        }
+
+        if (flags != extent->flags) {
+            break;
+        }
+
+        offset += num;
+        tail_bytes -= num;
+    }
+
+    cpu_to_be32s(&extent->flags);
+    extent->length = cpu_to_be32(bytes - tail_bytes);
+
+    return 0;
+}
+
+/* nbd_co_send_extents
+ * @extents should be in big-endian */
+static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
+                               NBDExtent *extents, unsigned nb_extents,
+                               uint32_t context_id, Error **errp)
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
+    return nbd_co_send_iov(client, iov, 2, errp);
+}
+
+static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
+                                    BlockDriverState *bs, uint64_t offset,
+                                    uint64_t length, uint32_t context_id,
+                                    Error **errp)
+{
+    int ret;
+    NBDExtent extent;
+
+    ret = blockstatus_to_extent_be(bs, offset, length, &extent);
+    if (ret < 0) {
+        return nbd_co_send_structured_error(
+                client, handle, -ret, "can't get block status", errp);
+    }
+
+    return nbd_co_send_extents(client, handle, &extent, 1, context_id, errp);
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -1523,6 +1816,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE;
+    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
+        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
     }
     if (request->flags & ~valid_flags) {
         error_setg(errp, "unsupported flags for command %s (got 0x%x)",
@@ -1650,6 +1945,19 @@ static coroutine_fn void nbd_trip(void *opaque)
         }
 
         break;
+    case NBD_CMD_BLOCK_STATUS:
+        if (client->export_meta.base_allocation) {
+            ret = nbd_co_send_block_status(req->client, request.handle,
+                                           blk_bs(exp->blk), request.from,
+                                           request.len,
+                                           NBD_META_ID_BASE_ALLOCATION,
+                                           &local_err);
+        } else {
+            ret = -EINVAL;
+            error_setg(&local_err, "CMD_BLOCK_STATUS not negotiated");
+        }
+
+        break;
     default:
         error_setg(&local_err, "invalid request type (%" PRIu32 ") received",
                    request.type);
@@ -1680,7 +1988,7 @@ reply:
             ret = nbd_co_send_structured_done(req->client, request.handle,
                                               &local_err);
         }
-    } else {
+    } else if (request.type != NBD_CMD_BLOCK_STATUS) {
         ret = nbd_co_send_simple_reply(req->client, request.handle,
                                        ret < 0 ? -ret : 0,
                                        req->data, reply_data_len, &local_err);
-- 
2.11.1
