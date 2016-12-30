Received: from eggs.gnu.org ([2001:4830:134:3::10]:40686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMylA-0001NH-8N
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyl5-0001sh-Sy
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:06:19 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:31 +0300
Message-ID: <20161230143142.18214-8-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 07/18] block/pcache: updating statistics for
 overlapping requests
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

When updating the statistics sometimes i/O requests can overlap each other,
in this case the requests are not stored in the statistics. It's not very good,
especially when the requests have a small range of intersection.

We can cut the requests in the intersection and add the pieces of requests in
the statistics. Maybe not significantly, but it can make the statistics more
accurate. Here, update_req_stats() adds the ability to save overlapping
requests.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/pcache.c b/block/pcache.c
index 1f3200af63..deac57c58d 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -46,6 +46,40 @@ typedef struct BDRVPCacheState {
     uint64_t max_aio_size;
 } BDRVPCacheState;
 
+static void update_req_stats(RBCache *rbcache, uint64_t offset, uint64_t bytes)
+{
+    do {
+        RBCacheNode *node = rbcache_search_and_insert(rbcache, offset, bytes);
+        /* The node was successfully added or already exists */
+        if (node->offset <= offset &&
+            node->offset + node->bytes >= offset + bytes)
+        {
+            break;
+        }
+
+        /* Request covers the whole node */
+        if (offset <= node->offset &&
+            offset + bytes >= node->offset + node->bytes)
+        {
+            rbcache_remove(rbcache, node);
+            continue;
+        }
+
+        if (offset < node->offset) {
+            RBCacheNode *new_node =
+                rbcache_node_alloc(rbcache, offset, node->offset - offset);
+            if (new_node != rbcache_insert(rbcache, new_node)) {
+                /* The presence of the node in this range is impossible */
+                abort();
+            }
+            break;
+        }
+
+        bytes = (offset + bytes) - (node->offset + node->bytes);
+        offset = node->offset + node->bytes;
+    } while (true);
+}
+
 static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -53,7 +87,7 @@ static coroutine_fn int pcache_co_preadv(BlockDriverState *bs, uint64_t offset,
     BDRVPCacheState *s = bs->opaque;
 
     if (s->max_aio_size >= bytes) {
-        rbcache_search_and_insert(s->req_stats, offset, bytes);
+        update_req_stats(s->req_stats, offset, bytes);
     }
 
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
-- 
2.11.0
