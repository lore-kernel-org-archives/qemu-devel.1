Received: from eggs.gnu.org ([209.51.188.92]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzUt-00057B-Nm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzIk-0003r5-1P
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 16:14:33 +0300
Message-Id: <20190227131433.197063-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 5/5] qcow2-refcount: don't mask corruptions
 under internal errors
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

No reasons for not reporting found corruptions as corruptions in case
of some internal errors, especially in case of just failed to fix l2
entry (and in this case, missed corruptions may influence comparing
logic, when we calculate difference between corruptions fields of two
results)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 35a9d943f2..55dad70a2a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1643,6 +1643,8 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                res->corruptions++;
+
                 if (qcow2_get_cluster_type(l2_entry) ==
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
@@ -1678,18 +1680,16 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                             /* Do not abort, continue checking the rest of this
                              * L2 table's entries */
                         } else {
+                            res->corruptions--;
                             res->corruptions_fixed++;
                             /* Skip marking the cluster as used
                              * (it is unused now) */
                             continue;
                         }
-                    } else {
-                        res->corruptions++;
                     }
                 } else {
                     fprintf(stderr, "ERROR offset=%" PRIx64 ": Data cluster is "
                         "not properly aligned; L2 entry corrupted.\n", offset);
-                    res->corruptions++;
                 }
             }
 
@@ -1858,6 +1858,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
         if ((refcount == 1) != ((l1_entry & QCOW_OFLAG_COPIED) != 0)) {
+            res->corruptions++;
             fprintf(stderr, "%s OFLAG_COPIED L2 cluster: l1_index=%d "
                     "l1_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
                     repair ? "Repairing" : "ERROR", i, l1_entry, refcount);
@@ -1870,9 +1871,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                     res->check_errors++;
                     goto fail;
                 }
+                res->corruptions--;
                 res->corruptions_fixed++;
-            } else {
-                res->corruptions++;
             }
         }
 
@@ -1900,6 +1900,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                     continue;
                 }
                 if ((refcount == 1) != ((l2_entry & QCOW_OFLAG_COPIED) != 0)) {
+                    res->corruptions++;
                     fprintf(stderr, "%s OFLAG_COPIED data cluster: "
                             "l2_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
                             repair ? "Repairing" : "ERROR", l2_entry, refcount);
@@ -1908,8 +1909,6 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
                         l2_dirty++;
-                    } else {
-                        res->corruptions++;
                     }
                 }
             }
@@ -1933,6 +1932,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions -= l2_dirty;
             res->corruptions_fixed += l2_dirty;
         }
     }
@@ -1971,6 +1971,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
         }
 
         if (cluster >= *nb_clusters) {
+            res->corruptions++;
             fprintf(stderr, "%s refcount block %" PRId64 " is outside image\n",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
 
@@ -2010,6 +2011,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                     goto resize_fail;
                 }
 
+                res->corruptions--;
                 res->corruptions_fixed++;
                 ret = qcow2_inc_refcounts_imrt(bs, res,
                                                refcount_table, nb_clusters,
@@ -2023,12 +2025,9 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                 continue;
 
 resize_fail:
-                res->corruptions++;
                 *rebuild = true;
                 fprintf(stderr, "ERROR could not resize image: %s\n",
                         strerror(-ret));
-            } else {
-                res->corruptions++;
             }
             continue;
         }
-- 
2.18.0
