Received: from eggs.gnu.org ([2001:4830:134:3::10]:53472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZb-0002WX-HN
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZU-0007Kg-QX
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:51 +0200
Message-Id: <20180523131155.12359-43-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 42/46] job: Add lifecycle QMP commands
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

This adds QMP commands that control the transition between states of the
job lifecycle.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/job.json |  99 +++++++++++++++++++++++++++++++++++++++++++
 job-qmp.c     | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS   |   1 +
 Makefile.objs |   1 +
 trace-events  |   9 ++++
 5 files changed, 244 insertions(+)
 create mode 100644 job-qmp.c

diff --git a/qapi/job.json b/qapi/job.json
index 9fbdd0ccd9..b84dc6c820 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -106,3 +106,102 @@
 { 'event': 'JOB_STATUS_CHANGE',
   'data': { 'id': 'str',
             'status': 'JobStatus' } }
+
+##
+# @job-pause:
+#
+# Pause an active job.
+#
+# This command returns immediately after marking the active job for pausing.
+# Pausing an already paused job is an error.
+#
+# The job will pause as soon as possible, which means transitioning into the
+# PAUSED state if it was RUNNING, or into STANDBY if it was READY. The
+# corresponding JOB_STATUS_CHANGE event will be emitted.
+#
+# Cancelling a paused job automatically resumes it.
+#
+# @id: The job identifier.
+#
+# Since: 2.13
+##
+{ 'command': 'job-pause', 'data': { 'id': 'str' } }
+
+##
+# @job-resume:
+#
+# Resume a paused job.
+#
+# This command returns immediately after resuming a paused job. Resuming an
+# already running job is an error.
+#
+# @id : The job identifier.
+#
+# Since: 2.13
+##
+{ 'command': 'job-resume', 'data': { 'id': 'str' } }
+
+##
+# @job-cancel:
+#
+# Instruct an active background job to cancel at the next opportunity.
+# This command returns immediately after marking the active job for
+# cancellation.
+#
+# The job will cancel as soon as possible and then emit a JOB_STATUS_CHANGE
+# event. Usually, the status will change to ABORTING, but it is possible that
+# a job successfully completes (e.g. because it was almost done and there was
+# no opportunity to cancel earlier than completing the job) and transitions to
+# PENDING instead.
+#
+# @id: The job identifier.
+#
+# Since: 2.13
+##
+{ 'command': 'job-cancel', 'data': { 'id': 'str' } }
+
+
+##
+# @job-complete:
+#
+# Manually trigger completion of an active job in the READY state.
+#
+# @id: The job identifier.
+#
+# Since: 2.13
+##
+{ 'command': 'job-complete', 'data': { 'id': 'str' } }
+
+##
+# @job-dismiss:
+#
+# Deletes a job that is in the CONCLUDED state. This command only needs to be
+# run explicitly for jobs that don't have automatic dismiss enabled.
+#
+# This command will refuse to operate on any job that has not yet reached its
+# terminal state, JOB_STATUS_CONCLUDED. For jobs that make use of JOB_READY
+# event, job-cancel or job-complete will still need to be used as appropriate.
+#
+# @id: The job identifier.
+#
+# Since: 2.13
+##
+{ 'command': 'job-dismiss', 'data': { 'id': 'str' } }
+
+##
+# @job-finalize:
+#
+# Instructs all jobs in a transaction (or a single job if it is not part of any
+# transaction) to finalize any graph changes and do any necessary cleanup. This
+# command requires that all involved jobs are in the PENDING state.
+#
+# For jobs in a transaction, instructing one job to finalize will force
+# ALL jobs in the transaction to finalize, so it is only necessary to instruct
+# a single member job to finalize.
+#
+# @id: The identifier of any job in the transaction, or of a job that is not
+#      part of any transaction.
+#
+# Since: 2.13
+##
+{ 'command': 'job-finalize', 'data': { 'id': 'str' } }
diff --git a/job-qmp.c b/job-qmp.c
new file mode 100644
index 0000000000..b2e18cfd9c
--- /dev/null
+++ b/job-qmp.c
@@ -0,0 +1,134 @@
+/*
+ * QMP interface for background jobs
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
+#include "qemu/job.h"
+#include "qapi/qapi-commands-job.h"
+#include "qapi/error.h"
+#include "trace-root.h"
+
+/* Get a job using its ID and acquire its AioContext */
+static Job *find_job(const char *id, AioContext **aio_context, Error **errp)
+{
+    Job *job;
+
+    *aio_context = NULL;
+
+    job = job_get(id);
+    if (!job) {
+        error_setg(errp, "Job not found");
+        return NULL;
+    }
+
+    *aio_context = job->aio_context;
+    aio_context_acquire(*aio_context);
+
+    return job;
+}
+
+void qmp_job_cancel(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_cancel(job);
+    job_user_cancel(job, true, errp);
+    aio_context_release(aio_context);
+}
+
+void qmp_job_pause(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_pause(job);
+    job_user_pause(job, errp);
+    aio_context_release(aio_context);
+}
+
+void qmp_job_resume(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_resume(job);
+    job_user_resume(job, errp);
+    aio_context_release(aio_context);
+}
+
+void qmp_job_complete(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_complete(job);
+    job_complete(job, errp);
+    aio_context_release(aio_context);
+}
+
+void qmp_job_finalize(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_finalize(job);
+    job_finalize(job, errp);
+    aio_context_release(aio_context);
+}
+
+void qmp_job_dismiss(const char *id, Error **errp)
+{
+    AioContext *aio_context;
+    Job *job = find_job(id, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_job_dismiss(job);
+    job_dismiss(&job, errp);
+    aio_context_release(aio_context);
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index d49c16cdd7..4a0bc1e71b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1370,6 +1370,7 @@ S: Supported
 F: blockjob.c
 F: include/block/blockjob.h
 F: job.c
+F: job-qmp.c
 F: include/block/job.h
 F: block/backup.c
 F: block/commit.c
diff --git a/Makefile.objs b/Makefile.objs
index 3df8d58e49..c6c3554203 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -97,6 +97,7 @@ io-obj-y = io/
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
 common-obj-y += bootdevice.o iothread.o
+common-obj-y += job-qmp.o
 common-obj-y += net/
 common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
diff --git a/trace-events b/trace-events
index ef7579a285..c445f54773 100644
--- a/trace-events
+++ b/trace-events
@@ -109,6 +109,15 @@ job_state_transition(void *job,  int ret, const char *legal, const char *s0, con
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
 job_completed(void *job, int ret, int jret) "job %p ret %d corrected ret %d"
 
+# job-qmp.c
+qmp_job_cancel(void *job) "job %p"
+qmp_job_pause(void *job) "job %p"
+qmp_job_resume(void *job) "job %p"
+qmp_job_complete(void *job) "job %p"
+qmp_job_finalize(void *job) "job %p"
+qmp_job_dismiss(void *job) "job %p"
+
+
 ### Guest events, keep at bottom
 
 
-- 
2.13.6
