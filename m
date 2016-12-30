Received: from eggs.gnu.org ([2001:4830:134:3::10]:42781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN4KP-0000a4-IU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 16:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN4KK-0002Hv-MN
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 16:03:05 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:37 +0300
Message-ID: <20161230143142.18214-14-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 13/18] block/pcache: write through
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

Write-through is another way to keep the cache up-to-date. Even if this
case will be rare, write to the cache is more optimal than drop-cache.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/pcache.c b/block/pcache.c
index c1cbfa7040..140f90d6d7 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -410,8 +410,26 @@ skip_large_request:
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
-static void pcache_invalidation(BlockDriverState *bs, uint64_t offset,
-                                uint64_t bytes)
+static void write_cache_data(PCacheNode *node, uint64_t offset, uint64_t bytes,
+                             QEMUIOVector *qiov)
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
+    copy = qemu_iovec_to_buf(qiov, qiov_offs, node->data + node_offs, size);
+    assert(copy == size);
+}
+
+static void pcache_write_through(BlockDriverState *bs, uint64_t offset,
+                                 uint64_t bytes, QEMUIOVector *qiov)
 {
     BDRVPCacheState *s = bs->opaque;
     uint64_t chunk_offset = offset, chunk_bytes = bytes;
@@ -429,7 +447,7 @@ static void pcache_invalidation(BlockDriverState *bs, uint64_t offset,
         chunk_bytes = end_offs - chunk_offset;
 
         if (node->status & NODE_STATUS_COMPLETED) {
-            rbcache_remove(s->cache, &node->common);
+            write_cache_data(node, offset, bytes, qiov);
         }
     } while (end_offs > chunk_offset);
 }
@@ -442,7 +460,7 @@ static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
     if (ret < 0) {
         return ret;
     }
-    pcache_invalidation(bs, offset, bytes);
+    pcache_write_through(bs, offset, bytes, qiov);
 
     return ret;
 }
-- 
2.11.0
