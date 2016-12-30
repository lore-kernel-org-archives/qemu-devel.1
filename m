Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyjK-000052-Cz
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyjG-0000XN-Ec
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:04:26 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:40 +0300
Message-ID: <20161230143142.18214-17-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 16/18] block/pcache: drop used pcache nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

The pcache is directed to certain situations to sequential reads. This concept
allows to drop parts of the cache that were already used, which will reduce
the size of cache and the number of displaced nodes.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/block/pcache.c b/block/pcache.c
index 3f89e40b05..6d2b54cf78 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -81,6 +81,7 @@ typedef struct PCacheNode {
         NODE_STATUS_REMOVE    = 0x08,
         NODE_STATUS_DELETED   = 0x10, /* only for debugging */
     } status;
+    uint64_t rdcnt;
     QLIST_ENTRY(PCacheNode) entry;
     int ref;
 } PCacheNode;
@@ -109,13 +110,17 @@ static uint64_t ranges_overlap_size(uint64_t offset1, uint64_t size1,
     return MIN(offset1 + size1, offset2 + size2) - MAX(offset1, offset2);
 }
 
-static void read_cache_data_direct(PCacheNode *node, uint64_t offset,
-                                   uint64_t bytes, QEMUIOVector *qiov)
+static void read_cache_data_direct(BlockDriverState *bs, PCacheNode *node,
+                                   uint64_t offset, uint64_t bytes,
+                                   QEMUIOVector *qiov)
 {
+    BDRVPCacheState *s = bs->opaque;
     uint64_t qiov_offs = 0, node_offs = 0;
     uint64_t size;
     uint64_t copy;
 
+    assert(node->status & NODE_STATUS_COMPLETED);
+
     if (offset < node->common.offset) {
         qiov_offs = node->common.offset - offset;
     } else {
@@ -124,11 +129,17 @@ static void read_cache_data_direct(PCacheNode *node, uint64_t offset,
     size = ranges_overlap_size(offset, bytes, node->common.offset,
                                node->common.bytes);
     copy = qemu_iovec_from_buf(qiov, qiov_offs, node->data + node_offs, size);
+    node->rdcnt += size;
+    if (node->rdcnt >= node->common.bytes &&
+        !(node->status & NODE_STATUS_REMOVE))
+    {
+        rbcache_remove(s->cache, &node->common);
+    }
     assert(copy == size);
 }
 
-static int read_cache_data(PCacheNode *node, uint64_t offset, uint64_t bytes,
-                           QEMUIOVector *qiov)
+static int read_cache_data(BlockDriverState *bs, PCacheNode *node,
+                           uint64_t offset, uint64_t bytes, QEMUIOVector *qiov)
 {
     if (node->status & NODE_STATUS_INFLIGHT) {
         ReqLinkEntry rlink = {
@@ -143,7 +154,7 @@ static int read_cache_data(PCacheNode *node, uint64_t offset, uint64_t bytes,
             return rlink.ret;
         }
     }
-    read_cache_data_direct(node, offset, bytes, qiov);
+    read_cache_data_direct(bs, node, offset, bytes, qiov);
 
     return 0;
 }
@@ -228,6 +239,7 @@ static RBCacheNode *pcache_node_alloc(uint64_t offset, uint64_t bytes,
 
     node->data = g_malloc(bytes);
     node->status = NODE_STATUS_NEW;
+    node->rdcnt = 0;
     node->ref = 1;
     QTAILQ_INIT(&node->wait_list);
 
@@ -492,7 +504,7 @@ static int pickup_parts_of_cache(BlockDriverState *bs, PCacheNode *node,
         PartReqEntry *part = &req.parts[req.cnt];
         if (ret == 0) {
             if (part->rlink.ret == 0) {
-                read_cache_data_direct(part->node, offset, bytes, qiov);
+                read_cache_data_direct(bs, part->node, offset, bytes, qiov);
             } else {
                 ret = part->rlink.ret;
             }
@@ -523,7 +535,7 @@ static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
     if (node->common.offset <= offset &&
         node->common.offset + node->common.bytes >= offset + bytes)
     {
-        ret = read_cache_data(node, offset, bytes, qiov);
+        ret = read_cache_data(bs, node, offset, bytes, qiov);
 
     } else {
         ret = pickup_parts_of_cache(bs, node, offset, bytes, qiov);
-- 
2.11.0
