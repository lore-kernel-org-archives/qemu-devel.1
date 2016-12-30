Received: from eggs.gnu.org ([2001:4830:134:3::10]:34844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN3QC-0006UU-5i
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 15:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cN3Q8-00015A-VG
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 15:05:00 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:33 +0300
Message-ID: <20161230143142.18214-10-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 09/18] block/pcache: skip readahead for
 unallocated clusters
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

Typically, data for unallocated clusters is filled with zeros, so it makes no
sense to store it in the cache.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/pcache.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/pcache.c b/block/pcache.c
index 57eebd434a..f30e9e7bfe 100644
--- a/block/pcache.c
+++ b/block/pcache.c
@@ -174,6 +174,28 @@ static RBCacheNode *pcache_node_alloc(uint64_t offset, uint64_t bytes,
     return &node->common;
 }
 
+static bool check_allocated_clusters(BlockDriverState *bs, uint64_t offset,
+                                     uint64_t bytes)
+{
+    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
+    int32_t nb_sectors = bytes >> BDRV_SECTOR_BITS;
+
+    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+
+    do {
+        int num, ret = bdrv_is_allocated(bs, sector_num, nb_sectors, &num);
+        if (ret <= 0) {
+            return false;
+        }
+        sector_num += num;
+        nb_sectors -= num;
+
+    } while (nb_sectors);
+
+    return true;
+}
+
 #define PCACHE_STEPS_FORWARD 2
 
 static PCacheNode *get_readahead_node(BlockDriverState *bs, RBCache *rbcache,
@@ -193,6 +215,10 @@ static PCacheNode *get_readahead_node(BlockDriverState *bs, RBCache *rbcache,
             break;
         }
 
+        if (!check_allocated_clusters(bs, offset, bytes)) {
+            break;
+        }
+
         node = rbcache_search_and_insert(rbcache, offset, bytes);
         if (node->status == NODE_STATUS_NEW) {
             return node;
-- 
2.11.0
