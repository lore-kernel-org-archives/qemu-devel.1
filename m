Received: from eggs.gnu.org ([2001:4830:134:3::10]:38600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amk-0007Z9-GC
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1AmZ-0002wo-5Y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:06 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:46 +0200
Message-Id: <20170420120058.28404-6-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/17] block: access wakeup with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                | 3 ++-
 block/nfs.c               | 4 +++-
 block/sheepdog.c          | 3 ++-
 include/block/block.h     | 5 +++--
 include/block/block_int.h | 4 ++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 869322a..3b2ede9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -501,7 +501,8 @@ static void dummy_bh_cb(void *opaque)
 
 void bdrv_wakeup(BlockDriverState *bs)
 {
-    if (bs->wakeup) {
+    /* The barrier (or an atomic op) is in the caller.  */
+    if (atomic_read(&bs->wakeup)) {
         aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
     }
 }
diff --git a/block/nfs.c b/block/nfs.c
index 0816678..fd2508a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -736,7 +736,9 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
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
index fb9203e..7e90a24 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -704,7 +704,8 @@ out:
 
     srco->co = NULL;
     srco->ret = ret;
-    srco->finished = true;
+    /* Set srco->finished before reading bs->wakeup.  */
+    atomic_mb_set(&srco->finished, true);
     if (srco->bs) {
         bdrv_wakeup(srco->bs);
     }
diff --git a/include/block/block.h b/include/block/block.h
index 5ddc0cf..486b6ed 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -398,7 +398,8 @@ void bdrv_drain_all(void);
          * block_job_defer_to_main_loop for how to do it). \
          */                                                \
         assert(!bs_->wakeup);                              \
-        bs_->wakeup = true;                                \
+        /* Set bs->wakeup before evaluating cond.  */      \
+        atomic_mb_set(&bs_->wakeup, true);                 \
         while (busy_) {                                    \
             if ((cond)) {                                  \
                 waited_ = busy_ = true;                    \
@@ -410,7 +411,7 @@ void bdrv_drain_all(void);
                 waited_ |= busy_;                          \
             }                                              \
         }                                                  \
-        bs_->wakeup = false;                               \
+        atomic_set(&bs_->wakeup, false);                   \
     }                                                      \
     waited_; })
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7317db6..ca34c99 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -590,8 +590,6 @@ struct BlockDriverState {
     /* Callback before write request is processed */
     NotifierWithReturnList before_write_notifiers;
 
-    bool wakeup;
-
     /* Offset after the highest byte written to */
     uint64_t wr_highest_offset;
 
@@ -622,6 +620,8 @@ struct BlockDriverState {
     unsigned int in_flight;
     unsigned int serialising_in_flight;
 
+    bool wakeup;
+
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-- 
2.9.3
