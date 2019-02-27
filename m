Received: from eggs.gnu.org ([209.51.188.92]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzUr-0005eA-DE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyzIw-0003ws-QN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 16:14:29 +0300
Message-Id: <20190227131433.197063-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-1-vsementsov@virtuozzo.com>
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/5] qcow2-refcount: fix check_oflag_copied
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

Increase corruptions_fixed only after successful fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 6f13d470d3..16e8942343 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1825,7 +1825,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0; i < s->l1_size; i++) {
         uint64_t l1_entry = s->l1_table[i];
         uint64_t l2_offset = l1_entry & L1E_OFFSET_MASK;
-        bool l2_dirty = false;
+        int l2_dirty = 0;
 
         if (!l2_offset) {
             continue;
@@ -1887,8 +1887,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                         l2_table[j] = cpu_to_be64(refcount == 1
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
-                        l2_dirty = true;
-                        res->corruptions_fixed++;
+                        l2_dirty++;
                     } else {
                         res->corruptions++;
                     }
@@ -1896,7 +1895,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             }
         }
 
-        if (l2_dirty) {
+        if (l2_dirty > 0) {
             ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
                                                 l2_offset, s->cluster_size);
             if (ret < 0) {
@@ -1914,6 +1913,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions_fixed += l2_dirty;
         }
     }
 
-- 
2.18.0
