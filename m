Received: from eggs.gnu.org ([2001:4830:134:3::10]:49490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzg6-0002EY-PU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMzg3-00038M-FP
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 11:05:10 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:34 +0300
Message-ID: <20161230143142.18214-11-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 10/18] block/pcache: cache invalidation on
 write requests
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

In AIO write request completion we just drop all the intersecting nodes in the
cache, it's a simple way to keep the cache up-to-date.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/block/pcache.c b/block/pcache.c
index f30e9e7bfe..4007241d37 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -314,11 +314,41 @@ skip_large_request:
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
+static void pcache_invalidation(BlockDriverState *bs, uint64_t offset,
+                                uint64_t bytes)
+{
+    BDRVPCacheState *s = bs->opaque;
+    uint64_t chunk_offset = offset, chunk_bytes = bytes;
+    uint64_t end_offs = offset + bytes;
+
+    do {
+        PCacheNode *node = rbcache_search(s->cache, chunk_offset, chunk_bytes);
+        if (node == NULL) {
+            break;
+        }
+        assert(node->status == NODE_STATUS_COMPLETED ||
+               node->status == NODE_STATUS_INFLIGHT);
+
+        chunk_offset = node->common.offset + node->common.bytes;
+        chunk_bytes = end_offs - chunk_offset;
+
+        if (node->status & NODE_STATUS_COMPLETED) {
+            rbcache_remove(s->cache, &node->common);
+        }
+    } while (end_offs > chunk_offset);
+}
+
 static coroutine_fn int pcache_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                           uint64_t bytes, QEMUIOVector *qiov,
                                           int flags)
 {
-    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+    int ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
+    if (ret < 0) {
+        return ret;
+    }
+    pcache_invalidation(bs, offset, bytes);
+
+    return ret;
 }
 
 static void pcache_state_init(QemuOpts *opts, BDRVPCacheState *s)
-- 
2.11.0
