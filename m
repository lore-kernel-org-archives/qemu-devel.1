Received: from eggs.gnu.org ([2001:4830:134:3::10]:53671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrM-0002R8-NN
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrJ-0000CW-MV
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:08 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:37 -0500
Message-Id: <20180310082746.24198-13-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 12/21] blockjobs: ensure abort is called for
 cancelled jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Presently, even if a job is canceled post-completion as a result of
a failing peer in a transaction, it will still call .commit because
nothing has updated or changed its return code.

The reason why this does not cause problems currently is because
backup's implementation of .commit checks for cancellation itself.

I'd like to simplify this contract:

(1) Abort is called if the job/transaction fails
(2) Commit is called if the job/transaction succeeds

To this end: A job's return code, if 0, will be forcibly set as
-ECANCELED if that job has already concluded. Remove the now
redundant check in the backup job implementation.

We need to check for cancellation in both block_job_completed
AND block_job_completed_single, because jobs may be cancelled between
those two calls; for instance in transactions. This also necessitates
an ABORTING -> ABORTING transition to be allowed.

The check in block_job_completed could be removed, but there's no
point in starting to attempt to succeed a transaction that we know
in advance will fail.

This does NOT affect mirror jobs that are "canceled" during their
synchronous phase. The mirror job itself forcibly sets the canceled
property to false prior to ceding control, so such cases will invoke
the "commit" callback.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c     |  2 +-
 block/trace-events |  1 +
 blockjob.c         | 21 ++++++++++++++++-----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 7e254dabff..453cd62c24 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -206,7 +206,7 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
     BdrvDirtyBitmap *bm;
     BlockDriverState *bs = blk_bs(job->common.blk);
 
-    if (ret < 0 || block_job_is_cancelled(&job->common)) {
+    if (ret < 0) {
         /* Merge the successor back into the parent, delete nothing. */
         bm = bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
         assert(bm);
diff --git a/block/trace-events b/block/trace-events
index 266afd9e99..5e531e0310 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -5,6 +5,7 @@ bdrv_open_common(void *bs, const char *filename, int flags, const char *format_n
 bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
 # blockjob.c
+block_job_completed(void *job, int ret, int jret) "job %p ret %d corrected ret %d"
 block_job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 block_job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
 
diff --git a/blockjob.c b/blockjob.c
index 59ac4a13c7..61af628376 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -51,7 +51,7 @@ bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
     /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0, 0, 0, 0},
     /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1, 1, 1, 0},
     /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0, 0, 0, 0},
-    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 0, 1, 0},
+    /* X: */ [BLOCK_JOB_STATUS_ABORTING]  = {0, 0, 0, 0, 0, 0, 1, 1, 0},
     /* E: */ [BLOCK_JOB_STATUS_CONCLUDED] = {0, 0, 0, 0, 0, 0, 0, 0, 1},
     /* N: */ [BLOCK_JOB_STATUS_NULL]      = {0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
@@ -405,13 +405,22 @@ static void block_job_conclude(BlockJob *job)
     }
 }
 
+static void block_job_update_rc(BlockJob *job)
+{
+    if (!job->ret && block_job_is_cancelled(job)) {
+        job->ret = -ECANCELED;
+    }
+    if (job->ret) {
+        block_job_state_transition(job, BLOCK_JOB_STATUS_ABORTING);
+    }
+}
+
 static void block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
 
-    if (job->ret || block_job_is_cancelled(job)) {
-        block_job_state_transition(job, BLOCK_JOB_STATUS_ABORTING);
-    }
+    /* Ensure abort is called for late-transactional failures */
+    block_job_update_rc(job);
 
     if (!job->ret) {
         if (job->driver->commit) {
@@ -896,7 +905,9 @@ void block_job_completed(BlockJob *job, int ret)
     assert(blk_bs(job->blk)->job == job);
     job->completed = true;
     job->ret = ret;
-    if (ret < 0 || block_job_is_cancelled(job)) {
+    block_job_update_rc(job);
+    trace_block_job_completed(job, ret, job->ret);
+    if (job->ret) {
         block_job_completed_txn_abort(job);
     } else {
         block_job_completed_txn_success(job);
-- 
2.14.3
