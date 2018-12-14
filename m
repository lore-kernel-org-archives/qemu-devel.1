Received: from eggs.gnu.org ([2001:4830:134:3::10]:45503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnjv-0000vG-UO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnju-0005jh-V1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:42:40 +0300
Message-Id: <20181214134240.217870-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-1-vsementsov@virtuozzo.com>
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 5/5] qcow2-refcount: don't mask corruptions
 under internal errors
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

No reasons for not reporting found corruptions as corruptions in case
of some internal errors, especially in case of just failed to fix l2
entry (and in this case, missed corruptions may influence comparing
logic, when we calculate difference between corruptions fields of two
results)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 8da0e91dd3..b0e006e628 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1639,6 +1639,8 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                res->corruptions++;
+
                 if (qcow2_get_cluster_type(l2_entry) ==
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
@@ -1674,18 +1676,16 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
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
 
@@ -1854,6 +1854,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
         if ((refcount == 1) != ((l1_entry & QCOW_OFLAG_COPIED) != 0)) {
+            res->corruptions++;
             fprintf(stderr, "%s OFLAG_COPIED L2 cluster: l1_index=%d "
                     "l1_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
                     repair ? "Repairing" : "ERROR", i, l1_entry, refcount);
@@ -1866,9 +1867,8 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                     res->check_errors++;
                     goto fail;
                 }
+                res->corruptions--;
                 res->corruptions_fixed++;
-            } else {
-                res->corruptions++;
             }
         }
 
@@ -1899,19 +1899,16 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                     fprintf(stderr, "%s OFLAG_COPIED data cluster: "
                             "l2_entry=%" PRIx64 " refcount=%" PRIu64 "\n",
                             repair ? "Repairing" : "ERROR", l2_entry, refcount);
-                    if (repair) {
-                        l2_table[j] = cpu_to_be64(refcount == 1
-                                    ? l2_entry |  QCOW_OFLAG_COPIED
-                                    : l2_entry & ~QCOW_OFLAG_COPIED);
-                        l2_dirty++;
-                    } else {
-                        res->corruptions++;
-                    }
+                    l2_table[j] = cpu_to_be64(refcount == 1
+                                ? l2_entry |  QCOW_OFLAG_COPIED
+                                : l2_entry & ~QCOW_OFLAG_COPIED);
+                    l2_dirty++;
                 }
             }
         }
 
-        if (l2_dirty > 0) {
+        res->corruptions += l2_dirty;
+        if (repair && l2_dirty > 0) {
             ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
                                                 l2_offset, s->cluster_size);
             if (ret < 0) {
@@ -1929,6 +1926,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions -= l2_dirty;
             res->corruptions_fixed += l2_dirty;
         }
     }
@@ -1967,6 +1965,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
         }
 
         if (cluster >= *nb_clusters) {
+            res->corruptions++;
             fprintf(stderr, "%s refcount block %" PRId64 " is outside image\n",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
 
@@ -2006,6 +2005,7 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
                     goto resize_fail;
                 }
 
+                res->corruptions--;
                 res->corruptions_fixed++;
                 ret = qcow2_inc_refcounts_imrt(bs, res,
                                                refcount_table, nb_clusters,
@@ -2019,12 +2019,9 @@ static int check_refblocks(BlockDriverState *bs, BdrvCheckResult *res,
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
