Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuo-0000ZF-78
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBum-00082s-Iq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:42 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:20 +0100
Message-Id: <1487689130-30373-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 24/54] block: Add permissions to blk_new()
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

We want every user to be specific about the permissions it needs, so
we'll pass the initial permissions as parameters to blk_new(). A user
only needs to call blk_set_perm() if it wants to change the permissions
after the fact.

The permissions are stored in the BlockBackend and applied whenever a
BlockDriverState should be attached in blk_insert_bs().

This does not include actually choosing the right set of permissions
everywhere yet. Instead, the usual FIXME comment is added to each place
and will be addressed in individual patches.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                          |  2 +-
 block/backup.c                   |  3 ++-
 block/block-backend.c            | 21 ++++++++++++++-------
 block/commit.c                   | 12 ++++++++----
 block/mirror.c                   |  3 ++-
 block/qcow2.c                    |  2 +-
 blockdev.c                       |  4 ++--
 blockjob.c                       |  3 ++-
 hmp.c                            |  3 ++-
 hw/block/fdc.c                   |  3 ++-
 hw/core/qdev-properties-system.c |  3 ++-
 hw/ide/qdev.c                    |  3 ++-
 hw/scsi/scsi-disk.c              |  3 ++-
 include/sysemu/block-backend.h   |  2 +-
 migration/block.c                |  3 ++-
 nbd/server.c                     |  3 ++-
 tests/test-blockjob.c            |  3 ++-
 tests/test-throttle.c            |  7 ++++---
 18 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 054e6f0..ed37d17 100644
