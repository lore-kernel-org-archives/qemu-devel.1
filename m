Received: from eggs.gnu.org ([2001:4830:134:3::10]:59300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0N-0005eA-Ie
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0L-0001G9-Cy
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:22:40 -0400
Message-Id: <20180823222249.13518-5-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-1-jsnow@redhat.com>
References: <20180823222249.13518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/13] block/commit: refactor commit to use
 job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>

Use the component callbacks; prepare, abort, and clean.

NB: prepare is only called when the job has not yet failed;
and abort can be called after prepare.

complete -> prepare -> abort -> clean
complete -> abort -> clean

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/commit.c | 90 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index b6e8969877..9bf50385cf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
     BlockDriverState *commit_top_bs;
     BlockBackend *top;
     BlockBackend *base;
+    BlockDriverState *base_bs;
     BlockdevOnError on_error;
     int base_flags;
     char *backing_file_str;
@@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
     return 0;
 }
 
-static void commit_exit(Job *job)
+static int commit_prepare(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
-    BlockJob *bjob = &s->common;
-    BlockDriverState *top = blk_bs(s->top);
-    BlockDriverState *base = blk_bs(s->base);
-    BlockDriverState *commit_top_bs = s->commit_top_bs;
-    bool remove_commit_top_bs = false;
-
-    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
-    bdrv_ref(top);
-    bdrv_ref(commit_top_bs);
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
     blk_unref(s->base);
+    s->base = NULL;
 
-    if (!job_is_cancelled(job) && job->ret == 0) {
-        /* success */
-        job->ret = bdrv_drop_intermediate(s->commit_top_bs, base,
-                                          s->backing_file_str);
-    } else {
-        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
-         * after the failed/cancelled commit job is gone? If we already wrote
-         * something to base, the intermediate images aren't valid any more. */
-        remove_commit_top_bs = true;
+    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
+                                  s->backing_file_str);
+}
+
+static void commit_abort(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
+    BlockDriverState *top_bs = blk_bs(s->top);
+
+    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
+    bdrv_ref(top_bs);
+    bdrv_ref(s->commit_top_bs);
+
+    if (s->base) {
+        blk_unref(s->base);
     }
 
+    /* free the blockers on the intermediate nodes so that bdrv_replace_nodes
+     * can succeed */
+    block_job_remove_all_bdrv(&s->common);
+
+    /* If bdrv_drop_intermediate() didn't already do that, remove the commit
+     * filter driver from the backing chain. Do this as the final step so that
+     * the 'consistent read' permission can be granted.
+     *
+     * XXX Can (or should) we somehow keep 'consistent read' blocked even
+     * after the failed/cancelled commit job is gone? If we already wrote
+     * something to base, the intermediate images aren't valid any more. */
+    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
+                      &error_abort);
+
+    bdrv_unref(s->commit_top_bs);
+    bdrv_unref(top_bs);
+}
+
+static void commit_clean(Job *job)
+{
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
+
     /* restore base open flags here if appropriate (e.g., change the base back
      * to r/o). These reopens do not need to be atomic, since we won't abort
      * even on failure here */
-    if (s->base_flags != bdrv_get_flags(base)) {
-        bdrv_reopen(base, s->base_flags, NULL);
+    if (s->base_flags != bdrv_get_flags(s->base_bs)) {
+        bdrv_reopen(s->base_bs, s->base_flags, NULL);
     }
+
     g_free(s->backing_file_str);
     blk_unref(s->top);
-
-    /* If there is more than one reference to the job (e.g. if called from
-     * job_finish_sync()), job_completed() won't free it and therefore the
-     * blockers on the intermediate nodes remain. This would cause
-     * bdrv_set_backing_hd() to fail. */
-    block_job_remove_all_bdrv(bjob);
-
-    /* If bdrv_drop_intermediate() didn't already do that, remove the commit
-     * filter driver from the backing chain. Do this as the final step so that
-     * the 'consistent read' permission can be granted.  */
-    if (remove_commit_top_bs) {
-        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
-                                &error_abort);
-        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
-                          &error_abort);
-    }
-
-    bdrv_unref(commit_top_bs);
-    bdrv_unref(top);
 }
 
 static int coroutine_fn commit_run(Job *job, Error **errp)
@@ -211,7 +216,9 @@ static const BlockJobDriver commit_job_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = commit_run,
-        .exit          = commit_exit,
+        .prepare       = commit_prepare,
+        .abort         = commit_abort,
+        .clean         = commit_clean
     },
 };
 
@@ -345,6 +352,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     if (ret < 0) {
         goto fail;
     }
+    s->base_bs = base;
 
     /* Required permissions are already taken with block_job_add_bdrv() */
     s->top = blk_new(0, BLK_PERM_ALL);
-- 
2.14.4
