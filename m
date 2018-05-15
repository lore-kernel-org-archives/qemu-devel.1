Received: from eggs.gnu.org ([2001:4830:134:3::10]:38811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4S-0006iX-Tc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4R-0001U4-0A
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:10 +0200
Message-Id: <20180515154033.19899-15-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/37] blockjob: Implement block_job_set_speed()
 centrally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

All block job drivers support .set_speed and all of them duplicate the
same code to implement it. Move that code to blockjob.c and remove the
now useless callback.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h     |  2 ++
 include/block/blockjob_int.h |  3 ---
 block/backup.c               | 13 -------------
 block/commit.c               | 14 --------------
 block/mirror.c               | 26 ++++++--------------------
 block/stream.c               | 14 --------------
 blockjob.c                   | 12 ++++--------
 7 files changed, 12 insertions(+), 72 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 22bf418209..82f52f4b14 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -29,6 +29,8 @@
 #include "block/block.h"
 #include "qemu/ratelimit.h"
 
+#define BLOCK_JOB_SLICE_TIME 100000000ULL /* ns */
+
 typedef struct BlockJobDriver BlockJobDriver;
 typedef struct BlockJobTxn BlockJobTxn;
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index d5a515de9b..ad510d5a0c 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -41,9 +41,6 @@ struct BlockJobDriver {
     /** String describing the operation, part of query-block-jobs QMP API */
     BlockJobType job_type;
 
-    /** Optional callback for job types that support setting a speed limit */
-    void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
-
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
 
diff --git a/block/backup.c b/block/backup.c
index 7585c4391e..8468fd9f94 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -27,7 +27,6 @@
 #include "qemu/error-report.h"
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
-#define SLICE_TIME 100000000ULL /* ns */
 
 typedef struct BackupBlockJob {
     BlockJob common;
@@ -190,17 +189,6 @@ static int coroutine_fn backup_before_write_notify(
     return backup_do_cow(job, req->offset, req->bytes, NULL, true);
 }
 
-static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
-{
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
-
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
-    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
-}
-
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
@@ -540,7 +528,6 @@ static const BlockJobDriver backup_job_driver = {
     .instance_size          = sizeof(BackupBlockJob),
     .job_type               = BLOCK_JOB_TYPE_BACKUP,
     .start                  = backup_run,
-    .set_speed              = backup_set_speed,
     .commit                 = backup_commit,
     .abort                  = backup_abort,
     .clean                  = backup_clean,
diff --git a/block/commit.c b/block/commit.c
index beec5d0ad6..46cbeaec3e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -31,8 +31,6 @@ enum {
     COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
 };
 
-#define SLICE_TIME 100000000ULL /* ns */
-
 typedef struct CommitBlockJob {
     BlockJob common;
     BlockDriverState *commit_top_bs;
@@ -216,21 +214,9 @@ out:
     block_job_defer_to_main_loop(&s->common, commit_complete, data);
 }
 
-static void commit_set_speed(BlockJob *job, int64_t speed, Error **errp)
-{
-    CommitBlockJob *s = container_of(job, CommitBlockJob, common);
-
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
-    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
-}
-
 static const BlockJobDriver commit_job_driver = {
     .instance_size = sizeof(CommitBlockJob),
     .job_type      = BLOCK_JOB_TYPE_COMMIT,
-    .set_speed     = commit_set_speed,
     .start         = commit_run,
 };
 
diff --git a/block/mirror.c b/block/mirror.c
index 702c139368..6955d68804 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -22,7 +22,6 @@
 #include "qemu/ratelimit.h"
 #include "qemu/bitmap.h"
 
-#define SLICE_TIME    100000000ULL /* ns */
 #define MAX_IN_FLIGHT 16
 #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
 #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
@@ -596,7 +595,7 @@ static void mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 
-    if (now - s->last_pause_ns > SLICE_TIME) {
+    if (now - s->last_pause_ns > BLOCK_JOB_SLICE_TIME) {
         s->last_pause_ns = now;
         block_job_sleep_ns(&s->common, 0);
     } else {
@@ -799,11 +798,10 @@ static void coroutine_fn mirror_run(void *opaque)
 
         /* Note that even when no rate limit is applied we need to yield
          * periodically with no pending I/O so that bdrv_drain_all() returns.
-         * We do so every SLICE_TIME nanoseconds, or when there is an error,
-         * or when the source is clean, whichever comes first.
-         */
+         * We do so every BLKOCK_JOB_SLICE_TIME nanoseconds, or when there is
+         * an error, or when the source is clean, whichever comes first. */
         delta = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->last_pause_ns;
-        if (delta < SLICE_TIME &&
+        if (delta < BLOCK_JOB_SLICE_TIME &&
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
@@ -869,7 +867,8 @@ static void coroutine_fn mirror_run(void *opaque)
         ret = 0;
 
         if (s->synced && !should_complete) {
-            delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
+            delay_ns = (s->in_flight == 0 &&
+                        cnt == 0 ? BLOCK_JOB_SLICE_TIME : 0);
         }
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
         block_job_sleep_ns(&s->common, delay_ns);
@@ -908,17 +907,6 @@ immediate_exit:
     block_job_defer_to_main_loop(&s->common, mirror_exit, data);
 }
 
-static void mirror_set_speed(BlockJob *job, int64_t speed, Error **errp)
-{
-    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
-
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
-    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
-}
-
 static void mirror_complete(BlockJob *job, Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
@@ -1003,7 +991,6 @@ static void mirror_drain(BlockJob *job)
 static const BlockJobDriver mirror_job_driver = {
     .instance_size          = sizeof(MirrorBlockJob),
     .job_type               = BLOCK_JOB_TYPE_MIRROR,
-    .set_speed              = mirror_set_speed,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
@@ -1014,7 +1001,6 @@ static const BlockJobDriver mirror_job_driver = {
 static const BlockJobDriver commit_active_job_driver = {
     .instance_size          = sizeof(MirrorBlockJob),
     .job_type               = BLOCK_JOB_TYPE_COMMIT,
-    .set_speed              = mirror_set_speed,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
diff --git a/block/stream.c b/block/stream.c
index a1d4768c2e..797d7c4f21 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -29,8 +29,6 @@ enum {
     STREAM_BUFFER_SIZE = 512 * 1024, /* in bytes */
 };
 
-#define SLICE_TIME 100000000ULL /* ns */
-
 typedef struct StreamBlockJob {
     BlockJob common;
     BlockDriverState *base;
@@ -210,21 +208,9 @@ out:
     block_job_defer_to_main_loop(&s->common, stream_complete, data);
 }
 
-static void stream_set_speed(BlockJob *job, int64_t speed, Error **errp)
-{
-    StreamBlockJob *s = container_of(job, StreamBlockJob, common);
-
-    if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
-        return;
-    }
-    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
-}
-
 static const BlockJobDriver stream_job_driver = {
     .instance_size = sizeof(StreamBlockJob),
     .job_type      = BLOCK_JOB_TYPE_STREAM,
-    .set_speed     = stream_set_speed,
     .start         = stream_run,
 };
 
diff --git a/blockjob.c b/blockjob.c
index ebc26a5245..2f4b768338 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -659,22 +659,18 @@ static bool block_job_timer_pending(BlockJob *job)
 
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
-    Error *local_err = NULL;
     int64_t old_speed = job->speed;
 
-    if (!job->driver->set_speed) {
-        error_setg(errp, QERR_UNSUPPORTED);
-        return;
-    }
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_SET_SPEED, errp)) {
         return;
     }
-    job->driver->set_speed(job, speed, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (speed < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
 
+    ratelimit_set_speed(&job->limit, speed, BLOCK_JOB_SLICE_TIME);
+
     job->speed = speed;
     if (speed && speed <= old_speed) {
         return;
-- 
2.13.6
