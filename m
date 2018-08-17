Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlv-0004J0-TZ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlq-0004Sn-Po
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:31 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:13 +0300
Message-Id: <20180817122219.16206-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/7] block/qcow2-refcount: fix
 check_oflag_copied
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

Increase corruptions_fixed only after successful fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3c539f02e5..615847eb09 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1816,7 +1816,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0; i < s->l1_size; i++) {
         uint64_t l1_entry = s->l1_table[i];
         uint64_t l2_offset = l1_entry & L1E_OFFSET_MASK;
-        bool l2_dirty = false;
+        int l2_fixed_entries = 0;
 
         if (!l2_offset) {
             continue;
@@ -1878,8 +1878,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                         l2_table[j] = cpu_to_be64(refcount == 1
                                     ? l2_entry |  QCOW_OFLAG_COPIED
                                     : l2_entry & ~QCOW_OFLAG_COPIED);
-                        l2_dirty = true;
-                        res->corruptions_fixed++;
+                        l2_fixed_entries++;
                     } else {
                         res->corruptions++;
                     }
@@ -1887,7 +1886,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
             }
         }
 
-        if (l2_dirty) {
+        if (l2_fixed_entries > 0) {
             ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
                                                 l2_offset, s->cluster_size);
             if (ret < 0) {
@@ -1905,6 +1904,7 @@ static int check_oflag_copied(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 goto fail;
             }
+            res->corruptions_fixed += l2_fixed_entries;
         }
     }
 
-- 
2.11.1
