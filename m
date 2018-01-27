Received: from eggs.gnu.org ([2001:4830:134:3::10]:37329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs7-00010Q-D2
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs4-0008Pp-J6
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:35 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:08 -0500
Message-Id: <20180127020515.27137-8-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 07/14] blockjobs: ensure abort is called for
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

This does NOT affect mirror jobs that are "canceled" during their
synchronous phase. The mirror job itself forcibly sets the canceled
property to false prior to ceding control, so such cases will invoke
the "commit" callback.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 2 +-
 blockjob.c     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index d729263708..a17248feab 100644
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
diff --git a/blockjob.c b/blockjob.c
index 0083fd7b0c..3d678d6ce2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -380,6 +380,11 @@ static void block_job_completed_single(BlockJob *job)
 {
     assert(job->completed);
 
+    /* Ensure abort is called and QMP client is notified of cancellation */
+    if (job->ret == 0 && block_job_is_cancelled(job)) {
+        job->ret = -ECANCELED;
+    }
+
     if (!job->ret) {
         if (job->driver->commit) {
             job->driver->commit(job);
-- 
2.14.3
