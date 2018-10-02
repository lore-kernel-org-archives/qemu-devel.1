Received: from eggs.gnu.org ([2001:4830:134:3::10]:40903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TwG-0002b8-Dt
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TgZ-0004CZ-1W
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:35 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:13 -0400
Message-Id: <20181002230218.13949-2-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/6] block/dirty-bitmaps: add user_locked
 status checker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Instead of both frozen and qmp_locked checks, wrap it into one check.
frozen implies the bitmap is split in two (for backup), and shouldn't
be modified. qmp_locked implies it's being used by another operation,
like being exported over NBD. In both cases it means we shouldn't allow
the user to modify it in any meaningful way.

Replace any usages where we check both frozen and qmp_locked with the
new check.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c           |  6 ++++++
 blockdev.c                     | 29 ++++++++---------------------
 include/block/dirty-bitmap.h   |  1 +
 migration/block-dirty-bitmap.c | 10 ++--------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8ac933cf1c..85bc668f6a 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -176,6 +176,12 @@ bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
     return bitmap->successor;
 }
 
+/* Both conditions disallow user-modification via QMP. */
+bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap) {
+    return (bdrv_dirty_bitmap_frozen(bitmap) ||
+            bdrv_dirty_bitmap_qmp_locked(bitmap));
+}
+
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked)
 {
     qemu_mutex_lock(bitmap->mutex);
diff --git a/blockdev.c b/blockdev.c
index 670ae5bbde..d775f228fe 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2009,11 +2009,8 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(state->bitmap)) {
-        error_setg(errp, "Cannot modify a frozen bitmap");
-        return;
-    } else if (bdrv_dirty_bitmap_qmp_locked(state->bitmap)) {
-        error_setg(errp, "Cannot modify a locked bitmap");
+    if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
+        error_setg(errp, "Cannot modify a bitmap in use by another operation");
         return;
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
         error_setg(errp, "Cannot clear a disabled bitmap");
@@ -2882,15 +2879,10 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
         error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be removed",
-                   name);
-        return;
-    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently locked and cannot be removed",
-                   name);
+                   "Bitmap '%s' is currently in use by another operation and"
+                   " cannot be removed", name);
         return;
     }
 
@@ -2920,15 +2912,10 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
         error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be modified",
-                   name);
-        return;
-    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently locked and cannot be modified",
-                   name);
+                   "Bitmap '%s' is currently in use by another operation"
+                   " and cannot be cleared", name);
         return;
     } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
         error_setg(errp,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 201ff7f20b..14639439a2 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -94,6 +94,7 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap);
 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
                                         BdrvDirtyBitmap *bitmap);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 477826330c..d49c581023 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -301,14 +301,8 @@ static int init_dirty_bitmap_migration(void)
                 goto fail;
             }
 
-            if (bdrv_dirty_bitmap_frozen(bitmap)) {
-                error_report("Can't migrate frozen dirty bitmap: '%s",
-                             bdrv_dirty_bitmap_name(bitmap));
-                goto fail;
-            }
-
-            if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-                error_report("Can't migrate locked dirty bitmap: '%s",
+            if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+                error_report("Can't migrate a bitmap that is in use: '%s'",
                              bdrv_dirty_bitmap_name(bitmap));
                 goto fail;
             }
-- 
2.14.4
