Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRw5-0005KE-7t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRw2-0001e5-Mw
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:03 +0200
Message-Id: <20180509162637.15575-9-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 08/42] job: Create Job,
 JobDriver and job_create()
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

This is the first step towards creating an infrastructure for generic
background jobs that aren't tied to a block device. For now, Job only
stores its ID and JobDriver, the rest stays in BlockJob.

The following patches will move over more parts of BlockJob to Job if
they are meaningful outside the context of a block job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |  9 +++----
 include/block/blockjob_int.h |  4 +--
 include/qemu/job.h           | 60 ++++++++++++++++++++++++++++++++++++++++++++
 block/backup.c               |  4 ++-
 block/commit.c               |  4 ++-
 block/mirror.c               | 10 +++++---
 block/stream.c               |  4 ++-
 blockjob.c                   | 46 ++++++++++++++++-----------------
 job.c                        | 48 +++++++++++++++++++++++++++++++++++
 tests/test-bdrv-drain.c      |  4 ++-
 tests/test-blockjob-txn.c    |  4 ++-
 tests/test-blockjob.c        | 12 ++++++---
 MAINTAINERS                  |  2 ++
 Makefile.objs                |  2 +-
 14 files changed, 169 insertions(+), 44 deletions(-)
 create mode 100644 include/qemu/job.h
 create mode 100644 job.c

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 0b57d53084..8acc1a236a 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -26,6 +26,7 @@
 #ifndef BLOCKJOB_H
 #define BLOCKJOB_H
 
+#include "qemu/job.h"
 #include "block/block.h"
 #include "qemu/ratelimit.h"
 
