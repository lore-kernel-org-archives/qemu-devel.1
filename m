Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMykb-0000xM-4O
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMykX-0001Xw-35
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:45 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:42 +0300
Message-ID: <20161230143142.18214-19-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 18/18] block/pcache: add tracepoints
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

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c     | 20 ++++++++++++++++++++
 block/trace-events | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/block/pcache.c b/block/pcache.c
index 6d2b54cf78..2bce3efc59 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/rbcache.h"
+#include "trace.h"
 
 #define PCACHE_OPT_STATS_SIZE "pcache-stats-size"
 #define PCACHE_OPT_MAX_AIO_SIZE "pcache-max-aio-size"
@@ -348,12 +349,18 @@ static void coroutine_fn pcache_co_readahead(BlockDriverState *bs,
     node->status |= NODE_STATUS_COMPLETED;
 
     if (ret < 0) {
+        trace_pcache_readahead_fail(ret, node->common.offset,
+                                    node->common.bytes);
         rbcache_remove(s->cache, &node->common);
     }
 
     QTAILQ_FOREACH_SAFE(rlink, &node->wait_list, entry, next) {
         QTAILQ_REMOVE(&node->wait_list, rlink, entry);
         rlink->ret = ret;
+
+        trace_pcache_readahead_pending_node_complete(ret, node->common.offset,
+            node->common.bytes, offset, bytes);
+
         qemu_coroutine_enter(rlink->co);
     }
 
@@ -509,6 +516,10 @@ static int pickup_parts_of_cache(BlockDriverState *bs, PCacheNode *node,
                 ret = part->rlink.ret;
             }
         }
+        if (part->rlink.ret < 0) {
+            trace_pcache_read_part_fail(ret, part->node->common.offset,
+                                        part->node->common.bytes);
+        }
         pcache_node_unref(part->node);
     }
 
@@ -618,6 +629,8 @@ static void pcache_write_through(BlockDriverState *bs, uint64_t offset,
 
         if (node->status & NODE_STATUS_COMPLETED) {
             write_cache_data(node, offset, bytes, qiov);
+            trace_pcache_write_through(offset, bytes, node->common.offset,
+                                       node->common.bytes);
         }
     } while (end_offs > chunk_offset);
 
@@ -631,6 +644,8 @@ static void pcache_write_through(BlockDriverState *bs, uint64_t offset,
             continue;
         }
         write_cache_data(node, offset, bytes, qiov);
+        trace_pcache_write_through_removed_node(offset, bytes,
+                node->common.offset, node->common.bytes);
     }
 }
 
@@ -663,6 +678,9 @@ static int pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
                                           PCACHE_DEFAULT_READAHEAD_SIZE);
     QLIST_INIT(&s->remove_node_list);
 
+    trace_pcache_state_init(stats_size, s->max_aio_size, cache_size,
+                            s->readahead_size);
+
     if (s->readahead_size < s->max_aio_size) {
         error_report("Readahead size can't be less than maximum request size"
                      "that can be handled by pcache");
@@ -704,6 +722,8 @@ static void pcache_close(BlockDriverState *bs)
 {
     BDRVPCacheState *s = bs->opaque;
 
+    trace_pcache_close(s->req_stats, s->cache);
+
     rbcache_destroy(s->req_stats);
     rbcache_destroy(s->cache);
 
diff --git a/block/trace-events b/block/trace-events
index cfc05f2478..d9cef3bcec 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -112,3 +112,13 @@ qed_aio_write_data(void *s, void *acb, int ret, uint64_t offset, size_t len) "s
 qed_aio_write_prefill(void *s, void *acb, uint64_t start, size_t len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
 qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t offset) "s %p acb %p start %"PRIu64" len %zu offset %"PRIu64
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
+
+# block/pcache.c
+pcache_readahead_fail(int ret, uint64_t offset, uint64_t bytes) "ret: %d offset: %"PRIu64" bytes: %"PRIu64
+pcache_readahead_pending_node_complete(int ret, uint64_t node_offset, uint64_t node_bytes, uint64_t read_offset, uint64_t read_bytes) "ret: %d node: %"PRIu64" %"PRIu64" pending read: %"PRIu64" %"PRIu64
+pcache_aio_read_cb_fail(int ret, uint64_t offset, uint64_t bytes) "ret: %d offset: %"PRIu64" bytes: %"PRIu64
+pcache_read_part_fail(int ret, uint64_t offset, uint64_t bytes) "ret: %d offset: %"PRIu64" bytes: %"PRIu64
+pcache_write_through(uint64_t req_offset, uint64_t req_bytes, uint64_t node_offset, uint64_t node_bytes) "request: %"PRIu64" %"PRIu64" node: %"PRIu64" %"PRIu64
+pcache_write_through_removed_node(uint64_t req_offset, uint64_t req_bytes, uint64_t node_offset, uint64_t node_bytes) "request: %"PRIu64" %"PRIu64" node: %"PRIu64" %"PRIu64
+pcache_state_init(uint64_t stats_size, uint64_t max_aio_size, uint64_t cache_size, uint64_t readahead_size) "pool statistics size: %"PRIu64" max aio size: %"PRIu64" cache size: %"PRIu64" readahead size: %"PRIu64
+pcache_close(void *req_stats, void *cache) "pool statistics: %p cache: %p"
-- 
2.11.0
