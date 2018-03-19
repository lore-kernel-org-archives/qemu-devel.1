Received: from eggs.gnu.org ([2001:4830:134:3::10]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgY-0008L4-1P
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1exqgU-0007Ln-R1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 05:02:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 19 Mar 2018 12:02:21 +0300
Message-Id: <20180319090223.23336-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-1-vsementsov@virtuozzo.com>
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 1/3] qcow2-bitmap: add
 qcow2_reopen_bitmaps_rw_hint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Add version of qcow2_reopen_bitmaps_rw, which do the same work but
also return a hint about was header updated or not. This will be
used in the following fix for bitmaps reloading after migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  2 ++
 block/qcow2-bitmap.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index ccb92a9696..d301f77cea 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -671,6 +671,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
+                                 Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3010adb909..6e93ec43e1 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1004,7 +1004,8 @@ fail:
     return false;
 }
 
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
+int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
+                                 Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
@@ -1012,6 +1013,10 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
     GSList *ro_dirty_bitmaps = NULL;
     int ret = 0;
 
+    if (header_updated != NULL) {
+        *header_updated = false;
+    }
+
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
         return 0;
@@ -1055,6 +1060,9 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
             error_setg_errno(errp, -ret, "Can't update bitmap directory");
             goto out;
         }
+        if (header_updated != NULL) {
+            *header_updated = true;
+        }
         g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
 
@@ -1065,6 +1073,11 @@ out:
     return ret;
 }
 
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
+{
+    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
+}
+
 /* store_bitmap_data()
  * Store bitmap to image, filling bitmap table accordingly.
  */
-- 
2.11.1
