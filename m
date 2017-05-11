Received: from eggs.gnu.org ([2001:4830:134:3::10]:42230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIT-0001bp-EO
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8pIS-0004ET-HA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:42:29 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 May 2017 16:41:59 +0200
Message-Id: <20170511144208.24075-10-pbonzini@redhat.com>
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/18] throttle-groups: protect throttled
 requests with a CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Another possibility is to use tg->lock, which we're holding anyway in
both schedule_next_request and throttle_group_co_io_limits_intercept.
This would require open-coding the CoQueue however, so I've chosen this
alternative.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: rename CoMutex [Fam]

 block/block-backend.c          |  1 +
 block/throttle-groups.c        | 12 ++++++++++--
 include/sysemu/block-backend.h |  7 ++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 915ccc5e56..17b0ef2dc3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -163,6 +163,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
     blk->shared_perm = shared_perm;
     blk_set_enable_write_cache(blk, true);
 
+    qemu_co_mutex_init(&blk->public.throttled_reqs_lock);
     qemu_co_queue_init(&blk->public.throttled_reqs[0]);
     qemu_co_queue_init(&blk->public.throttled_reqs[1]);
 
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 8bf1031efa..a181cb1dee 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -270,8 +270,13 @@ static bool coroutine_fn throttle_group_co_restart_queue(BlockBackend *blk,
                                                          bool is_write)
 {
     BlockBackendPublic *blkp = blk_get_public(blk);
+    bool ret;
 
-    return qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
+    qemu_co_mutex_lock(&blkp->throttled_reqs_lock);
+    ret = qemu_co_queue_next(&blkp->throttled_reqs[is_write]);
+    qemu_co_mutex_unlock(&blkp->throttled_reqs_lock);
+
+    return ret;
 }
 
 /* Look for the next pending I/O request and schedule it.
@@ -340,7 +345,10 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
     if (must_wait || blkp->pending_reqs[is_write]) {
         blkp->pending_reqs[is_write]++;
         qemu_mutex_unlock(&tg->lock);
-        qemu_co_queue_wait(&blkp->throttled_reqs[is_write], NULL);
+        qemu_co_mutex_lock(&blkp->throttled_reqs_lock);
+        qemu_co_queue_wait(&blkp->throttled_reqs[is_write],
+                           &blkp->throttled_reqs_lock);
+        qemu_co_mutex_unlock(&blkp->throttled_reqs_lock);
         qemu_mutex_lock(&tg->lock);
         blkp->pending_reqs[is_write]--;
     }
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 87a43b07ab..f8b7eaa4f2 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -72,11 +72,8 @@ typedef struct BlockDevOps {
  * fields that must be public. This is in particular for QLIST_ENTRY() and
  * friends so that BlockBackends can be kept in lists outside block-backend.c */
 typedef struct BlockBackendPublic {
-    /* I/O throttling has its own locking, but also some fields are
-     * protected by the AioContext lock.
-     */
-
-    /* Protected by AioContext lock.  */
+    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
+    CoMutex      throttled_reqs_lock;
     CoQueue      throttled_reqs[2];
 
     /* Nonzero if the I/O limits are currently being ignored; generally
-- 
2.12.2
