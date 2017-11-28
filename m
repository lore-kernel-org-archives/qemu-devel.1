Received: from eggs.gnu.org ([2001:4830:134:3::10]:33895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3l-00055j-Fe
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3f-0005Xv-Op
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:33 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Nov 2017 16:43:48 +0100
Message-Id: <20171128154350.21504-3-kwolf@redhat.com>
In-Reply-To: <20171128154350.21504-1-kwolf@redhat.com>
References: <20171128154350.21504-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 2/4] Revert "blockjob: do not allow
 coroutine double entry or entry-after-completion"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This reverts commit 4afeffc8572f40d8844b946a30c00b10da4442b1.

This fixed the symptom of a bug rather than the root cause. Waking up a
sleeping coroutine is generally fine, we just need to make it work
correctly across AioContexts, which we'll do in a minute.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h | 3 +--
 blockjob.c                   | 7 ++-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 43f3be2965..f13ad05c0d 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -143,8 +143,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
  * @ns: How many nanoseconds to stop for.
  *
  * Put the job to sleep (assuming that it wasn't canceled) for @ns
- * nanoseconds.  Canceling the job will not interrupt the wait, so the
- * cancel will not process until the coroutine wakes up.
+ * nanoseconds.  Canceling the job will interrupt the wait immediately.
  */
 void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
 
diff --git a/blockjob.c b/blockjob.c
index ff9a614531..3a0c49137e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -797,14 +797,11 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
         return;
     }
 
-    /* We need to leave job->busy set here, because when we have
-     * put a coroutine to 'sleep', we have scheduled it to run in
-     * the future.  We cannot enter that same coroutine again before
-     * it wakes and runs, otherwise we risk double-entry or entry after
-     * completion. */
+    job->busy = false;
     if (!block_job_should_pause(job)) {
         co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
     }
+    job->busy = true;
 
     block_job_pause_point(job);
 }
-- 
2.13.6
