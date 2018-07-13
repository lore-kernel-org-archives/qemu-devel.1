Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdvNM-0004Ph-UJ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdvNJ-0002LN-Gk
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:32:36 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:51526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fdvNJ-0002Fa-4c
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:32:33 -0400
Received: from player779.ha.ovh.net (unknown [10.109.143.3])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 91D99BAA32
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 12:32:24 +0200 (CEST)
Date: Fri, 13 Jul 2018 12:32:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180713123218.40fdf06a@bahia.lan>
In-Reply-To: <d8b2dc17-d275-272d-a8b3-c4369de4c67d@redhat.com>
References: <d8b2dc17-d275-272d-a8b3-c4369de4c67d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-iotests RC0+ status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, 12 Jul 2018 18:16:05 -0400
John Snow <jsnow@redhat.com> wrote:

> Hi, on Fedora 28 x64 host, as of 68f1b569 I'm seeing:
> 
> `./check -v -qcow`
> 	- occasional stall on 052
> 	- stalls on 216
> 
> `./check -v -qed`
> 	- stalls on 200
> 
> `./check -v -luks`
> 	- failures on 226.
> 
> 
> 052 is something I can't reproduce. The test takes quite a while, so
> maybe at some points I am simply not being patient enough.
> 
> 
> 216 appears to have never worked for qcow1.
> 
> 
> 226 is my fault: the test doesn't handle LUKS well, because it sets
> TEST_IMG to something sneaky:
> 'driver=luks,key-secret=keysec0,file.filename=/path/to/src/qemu/bin/git/tests/qemu-iotests/scratch/t.luks'
> ... my test expected this to be a real file and doesn't suffer this
> particularly well. I've sent a patch.
> 
> 
> 200 appears to regress on this commit:
> f45280cbf66d8e58224f6a253d0ae2aa72cc6280 is the first bad commit
> commit f45280cbf66d8e58224f6a253d0ae2aa72cc6280
> Author: Greg Kurz <groug@kaod.org>
> Date:   Mon May 28 14:03:59 2018 +0200
> 

Hi,

After a few tries, I could reproduce the hang.

(gdb) thread apply all bt

Thread 5 (Thread 0x7fbea5be8700 (LWP 482289)):
#0  0x00007fbeb4646caf in do_sigwait () at /lib64/libpthread.so.0
#1  0x00007fbeb4646d3d in sigwait () at /lib64/libpthread.so.0
#2  0x0000560b3e4b05b5 in qemu_dummy_cpu_thread_fn (arg=0x560b3f925750) at /var/tmp/qemu/cpus.c:1260
#3  0x0000560b3ea5561d in qemu_thread_start (args=0x560b3f9449b0) at util/qemu-thread-posix.c:504
#4  0x00007fbeb463c50b in start_thread () at /lib64/libpthread.so.0
#5  0x00007fbeb437416f in clone () at /lib64/libc.so.6

Thread 4 (Thread 0x7fbea70ef700 (LWP 482286)):
#0  0x00007fbeb4645b1d in __lll_lock_wait () at /lib64/libpthread.so.0
#1  0x00007fbeb463ef18 in pthread_mutex_lock () at /lib64/libpthread.so.0
#2  0x0000560b3ea54aa6 in qemu_mutex_lock_impl (mutex=0x560b3f9032a0, file=0x560b3ebd0c41 "util/async.c", line=511) at util/qemu-thread-posix.c:66
#3  0x0000560b3ea4dcf0 in aio_context_acquire (ctx=0x560b3f903240) at util/async.c:511
#4  0x0000560b3ea4d88a in co_schedule_bh_cb (opaque=0x560b3f903240) at util/async.c:399
#5  0x0000560b3ea4cfaa in aio_bh_call (bh=0x560b3f901a70) at util/async.c:90
#6  0x0000560b3ea4d042 in aio_bh_poll (ctx=0x560b3f903240) at util/async.c:118
#7  0x0000560b3ea525a6 in aio_poll (ctx=0x560b3f903240, blocking=true) at util/aio-posix.c:689
#8  0x0000560b3e63d3b1 in iothread_run (opaque=0x560b3f8d3000) at iothread.c:64
#9  0x0000560b3ea5561d in qemu_thread_start (args=0x560b3f9035e0) at util/qemu-thread-posix.c:504
#10 0x00007fbeb463c50b in start_thread () at /lib64/libpthread.so.0
#11 0x00007fbeb437416f in clone () at /lib64/libc.so.6

Thread 3 (Thread 0x7fbea78f0700 (LWP 482285)):
#0  0x00007fbeb4369d66 in ppoll () at /lib64/libc.so.6
#1  0x0000560b3ea4f59d in qemu_poll_ns (fds=0x7fbe98000b20, nfds=1, timeout=-1) at util/qemu-timer.c:322
#2  0x0000560b3ea522d9 in aio_poll (ctx=0x560b3f82f320, blocking=true) at util/aio-posix.c:629
#3  0x0000560b3e63d3b1 in iothread_run (opaque=0x560b3f82f050) at iothread.c:64
#4  0x0000560b3ea5561d in qemu_thread_start (args=0x560b3f8306a0) at util/qemu-thread-posix.c:504
#5  0x00007fbeb463c50b in start_thread () at /lib64/libpthread.so.0
#6  0x00007fbeb437416f in clone () at /lib64/libc.so.6

