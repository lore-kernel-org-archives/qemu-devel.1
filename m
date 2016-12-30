Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMylA-0001N3-7f
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyl6-0001tC-Ez
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:19 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:38 +0300
Message-ID: <20161230143142.18214-15-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 14/18] block/pcache: up-to-date cache for
 removed nodes
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

We must be able to keep the actual data even for the removed nodes. This is
necessary when we need to defer the reading of node. Because there may come
an overlapping write to removed node in the interval between node completion
and reading of the node.

For this we move the removed nodes to remove_node_list and update
node->data on each overlapping write.

This is preparatory patch for the resolution of partial cache-hit.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/pcache.c b/block/pcache.c
index 140f90d6d7..86b28de44b 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -60,6 +60,7 @@ typedef struct BDRVPCacheState {
     RBCache *cache;
     uint64_t max_aio_size;
     uint64_t readahead_size;
+    QLIST_HEAD(, PCacheNode) remove_node_list;
 } BDRVPCacheState;
 
 typedef struct ReqLinkEntry {
@@ -79,6 +80,7 @@ typedef struct PCacheNode {
         NODE_STATUS_REMOVE    = 0x08,
         NODE_STATUS_DELETED   = 0x10, /* only for debugging */
     } status;
+    QLIST_ENTRY(PCacheNode) entry;
     int ref;
 } PCacheNode;
 
@@ -94,6 +96,7 @@ static void pcache_node_unref(PCacheNode *node)
         assert(node->status & NODE_STATUS_REMOVE);
         node->status |= NODE_STATUS_DELETED;
 
+        QLIST_REMOVE(node, entry);
         g_free(node->data);
         g_free(node);
     }
@@ -205,11 +208,14 @@ static bool check_request_sequence(BDRVPCacheState *s, uint64_t offset)
 
 static void pcache_node_free(RBCacheNode *rbnode, void *opaque)
 {
+    BDRVPCacheState *s = opaque;
     PCacheNode *node = container_of(rbnode, PCacheNode, common);
 
     assert(node->status == NODE_STATUS_INFLIGHT ||
            node->status == NODE_STATUS_COMPLETED);
 
+    QLIST_INSERT_HEAD(&s->remove_node_list, node, entry);
+
     node->status |= NODE_STATUS_REMOVE;
     pcache_node_unref(node);
 }
@@ -432,11 +438,12 @@ static void pcache_write_through(BlockDriverState *bs, uint64_t offset,
                                  uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVPCacheState *s = bs->opaque;
+    PCacheNode *node, *next;
     uint64_t chunk_offset = offset, chunk_bytes = bytes;
     uint64_t end_offs = offset + bytes;
 
     do {
-        PCacheNode *node = rbcache_search(s->cache, chunk_offset, chunk_bytes);
+        node = rbcache_search(s->cache, chunk_offset, chunk_bytes);
         if (node == NULL) {
             break;
         }
@@ -450,6 +457,18 @@ static void pcache_write_through(BlockDriverState *bs, uint64_t offset,
             write_cache_data(node, offset, bytes, qiov);
         }
     } while (end_offs > chunk_offset);
+
+    QLIST_FOREACH_SAFE(node, &s->remove_node_list, entry, next) {
+        if (node->status & NODE_STATUS_INFLIGHT) {
+            continue;
+        }
+        if (offset >= node->common.offset + node->common.bytes ||
+            offset + bytes <= node->common.offset)
+        {
+            continue;
+        }
+        write_cache_data(node, offset, bytes, qiov);
+    }
 }
 
 static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
@@ -479,6 +498,7 @@ static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
                               RBCACHE_LRU, s);
     s->readahead_size = qemu_opt_get_size(opts, PCACHE_OPT_READAHEAD_SIZE,
                                           PCACHE_DEFAULT_READAHEAD_SIZE);
+    QLIST_INIT(&s->remove_node_list);
 }
 
 static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
@@ -516,6 +536,8 @@ static void pcache_close(BlockDriverState *bs)
 
     rbcache_destroy(s->req_stats);
     rbcache_destroy(s->cache);
+
+    assert(QLIST_EMPTY(&s->remove_node_list));
 }
 
 static int64_t pcache_getlength(BlockDriverState *bs)
-- 
2.11.0
