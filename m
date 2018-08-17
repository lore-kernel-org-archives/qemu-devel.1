Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlw-0004J4-3G
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlt-0004UO-2f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:31 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:15 +0300
Message-Id: <20180817122219.16206-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/7] block/qcow2-refcount:
 check_refcounts_l2: refactor compressed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Separate offset and size of compressed cluster.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 566c19fbfa..0ea01e3ee2 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1570,7 +1570,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_table, l2_entry;
     uint64_t next_contiguous_offset = 0;
-    int i, l2_size, nb_csectors, ret;
+    int i, l2_size, ret;
 
     /* Read L2 table from disk */
     l2_size = s->l2_size * sizeof(uint64_t);
@@ -1589,6 +1589,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
         switch (qcow2_get_cluster_type(l2_entry)) {
         case QCOW2_CLUSTER_COMPRESSED:
+        {
+            int64_t csize, coffset;
+
             /* Compressed clusters don't have QCOW_OFLAG_COPIED */
             if (l2_entry & QCOW_OFLAG_COPIED) {
                 fprintf(stderr, "ERROR: coffset=0x%" PRIx64 ": "
@@ -1599,12 +1602,13 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             }
 
             /* Mark cluster as used */
-            nb_csectors = ((l2_entry >> s->csize_shift) &
-                           s->csize_mask) + 1;
-            l2_entry &= s->cluster_offset_mask;
+            csize = (((l2_entry >> s->csize_shift) & s->csize_mask) + 1) *
+                    BDRV_SECTOR_SIZE;
+            coffset = l2_entry & s->cluster_offset_mask &
+                      ~(BDRV_SECTOR_SIZE - 1);
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
-                                           l2_entry & ~511, nb_csectors * 512);
+                                           coffset, csize);
             if (ret < 0) {
                 goto fail;
             }
@@ -1621,6 +1625,7 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                 res->bfi.fragmented_clusters++;
             }
             break;
+        }
 
         case QCOW2_CLUSTER_ZERO_ALLOC:
         case QCOW2_CLUSTER_NORMAL:
-- 
2.11.1
