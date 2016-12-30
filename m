Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyk8-0000eN-0D
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyk4-00013f-00
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:15 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:36 +0300
Message-ID: <20161230143142.18214-13-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 12/18] block/pcache: inflight readahead
 request waiting for read
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

If there was a cache hit, but the status of the node is NODE_STATUS_INFLIGHT,
then this means that a readahead request for this node is in flight. In this case,
we can wait for the completion of the readahead request, and then copy the
data. It allows us even more to optimize aio read requests.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/block/pcache.c b/block/pcache.c
index e3749679ca..c1cbfa7040 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -62,9 +62,16 @@ typedef struct BDRVPCacheState {
     uint64_t readahead_size;
 } BDRVPCacheState;
 
+typedef struct ReqLinkEntry {
+    QTAILQ_ENTRY(ReqLinkEntry) entry;
+    Coroutine *co;
+    int ret;
+} ReqLinkEntry;
+
 typedef struct PCacheNode {
     RBCacheNode common;
     uint8_t *data;
+    QTAILQ_HEAD(, ReqLinkEntry) wait_list;
     enum {
         NODE_STATUS_NEW       = 0x01,
         NODE_STATUS_INFLIGHT  = 0x02,
@@ -116,6 +123,27 @@ static void read_cache_data_direct(PCacheNode *node, uint64_t offset,
     assert(copy == size);
 }
 
+static int read_cache_data(PCacheNode *node, uint64_t offset, uint64_t bytes,
+                           QEMUIOVector *qiov)
+{
+    if (node->status & NODE_STATUS_INFLIGHT) {
+        ReqLinkEntry rlink = {
+            .co = qemu_coroutine_self(),
+        };
+
+        QTAILQ_INSERT_HEAD(&node->wait_list, &rlink, entry);
+
+        qemu_coroutine_yield();
+
+        if (rlink.ret < 0) {
+            return rlink.ret;
+        }
+    }
+    read_cache_data_direct(node, offset, bytes, qiov);
+
+    return 0;
+}
+
 static void update_req_stats(RBCache *rbcache, uint64_t offset, uint64_t bytes)
 {
     do {
@@ -194,6 +222,7 @@ static RBCacheNode *pcache_node_alloc(uint64_t offset, uint64_t bytes,
     node->data = g_malloc(bytes);
     node->status = NODE_STATUS_NEW;
     node->ref = 1;
+    QTAILQ_INIT(&node->wait_list);
 
     return &node->common;
 }
@@ -272,6 +301,7 @@ static void coroutine_fn pcache_co_readahead(BlockDriverState *bs,
     BDRVPCacheState *s = bs->opaque;
     QEMUIOVector qiov;
     PCacheNode *node;
+    ReqLinkEntry *rlink, *next;
     uint64_t readahead_offset;
     uint64_t readahead_bytes;
     int ret;
@@ -301,6 +331,13 @@ static void coroutine_fn pcache_co_readahead(BlockDriverState *bs,
     if (ret < 0) {
         rbcache_remove(s->cache, &node->common);
     }
+
+    QTAILQ_FOREACH_SAFE(rlink, &node->wait_list, entry, next) {
+        QTAILQ_REMOVE(&node->wait_list, rlink, entry);
+        rlink->ret = ret;
+        qemu_coroutine_enter(rlink->co);
+    }
+
     pcache_node_unref(node);
 }
 
@@ -323,7 +360,7 @@ static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
     BDRVPCacheState *s = bs->opaque;
 
     PCacheNode *node = rbcache_search(s->cache, offset, bytes);
-    if (node == NULL || node->status & NODE_STATUS_INFLIGHT) {
+    if (node == NULL) {
         return CACHE_MISS;
     }
 
@@ -331,7 +368,10 @@ static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
     if (node->common.offset <= offset &&
         node->common.offset + node->common.bytes >= offset + bytes)
     {
-        read_cache_data_direct(node, offset, bytes, qiov);
+        int ret = read_cache_data(node, offset, bytes, qiov);
+        if (ret < 0) {
+            return ret;
+        }
         return CACHE_HIT;
     }
 
@@ -362,8 +402,8 @@ static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
     qemu_coroutine_enter(co);
 
     status = pcache_lookup_data(bs, offset, bytes, qiov);
-    if (status == CACHE_HIT) {
-        return 0;
+    if (status != CACHE_MISS) {
+        return status < 0 ? status : 0;
     }
 
 skip_large_request:
-- 
2.11.0
