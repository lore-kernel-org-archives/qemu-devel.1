Received: from eggs.gnu.org ([2001:4830:134:3::10]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI8-0006Kl-Fo
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI7-0006T3-FT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:29 -0400
Message-Id: <20180512012537.22478-5-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/12] qcow2/dirty-bitmaps: load IN_USE
 bitmaps if disk is RO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

For the purposes of qemu-img manipulation and querying of bitmaps, load
bitmaps that are "in use" -- if the image is read only. This will allow
us to diagnose problems with this flag using the qemu-img tool.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index fc8d52fc3e..b556dbdccd 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -346,7 +346,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
     uint32_t granularity;
     BdrvDirtyBitmap *bitmap = NULL;
 
-    if (bm->flags & BME_FLAG_IN_USE) {
+    if (can_write(bs) && (bm->flags & BME_FLAG_IN_USE)) {
         error_setg(errp, "Bitmap '%s' is in use", bm->name);
         goto fail;
     }
@@ -974,23 +974,21 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (!(bm->flags & BME_FLAG_IN_USE)) {
-            BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
-            if (bitmap == NULL) {
-                goto fail;
-            }
-            bm->dirty_bitmap = bitmap;
+        BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
+        if (bitmap == NULL) {
+            goto fail;
+        }
+        bm->dirty_bitmap = bitmap;
 
-            if (!(bm->flags & BME_FLAG_AUTO)) {
-                bdrv_disable_dirty_bitmap(bitmap);
-            }
-            bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            if (can_write(bs)) {
-                bm->flags |= BME_FLAG_IN_USE;
-                needs_update = true;
-            } else {
-                bdrv_dirty_bitmap_set_readonly(bitmap, true);
-            }
+        if (!(bm->flags & BME_FLAG_AUTO)) {
+            bdrv_disable_dirty_bitmap(bitmap);
+        }
+        bdrv_dirty_bitmap_set_persistance(bitmap, true);
+        if (can_write(bs)) {
+            bm->flags |= BME_FLAG_IN_USE;
+            needs_update = true;
+        } else {
+            bdrv_dirty_bitmap_set_readonly(bitmap, true);
         }
     }
 
-- 
2.14.3
