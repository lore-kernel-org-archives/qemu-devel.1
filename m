Received: from eggs.gnu.org ([2001:4830:134:3::10]:38655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoK-0008M2-PZ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoI-0006s4-QL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Jun 2018 19:57:45 +0300
Message-Id: <20180625165745.25259-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180625165745.25259-1-vsementsov@virtuozzo.com>
References: <20180625165745.25259-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] dirty-bitmap: fix double lock on bitmap
 enabling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Bitmap lock/unlock were added to bdrv_enable_dirty_bitmap in
8b1402ce80d, but some places were not updated correspondingly, which
leads to trying to take this lock twice, which is dead-lock. Fix this.

Actually, iotest 199 (about dirty bitmap postcopy migration) is broken
now, and this fixes it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c           | 3 ++-
 migration/block-dirty-bitmap.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 93744b3565..c9b8a6fd52 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -250,8 +250,9 @@ void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 {
+    assert(bitmap->mutex == bitmap->successor->mutex);
     qemu_mutex_lock(bitmap->mutex);
-    bdrv_enable_dirty_bitmap(bitmap->successor);
+    bdrv_enable_dirty_bitmap_locked(bitmap->successor);
     qemu_mutex_unlock(bitmap->mutex);
 }
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 3bafbbdc4c..477826330c 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -511,7 +511,7 @@ void dirty_bitmap_mig_before_vm_start(void)
         DirtyBitmapLoadBitmapState *b = item->data;
 
         if (b->migrated) {
-            bdrv_enable_dirty_bitmap(b->bitmap);
+            bdrv_enable_dirty_bitmap_locked(b->bitmap);
         } else {
             bdrv_dirty_bitmap_enable_successor(b->bitmap);
         }
@@ -547,7 +547,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
         if (enabled_bitmaps == NULL) {
             /* in postcopy */
             bdrv_reclaim_dirty_bitmap_locked(s->bs, s->bitmap, &error_abort);
-            bdrv_enable_dirty_bitmap(s->bitmap);
+            bdrv_enable_dirty_bitmap_locked(s->bitmap);
         } else {
             /* target not started, successor must be empty */
             int64_t count = bdrv_get_dirty_count(s->bitmap);
-- 
2.11.1
