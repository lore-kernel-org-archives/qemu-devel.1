Received: from eggs.gnu.org ([2001:4830:134:3::10]:52786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ1-0001p7-Fm
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYr-0006rs-Db
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:19 +0200
Message-Id: <20180523131155.12359-11-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/46] job: Rename BlockJobType into JobType
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

QAPI types aren't externally visible, so we can rename them without
causing problems. Before we add a job type to Job, rename the enum
so it can be used for more than just block jobs.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json         | 14 +++++++-------
 include/block/blockjob_int.h |  2 +-
 block/backup.c               |  2 +-
 block/commit.c               |  2 +-
 block/mirror.c               |  4 ++--
 block/stream.c               |  2 +-
 blockjob.c                   |  6 +++---
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0e29abf099..63c6011411 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1050,9 +1050,9 @@
   'data': ['top', 'full', 'none', 'incremental'] }
 
 ##
-# @BlockJobType:
+# @JobType:
 #
-# Type of a block job.
+# Type of a background job.
 #
 # @commit: block commit job type, see "block-commit"
 #
@@ -1064,7 +1064,7 @@
 #
 # Since: 1.7
 ##
-{ 'enum': 'BlockJobType',
+{ 'enum': 'JobType',
   'data': ['commit', 'stream', 'mirror', 'backup'] }
 
 ##
@@ -4499,7 +4499,7 @@
 #
 ##
 { 'event': 'BLOCK_JOB_COMPLETED',
-  'data': { 'type'  : 'BlockJobType',
+  'data': { 'type'  : 'JobType',
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
@@ -4535,7 +4535,7 @@
 #
 ##
 { 'event': 'BLOCK_JOB_CANCELLED',
-  'data': { 'type'  : 'BlockJobType',
+  'data': { 'type'  : 'JobType',
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
@@ -4600,7 +4600,7 @@
 #
 ##
 { 'event': 'BLOCK_JOB_READY',
-  'data': { 'type'  : 'BlockJobType',
+  'data': { 'type'  : 'JobType',
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
@@ -4627,7 +4627,7 @@
 #
 ##
 { 'event': 'BLOCK_JOB_PENDING',
-  'data': { 'type'  : 'BlockJobType',
+  'data': { 'type'  : 'JobType',
             'id'    : 'str' } }
 
 ##
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e8eca44747..8e7e0a2f57 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -39,7 +39,7 @@ struct BlockJobDriver {
     JobDriver job_driver;
 
     /** String describing the operation, part of query-block-jobs QMP API */
-    BlockJobType job_type;
+    JobType job_type;
 
     /** Mandatory: Entrypoint for the Coroutine. */
     CoroutineEntry *start;
diff --git a/block/backup.c b/block/backup.c
index 9e672bbd5e..c49ea92dca 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -526,7 +526,7 @@ static const BlockJobDriver backup_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(BackupBlockJob),
     },
-    .job_type               = BLOCK_JOB_TYPE_BACKUP,
+    .job_type               = JOB_TYPE_BACKUP,
     .start                  = backup_run,
     .commit                 = backup_commit,
     .abort                  = backup_abort,
diff --git a/block/commit.c b/block/commit.c
index 18cbb2f9c4..afa2b2bacf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -218,7 +218,7 @@ static const BlockJobDriver commit_job_driver = {
     .job_driver = {
         .instance_size = sizeof(CommitBlockJob),
     },
-    .job_type      = BLOCK_JOB_TYPE_COMMIT,
+    .job_type      = JOB_TYPE_COMMIT,
     .start         = commit_run,
 };
 
diff --git a/block/mirror.c b/block/mirror.c
index aa1d6b742e..ed72656a23 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -989,7 +989,7 @@ static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
     },
-    .job_type               = BLOCK_JOB_TYPE_MIRROR,
+    .job_type               = JOB_TYPE_MIRROR,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
@@ -1001,7 +1001,7 @@ static const BlockJobDriver commit_active_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
     },
-    .job_type               = BLOCK_JOB_TYPE_COMMIT,
+    .job_type               = JOB_TYPE_COMMIT,
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
diff --git a/block/stream.c b/block/stream.c
index f88fc75141..048bceb5d0 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -212,7 +212,7 @@ static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
     },
-    .job_type      = BLOCK_JOB_TYPE_STREAM,
+    .job_type      = JOB_TYPE_STREAM,
     .start         = stream_run,
 };
 
diff --git a/blockjob.c b/blockjob.c
index 1464856eb5..2a3844721e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -310,7 +310,7 @@ static char *child_job_get_parent_desc(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
     return g_strdup_printf("%s job '%s'",
-                           BlockJobType_str(job->driver->job_type),
+                           JobType_str(job->driver->job_type),
                            job->job.id);
 }
 
@@ -847,7 +847,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
         return NULL;
     }
     info = g_new0(BlockJobInfo, 1);
-    info->type      = g_strdup(BlockJobType_str(job->driver->job_type));
+    info->type      = g_strdup(JobType_str(job->driver->job_type));
     info->device    = g_strdup(job->job.id);
     info->len       = job->len;
     info->busy      = atomic_read(&job->busy);
@@ -980,7 +980,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                    block_job_sleep_timer_cb, job);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
-               BlockJobType_str(driver->job_type));
+               JobType_str(driver->job_type));
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
     bs->job = job;
 
-- 
2.13.6
