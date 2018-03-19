Received: from eggs.gnu.org ([2001:4830:134:3::10]:52562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgY-0008L5-1X
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgU-0007Lu-S5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 19 Mar 2018 12:02:22 +0300
Message-Id: <20180319090223.23336-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-1-vsementsov@virtuozzo.com>
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Consider migration with shared storage. Persistent bitmaps are stored
on bdrv_inactivate. Then, on destination
process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
are already loaded on destination start. In this case we should call
qcow2_reopen_bitmaps_rw instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7472af6931..6219666d4a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1480,7 +1480,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        if (!bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
+            bool header_updated = false;
+            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
+            update_header = update_header && !header_updated;
+        }
+    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
         update_header = false;
     }
     if (local_err != NULL) {
-- 
2.11.1
