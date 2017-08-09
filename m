Received: from eggs.gnu.org ([2001:4830:134:3::10]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRaw-0003Xe-I8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRau-0003gf-RW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:22 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  9 Aug 2017 17:02:53 +0300
Message-Id: <20170809140256.25584-4-el13635@mail.ntua.gr>
In-Reply-To: <20170809140256.25584-1-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 3/6] block: require job-id when device is a
 node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

With implicit filter nodes on the top of the graph it is not possible to
generate job-ids with the name of the device in block_job_create()
anymore, since the job's bs will not be a child_root.

Instead we can require that job-id is not NULL in block_job_create(),
and check that a job-id has been set in the callers of
block_job_create() in blockdev.c. It is more consistent to require an
explicit job-id when the device parameter in the job creation command,
eg

 { "execute": "drive-backup",
   "arguments": { "device": "drive0",
                  "sync": "full",
                  "target": "backup.img" } }

is not a BlockBackend name, instead of automatically getting it from the
root BS if device is a node name. That information is lost after calling
block_job_create(), so we can do it in its caller instead.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 blockdev.c                   | 65 +++++++++++++++++++++++++++++++++++++++-----
 blockjob.c                   | 16 ++++-------
 include/block/blockjob_int.h |  3 +-
 tests/test-blockjob.c        | 10 ++-----
 4 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index fc7b65c3f0..6ffa5b0b04 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3004,6 +3004,16 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         return;
     }
 
+    /* Always require a job-id when device is a node name */
+    if (!has_job_id) {
+        if (blk_by_name(device)) {
+            job_id = device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return;
+        }
+    }
+
     /* Skip implicit filter nodes */
     bs = bdrv_get_first_explicit(bs);
 
@@ -3058,7 +3068,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     /* backing_file string overrides base bs filename */
     base_name = has_backing_file ? backing_file : base_name;
 
-    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
+    stream_start(job_id, bs, base_bs, base_name,
                  has_speed ? speed : 0, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -3117,6 +3127,16 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     /* Skip implicit filter nodes */
     bs = bdrv_get_first_explicit(bs);
 
+    /* Always require a job-id when device is a node name */
+    if (!has_job_id) {
+        if (blk_by_name(device)) {
+            job_id = device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return;
+        }
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
@@ -3171,7 +3191,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
                              " but 'top' is the active layer");
             goto out;
         }
-        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
+        commit_active_start(job_id, bs, base_bs,
                             BLOCK_JOB_DEFAULT, speed, on_error,
                             filter_node_name, NULL, NULL, false, &local_err);
     } else {
@@ -3179,7 +3199,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         if (bdrv_op_is_blocked(overlay_bs, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
             goto out;
         }
-        commit_start(has_job_id ? job_id : NULL, bs, base_bs, top_bs, speed,
+        commit_start(job_id, bs, base_bs, top_bs, speed,
                      on_error, has_backing_file ? backing_file : NULL,
                      filter_node_name, &local_err);
     }
@@ -3220,7 +3240,13 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         backup->mode = NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     }
     if (!backup->has_job_id) {
-        backup->job_id = NULL;
+        /* Always require a job-id when device is a node name */
+        if (blk_by_name(backup->device)) {
+            backup->job_id = backup->device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return NULL;
+        }
     }
     if (!backup->has_compress) {
         backup->compress = false;
@@ -3366,7 +3392,13 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
         backup->on_target_error = BLOCKDEV_ON_ERROR_REPORT;
     }
     if (!backup->has_job_id) {
-        backup->job_id = NULL;
+        /* Always require a job-id when device is a node name */
+        if (blk_by_name(backup->device)) {
+            backup->job_id = backup->device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return NULL;
+        }
     }
     if (!backup->has_compress) {
         backup->compress = false;
@@ -3509,6 +3541,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    /* Always require a job-id when device is a node name */
+    if (!arg->has_job_id) {
+        if (blk_by_name(arg->device)) {
+            arg->job_id = arg->device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return;
+        }
+    }
+
     /* Skip implicit filter nodes */
     bs = bdrv_get_first_explicit(bs);
 
@@ -3624,7 +3666,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     bdrv_set_aio_context(target_bs, aio_context);
 
-    blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
+    blockdev_mirror_common(arg->job_id, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
@@ -3674,12 +3716,21 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
         return;
     }
 
+    /* Always require a job-id when device is a node name */
+    if (!has_job_id) {
+        if (blk_by_name(device)) {
+            job_id = device;
+        } else {
+            error_setg(errp, "An explicit job ID is required for this node");
+            return;
+        }
+    }
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
     bdrv_set_aio_context(target_bs, aio_context);
 
-    blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
+    blockdev_mirror_common(job_id, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
                            has_speed, speed,
                            has_granularity, granularity,
diff --git a/blockjob.c b/blockjob.c
index 70a78188b7..ba26890ae9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -622,20 +622,14 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         return NULL;
     }
 
-    if (job_id == NULL && !(flags & BLOCK_JOB_INTERNAL)) {
-        job_id = bdrv_get_device_name(bs);
-        if (!*job_id) {
-            error_setg(errp, "An explicit job ID is required for this node");
-            return NULL;
-        }
-    }
-
-    if (job_id) {
-        if (flags & BLOCK_JOB_INTERNAL) {
+    if (flags & BLOCK_JOB_INTERNAL) {
+        if (job_id) {
             error_setg(errp, "Cannot specify job ID for internal block job");
             return NULL;
         }
-
+    } else {
+        /* Require job-id. */
+        assert(job_id);
         if (!id_wellformed(job_id)) {
             error_setg(errp, "Invalid job ID '%s'", job_id);
             return NULL;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f13ad05c0d..ff906808a6 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -112,8 +112,7 @@ struct BlockJobDriver {
 
 /**
  * block_job_create:
- * @job_id: The id of the newly-created job, or %NULL to have one
- * generated automatically.
+ * @job_id: The id of the newly-created job, must be non %NULL.
  * @job_type: The class object for the newly-created job.
  * @bs: The block
  * @perm, @shared_perm: Permissions to request for @bs
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 23bdf1a932..83ce5f63c7 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -93,9 +93,6 @@ static void test_job_ids(void)
     blk[1] = create_blk("drive1");
     blk[2] = create_blk("drive2");
 
-    /* No job ID provided and the block backend has no name */
-    job[0] = do_test_id(blk[0], NULL, false);
-
     /* These are all invalid job IDs */
     job[0] = do_test_id(blk[0], "0id", false);
     job[0] = do_test_id(blk[0], "",    false);
@@ -119,16 +116,15 @@ static void test_job_ids(void)
     block_job_early_fail(job[0]);
     job[1] = do_test_id(blk[1], "id0", true);
 
-    /* No job ID specified, defaults to the backend name ('drive1') */
     block_job_early_fail(job[1]);
-    job[1] = do_test_id(blk[1], NULL, true);
+    job[1] = do_test_id(blk[1], "drive1", true);
 
     /* Duplicate job ID */
     job[2] = do_test_id(blk[2], "drive1", false);
 
-    /* The ID of job[2] would default to 'drive2' but it is already in use */
+    /* The ID of job[2] is already in use */
     job[0] = do_test_id(blk[0], "drive2", true);
-    job[2] = do_test_id(blk[2], NULL, false);
+    job[2] = do_test_id(blk[2], "drive2", false);
 
     /* This one is valid */
     job[2] = do_test_id(blk[2], "id_2", true);
-- 
2.11.0
