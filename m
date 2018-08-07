Received: from eggs.gnu.org ([2001:4830:134:3::10]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth7-0004lp-NN
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth6-0001Mv-1u
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:44 -0400
Message-Id: <20180807043349.27196-17-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 16/21] block/commit: refactor commit to use job
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Use the component callbacks; prepare, commit, abort, and clean.

NB: prepare is only called when the job has not yet failed;
and abort can be called after prepare.

complete -> prepare -> abort -> clean
complete -> abort -> clean

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/commit.c | 94 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 33 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 1a4a56795f..6673a0544e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -35,7 +35,9 @@ typedef struct CommitBlockJob {
     BlockJob common;
     BlockDriverState *commit_top_bs;
     BlockBackend *top;
+    BlockDriverState *top_bs;
     BlockBackend *base;
+    BlockDriverState *base_bs;
     BlockdevOnError on_error;
     int base_flags;
     char *backing_file_str;
@@ -71,37 +73,37 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
 static void commit_exit(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
-    BlockJob *bjob = &s->common;
-    BlockDriverState *top = blk_bs(s->top);
-    BlockDriverState *base = blk_bs(s->base);
-    BlockDriverState *commit_top_bs = s->commit_top_bs;
-    int ret = job->ret;
-    bool remove_commit_top_bs = false;
+
+    s->top_bs = blk_bs(s->top);
+    s->base_bs = blk_bs(s->base);
 
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
-    bdrv_ref(top);
-    bdrv_ref(commit_top_bs);
+    bdrv_ref(s->top_bs);
+    bdrv_ref(s->commit_top_bs);
+}
 
-    /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
-     * the normal backing chain can be restored. */
-    blk_unref(s->base);
+static int commit_prepare(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
-    if (!job_is_cancelled(job) && ret == 0) {
-        /* success */
-        ret = bdrv_drop_intermediate(s->commit_top_bs, base,
-                                     s->backing_file_str);
-    } else {
-        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
-         * after the failed/cancelled commit job is gone? If we already wrote
-         * something to base, the intermediate images aren't valid any more. */
-        remove_commit_top_bs = true;
-    }
+     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
+      * the normal backing chain can be restored. */
+     blk_unref(s->base);
+     s->base = NULL;
+
+     return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
+                                   s->backing_file_str);
+}
+
+static void commit_exit_common(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
     /* restore base open flags here if appropriate (e.g., change the base back
      * to r/o). These reopens do not need to be atomic, since we won't abort
      * even on failure here */
-    if (s->base_flags != bdrv_get_flags(base)) {
-        bdrv_reopen(base, s->base_flags, NULL);
+    if (s->base_flags != bdrv_get_flags(s->base_bs)) {
+        bdrv_reopen(s->base_bs, s->base_flags, NULL);
     }
     g_free(s->backing_file_str);
     blk_unref(s->top);
@@ -110,21 +112,43 @@ static void commit_exit(Job *job)
      * job_finish_sync()), job_completed() won't free it and therefore the
      * blockers on the intermediate nodes remain. This would cause
      * bdrv_set_backing_hd() to fail. */
-    block_job_remove_all_bdrv(bjob);
+    block_job_remove_all_bdrv(&s->common);
+}
+
+static void commit_commit(Job *job)
+{
+    commit_exit_common(job);
+}
+
+static void commit_abort(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
+
+    if (s->base) {
+        blk_unref(s->base);
+    }
+
+    commit_exit_common(job);
+
+    /* XXX Can (or should) we somehow keep 'consistent read' blocked even
+     * after the failed/cancelled commit job is gone? If we already wrote
+     * something to base, the intermediate images aren't valid any more. */
 
     /* If bdrv_drop_intermediate() didn't already do that, remove the commit
      * filter driver from the backing chain. Do this as the final step so that
      * the 'consistent read' permission can be granted.  */
-    if (remove_commit_top_bs) {
-        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
-                                &error_abort);
-        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
-                          &error_abort);
-    }
+    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
+                      &error_abort);
+}
 
-    bdrv_unref(commit_top_bs);
-    bdrv_unref(top);
-    job->ret = ret;
+static void commit_clean(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
+
+    bdrv_unref(s->commit_top_bs);
+    bdrv_unref(s->top_bs);
 }
 
 static int coroutine_fn commit_run(Job *job)
@@ -214,6 +238,10 @@ static const BlockJobDriver commit_job_driver = {
         .drain         = block_job_drain,
         .start         = commit_run,
         .exit          = commit_exit,
+        .prepare       = commit_prepare,
+        .commit        = commit_commit,
+        .abort         = commit_abort,
+        .clean         = commit_clean
     },
 };
 
-- 
2.14.4