@@ -40,6 +41,9 @@ typedef struct BlockJobTxn BlockJobTxn;
  * Long-running operation on a BlockDriverState.
  */
 typedef struct BlockJob {
+    /** Data belonging to the generic Job infrastructure */
+    Job job;
+
     /** The job type, including the job vtable.  */
     const BlockJobDriver *driver;
 
@@ -47,11 +51,6 @@ typedef struct BlockJob {
     BlockBackend *blk;
 
     /**
-     * The ID of the block job. May be NULL for internal jobs.
-     */
-    char *id;
-
-    /**
      * The coroutine that executes the job.  If not NULL, it is
      * reentered when busy is false and the job is cancelled.
      */
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 62ec964d09..e8eca44747 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -35,8 +35,8 @@
  * A class type for block job driver.
  */
 struct BlockJobDriver {
-    /** Derived BlockJob struct size */
-    size_t instance_size;
+    /** Generic JobDriver callbacks and settings */
+    JobDriver job_driver;
 
     /** String describing the operation, part of query-block-jobs QMP API */
     BlockJobType job_type;
diff --git a/include/qemu/job.h b/include/qemu/job.h
new file mode 100644
index 0000000000..b4b49f19e1
--- /dev/null
+++ b/include/qemu/job.h
@@ -0,0 +1,60 @@
+/*
+ * Declarations for background jobs
+ *
+ * Copyright (c) 2011 IBM Corp.
+ * Copyright (c) 2012, 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef JOB_H
+#define JOB_H
+
+typedef struct JobDriver JobDriver;
+
+/**
+ * Long-running operation.
+ */
+typedef struct Job {
+    /** The ID of the job. May be NULL for internal jobs. */
+    char *id;
+
+    /** The type of this job. */
+    const JobDriver *driver;
+} Job;
+
+/**
+ * Callbacks and other information about a Job driver.
+ */
+struct JobDriver {
+    /** Derived Job struct size */
+    size_t instance_size;
+};
+
+
+/**
+ * Create a new long-running job and return it.
+ *
+ * @job_id: The id of the newly-created job, or %NULL for internal jobs
+ * @driver: The class object for the newly-created job.
+ * @errp: Error object.
+ */
+void *job_create(const char *job_id, const JobDriver *driver, Error **errp);
+
+#endif
diff --git a/block/backup.c b/block/backup.c
index e14d99560d..9e672bbd5e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -523,7 +523,9 @@ static void coroutine_fn backup_run(void *opaque)
 }
 
 static const BlockJobDriver backup_job_driver = {
-    .instance_size          = sizeof(BackupBlockJob),
+    .job_driver = {
+        .instance_size          = sizeof(BackupBlockJob),
+    },
     .job_type               = BLOCK_JOB_TYPE_BACKUP,
     .start                  = backup_run,
     .commit                 = backup_commit,
diff --git a/block/commit.c b/block/commit.c
index ba5df6aa0a..18cbb2f9c4 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -215,7 +215,9 @@ out:
 }
 
 static const BlockJobDriver commit_job_driver = {
-    .instance_size = sizeof(CommitBlockJob),
+    .job_driver = {
+        .instance_size = sizeof(CommitBlockJob),
+    },
     .job_type      = BLOCK_JOB_TYPE_COMMIT,
     .start         = commit_run,
 };
diff --git a/block/mirror.c b/block/mirror.c
index 350f733d0a..c75c7100fb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -913,7 +913,7 @@ static void mirror_complete(BlockJob *job, Error **errp)
 
     if (!s->synced) {
         error_setg(errp, "The active block job '%s' cannot be completed",
-                   job->id);
+                   job->job.id);
         return;
     }
 
@@ -986,7 +986,9 @@ static void mirror_drain(BlockJob *job)
 }
 
 static const BlockJobDriver mirror_job_driver = {
-    .instance_size          = sizeof(MirrorBlockJob),
+    .job_driver = {
+        .instance_size          = sizeof(MirrorBlockJob),
+    },
     .job_type               = BLOCK_JOB_TYPE_MIRROR,
     .start                  = mirror_run,
     .complete               = mirror_complete,
@@ -996,7 +998,9 @@ static const BlockJobDriver mirror_job_driver = {
 };
 
 static const BlockJobDriver commit_active_job_driver = {
-    .instance_size          = sizeof(MirrorBlockJob),
+    .job_driver = {
+        .instance_size          = sizeof(MirrorBlockJob),
+    },
     .job_type               = BLOCK_JOB_TYPE_COMMIT,
     .start                  = mirror_run,
     .complete               = mirror_complete,
diff --git a/block/stream.c b/block/stream.c
index df9660d2fc..f88fc75141 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -209,7 +209,9 @@ out:
 }
 
 static const BlockJobDriver stream_job_driver = {
-    .instance_size = sizeof(StreamBlockJob),
+    .job_driver = {
+        .instance_size = sizeof(StreamBlockJob),
+    },
     .job_type      = BLOCK_JOB_TYPE_STREAM,
     .start         = stream_run,
 };
diff --git a/blockjob.c b/blockjob.c
index 9943218a34..35d604d05a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -34,7 +34,6 @@
 #include "qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
-#include "qemu/id.h"
 #include "qemu/timer.h"
 
 /* Right now, this mutex is only needed to synchronize accesses to job->busy
@@ -92,7 +91,8 @@ static int block_job_apply_verb(BlockJob *job, BlockJobVerb bv, Error **errp)
         return 0;
     }
     error_setg(errp, "Job '%s' in state '%s' cannot accept command verb '%s'",
-               job->id, BlockJobStatus_str(job->status), BlockJobVerb_str(bv));
+               job->job.id, BlockJobStatus_str(job->status),
+               BlockJobVerb_str(bv));
     return -EPERM;
 }
 
@@ -159,7 +159,7 @@ BlockJob *block_job_get(const char *id)
     BlockJob *job;
 
     QLIST_FOREACH(job, &block_jobs, job_list) {
-        if (job->id && !strcmp(id, job->id)) {
+        if (job->job.id && !strcmp(id, job->job.id)) {
             return job;
         }
     }
@@ -247,7 +247,7 @@ void block_job_unref(BlockJob *job)
                                         block_job_detach_aio_context, job);
         blk_unref(job->blk);
         error_free(job->blocker);
-        g_free(job->id);
+        g_free(job->job.id);
         assert(!timer_pending(&job->sleep_timer));
         g_free(job);
     }
@@ -297,7 +297,7 @@ static char *child_job_get_parent_desc(BdrvChild *c)
     BlockJob *job = c->opaque;
     return g_strdup_printf("%s job '%s'",
                            BlockJobType_str(job->driver->job_type),
-                           job->id);
+                           job->job.id);
 }
 
 static void child_job_drained_begin(BdrvChild *c)
@@ -351,7 +351,7 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
 
 bool block_job_is_internal(BlockJob *job)
 {
-    return (job->id == NULL);
+    return (job->job.id == NULL);
 }
 
 static bool block_job_started(BlockJob *job)
@@ -697,13 +697,13 @@ int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
 void block_job_complete(BlockJob *job, Error **errp)
 {
     /* Should not be reachable via external interface for internal jobs */
-    assert(job->id);
+    assert(job->job.id);
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_COMPLETE, errp)) {
         return;
     }
     if (job->pause_count || job->cancelled || !job->driver->complete) {
         error_setg(errp, "The active block job '%s' cannot be completed",
-                   job->id);
+                   job->job.id);
         return;
     }
 