--- a/block.c
+++ b/block.c
@@ -2170,7 +2170,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
             goto fail;
         }
         if (file_bs != NULL) {
-            file = blk_new();
+            file = blk_new(BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
             blk_insert_bs(file, file_bs);
             bdrv_unref(file_bs);
 
diff --git a/block/backup.c b/block/backup.c
index fe010e7..4b3c94c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -624,7 +624,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    job->target = blk_new();
+    /* FIXME Use real permissions */
+    job->target = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(job->target, target);
 
     job->on_source_error = on_source_error;
diff --git a/block/block-backend.c b/block/block-backend.c
index 1ed75c6..0319220 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -120,17 +120,23 @@ static const BdrvChildRole child_root = {
 
 /*
  * Create a new BlockBackend with a reference count of one.
- * Store an error through @errp on failure, unless it's null.
+ *
+ * @perm is a bitmasks of BLK_PERM_* constants which describes the permissions
+ * to request for a block driver node that is attached to this BlockBackend.
+ * @shared_perm is a bitmask which describes which permissions may be granted
+ * to other users of the attached node.
+ * Both sets of permissions can be changed later using blk_set_perm().
+ *
  * Return the new BlockBackend on success, null on failure.
  */
-BlockBackend *blk_new(void)
+BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
 {
     BlockBackend *blk;
 
     blk = g_new0(BlockBackend, 1);
     blk->refcnt = 1;
-    blk->perm = 0;
-    blk->shared_perm = BLK_PERM_ALL;
+    blk->perm = perm;
+    blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
     qemu_co_queue_init(&blk->public.throttled_reqs[0]);
@@ -161,7 +167,7 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
     BlockBackend *blk;
     BlockDriverState *bs;
 
-    blk = blk_new();
+    blk = blk_new(0, BLK_PERM_ALL);
     bs = bdrv_open(filename, reference, options, flags, errp);
     if (!bs) {
         blk_unref(blk);
@@ -505,9 +511,10 @@ void blk_remove_bs(BlockBackend *blk)
 void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs)
 {
     bdrv_ref(bs);
-    /* FIXME Use real permissions */
+    /* FIXME Error handling */
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
-                                       0, BLK_PERM_ALL, blk, &error_abort);
+                                       blk->perm, blk->shared_perm, blk,
+                                       &error_abort);
 
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
diff --git a/block/commit.c b/block/commit.c
index c284e85..1897e98 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -275,10 +275,12 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         block_job_add_bdrv(&s->common, overlay_bs);
     }
 
-    s->base = blk_new();
+    /* FIXME Use real permissions */
+    s->base = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(s->base, base);
 
-    s->top = blk_new();
+    /* FIXME Use real permissions */
+    s->top = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(s->top, top);
 
     s->active = bs;
@@ -328,10 +330,12 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }
 
-    src = blk_new();
+    /* FIXME Use real permissions */
+    src = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(src, bs);
 
-    backing = blk_new();
+    /* FIXME Use real permissions */
+    backing = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(backing, bs->backing->bs);
 
     length = blk_getlength(src);
diff --git a/block/mirror.c b/block/mirror.c
index 13f793e..8f015b2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1012,7 +1012,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    s->target = blk_new();
+    /* FIXME Use real permissions */
+    s->target = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(s->target, target);
 
     s->replaces = g_strdup(replaces);
diff --git a/block/qcow2.c b/block/qcow2.c
index ef028f6..0356e69 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3262,7 +3262,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     }
 
     if (new_size) {
-        BlockBackend *blk = blk_new();
+        BlockBackend *blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
         blk_insert_bs(blk, bs);
         ret = blk_truncate(blk, new_size);
         blk_unref(blk);
diff --git a/blockdev.c b/blockdev.c
index 3596d87..10a12d1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -554,7 +554,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     if ((!file || !*file) && !qdict_size(bs_opts)) {
         BlockBackendRootState *blk_rs;
 
-        blk = blk_new();
+        blk = blk_new(0, BLK_PERM_ALL);
         blk_rs = blk_get_root_state(blk);
         blk_rs->open_flags    = bdrv_flags;
         blk_rs->read_only     = read_only;
@@ -2886,7 +2886,7 @@ void qmp_block_resize(bool has_device, const char *device,
         goto out;
     }
 
-    blk = blk_new();
+    blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
     blk_insert_bs(blk, bs);
 
     /* complete all in-flight operations before resizing the device */
diff --git a/blockjob.c b/blockjob.c
index abee11b..508e0e5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -159,7 +159,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
-    blk = blk_new();
+    /* FIXME Use real permissions */
+    blk = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(blk, bs);
 
     job = g_malloc0(driver->instance_size);
diff --git a/hmp.c b/hmp.c
index 2bc4f06..15fd3f7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2044,7 +2044,8 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     if (!blk) {
         BlockDriverState *bs = bdrv_lookup_bs(NULL, device, &err);
         if (bs) {
-            blk = local_blk = blk_new();
+            /* FIXME Use real permissions */
+            blk = local_blk = blk_new(0, BLK_PERM_ALL);
             blk_insert_bs(blk, bs);
         } else {
             goto fail;
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 17d29e7..74f3634 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -533,7 +533,8 @@ static int floppy_drive_init(DeviceState *qdev)
 
     if (!dev->conf.blk) {
         /* Anonymous BlockBackend for an empty drive */
-        dev->conf.blk = blk_new();
+        /* FIXME Use real permissions */
+        dev->conf.blk = blk_new(0, BLK_PERM_ALL);
         ret = blk_attach_dev(dev->conf.blk, qdev);
         assert(ret == 0);
     }
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 94f4d8b..cca4775 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -78,7 +78,8 @@ static void parse_drive(DeviceState *dev, const char *str, void **ptr,
     if (!blk) {
         BlockDriverState *bs = bdrv_lookup_bs(NULL, str, NULL);
         if (bs) {
-            blk = blk_new();
+            /* FIXME Use real permissions */
+            blk = blk_new(0, BLK_PERM_ALL);
             blk_insert_bs(blk, bs);
             blk_created = true;
         }
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index dbaa75c..bb3c377 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -170,7 +170,8 @@ static int ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind)
             return -1;
         } else {
             /* Anonymous BlockBackend for an empty drive */
-            dev->conf.blk = blk_new();
+            /* FIXME Use real permissions */
+            dev->conf.blk = blk_new(0, BLK_PERM_ALL);
         }
     }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index bbfb5dc..546acc7 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2380,7 +2380,8 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
 
     if (!dev->conf.blk) {
-        dev->conf.blk = blk_new();
+        /* FIXME Use real permissions */
+        dev->conf.blk = blk_new(0, BLK_PERM_ALL);
     }
 
     s->qdev.blocksize = 2048;
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 4a18e86..6651f43 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -84,7 +84,7 @@ typedef struct BlockBackendPublic {
     QLIST_ENTRY(BlockBackendPublic) round_robin;
 } BlockBackendPublic;
 
-BlockBackend *blk_new(void);
+BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
 int blk_get_refcnt(BlockBackend *blk);
diff --git a/migration/block.c b/migration/block.c
index ebc10e6..6b7ffd4 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -415,7 +415,8 @@ static void init_blk_migration(QEMUFile *f)
         }
 
         bmds = g_new0(BlkMigDevState, 1);
-        bmds->blk = blk_new();
+        /* FIXME Use real permissions */
+        bmds->blk = blk_new(0, BLK_PERM_ALL);
         bmds->blk_name = g_strdup(bdrv_get_device_name(bs));
         bmds->bulk_completed = 0;
         bmds->total_sectors = sectors;
diff --git a/nbd/server.c b/nbd/server.c
index ac92fa0..936d5aa 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -892,7 +892,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
     BlockBackend *blk;
     NBDExport *exp = g_malloc0(sizeof(NBDExport));
 
-    blk = blk_new();
+    /* FIXME Use real permissions */
+    blk = blk_new(0, BLK_PERM_ALL);
     blk_insert_bs(blk, bs);
     blk_set_enable_write_cache(blk, !writethrough);
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 068c9e4..1dd1cfa 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -53,7 +53,8 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
  * BlockDriverState inserted. */
 static BlockBackend *create_blk(const char *name)
 {
-    BlockBackend *blk = blk_new();
+    /* FIXME Use real permissions */
+    BlockBackend *blk = blk_new(0, BLK_PERM_ALL);
     BlockDriverState *bs;
 
     bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 363b59a..5846433 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -593,9 +593,10 @@ static void test_groups(void)
     BlockBackend *blk1, *blk2, *blk3;
     BlockBackendPublic *blkp1, *blkp2, *blkp3;
 
-    blk1 = blk_new();
-    blk2 = blk_new();
-    blk3 = blk_new();
+    /* FIXME Use real permissions */
+    blk1 = blk_new(0, BLK_PERM_ALL);
+    blk2 = blk_new(0, BLK_PERM_ALL);
+    blk3 = blk_new(0, BLK_PERM_ALL);
 
     blkp1 = blk_get_public(blk1);
     blkp2 = blk_get_public(blk2);
-- 
1.8.3.1
