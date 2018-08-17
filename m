Received: from eggs.gnu.org ([2001:4830:134:3::10]:34809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlw-0004J2-37
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlu-0004VF-15
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:31 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:16 +0300
Message-Id: <20180817122219.16206-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/7] block/qcow2-refcount:
 check_refcounts_l2: reduce ignored overlaps
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

Reduce number of structures ignored in overlap check: when checking
active table ignore active tables, when checking inactive table ignore
inactive ones.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0ea01e3ee2..3b057b635d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1565,7 +1565,7 @@ enum {
 static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                               void **refcount_table,
                               int64_t *refcount_table_size, int64_t l2_offset,
-                              int flags, BdrvCheckMode fix)
+                              int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_table, l2_entry;
@@ -1654,11 +1654,12 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                     if (fix & BDRV_FIX_ERRORS) {
                         uint64_t l2e_offset =
                             l2_offset + (uint64_t)i * sizeof(uint64_t);
+                        int ign = active ? QCOW2_OL_ACTIVE_L2 :
+                                           QCOW2_OL_INACTIVE_L2;
 
                         l2_entry = QCOW_OFLAG_ZERO;
                         l2_table[i] = cpu_to_be64(l2_entry);
-                        ret = qcow2_pre_write_overlap_check(bs,
-                                QCOW2_OL_ACTIVE_L2 | QCOW2_OL_INACTIVE_L2,
+                        ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, sizeof(uint64_t));
                         if (ret < 0) {
                             fprintf(stderr, "ERROR: Overlap check failed\n");
@@ -1732,7 +1733,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
                               void **refcount_table,
                               int64_t *refcount_table_size,
                               int64_t l1_table_offset, int l1_size,
-                              int flags, BdrvCheckMode fix)
+                              int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l1_table = NULL, l2_offset, l1_size2;
@@ -1788,7 +1789,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
             /* Process and check L2 entries */
             ret = check_refcounts_l2(bs, res, refcount_table,
                                      refcount_table_size, l2_offset, flags,
-                                     fix);
+                                     fix, active);
             if (ret < 0) {
                 goto fail;
             }
@@ -2074,7 +2075,7 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     /* current L1 table */
     ret = check_refcounts_l1(bs, res, refcount_table, nb_clusters,
                              s->l1_table_offset, s->l1_size, CHECK_FRAG_INFO,
-                             fix);
+                             fix, true);
     if (ret < 0) {
         return ret;
     }
@@ -2097,7 +2098,8 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
         ret = check_refcounts_l1(bs, res, refcount_table, nb_clusters,
-                                 sn->l1_table_offset, sn->l1_size, 0, fix);
+                                 sn->l1_table_offset, sn->l1_size, 0, fix,
+                                 false);
         if (ret < 0) {
             return ret;
         }
-- 
2.11.1
