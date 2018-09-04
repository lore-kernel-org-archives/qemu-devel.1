Received: from eggs.gnu.org ([2001:4830:134:3::10]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpn-0004jK-1X
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxEpl-0001fC-Ks
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:09:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  4 Sep 2018 13:09:21 -0400
Message-Id: <20180904170930.28619-7-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-1-jsnow@redhat.com>
References: <20180904170930.28619-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/15] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

For purposes of minimum code movement, refactor the mirror_exit
callback to use the post-finalization callbacks in a trivial way.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 3365bcfdfb..26c30e9607 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
     int max_iov;
     bool initial_zeroing_ongoing;
     int in_active_write_counter;
+    bool prepared;
 } MirrorBlockJob;
 
 typedef struct MirrorBDSOpaque {
@@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
     }
 }
 
-static void mirror_exit(Job *job)
+static int mirror_exit_common(Job *job)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     BlockJob *bjob = &s->common;
@@ -617,7 +618,13 @@ static void mirror_exit(Job *job)
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
-    int ret = job->ret;
+    bool abort = job->ret < 0;
+    int ret = 0;
+
+    if (s->prepared) {
+        return 0;
+    }
+    s->prepared = true;
 
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
@@ -642,7 +649,7 @@ static void mirror_exit(Job *job)
      * required before it could become a backing file of target_bs. */
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
-    if (ret == 0 && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
+    if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
         if (backing_bs(target_bs) != backing) {
             bdrv_set_backing_hd(target_bs, backing, &local_err);
@@ -658,7 +665,7 @@ static void mirror_exit(Job *job)
         aio_context_acquire(replace_aio_context);
     }
 
-    if (s->should_complete && ret == 0) {
+    if (s->should_complete && !abort) {
         BlockDriverState *to_replace = s->to_replace ? s->to_replace : src;
 
         if (bdrv_get_flags(target_bs) != bdrv_get_flags(to_replace)) {
@@ -708,7 +715,18 @@ static void mirror_exit(Job *job)
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
 
-    job->ret = ret;
+    return ret;
+}
+
+static int mirror_prepare(Job *job)
+{
+    return mirror_exit_common(job);
+}
+
+static void mirror_abort(Job *job)
+{
+    int ret = mirror_exit_common(job);
+    assert(ret == 0);
 }
 
 static void mirror_throttle(MirrorBlockJob *s)
@@ -1129,7 +1147,8 @@ static const BlockJobDriver mirror_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
-        .exit                   = mirror_exit,
+        .prepare                = mirror_prepare,
+        .abort                  = mirror_abort,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1146,7 +1165,8 @@ static const BlockJobDriver commit_active_job_driver = {
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
         .run                    = mirror_run,
-        .exit                   = mirror_exit,
+        .prepare                = mirror_prepare,
+        .abort                  = mirror_abort,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
-- 
2.14.4
