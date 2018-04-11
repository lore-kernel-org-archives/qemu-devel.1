Received: from eggs.gnu.org ([2001:4830:134:3::10]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In9-0002hG-W4
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In5-0004U5-St
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:28 +0200
Message-Id: <20180411163940.2523-8-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

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
 include/block/block.h        |  7 +++++++
 include/block/block_int.h    |  7 +++++++
 include/block/blockjob_int.h |  8 ++++++++
 block.c                      |  9 +++++++++
 block/io.c                   | 27 ++++++++++++++++++++++++---
 block/mirror.c               |  8 ++++++++
 blockjob.c                   | 21 +++++++++++++++++++++
 tests/test-bdrv-drain.c      | 18 ++++++++++--------
 8 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..23dee3c114 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -559,6 +559,13 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore);
 void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
 
 /**
+ * bdrv_drain_poll:
+ *
+ * Poll for pending requests in @bs. This is part of bdrv_drained_begin.
+ */
+bool bdrv_drain_poll(BlockDriverState *bs, bool top_level);
+
+/**
  * bdrv_drained_begin:
  *
  * Begin a quiesced section for exclusive access to the BDS, by disabling
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c4dd1d4bb8..dc6985e3ae 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -575,6 +575,13 @@ struct BdrvChildRole {
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
index 642adce68b..3a2f851d3f 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -106,6 +106,14 @@ struct BlockJobDriver {
     void coroutine_fn (*resume)(BlockJob *job);
 
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
index a2caadf0a0..462287bdfb 100644
--- a/block.c
+++ b/block.c
@@ -820,6 +820,12 @@ static void bdrv_child_cb_drained_begin(BdrvChild *child)
     bdrv_drained_begin(bs);
 }
 
+static bool bdrv_child_cb_drained_poll(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    return bdrv_drain_poll(bs, false);
+}
+
 static void bdrv_child_cb_drained_end(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -904,6 +910,7 @@ const BdrvChildRole child_file = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .attach          = bdrv_child_cb_attach,
     .detach          = bdrv_child_cb_detach,
@@ -928,6 +935,7 @@ const BdrvChildRole child_format = {
     .get_parent_desc = bdrv_child_get_parent_desc,
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .attach          = bdrv_child_cb_attach,
     .detach          = bdrv_child_cb_detach,
@@ -1047,6 +1055,7 @@ const BdrvChildRole child_backing = {
     .detach          = bdrv_backing_detach,
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
+    .drained_poll    = bdrv_child_cb_drained_poll,
     .drained_end     = bdrv_child_cb_drained_end,
     .inactivate      = bdrv_child_cb_inactivate,
     .update_filename = bdrv_backing_update_filename,
diff --git a/block/io.c b/block/io.c
index 6f580f49ff..0a778eeff4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -69,6 +69,20 @@ void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
     }
 }
 
+static bool bdrv_parent_drained_poll(BlockDriverState *bs)
+{
+    BdrvChild *c, *next;
+    bool busy = false;
+
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
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
@@ -182,11 +196,18 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 }
 
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
-static bool bdrv_drain_poll(BlockDriverState *bs)
+bool bdrv_drain_poll(BlockDriverState *bs, bool top_level)
 {
     /* Execute pending BHs first and check everything else only after the BHs
      * have executed. */
-    while (aio_poll(bs->aio_context, false));
+    if (top_level) {
+        while (aio_poll(bs->aio_context, false));
+    }
+
+    if (bdrv_parent_drained_poll(bs)) {
+        return true;
+    }
+
     return atomic_read(&bs->in_flight);
 }
 
@@ -196,7 +217,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     bool waited;
 
     /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs));
+    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll(bs, true));
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
diff --git a/block/mirror.c b/block/mirror.c
index 820f512c7b..939504bd80 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -975,6 +975,12 @@ static void mirror_pause(BlockJob *job)
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
@@ -1004,6 +1010,7 @@ static const BlockJobDriver mirror_job_driver = {
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
+    .drained_poll           = mirror_drained_poll,
     .attached_aio_context   = mirror_attached_aio_context,
     .drain                  = mirror_drain,
 };