@@ -712,7 +712,7 @@ void block_job_complete(BlockJob *job, Error **errp)
 
 void block_job_finalize(BlockJob *job, Error **errp)
 {
-    assert(job && job->id);
+    assert(job && job->job.id);
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_FINALIZE, errp)) {
         return;
     }
@@ -723,7 +723,7 @@ void block_job_dismiss(BlockJob **jobptr, Error **errp)
 {
     BlockJob *job = *jobptr;
     /* similarly to _complete, this is QMP-interface only. */
-    assert(job->id);
+    assert(job->job.id);
     if (block_job_apply_verb(job, BLOCK_JOB_VERB_DISMISS, errp)) {
         return;
     }
@@ -840,7 +840,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     }
     info = g_new0(BlockJobInfo, 1);
     info->type      = g_strdup(BlockJobType_str(job->driver->job_type));
-    info->device    = g_strdup(job->id);
+    info->device    = g_strdup(job->job.id);
     info->len       = job->len;
     info->busy      = atomic_read(&job->busy);
     info->paused    = job->pause_count > 0;
@@ -871,7 +871,7 @@ static void block_job_event_cancelled(BlockJob *job)
     }
 
     qapi_event_send_block_job_cancelled(job->driver->job_type,
-                                        job->id,
+                                        job->job.id,
                                         job->len,
                                         job->offset,
                                         job->speed,
@@ -885,7 +885,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
     }
 
     qapi_event_send_block_job_completed(job->driver->job_type,
-                                        job->id,
+                                        job->job.id,
                                         job->len,
                                         job->offset,
                                         job->speed,
@@ -899,7 +899,7 @@ static int block_job_event_pending(BlockJob *job)
     block_job_state_transition(job, BLOCK_JOB_STATUS_PENDING);
     if (!job->auto_finalize && !block_job_is_internal(job)) {
         qapi_event_send_block_job_pending(job->driver->job_type,
-                                          job->id,
+                                          job->job.id,
                                           &error_abort);
     }
     return 0;
@@ -937,12 +937,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
             error_setg(errp, "Cannot specify job ID for internal block job");
             return NULL;
         }
-
-        if (!id_wellformed(job_id)) {
-            error_setg(errp, "Invalid job ID '%s'", job_id);
-            return NULL;
-        }
-
         if (block_job_get(job_id)) {
             error_setg(errp, "Job ID '%s' already in use", job_id);
             return NULL;
@@ -956,9 +950,13 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         return NULL;
     }
 
-    job = g_malloc0(driver->instance_size);
+    job = job_create(job_id, &driver->job_driver, errp);
+    if (job == NULL) {
+        blk_unref(blk);
+        return NULL;
+    }
+
     job->driver        = driver;
-    job->id            = g_strdup(job_id);
     job->blk           = blk;
     job->cb            = cb;
     job->opaque        = opaque;
@@ -1179,7 +1177,7 @@ void block_job_event_ready(BlockJob *job)
     }
 
     qapi_event_send_block_job_ready(job->driver->job_type,
-                                    job->id,
+                                    job->job.id,
                                     job->len,
                                     job->offset,
                                     job->speed, &error_abort);
