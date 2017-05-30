Received: from eggs.gnu.org ([2001:4830:134:3::10]:58229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dFcuh-0002hd-3X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dFcud-0001Iz-Uy
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:54:03 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dFcud-0001Ir-Kw
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:53:59 -0400
Received: by mail-wm0-x22f.google.com with SMTP id e127so90105637wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 01:53:59 -0700 (PDT)
From: Roman Pen <roman.penyaev@profitbricks.com>
Date: Tue, 30 May 2017 10:53:46 +0200
Message-Id: <20170530085346.1730-1-roman.penyaev@profitbricks.com>
Subject: [Qemu-devel] [PATCH 1/1] coroutine-lock: do not touch coroutine
 after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Submission of requests on linux aio is a bit tricky and can lead to
requests completions on submission path:

44713c9e8547 ("linux-aio: Handle io_submit() failure gracefully")
0ed93d84edab ("linux-aio: process completions from ioq_submit()")

That means that any coroutine which has been yielded in order to wait
for completion can be resumed from submission path and be eventually
terminated (freed).

The following use-after-free crash was observed when IO throttling
was enabled:

 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 0x7f5813dff700 (LWP 56417)]
 virtqueue_unmap_sg (elem=0x7f5804009a30, len=1, vq=<optimized out>) at virtio.c:252
 (gdb) bt
 #0  virtqueue_unmap_sg (elem=0x7f5804009a30, len=1, vq=<optimized out>) at virtio.c:252
                              ^^^^^^^^^^^^^^
                              remember the address

 #1  virtqueue_fill (vq=0x5598b20d21b0, elem=0x7f5804009a30, len=1, idx=0) at virtio.c:282
 #2  virtqueue_push (vq=0x5598b20d21b0, elem=elem@entry=0x7f5804009a30, len=<optimized out>) at virtio.c:308
 #3  virtio_blk_req_complete (req=req@entry=0x7f5804009a30, status=status@entry=0 '\000') at virtio-blk.c:61
 #4  virtio_blk_rw_complete (opaque=<optimized out>, ret=0) at virtio-blk.c:126
 #5  blk_aio_complete (acb=0x7f58040068d0) at block-backend.c:923
 #6  coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at coroutine-ucontext.c:78

 (gdb) p * elem
 $8 = {index = 77, out_num = 2, in_num = 1,
       in_addr = 0x7f5804009ad8, out_addr = 0x7f5804009ae0,
       in_sg = 0x0, out_sg = 0x7f5804009a50}
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       'in_sg' and 'out_sg' are invalid.
       e.g. it is impossible that 'in_sg' is zero,
       instead its value must be equal to:

       (gdb) p/x 0x7f5804009ad8 + sizeof(elem->in_addr[0]) + 2 * sizeof(elem->out_addr[0])
       $26 = 0x7f5804009af0

Seems 'elem' was corrupted.  Meanwhile another thread raised an abort:

 Thread 12 (Thread 0x7f57f2ffd700 (LWP 56426)):
 #0  raise () from /lib/x86_64-linux-gnu/libc.so.6
 #1  abort () from /lib/x86_64-linux-gnu/libc.so.6
 #2  qemu_coroutine_enter (co=0x7f5804009af0) at qemu-coroutine.c:113
 #3  qemu_co_queue_run_restart (co=0x7f5804009a30) at qemu-coroutine-lock.c:60
 #4  qemu_coroutine_enter (co=0x7f5804009a30) at qemu-coroutine.c:119
                           ^^^^^^^^^^^^^^^^^^
                           WTF?? this is equal to elem from crashed thread

 #5  qemu_co_queue_run_restart (co=0x7f57e7f16ae0) at qemu-coroutine-lock.c:60
 #6  qemu_coroutine_enter (co=0x7f57e7f16ae0) at qemu-coroutine.c:119
 #7  qemu_co_queue_run_restart (co=0x7f5807e112a0) at qemu-coroutine-lock.c:60
 #8  qemu_coroutine_enter (co=0x7f5807e112a0) at qemu-coroutine.c:119
 #9  qemu_co_queue_run_restart (co=0x7f5807f17820) at qemu-coroutine-lock.c:60
 #10 qemu_coroutine_enter (co=0x7f5807f17820) at qemu-coroutine.c:119
 #11 qemu_co_queue_run_restart (co=0x7f57e7f18e10) at qemu-coroutine-lock.c:60
 #12 qemu_coroutine_enter (co=0x7f57e7f18e10) at qemu-coroutine.c:119
 #13 qemu_co_enter_next (queue=queue@entry=0x5598b1e742d0) at qemu-coroutine-lock.c:106
 #14 timer_cb (blk=0x5598b1e74280, is_write=<optimized out>) at throttle-groups.c:419

Crash can be explained by access of 'co' object from the loop inside
qemu_co_queue_run_restart():

  while ((next = QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
      QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
                           ^^^^^^^^^^^^^^^^^^^^
                           on each iteration 'co' is accessed,
                           but 'co' can be already freed

      qemu_coroutine_enter(next);
  }

When 'next' coroutine is resumed (entered) it can in its turn resume
'co', and eventually free it.  That's why we see 'co' (which was freed)
has the same address as 'elem' from the first backtrace.

The fix is obvious: use temporal queue and do not touch coroutine after
first qemu_coroutine_enter() is invoked.

The issue is quite rare and happens every ~12 hours on very high IO load
(building linux kernel with -j512 inside guest) when IO throttling is
enabled.  With the fix applied guest is running ~35 hours and is still
alive so far.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
---
 util/qemu-coroutine-lock.c | 17 +++++++++++++++--
 util/qemu-coroutine.c      |  7 +++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 6328eed26bc6..026f5297f0f9 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -77,10 +77,23 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
 void qemu_co_queue_run_restart(Coroutine *co)
 {
     Coroutine *next;
+    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =
+        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
 
     trace_qemu_co_queue_run_restart(co);
-    while ((next = QSIMPLEQ_FIRST(&co->co_queue_wakeup))) {
-        QSIMPLEQ_REMOVE_HEAD(&co->co_queue_wakeup, co_queue_next);
+
+    /*
+     * We use temporal queue in order not to touch 'co' after entering
+     * 'next' coroutine.  The thing is that 'next' coroutine can resume
+     * current 'co' coroutine and eventually terminate (free) it (see
+     * linux-aio.c: ioq_submit() where qemu_laio_process_completions()
+     * is invoked).  The rule of thumb is simple: do not touch coroutine
+     * when you enter another one.
+     */
+    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
+
+    while ((next = QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
+        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
         qemu_coroutine_enter(next);
     }
 }
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 486af9a62275..d020b63742af 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -126,6 +126,13 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
 
     qemu_co_queue_run_restart(co);
 
+    /*
+     * BEWARE: in case of ret == COROUTINE_YIELD here at this point
+     *         after qemu_co_queue_run_restart() 'co' can be already
+     *         freed by other coroutine, which has entered 'co'. So
+     *         be careful and do not touch it.
+     */
+
     switch (ret) {
     case COROUTINE_YIELD:
         return;
-- 
2.11.0
