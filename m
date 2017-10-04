Received: from eggs.gnu.org ([2001:4830:134:3::10]:60705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrC-0005kM-RS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrB-0000Iz-Uj
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:18 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  3 Oct 2017 21:52:03 -0400
Message-Id: <20171004015205.20724-3-jsnow@redhat.com>
In-Reply-To: <20171004015205.20724-1-jsnow@redhat.com>
References: <20171004015205.20724-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] qmp: add block-job-reap command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

For jobs that have finished (either completed or canceled), allow the
user to dismiss the job's status reports via block-job-reap.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/trace-events   |  1 +
 blockdev.c           | 14 ++++++++++++++
 qapi/block-core.json | 21 +++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/block/trace-events b/block/trace-events
index 25dd5a3..9580efa 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -46,6 +46,7 @@ qmp_block_job_cancel(void *job) "job %p"
 qmp_block_job_pause(void *job) "job %p"
 qmp_block_job_resume(void *job) "job %p"
 qmp_block_job_complete(void *job) "job %p"
+qmp_block_job_reap(void *job) "job %p"
 qmp_block_stream(void *bs, void *job) "bs %p job %p"
 
 # block/file-win32.c
diff --git a/blockdev.c b/blockdev.c
index eeb4986..c08d6fb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3766,6 +3766,20 @@ void qmp_block_job_complete(const char *device, Error **errp)
     aio_context_release(aio_context);
 }
 
+void qmp_block_job_reap(const char *device, Error **errp)
+{
+    AioContext *aio_context;
+    BlockJob *job = find_block_job(device, &aio_context, errp);
+
+    if (!job) {
+        return;
+    }
+
+    trace_qmp_block_job_reap(job);
+    block_job_reap(&job, errp);
+    aio_context_release(aio_context);
+}
+
 void qmp_change_backing_file(const char *device,
                              const char *image_node_name,
                              const char *backing_file,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a4f5e10..5cce49d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2161,6 +2161,27 @@
 { 'command': 'block-job-complete', 'data': { 'device': 'str' } }
 
 ##
+# @block-job-reap:
+#
+# For jobs that have already completed, remove them from the block-job-query
+# list. This command only needs to be run for jobs which were started with the
+# persistent=true option.
+#
+# This command will refuse to operate on any job that has not yet reached
+# its terminal state. "cancel" or "complete" will still need to be used as
+# appropriate.
+#
+# @device: The job identifier. This used to be a device name (hence
+#          the name of the parameter), but since QEMU 2.7 it can have
+#          other values.
+#
+# Returns: Nothing on success
+#
+# Since: 2.11
+##
+{ 'command': 'block-job-reap', 'data': { 'device': 'str' } }
+
+##
 # @BlockdevDiscardOptions:
 #
 # Determines how to handle discard requests.
-- 
2.9.5
