Received: from eggs.gnu.org ([209.51.188.92]:41492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45D-000204-6N
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45B-0003pl-ST
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45B-0003ie-EG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rqJ122295
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8sjj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:53 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:53 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:46 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-73-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 72/97] mirror: fix dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Let start from the beginning:

Commit b9e413dd375 (in 2.9)
"block: explicitly acquire aiocontext in aio callbacks that need it"
added pairs of aio_context_acquire/release to mirror_write_complete and
mirror_read_complete, when they were aio callbacks for blk_aio_* calls.

Then, commit 2e1990b26e5 (in 3.0) "block/mirror: Convert to coroutines"
dropped these blk_aio_* calls, than mirror_write_complete and
mirror_read_complete are not callbacks more, and don't need additional
aiocontext acquiring. Furthermore, mirror_read_complete calls
blk_co_pwritev inside these pair of aio_context_acquire/release, which
leads to the following dead-lock with mirror:

 (gdb) info thr
   Id   Target Id         Frame
   3    Thread (LWP 145412) "qemu-system-x86" syscall ()
   2    Thread (LWP 145416) "qemu-system-x86" __lll_lock_wait ()
 * 1    Thread (LWP 145411) "qemu-system-x86" __lll_lock_wait ()

 (gdb) bt
 #0  __lll_lock_wait ()
 #1  _L_lock_812 ()
 #2  __GI___pthread_mutex_lock
 #3  qemu_mutex_lock_impl (mutex=0x561032dce420 <qemu_global_mutex>,
     file=0x5610327d8654 "util/main-loop.c", line=236) at
     util/qemu-thread-posix.c:66
 #4  qemu_mutex_lock_iothread_impl
 #5  os_host_main_loop_wait (timeout=480116000) at util/main-loop.c:236
 #6  main_loop_wait (nonblocking=0) at util/main-loop.c:497
 #7  main_loop () at vl.c:1892
 #8  main

Printing contents of qemu_global_mutex, I see that "__owner = 145416",
so, thr1 is main loop, and now it wants BQL, which is owned by thr2.

 (gdb) thr 2
 (gdb) bt
 #0  __lll_lock_wait ()
 #1  _L_lock_870 ()
 #2  __GI___pthread_mutex_lock
 #3  qemu_mutex_lock_impl (mutex=0x561034d25dc0, ...
 #4  aio_context_acquire (ctx=0x561034d25d60)
 #5  dma_blk_cb
 #6  dma_blk_io
 #7  dma_blk_read
 #8  ide_dma_cb
 #9  bmdma_cmd_writeb
 #10 bmdma_write
 #11 memory_region_write_accessor
 #12 access_with_adjusted_size
 #15 flatview_write
 #16 address_space_write
 #17 address_space_rw
 #18 kvm_handle_io
 #19 kvm_cpu_exec
 #20 qemu_kvm_cpu_thread_fn
 #21 qemu_thread_start
 #22 start_thread
 #23 clone ()

Printing mutex in fr 2, I see "__owner = 145411", so thr2 wants aio
context mutex, which is owned by thr1. Classic dead-lock.

Then, let's check that aio context is hold by mirror coroutine: just
print coroutine stack of first tracked request in mirror job target:

 (gdb) [...]
 (gdb) qemu coroutine 0x561035dd0860
 #0  qemu_coroutine_switch
 #1  qemu_coroutine_yield
 #2  qemu_co_mutex_lock_slowpath
 #3  qemu_co_mutex_lock
 #4  qcow2_co_pwritev
 #5  bdrv_driver_pwritev
 #6  bdrv_aligned_pwritev
 #7  bdrv_co_pwritev
 #8  blk_co_pwritev
 #9  mirror_read_complete () at block/mirror.c:232
 #10 mirror_co_read () at block/mirror.c:370
 #11 coroutine_trampoline
 #12 __start_context

Yes it is mirror_read_complete calling blk_co_pwritev after acquiring
aio context.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d12ade5732c4d2d293735a39b4bd943da8d64db6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index dd5ca02b09..b097853983 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -198,7 +198,6 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
 
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -208,15 +207,14 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
             s->ret = ret;
         }
     }
+
     mirror_iteration_done(op, ret);
-    aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
 static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
 
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -227,12 +225,11 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
         }
 
         mirror_iteration_done(op, ret);
-    } else {
-        ret = blk_co_pwritev(s->target, op->offset,
-                             op->qiov.size, &op->qiov, 0);
-        mirror_write_complete(op, ret);
+        return;
     }
-    aio_context_release(blk_get_aio_context(s->common.blk));
+
+    ret = blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qiov, 0);
+    mirror_write_complete(op, ret);
 }
 
 /* Clip bytes relative to offset to not exceed end-of-file */
-- 
2.17.1
