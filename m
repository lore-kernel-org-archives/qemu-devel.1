Received: from eggs.gnu.org ([2001:4830:134:3::10]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgm-0004hL-2H
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgl-0003lj-7x
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:40 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:12 +0200
Message-Id: <20170525163225.29954-6-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/18] block: access wakeup with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                | 3 ++-
 block/nfs.c               | 4 +++-
 block/sheepdog.c          | 3 ++-
 include/block/block.h     | 5 +++--
 include/block/block_int.h | 7 +++++--
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index cc5de2c..3a98b02 100644
--- a/block/io.c
+++ b/block/io.c
@@ -514,7 +514,8 @@ static void dummy_bh_cb(void *opaque)
 
 void bdrv_wakeup(BlockDriverState *bs)
 {
-    if (bs->wakeup) {
+    /* The barrier (or an atomic op) is in the caller.  */
+    if (atomic_read(&bs->wakeup)) {
         aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
     }
 }
diff --git a/block/nfs.c b/block/nfs.c
index 848b2c0..18c87d2 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -730,7 +730,9 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    task->complete = 1;
+
+    /* Set task->complete before reading bs->wakeup.  */
+    atomic_mb_set(&task->complete, 1);
     bdrv_wakeup(task->bs);
 }
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a..5ebf5d9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -698,7 +698,8 @@ out:
 
     srco->co = NULL;
     srco->ret = ret;
-    srco->finished = true;
+    /* Set srco->finished before reading bs->wakeup.  */
+    atomic_mb_set(&srco->finished, true);
     if (srco->bs) {
         bdrv_wakeup(srco->bs);
     }
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e9..a4f09df 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -402,7 +402,8 @@ void bdrv_drain_all(void);
          * block_job_defer_to_main_loop for how to do it). \
          */                                                \
         assert(!bs_->wakeup);                              \
-        bs_->wakeup = true;                                \
+        /* Set bs->wakeup before evaluating cond.  */      \
+        atomic_mb_set(&bs_->wakeup, true);                 \
         while (busy_) {                                    \
             if ((cond)) {                                  \
                 waited_ = busy_ = true;                    \
@@ -414,7 +415,7 @@ void bdrv_drain_all(void);
                 waited_ |= busy_;                          \
             }                                              \
         }                                                  \
-        bs_->wakeup = false;                               \
+        atomic_set(&bs_->wakeup, false);                   \
     }                                                      \
     waited_; })
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2fafd65..b690e58 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -604,8 +604,6 @@ struct BlockDriverState {
     /* Callback before write request is processed */
     NotifierWithReturnList before_write_notifiers;
 
-    bool wakeup;
-
     /* Offset after the highest byte written to */
     uint64_t wr_highest_offset;
 
@@ -636,6 +634,11 @@ struct BlockDriverState {
     unsigned int in_flight;
     unsigned int serialising_in_flight;
 
+    /* Internal to BDRV_POLL_WHILE and bdrv_wakeup.  Accessed with atomic
+     * ops.
+     */
+    bool wakeup;
+
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-- 
1.8.3.1
