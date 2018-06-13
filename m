Received: from eggs.gnu.org ([2001:4830:134:3::10]:46012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAz-0001OU-OW
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001ej-UN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:04 -0400
Message-Id: <20180613020613.1343-2-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/10] qcow2/bitmap: remove redundant
 arguments from bitmap_list_load
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

We always call it with the same fields of the struct we always pass.
We can split this out later if we really wind up needing to.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 69485aa1de..0670e5eb41 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -535,8 +535,7 @@ static uint32_t bitmap_list_count(Qcow2BitmapList *bm_list)
  * Get bitmap list from qcow2 image. Actually reads bitmap directory,
  * checks it and convert to bitmap list.
  */
-static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
-                                         uint64_t size, Error **errp)
+static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error **errp)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
@@ -544,6 +543,8 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
     Qcow2BitmapDirEntry *e;
     uint32_t nb_dir_entries = 0;
     Qcow2BitmapList *bm_list = NULL;
+    uint64_t offset = s->bitmap_directory_offset;
+    uint64_t size = s->bitmap_directory_size;
 
     if (size == 0) {
         error_setg(errp, "Requested bitmap directory size is zero");
@@ -655,8 +656,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         return ret;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, NULL);
+    bm_list = bitmap_list_load(bs, NULL);
     if (bm_list == NULL) {
         res->corruptions++;
         return -EINVAL;
@@ -952,8 +952,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         return false;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = bitmap_list_load(bs, errp);
     if (bm_list == NULL) {
         return false;
     }
@@ -1026,8 +1025,7 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
         return -EINVAL;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = bitmap_list_load(bs, errp);
     if (bm_list == NULL) {
         return -EINVAL;
     }
@@ -1276,8 +1274,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
         return;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = bitmap_list_load(bs, errp);
     if (bm_list == NULL) {
         return;
     }
@@ -1329,8 +1326,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     if (s->nb_bitmaps == 0) {
         bm_list = bitmap_list_new();
     } else {
-        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                                   s->bitmap_directory_size, errp);
+        bm_list = bitmap_list_load(bs, errp);
         if (bm_list == NULL) {
             return;
         }
@@ -1494,8 +1490,7 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = bitmap_list_load(bs, errp);
     if (bm_list == NULL) {
         goto fail;
     }
-- 
2.14.3
