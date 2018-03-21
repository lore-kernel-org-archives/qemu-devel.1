Received: from eggs.gnu.org ([2001:4830:134:3::10]:54984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eycib-00061l-4e
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyciX-0005ix-3J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Mar 2018 15:19:39 +0300
Message-Id: <20180321121940.39426-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180321121940.39426-1-vsementsov@virtuozzo.com>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] nbd/server: implement dirty bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |   2 +
 nbd/server.c        | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 203 insertions(+), 6 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index fcdcd54502..f0b459283f 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -315,6 +315,8 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       Error **errp);
 
+void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
+                       const char *bitmap_export_name, Error **errp);
 
 /* nbd_read
  * Reads @size bytes from @ioc. Returns 0 on success.
diff --git a/nbd/server.c b/nbd/server.c
index 8fe53ffd4b..6554919ef2 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -23,6 +23,12 @@
 #include "nbd-internal.h"
 
 #define NBD_META_ID_BASE_ALLOCATION 0
+#define NBD_META_ID_DIRTY_BITMAP 1
+
+#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
+#define MAX_EXTENT_LENGTH QEMU_ALIGN_DOWN(INT32_MAX, 512)
+
+#define NBD_STATE_DIRTY 1
 
 static int system_errno_to_nbd_errno(int err)
 {
@@ -80,6 +86,9 @@ struct NBDExport {
 
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;
+
+    BdrvDirtyBitmap *export_bitmap;
+    char *export_bitmap_name;
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
@@ -92,6 +101,7 @@ typedef struct NBDExportMetaContexts {
     bool valid; /* means that negotiation of the option finished without
                    errors */
     bool base_allocation; /* export base:allocation context (block status) */
+    bool dirty_bitmap; /* export qemu-dirty-bitmap:<export_bitmap_name> */
 } NBDExportMetaContexts;
 
 struct NBDClient {
@@ -786,12 +796,32 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                  &meta->base_allocation, errp);
 }
 
+/* nbd_meta_bitmap_query
+ *
+ * Handle query to 'qemu-dirty-bitmap' namespace.
+ * 'len' is the amount of text remaining to be read from the current name, after
+ * the 'qemu-dirty-bitmap:' portion has been stripped.
+ *
+ * Return -errno on I/O error, 0 if option was completely handled by
+ * sending a reply about inconsistent lengths, or 1 on success. */
+static int nbd_meta_bitmap_query(NBDClient *client, NBDExportMetaContexts *meta,
+                                 uint32_t len, Error **errp)
+{
+    if (!client->exp->export_bitmap) {
+        return nbd_opt_skip(client, len, errp);
+    }
+
+    return nbd_meta_single_query(client, client->exp->export_bitmap_name, len,
+                                 &meta->dirty_bitmap, errp);
+}
+
 struct {
     const char *ns;
     int (*func)(NBDClient *, NBDExportMetaContexts *, uint32_t, Error **);
 } meta_namespace_handlers[] = {
     /* namespaces should go in non-decreasing order by name length */
     {.ns = "base:", .func = nbd_meta_base_query},
+    {.ns = "qemu-dirty-bitmap:", .func = nbd_meta_bitmap_query},
 };
 
 /* nbd_negotiate_meta_query
@@ -921,6 +951,17 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         }
     }
 
+    if (meta->dirty_bitmap) {
+        char *context = g_strdup_printf("qemu-dirty-bitmap:%s",
+                                        exp->export_bitmap_name);
+        ret = nbd_negotiate_send_meta_context(client, context,
+                                              NBD_META_ID_DIRTY_BITMAP,
+                                              errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
     if (ret == 0) {
         meta->valid = true;
@@ -1549,6 +1590,11 @@ void nbd_export_put(NBDExport *exp)
             exp->blk = NULL;
         }
 
+        if (exp->export_bitmap) {
+            bdrv_dirty_bitmap_set_qmp_locked(exp->export_bitmap, false);
+            g_free(exp->export_bitmap_name);
+        }
+
         g_free(exp);
     }
 }
@@ -1790,6 +1836,9 @@ static int blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
 }
 
 /* nbd_co_send_extents
+ *
+ * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
+ *
  * @extents should be in big-endian */
 static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
                                NBDExtent *extents, unsigned nb_extents,
@@ -1802,7 +1851,7 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
         {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
     };
 
-    set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE, NBD_REPLY_TYPE_BLOCK_STATUS,
+    set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STATUS,
                  handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
     stl_be_p(&chunk.context_id, context_id);
 
@@ -1827,6 +1876,91 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
     return nbd_co_send_extents(client, handle, &extent, 1, context_id, errp);
 }
 
