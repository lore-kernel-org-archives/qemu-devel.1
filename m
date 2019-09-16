Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B80EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124A0214DE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124A0214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sEs-0007ah-0M
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqc-0007Fj-Tb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqa-0007vk-Fx
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:58110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqV-0007sj-Ao; Mon, 16 Sep 2019 10:19:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqS-0003EA-FX; Mon, 16 Sep 2019 17:19:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 17:19:09 +0300
Message-Id: <20190916141911.5255-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916141911.5255-1-vsementsov@virtuozzo.com>
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add bs link
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add bs field to BdrvDirtyBitmap structure. Drop BlockDriverState
parameter from bitmap APIs where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h   | 14 +++++---------
 block/backup.c                 | 14 ++++++--------
 block/dirty-bitmap.c           | 24 ++++++++++++------------
 block/mirror.c                 |  4 ++--
 block/qcow2-bitmap.c           |  6 +++---
 blockdev.c                     |  6 +++---
 migration/block-dirty-bitmap.c |  7 +++----
 migration/block.c              |  4 ++--
 8 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 848dfc6590..4c58d922e4 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -18,21 +18,18 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
                                           Error **errp);
-int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
-                                       BdrvDirtyBitmap *bitmap,
+int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap,
                                        Error **errp);
-BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
-                                            BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
                                             Error **errp);
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
-                                           BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                                            Error **errp);
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
 int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
                             Error **errp);
-void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
+void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          const char *name,
@@ -107,8 +104,7 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
                                     uint64_t bytes);
 bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
                                        uint64_t *offset, uint64_t *bytes);
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
-                                                  BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
 
 #endif
diff --git a/block/backup.c b/block/backup.c
index 763f0d7ff6..acb67da3a7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -352,7 +352,6 @@ static int coroutine_fn backup_before_write_notify(
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
-    BlockDriverState *bs = blk_bs(job->common.blk);
     bool sync = (((ret == 0) || (job->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS)) \
                  && (job->bitmap_mode != BITMAP_SYNC_MODE_NEVER));
 
@@ -361,13 +360,13 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
          * We succeeded, or we always intended to sync the bitmap.
          * Delete this bitmap and install the child.
          */
-        bm = bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
+        bm = bdrv_dirty_bitmap_abdicate(job->sync_bitmap, NULL);
     } else {
         /*
          * We failed, or we never intended to sync the bitmap anyway.
          * Merge the successor back into the parent, keeping all data.
          */
-        bm = bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
+        bm = bdrv_reclaim_dirty_bitmap(job->sync_bitmap, NULL);
     }
 
     assert(bm);
@@ -398,10 +397,9 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
 
     if (s->copy_bitmap) {
-        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
+        bdrv_release_dirty_bitmap(s->copy_bitmap);
         s->copy_bitmap = NULL;
     }
 
@@ -679,7 +677,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         }
 
         /* Create a new bitmap, and freeze/disable this one. */
-        if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) < 0) {
+        if (bdrv_dirty_bitmap_create_successor(sync_bitmap, errp) < 0) {
             return NULL;
         }
     }
@@ -758,10 +756,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
  error:
     if (copy_bitmap) {
         assert(!job || !job->copy_bitmap);
-        bdrv_release_dirty_bitmap(bs, copy_bitmap);
+        bdrv_release_dirty_bitmap(copy_bitmap);
     }
     if (sync_bitmap) {
-        bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
+        bdrv_reclaim_dirty_bitmap(sync_bitmap, NULL);
     }
     if (job) {
         backup_clean(&job->common.job);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index acfc3077f1..f3dc7b3ca5 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -29,6 +29,7 @@
 
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
+    BlockDriverState *bs;
     HBitmap *bitmap;            /* Dirty bitmap implementation */
     bool busy;                  /* Bitmap is busy, it can't be used via QMP */
     BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
@@ -114,6 +115,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
         return NULL;
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
+    bitmap->bs = bs;
     bitmap->mutex = &bs->dirty_bitmap_mutex;
     bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size = bitmap_size;
@@ -236,8 +238,7 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
  * The successor will be enabled if the parent bitmap was.
  * Called with BQL taken.
  */
-int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
-                                       BdrvDirtyBitmap *bitmap, Error **errp)
+int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap, Error **errp)
 {
     uint64_t granularity;
     BdrvDirtyBitmap *child;
@@ -253,7 +254,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
     /* Create an anonymous successor */
     granularity = bdrv_dirty_bitmap_granularity(bitmap);
-    child = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
+    child = bdrv_create_dirty_bitmap(bitmap->bs, granularity, NULL, errp);
     if (!child) {
         return -1;
     }
@@ -299,8 +300,7 @@ static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
  * delete the old bitmap, and return a handle to the new bitmap.
  * Called with BQL taken.
  */
-BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
-                                            BdrvDirtyBitmap *bitmap,
+BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
                                             Error **errp)
 {
     char *name;
@@ -319,7 +319,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     successor->persistent = bitmap->persistent;
     bitmap->persistent = false;
     bitmap->busy = false;
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    bdrv_release_dirty_bitmap(bitmap);
 
     return successor;
 }
