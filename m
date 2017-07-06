Received: from eggs.gnu.org ([2001:4830:134:3::10]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nh-0004qP-OT
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ng-00062i-Jf
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:45 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:21 +0200
Message-Id: <20170706163828.24082-5-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] block: make before-write notifiers
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Reads access the list in RCU style, so be careful to avoid use-after-free
scenarios in the backup block job.  Apart from this, all that's needed
is protecting updates with a mutex.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/backup.c            | 17 +++++++++++++----
 block/io.c                | 12 ++++++++++++
 block/write-threshold.c   |  2 +-
 include/block/block_int.h | 16 ++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5387fbd84e..9214ffcc58 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -246,6 +246,13 @@ static void backup_abort(BlockJob *job)
 static void backup_clean(BlockJob *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+
+    /* Ensure that no I/O is using the notifier anymore before freeing
+     * the bitmap and the job.
+     */
+    blk_drain(job->blk);
+    g_free(s->done_bitmap);
+
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
@@ -526,12 +533,14 @@ static void coroutine_fn backup_run(void *opaque)
         }
     }
 
-    notifier_with_return_remove(&job->before_write);
-
-    /* wait until pending backup_do_cow() calls have completed */
+    /* At this point, all future invocations of the write notifier will
+     * find a 1 in the done_bitmap, but we still have to wait for pending
+     * backup_do_cow() calls to complete.
+     */
     qemu_co_rwlock_wrlock(&job->flush_rwlock);
     qemu_co_rwlock_unlock(&job->flush_rwlock);
-    g_free(job->done_bitmap);
+
+    bdrv_remove_before_write_notifier(bs, &job->before_write);
 
     data = g_malloc(sizeof(*data));
     data->ret = ret;
diff --git a/block/io.c b/block/io.c
index 68f19bbe69..089866bb5e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2499,10 +2499,22 @@ bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov)
     return true;
 }
 
+static QemuSpin notifiers_spin_lock;
+
 void bdrv_add_before_write_notifier(BlockDriverState *bs,
                                     NotifierWithReturn *notifier)
 {
+    qemu_spin_lock(&notifiers_spin_lock);
     notifier_with_return_list_add(&bs->before_write_notifiers, notifier);
+    qemu_spin_unlock(&notifiers_spin_lock);
+}
+
+void bdrv_remove_before_write_notifier(BlockDriverState *bs,
+                                       NotifierWithReturn *notifier)
+{
+    qemu_spin_lock(&notifiers_spin_lock);
+    notifier_with_return_remove(notifier);
+    qemu_spin_unlock(&notifiers_spin_lock);
 }
 
 void bdrv_io_plug(BlockDriverState *bs)
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 64ddd3d653..53c8caeda7 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -32,7 +32,7 @@ bool bdrv_write_threshold_is_set(const BlockDriverState *bs)
 static void write_threshold_disable(BlockDriverState *bs)
 {
     if (bdrv_write_threshold_is_set(bs)) {
-        notifier_with_return_remove(&bs->write_threshold_notifier);
+        bdrv_remove_before_write_notifier(bs, &bs->write_threshold_notifier);
         bs->write_threshold_offset = 0;
     }
 }
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6d3fbbfc1e..173d9dcaf9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -707,6 +707,8 @@ void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
 
 /**
  * bdrv_add_before_write_notifier:
+ * @bs: The #BlockDriverState for which to register the notifier
+ * @notifier: The notifier to add
  *
  * Register a callback that is invoked before write requests are processed but
  * after any throttling or waiting for overlapping requests.
@@ -715,6 +717,20 @@ void bdrv_add_before_write_notifier(BlockDriverState *bs,
                                     NotifierWithReturn *notifier);
 
 /**
+ * bdrv_remove_before_write_notifier:
+ * @bs: The #BlockDriverState for which to register the notifier
+ * @notifier: The notifier to add
+ *
+ * Unregister a callback that is invoked before write requests are processed but
+ * after any throttling or waiting for overlapping requests.
+ *
+ * Note that more I/O could be pending on @bs.  You need to wait for
+ * it to finish, for example with bdrv_drain(), before freeing @notifier.
+ */
+void bdrv_remove_before_write_notifier(BlockDriverState *bs,
+                                       NotifierWithReturn *notifier);
+
+/**
  * bdrv_detach_aio_context:
  *
  * May be called from .bdrv_detach_aio_context() to detach children from the
-- 
2.13.0
