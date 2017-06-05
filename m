Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI3-0008S2-Ky
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI2-0005v2-6N
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrI1-0005uF-TP
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:22 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E61CB80480
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:58 +0200
Message-Id: <20170605123908.18777-10-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/19] throttle-groups: protect throttled
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
Cc: famz@redhat.com

Another possibility is to use tg->lock, which we're holding anyway in
both schedule_next_request and throttle_group_co_io_limits_intercept.
This would require open-coding the CoQueue however, so I've chosen this
alternative.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/block-backend.c          |  1 +
 block/throttle-groups.c        | 12 ++++++++++--
 include/sysemu/block-backend.h |  7 ++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index e50ec03f30..be2ddf173a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -216,6 +216,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)
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
index 24b63d6b03..999eb2333a 100644
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
2.13.0
