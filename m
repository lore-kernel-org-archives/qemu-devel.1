Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybs-0003x1-AK
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0Ybr-0000HH-FG
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:20:52 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 26 Mar 2018 22:20:37 +0200
Message-Id: <20180326202039.21070-3-mreitz@redhat.com>
In-Reply-To: <20180326202039.21070-1-mreitz@redhat.com>
References: <20180326202039.21070-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] qcow2: fix bitmaps loading when bitmaps
 already exist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On reopen with existing bitmaps, instead of loading bitmaps, lets
reopen them if needed. This also fixes bitmaps migration through
shared storage.
Consider the case. Persistent bitmaps are stored on bdrv_inactivate.
Then, on destination process_incoming_migration_bh() calls
bdrv_invalidate_cache_all() which leads to
qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps are
already loaded on destination start.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180320170521.32152-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cf4f3becae..486f3e83b7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1480,7 +1480,22 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
     }
 
-    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
+    if (bdrv_dirty_bitmap_next(bs, NULL)) {
+        /* It's some kind of reopen with already existing dirty bitmaps. There
+         * are no known cases where we need loading bitmaps in such situation,
+         * so it's safer don't load them.
+         *
+         * Moreover, if we have some readonly bitmaps and we are reopening for
+         * rw we should reopen bitmaps correspondingly.
+         */
+        if (bdrv_has_readonly_bitmaps(bs) &&
+            !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
+        {
+            bool header_updated = false;
+            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
+            update_header = update_header && !header_updated;
+        }
+    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
         update_header = false;
     }
     if (local_err != NULL) {
-- 
2.14.3
