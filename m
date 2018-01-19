Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl6-00022w-VN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl5-000681-Uc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:33 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:47 -0500
Message-Id: <20180119205847.7141-14-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/13] blockjob: remove
 block_job_pause_point from interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Remove the last call in block/mirror, using relax instead.
relax may do nothing if we are canceled, so allow iteration to return
prematurely and allow mirror_run to handle the cancellation logic.

This is a functional change to mirror that should have the effect of
cancelled mirror jobs being able to respond to that request a little
sooner instead of launching new requests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c               |  4 +++-
 blockjob.c                   | 10 +++++++++-
 include/block/blockjob_int.h |  9 ---------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 192e03694f..8e6b5b25a9 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -345,7 +345,9 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         mirror_wait_for_io(s);
     }
 
-    block_job_pause_point(&s->common);
+    if (block_job_relax(&s->common, 0)) {
+        return 0;
+    }
 
     /* Find the number of consective dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
diff --git a/blockjob.c b/blockjob.c
index 40167d6896..27c13fdd08 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -60,6 +60,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
 static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
+static int coroutine_fn block_job_pause_point(BlockJob *job);
 
 /* Transactional group of block jobs */
 struct BlockJobTxn {
@@ -793,7 +794,14 @@ static void block_job_do_yield(BlockJob *job, uint64_t ns)
     assert(job->busy);
 }
 
-int coroutine_fn block_job_pause_point(BlockJob *job)
+/**
+ * block_job_pause_point:
+ * @job: The job that is ready to pause.
+ *
+ * Pause now if block_job_pause() has been called.  Block jobs that perform
+ * lots of I/O must call this between requests so that the job can be paused.
+ */
+static int coroutine_fn block_job_pause_point(BlockJob *job)
 {
     assert(job && block_job_started(job));
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index c4891a5a9b..57327cbc5a 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -201,15 +201,6 @@ void block_job_completed(BlockJob *job, int ret);
  */
 bool block_job_is_cancelled(BlockJob *job);
 
-/**
- * block_job_pause_point:
- * @job: The job that is ready to pause.
- *
- * Pause now if block_job_pause() has been called.  Block jobs that perform
- * lots of I/O must call this between requests so that the job can be paused.
- */
-int coroutine_fn block_job_pause_point(BlockJob *job);
-
 /**
  * block_job_enter:
  * @job: The job to enter.
-- 
2.14.3
