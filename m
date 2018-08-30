Received: from eggs.gnu.org ([2001:4830:134:3::10]:49660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDW-000102-Hj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDU-0006hD-QS
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Aug 2018 21:57:30 -0400
Message-Id: <20180830015734.19765-6-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
References: <20180830015734.19765-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/9] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, John Snow <jsnow@redhat.com>

Change the manual deferment to mirror_exit into the implicit
callback to job_exit and the mirror_exit callback.

This does change the order of some bdrv_unref calls and job_completed,
but thanks to the new context in which we call .exit, this is safe to
defer the possible flushing of any nodes to the job_finalize_single
cleanup stage.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index be5dc6b7b0..b8941db6c1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -607,26 +607,22 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
     }
 }
 
-typedef struct {
-    int ret;
-} MirrorExitData;
-
-static void mirror_exit(Job *job, void *opaque)
+static void mirror_exit(Job *job)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    MirrorExitData *data = opaque;
     MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
+    int ret = job->ret;
 
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
-    /* Make sure that the source BDS doesn't go away before we called
-     * job_completed(). */
+    /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
+     * before we can call bdrv_drained_end */
     bdrv_ref(src);
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
@@ -652,7 +648,7 @@ static void mirror_exit(Job *job, void *opaque)
             bdrv_set_backing_hd(target_bs, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
-                data->ret = -EPERM;
+                ret = -EPERM;
             }
         }
     }
@@ -662,7 +658,7 @@ static void mirror_exit(Job *job, void *opaque)
         aio_context_acquire(replace_aio_context);
     }
 
-    if (s->should_complete && data->ret == 0) {
+    if (s->should_complete && ret == 0) {
         BlockDriverState *to_replace = src;
         if (s->to_replace) {
             to_replace = s->to_replace;
@@ -679,7 +675,7 @@ static void mirror_exit(Job *job, void *opaque)
         bdrv_drained_end(target_bs);
         if (local_err) {
             error_report_err(local_err);
-            data->ret = -EPERM;
+            ret = -EPERM;
         }
     }
     if (s->to_replace) {
@@ -710,12 +706,12 @@ static void mirror_exit(Job *job, void *opaque)
     blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
     bs_opaque->job = NULL;
-    job_completed(job, data->ret);
 
-    g_free(data);
     bdrv_drained_end(src);
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
+
+    job->ret = ret;
 }
 
 static void mirror_throttle(MirrorBlockJob *s)
@@ -815,7 +811,6 @@ static int mirror_flush(MirrorBlockJob *s)
 static int coroutine_fn mirror_run(Job *job, Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
-    MirrorExitData *data;
     BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
@@ -1035,14 +1030,10 @@ immediate_exit:
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);
 
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-
     if (need_drain) {
         bdrv_drained_begin(bs);
     }
 
-    job_defer_to_main_loop(&s->common.job, mirror_exit, data);
     return ret;
 }
 
@@ -1141,6 +1132,7 @@ static const BlockJobDriver mirror_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
+        .exit                   = mirror_exit,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1157,6 +1149,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
+        .exit                   = mirror_exit,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
-- 
2.14.4
