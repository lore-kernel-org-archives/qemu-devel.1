Received: from eggs.gnu.org ([2001:4830:134:3::10]:57085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMT-0003ZW-W5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMS-0006cQ-Oo
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:20 +0200
Message-Id: <20180613181823.13618-12-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/14] job: Add
 job_progress_increase_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

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
2.17.1
