Received: from eggs.gnu.org ([209.51.188.92]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzUt-00057D-KM
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzIn-0003sq-6J
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:13 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 16:14:32 +0300
Message-Id: <20190227131433.197063-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 4/5] qcow2-refcount: check_refcounts_l2:
 don't count fixed cluster as allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, vsementsov@virtuozzo.com

Do not count a cluster which is fixed to be ZERO as allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 00a922edfa..35a9d943f2 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1641,15 +1641,6 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
         {
             uint64_t offset = l2_entry & L2E_OFFSET_MASK;
 
-            if (flags & CHECK_FRAG_INFO) {
-                res->bfi.allocated_clusters++;
-                if (next_contiguous_offset &&
-                    offset != next_contiguous_offset) {
-                    res->bfi.fragmented_clusters++;
-                }
-                next_contiguous_offset = offset + s->cluster_size;
-            }
-
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
                 if (qcow2_get_cluster_type(l2_entry) ==
@@ -1702,6 +1693,15 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                 }
             }
 
+            if (flags & CHECK_FRAG_INFO) {
+                res->bfi.allocated_clusters++;
+                if (next_contiguous_offset &&
+                    offset != next_contiguous_offset) {
+                    res->bfi.fragmented_clusters++;
+                }
+                next_contiguous_offset = offset + s->cluster_size;
+            }
+
             /* Mark cluster as used */
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
-- 
2.18.0
