Received: from eggs.gnu.org ([2001:4830:134:3::10]:40614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMykt-0001A7-86
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMykp-0001l2-0C
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:03 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:39 +0300
Message-ID: <20161230143142.18214-16-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 15/18] block/pcache: pick up parts of the
 cache
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

Provided that the request size is less than the readahead size, a partial cache
hit can occur in the following three cases:
1. The request covers the bottom part of the node
2. The request covers the upper part of the node
3. The request is between two nodes and partially covers both of them

The function pickup_parts_of_cache() covers all three cases and for the
uncached part of the request it creates a new request.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 8 deletions(-)

diff --git a/block/pcache.c b/block/pcache.c
index 86b28de44b..3f89e40b05 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
@@ -355,6 +356,153 @@ static void pcache_readahead_entry(void *opaque)
                         readahead_co->bytes);
 }
 
+/*
+ * Provided that the request size is less or equal than the readahead size,
+ * a partial cache hit can occur in the following three cases:
+ * 1. The request covers the bottom part of the node.
+ * 2. The request covers the upper part of the node.
+ * 3. The request is between two nodes and partially covers both of them.
+ *
+ * Therefore, the request can be divided into no more than 3 parts.
+ */
+#define PCACHE_MAX_FRAGMENT_NUM 3
+
+typedef struct PartReqEntry {
+    ReqLinkEntry rlink;
+    PCacheNode *node;
+} PartReqEntry;
+
+typedef struct PartReqDesc {
+    Coroutine *co;
+    PartReqEntry parts[PCACHE_MAX_FRAGMENT_NUM];
+    uint32_t cnt;
+    uint32_t completed;
+} PartReqDesc;
+
+typedef struct PCachePartReqCo {
+    BlockDriverState *bs;
+    uint64_t offset;
+    uint64_t bytes;
+    PartReqDesc *desc;
+} PCachePartReqCo;
+
+static void coroutine_fn pcache_co_part_req(BlockDriverState *bs,
+                                            uint64_t offset, uint64_t bytes,
+                                            PartReqDesc *req)
+{
+    BDRVPCacheState *s = bs->opaque;
+    QEMUIOVector qiov;
+    PartReqEntry *part = &req->parts[req->cnt];
+    PCacheNode *node = container_of(rbcache_node_alloc(s->cache, offset, bytes),
+                                    PCacheNode, common);
+    node->status = NODE_STATUS_INFLIGHT;
+    qemu_iovec_init(&qiov, 1);
+    qemu_iovec_add(&qiov, node->data, node->common.bytes);
+
+    part->node = node;
+    assert(++req->cnt <= PCACHE_MAX_FRAGMENT_NUM);
+
+    part->rlink.ret = bdrv_co_preadv(bs->file, offset, bytes, &qiov, 0);
+
+    node->status = NODE_STATUS_COMPLETED | NODE_STATUS_REMOVE;
+    QLIST_INSERT_HEAD(&s->remove_node_list, node, entry);
+
+    if (!qemu_coroutine_entered(req->co)) {
+        qemu_coroutine_enter(req->co);
+    } else {
+        req->completed++;
+    }
+}
+
+static void pcache_part_req_entry(void *opaque)
+{
+    PCachePartReqCo *req_co = opaque;
+
+    pcache_co_part_req(req_co->bs, req_co->offset, req_co->bytes, req_co->desc);
+}
+
+static int pickup_parts_of_cache(BlockDriverState *bs, PCacheNode *node,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov)
+{
+    BDRVPCacheState *s = bs->opaque;
+    PartReqDesc req = {
+        .co = qemu_coroutine_self(),
+    };
+    PCachePartReqCo req_co = {
+        .bs = bs,
+        .desc = &req
+    };
+    uint64_t chunk_offset = offset, chunk_bytes = bytes;
+    uint64_t up_size;
+    int ret = 0;
+
+    do {
+        pcache_node_ref(node);
+
+        if (chunk_offset < node->common.offset) {
+            Coroutine *co;
+
+            req_co.offset = chunk_offset;
+            req_co.bytes = up_size = node->common.offset - chunk_offset;
+
+            co = qemu_coroutine_create(pcache_part_req_entry, &req_co);
+            qemu_coroutine_enter(co);
+
+            chunk_offset += up_size;
+            chunk_bytes -= up_size;
+        }
+
+        req.parts[req.cnt].node = node;
+        if (node->status & NODE_STATUS_INFLIGHT) {
+            req.parts[req.cnt].rlink.co = qemu_coroutine_self();
+            QTAILQ_INSERT_HEAD(&node->wait_list,
+                               &req.parts[req.cnt].rlink, entry);
+        } else {
+            req.completed++;
+        }
+        assert(++req.cnt <= PCACHE_MAX_FRAGMENT_NUM);
+
+        up_size = MIN(node->common.offset + node->common.bytes - chunk_offset,
+                      chunk_bytes);
+        chunk_bytes -= up_size;
+        chunk_offset += up_size;
+
+        if (chunk_bytes != 0) {
+            node = rbcache_search(s->cache, chunk_offset, chunk_bytes);
+            if (node == NULL) {
+                Coroutine *co;
+
+                req_co.offset = chunk_offset;
+                req_co.bytes = chunk_bytes;
+
+                co = qemu_coroutine_create(pcache_part_req_entry, &req_co);
+                qemu_coroutine_enter(co);
+                chunk_bytes = 0;
+            }
+        }
+    } while (chunk_bytes != 0);
+
+    while (req.completed < req.cnt) {
+        qemu_coroutine_yield();
+        req.completed++;
+    }
+
+    while (req.cnt--) {
+        PartReqEntry *part = &req.parts[req.cnt];
+        if (ret == 0) {
+            if (part->rlink.ret == 0) {
+                read_cache_data_direct(part->node, offset, bytes, qiov);
+            } else {
+                ret = part->rlink.ret;
+            }
+        }
+        pcache_node_unref(part->node);
+    }
+
+    return ret;
+}
+
 enum {
     CACHE_MISS,
     CACHE_HIT,
@@ -364,6 +512,7 @@ static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
                               uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVPCacheState *s = bs->opaque;
+    int ret;
 
     PCacheNode *node = rbcache_search(s->cache, offset, bytes);
     if (node == NULL) {
@@ -374,14 +523,16 @@ static int pcache_lookup_data(BlockDriverState *bs, uint64_t offset,
     if (node->common.offset <= offset &&
         node->common.offset + node->common.bytes >= offset + bytes)
     {
-        int ret = read_cache_data(node, offset, bytes, qiov);
-        if (ret < 0) {
-            return ret;
-        }
-        return CACHE_HIT;
+        ret = read_cache_data(node, offset, bytes, qiov);
+
+    } else {
+        ret = pickup_parts_of_cache(bs, node, offset, bytes, qiov);
     }
 
-    return CACHE_MISS;
+    if (ret < 0) {
+        return ret;
+    }
+    return CACHE_HIT;
 }
 
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
@@ -484,7 +635,7 @@ static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
     return ret;
 }
 
-static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
+static int pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
 {
     uint64_t stats_size = qemu_opt_get_size(opts, PCACHE_OPT_STATS_SIZE,
                                             PCACHE_DEFAULT_STATS_SIZE);
@@ -499,6 +650,13 @@ static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
     s->readahead_size = qemu_opt_get_size(opts, PCACHE_OPT_READAHEAD_SIZE,
                                           PCACHE_DEFAULT_READAHEAD_SIZE);
     QLIST_INIT(&s->remove_node_list);
+
+    if (s->readahead_size < s->max_aio_size) {
+        error_report("Readahead size can't be less than maximum request size"
+                     "that can be handled by pcache");
+        return -ENOTSUP;
+    }
+    return 0;
 }
 
 static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
@@ -524,7 +682,7 @@ static int pcache_file_open(BlockDriverState *bs, QDict *options, int flags,
         error_propagate(errp, local_err);
         goto fail;
     }
-    pcache_state_init(opts, bs->opaque);
+    ret = pcache_state_init(opts, bs->opaque);
 fail:
     qemu_opts_del(opts);
     return ret;
-- 
2.11.0
