Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHy-0008Ls-4M
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHx-0005qi-05
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHw-0005pY-Ms
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:16 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFBBF3D957
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:54 +0200
Message-Id: <20170605123908.18777-6-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/19] block: access wakeup with atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

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
index d76202b452..4a598299a9 100644
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
index 848b2c0bb0..18c87d2f25 100644
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
index a18315a1ca..5ebf5d9fbb 100644
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
index 9b355e92d8..a4f09df95a 100644
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
index e5f19eb24c..dd09e0071b 100644
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
2.13.0
