Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-00040w-7h
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF23-0002Fn-Sp
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF23-0002FQ-MI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:07 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:44 -0400
Message-Id: <20181029212501.5897-3-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 02/19] dirty-bitmap: switch assert-fails to
 errors in bdrv_merge_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move checks from qmp_x_block_dirty_bitmap_merge() to
bdrv_merge_dirty_bitmap(), to share them with dirty bitmap merge
transaction action in future commit.

Note: for now, only qmp_x_block_dirty_bitmap_merge() calls
bdrv_merge_dirty_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
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
index 1869f9aaf3..e3398e141a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2962,16 +2962,6 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
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
2.14.5
