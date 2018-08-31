Received: from eggs.gnu.org ([2001:4830:134:3::10]:57965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0T-0001eQ-Jp
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrup-00076M-UO
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:28:59 -0400
Message-Id: <20180831222907.16257-8-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/15] block/commit: refactor stream to use
 job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/stream.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 700eb239e4..81a7ec8ece 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,16 +54,16 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
-static void stream_exit(Job *job)
+static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
-    int ret = job->ret;
+    int ret = 0;
 
-    if (!job_is_cancelled(job) && bs->backing && ret == 0) {
+    if (bs->backing) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
@@ -75,12 +75,19 @@ static void stream_exit(Job *job)
         bdrv_set_backing_hd(bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            ret = -EPERM;
-            goto out;
+            return -EPERM;
         }
     }
 
-out:
+    return ret;
+}
+
+static void stream_clean(Job *job)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+    BlockJob *bjob = &s->common;
+    BlockDriverState *bs = blk_bs(bjob->blk);
+
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_flags != bdrv_get_flags(bs)) {
         /* Give up write permissions before making it read-only */
@@ -89,7 +96,6 @@ out:
     }
 
     g_free(s->backing_file_str);
-    job->ret = ret;
 }
 
 static int coroutine_fn stream_run(Job *job, Error **errp)
@@ -206,7 +212,8 @@ static const BlockJobDriver stream_job_driver = {
         .job_type      = JOB_TYPE_STREAM,
         .free          = block_job_free,
         .run           = stream_run,
-        .exit          = stream_exit,
+        .prepare       = stream_prepare,
+        .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
     },
-- 
2.14.4
