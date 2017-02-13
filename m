Received: from eggs.gnu.org ([2001:4830:134:3::10]:59589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMC-0003Y0-CO
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMA-0006F6-Ph
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:47 +0100
Message-Id: <1487006583-24350-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 25/41] blockjob: Add permissions to
 block_job_add_bdrv()
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

Block jobs don't actually do I/O through the the reference they create
with block_job_add_bdrv(), but they might want to use the permisssion
system to express what the block job does to intermediate nodes. This
adds permissions to block_job_add_bdrv() to provide the means to request
permissions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c           |  3 ++-
 block/commit.c           |  7 +++++--
 block/mirror.c           |  7 +++++--
 block/stream.c           |  3 ++-
 blockjob.c               | 27 +++++++++++++++++++++------
 include/block/blockjob.h |  4 +++-
 6 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 12ab25c..22171f4 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -657,7 +657,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
 
-    block_job_add_bdrv(&job->common, target);
+    /* FIXME Use real permissions */
+    block_job_add_bdrv(&job->common, target, 0, BLK_PERM_ALL, &error_abort);
     job->common.len = len;
     block_job_txn_add_job(txn, &job->common);
 
diff --git a/block/commit.c b/block/commit.c
index 60d29a9..68fa2a4 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -267,13 +267,16 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * disappear from the chain after this operation. */
     assert(bdrv_chain_contains(top, base));
     for (iter = top; iter != backing_bs(base); iter = backing_bs(iter)) {
-        block_job_add_bdrv(&s->common, iter);
+        /* FIXME Use real permissions */
+        block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_abort);
     }
     /* overlay_bs must be blocked because it needs to be modified to
      * update the backing image string, but if it's the root node then
      * don't block it again */
     if (bs != overlay_bs) {
-        block_job_add_bdrv(&s->common, overlay_bs);
+        /* FIXME Use real permissions */
+        block_job_add_bdrv(&s->common, overlay_bs, 0, BLK_PERM_ALL,
+                           &error_abort);
     }
 
     /* FIXME Use real permissions */
diff --git a/block/mirror.c b/block/mirror.c
index 22680d7..9532b18 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1020,13 +1020,16 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    block_job_add_bdrv(&s->common, target);
+    /* FIXME Use real permissions */
+    block_job_add_bdrv(&s->common, target, 0, BLK_PERM_ALL, &error_abort);
+
     /* In commit_active_start() all intermediate nodes disappear, so
      * any jobs in them must be blocked */
     if (bdrv_chain_contains(bs, target)) {
         BlockDriverState *iter;
         for (iter = backing_bs(bs); iter != target; iter = backing_bs(iter)) {
-            block_job_add_bdrv(&s->common, iter);
+            /* FIXME Use real permissions */
+            block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_abort);
         }
     }
 
diff --git a/block/stream.c b/block/stream.c
index 7f49279..47f0ffb 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -248,7 +248,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     /* Block all intermediate nodes between bs and base, because they
      * will disappear from the chain after this operation */
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
-        block_job_add_bdrv(&s->common, iter);
+        /* FIXME Use real permissions */
+        block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_abort);
     }
 
     s->base = base;
diff --git a/blockjob.c b/blockjob.c
index 27833c7..0bcc099 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -55,6 +55,10 @@ struct BlockJobTxn {
 
 static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
 
+static const BdrvChildRole child_job = {
+    .stay_at_node   = true,
+};
+
 BlockJob *block_job_next(BlockJob *job)
 {
     if (!job) {
@@ -115,11 +119,22 @@ static void block_job_detach_aio_context(void *opaque)
     block_job_unref(job);
 }
 
-void block_job_add_bdrv(BlockJob *job, BlockDriverState *bs)
+int block_job_add_bdrv(BlockJob *job, BlockDriverState *bs,
+                       uint64_t perm, uint64_t shared_perm, Error **errp)
 {
-    job->nodes = g_slist_prepend(job->nodes, bs);
+    BdrvChild *c;
+
+    c = bdrv_root_attach_child(bs, "job", &child_job, perm, shared_perm,
+                               NULL, errp);
+    if (c == NULL) {
+        return -EPERM;
+    }
+
+    job->nodes = g_slist_prepend(job->nodes, c);
     bdrv_ref(bs);
     bdrv_op_block_all(bs, job->blocker);
+
+    return 0;
 }
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
@@ -171,7 +186,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job = g_malloc0(driver->instance_size);
     error_setg(&job->blocker, "block device is in use by block job: %s",
                BlockJobType_lookup[driver->job_type]);
-    block_job_add_bdrv(job, bs);
+    block_job_add_bdrv(job, bs, 0, BLK_PERM_ALL, &error_abort);
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
 
     job->driver        = driver;
@@ -238,9 +253,9 @@ void block_job_unref(BlockJob *job)
         BlockDriverState *bs = blk_bs(job->blk);
         bs->job = NULL;
         for (l = job->nodes; l; l = l->next) {
-            bs = l->data;
-            bdrv_op_unblock_all(bs, job->blocker);
-            bdrv_unref(bs);
+            BdrvChild *c = l->data;
+            bdrv_op_unblock_all(c->bs, job->blocker);
+            bdrv_root_unref_child(c);
         }
         g_slist_free(job->nodes);
         blk_remove_aio_context_notifier(job->blk,
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 1acb256..b0b1134 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -170,12 +170,14 @@ BlockJob *block_job_get(const char *id);
  * block_job_add_bdrv:
  * @job: A block job
  * @bs: A BlockDriverState that is involved in @job
+ * @perm, @shared_perm: Permissions to request on the node
  *
  * Add @bs to the list of BlockDriverState that are involved in
  * @job. This means that all operations will be blocked on @bs while
  * @job exists.
  */
-void block_job_add_bdrv(BlockJob *job, BlockDriverState *bs);
+int block_job_add_bdrv(BlockJob *job, BlockDriverState *bs,
+                       uint64_t perm, uint64_t shared_perm, Error **errp);
 
 /**
  * block_job_set_speed:
-- 
1.8.3.1
