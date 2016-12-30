Received: from eggs.gnu.org ([2001:4830:134:3::10]:40711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMylE-0001RA-Vw
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMylA-0001xX-UA
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:24 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:32 +0300
Message-ID: <20161230143142.18214-9-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 08/18] block/pcache: add AIO readahead
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

This patch adds readahead data to the cache. Here the readahead is a separate
asynchronous request, which doesn't depend on completion of filtered read
requests. The readahead is done only by the condition, if before the current
request there's sequential read data enough size. This information can give
the request statistics, of course this method of detection is not very reliable,
but in most cases it'll work.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 2 deletions(-)

diff --git a/block/pcache.c b/block/pcache.c
index deac57c58d..57eebd434a 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -17,6 +17,8 @@
 
 #define PCACHE_OPT_STATS_SIZE "pcache-stats-size"
 #define PCACHE_OPT_MAX_AIO_SIZE "pcache-max-aio-size"
+#define PCACHE_OPT_CACHE_SIZE "pcache-full-size"
+#define PCACHE_OPT_READAHEAD_SIZE "pcache-readahead-size"
 
 static QemuOptsList runtime_opts = {
     .name = "pcache",
@@ -32,6 +34,16 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "Maximum size of aio which is handled by pcache",
         },
+        {
+            .name = PCACHE_OPT_CACHE_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Total cache size",
+        },
+        {
+            .name = PCACHE_OPT_READAHEAD_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Prefetch cache readahead size",
+        },
         { /* end of list */ }
     },
 };
