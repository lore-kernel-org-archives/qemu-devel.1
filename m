Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKD-0007uJ-Vg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfKC-0005oP-WD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:40 +0200
Message-Id: <20180518132114.4070-7-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/40] job: Add job_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This moves freeing the Job object and its fields from block_job_unref()
to job_delete().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/qemu/job.h | 3 +++
 blockjob.c         | 3 +--
 job.c              | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 279ce688fd..43dc2e4a7d 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -62,6 +62,9 @@ struct JobDriver {
  */
 void *job_create(const char *job_id, const JobDriver *driver, Error **errp);
 
+/** Frees the @job object. */
+void job_delete(Job *job);
+
 /** Returns the JobType of a given Job. */
 JobType job_type(const Job *job);
 
diff --git a/blockjob.c b/blockjob.c
index ea71ec0129..430a67ba63 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -261,9 +261,8 @@ void block_job_unref(BlockJob *job)
                                         block_job_detach_aio_context, job);
         blk_unref(job->blk);
         error_free(job->blocker);
-        g_free(job->job.id);
         assert(!timer_pending(&job->sleep_timer));
-        g_free(job);
+        job_delete(&job->job);
     }
 }
 
diff --git a/job.c b/job.c
index 83724a43de..cfdd008c52 100644
--- a/job.c
+++ b/job.c
@@ -56,3 +56,9 @@ void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
 
     return job;
 }
+
+void job_delete(Job *job)
+{
+    g_free(job->id);
+    g_free(job);
+}
-- 
2.13.6
