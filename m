Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuo-0000Zk-Ou
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBum-00083E-Rd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:42 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:21 +0100
Message-Id: <1487689130-30373-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 25/54] block: Add error parameter to
 blk_insert_bs()
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

Now that blk_insert_bs() requests the BlockBackend permissions for the
node it attaches to, it can fail. Instead of aborting, pass the errors
to the callers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                          |  5 ++++-
 block/backup.c                   |  5 ++++-
 block/block-backend.c            | 13 ++++++++-----
 block/commit.c                   | 38 ++++++++++++++++++++++++++++++--------
 block/mirror.c                   | 15 ++++++++++++---
 block/qcow2.c                    | 10 ++++++++--
 blockdev.c                       | 11 +++++++++--
 blockjob.c                       |  7 ++++++-
 hmp.c                            |  6 +++++-
 hw/core/qdev-properties-system.c |  7 ++++++-
 include/sysemu/block-backend.h   |  2 +-
 migration/block.c                |  2 +-
 nbd/server.c                     |  6 +++++-
 tests/test-blockjob.c            |  2 +-
 14 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/block.c b/block.c
index ed37d17..9f46698 100644
--- a/block.c
+++ b/block.c
@@ -2171,8 +2171,11 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
         if (file_bs != NULL) {
             file = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
-            blk_insert_bs(file, file_bs);
+            blk_insert_bs(file, file_bs, &local_err);
             bdrv_unref(file_bs);
+            if (local_err) {
+                goto fail;
+            }
 
             qdict_put(options, "file",
                       qstring_from_str(bdrv_get_node_name(file_bs)));
diff --git a/block/backup.c b/block/backup.c
index 4b3c94c..f38d1d0 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -626,7 +626,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     /* FIXME Use real permissions */
     job->target = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(job->target, target);
+    ret = blk_insert_bs(job->target, target, errp);
+    if (ret < 0) {
+        goto error;
+    }
 
     job->on_source_error = on_source_error;
     job->on_target_error = on_target_error;
diff --git a/block/block-backend.c b/block/block-backend.c
index 0319220..299948f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -508,19 +508,22 @@ void blk_remove_bs(BlockBackend *blk)
 /*
  * Associates a new BlockDriverState with @blk.
  */
-void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs)
+int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
-    bdrv_ref(bs);
-    /* FIXME Error handling */
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
-                                       blk->perm, blk->shared_perm, blk,
-                                       &error_abort);
+                                       blk->perm, blk->shared_perm, blk, errp);
+    if (blk->root == NULL) {
+        return -EPERM;
+    }
+    bdrv_ref(bs);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
         throttle_timers_attach_aio_context(
             &blk->public.throttle_timers, bdrv_get_aio_context(bs));
     }
+
+    return 0;
 }
 
 /*
diff --git a/block/commit.c b/block/commit.c
index 1897e98..2ad8138 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -220,6 +220,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     BlockDriverState *overlay_bs;
     Error *local_err = NULL;
+    int ret;
 
     assert(top != bs);
     if (top == base) {
@@ -256,8 +257,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-            block_job_unref(&s->common);
-            return;
+            goto fail;
         }
     }
 
@@ -277,11 +277,17 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     /* FIXME Use real permissions */
     s->base = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(s->base, base);
+    ret = blk_insert_bs(s->base, base, errp);
+    if (ret < 0) {
+        goto fail;
+    }
 
     /* FIXME Use real permissions */
     s->top = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(s->top, top);
+    ret = blk_insert_bs(s->top, top, errp);
+    if (ret < 0) {
+        goto fail;
+    }
 
     s->active = bs;
 
@@ -294,6 +300,16 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
     trace_commit_start(bs, base, top, s);
     block_job_start(&s->common);
+    return;
+
+fail:
+    if (s->base) {
+        blk_unref(s->base);
+    }
+    if (s->top) {
+        blk_unref(s->top);
+    }
+    block_job_unref(&s->common);
 }
 
 
@@ -332,11 +348,17 @@ int bdrv_commit(BlockDriverState *bs)
 
     /* FIXME Use real permissions */
     src = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(src, bs);
-
-    /* FIXME Use real permissions */
     backing = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(backing, bs->backing->bs);
