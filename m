Received: from eggs.gnu.org ([2001:4830:134:3::10]:52248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxQD-0005dY-HP
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxQB-0003JY-OC
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:33:49 -0400
Date: Mon, 17 Apr 2017 11:33:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417033334.GA6717@lemon.lan>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
	<80449391-88a6-d517-0682-de555fe4c169@redhat.com>
	<20170416093743.GA24137@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170416093743.GA24137@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9-rc5 v2] block: Drain
 BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Sun, 04/16 10:37, Stefan Hajnoczi wrote:
> On Sat, Apr 15, 2017 at 01:10:02AM +0800, Paolo Bonzini wrote:
> > 
> > 
> > On 14/04/2017 16:51, Stefan Hajnoczi wrote:
> > > On Fri, Apr 14, 2017 at 9:02 AM, Fam Zheng <famz@redhat.com> wrote:
> > >> @@ -398,11 +399,15 @@ void bdrv_drain_all(void);
> > >>           */                                                \
> > >>          assert(!bs_->wakeup);                              \
> > >>          bs_->wakeup = true;                                \
> > >> -        while ((cond)) {                                   \
> > >> -            aio_context_release(ctx_);                     \
> > >> -            aio_poll(qemu_get_aio_context(), true);        \
> > >> -            aio_context_acquire(ctx_);                     \
> > >> -            waited_ = true;                                \
> > >> +        while (busy_) {                                    \
> > >> +            if ((cond)) {                                  \
> > >> +                waited_ = busy_ = true;                    \
> > >> +                aio_context_release(ctx_);                 \
> > >> +                aio_poll(qemu_get_aio_context(), true);    \
> > >> +                aio_context_acquire(ctx_);                 \
> > >> +            } else {                                       \
> > >> +                busy_ = aio_poll(ctx_, false);             \
> > >> +            }                                              \
> > > 
> > > Wait, I'm confused.  The current thread is not in the BDS AioContext.
> > > We're not allowed to call aio_poll(ctx_, false).
> > 
> > It's pretty ugly indeed.  Strictly from a thread-safety point of view,
> > everything that aio_poll calls will acquire the AioContext, so that is
> > safe and in fact the release/acquire pair can beeven  hoisted outside
> > the "if".
> > 
> > If we did that for blocking=true in both I/O and main thread, then that
> > would be racy.  This is the scenario mentioned in the commit message for
> > c9d1a56, "block: only call aio_poll on the current thread's AioContext",
> > 2016-10-28).
> > 
> > If only one thread has blocking=true, it's subject to races too.  In
> > this case, the I/O thread may fail to be woken by iothread_stop's
> > aio_notify.  However, by the time iothread_stop is called there should
> > be no BlockDriverStates (and thus no BDRV_POLL_WHILE running the above
> > code) for the I/O thread's AioContext.
> 
> The scenario I have in mind is:
> 
> BDRV_POLL_WHILE() is called from the IOThread and the main loop also
> invokes BDRV_POLL_WHILE().
> 
> The IOThread is blocked in aio_poll(ctx, true).
> 
> The main loop calls aio_poll(ctx, false) and can therefore steal the
> event/completion condition.
> 
> I *think* ppoll() will return in both threads and they will race to
> invoke handlers, but I'm not 100% sure that two BDRV_POLL_WHILE() calls
> in parallel are safe.
> 
> What do you think?

BDRV_POLL_WHILE in both IOThread and main loop has aio_context_acquire(ctx)
around it; in the branch where main loop calls aio_poll(ctx, false),
there is also no aio_context_release(ctx). So I thinki it is protected by the
AioContext lock, and is safe.

I tested your suggested "aio_poll(qemu_get_aio_context(), false)", but it
doesn't work. The new hunk is:

diff --git a/include/block/block.h b/include/block/block.h
index 97d4330..0e77522 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -381,12 +381,13 @@ void bdrv_drain_all(void);
 
 #define BDRV_POLL_WHILE(bs, cond) ({                       \
     bool waited_ = false;                                  \
+    bool busy_ = true;                                     \
     BlockDriverState *bs_ = (bs);                          \
     AioContext *ctx_ = bdrv_get_aio_context(bs_);          \
     if (aio_context_in_iothread(ctx_)) {                   \
-        while ((cond)) {                                   \
-            aio_poll(ctx_, true);                          \
-            waited_ = true;                                \
+        while ((cond) || busy_) {                          \
+            busy_ = aio_poll(ctx_, (cond));                \
+            waited_ |= !!(cond);                           \
         }                                                  \
     } else {                                               \
         assert(qemu_get_current_aio_context() ==           \
@@ -398,11 +399,12 @@ void bdrv_drain_all(void);
          */                                                \
         assert(!bs_->wakeup);                              \
         bs_->wakeup = true;                                \
-        while ((cond)) {                                   \
-            aio_context_release(ctx_);                     \
-            aio_poll(qemu_get_aio_context(), true);        \
-            aio_context_acquire(ctx_);                     \
-            waited_ = true;                                \
+        while ((cond) || busy_) {                          \
+                aio_context_release(ctx_);                 \
+                busy_ = aio_poll(qemu_get_aio_context(),   \
+                                 (cond));                  \
+                aio_context_acquire(ctx_);                 \
+                waited_ |= !!(cond);                       \
         }                                                  \
         bs_->wakeup = false;                               \
     }                                                      \

I get a coroutine re-enter crash (with the same drive-mirror -> ready -> reset
reproducer), which I don't fully understand yet:

#0  0x00007f09fdec091f in raise () at /lib64/libc.so.6
#1  0x00007f09fdec251a in abort () at /lib64/libc.so.6
#2  0x0000563e2017db9b in qemu_aio_coroutine_enter (ctx=0x563e21f52020, co=0x563e22cf1840) at /stor/work/qemu/util/qemu-coroutine.c:114
#3  0x0000563e2015ee82 in aio_co_enter (ctx=0x563e21f52020, co=0x563e22cf1840) at /stor/work/qemu/util/async.c:472
#4  0x0000563e2007241a in bdrv_coroutine_enter (bs=0x563e21fde470, co=0x563e22cf1840) at /stor/work/qemu/block.c:4333
#5  0x0000563e200745e6 in block_job_enter (job=0x563e22e76000) at /stor/work/qemu/blockjob.c:535
#6  0x0000563e20074554 in block_job_resume (job=0x563e22e76000) at /stor/work/qemu/blockjob.c:521
#7  0x0000563e20073372 in block_job_drained_end (opaque=0x563e22e76000) at /stor/work/qemu/blockjob.c:80
#8  0x0000563e200c0578 in blk_root_drained_end (child=0x563e21f9c8f0) at /stor/work/qemu/block/block-backend.c:1945
#9  0x0000563e200ce7af in bdrv_parent_drained_end (bs=0x563e21fde470) at /stor/work/qemu/block/io.c:64
#10 0x0000563e200cefe3 in bdrv_drained_end (bs=0x563e21fde470) at /stor/work/qemu/block/io.c:245 #11 0x0000563e200cf06f in bdrv_drain (bs=0x563e21fde470) at /stor/work/qemu/block/io.c:270
#12 0x0000563e200bf485 in blk_drain (blk=0x563e21f8eec0) at /stor/work/qemu/block/block-backend.c:1383
#13 0x0000563e1fd069aa in virtio_blk_reset (vdev=0x563e23afd950) at /stor/work/qemu/hw/block/virtio-blk.c:708
#14 0x0000563e1fd4c2fd in virtio_reset (opaque=0x563e23afd950) at /stor/work/qemu/hw/virtio/virtio.c:1200
#15 0x0000563e1ffdea74 in virtio_bus_reset (bus=0x563e23afd8d8) at /stor/work/qemu/hw/virtio/virtio-bus.c:96
#16 0x0000563e1ffdc609 in virtio_pci_reset (qdev=0x563e23af5440) at /stor/work/qemu/hw/virtio/virtio-pci.c:1873
#17 0x0000563e1fe994e9 in device_reset (dev=0x563e23af5440) at /stor/work/qemu/hw/core/qdev.c:1169
#18 0x0000563e1fe9735b in qdev_reset_one (dev=0x563e23af5440, opaque=0x0) at /stor/work/qemu/hw/core/qdev.c:310
#19 0x0000563e1fe97f5f in qdev_walk_children (dev=0x563e23af5440, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x563e1fe9733f <qdev_reset_one>, post_busfn=0x563e1fe97362 <qbus_reset_one>, opaque=0x0) at /stor/work/qemu/hw/core/qdev.c:625
#20 0x0000563e1fe9c125 in qbus_walk_children (bus=0x563e2216e1f0, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x563e1fe9733f <qdev_reset_one>, post_busfn=0x563e1fe97362 <qbus_reset_one>, opaque=0x0) at /stor/work/qemu/hw/core/bus.c:59
#21 0x0000563e1fe97f23 in qdev_walk_children (dev=0x563e2216c790, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x563e1fe9733f <qdev_reset_one>, post_busfn=0x563e1fe97362 <qbus_reset_one>, opaque=0x0) at /stor/work/qemu/hw/core/qdev.c:617
#22 0x0000563e1fe9c125 in qbus_walk_children (bus=0x563e21fe9ae0, pre_devfn=0x0, pre_busfn=0x0, post_devfn=0x563e1fe9733f <qdev_reset_one>, post_busfn=0x563e1fe97362 <qbus_reset_one>, opaque=0x0) at /stor/work/qemu/hw/core/bus.c:59
#23 0x0000563e1fe97475 in qbus_reset_all (bus=0x563e21fe9ae0) at /stor/work/qemu/hw/core/qdev.c:336
#24 0x0000563e1fe97498 in qbus_reset_all_fn (opaque=0x563e21fe9ae0) at /stor/work/qemu/hw/core/qdev.c:342
#25 0x0000563e1fe9ca6b in qemu_devices_reset () at /stor/work/qemu/hw/core/reset.c:69
#26 0x0000563e1fd6377d in pc_machine_reset () at /stor/work/qemu/hw/i386/pc.c:2234
#27 0x0000563e1fe0f4d4 in qemu_system_reset (report=true) at /stor/work/qemu/vl.c:1697
#28 0x0000563e1fe0f8fe in main_loop_should_exit () at /stor/work/qemu/vl.c:1865
#29 0x0000563e1fe0f9cb in main_loop () at /stor/work/qemu/vl.c:1902
#30 0x0000563e1fe17716 in main (argc=20, argv=0x7ffde0a17168, envp=0x7ffde0a17210) at /stor/work/qemu/vl.c:4709

(gdb) info thread
  Id   Target Id         Frame 
* 1    Thread 0x7f0a04396c00 (LWP 6192) "qemu-system-x86" 0x0000563e2017db9b in qemu_aio_coroutine_enter (ctx=0x563e21f52020, co=0x563e22cf1840)
    at /stor/work/qemu/util/qemu-coroutine.c:114
  2    Thread 0x7f09f535e700 (LWP 6193) "qemu-system-x86" 0x00007f0a022d2c7d in nanosleep () from /lib64/libpthread.so.0
  3    Thread 0x7f09f4b5d700 (LWP 6194) "qemu-system-x86" 0x0000563e2015e98c in aio_notify (ctx=0x563e21f52020) at /stor/work/qemu/util/async.c:341
  4    Thread 0x7f09ef117700 (LWP 6196) "qemu-system-x86" 0x00007f0a022cf460 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0

(gdb) t 3
[Switching to thread 3 (Thread 0x7f09f4b5d700 (LWP 6194))]
#0  0x0000563e2015e98c in aio_notify (ctx=0x563e21f52020) at /stor/work/qemu/util/async.c:341
341	    if (ctx->notify_me) {
(gdb) bt
#0  0x0000563e2015e98c in aio_notify (ctx=0x563e21f52020) at /stor/work/qemu/util/async.c:341
#1  0x0000563e2015ea10 in aio_timerlist_notify (opaque=0x563e21f52020, type=QEMU_CLOCK_REALTIME) at /stor/work/qemu/util/async.c:356
#2  0x0000563e2016032f in timerlist_notify (timer_list=0x563e21f521e0) at /stor/work/qemu/util/qemu-timer.c:281
#3  0x0000563e20160656 in timerlist_rearm (timer_list=0x563e21f521e0) at /stor/work/qemu/util/qemu-timer.c:404
#4  0x0000563e20160729 in timer_mod_ns (ts=0x7f09f00014c0, expire_time=176119278967) at /stor/work/qemu/util/qemu-timer.c:432
#5  0x0000563e20160807 in timer_mod (ts=0x7f09f00014c0, expire_time=176119278967) at /stor/work/qemu/util/qemu-timer.c:462
#6  0x0000563e2017f00a in co_aio_sleep_ns (ctx=0x563e21f52020, type=QEMU_CLOCK_REALTIME, ns=100000000) at /stor/work/qemu/util/qemu-coroutine-sleep.c:38
#7  0x0000563e20074941 in block_job_sleep_ns (job=0x563e22e76000, type=QEMU_CLOCK_REALTIME, ns=100000000) at /stor/work/qemu/blockjob.c:636
#8  0x0000563e200cbba1 in mirror_run (opaque=0x563e22e76000) at /stor/work/qemu/block/mirror.c:881
#9  0x0000563e20073b1e in block_job_co_entry (opaque=0x563e22e76000) at /stor/work/qemu/blockjob.c:282
#10 0x0000563e2017f0bb in coroutine_trampoline (i0=583997504, i1=22078) at /stor/work/qemu/util/coroutine-ucontext.c:79
#11 0x00007f09fded5bf0 in __start_context () at /lib64/libc.so.6
#12 0x00007ffde0a14cd0 in  ()
#13 0x0000000000000000 in  ()