@@ -1015,6 +1022,7 @@ static const BlockJobDriver commit_active_job_driver = {
     .start                  = mirror_run,
     .complete               = mirror_complete,
     .pause                  = mirror_pause,
+    .drained_poll           = mirror_drained_poll,
     .attached_aio_context   = mirror_attached_aio_context,
     .drain                  = mirror_drain,
 };
diff --git a/blockjob.c b/blockjob.c
index 27f957e571..3d65196309 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -306,6 +306,26 @@ static void child_job_drained_begin(BdrvChild *c)
     block_job_pause(job);
 }
 
+static bool child_job_drained_poll(BdrvChild *c)
+{
+    BlockJob *job = c->opaque;
+
+    /* An inactive or completed job doesn't have any pending requests. Jobs
+     * with !job->busy are either already paused or have a pause point after
+     * being reentered, so no job driver code will run before they pause. */
+    if (!job->busy || job->completed || job->deferred_to_main_loop) {
+        return false;
+    }
+
+    /* Otherwise, assume that it isn't fully stopped yet, but allow the job to
+     * override this assumption. */
+    if (job->driver->drained_poll) {
+        return job->driver->drained_poll(job);
+    } else {
+        return true;
+    }
+}
+
 static void child_job_drained_end(BdrvChild *c)
 {
     BlockJob *job = c->opaque;
@@ -315,6 +335,7 @@ static void child_job_drained_end(BdrvChild *c)
 static const BdrvChildRole child_job = {
     .get_parent_desc    = child_job_get_parent_desc,
     .drained_begin      = child_job_drained_begin,
+    .drained_poll       = child_job_drained_poll,
     .drained_end        = child_job_drained_end,
     .stay_at_node       = true,
 };
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 6de525b509..37f2d6ac8c 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -686,7 +686,11 @@ static void coroutine_fn test_job_start(void *opaque)
 
     block_job_event_ready(&s->common);
     while (!s->should_complete) {
-        block_job_sleep_ns(&s->common, 100000);
+        /* Avoid block_job_sleep_ns() because it marks the job as !busy. We
+         * want to emulate some actual activity (probably some I/O) here so
+         * that drain has to wait for this acitivity to stop. */
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+        block_job_pause_point(&s->common);
     }
 
     block_job_defer_to_main_loop(&s->common, test_job_completed, NULL);
@@ -728,7 +732,7 @@ static void test_blockjob_common(enum drain_type drain_type)
 
     g_assert_cmpint(job->pause_count, ==, 0);
     g_assert_false(job->paused);
-    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+    g_assert_true(job->busy); /* We're in qemu_co_sleep_ns() */
 
     do_drain_begin(drain_type, src);
 
@@ -738,15 +742,14 @@ static void test_blockjob_common(enum drain_type drain_type)
     } else {
         g_assert_cmpint(job->pause_count, ==, 1);
     }
-    /* XXX We don't wait until the job is actually paused. Is this okay? */
-    /* g_assert_true(job->paused); */
+    g_assert_true(job->paused);
     g_assert_false(job->busy); /* The job is paused */
 
     do_drain_end(drain_type, src);
 
     g_assert_cmpint(job->pause_count, ==, 0);
     g_assert_false(job->paused);
-    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+    g_assert_true(job->busy); /* We're in qemu_co_sleep_ns() */
 
     do_drain_begin(drain_type, target);
 
@@ -756,15 +759,14 @@ static void test_blockjob_common(enum drain_type drain_type)
     } else {
         g_assert_cmpint(job->pause_count, ==, 1);
     }
-    /* XXX We don't wait until the job is actually paused. Is this okay? */
-    /* g_assert_true(job->paused); */
+    g_assert_true(job->paused);
     g_assert_false(job->busy); /* The job is paused */
 
     do_drain_end(drain_type, target);
 
     g_assert_cmpint(job->pause_count, ==, 0);
     g_assert_false(job->paused);
-    g_assert_false(job->busy); /* We're in block_job_sleep_ns() */
+    g_assert_true(job->busy); /* We're in qemu_co_sleep_ns() */
 
     ret = block_job_complete_sync(job, &error_abort);
     g_assert_cmpint(ret, ==, 0);
-- 
2.13.6
