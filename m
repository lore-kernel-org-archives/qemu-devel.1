Received: from eggs.gnu.org ([2001:4830:134:3::10]:45480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnjv-0000uh-Eo
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXnju-0005jH-Nj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:42:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:42:36 +0300
Message-Id: <20181214134240.217870-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-1-vsementsov@virtuozzo.com>
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 1/5] qcow2-refcount: fix check_oflag_copied
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

Increase corruptions_fixed only after successful fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 1c63ac244a..b717fdecc6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1822,7 +1822,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0; i < s->l1_size; i++) {
         uint64_t l1_entry = s->l1_table[i];
         uint64_t l2_offset = l1_entry & L1E_OFFSET_MASK;
-        bool l2_dirty = false;
+        int l2_dirty = 0;
 
         if (!l2_offset) {
             continue;
@@ -1884,8 +1884,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                         l2_table[j] = cpu_to_be64(refcount == 1
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
-                        l2_dirty = true;
-                        res->corruptions_fixed++;
+                        l2_dirty++;
                     } else {
                         res->corruptions++;
                     }
@@ -1893,7 +1892,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             }
         }
 
-        if (l2_dirty) {
+        if (l2_dirty > 0) {
             ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
                                                 l2_offset, s->cluster_size);
             if (ret < 0) {
@@ -1911,6 +1910,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions_fixed += l2_dirty;
         }
     }
 
-- 
2.18.0
