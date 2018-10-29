Received: from eggs.gnu.org ([2001:4830:134:3::10]:45314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2V-0004RA-PT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2Q-0002Qo-0s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2B-0002J4-Bt
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:54 -0400
Message-Id: <20181029212501.5897-13-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 12/19] block/dirty-bitmaps: allow clear on
 disabled bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Similarly to merge, it's OK to allow clear operations on disabled
bitmaps, as this condition only means that they are not recording
new writes. We are free to clear it if the user requests it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002230218.13949-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 1 -
 blockdev.c           | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index bfccb0ea15..9b9ebd7142 100644
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
index 9da0cf1a72..8970f699b9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2013,9 +2013,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     if (bdrv_dirty_bitmap_user_locked(state->bitmap)) {
         error_setg(errp, "Cannot modify a bitmap in use by another operation");
         return;
-    } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
-        error_setg(errp, "Cannot clear a disabled bitmap");
-        return;
     } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
         error_setg(errp, "Cannot clear a readonly bitmap");
         return;
@@ -2918,11 +2915,6 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
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
2.14.5
