Received: from eggs.gnu.org ([2001:4830:134:3::10]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TwG-0002ez-FI
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TgZ-0004Cg-2H
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:35 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:15 -0400
Message-Id: <20181002230218.13949-4-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/6] block/dirty-bitmaps: allow clear on
 disabled bitmaps
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

Similarly to merge, it's OK to allow clear operations on disabled
bitmaps, as this condition only means that they are not recording
new writes. We are free to clear it if the user requests it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 1 -
 blockdev.c           | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 8a6e07930f..035f97e5c2 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -625,7 +625,6 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     bdrv_dirty_bitmap_lock(bitmap);
     if (!out) {
diff --git a/blockdev.c b/blockdev.c
index d775f228fe..cccd36b5e7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2012,9 +2012,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
         error_setg(errp, "Cannot modify a bitmap in use by another operation");
         return;
-    } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
-        error_setg(errp, "Cannot clear a disabled bitmap");
-        return;
     } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
         error_setg(errp, "Cannot clear a readonly bitmap");
         return;
@@ -2917,11 +2914,6 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                    "Bitmap '%s' is currently in use by another operation"
                    " and cannot be cleared", name);
         return;
-    } else if (!bdrv_dirty_bitmap_enabled(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently disabled and cannot be cleared",
-                   name);
-        return;
     } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
         error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
         return;
-- 
2.14.4
