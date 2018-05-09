Received: from eggs.gnu.org ([2001:4830:134:3::10]:52942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwp-000689-QU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwo-00036d-Jt
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:35 +0200
Message-Id: <20180509162637.15575-41-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 40/42] job: Add query-jobs QMP command
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

This adds a minimal query-jobs implementation that shouldn't pose many
design questions. It can later be extended to expose more information,
and especially job-specific information.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 18 ----------------
 qapi/job.json        | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/job.h   |  3 +++
 job-qmp.c            | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 job.c                |  2 +-
 5 files changed, 117 insertions(+), 19 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f2da7d696d..d38dfa7836 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1051,24 +1051,6 @@
   'data': ['top', 'full', 'none', 'incremental'] }
 
 ##
-# @JobType:
-#
-# Type of a background job.
-#
-# @commit: block commit job type, see "block-commit"
-#
-# @stream: block stream job type, see "block-stream"
-#
-# @mirror: drive mirror job type, see "drive-mirror"
-#
-# @backup: drive backup job type, see "drive-backup"
-#
-# Since: 1.7
-##
-{ 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup'] }
-
-##
 # @JobVerb:
 #
 # Represents command verbs that can be applied to a job.
diff --git a/qapi/job.json b/qapi/job.json
index 7b84158292..742fa97768 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -5,6 +5,24 @@
 ##
 
 ##
+# @JobType:
+#
+# Type of a background job.
+#
+# @commit: block commit job type, see "block-commit"
+#
+# @stream: block stream job type, see "block-stream"
+#
+# @mirror: drive mirror job type, see "drive-mirror"
+#
+# @backup: drive backup job type, see "drive-backup"
+#
+# Since: 1.7
+##
+{ 'enum': 'JobType',
+  'data': ['commit', 'stream', 'mirror', 'backup'] }
+
+##
 # @JobStatus:
 #
 # Indicates the present state of a given job in its lifetime.
@@ -175,3 +193,44 @@
 # Since: 2.13
 ##
 { 'command': 'job-finalize', 'data': { 'id': 'str' } }
+
+##
+# @JobInfo:
+#
+# Information about a job.
+#
+# @id:                  The job identifier
+#
+# @type:                The job type
+#
+# @status:              Current job state/status
+#
+# @current-progress:    The current progress value
+#
+# @total-progress:      The maximum progress value
+#
+# @error:               If this field is present, the job failed; if it is
+#                       still missing in the CONCLUDED state, this indicates
+#                       successful completion.
+#
+#                       The value is a human-readable error message to describe
+#                       the reason for the job failure. It should not be parsed
+#                       by applications.
+#
+# Since: 2.13
+##
+{ 'struct': 'JobInfo',
+  'data': { 'id': 'str', 'type': 'JobType', 'status': 'JobStatus',
+            'current-progress': 'int', 'total-progress': 'int',
+            '*error': 'str' } }
+
+##
+# @query-jobs:
+#
+# Return information about jobs.
+#
+# Returns: a list with a @JobInfo for each active job
+#
+# Since: 2.13
+##
+{ 'command': 'query-jobs', 'returns': ['JobInfo'] }
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9e61663f3a..da1c56f515 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -391,6 +391,9 @@ JobType job_type(Job *job);
 /** Returns the enum string for the JobType of a given Job. */
 const char *job_type_str(Job *job);
 
+/** Returns true if the job should not be visible to the management layer. */
+bool job_is_internal(Job *job);
+
 /** Returns whether the job is scheduled for cancellation. */
 bool job_is_cancelled(Job *job);
 
diff --git a/job-qmp.c b/job-qmp.c
index f32cb8b73e..7425a2a490 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -138,3 +138,57 @@ void qmp_job_dismiss(const char *id, Error **errp)
     job_dismiss(&job, errp);
     aio_context_release(aio_context);
 }
+
+static JobInfo *job_query_single(Job *job, Error **errp)
+{
+    JobInfo *info;
+    const char *errmsg = NULL;
+
+    assert (!job_is_internal(job));
+
+    if (job->ret < 0) {
+        errmsg = strerror(-job->ret);
+    }
+
+    info = g_new(JobInfo, 1);
+    *info = (JobInfo) {
+        .id                 = g_strdup(job->id),
+        .type               = job_type(job),
+        .status             = job->status,
+        .current_progress   = job->progress_current,
+        .total_progress     = job->progress_total,
+        .has_error          = !!errmsg,
+        .error              = g_strdup(errmsg),
+    };
+
+    return info;
+}
+
+JobInfoList *qmp_query_jobs(Error **errp)
+{
+    JobInfoList *head = NULL, **p_next = &head;
+    Job *job;
+
+    for (job = job_next(NULL); job; job = job_next(job)) {
+        JobInfoList *elem;
+        AioContext *aio_context;
+
+        if (job_is_internal(job)) {
+            continue;
+        }
+        elem = g_new0(JobInfoList, 1);
+        aio_context = job->aio_context;
+        aio_context_acquire(aio_context);
+        elem->value = job_query_single(job, errp);
+        aio_context_release(aio_context);
+        if (!elem->value) {
+            g_free(elem);
+            qapi_free_JobInfoList(head);
+            return NULL;
+        }
+        *p_next = elem;
+        p_next = &elem->next;
+    }
+
+    return head;
+}
diff --git a/job.c b/job.c
index 4dc45648e9..178d540dc7 100644
--- a/job.c
+++ b/job.c
@@ -158,7 +158,7 @@ static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
     return rc;
 }
 
-static bool job_is_internal(Job *job)
+bool job_is_internal(Job *job)
 {
     return (job->id == NULL);
 }
-- 
2.13.6
