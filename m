Received: from eggs.gnu.org ([2001:4830:134:3::10]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuy-0000l2-KV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBux-00088h-4J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:52 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:27 +0100
Message-Id: <1487689130-30373-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 31/54] blockjob: Add permissions to
 block_job_create()
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

This functions creates a BlockBackend internally, so the block jobs need
to tell it what they want to do with the BB.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c               | 5 +++--
 block/commit.c               | 5 +++--
 block/mirror.c               | 5 +++--
 block/stream.c               | 5 +++--
 blockjob.c                   | 6 +++---
 include/block/blockjob_int.h | 4 +++-
 tests/test-blockjob-txn.c    | 6 +++---
 tests/test-blockjob.c        | 5 +++--
 8 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f38d1d0..c759684 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -618,8 +618,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    job = block_job_create(job_id, &backup_job_driver, bs, speed,
-                           creation_flags, cb, opaque, errp);
+    /* FIXME Use real permissions */
+    job = block_job_create(job_id, &backup_job_driver, bs, 0, BLK_PERM_ALL,
+                           speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
     }
diff --git a/block/commit.c b/block/commit.c
index 2ad8138..60d29a9 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -235,8 +235,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    s = block_job_create(job_id, &commit_job_driver, bs, speed,
-                         BLOCK_JOB_DEFAULT, NULL, NULL, errp);
+    /* FIXME Use real permissions */
+    s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
+                         speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
     }
diff --git a/block/mirror.c b/block/mirror.c
index c551bfc..9a61c1e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1010,8 +1010,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
-    s = block_job_create(job_id, driver, bs, speed, creation_flags,
-                         cb, opaque, errp);
+    /* FIXME Use real permissions */
+    s = block_job_create(job_id, driver, bs, 0, BLK_PERM_ALL, speed,
+                         creation_flags, cb, opaque, errp);
     if (!s) {
         return;
     }
diff --git a/block/stream.c b/block/stream.c
index 1523ba7..7f49279 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -229,8 +229,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     BlockDriverState *iter;
     int orig_bs_flags;
 
-    s = block_job_create(job_id, &stream_job_driver, bs, speed,
-                         BLOCK_JOB_DEFAULT, NULL, NULL, errp);
+    /* FIXME Use real permissions */
+    s = block_job_create(job_id, &stream_job_driver, bs, 0, BLK_PERM_ALL,
+                         speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
     }
diff --git a/blockjob.c b/blockjob.c
index 72b7d4c..27833c7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -123,7 +123,8 @@ void block_job_add_bdrv(BlockJob *job, BlockDriverState *bs)
 }
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, int64_t speed, int flags,
+                       BlockDriverState *bs, uint64_t perm,
+                       uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
     BlockBackend *blk;
@@ -160,8 +161,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         }
     }
 
-    /* FIXME Use real permissions */
-    blk = blk_new(0, BLK_PERM_ALL);
+    blk = blk_new(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         blk_unref(blk);
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 8223822..3f86cc5 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -119,6 +119,7 @@ struct BlockJobDriver {
  * generated automatically.
  * @job_type: The class object for the newly-created job.
  * @bs: The block
+ * @perm, @shared_perm: Permissions to request for @bs
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @cb: Completion function for the job.
  * @opaque: Opaque pointer value passed to @cb.
@@ -134,7 +135,8 @@ struct BlockJobDriver {
  * called from a wrapper that is specific to the job type.
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, int64_t speed, int flags,
+                       BlockDriverState *bs, uint64_t perm,
+                       uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
 /**
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index f6dfd08..4ccbda1 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -101,9 +101,9 @@ static BlockJob *test_block_job_start(unsigned int iterations,
     g_assert_nonnull(bs);
 
     snprintf(job_id, sizeof(job_id), "job%u", counter++);
-    s = block_job_create(job_id, &test_block_job_driver, bs, 0,
-                         BLOCK_JOB_DEFAULT, test_block_job_cb,
-                         data, &error_abort);
+    s = block_job_create(job_id, &test_block_job_driver, bs,
+                         0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT,
+                         test_block_job_cb, data, &error_abort);
     s->iterations = iterations;
     s->use_timer = use_timer;
     s->rc = rc;
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 143ce96..1afe17b 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -30,8 +30,9 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
     BlockJob *job;
     Error *errp = NULL;
 
-    job = block_job_create(id, &test_block_job_driver, blk_bs(blk), 0,
-                           BLOCK_JOB_DEFAULT, block_job_cb, NULL, &errp);
+    job = block_job_create(id, &test_block_job_driver, blk_bs(blk),
+                           0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
+                           NULL, &errp);
     if (should_succeed) {
         g_assert_null(errp);
         g_assert_nonnull(job);
-- 
1.8.3.1
