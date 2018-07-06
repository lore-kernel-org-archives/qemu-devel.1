Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ7E-0006X3-Q1
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbQ7D-0000IU-3f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:45:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  6 Jul 2018 14:36:27 +0300
Message-Id: <20180706113630.25222-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180706113630.25222-1-vsementsov@virtuozzo.com>
References: <20180706113630.25222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/4] drity-bitmap: switch assert-fails to
 errors in bdrv_merge_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Move checks from qmp_x_block_dirty_bitmap_merge() to
bdrv_merge_dirty_bitmap(), to share them with dirty bitmap merge
transaction action in future commit.

Note: for now, only qmp_x_block_dirty_bitmap_merge() calls
bdrv_merge_dirty_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 15 +++++++++++++--
 blockdev.c           | 10 ----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c9b8a6fd52..6c8761e027 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -798,12 +798,23 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
 
     qemu_mutex_lock(dest->mutex);
 
-    assert(bdrv_dirty_bitmap_enabled(dest));
-    assert(!bdrv_dirty_bitmap_readonly(dest));
+    if (bdrv_dirty_bitmap_frozen(dest)) {
+        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
+                   dest->name);
+        goto out;
+    }
+
+    if (bdrv_dirty_bitmap_readonly(dest)) {
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
+                   dest->name);
+        goto out;
+    }
 
     if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
+        goto out;
     }
 
+out:
     qemu_mutex_unlock(dest->mutex);
 }
diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..902338e815 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2955,16 +2955,6 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(dst)) {
-        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
-                   dst_name);
-        return;
-    } else if (bdrv_dirty_bitmap_readonly(dst)) {
-        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
-                   dst_name);
-        return;
-    }
-
     src = bdrv_find_dirty_bitmap(bs, src_name);
     if (!src) {
         error_setg(errp, "Dirty bitmap '%s' not found", src_name);
-- 
2.11.1
