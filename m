Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006ah-VF
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchU-0006hM-Ox
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:20 +0300
Message-Id: <20181011151623.25702-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181011151623.25702-1-vsementsov@virtuozzo.com>
References: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 5/8] block/qcow2-refcount:
 check_refcounts_l2: don't count corrupted entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Misaligned entries will lead to fatal qcow2 driver corruption on read
or write to corresponding offset, so there is no sense to take them
into account.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 8fb9c9af39..3b34681f16 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1634,15 +1634,6 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
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
@@ -1681,9 +1672,6 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                              * L2 table's entries */
                         } else {
                             res->corruptions_fixed++;
-                            /* Skip marking the cluster as used
-                             * (it is unused now) */
-                            continue;
                         }
                     } else {
                         res->corruptions++;
@@ -1693,6 +1681,19 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         "not properly aligned; L2 entry corrupted.\n", offset);
                     res->corruptions++;
                 }
+
+                /* Skip marking the cluster as used
+                 * (l2 entry is marked as zero or still fatally corrupted) */
+                continue;
+            }
+
+            if (flags & CHECK_FRAG_INFO) {
+                res->bfi.allocated_clusters++;
+                if (next_contiguous_offset &&
+                    offset != next_contiguous_offset) {
+                    res->bfi.fragmented_clusters++;
+                }
+                next_contiguous_offset = offset + s->cluster_size;
             }
 
             /* Mark cluster as used */
-- 
2.18.0
