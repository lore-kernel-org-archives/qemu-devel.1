Received: from eggs.gnu.org ([2001:4830:134:3::10]:47384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnV0-0007UM-BL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUv-0000xe-5N
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:40 -0500
Message-Id: <20180313171345.659672-13-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Minimal realization: only one extent in server answer is supported.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180312152126.286890-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: tweak whitespace, move constant from .h to .c, improve
logic of check_meta_export_name, simplify nbd_negotiate_options
by doing more in nbd_negotiate_meta_queries]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 311 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 311 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 280bdbb1040..cea158913ba 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -22,6 +22,8 @@
 #include "trace.h"
 #include "nbd-internal.h"

+#define NBD_META_ID_BASE_ALLOCATION 0
+
 static int system_errno_to_nbd_errno(int err)
 {
     switch (err) {
@@ -82,6 +84,16 @@ struct NBDExport {

 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);

+/* NBDExportMetaContexts represents a list of contexts to be exported,
+ * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
+ * NBD_OPT_LIST_META_CONTEXT. */
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
@@ -102,6 +114,7 @@ struct NBDClient {
     bool closing;

     bool structured_reply;
+    NBDExportMetaContexts export_meta;

     uint32_t opt; /* Current option being negotiated */
     uint32_t optlen; /* remaining length of data in ioc for the option being
@@ -273,6 +286,20 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
     return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
 }

+/* Drop size bytes from the unparsed payload of the current option.
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_opt_skip(NBDClient *client, size_t size, Error **errp)
+{
+    if (size > client->optlen) {
+        return nbd_opt_invalid(client, errp,
+                               "Inconsistent lengths in option %s",
+                               nbd_opt_lookup(client->opt));
+    }
+    client->optlen -= size;
+    return nbd_drop(client->ioc, size, errp) < 0 ? -EIO : 1;
+}
+
 /* nbd_opt_read_name
  *
  * Read a string with the format:
@@ -372,6 +399,12 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)
     return nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
 }

+static void nbd_check_meta_export_name(NBDClient *client)
+{
+    client->export_meta.valid &= !strcmp(client->exp->name,
+                                         client->export_meta.export_name);
+}
+
 /* Send a reply to NBD_OPT_EXPORT_NAME.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_handle_export_name(NBDClient *client,
@@ -423,6 +456,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,

     QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
     nbd_export_get(client->exp);
+    nbd_check_meta_export_name(client);

     return 0;
 }
@@ -616,6 +650,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint16_t myflags,
         client->exp = exp;
         QTAILQ_INSERT_TAIL(&client->exp->clients, client, next);
         nbd_export_get(client->exp);
+        nbd_check_meta_export_name(client);
         rc = 1;
     }
     return rc;
@@ -670,6 +705,189 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     return QIO_CHANNEL(tioc);
 }

+/* nbd_negotiate_send_meta_context
+ *
+ * Send one chunk of reply to NBD_OPT_{LIST,SET}_META_CONTEXT
+ *
+ * For NBD_OPT_LIST_META_CONTEXT @context_id is ignored, 0 is used instead.
+ */
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
+    if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+        context_id = 0;
+    }
+
+    set_be_option_rep(&opt.h, client->opt, NBD_REP_META_CONTEXT,
+                      sizeof(opt) - sizeof(opt.h) + iov[1].iov_len);
+    stl_be_p(&opt.context_id, context_id);
+
+    return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
+}
+
+/* nbd_meta_base_query
+ *
+ * Handle query to 'base' namespace. For now, only base:allocation context is
+ * available in it.  'len' is the amount of text remaining to be read from
+ * the current name, after the 'base:' portion has been stripped.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+                               uint32_t len, Error **errp)
+{
+    int ret;
+    char query[sizeof("allocation") - 1];
+    size_t alen = strlen("allocation");
+
+    if (len == 0) {
+        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+            meta->base_allocation = true;
+        }
+        return 1;
+    }
+
+    if (len != alen) {
+        return nbd_opt_skip(client, len, errp);
+    }
+
+    ret = nbd_opt_read(client, query, len, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    if (strncmp(query, "allocation", alen) == 0) {
+        meta->base_allocation = true;
+    }
+
+    return 1;
+}
+
+/* nbd_negotiate_meta_query
+ *
+ * Parse namespace name and call corresponding function to parse body of the
+ * query.
+ *
+ * The only supported namespace now is 'base'.
+ *
+ * The function aims not wasting time and memory to read long unknown namespace
+ * names.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_negotiate_meta_query(NBDClient *client,
+                                    NBDExportMetaContexts *meta, Error **errp)
+{
+    int ret;
+    char query[sizeof("base:") - 1];
+    size_t baselen = strlen("base:");
+    uint32_t len;
+
+    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&len);
+
+    /* The only supported namespace for now is 'base'. So query should start
+     * with 'base:'. Otherwise, we can ignore it and skip the remainder. */
+    if (len < baselen) {
+        return nbd_opt_skip(client, len, errp);
+    }
+
+    len -= baselen;
+    ret = nbd_opt_read(client, query, baselen, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    if (strncmp(query, "base:", baselen) != 0) {
+        return nbd_opt_skip(client, len, errp);
+    }
+
+    return nbd_meta_base_query(client, meta, len, errp);
+}
+
+/* nbd_negotiate_meta_queries
+ * Handle NBD_OPT_LIST_META_CONTEXT and NBD_OPT_SET_META_CONTEXT
+ *
+ * Return -errno on I/O error, or 0 if option was completely handled. */
+static int nbd_negotiate_meta_queries(NBDClient *client,
+                                      NBDExportMetaContexts *meta, Error **errp)
+{
+    int ret;
+    NBDExport *exp;
+    NBDExportMetaContexts local_meta;
+    uint32_t nb_queries;
+    int i;
+
+    if (!client->structured_reply) {
+        return nbd_opt_invalid(client, errp,
+                               "request option '%s' when structured reply "
+                               "is not negotiated",
+                               nbd_opt_lookup(client->opt));
+    }
+
+    if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+        /* Only change the caller's meta on SET. */
+        meta = &local_meta;
+    }
+
+    memset(meta, 0, sizeof(*meta));
+
+    ret = nbd_opt_read_name(client, meta->export_name, NULL, errp);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    exp = nbd_export_find(meta->export_name);
+    if (exp == NULL) {
+        return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
+                            "export '%s' not present", meta->export_name);
+    }
+
+    ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
+    if (ret <= 0) {
+        return ret;
+    }
+    cpu_to_be32s(&nb_queries);
+
+    if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
+        /* enable all known contexts */
+        meta->base_allocation = true;
+    } else {
+        for (i = 0; i < nb_queries; ++i) {
+            ret = nbd_negotiate_meta_query(client, meta, errp);
+            if (ret <= 0) {
+                return ret;
+            }
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
@@ -860,6 +1078,12 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 }
                 break;

+            case NBD_OPT_LIST_META_CONTEXT:
+            case NBD_OPT_SET_META_CONTEXT:
+                ret = nbd_negotiate_meta_queries(client, &client->export_meta,
+                                                 errp);
+                break;
+
             default:
                 ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
                                    "Unsupported option %" PRIu32 " (%s)",
@@ -1489,6 +1713,79 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
     return ret;
 }

