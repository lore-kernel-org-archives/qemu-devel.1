Received: from eggs.gnu.org ([2001:4830:134:3::10]:53825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrR-0002Y0-Gh
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrP-0000GL-Qj
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:13 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:46 -0500
Message-Id: <20180310082746.24198-22-jsnow@redhat.com>
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 21/21] tests/test-blockjob: test
 cancellations
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

Whatever the state a blockjob is in, it should be able to be canceled
by the block layer.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-blockjob.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 4 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 599e28d732..8946bfd37b 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -24,14 +24,15 @@ static void block_job_cb(void *opaque, int ret)
 {
 }
 
-static BlockJob *do_test_id(BlockBackend *blk, const char *id,
-                            bool should_succeed)
+static BlockJob *mk_job(BlockBackend *blk, const char *id,
+                        const BlockJobDriver *drv, bool should_succeed,
+                        int flags)
 {
     BlockJob *job;
     Error *errp = NULL;
 
-    job = block_job_create(id, &test_block_job_driver, NULL, blk_bs(blk),
-                           0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
+    job = block_job_create(id, drv, NULL, blk_bs(blk),
+                           0, BLK_PERM_ALL, 0, flags, block_job_cb,
                            NULL, &errp);
     if (should_succeed) {
         g_assert_null(errp);
@@ -50,6 +51,13 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
     return job;
 }
 
+static BlockJob *do_test_id(BlockBackend *blk, const char *id,
+                            bool should_succeed)
+{
+    return mk_job(blk, id, &test_block_job_driver,
+                  should_succeed, BLOCK_JOB_DEFAULT);
+}
+
 /* This creates a BlockBackend (optionally with a name) with a
  * BlockDriverState inserted. */
 static BlockBackend *create_blk(const char *name)
@@ -142,6 +150,216 @@ static void test_job_ids(void)
     destroy_blk(blk[2]);
 }
 
+typedef struct CancelJob {
+    BlockJob common;
+    BlockBackend *blk;
+    bool should_converge;
+    bool should_complete;
+    bool completed;
+} CancelJob;
+
+static void cancel_job_completed(BlockJob *job, void *opaque)
+{
+    CancelJob *s = opaque;
+    s->completed = true;
+    block_job_completed(job, 0);
+}
+
+static void cancel_job_complete(BlockJob *job, Error **errp)
+{
+    CancelJob *s = container_of(job, CancelJob, common);
+    s->should_complete = true;
+}
+
+static void coroutine_fn cancel_job_start(void *opaque)
+{
+    CancelJob *s = opaque;
+
+    while (!s->should_complete) {
+        if (block_job_is_cancelled(&s->common)) {
+            goto defer;
+        }
+
+        if (!s->common.ready && s->should_converge) {
+            block_job_event_ready(&s->common);
+        }
+
+        block_job_sleep_ns(&s->common, 100000);
+    }
+
+ defer:
+    block_job_defer_to_main_loop(&s->common, cancel_job_completed, s);
+}
+
+static const BlockJobDriver test_cancel_driver = {
+    .instance_size = sizeof(CancelJob),
+    .start         = cancel_job_start,
+    .complete      = cancel_job_complete,
+};
+
+static CancelJob *create_common(BlockJob **pjob)
+{
+    BlockBackend *blk;
+    BlockJob *job;
+    CancelJob *s;
+
+    blk = create_blk(NULL);
+    job = mk_job(blk, "Steve", &test_cancel_driver, true,
+                 BLOCK_JOB_MANUAL_FINALIZE | BLOCK_JOB_MANUAL_DISMISS);
+    block_job_ref(job);
+    assert(job->status == BLOCK_JOB_STATUS_CREATED);
+    s = container_of(job, CancelJob, common);
+    s->blk = blk;
+
+    *pjob = job;
+    return s;
+}
+
+static void cancel_common(CancelJob *s)
+{
+    BlockJob *job = &s->common;
+    BlockBackend *blk = s->blk;
+    BlockJobStatus sts = job->status;
+
+    block_job_cancel_sync(job);
+    if ((sts != BLOCK_JOB_STATUS_CREATED) &&
+        (sts != BLOCK_JOB_STATUS_CONCLUDED)) {
+        BlockJob *dummy = job;
+        block_job_dismiss(&dummy, &error_abort);
+    }
+    assert(job->status == BLOCK_JOB_STATUS_NULL);
+    block_job_unref(job);
+    destroy_blk(blk);
+}
+
+static void test_cancel_created(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+    cancel_common(s);
+}
+
+static void test_cancel_running(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    cancel_common(s);
+}
+
+static void test_cancel_paused(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    block_job_user_pause(job, &error_abort);
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_PAUSED);
+
+    cancel_common(s);
+}
+
+static void test_cancel_ready(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    s->should_converge = true;
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_READY);
+
+    cancel_common(s);
+}
+
+static void test_cancel_standby(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    s->should_converge = true;
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_READY);
+
+    block_job_user_pause(job, &error_abort);
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_STANDBY);
+
+    cancel_common(s);
+}
+
+static void test_cancel_pending(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    s->should_converge = true;
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_READY);
+
+    block_job_complete(job, &error_abort);
+    block_job_enter(job);
+    while (!s->completed) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+    assert(job->status == BLOCK_JOB_STATUS_PENDING);
+
+    cancel_common(s);
+}
+
+static void test_cancel_concluded(void)
+{
+    BlockJob *job;
+    CancelJob *s;
+
+    s = create_common(&job);
+
+    block_job_start(job);
+    assert(job->status == BLOCK_JOB_STATUS_RUNNING);
+
+    s->should_converge = true;
+    block_job_enter(job);
+    assert(job->status == BLOCK_JOB_STATUS_READY);
+
+    block_job_complete(job, &error_abort);
+    block_job_enter(job);
+    while (!s->completed) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+    assert(job->status == BLOCK_JOB_STATUS_PENDING);
+
+    block_job_finalize(job, &error_abort);
+    assert(job->status == BLOCK_JOB_STATUS_CONCLUDED);
+
+    cancel_common(s);
+}
+
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
@@ -149,5 +367,12 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/blockjob/ids", test_job_ids);
+    g_test_add_func("/blockjob/cancel/created", test_cancel_created);
+    g_test_add_func("/blockjob/cancel/running", test_cancel_running);
+    g_test_add_func("/blockjob/cancel/paused", test_cancel_paused);
+    g_test_add_func("/blockjob/cancel/ready", test_cancel_ready);
+    g_test_add_func("/blockjob/cancel/standby", test_cancel_standby);
+    g_test_add_func("/blockjob/cancel/pending", test_cancel_pending);
+    g_test_add_func("/blockjob/cancel/concluded", test_cancel_concluded);
     return g_test_run();
 }
-- 
2.14.3