@@ -331,8 +331,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
  * The marged parent will be enabled if and only if the successor was enabled.
  * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
  */
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
-                                                  BdrvDirtyBitmap *parent,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *parent,
                                                   Error **errp)
 {
     BdrvDirtyBitmap *successor = parent->successor;
@@ -356,14 +355,13 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
 }
 
 /* Called with BQL taken. */
-BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
-                                           BdrvDirtyBitmap *parent,
+BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *parent,
                                            Error **errp)
 {
     BdrvDirtyBitmap *ret;
 
     qemu_mutex_lock(parent->mutex);
-    ret = bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
+    ret = bdrv_reclaim_dirty_bitmap_locked(parent, errp);
     qemu_mutex_unlock(parent->mutex);
 
     return ret;
@@ -389,8 +387,10 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
 }
 
 /* Called with BQL taken.  */
-void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
+void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
+    BlockDriverState *bs = bitmap->bs;
+
     bdrv_dirty_bitmaps_lock(bs);
     bdrv_release_dirty_bitmap_locked(bitmap);
     bdrv_dirty_bitmaps_unlock(bs);
diff --git a/block/mirror.c b/block/mirror.c
index fe984efb90..a6c50caea4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -638,7 +638,7 @@ static int mirror_exit_common(Job *job)
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
 
-    bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
+    bdrv_release_dirty_bitmap(s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
      * before we can call bdrv_drained_end */
@@ -1709,7 +1709,7 @@ fail:
         blk_unref(s->target);
         bs_opaque->job = NULL;
         if (s->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
+            bdrv_release_dirty_bitmap(s->dirty_bitmap);
         }
         job_early_fail(&s->common.job);
     }
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b2487101ed..6d795a2255 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -374,7 +374,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
 fail:
     g_free(bitmap_table);
     if (bitmap != NULL) {
-        bdrv_release_dirty_bitmap(bs, bitmap);
+        bdrv_release_dirty_bitmap(bitmap);
     }
 
     return NULL;
@@ -941,7 +941,7 @@ fail:
 static void release_dirty_bitmap_helper(gpointer bitmap,
                                         gpointer bs)
 {
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    bdrv_release_dirty_bitmap(bitmap);
 }
 
 /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
@@ -1569,7 +1569,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             continue;
         }
 
-        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        bdrv_release_dirty_bitmap(bm->dirty_bitmap);
     }
 
     bitmap_list_free(bm_list);
diff --git a/blockdev.c b/blockdev.c
index fbef6845c8..a8593fa0c1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2178,7 +2178,7 @@ static void block_dirty_bitmap_remove_commit(BlkActionState *common)
                                              common, common);
 
     bdrv_dirty_bitmap_set_busy(state->bitmap, false);
-    bdrv_release_dirty_bitmap(state->bs, state->bitmap);
+    bdrv_release_dirty_bitmap(state->bitmap);
 }
 
 static void abort_prepare(BlkActionState *common, Error **errp)
@@ -2954,7 +2954,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_remove(
     }
 
     if (release) {
-        bdrv_release_dirty_bitmap(bs, bitmap);
+        bdrv_release_dirty_bitmap(bitmap);
     }
 
     if (bitmap_bs) {
@@ -3086,7 +3086,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_merge(
     bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
 
  out:
-    bdrv_release_dirty_bitmap(bs, anon);
+    bdrv_release_dirty_bitmap(anon);
     return dst;
 }
 
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5121f86d73..793f249aa5 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -474,7 +474,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
         DirtyBitmapLoadBitmapState *b;
 
-        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_err);
+        bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return -EINVAL;
@@ -535,13 +535,12 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
         bdrv_dirty_bitmap_lock(s->bitmap);
         if (enabled_bitmaps == NULL) {
             /* in postcopy */
-            bdrv_reclaim_dirty_bitmap_locked(s->bs, s->bitmap, &error_abort);
+            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
             bdrv_enable_dirty_bitmap_locked(s->bitmap);
         } else {
             /* target not started, successor must be empty */
             int64_t count = bdrv_get_dirty_count(s->bitmap);
-            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bs,
-                                                                    s->bitmap,
+            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
                                                                     NULL);
             /* bdrv_reclaim_dirty_bitmap can fail only on no successor (it
              * must be) or on merge fail, but merge can't fail when second
diff --git a/migration/block.c b/migration/block.c
index 0de9d84198..0496b9b66e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -361,7 +361,7 @@ static int set_dirty_tracking(void)
 fail:
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
         if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitmap);
+            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
         }
     }
     return ret;
@@ -374,7 +374,7 @@ static void unset_dirty_tracking(void)
     BlkMigDevState *bmds;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitmap);
+        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
     }
 }
 
-- 
2.21.0


