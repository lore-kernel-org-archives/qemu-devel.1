Received: from eggs.gnu.org ([2001:4830:134:3::10]:53446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZY-0002UE-Ex
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZT-0007Jh-J2
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:52 +0200
Message-Id: <20180523131155.12359-44-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 43/46] job: Add query-jobs QMP command
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

This adds a minimal query-jobs implementation that shouldn't pose many
design questions. It can later be extended to expose more information,
and especially job-specific information.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/job.json      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/job.h |  3 +++
 job-qmp.c          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 job.c              |  2 +-
 4 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/qapi/job.json b/qapi/job.json
index b84dc6c820..970124de76 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -205,3 +205,49 @@
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
+# @type:                The kind of job that is being performed
+#
+# @status:              Current job state/status
+#
+# @current-progress:    Progress made until now. The unit is arbitrary and the
+#                       value can only meaningfully be used for the ratio of
+#                       @current-progress to @total-progress. The value is
+#                       monotonically increasing.
+#
+# @total-progress:      Estimated @current-progress value at the completion of
+#                       the job. This value can arbitrarily change while the
+#                       job is running, in both directions.
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
index 92d1d249fe..8c8badf75e 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -392,6 +392,9 @@ JobType job_type(const Job *job);
 /** Returns the enum string for the JobType of a given Job. */
 const char *job_type_str(const Job *job);
 
+/** Returns true if the job should not be visible to the management layer. */
+bool job_is_internal(Job *job);
+
 /** Returns whether the job is scheduled for cancellation. */
 bool job_is_cancelled(Job *job);
 
diff --git a/job-qmp.c b/job-qmp.c
index b2e18cfd9c..7f38f63336 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -132,3 +132,57 @@ void qmp_job_dismiss(const char *id, Error **errp)
     job_dismiss(&job, errp);
     aio_context_release(aio_context);
 }
+
+static JobInfo *job_query_single(Job *job, Error **errp)
+{
+    JobInfo *info;
+    const char *errmsg = NULL;
+
+    assert(!job_is_internal(job));
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
index 599a1042cf..f026661b0f 100644
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