+/* Set several extents, describing region of given @length with given @flags.
+ * Do not set more than @nb_extents, return number of set extents.
+ */
+static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
+                            uint64_t length, uint32_t flags)
+{
+    unsigned i = 0;
+    uint32_t max_extent_be = cpu_to_be32(MAX_EXTENT_LENGTH);
+    uint32_t flags_be = cpu_to_be32(flags);
+
+    for (i = 0; i < nb_extents && length > MAX_EXTENT_LENGTH;
+         i++, length -= MAX_EXTENT_LENGTH)
+    {
+        extents[i].length = max_extent_be;
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
+    uint64_t begin = offset, end;
+    uint64_t overall_end = offset + length;
+    unsigned i = 0;
+    BdrvDirtyBitmapIter *it;
+    bool dirty;
+
+    bdrv_dirty_bitmap_lock(bitmap);
+
+    it = bdrv_dirty_iter_new(bitmap);
+    dirty = bdrv_get_dirty_locked(NULL, bitmap, offset);
+
+    while (begin < overall_end && i < nb_extents) {
+        if (dirty) {
+            end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
+        } else {
+            bdrv_set_dirty_iter(it, begin);
+            end = bdrv_dirty_iter_next(it);
+        }
+        if (end == -1) {
+            end = overall_end;
+        }
+
+        i += add_extents(extents + i, nb_extents - i, end - begin,
+                         dirty ? NBD_STATE_DIRTY : 0);
+        begin = end;
+        dirty = !dirty;
+    }
+
+    bdrv_dirty_iter_free(it);
+
+    bdrv_dirty_bitmap_unlock(bitmap);
+
+    return i;
+}
+
+static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
+                              BdrvDirtyBitmap *bitmap, uint64_t offset,
+                              uint64_t length, uint32_t context_id,
+                              Error **errp)
+{
+    int ret;
+    unsigned nb_extents;
+    NBDExtent *extents = g_new(NBDExtent, NBD_MAX_BITMAP_EXTENTS);
+
+    nb_extents = bitmap_to_extents(bitmap, offset, length, extents,
+                                   NBD_MAX_BITMAP_EXTENTS);
+
+    ret = nbd_co_send_extents(client, handle, extents, nb_extents, context_id,
+                              errp);
+
+    g_free(extents);
+
+    return ret;
+}
+
 /* nbd_co_receive_request
  * Collect a client request. Return 0 if request looks valid, -EIO to drop
  * connection right away, and any other negative value to report an error to
@@ -2040,11 +2174,32 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "discard failed", errp);
 
     case NBD_CMD_BLOCK_STATUS:
-        if (client->export_meta.valid && client->export_meta.base_allocation) {
-            return nbd_co_send_block_status(client, request->handle,
-                                            blk_bs(exp->blk), request->from,
-                                            request->len,
-                                            NBD_META_ID_BASE_ALLOCATION, errp);
+        if (client->export_meta.valid &&
+            (client->export_meta.base_allocation ||
+             client->export_meta.dirty_bitmap))
+        {
+            if (client->export_meta.base_allocation) {
+                ret = nbd_co_send_block_status(client, request->handle,
+                                               blk_bs(exp->blk), request->from,
+                                               request->len,
+                                               NBD_META_ID_BASE_ALLOCATION,
+                                               errp);
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+
+            if (client->export_meta.dirty_bitmap) {
+                ret = nbd_co_send_bitmap(client, request->handle,
+                                         client->exp->export_bitmap,
+                                         request->from, request->len,
+                                         NBD_META_ID_DIRTY_BITMAP, errp);
+                if (ret < 0) {
+                    return ret;
+                }
+            }
+
+            return nbd_co_send_structured_done(client, request->handle, errp);
         } else {
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
                                           "CMD_BLOCK_STATUS not negotiated",
@@ -2196,3 +2351,43 @@ void nbd_client_new(NBDExport *exp,
     co = qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
+
+void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
+                       const char *bitmap_export_name, Error **errp)
+{
+    BdrvDirtyBitmap *bm = NULL;
+    BlockDriverState *bs = blk_bs(exp->blk);
+
+    if (exp->export_bitmap) {
+        error_setg(errp, "Export bitmap is already set");
+        return;
+    }
+
+    while (true) {
+        bm = bdrv_find_dirty_bitmap(bs, bitmap);
+        if (bm != NULL || bs->backing == NULL) {
+            break;
+        }
+
+        bs = bs->backing->bs;
+    }
+
+    if (bm == NULL) {
+        error_setg(errp, "Bitmap '%s' is not found", bitmap);
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_enabled(bm)) {
+        error_setg(errp, "Bitmap '%s' is enabled", bitmap);
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
+        error_setg(errp, "Bitmap '%s' is locked", bitmap);
+        return;
+    }
+
+    bdrv_dirty_bitmap_set_qmp_locked(bm, true);
+    exp->export_bitmap = bm;
+    exp->export_bitmap_name = g_strdup(bitmap_export_name);
+}
-- 
2.11.1
