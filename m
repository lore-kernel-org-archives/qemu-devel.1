Received: from eggs.gnu.org ([2001:4830:134:3::10]:53831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i0-0005Ov-25
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hy-0002Qw-Rd
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6hy-0002Qi-Jk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:34 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96D90C03BD5F
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:21 +0100
Message-Id: <20170323173928.14439-4-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] blockjob: introduce block_job_fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com

Outside blockjob.c, block_job_unref is only used when a block job fails
to start, and block_job_ref is not used at all.  The reference counting
thus is pretty well hidden.  Introduce a separate function to be used
by block jobs; because block_job_ref and block_job_unref now become
static, move them earlier in blockjob.c.

Later on, block_job_fail will also have different locking than
block_job_unref.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/backup.c               |  2 +-
 block/commit.c               |  2 +-
 block/mirror.c               |  2 +-
 blockjob.c                   | 47 ++++++++++++++++++++++++++------------------
 include/block/blockjob_int.h | 15 +++-----------
 tests/test-blockjob.c        | 10 +++++-----
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a4fb288..f284fd5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -692,7 +692,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
     if (job) {
         backup_clean(&job->common);
-        block_job_unref(&job->common);
+        block_job_fail(&job->common);
     }
 
     return NULL;
diff --git a/block/commit.c b/block/commit.c
index 2832482..9b9ea39 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -424,7 +424,7 @@ fail:
     if (commit_top_bs) {
         bdrv_set_backing_hd(overlay_bs, top, &error_abort);
     }
-    block_job_unref(&s->common);
+    block_job_fail(&s->common);
 }
 
 
diff --git a/block/mirror.c b/block/mirror.c
index ca4baa5..5cb2134 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1243,7 +1243,7 @@ fail:
     if (s) {
         g_free(s->replaces);
         blk_unref(s->target);
-        block_job_unref(&s->common);
+        block_job_fail(&s->common);
     }
 
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
diff --git a/blockjob.c b/blockjob.c
index 24d1e12..1c63d15 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -106,6 +106,32 @@ BlockJob *block_job_get(const char *id)
     return NULL;
 }
 
+static void block_job_ref(BlockJob *job)
+{
+    ++job->refcnt;
+}
+
+static void block_job_attached_aio_context(AioContext *new_context,
+                                           void *opaque);
+static void block_job_detach_aio_context(void *opaque);
+
+static void block_job_unref(BlockJob *job)
+{
+    if (--job->refcnt == 0) {
+        BlockDriverState *bs = blk_bs(job->blk);
+        bs->job = NULL;
+        block_job_remove_all_bdrv(job);
+        blk_remove_aio_context_notifier(job->blk,
+                                        block_job_attached_aio_context,
+                                        block_job_detach_aio_context, job);
+        blk_unref(job->blk);
+        error_free(job->blocker);
+        g_free(job->id);
+        QLIST_REMOVE(job, job_list);
+        g_free(job);
+    }
+}
+
 static void block_job_attached_aio_context(AioContext *new_context,
                                            void *opaque)
 {
@@ -293,26 +319,9 @@ void block_job_start(BlockJob *job)
     qemu_coroutine_enter(job->co);
 }
 
-void block_job_ref(BlockJob *job)
-{
-    ++job->refcnt;
-}
-
-void block_job_unref(BlockJob *job)
+void block_job_fail(BlockJob *job)
 {
-    if (--job->refcnt == 0) {
-        BlockDriverState *bs = blk_bs(job->blk);
-        bs->job = NULL;
-        block_job_remove_all_bdrv(job);
-        blk_remove_aio_context_notifier(job->blk,
-                                        block_job_attached_aio_context,
-                                        block_job_detach_aio_context, job);
-        blk_unref(job->blk);
-        error_free(job->blocker);
-        g_free(job->id);
-        QLIST_REMOVE(job, job_list);
-        g_free(job);
-    }
+    block_job_unref(job);
 }
 
 static void block_job_completed_single(BlockJob *job)
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index bfcc5d1..97ffc43 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -156,21 +156,12 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
 void block_job_yield(BlockJob *job);
 
 /**
- * block_job_ref:
+ * block_job_fail:
  * @bs: The block device.
  *
- * Grab a reference to the block job. Should be paired with block_job_unref.
+ * The block job could not be started, free it.
  */
-void block_job_ref(BlockJob *job);
-
-/**
- * block_job_unref:
- * @bs: The block device.
- *
- * Release reference to the block job and release resources if it is the last
- * reference.
- */
-void block_job_unref(BlockJob *job);
+void block_job_fail(BlockJob *job);
 
 /**
  * block_job_completed:
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 740e740..35bbbbc 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -116,11 +116,11 @@ static void test_job_ids(void)
     job[1] = do_test_id(blk[1], "id0", false);
 
     /* But once job[0] finishes we can reuse its ID */
-    block_job_unref(job[0]);
+    block_job_fail(job[0]);
     job[1] = do_test_id(blk[1], "id0", true);
 
     /* No job ID specified, defaults to the backend name ('drive1') */
-    block_job_unref(job[1]);
+    block_job_fail(job[1]);
     job[1] = do_test_id(blk[1], NULL, true);
 
     /* Duplicate job ID */
@@ -133,9 +133,9 @@ static void test_job_ids(void)
     /* This one is valid */
     job[2] = do_test_id(blk[2], "id_2", true);
 
-    block_job_unref(job[0]);
-    block_job_unref(job[1]);
-    block_job_unref(job[2]);
+    block_job_fail(job[0]);
+    block_job_fail(job[1]);
+    block_job_fail(job[2]);
 
     destroy_blk(blk[0]);
     destroy_blk(blk[1]);
-- 
2.9.3