@@ -1209,7 +1207,7 @@ BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
         abort();
     }
     if (!block_job_is_internal(job)) {
-        qapi_event_send_block_job_error(job->id,
+        qapi_event_send_block_job_error(job->job.id,
                                         is_read ? IO_OPERATION_TYPE_READ :
                                         IO_OPERATION_TYPE_WRITE,
                                         action, &error_abort);
diff --git a/job.c b/job.c
new file mode 100644
index 0000000000..87fd48468c
--- /dev/null
+++ b/job.c
@@ -0,0 +1,48 @@
+/*
+ * Background jobs (long-running operations)
+ *
+ * Copyright (c) 2011 IBM Corp.
+ * Copyright (c) 2012, 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qemu/job.h"
+#include "qemu/id.h"
+
+void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
+{
+    Job *job;
+
+    if (job_id) {
+        if (!id_wellformed(job_id)) {
+            error_setg(errp, "Invalid job ID '%s'", job_id);
+            return NULL;
+        }
+    }
+
+    job = g_malloc0(driver->instance_size);
+    job->driver        = driver;
+    job->id            = g_strdup(job_id);
+
+    return job;
+}
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 7673de1062..fe9f412b39 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -520,7 +520,9 @@ static void test_job_complete(BlockJob *job, Error **errp)
 }
 
 BlockJobDriver test_job_driver = {
-    .instance_size  = sizeof(TestBlockJob),
+    .job_driver = {
+        .instance_size  = sizeof(TestBlockJob),
+    },
     .start          = test_job_start,
     .complete       = test_job_complete,
 };
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 5789893dda..48b12d1744 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -74,7 +74,9 @@ static void test_block_job_cb(void *opaque, int ret)
 }
 
 static const BlockJobDriver test_block_job_driver = {
-    .instance_size = sizeof(TestBlockJob),
+    .job_driver = {
+        .instance_size = sizeof(TestBlockJob),
+    },
     .start = test_block_job_run,
 };
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 8946bfd37b..b82026180a 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -17,7 +17,9 @@
 #include "sysemu/block-backend.h"
 
 static const BlockJobDriver test_block_job_driver = {
-    .instance_size = sizeof(BlockJob),
+    .job_driver = {
+        .instance_size = sizeof(BlockJob),
+    },
 };
 
 static void block_job_cb(void *opaque, int ret)
@@ -38,9 +40,9 @@ static BlockJob *mk_job(BlockBackend *blk, const char *id,
         g_assert_null(errp);
         g_assert_nonnull(job);
         if (id) {
-            g_assert_cmpstr(job->id, ==, id);
+            g_assert_cmpstr(job->job.id, ==, id);
         } else {
-            g_assert_cmpstr(job->id, ==, blk_name(blk));
+            g_assert_cmpstr(job->job.id, ==, blk_name(blk));
         }
     } else {
         g_assert_nonnull(errp);
@@ -192,7 +194,9 @@ static void coroutine_fn cancel_job_start(void *opaque)
 }
 
 static const BlockJobDriver test_cancel_driver = {
-    .instance_size = sizeof(CancelJob),
+    .job_driver = {
+        .instance_size = sizeof(CancelJob),
+    },
     .start         = cancel_job_start,
     .complete      = cancel_job_complete,
 };
diff --git a/MAINTAINERS b/MAINTAINERS
index 459e3594e1..a97f60d104 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1369,6 +1369,8 @@ L: qemu-block@nongnu.org
 S: Supported
 F: blockjob.c
 F: include/block/blockjob.h
+F: job.c
+F: include/block/job.h
 F: block/backup.c
 F: block/commit.c
 F: block/stream.c
diff --git a/Makefile.objs b/Makefile.objs
index c6c9b8fc21..92b73fc272 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -63,7 +63,7 @@ chardev-obj-y = chardev/
 # block-obj-y is code used by both qemu system emulation and qemu-img
 
 block-obj-y += nbd/
-block-obj-y += block.o blockjob.o
+block-obj-y += block.o blockjob.o job.o
 block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
-- 
2.13.6
