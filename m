Received: from eggs.gnu.org ([2001:4830:134:3::10]:40131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyio-0008KC-K0
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyik-0000AI-Kw
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:03:54 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:35 +0300
Message-ID: <20161230143142.18214-12-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 11/18] block/pcache: add reading data from
 the cache
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

Added read_cache_data_direct() allowing to read data from node to qiov.
And the simplest use case - read data from node provided that the node is
not in flight and fully covers read request.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/block/pcache.c b/block/pcache.c
index 4007241d37..e3749679ca 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -92,6 +92,30 @@ static void pcache_node_unref(PCacheNode *node)
     }
 }
 
+static uint64_t ranges_overlap_size(uint64_t offset1, uint64_t size1,
+                                    uint64_t offset2, uint32_t size2)
+{
+    return MIN(offset1 + size1, offset2 + size2) - MAX(offset1, offset2);
+}
+
+static void read_cache_data_direct(PCacheNode *node, uint64_t offset,
+                                   uint64_t bytes, QEMUIOVector *qiov)
+{
+    uint64_t qiov_offs = 0, node_offs = 0;
+    uint64_t size;
+    uint64_t copy;
+
+    if (offset < node->common.offset) {
+        qiov_offs = node->common.offset - offset;
+    } else {
+        node_offs = offset - node->common.offset;
+    }
+    size = ranges_overlap_size(offset, bytes, node->common.offset,
+                               node->common.bytes);
+    copy = qemu_iovec_from_buf(qiov, qiov_offs, node->data + node_offs, size);
+    assert(copy == size);
+}
+
 static void update_req_stats(RBCache *rbcache, uint64_t offset, uint64_t bytes)
 {
     do {
@@ -288,6 +312,32 @@ static void pcache_readahead_entry(void *opaque)
                         readahead_co->bytes);
 }
 
+enum {
+    CACHE_MISS,
+    CACHE_HIT,
+};
+
+static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
+                              uint64_t bytes, QEMUIOVector *qiov)
+{
+    BDRVPCacheState *s = bs->opaque;
+
+    PCacheNode *node = rbcache_search(s->cache, offset, bytes);
+    if (node == NULL || node->status & NODE_STATUS_INFLIGHT) {
+        return CACHE_MISS;
+    }
+
+    /* Node covers the whole request */
+    if (node->common.offset <= offset &&
+        node->common.offset + node->common.bytes >= offset + bytes)
+    {
+        read_cache_data_direct(node, offset, bytes, qiov);
+        return CACHE_HIT;
+    }
+
+    return CACHE_MISS;
+}
+
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -295,6 +345,7 @@ static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
     BDRVPCacheState *s = bs->opaque;
     PCacheReadaheadCo readahead_co;
     Coroutine *co;
+    int status;
 
     if (bytes > s->max_aio_size) {
         goto skip_large_request;
@@ -310,6 +361,11 @@ static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
     co = qemu_coroutine_create(pcache_readahead_entry, &readahead_co);
     qemu_coroutine_enter(co);
 
+    status = pcache_lookup_data(bs, offset, bytes, qiov);
+    if (status == CACHE_HIT) {
+        return 0;
+    }
+
 skip_large_request:
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
-- 
2.11.0
