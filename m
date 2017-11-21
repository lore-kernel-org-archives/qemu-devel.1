Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC9-0003CJ-9r
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHAC3-0005Dy-8G
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:10:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Nov 2017 16:10:13 +0100
Message-Id: <20171121151017.28158-4-kwolf@redhat.com>
In-Reply-To: <20171121151017.28158-1-kwolf@redhat.com>
References: <20171121151017.28158-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] block: Add errp to bdrv_snapshot_goto()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/snapshot.h |  3 ++-
 block/snapshot.c         | 23 +++++++++++++++++------
 qemu-img.c               |  6 +++---
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index e5c0553115..aeb80405e8 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -57,7 +57,8 @@ int bdrv_can_snapshot(BlockDriverState *bs);
 int bdrv_snapshot_create(BlockDriverState *bs,
                          QEMUSnapshotInfo *sn_info);
 int bdrv_snapshot_goto(BlockDriverState *bs,
-                       const char *snapshot_id);
+                       const char *snapshot_id,
+                       Error **errp);
 int bdrv_snapshot_delete(BlockDriverState *bs,
                          const char *snapshot_id,
                          const char *name,
diff --git a/block/snapshot.c b/block/snapshot.c
index be0743abac..75562df4cc 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -177,18 +177,21 @@ int bdrv_snapshot_create(BlockDriverState *bs,
 }
 
 int bdrv_snapshot_goto(BlockDriverState *bs,
-                       const char *snapshot_id)
+                       const char *snapshot_id,
+                       Error **errp)
 {
     BlockDriver *drv = bs->drv;
     int ret, open_ret;
     int64_t len;
 
     if (!drv) {
+        error_setg(errp, "Block driver is closed");
         return -ENOMEDIUM;
     }
 
     len = bdrv_getlength(bs);
     if (len < 0) {
+        error_setg_errno(errp, -len, "Cannot get block device size");
         return len;
     }
     /* We should set all bits in all enabled dirty bitmaps, because dirty
@@ -200,13 +203,18 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
     bdrv_set_dirty(bs, 0, len);
 
     if (drv->bdrv_snapshot_goto) {
-        return drv->bdrv_snapshot_goto(bs, snapshot_id);
+        ret = drv->bdrv_snapshot_goto(bs, snapshot_id);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to load snapshot");
+        }
+        return ret;
     }
 
     if (bs->file) {
         BlockDriverState *file;
         QDict *options = qdict_clone_shallow(bs->options);
         QDict *file_options;
+        Error *local_err = NULL;
 
         file = bs->file->bs;
         /* Prevent it from getting deleted when detached from bs */
@@ -220,13 +228,15 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bdrv_unref_child(bs, bs->file);
         bs->file = NULL;
 
-        ret = bdrv_snapshot_goto(file, snapshot_id);
-        open_ret = drv->bdrv_open(bs, options, bs->open_flags, NULL);
+        ret = bdrv_snapshot_goto(file, snapshot_id, errp);
+        open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         QDECREF(options);
         if (open_ret < 0) {
             bdrv_unref(file);
             bs->drv = NULL;
-            return open_ret;
+            /* A bdrv_snapshot_goto() error takes precedence */
+            error_propagate(errp, local_err);
+            return ret < 0 ? ret : open_ret;
         }
 
         assert(bs->file->bs == file);
@@ -234,6 +244,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
 
+    error_setg(errp, "Block driver does not support snapshots");
     return -ENOTSUP;
 }
 
@@ -467,7 +478,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs)
 
         aio_context_acquire(ctx);
         if (bdrv_can_snapshot(bs)) {
-            err = bdrv_snapshot_goto(bs, name);
+            err = bdrv_snapshot_goto(bs, name, NULL);
         }
         aio_context_release(ctx);
         if (err < 0) {
diff --git a/qemu-img.c b/qemu-img.c
index 02a6e27beb..68b375f998 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2989,10 +2989,10 @@ static int img_snapshot(int argc, char **argv)
         break;
 
     case SNAPSHOT_APPLY:
-        ret = bdrv_snapshot_goto(bs, snapshot_name);
+        ret = bdrv_snapshot_goto(bs, snapshot_name, &err);
         if (ret) {
-            error_report("Could not apply snapshot '%s': %d (%s)",
-                snapshot_name, ret, strerror(-ret));
+            error_reportf_err(err, "Could not apply snapshot '%s': ",
+                              snapshot_name);
         }
         break;
 
-- 
2.13.6
