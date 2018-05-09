Received: from eggs.gnu.org ([2001:4830:134:3::10]:52102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRw5-0005JS-2c
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRw3-0001fm-Ns
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:05 +0200
Message-Id: <20180509162637.15575-11-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 10/42] job: Add JobDriver.job_type
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

This moves the job_type field from BlockJobDriver to JobDriver.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h |  3 ---
 include/qemu/job.h           | 11 +++++++++++
 block/backup.c               |  2 +-
 block/commit.c               |  2 +-
 block/mirror.c               |  4 ++--
 block/stream.c               |  2 +-
 blockjob.c                   | 16 +++++++---------
 job.c                        | 10 ++++++++++
 8 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 8e7e0a2f57..1e62d6dd30 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -38,9 +38,6 @@ struct BlockJobDriver {
     /** Generic JobDriver callbacks and settings */
     JobDriver job_driver;
 
-    /** String describing the operation, part of query-block-jobs QMP API */
-    JobType job_type;
-
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index b4b49f19e1..c87e951c8a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -26,6 +26,8 @@
 #ifndef JOB_H
 #define JOB_H
 
+#include "qapi/qapi-types-block-core.h"
+
 typedef struct JobDriver JobDriver;
 
 /**
@@ -45,6 +47,9 @@ typedef struct Job {
 struct JobDriver {
     /** Derived Job struct size */
     size_t instance_size;
+
+    /** Enum describing the operation */
+    JobType job_type;
 };
 
 
@@ -57,4 +62,10 @@ struct JobDriver {
  */
 void *job_create(const char *job_id, const JobDriver *driver, Error **errp);
 
+/** Returns the JobType of a given Job. */
+JobType job_type(Job *job);
+
+/** Returns the enum string for the JobType of a given Job. */
+const char *job_type_str(Job *job);
+
 #endif
diff --git a/block/backup.c b/block/backup.c
index c49ea92dca..baf8d432da 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -525,8 +525,8 @@ static void coroutine_fn backup_run(void *opaque)
 static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
+        .job_type               = JOB_TYPE_BACKUP,
     },
-    .job_type               = JOB_TYPE_BACKUP,
     .start                  = backup_run,
     .commit                 = backup_commit,
     .abort                  = backup_abort,
diff --git a/block/commit.c b/block/commit.c
index afa2b2bacf..32d29c890e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -217,8 +217,8 @@ out:
 static const BlockJobDriver commit_job_driver = {
     .job_driver = {
         .instance_size = sizeof(CommitBlockJob),
+        .job_type      = JOB_TYPE_COMMIT,
     },
-    .job_type      = JOB_TYPE_COMMIT,
     .start         = commit_run,
 };
 
diff --git a/block/mirror.c b/block/mirror.c
index 243a58f465..054972bdc1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -988,8 +988,8 @@ static void mirror_drain(BlockJob *job)
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
+        .job_type               = JOB_TYPE_MIRROR,
     },
-    .job_type               = JOB_TYPE_MIRROR,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
@@ -1000,8 +1000,8 @@ static const BlockJobDriver mirror_job_driver = {
 static const BlockJobDriver commit_active_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
+        .job_type               = JOB_TYPE_COMMIT,
     },
-    .job_type               = JOB_TYPE_COMMIT,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
diff --git a/block/stream.c b/block/stream.c
index 048bceb5d0..cb723f190a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -211,8 +211,8 @@ out:
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
+        .job_type      = JOB_TYPE_STREAM,
     },
-    .job_type      = JOB_TYPE_STREAM,
     .start         = stream_run,
 };
 
diff --git a/blockjob.c b/blockjob.c
index 788b8cf686..3cf28eb730 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -295,9 +295,7 @@ static void block_job_detach_aio_context(void *opaque)
 static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
-    return g_strdup_printf("%s job '%s'",
-                           JobType_str(job->driver->job_type),
-                           job->job.id);
+    return g_strdup_printf("%s job '%s'", job_type_str(&job->job), job->job.id);
 }
 
 static void child_job_drained_begin(BdrvChild *c)
@@ -839,7 +837,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
         return NULL;
     }
     info = g_new0(BlockJobInfo, 1);
-    info->type      = g_strdup(JobType_str(job->driver->job_type));
+    info->type      = g_strdup(job_type_str(&job->job));
     info->device    = g_strdup(job->job.id);
     info->len       = job->len;
     info->busy      = atomic_read(&job->busy);
@@ -870,7 +868,7 @@ static void block_job_event_cancelled(BlockJob *job)
         return;
     }
 
-    qapi_event_send_block_job_cancelled(job->driver->job_type,
+    qapi_event_send_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
                                         job->len,
                                         job->offset,
@@ -884,7 +882,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
         return;
     }
 
-    qapi_event_send_block_job_completed(job->driver->job_type,
+    qapi_event_send_block_job_completed(job_type(&job->job),
                                         job->job.id,
                                         job->len,
                                         job->offset,
@@ -898,7 +896,7 @@ static int block_job_event_pending(BlockJob *job)
 {
     block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
     if (!job->auto_finalize && !block_job_is_internal(job)) {
-        qapi_event_send_block_job_pending(job->driver->job_type,
+        qapi_event_send_block_job_pending(job_type(&job->job),
                                           job->job.id,
                                           &error_abort);
     }
@@ -972,7 +970,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                    block_job_sleep_timer_cb, job);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
-               JobType_str(driver->job_type));
+               job_type_str(&job->job));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
     bs->job = job;
 
@@ -1176,7 +1174,7 @@ void block_job_event_ready(BlockJob *job)
         return;
     }
 
-    qapi_event_send_block_job_ready(job->driver->job_type,
+    qapi_event_send_block_job_ready(job_type(&job->job),
                                     job->job.id,
                                     job->len,
                                     job->offset,
diff --git a/job.c b/job.c
index 87fd48468c..f00f401502 100644
--- a/job.c
+++ b/job.c
@@ -29,6 +29,16 @@
 #include "qemu/job.h"
 #include "qemu/id.h"
 
+JobType job_type(Job *job)
+{
+    return job->driver->job_type;
+}
+
+const char *job_type_str(Job *job)
+{
+    return JobType_str(job_type(job));
+}
+
 void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
 {
     Job *job;
-- 
2.13.6
