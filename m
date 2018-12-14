Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnk0-00014I-C6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnju-0005jV-RN
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:42:39 +0300
Message-Id: <20181214134240.217870-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-1-vsementsov@virtuozzo.com>
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 4/5] qcow2-refcount: check_refcounts_l2:
 don't count fixed cluster as allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Do not count a cluster which is fixed to be ZERO as allocated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e76085d9aa..8da0e91dd3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1637,15 +1637,6 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
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
@@ -1698,6 +1689,15 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
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
