Received: from eggs.gnu.org ([2001:4830:134:3::10]:54050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYE-0007do-Vj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTrYD-0008K0-MI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:58:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  3 Dec 2018 17:58:09 +0100
Message-Id: <20181203165810.14509-2-kwolf@redhat.com>
In-Reply-To: <20181203165810.14509-1-kwolf@redhat.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] mirror: fix dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
 #3  qemu_mutex_lock_impl (mutex=3D0x561032dce420 <qemu_global_mutex>,
     file=3D0x5610327d8654 "util/main-loop.c", line=3D236) at
     util/qemu-thread-posix.c:66
 #4  qemu_mutex_lock_iothread_impl
 #5  os_host_main_loop_wait (timeout=3D480116000) at util/main-loop.c:236
 #6  main_loop_wait (nonblocking=3D0) at util/main-loop.c:497
 #7  main_loop () at vl.c:1892
 #8  main

Printing contents of qemu_global_mutex, I see that "__owner =3D 145416",
so, thr1 is main loop, and now it wants BQL, which is owned by thr2.

 (gdb) thr 2
 (gdb) bt
 #0  __lll_lock_wait ()
 #1  _L_lock_870 ()
 #2  __GI___pthread_mutex_lock
 #3  qemu_mutex_lock_impl (mutex=3D0x561034d25dc0, ...
 #4  aio_context_acquire (ctx=3D0x561034d25d60)
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

Printing mutex in fr 2, I see "__owner =3D 145411", so thr2 wants aio
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
---
 block/mirror.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 56d9ef7474..8f52c6215d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -199,7 +199,6 @@ static void coroutine_fn mirror_write_complete(Mirror=
Op *op, int ret)
 {
     MirrorBlockJob *s =3D op->s;
=20
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
=20
@@ -209,15 +208,14 @@ static void coroutine_fn mirror_write_complete(Mirr=
orOp *op, int ret)
             s->ret =3D ret;
         }
     }
+
     mirror_iteration_done(op, ret);
-    aio_context_release(blk_get_aio_context(s->common.blk));
 }
=20
 static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s =3D op->s;
=20
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
=20
@@ -228,12 +226,11 @@ static void coroutine_fn mirror_read_complete(Mirro=
rOp *op, int ret)
         }
=20
         mirror_iteration_done(op, ret);
-    } else {
-        ret =3D blk_co_pwritev(s->target, op->offset,
-                             op->qiov.size, &op->qiov, 0);
-        mirror_write_complete(op, ret);
+        return;
     }
-    aio_context_release(blk_get_aio_context(s->common.blk));
+
+    ret =3D blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qi=
ov, 0);
+    mirror_write_complete(op, ret);
 }
=20
 /* Clip bytes relative to offset to not exceed end-of-file */
--=20
2.19.2
