Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk8y-0001Dr-HK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk3z-0006uC-R3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:05:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 17 Aug 2018 15:04:54 -0400
Message-Id: <20180817190457.8292-5-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-1-jsnow@redhat.com>
References: <20180817190457.8292-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Change the manual deferment to commit_complete into the implicit
callback to job_exit, renaming commit_complete to commit_exit.

This conversion does change the timing of when job_completed is
called to after the bdrv_replace_node and bdrv_unref calls, which
could have implications for bjob->blk which will now be put down
after this cleanup.

Kevin highlights that we did not take any permissions for that backend
at job creation time, so it is safe to reorder these operations.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/commit.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4a17bb73ec..93c3b6a39e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -68,19 +68,13 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
     return 0;
 }
 
-typedef struct {
-    int ret;
-} CommitCompleteData;
-
-static void commit_complete(Job *job, void *opaque)
+static void commit_exit(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    CommitCompleteData *data = opaque;
     BlockDriverState *top = blk_bs(s->top);
     BlockDriverState *base = blk_bs(s->base);
     BlockDriverState *commit_top_bs = s->commit_top_bs;
-    int ret = data->ret;
     bool remove_commit_top_bs = false;
 
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
@@ -93,8 +87,8 @@ static void commit_complete(Job *job, void *opaque)
 
     if (!job_is_cancelled(job) && ret == 0) {
         /* success */
-        ret = bdrv_drop_intermediate(s->commit_top_bs, base,
-                                     s->backing_file_str);
+        job->ret = bdrv_drop_intermediate(s->commit_top_bs, base,
+                                          s->backing_file_str);
     } else {
         /* XXX Can (or should) we somehow keep 'consistent read' blocked even
          * after the failed/cancelled commit job is gone? If we already wrote
@@ -117,9 +111,6 @@ static void commit_complete(Job *job, void *opaque)
      * bdrv_set_backing_hd() to fail. */
     block_job_remove_all_bdrv(bjob);
 
-    job_completed(job, ret);
-    g_free(data);
-
     /* If bdrv_drop_intermediate() didn't already do that, remove the commit
      * filter driver from the backing chain. Do this as the final step so that
      * the 'consistent read' permission can be granted.  */
@@ -137,7 +128,6 @@ static void commit_complete(Job *job, void *opaque)
 static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
-    CommitCompleteData *data;
     int64_t offset;
     uint64_t delay_ns = 0;
     int ret = 0;
@@ -210,9 +200,6 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
 out:
     qemu_vfree(buf);
 
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-    job_defer_to_main_loop(&s->common.job, commit_complete, data);
     return ret;
 }
 
@@ -224,6 +211,7 @@ static const BlockJobDriver commit_job_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = commit_run,
+        .exit          = commit_exit,
     },
 };
 
-- 
2.14.4