Thread 2 (Thread 0x7fbea80f1700 (LWP 482284)):
#0  0x00007fbeb436eb99 in syscall () at /lib64/libc.so.6
#1  0x0000560b3ea552a9 in qemu_futex_wait (f=0x560b3f21c2f8 <rcu_call_ready_event>, val=4294967295) at /var/tmp/qemu/include/qemu/futex.h:29
#2  0x0000560b3ea55470 in qemu_event_wait (ev=0x560b3f21c2f8 <rcu_call_ready_event>) at util/qemu-thread-posix.c:442
#3  0x0000560b3ea6dcaa in call_rcu_thread (opaque=0x0) at util/rcu.c:261
#4  0x0000560b3ea5561d in qemu_thread_start (args=0x560b3f7cdaa0) at util/qemu-thread-posix.c:504
#5  0x00007fbeb463c50b in start_thread () at /lib64/libpthread.so.0
#6  0x00007fbeb437416f in clone () at /lib64/libc.so.6

Thread 1 (Thread 0x7fbebca47d00 (LWP 482283)):
#0  0x00007fbeb4369d66 in ppoll () at /lib64/libc.so.6
#1  0x0000560b3ea4f59d in qemu_poll_ns (fds=0x560b3f914f50, nfds=1, timeout=-1) at util/qemu-timer.c:322
#2  0x0000560b3ea522d9 in aio_poll (ctx=0x560b3f8f5f10, blocking=true) at util/aio-posix.c:629
#3  0x0000560b3e9980fa in bdrv_do_drained_begin (bs=0x560b3f9086e0, recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:390
#4  0x0000560b3e998167 in bdrv_drained_begin (bs=0x560b3f9086e0) at block/io.c:396
#5  0x0000560b3e984ac8 in blk_drain (blk=0x560b3fb6b140) at block/block-backend.c:1591
#6  0x0000560b3e982fa3 in blk_remove_bs (blk=0x560b3fb6b140) at block/block-backend.c:775
#7  0x0000560b3e9824f8 in blk_delete (blk=0x560b3fb6b140) at block/block-backend.c:401
#8  0x0000560b3e98271d in blk_unref (blk=0x560b3fb6b140) at block/block-backend.c:450
#9  0x0000560b3e929a8c in block_job_free (job=0x560b3f874c00) at blockjob.c:98
#10 0x0000560b3e92b86e in job_unref (job=0x560b3f874c00) at job.c:367
#11 0x0000560b3e92c1ed in job_do_dismiss (job=0x560b3f874c00) at job.c:633
#12 0x0000560b3e92c2f9 in job_conclude (job=0x560b3f874c00) at job.c:659
#13 0x0000560b3e92c586 in job_finalize_single (job=0x560b3f874c00) at job.c:727
#14 0x0000560b3e92c771 in job_completed_txn_abort (job=0x560b3f874c00) at job.c:783
#15 0x0000560b3e92cb6e in job_completed (job=0x560b3f874c00, ret=0, error=0x0) at job.c:882
#16 0x0000560b3e683260 in stream_complete (job=0x560b3f874c00, opaque=0x560b3f9035e0) at block/stream.c:96
#17 0x0000560b3e92ce4b in job_defer_to_main_loop_bh (opaque=0x560b3f903600) at job.c:973
#18 0x0000560b3ea4cfaa in aio_bh_call (bh=0x7fbe9c001230) at util/async.c:90
#19 0x0000560b3ea4d042 in aio_bh_poll (ctx=0x560b3f8f5f10) at util/async.c:118
#20 0x0000560b3ea51bca in aio_dispatch (ctx=0x560b3f8f5f10) at util/aio-posix.c:436
#21 0x0000560b3ea4d3dd in aio_ctx_dispatch (source=0x560b3f8f5f10, callback=0x0, user_data=0x0) at util/async.c:261
#22 0x00007fbebc183b77 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#23 0x0000560b3ea50623 in glib_pollfds_poll () at util/main-loop.c:215
#24 0x0000560b3ea50691 in os_host_main_loop_wait (timeout=0) at util/main-loop.c:238
#25 0x0000560b3ea5074a in main_loop_wait (nonblocking=0) at util/main-loop.c:497
#26 0x0000560b3e6462fc in main_loop () at vl.c:1866
#27 0x0000560b3e64dbf3 in main (argc=21, argv=0x7ffc4f767948, envp=0x7ffc4f7679f8) at vl.c:4644


Thread 4 is iothread0.

#3  0x0000560b3ea4dcf0 in aio_context_acquire (ctx=0x560b3f903240) at util/async.c:511
511         qemu_rec_mutex_lock(&ctx->lock);
(gdb) p ctx
$34 = (AioContext *) 0x560b3f903240
(gdb) p ctx->lock.lock.__data.__owner 
$35 = 482283

482283 is the pid of the main thread, which seems to have acquired this aio context
in job_defer_to_main_loop_bh().

#17 0x0000560b3e92ce4b in job_defer_to_main_loop_bh (opaque=0x560b3f903600) at job.c:973
973         data->fn(data->job, data->opaque);
(gdb) p data->job->aio_context
$36 = (AioContext *) 0x560b3f903240


It looks like we have a deadlock here... Not sure how to debug that :-\

Cheers,

--
Greg

> 
> 
> Thanks,
> --js
