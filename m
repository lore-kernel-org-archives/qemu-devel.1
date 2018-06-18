Received: from eggs.gnu.org ([2001:4830:134:3::10]:51796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHO-0004qn-Q9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHM-0006FS-S8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:36 +0200
Message-Id: <20180618164504.24488-8-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/35] block: Really pause block jobs on drain
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

We already requested that block jobs be paused in .bdrv_drained_begin,
but no guarantee was made that the job was actually inactive at the
point where bdrv_drained_begin() returned.

This introduces a new callback BdrvChildRole.bdrv_drained_poll() and
uses it to make bdrv_drain_poll() consider block jobs using the node to
be drained.

For the test case to work as expected, we have to switch from
block_job_sleep_ns() to qemu_co_sleep_ns() so that the test job is even
considered active and must be waited for when draining the node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h        |  8 ++++++++
 include/block/block_int.h    |  7 +++++++
 include/block/blockjob_int.h |  8 ++++++++
 block.c                      |  9 +++++++++
 block/io.c                   | 40 ++++++++++++++++++++++++++++++++++------
 block/mirror.c               |  8 ++++++++
 blockjob.c                   | 23 +++++++++++++++++++++++
 tests/test-bdrv-drain.c      | 18 ++++++++++--------
 8 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index e677080c4e..cebbb39c6c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -568,6 +568,14 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore);
 void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
 
 /**
+ * bdrv_drain_poll:
+ *
+ * Poll for pending requests in @bs and its parents (except for
+ * @ignore_parent). This is part of bdrv_drained_begin.
+ */
+bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent);
+
+/**
  * bdrv_drained_begin:
  *
  * Begin a quiesced section for exclusive access to the BDS, by disabling
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 327e478a73..1b811db8ec 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -605,6 +605,13 @@ struct BdrvChildRole {
     void (*drained_begin)(BdrvChild *child);
     void (*drained_end)(BdrvChild *child);
 
+    /*
+     * Returns whether the parent has pending requests for the child. This
+     * callback is polled after .drained_begin() has been called until all
+     * activity on the child has stopped.
+     */
+    bool (*drained_poll)(BdrvChild *child);
+
     /* Notifies the parent that the child has been activated/inactivated (e.g.
      * when migration is completing) and it can start/stop requesting
      * permissions and doing I/O on it. */
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 5cd50c6639..e4a318dd15 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -39,6 +39,14 @@ struct BlockJobDriver {
     JobDriver job_driver;
 
     /*
+     * Returns whether the job has pending requests for the child or will
+     * submit new requests before the next pause point. This callback is polled
+     * in the context of draining a job node after requesting that the job be
+     * paused, until all activity on the child has stopped.
+     */
+    bool (*drained_poll)(BlockJob *job);
+
+    /*
      * If the callback is not NULL, it will be invoked before the job is
      * resumed in a new AioContext.  This is the place to move any resources
      * besides job->blk to the new AioContext.
diff --git a/block.c b/block.c
index afe30caac3..8cf9cd8855 100644
--- a/block.c
+++ b/block.c
@@ -821,6 +821,12 @@ static void bdrv_child_cb_drained_begin(BdrvChild *child)
     bdrv_drained_begin(bs);
 }
 
+static bool bdrv_child_cb_drained_poll(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    return bdrv_drain_poll(bs, NULL);
+}
+
 static void bdrv_child_cb_drained_end(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -905,6 +911,7 @@ const BdrvChildRole child_file = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .attach          = bdrv_child_cb_attach,
     .detach          = bdrv_child_cb_detach,
@@ -929,6 +936,7 @@ const BdrvChildRole child_format = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .attach          = bdrv_child_cb_attach,
     .detach          = bdrv_child_cb_detach,
@@ -1048,6 +1056,7 @@ const BdrvChildRole child_backing = {
     .detach          = bdrv_backing_detach,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
     .update_filename = bdrv_backing_update_filename,
diff --git a/block/io.c b/block/io.c
index bc7a2d78b8..5820e73bb2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -69,6 +69,23 @@ void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
     }
 }
 
+static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore)
+{
+    BdrvChild *c, *next;
+    bool busy = false;
+
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
+        if (c == ignore) {
+            continue;
+        }
+        if (c->role->drained_poll) {
+            busy |= c->role->drained_poll(c);
+        }
+    }
+
+    return busy;
+}
+
 static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 {
     dst->opt_transfer = MAX(dst->opt_transfer, src->opt_transfer);
@@ -183,21 +200,32 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 }
 
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
-static bool bdrv_drain_poll(BlockDriverState *bs)
+bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent)
+{
+    if (bdrv_parent_drained_poll(bs, ignore_parent)) {
+        return true;
+    }
+
+    return atomic_read(&bs->in_flight);
+}
+
+static bool bdrv_drain_poll_top_level(BlockDriverState *bs,
+                                      BdrvChild *ignore_parent)
 {
     /* Execute pending BHs first and check everything else only after the BHs
      * have executed. */
     while (aio_poll(bs->aio_context, false));
-    return atomic_read(&bs->in_flight);
+
+    return bdrv_drain_poll(bs, ignore_parent);
 }
 
