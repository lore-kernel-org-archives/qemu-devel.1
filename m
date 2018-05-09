Received: from eggs.gnu.org ([2001:4830:134:3::10]:51976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvz-0005BL-2P
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvx-0001VA-JC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:25:58 +0200
Message-Id: <20180509162637.15575-4-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 03/42] blockjob: Move RateLimit to BlockJob
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

Every block job has a RateLimit, and they all do the exact same thing
with it, so it should be common infrastructure. Move the struct field
for a start.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/blockjob.h | 4 ++++
 block/backup.c           | 5 ++---
 block/commit.c           | 5 ++---
 block/mirror.c           | 6 +++---
 block/stream.c           | 5 ++---
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index a2cc52233b..22bf418209 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -27,6 +27,7 @@
 #define BLOCKJOB_H
 
 #include "block/block.h"
+#include "qemu/ratelimit.h"
 
 typedef struct BlockJobDriver BlockJobDriver;
 typedef struct BlockJobTxn BlockJobTxn;
@@ -118,6 +119,9 @@ typedef struct BlockJob {
     /** Speed that was set with @block_job_set_speed.  */
     int64_t speed;
 
+    /** Rate limiting data structure for implementing @speed. */
+    RateLimit limit;
+
     /** The completion function that will be called when the job completes.  */
     BlockCompletionFunc *cb;
 
diff --git a/block/backup.c b/block/backup.c
index 5d95805472..7585c4391e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -35,7 +35,6 @@ typedef struct BackupBlockJob {
     /* bitmap for sync=incremental */
     BdrvDirtyBitmap *sync_bitmap;
     MirrorSyncMode sync_mode;
-    RateLimit limit;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     CoRwlock flush_rwlock;
@@ -199,7 +198,7 @@ static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
+    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
 }
 
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
@@ -346,7 +345,7 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
      * (without, VM does not reboot)
      */
     if (job->common.speed) {
-        uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
+        uint64_t delay_ns = ratelimit_calculate_delay(&job->common.limit,
                                                       job->bytes_read);
         job->bytes_read = 0;
         block_job_sleep_ns(&job->common, delay_ns);
diff --git a/block/commit.c b/block/commit.c
index 50b191c980..beec5d0ad6 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -35,7 +35,6 @@ enum {
 
 typedef struct CommitBlockJob {
     BlockJob common;
-    RateLimit limit;
     BlockDriverState *commit_top_bs;
     BlockBackend *top;
     BlockBackend *base;
@@ -201,7 +200,7 @@ static void coroutine_fn commit_run(void *opaque)
         block_job_progress_update(&s->common, n);
 
         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, n);
+            delay_ns = ratelimit_calculate_delay(&s->common.limit, n);
         } else {
             delay_ns = 0;
         }
@@ -225,7 +224,7 @@ static void commit_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
+    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
 }
 
 static const BlockJobDriver commit_job_driver = {
diff --git a/block/mirror.c b/block/mirror.c
index 77ee9b1791..95da62544f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -36,7 +36,6 @@ typedef struct MirrorBuffer {
 
 typedef struct MirrorBlockJob {
     BlockJob common;
-    RateLimit limit;
     BlockBackend *target;
     BlockDriverState *mirror_top_bs;
     BlockDriverState *source;
@@ -450,7 +449,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         offset += io_bytes;
         nb_chunks -= DIV_ROUND_UP(io_bytes, s->granularity);
         if (s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, io_bytes_acct);
+            delay_ns = ratelimit_calculate_delay(&s->common.limit,
+                                                 io_bytes_acct);
         }
     }
     return delay_ns;
@@ -916,7 +916,7 @@ static void mirror_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
+    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
 }
 
 static void mirror_complete(BlockJob *job, Error **errp)
diff --git a/block/stream.c b/block/stream.c
index 8369852bda..a1d4768c2e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -33,7 +33,6 @@ enum {
 
 typedef struct StreamBlockJob {
     BlockJob common;
-    RateLimit limit;
     BlockDriverState *base;
     BlockdevOnError on_error;
     char *backing_file_str;
@@ -189,7 +188,7 @@ static void coroutine_fn stream_run(void *opaque)
         /* Publish progress */
         block_job_progress_update(&s->common, n);
         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit, n);
+            delay_ns = ratelimit_calculate_delay(&s->common.limit, n);
         } else {
             delay_ns = 0;
         }
@@ -219,7 +218,7 @@ static void stream_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER, "speed");
         return;
     }
-    ratelimit_set_speed(&s->limit, speed, SLICE_TIME);
+    ratelimit_set_speed(&s->common.limit, speed, SLICE_TIME);
 }
 
 static const BlockJobDriver stream_job_driver = {
-- 
2.13.6
