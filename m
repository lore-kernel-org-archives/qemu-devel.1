Received: from eggs.gnu.org ([2001:4830:134:3::10]:38743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4R-0006gF-4u
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4P-0001Sh-Sz
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:11 +0200
Message-Id: <20180515154033.19899-16-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/37] blockjob: Introduce
 block_job_ratelimit_get_delay()
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

This gets us rid of more direct accesses to BlockJob fields from the
job drivers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob_int.h |  8 ++++++++
 block/backup.c               | 18 +++++++-----------
 block/commit.c               |  4 ++--
 block/mirror.c               |  5 +----
 block/stream.c               |  4 ++--
 blockjob.c                   |  9 +++++++++
 6 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index ad510d5a0c..62ec964d09 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -166,6 +166,14 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns);
 void block_job_yield(BlockJob *job);
 
 /**
+ * block_job_ratelimit_get_delay:
+ *
+ * Calculate and return delay for the next request in ns. See the documentation
+ * of ratelimit_calculate_delay() for details.
+ */
+int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
+
+/**
  * block_job_early_fail:
  * @bs: The block device.
  *
diff --git a/block/backup.c b/block/backup.c
index 8468fd9f94..cfdb6ecdf5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -325,21 +325,17 @@ static void backup_complete(BlockJob *job, void *opaque)
 
 static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 {
+    uint64_t delay_ns;
+
     if (block_job_is_cancelled(&job->common)) {
         return true;
     }
 
-    /* we need to yield so that bdrv_drain_all() returns.
-     * (without, VM does not reboot)
-     */
-    if (job->common.speed) {
-        uint64_t delay_ns = ratelimit_calculate_delay(&job->common.limit,
-                                                      job->bytes_read);
-        job->bytes_read = 0;
-        block_job_sleep_ns(&job->common, delay_ns);
-    } else {
-        block_job_sleep_ns(&job->common, 0);
-    }
+    /* We need to yield even for delay_ns = 0 so that bdrv_drain_all() can
+     * return. Without a yield, the VM would not reboot. */
+    delay_ns = block_job_ratelimit_get_delay(&job->common, job->bytes_read);
+    job->bytes_read = 0;
+    block_job_sleep_ns(&job->common, delay_ns);
 
     if (block_job_is_cancelled(&job->common)) {
         return true;
diff --git a/block/commit.c b/block/commit.c
index 46cbeaec3e..ba5df6aa0a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -197,8 +197,8 @@ static void coroutine_fn commit_run(void *opaque)
         /* Publish progress */
         block_job_progress_update(&s->common, n);
 
-        if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->common.limit, n);
+        if (copy) {
+            delay_ns = block_job_ratelimit_get_delay(&s->common, n);
         } else {
             delay_ns = 0;
         }
diff --git a/block/mirror.c b/block/mirror.c
index 6955d68804..6aa38db114 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -447,10 +447,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         assert(io_bytes);
         offset += io_bytes;
         nb_chunks -= DIV_ROUND_UP(io_bytes, s->granularity);
-        if (s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->common.limit,
-                                                 io_bytes_acct);
-        }
+        delay_ns = block_job_ratelimit_get_delay(&s->common, io_bytes_acct);
     }
     return delay_ns;
 }
diff --git a/block/stream.c b/block/stream.c
index 797d7c4f21..df9660d2fc 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -185,8 +185,8 @@ static void coroutine_fn stream_run(void *opaque)
 
         /* Publish progress */
         block_job_progress_update(&s->common, n);
-        if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->common.limit, n);
+        if (copy) {
+            delay_ns = block_job_ratelimit_get_delay(&s->common, n);
         } else {
             delay_ns = 0;
         }
diff --git a/blockjob.c b/blockjob.c
index 2f4b768338..04416f11cd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -680,6 +680,15 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     block_job_enter_cond(job, block_job_timer_pending);
 }
 
+int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
+{
+    if (!job->speed) {
+        return 0;
+    }
+
+    return ratelimit_calculate_delay(&job->limit, n);
+}
+
 void block_job_complete(BlockJob *job, Error **errp)
 {
     /* Should not be reachable via external interface for internal jobs */
-- 
2.13.6