+
+    ret = blk_insert_bs(src, bs, NULL);
+    if (ret < 0) {
+        goto ro_cleanup;
+    }
+
+    ret = blk_insert_bs(backing, bs->backing->bs, NULL);
+    if (ret < 0) {
+        goto ro_cleanup;
+    }
 
     length = blk_getlength(src);
     if (length < 0) {
diff --git a/block/mirror.c b/block/mirror.c
index 8f015b2..c551bfc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -523,9 +523,12 @@ static void mirror_exit(BlockJob *job, void *opaque)
         bdrv_replace_in_backing_chain(to_replace, target_bs);
         bdrv_drained_end(target_bs);
 
-        /* We just changed the BDS the job BB refers to */
+        /* We just changed the BDS the job BB refers to, so switch the BB back
+         * so the cleanup does the right thing. We don't need any permissions
+         * any more now. */
         blk_remove_bs(job->blk);
-        blk_insert_bs(job->blk, src);
+        blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
+        blk_insert_bs(job->blk, src, &error_abort);
     }
     if (s->to_replace) {
         bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
@@ -990,6 +993,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              bool auto_complete)
 {
     MirrorBlockJob *s;
+    int ret;
 
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
@@ -1014,7 +1018,12 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
     /* FIXME Use real permissions */
     s->target = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(s->target, target);
+    ret = blk_insert_bs(s->target, target, errp);
+    if (ret < 0) {
+        blk_unref(s->target);
+        block_job_unref(&s->common);
+        return;
+    }
 
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
diff --git a/block/qcow2.c b/block/qcow2.c
index 0356e69..6f79df8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3113,6 +3113,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     uint64_t cluster_size = s->cluster_size;
     bool encrypt;
     int refcount_bits = s->refcount_bits;
+    Error *local_err = NULL;
     int ret;
     QemuOptDesc *desc = opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
@@ -3263,10 +3264,15 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
 
     if (new_size) {
         BlockBackend *blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
-        blk_insert_bs(blk, bs);
+        ret = blk_insert_bs(blk, bs, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            blk_unref(blk);
+            return ret;
+        }
+
         ret = blk_truncate(blk, new_size);
         blk_unref(blk);
-
         if (ret < 0) {
             return ret;
         }
diff --git a/blockdev.c b/blockdev.c
index 10a12d1..d01e313 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2432,6 +2432,7 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
     bool has_device;
+    int ret;
 
     /* For BBs without a device, we can exchange the BDS tree at will */
     has_device = blk_get_attached_dev(blk);
@@ -2451,7 +2452,10 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
         return;
     }
 
-    blk_insert_bs(blk, bs);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        return;
+    }
 
     if (!blk_dev_has_tray(blk)) {
         /* For tray-less devices, blockdev-close-tray is a no-op (or may not be
@@ -2887,7 +2891,10 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
     blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
-    blk_insert_bs(blk, bs);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto out;
+    }
 
     /* complete all in-flight operations before resizing the device */
     bdrv_drain_all();
diff --git a/blockjob.c b/blockjob.c
index 508e0e5..72b7d4c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -128,6 +128,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 {
     BlockBackend *blk;
     BlockJob *job;
+    int ret;
 
     if (bs->job) {
         error_setg(errp, QERR_DEVICE_IN_USE, bdrv_get_device_name(bs));
@@ -161,7 +162,11 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
     /* FIXME Use real permissions */
     blk = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(blk, bs);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        blk_unref(blk);
+        return NULL;
+    }
 
     job = g_malloc0(driver->instance_size);
     error_setg(&job->blocker, "block device is in use by block job: %s",
diff --git a/hmp.c b/hmp.c
index 15fd3f7..801fddb 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2039,6 +2039,7 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     const char* device = qdict_get_str(qdict, "device");
     const char* command = qdict_get_str(qdict, "command");
     Error *err = NULL;
+    int ret;
 
     blk = blk_by_name(device);
     if (!blk) {
@@ -2046,7 +2047,10 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
         if (bs) {
             /* FIXME Use real permissions */
             blk = local_blk = blk_new(0, BLK_PERM_ALL);
-            blk_insert_bs(blk, bs);
+            ret = blk_insert_bs(blk, bs, &err);
+            if (ret < 0) {
+                goto fail;
+            }
         } else {
             goto fail;
         }
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index cca4775..66ba367 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -73,6 +73,7 @@ static void parse_drive(DeviceState *dev, const char *str, void **ptr,
 {
     BlockBackend *blk;
     bool blk_created = false;
+    int ret;
 
     blk = blk_by_name(str);
     if (!blk) {
@@ -80,8 +81,12 @@ static void parse_drive(DeviceState *dev, const char *str, void **ptr,
         if (bs) {
             /* FIXME Use real permissions */
             blk = blk_new(0, BLK_PERM_ALL);
-            blk_insert_bs(blk, bs);
             blk_created = true;
+
+            ret = blk_insert_bs(blk, bs, errp);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
     if (!blk) {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 6651f43..0861113 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -102,7 +102,7 @@ BlockBackend *blk_by_public(BlockBackendPublic *public);
 
 BlockDriverState *blk_bs(BlockBackend *blk);
 void blk_remove_bs(BlockBackend *blk);
-void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs);
+int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
 bool bdrv_has_blk(BlockDriverState *bs);
 bool bdrv_is_root_node(BlockDriverState *bs);
 int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
diff --git a/migration/block.c b/migration/block.c
index 6b7ffd4..d259936 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -446,7 +446,7 @@ static void init_blk_migration(QEMUFile *f)
         BlockDriverState *bs = bmds_bs[i].bs;
 
         if (bmds) {
-            blk_insert_bs(bmds->blk, bs);
+            blk_insert_bs(bmds->blk, bs, &error_abort);
 
             alloc_aio_bitmap(bmds);
             error_setg(&bmds->blocker, "block device is in use by migration");
diff --git a/nbd/server.c b/nbd/server.c
index 936d5aa..89362ba 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -891,10 +891,14 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
 {
     BlockBackend *blk;
     NBDExport *exp = g_malloc0(sizeof(NBDExport));
+    int ret;
 
     /* FIXME Use real permissions */
     blk = blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(blk, bs);
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        goto fail;
+    }
     blk_set_enable_write_cache(blk, !writethrough);
 
     exp->refcount = 1;
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 1dd1cfa..143ce96 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -60,7 +60,7 @@ static BlockBackend *create_blk(const char *name)
     bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
     g_assert_nonnull(bs);
 
-    blk_insert_bs(blk, bs);
+    blk_insert_bs(blk, bs, &error_abort);
     bdrv_unref(bs);
 
     if (name) {
-- 
1.8.3.1
