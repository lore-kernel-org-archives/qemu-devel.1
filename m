Received: from eggs.gnu.org ([2001:4830:134:3::10]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmD-0006Fm-Rf
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmC-0000XI-75
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:24 +0200
Message-Id: <1499447335-6125-70-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 069/100] qcow2-refcount: rename inc_refcounts()
 and make it public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is needed for the following patch, which will introduce refcounts
checking for qcow2 bitmaps.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20170628120530.31251-8-vsementsov@virtuozzo.com
[mreitz: s/inc_refcounts/qcow2_inc_refcounts_imrt/ in one more (new)
         place]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 59 ++++++++++++++++++++++++++------------------------
 block/qcow2.h          |  4 ++++
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 81c22e6..8add3d5 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1323,11 +1323,10 @@ static int realloc_refcount_array(BDRVQcow2State *s, void **array,
  *
  * Modifies the number of errors in res.
  */
-static int inc_refcounts(BlockDriverState *bs,
-                         BdrvCheckResult *res,
-                         void **refcount_table,
-                         int64_t *refcount_table_size,
-                         int64_t offset, int64_t size)
+int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
+                             void **refcount_table,
+                             int64_t *refcount_table_size,
+                             int64_t offset, int64_t size)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start, last, cluster_offset, k, refcount;
@@ -1420,8 +1419,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             nb_csectors = ((l2_entry >> s->csize_shift) &
                            s->csize_mask) + 1;
             l2_entry &= s->cluster_offset_mask;
-            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
-                                l2_entry & ~511, nb_csectors * 512);
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           l2_entry & ~511, nb_csectors * 512);
             if (ret < 0) {
                 goto fail;
             }
@@ -1454,8 +1454,9 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             }
 
             /* Mark cluster as used */
-            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
-                                offset, s->cluster_size);
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           offset, s->cluster_size);
             if (ret < 0) {
                 goto fail;
             }
@@ -1508,8 +1509,8 @@ static int check_refcounts_l1(BlockDriverState *bs,
     l1_size2 = l1_size * sizeof(uint64_t);
 
     /* Mark L1 table as used */
-    ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
-                        l1_table_offset, l1_size2);
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
+                                   l1_table_offset, l1_size2);
     if (ret < 0) {
         goto fail;
     }
@@ -1538,8 +1539,9 @@ static int check_refcounts_l1(BlockDriverState *bs,
         if (l2_offset) {
             /* Mark L2 table as used */
             l2_offset &= L1E_OFFSET_MASK;
-            ret = inc_refcounts(bs, res, refcount_table, refcount_table_size,
-                                l2_offset, s->cluster_size);
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           l2_offset, s->cluster_size);
             if (ret < 0) {
                 goto fail;
             }
@@ -1757,14 +1759,15 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                 }
 
                 res->corruptions_fixed++;
-                ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                                    offset, s->cluster_size);
+                ret = qcow2_inc_refcounts_imrt(bs, res,
+                                               refcount_table, nb_clusters,
+                                               offset, s->cluster_size);
                 if (ret < 0) {
                     return ret;
                 }
                 /* No need to check whether the refcount is now greater than 1:
                  * This area was just allocated and zeroed, so it can only be
-                 * exactly 1 after inc_refcounts() */
+                 * exactly 1 after qcow2_inc_refcounts_imrt() */
                 continue;
 
 resize_fail:
@@ -1779,8 +1782,8 @@ resize_fail:
         }
 
         if (offset != 0) {
-            ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                                offset, s->cluster_size);
+            ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                           offset, s->cluster_size);
             if (ret < 0) {
                 return ret;
             }
@@ -1820,8 +1823,8 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     }
 
     /* header */
-    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                        0, s->cluster_size);
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                   0, s->cluster_size);
     if (ret < 0) {
         return ret;
     }
@@ -1842,25 +1845,25 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
     }
-    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                        s->snapshots_offset, s->snapshots_size);
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                   s->snapshots_offset, s->snapshots_size);
     if (ret < 0) {
         return ret;
     }
 
     /* refcount data */
-    ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                        s->refcount_table_offset,
-                        s->refcount_table_size * sizeof(uint64_t));
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                   s->refcount_table_offset,
+                                   s->refcount_table_size * sizeof(uint64_t));
     if (ret < 0) {
         return ret;
     }
 
     /* encryption */
     if (s->crypto_header.length) {
-        ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
-                            s->crypto_header.offset,
-                            s->crypto_header.length);
+        ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, nb_clusters,
+                                       s->crypto_header.offset,
+                                       s->crypto_header.length);
         if (ret < 0) {
             return ret;
         }
diff --git a/block/qcow2.h b/block/qcow2.h
index 84c9853..a272a39 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -544,6 +544,10 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
                                  int64_t size);
 int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
                                   int64_t size);
+int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
+                             void **refcount_table,
+                             int64_t *refcount_table_size,
+                             int64_t offset, int64_t size);
 
 int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
-- 
1.8.3.1
