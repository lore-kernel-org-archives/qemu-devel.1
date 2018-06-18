Received: from eggs.gnu.org ([2001:4830:134:3::10]:52340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHi-0005Ft-He
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHh-0006Vj-NT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:45:01 +0200
Message-Id: <20180618164504.24488-33-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 32/35] job: Add job_progress_increase_remaining()
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180613181823.13618-12-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/job.h | 15 +++++++++++++++
 job.c              |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 1d820530fa..18c9223e31 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -335,6 +335,21 @@ void job_progress_update(Job *job, uint64_t done);
  */
 void job_progress_set_remaining(Job *job, uint64_t remaining);
 
+/**
+ * @job: The job whose expected progress end value is updated
+ * @delta: Value which is to be added to the current expected end
+ *         value
+ *
+ * Increases the expected end value of the progress counter of a job.
+ * This is useful for parenthesis operations: If a job has to
+ * conditionally perform a high-priority operation as part of its
+ * progress, it calls this function with the expected operation's
+ * length before, and job_progress_update() afterwards.
+ * (So the operation acts as a parenthesis in regards to the main job
+ * operation running in background.)
+ */
+void job_progress_increase_remaining(Job *job, uint64_t delta);
+
 /** To be called when a cancelled job is finalised. */
 void job_event_cancelled(Job *job);
 
diff --git a/job.c b/job.c
index 84e140238b..fa671b431a 100644
--- a/job.c
+++ b/job.c
@@ -385,6 +385,11 @@ void job_progress_set_remaining(Job *job, uint64_t remaining)
     job->progress_total = job->progress_current + remaining;
 }
 
+void job_progress_increase_remaining(Job *job, uint64_t delta)
+{
+    job->progress_total += delta;
+}
+
 void job_event_cancelled(Job *job)
 {
     notifier_list_notify(&job->on_finalize_cancelled, job);
-- 
2.13.6