@@ -40,12 +52,46 @@ static QemuOptsList runtime_opts = {
 #define MB_BITS 20
 #define PCACHE_DEFAULT_STATS_SIZE (3 << MB_BITS)
 #define PCACHE_DEFAULT_MAX_AIO_SIZE (64 << KB_BITS)
+#define PCACHE_DEFAULT_CACHE_SIZE (4 << MB_BITS)
+#define PCACHE_DEFAULT_READAHEAD_SIZE (128 << KB_BITS)
 
 typedef struct BDRVPCacheState {
     RBCache *req_stats;
+    RBCache *cache;
     uint64_t max_aio_size;
+    uint64_t readahead_size;
 } BDRVPCacheState;
 
+typedef struct PCacheNode {
+    RBCacheNode common;
+    uint8_t *data;
+    enum {
+        NODE_STATUS_NEW       = 0x01,
+        NODE_STATUS_INFLIGHT  = 0x02,
+        NODE_STATUS_COMPLETED = 0x04,
+        NODE_STATUS_REMOVE    = 0x08,
+        NODE_STATUS_DELETED   = 0x10, /* only for debugging */
+    } status;
+    int ref;
+} PCacheNode;
+
+static inline void pcache_node_ref(PCacheNode *node)
+{
+    node->ref++;
+}
+
+static void pcache_node_unref(PCacheNode *node)
+{
+    assert(node->ref > 0);
+    if (--node->ref == 0) {
+        assert(node->status & NODE_STATUS_REMOVE);
+        node->status |= NODE_STATUS_DELETED;
+
+        g_free(node->data);
+        g_free(node);
+    }
+}
+
 static void update_req_stats(RBCache *rbcache, uint64_t offset, uint64_t bytes)
 {
     do {
@@ -80,16 +126,165 @@ static void update_req_stats(RBCache *rbcache, uint64_t offset, uint64_t bytes)
     } while (true);
 }
 
+static bool check_request_sequence(BDRVPCacheState *s, uint64_t offset)
+{
+    uint64_t cache_line_size = s->readahead_size;
+    uint64_t check_offset;
+
+    if (offset <= cache_line_size) {
+        return false;
+    }
+    check_offset = offset - cache_line_size;
+
+    do {
+        RBCacheNode *node = rbcache_search(s->req_stats, check_offset,
+                                           offset - check_offset);
+        if (node == NULL) {
+            return false;
+        }
+        if (node->offset > check_offset) {
+            return false;
+        }
+        check_offset = node->offset + node->bytes;
+    } while (check_offset < offset);
+
+    return true;
+}
+
+static void pcache_node_free(RBCacheNode *rbnode, void *opaque)
+{
+    PCacheNode *node = container_of(rbnode, PCacheNode, common);
+
+    assert(node->status == NODE_STATUS_INFLIGHT ||
+           node->status == NODE_STATUS_COMPLETED);
+
+    node->status |= NODE_STATUS_REMOVE;
+    pcache_node_unref(node);
+}
+
+static RBCacheNode *pcache_node_alloc(uint64_t offset, uint64_t bytes,
+                                      void *opaque)
+{
+    PCacheNode *node = g_malloc(sizeof(*node));
+
+    node->data = g_malloc(bytes);
+    node->status = NODE_STATUS_NEW;
+    node->ref = 1;
+
+    return &node->common;
+}
+
+#define PCACHE_STEPS_FORWARD 2
+
+static PCacheNode *get_readahead_node(BlockDriverState *bs, RBCache *rbcache,
+                                      uint64_t offset, uint64_t bytes)
+{
+    uint32_t count = PCACHE_STEPS_FORWARD;
+
+    int64_t total_bytes = bdrv_getlength(bs);
+    if (total_bytes < 0) {
+        return NULL;
+    }
+
+    while (count--) {
+        PCacheNode *node;
+
+        if (total_bytes <= offset + bytes) {
+            break;
+        }
+
+        node = rbcache_search_and_insert(rbcache, offset, bytes);
+        if (node->status == NODE_STATUS_NEW) {
+            return node;
+        }
+         /* The range less than the readahead size is not cached to reduce
+          * fragmentation of the cache. If the data is already cached, then we
+          * just step over it.
+          */
+        if (offset <= node->common.offset && !count--) {
+            break;
+        }
+        offset = node->common.offset + node->common.bytes;
+    };
+
+    return NULL;
+}
+
+typedef struct PCacheReadaheadCo {
+    BlockDriverState *bs;
+    int64_t offset;
+    uint64_t bytes;
+} PCacheReadaheadCo;
+
+static void coroutine_fn pcache_co_readahead(BlockDriverState *bs,
+                                             uint64_t offset, uint64_t bytes)
+{
+    BDRVPCacheState *s = bs->opaque;
+    QEMUIOVector qiov;
+    PCacheNode *node;
+    uint64_t readahead_offset;
+    uint64_t readahead_bytes;
+    int ret;
+
+    if (!check_request_sequence(s, offset)) {
+        return;
+    }
+
+    readahead_offset = offset + bytes;
+    readahead_bytes = s->readahead_size;
+
+    node = get_readahead_node(bs, s->cache, readahead_offset, readahead_bytes);
+    if (node == NULL) {
+        return;
+    }
+    node->status = NODE_STATUS_INFLIGHT;
+    qemu_iovec_init(&qiov, 1);
+    qemu_iovec_add(&qiov, node->data, node->common.bytes);
+    pcache_node_ref(node);
+
+    ret = bdrv_co_preadv(bs->file, node->common.offset,
+                         node->common.bytes, &qiov, 0);
+    assert(node->status & NODE_STATUS_INFLIGHT);
+    node->status &= ~NODE_STATUS_INFLIGHT;
+    node->status |= NODE_STATUS_COMPLETED;
+
+    if (ret < 0) {
+        rbcache_remove(s->cache, &node->common);
+    }
+    pcache_node_unref(node);
+}
+
+static void pcache_readahead_entry(void *opaque)
+{
+    PCacheReadaheadCo *readahead_co = opaque;
+
+    pcache_co_readahead(readahead_co->bs, readahead_co->offset,
+                        readahead_co->bytes);
+}
+
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
 {
     BDRVPCacheState *s = bs->opaque;
+    PCacheReadaheadCo readahead_co;
+    Coroutine *co;
 
-    if (s->max_aio_size >= bytes) {
-        update_req_stats(s->req_stats, offset, bytes);
+    if (bytes > s->max_aio_size) {
+        goto skip_large_request;
     }
 
+    update_req_stats(s->req_stats, offset, bytes);
+
+    readahead_co = (PCacheReadaheadCo) {
+        .bs = bs,
+        .offset = offset,
+        .bytes = bytes,
+    };
+    co = qemu_coroutine_create(pcache_readahead_entry, &readahead_co);
+    qemu_coroutine_enter(co);
+
+skip_large_request:
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
@@ -104,10 +299,16 @@ static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
 {
     uint64_t stats_size = qemu_opt_get_size(opts, PCACHE_OPT_STATS_SIZE,
                                             PCACHE_DEFAULT_STATS_SIZE);
+    uint64_t cache_size = qemu_opt_get_size(opts, PCACHE_OPT_CACHE_SIZE,
+                                            PCACHE_DEFAULT_CACHE_SIZE);
     s->req_stats = rbcache_create(NULL, NULL, stats_size, RBCACHE_FIFO, s);
 
     s->max_aio_size = qemu_opt_get_size(opts, PCACHE_OPT_MAX_AIO_SIZE,
                                         PCACHE_DEFAULT_MAX_AIO_SIZE);
+    s->cache = rbcache_create(pcache_node_alloc, pcache_node_free, cache_size,
+                              RBCACHE_LRU, s);
+    s->readahead_size = qemu_opt_get_size(opts, PCACHE_OPT_READAHEAD_SIZE,
+                                          PCACHE_DEFAULT_READAHEAD_SIZE);
 }
 
 static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
@@ -144,6 +345,7 @@ static void pcache_close(BlockDriverState *bs)
     BDRVPCacheState *s = bs->opaque;
 
     rbcache_destroy(s->req_stats);
+    rbcache_destroy(s->cache);
 }
 
 static int64_t pcache_getlength(BlockDriverState *bs)
-- 
2.11.0
