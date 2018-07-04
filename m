Received: from eggs.gnu.org ([2001:4830:134:3::10]:53032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMY-0002Bg-45
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMU-0004CJ-4i
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fabMU-0004C7-06
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:58 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  4 Jul 2018 02:33:55 -0400
Message-Id: <20180704063355.25818-3-jsnow@redhat.com>
In-Reply-To: <20180704063355.25818-1-jsnow@redhat.com>
References: <20180704063355.25818-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] dirty-bitmap: fix double lock on bitmap
 enabling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Bitmap lock/unlock were added to bdrv_enable_dirty_bitmap in
8b1402ce80d, but some places were not updated correspondingly, which
leads to trying to take this lock twice, which is dead-lock. Fix this.

Actually, iotest 199 (about dirty bitmap postcopy migration) is broken
now, and this fixes it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180625165745.25259-3-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.14.4
