Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8P-0005vW-4W
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8N-00061C-0S
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:13 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:24 -0500
Message-Id: <20180223235142.21501-4-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 03/21] blockjobs: add manual property
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

This property will be used to opt-in to the new BlockJobs workflow
that allows a tighter, more explicit control over transitions from
one runstate to another.

While we're here, fix up the documentation for block_job_create
a little bit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                   |  1 +
 include/block/blockjob.h     | 10 ++++++++++
 include/block/blockjob_int.h |  4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 7ba3683ee3..47468331ec 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -700,6 +700,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->manual        = (flags & BLOCK_JOB_MANUAL);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9482..8ffabdcbc4 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,14 +141,24 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
+    /**
+     * Set to true when the management API has requested manual job
+     * management semantics.
+     */
+    bool manual;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
 } BlockJob;
 
 typedef enum BlockJobCreateFlags {
+    /* Default behavior */
     BLOCK_JOB_DEFAULT = 0x00,
+    /* BlockJob is not QMP-created and should not send QMP events */
     BLOCK_JOB_INTERNAL = 0x01,
+    /* BlockJob requests manual job management steps. */
+    BLOCK_JOB_MANUAL = 0x02,
 } BlockJobCreateFlags;
 
 /**
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index becaae74c2..259d49b32a 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -114,11 +114,13 @@ struct BlockJobDriver {
  * block_job_create:
  * @job_id: The id of the newly-created job, or %NULL to have one
  * generated automatically.
- * @job_type: The class object for the newly-created job.
+ * @driver: The class object for the newly-created job.
  * @txn: The transaction this job belongs to, if any. %NULL otherwise.
  * @bs: The block
  * @perm, @shared_perm: Permissions to request for @bs
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
+ * @flags: Creation flags for the Block Job.
+ *         See @BlockJobCreateFlags
  * @cb: Completion function for the job.
  * @opaque: Opaque pointer value passed to @cb.
  * @errp: Error object.
-- 
2.14.3
