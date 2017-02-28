Received: from eggs.gnu.org ([2001:4830:134:3::10]:44201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihK0-0005F4-C1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihJy-0004e5-Qm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:56:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 13:54:28 +0100
Message-Id: <1488286469-9381-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 43/44] block: Add Error parameter to
 bdrv_set_backing_hd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Not all callers of bdrv_set_backing_hd() know for sure that attaching
the backing file will be allowed by the permission system. Return the
error from the function rather than aborting.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 30 +++++++++++++++++++++++-------
 block/commit.c        | 14 +++++++-------
 block/mirror.c        |  7 ++++++-
 block/stream.c        |  9 ++++++++-
 block/vvfat.c         |  2 +-
 include/block/block.h |  3 ++-
 6 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/block.c b/block.c
index 74ac7dc..6440b61 100644
--- a/block.c
+++ b/block.c
@@ -1883,7 +1883,8 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
+void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                         Error **errp)
 {
     if (backing_hd) {
         bdrv_ref(backing_hd);
@@ -1897,9 +1898,12 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
         bs->backing = NULL;
         goto out;
     }
-    /* FIXME Error handling */
+
     bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
-                                    &error_abort);
+                                    errp);
+    if (!bs->backing) {
+        bdrv_unref(backing_hd);
+    }
 
 out:
     bdrv_refresh_limits(bs, NULL);
@@ -1983,8 +1987,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-    bdrv_set_backing_hd(bs, backing_hd);
+    bdrv_set_backing_hd(bs, backing_hd, &local_err);
     bdrv_unref(backing_hd);
+    if (local_err) {
+        ret = -EINVAL;
+        goto free_exit;
+    }
 
     qdict_del(parent_options, bdref_key);
 
@@ -2818,7 +2826,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv->bdrv_close(bs);
         bs->drv = NULL;
 
-        bdrv_set_backing_hd(bs, NULL);
+        bdrv_set_backing_hd(bs, NULL, &error_abort);
 
         if (bs->file != NULL) {
             bdrv_unref_child(bs, bs->file);
@@ -2927,7 +2935,8 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top)
     bdrv_ref(bs_top);
 
     change_parent_backing_link(bs_top, bs_new);
-    bdrv_set_backing_hd(bs_new, bs_top);
+    /* FIXME Error handling */
+    bdrv_set_backing_hd(bs_new, bs_top, &error_abort);
     bdrv_unref(bs_top);
 
     /* bs_new is now referenced by its new parents, we don't need the
@@ -3075,6 +3084,7 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
                            BlockDriverState *base, const char *backing_file_str)
 {
     BlockDriverState *new_top_bs = NULL;
+    Error *local_err = NULL;
     int ret = -EIO;
 
     if (!top->drv || !base->drv) {
@@ -3107,7 +3117,13 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
     if (ret) {
         goto exit;
     }
-    bdrv_set_backing_hd(new_top_bs, base);
+
+    bdrv_set_backing_hd(new_top_bs, base, &local_err);
+    if (local_err) {
+        ret = -EPERM;
+        error_report_err(local_err);
+        goto exit;
+    }
 
     ret = 0;
 exit:
diff --git a/block/commit.c b/block/commit.c
index 1e0f531..22a0a4d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -121,7 +121,7 @@ static void commit_complete(BlockJob *job, void *opaque)
      * filter driver from the backing chain. Do this as the final step so that
      * the 'consistent read' permission can be granted.  */
     if (remove_commit_top_bs) {
-        bdrv_set_backing_hd(overlay_bs, top);
+        bdrv_set_backing_hd(overlay_bs, top, &error_abort);
     }
 }
 
@@ -316,8 +316,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, top);
-    bdrv_set_backing_hd(overlay_bs, commit_top_bs);
+    bdrv_set_backing_hd(commit_top_bs, top, &error_abort);
+    bdrv_set_backing_hd(overlay_bs, commit_top_bs, &error_abort);
 
     s->commit_top_bs = commit_top_bs;
     bdrv_unref(commit_top_bs);
@@ -390,7 +390,7 @@ fail:
         blk_unref(s->top);
     }
     if (commit_top_bs) {
-        bdrv_set_backing_hd(overlay_bs, top);
+        bdrv_set_backing_hd(overlay_bs, top, &error_abort);
     }
     block_job_unref(&s->common);
 }
@@ -451,8 +451,8 @@ int bdrv_commit(BlockDriverState *bs)
         goto ro_cleanup;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, backing_file_bs);
-    bdrv_set_backing_hd(bs, commit_top_bs);
+    bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
+    bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
 
     ret = blk_insert_bs(backing, backing_file_bs, &local_err);
     if (ret < 0) {
@@ -532,7 +532,7 @@ ro_cleanup:
 
     blk_unref(backing);
     if (backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs);
+        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
     bdrv_unref(commit_top_bs);
     blk_unref(src);
diff --git a/block/mirror.c b/block/mirror.c
index 9247ad9..e0475b4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -503,6 +503,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     BlockDriverState *src = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
+    Error *local_err = NULL;
 
     /* Make sure that the source BDS doesn't go away before we called
      * block_job_completed(). */
@@ -516,7 +517,11 @@ static void mirror_exit(BlockJob *job, void *opaque)
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
         if (backing_bs(target_bs) != backing) {
-            bdrv_set_backing_hd(target_bs, backing);
+            bdrv_set_backing_hd(target_bs, backing, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                data->ret = -EPERM;
+            }
         }
     }
 
diff --git a/block/stream.c b/block/stream.c
index b9c2f43..0113710 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -68,6 +68,7 @@ static void stream_complete(BlockJob *job, void *opaque)
     StreamCompleteData *data = opaque;
     BlockDriverState *bs = blk_bs(job->blk);
     BlockDriverState *base = s->base;
+    Error *local_err = NULL;
 
     if (!block_job_is_cancelled(&s->common) && data->reached_end &&
         data->ret == 0) {
@@ -79,9 +80,15 @@ static void stream_complete(BlockJob *job, void *opaque)
             }
         }
         data->ret = bdrv_change_backing_file(bs, base_id, base_fmt);
-        bdrv_set_backing_hd(bs, base);
+        bdrv_set_backing_hd(bs, base, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            data->ret = -EPERM;
+            goto out;
+        }
     }
 
+out:
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_flags != bdrv_get_flags(bs)) {
         /* Give up write permissions before making it read-only */
diff --git a/block/vvfat.c b/block/vvfat.c
index 72b482c..aa61c32 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3041,7 +3041,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
                                    &error_abort);
     *(void**) backing->opaque = s;
 
-    bdrv_set_backing_hd(s->bs, backing);
+    bdrv_set_backing_hd(s->bs, backing, &error_abort);
     bdrv_unref(backing);
 
     return 0;
diff --git a/include/block/block.h b/include/block/block.h
index 07f7561..eac2861 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -247,7 +247,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BlockDriverState* parent,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp);
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd);
+void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                         Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
-- 
1.8.3.1
