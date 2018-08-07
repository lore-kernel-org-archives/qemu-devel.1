Received: from eggs.gnu.org ([2001:4830:134:3::10]:54054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth5-0004jn-U9
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0001KB-NP
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:34 -0400
Message-Id: <20180807043349.27196-7-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 06/21] block/stream: utilize job_exit shim
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

Change the manual deferment to stream_complete into the implicit
callback to job_exit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/stream.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index a5d6e0cf8a..163cd6431c 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,20 +54,16 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
-typedef struct {
-    int ret;
-} StreamCompleteData;
-
-static void stream_complete(Job *job, void *opaque)
+static void stream_exit(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    StreamCompleteData *data = opaque;
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
+    int ret = job->ret;
 
-    if (!job_is_cancelled(job) && bs->backing && data->ret == 0) {
+    if (!job_is_cancelled(job) && bs->backing && ret == 0) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
@@ -75,11 +71,11 @@ static void stream_complete(Job *job, void *opaque)
                 base_fmt = base->drv->format_name;
             }
         }
-        data->ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
         bdrv_set_backing_hd(bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            data->ret = -EPERM;
+            ret = -EPERM;
             goto out;
         }
     }
@@ -93,14 +89,12 @@ out:
     }
 
     g_free(s->backing_file_str);
-    job_completed(job, data->ret);
-    g_free(data);
+    job->ret = ret;
 }
 
 static void coroutine_fn stream_run(void *opaque)
 {
     StreamBlockJob *s = opaque;
-    StreamCompleteData *data;
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *base = s->base;
@@ -203,9 +197,7 @@ static void coroutine_fn stream_run(void *opaque)
 
 out:
     /* Modify backing chain and close BDSes in main loop */
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-    job_defer_to_main_loop(&s->common.job, stream_complete, data);
+    s->common.job.ret = ret;
 }
 
 static const BlockJobDriver stream_job_driver = {
@@ -214,6 +206,7 @@ static const BlockJobDriver stream_job_driver = {
         .job_type      = JOB_TYPE_STREAM,
         .free          = block_job_free,
         .start         = stream_run,
+        .exit          = stream_exit,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
     },
-- 
2.14.4
