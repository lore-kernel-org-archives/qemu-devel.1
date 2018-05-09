Received: from eggs.gnu.org ([2001:4830:134:3::10]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvy-0005BH-VL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvx-0001Uw-I3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:25:59 +0200
Message-Id: <20180509162637.15575-5-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 04/42] blockjob: Implement
 block_job_set_speed() centrally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

All block job drivers support .set_speed and all of them duplicate the
same code to implement it. Move that code to blockjob.c and remove the
now useless callback.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/blockjob.h     |  2 ++
 include/block/blockjob_int.h |  3 ---
 block/backup.c               | 13 -------------
 block/commit.c               | 14 --------------
 block/mirror.c               | 14 --------------
 block/stream.c               | 14 --------------
 blockjob.c                   | 12 ++++--------
 7 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 22bf418209..5aa8a6aaec 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -29,6 +29,8 @@
 #include "block/block.h"
 #include "qemu/ratelimit.h"
 
+#define SLICE_TIME 100000000ULL /* ns */
+
 typedef struct BlockJobDriver BlockJobDriver;
 typedef struct BlockJobTxn BlockJobTxn;
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 642adce68b..870bd346a8 100644
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
index 95da62544f..21eb04f1d2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -22,7 +22,6 @@
 #include "qemu/ratelimit.h"
 #include "qemu/bitmap.h"
 
-#define SLICE_TIME    100000000ULL /* ns */
 #define MAX_IN_FLIGHT 16
 #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
 #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
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
index bdd34f3a76..5d050e65d3 100644
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
 
+    ratelimit_set_speed(&job->limit, speed, SLICE_TIME);
+
     job->speed = speed;
     if (speed && speed <= old_speed) {
         return;
-- 
2.13.6