-static bool bdrv_drain_recurse(BlockDriverState *bs)
+static bool bdrv_drain_recurse(BlockDriverState *bs, BdrvChild *parent)
 {
     BdrvChild *child, *tmp;
     bool waited;
 
     /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs));
+    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
@@ -214,7 +242,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
              */
             bdrv_ref(bs);
         }
-        waited |= bdrv_drain_recurse(bs);
+        waited |= bdrv_drain_recurse(bs, child);
         if (in_main_loop) {
             bdrv_unref(bs);
         }
@@ -290,7 +318,7 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
 
     bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true);
-    bdrv_drain_recurse(bs);
+    bdrv_drain_recurse(bs, parent);
 
     if (recursive) {
         bs->recursive_quiesce_counter++;
diff --git a/block/mirror.c b/block/mirror.c
index 435268bbbf..c2146c1ab3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -964,6 +964,12 @@ static void mirror_pause(Job *job)
     mirror_wait_for_all_io(s);
 }
 
+static bool mirror_drained_poll(BlockJob *job)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+    return !!s->in_flight;
+}
+
 static void mirror_attached_aio_context(BlockJob *job, AioContext *new_context)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
@@ -997,6 +1003,7 @@ static const BlockJobDriver mirror_job_driver = {
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
+    .drained_poll           = mirror_drained_poll,
     .attached_aio_context   = mirror_attached_aio_context,
     .drain                  = mirror_drain,
 };
@@ -1012,6 +1019,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
+    .drained_poll           = mirror_drained_poll,
     .attached_aio_context   = mirror_attached_aio_context,
     .drain                  = mirror_drain,
 };
diff --git a/blockjob.c b/blockjob.c
index 0306533a2e..be5903aa96 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -155,6 +155,28 @@ static void child_job_drained_begin(BdrvChild *c)
     job_pause(&job->job);
 }
 
+static bool child_job_drained_poll(BdrvChild *c)
+{
+    BlockJob *bjob = c->opaque;
+    Job *job = &bjob->job;
+    const BlockJobDriver *drv = block_job_driver(bjob);
+
+    /* An inactive or completed job doesn't have any pending requests. Jobs
+     * with !job->busy are either already paused or have a pause point after
+     * being reentered, so no job driver code will run before they pause. */
+    if (!job->busy || job_is_completed(job) || job->deferred_to_main_loop) {
+        return false;
+    }
+
+    /* Otherwise, assume that it isn't fully stopped yet, but allow the job to
+     * override this assumption. */
+    if (drv->drained_poll) {
+        return drv->drained_poll(bjob);
+    } else {
+        return true;
+    }
+}
+
 static void child_job_drained_end(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
@@ -164,6 +186,7 @@ static void child_job_drained_end(BdrvChild *c)
 static const BdrvChildRole child_job = {
     .get_parent_desc    = child_job_get_parent_desc,
     .drained_begin      = child_job_drained_begin,
+    .drained_poll       = child_job_drained_poll,
     .drained_end        = child_job_drained_end,
     .stay_at_node       = true,
 };
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index cc03bc171b..22d31c953e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -686,7 +686,11 @@ static void coroutine_fn test_job_start(void *opaque)
 
     job_transition_to_ready(&s->common.job);
     while (!s->should_complete) {
-        job_sleep_ns(&s->common.job, 100000);
+        /* Avoid block_job_sleep_ns() because it marks the job as !busy. We
+         * want to emulate some actual activity (probably some I/O) here so
+         * that drain has to wait for this acitivity to stop. */
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+        job_pause_point(&s->common.job);
     }
 
     job_defer_to_main_loop(&s->common.job, test_job_completed, NULL);
@@ -733,7 +737,7 @@ static void test_blockjob_common(enum drain_type drain_type)
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
+    g_assert_true(job->job.busy); /* We're in job_sleep_ns() */
 
     do_drain_begin(drain_type, src);
 
@@ -743,15 +747,14 @@ static void test_blockjob_common(enum drain_type drain_type)
     } else {
         g_assert_cmpint(job->job.pause_count, ==, 1);
     }
-    /* XXX We don't wait until the job is actually paused. Is this okay? */
-    /* g_assert_true(job->job.paused); */
+    g_assert_true(job->job.paused);
     g_assert_false(job->job.busy); /* The job is paused */
 
     do_drain_end(drain_type, src);
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
+    g_assert_true(job->job.busy); /* We're in qemu_co_sleep_ns() */
 
     do_drain_begin(drain_type, target);
 
@@ -761,15 +764,14 @@ static void test_blockjob_common(enum drain_type drain_type)
     } else {
         g_assert_cmpint(job->job.pause_count, ==, 1);
     }
-    /* XXX We don't wait until the job is actually paused. Is this okay? */
-    /* g_assert_true(job->job.paused); */
+    g_assert_true(job->job.paused);
     g_assert_false(job->job.busy); /* The job is paused */
 
     do_drain_end(drain_type, target);
 
     g_assert_cmpint(job->job.pause_count, ==, 0);
     g_assert_false(job->job.paused);
-    g_assert_false(job->job.busy); /* We're in job_sleep_ns() */
+    g_assert_true(job->job.busy); /* We're in job_sleep_ns() */
 
     ret = job_complete_sync(&job->job, &error_abort);
     g_assert_cmpint(ret, ==, 0);
-- 
2.13.6