+static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
+                                    uint64_t bytes, NBDExtent *extent)
+{
+    uint64_t remaining_bytes = bytes;
+
+    while (remaining_bytes) {
+        uint32_t flags;
+        int64_t num;
+        int ret = bdrv_block_status_above(bs, NULL, offset, remaining_bytes,
+                                          &num, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+
+        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
+                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
+
+        if (remaining_bytes == bytes) {
+            extent->flags = flags;
+        }
+
+        if (flags != extent->flags) {
+            break;
+        }
+
+        offset += num;
+        remaining_bytes -= num;
+    }
+
+    cpu_to_be32s(&extent->flags);
+    extent->length = cpu_to_be32(bytes - remaining_bytes);
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
+/* Get block status from the exported device and send it to the client */
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
@@ -1566,6 +1863,8 @@ static int nbd_co_receive_request(NBDRequestData *req, NBDRequest *request,
         valid_flags |= NBD_CMD_FLAG_DF;
     } else if (request->type == NBD_CMD_WRITE_ZEROES) {
         valid_flags |= NBD_CMD_FLAG_NO_HOLE;
+    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
+        valid_flags |= NBD_CMD_FLAG_REQ_ONE;
     }
     if (request->flags & ~valid_flags) {
         error_setg(errp, "unsupported flags for command %s (got 0x%x)",
@@ -1699,6 +1998,18 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "discard failed", errp);

+    case NBD_CMD_BLOCK_STATUS:
+        if (client->export_meta.valid && client->export_meta.base_allocation) {
+            return nbd_co_send_block_status(client, request->handle,
+                                            blk_bs(exp->blk), request->from,
+                                            request->len,
+                                            NBD_META_ID_BASE_ALLOCATION, errp);
+        } else {
+            return nbd_send_generic_reply(client, request->handle, -EINVAL,
+                                          "CMD_BLOCK_STATUS not negotiated",
+                                          errp);
+        }
+
     default:
         msg = g_strdup_printf("invalid request type (%" PRIu32 ") received",
                               request->type);
-- 
2.14.3
