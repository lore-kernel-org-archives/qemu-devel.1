Received: from eggs.gnu.org ([2001:4830:134:3::10]:45980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAz-0001Ni-3Q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001eP-KH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:08 -0400
Message-Id: <20180613020613.1343-6-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/10] qcow2/bitmap: reject IN_USE bitmaps
 on rw reload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Presently, an image with IN_USE bitmaps cannot be loaded as RO.
In preparation for changing that, IN_USE bitmaps ought to create an
error on reload instead of being skipped.

While we're here, update the function to work with two new facts:
 - All bm_list entries will have a BdrvDirtyBitmap (because we load and
   disable bitmaps when the autoload flag isn't set), and
 - The dirty_bitmap will be cached, so we don't have to look it up.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d94b6bd5cf..859819639b 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1046,23 +1046,22 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (!(bm->flags & BME_FLAG_IN_USE)) {
-            BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
-            if (bitmap == NULL) {
-                continue;
-            }
-
-            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
-                error_setg(errp, "Bitmap %s is not readonly but not marked"
-                                 "'IN_USE' in the image. Something went wrong,"
-                                 "all the bitmaps may be corrupted", bm->name);
-                ret = -EINVAL;
-                goto out;
-            }
-
-            bm->flags |= BME_FLAG_IN_USE;
-            ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+        if (bm->flags & BME_FLAG_IN_USE) {
+            error_setg(errp, "Bitmap '%s' is in use; can't reopen RW",
+                       bm->name);
+            ret = -EINVAL;
+            goto out;
+        } else if (!bdrv_dirty_bitmap_readonly(bm->dirty_bitmap)) {
+            error_setg(errp, "Bitmap %s is neither readonly nor 'IN_USE' in "
+                       "the image. Something went wrong, all the bitmaps may "
+                       "be corrupted. Please report this to the developers at "
+                       " qemu-devel@nongnu.org", bm->name);
+            ret = -EINVAL;
+            goto out;
         }
+
+        bm->flags |= BME_FLAG_IN_USE;
+        ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bm->dirty_bitmap);
     }
 
     if (ro_dirty_bitmaps != NULL) {
-- 
2.14.3
