Received: from eggs.gnu.org ([2001:4830:134:3::10]:36765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5o-0007pJ-Od
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5k-00083D-47
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:08 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:13024 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-00080M-Kd
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:04 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:56 +0300
Message-Id: <20170203154757.36140-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 17/18] nbd: BLOCK_STATUS for standard
 get_block_status function: server part
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

Minimal realization: only one extent in server answer is supported.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  3 ++
 nbd/nbd-internal.h  |  1 +
 nbd/server.c        | 80 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 08d5e51f21..69aee1eda1 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -181,6 +181,9 @@ enum {
 #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
 
+#define NBD_STATE_HOLE 1
+#define NBD_STATE_ZERO (1 << 1)
+
 #define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
 
 ssize_t nbd_wr_syncv(QIOChannel *ioc,
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index fbbcf69925..f89baa6049 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -86,6 +86,7 @@
 #define NBD_OPT_LIST_META_CONTEXT (9)
 #define NBD_OPT_SET_META_CONTEXT  (10)
 
+#define NBD_META_NS_BASE "base"
 #define NBD_META_NS_BITMAPS "qemu-dirty-bitmap"
 
 /* NBD errors are based on errno numbers, so there is a 1:1 mapping,
diff --git a/nbd/server.c b/nbd/server.c
index c96dda4086..cb87481382 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -103,6 +103,7 @@ struct NBDClient {
 
     bool structured_reply;
     BdrvDirtyBitmap *export_bitmap;
+    bool export_block_status;
 };
 
 /* That's all folks */
@@ -506,8 +507,24 @@ static int nbd_negotiate_one_bitmap_query(QIOChannel *ioc, BlockDriverState *bs,
     return 0;
 }
 
+static int nbd_negotiate_one_base_query(QIOChannel *ioc, BlockDriverState *bs,
+                                        uint32_t opt, const char *query,
+                                        bool *block_status)
+{
+    if (query[0] == '\0' || strcmp(query, "allocation") == 0) {
+        if (block_status != NULL) {
+            *block_status = true;
+        }
+
+        return nbd_negotiate_send_meta_context(ioc, "base:allocation", opt);
+    }
+
+    return 0;
+}
+
 static int nbd_negotiate_one_meta_query(QIOChannel *ioc, BlockDriverState *bs,
-                                        uint32_t opt, BdrvDirtyBitmap **bitmap)
+                                        uint32_t opt, BdrvDirtyBitmap **bitmap,
+                                        bool *block_status)
 {
     int ret = 0, nb_read;
     char *query, *colon, *namespace, *subquery;
@@ -530,6 +547,9 @@ static int nbd_negotiate_one_meta_query(QIOChannel *ioc, BlockDriverState *bs,
 
     if (strcmp(namespace, NBD_META_NS_BITMAPS) == 0) {
         ret = nbd_negotiate_one_bitmap_query(ioc, bs, opt, subquery, bitmap);
+    } else if (strcmp(namespace, NBD_META_NS_BASE) == 0) {
+        ret = nbd_negotiate_one_base_query(ioc, bs, opt, subquery,
+                                           block_status);
     }
 
 out:
@@ -663,7 +683,8 @@ static int nbd_negotiate_list_meta_context(NBDClient *client, uint32_t length)
 
     for (i = 0; i < nb_queries; ++i) {
         ret = nbd_negotiate_one_meta_query(client->ioc, bs,
-                                           NBD_OPT_LIST_META_CONTEXT, NULL);
+                                           NBD_OPT_LIST_META_CONTEXT, NULL,
+                                           NULL);
         if (ret < 0) {
             return ret;
         }
@@ -712,7 +733,8 @@ static int nbd_negotiate_set_meta_context(NBDClient *client, uint32_t length)
 
     ret = nbd_negotiate_one_meta_query(client->ioc, bs,
                                        NBD_OPT_SET_META_CONTEXT,
-                                       &client->export_bitmap);
+                                       &client->export_bitmap,
+                                       &client->export_block_status);
     if (ret < 0) {
         return ret;
     }
@@ -1497,6 +1519,30 @@ static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
     return i;
 }
 
+static int blockstatus_to_extent(BlockDriverState *bs, uint64_t offset,
+                                  uint64_t length, NBDExtent *extent)
+{
+    BlockDriverState *file;
+    uint64_t start_sector = offset >> BDRV_SECTOR_BITS;
+    uint64_t last_sector = (offset + length - 1) >> BDRV_SECTOR_BITS;
+    uint64_t begin = start_sector;
+    uint64_t end = last_sector + 1;
+
+    int nb = MIN(INT_MAX, end - begin);
+    int64_t ret = bdrv_get_block_status_above(bs, NULL, begin, nb, &nb, &file);
+    if (ret < 0) {
+        return ret;
+    }
+
+    extent->flags =
+        cpu_to_be32((ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
+                    (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0));
+    extent->length = cpu_to_be32((nb << BDRV_SECTOR_BITS) -
+                                 (offset - (start_sector << BDRV_SECTOR_BITS)));
+
+    return 0;
+}
+
 static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                   uint64_t length, NBDExtent *extents,
                                   unsigned nb_extents)
@@ -1589,6 +1635,21 @@ static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
     return ret;
 }
 
+static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
+                                    BlockDriverState *bs, uint64_t offset,
+                                    uint64_t length, uint32_t context_id)
+{
+    int ret;
+    NBDExtent extent;
+
+    ret = blockstatus_to_extent(bs, offset, length, &extent);
+    if (ret < 0) {
+        return nbd_co_send_structured_error(client, handle, -ret);
+    }
+
+    return nbd_co_send_extents(client, handle, &extent, 1, context_id);
+}
+
 /* Collect a client request.  Return 0 if request looks valid, -EAGAIN
  * to keep trying the collection, -EIO to drop connection right away,
  * and any other negative value to report an error to the client
@@ -1869,13 +1930,18 @@ static void nbd_trip(void *opaque)
         break;
     case NBD_CMD_BLOCK_STATUS:
         TRACE("Request type is BLOCK_STATUS");
-        if (client->export_bitmap == NULL) {
+        if (!!client->export_bitmap) {
+            ret = nbd_co_send_bitmap(req->client, request.handle,
+                                     client->export_bitmap, request.from,
+                                     request.len, 0);
+        } else if (client->export_block_status) {
+            ret = nbd_co_send_block_status(req->client, request.handle,
+                                           blk_bs(exp->blk), request.from,
+                                           request.len, 0);
+        } else {
             reply.error = EINVAL;
             goto error_reply;
         }
-        ret = nbd_co_send_bitmap(req->client, request.handle,
-                                 client->export_bitmap, request.from,
-                                 request.len, 0);
         if (ret < 0) {
             goto out;
         }
-- 
2.11.0
