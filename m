Received: from eggs.gnu.org ([2001:4830:134:3::10]:49787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d66sP-0007ZS-1U
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d66sL-0008SJ-St
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:52:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d66sI-0008G5-LR
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:52:17 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
	<58FD9546.5000104@huawei.com>
	<82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
	<58FF1DF7.4000006@huawei.com>
	<bfac018b-55cf-9cf8-5ffe-ff0d1fbd4b53@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <590A971B.1070900@huawei.com>
Date: Thu, 4 May 2017 10:51:07 +0800
MIME-Version: 1.0
In-Reply-To: <bfac018b-55cf-9cf8-5ffe-ff0d1fbd4b53@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: serialize compare
 thread's initialization with main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com

Hi Jason,

On 2017/4/25 19:33, Jason Wang wrote:
>
> On 2017年04月25日 17:59, Hailiang Zhang wrote:
>> On 2017/4/25 16:41, Jason Wang wrote:
>>> On 2017年04月24日 14:03, Hailiang Zhang wrote:
>>>> On 2017/4/24 12:10, Jason Wang wrote:
>>>>> On 2017年04月20日 15:46, zhanghailiang wrote:
>>>>>> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is used
>>>>>> to detach watched fd from default main context, so it has chance to
>>>>>> handle the same watched fd with main thread concurrently, which will
>>>>>> trigger an error report:
>>>>>> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src ==
>>>>>> ((void *)0)' failed."
>>>>> Anyway to prevent fd from being handled by main thread before creating
>>>>> colo thread? Using semaphore seems not elegant.
>>>> So how about calling qemu_mutex_lock_iothread() before
>>>> qemu_chr_fe_set_handlers() ?
>>> Looks better, but I needs more information e.g how main thread can
>>> touch it?
>> Hmm, this happened quite occasionally, and we didn't catch the first
>> place (backtrace)
>> of removing fd from been watched, but  from the codes logic, we found
>> there should
>> be such possible cases:
>> tcp_chr_write (Or tcp_chr_read/tcp_chr_sync_read/chr_disconnect)
>>   ->tcp_chr_disconnect (Or char_socket_finalize)
>>      ->tcp_chr_free_connection
>>        -> remove_fd_in_watch(chr);
>>
>> Anyway, it needs the protection from been freed twice.
>>
>> Thanks,
>> Hailiang
> Still a little bit confused. The question is how could main thread still
> call tcp_chr_write or other in the above case?

Finally, we reproduced this bug (We use qemu 2.6), and got the follow backtrace of this problem:

(gdb) thread apply all bt

Thread 7 (Thread 0x7f407a1ff700 (LWP 23144)):
#0  0x00007f41037e0db5 in _int_malloc () from /usr/lib64/libc.so.6
#1  0x00007f41037e3b96 in calloc () from /usr/lib64/libc.so.6
#2  0x00007f41041ad4d7 in g_malloc0 () from /usr/lib64/libglib-2.0.so.0
#3  0x00007f41041a5437 in g_source_new () from /usr/lib64/libglib-2.0.so.0
#4  0x00007f410a2cec9c in qio_channel_create_fd_watch (ioc=ioc@entry=0x7f410d6238c0, fd=20, condition=condition@entry=
     (G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL)) at io/channel-watch.c:259
#5  0x00007f410a2ced01 in qio_channel_create_socket_watch (ioc=ioc@entry=0x7f410d6238c0, socket=<optimized out>,
     condition=condition@entry=(G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL)) at io/channel-watch.c:311
#6  0x00007f410a2cbea7 in qio_channel_socket_create_watch (ioc=0x7f410d6238c0, condition=(G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL))
     at io/channel-socket.c:732
#7  0x00007f410a2c94d2 in qio_channel_create_watch (ioc=0x7f410d6238c0, condition=condition@entry=
     (G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL)) at io/channel.c:132
#8  0x00007f410a003cd6 in io_watch_poll_prepare (source=0x7f4070000d00, timeout_=<optimized out>) at qemu-char.c:883
#9  0x00007f41041a72ed in g_main_context_prepare () from /usr/lib64/libglib-2.0.so.0
#10 0x00007f41041a7b7b in g_main_context_iterate.isra.24 () from /usr/lib64/libglib-2.0.so.0
#11 0x00007f41041a7fba in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
#12 0x00007f410a1e528f in colo_compare_thread (opaque=0x7f410d7d6800) at net/colo-compare.c:651
#13 0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#14 0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 6 (Thread 0x7f40799fe700 (LWP 19368)):
#0  0x00007f4103b2f6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x00007f410a3138d1 in qemu_cond_wait (cond=cond@entry=0x7f410cce44c0, mutex=mutex@entry=0x7f410cce44f0)
     at util/qemu-thread-posix.c:132
---Type <return> to continue, or q <return> to quit---
#2  0x00007f410a22b1a3 in vnc_worker_thread_loop (queue=queue@entry=0x7f410cce44c0) at ui/vnc-jobs.c:228
#3  0x00007f410a22b810 in vnc_worker_thread (arg=0x7f410cce44c0) at ui/vnc-jobs.c:335
#4  0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 5 (Thread 0x7f407abff700 (LWP 19366)):
#0  0x00007f4103b2f6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x00007f410a3138d1 in qemu_cond_wait (cond=cond@entry=0x7f410a9fc368 <mlock_struct+40>,
     mutex=mutex@entry=0x7f410a9fc340 <mlock_struct>) at util/qemu-thread-posix.c:132
#2  0x00007f4109e99060 in mlock_wait () at /work/zhanghailiang/qemu-kvm/exec.c:392
#3  mlock_thread (opaque=<optimized out>) at /work/zhanghailiang/qemu-kvm/exec.c:407
#4  0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 4 (Thread 0x7f40fcd83700 (LWP 19364)):
#0  0x00007f4103b2f6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x00007f410a3138d1 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x7f410aa66ca0 <qemu_global_mutex>)
     at util/qemu-thread-posix.c:132
#2  0x00007f4109ed5b3b in qemu_kvm_wait_io_event (cpu=0x7f410c2bda30) at /work/zhanghailiang/qemu-kvm/cpus.c:1087
#3  qemu_kvm_cpu_thread_fn (arg=0x7f410c2bda30) at /work/zhanghailiang/qemu-kvm/cpus.c:1126
#4  0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 3 (Thread 0x7f40fd584700 (LWP 19363)):
#0  0x00007f4103b2f6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /usr/lib64/libpthread.so.0
#1  0x00007f410a3138d1 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x7f410aa66ca0 <qemu_global_mutex>)
---Type <return> to continue, or q <return> to quit---
     at util/qemu-thread-posix.c:132
#2  0x00007f4109ed5b3b in qemu_kvm_wait_io_event (cpu=0x7f410c24e690) at /work/zhanghailiang/qemu-kvm/cpus.c:1087
#3  qemu_kvm_cpu_thread_fn (arg=0x7f410c24e690) at /work/zhanghailiang/qemu-kvm/cpus.c:1126
#4  0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 2 (Thread 0x7f40fde76700 (LWP 19311)):
#0  0x00007f4103853e99 in syscall () from /usr/lib64/libc.so.6
#1  0x00007f410a313d52 in futex_wait (val=4294967295, ev=0x7f410afe4fc8 <rcu_call_ready_event>) at util/qemu-thread-posix.c:301
#2  qemu_event_wait (ev=ev@entry=0x7f410afe4fc8 <rcu_call_ready_event>) at util/qemu-thread-posix.c:408
#3  0x00007f410a329846 in call_rcu_thread (opaque=<optimized out>) at util/rcu.c:250
#4  0x00007f4103b2bdc5 in start_thread () from /usr/lib64/libpthread.so.0
#5  0x00007f410385971d in clone () from /usr/lib64/libc.so.6

Thread 1 (Thread 0x7f4109b73bc0 (LWP 19310)):
#0  0x00007f41037985d7 in raise () from /usr/lib64/libc.so.6
#1  0x00007f4103799cc8 in abort () from /usr/lib64/libc.so.6
#2  0x00007f4103791546 in __assert_fail_base () from /usr/lib64/libc.so.6
#3  0x00007f41037915f2 in __assert_fail () from /usr/lib64/libc.so.6
#4  0x00007f410a003778 in io_watch_poll_finalize (source=<optimized out>) at qemu-char.c:919
#5  0x00007f41041a4de2 in g_source_unref_internal () from /usr/lib64/libglib-2.0.so.0
#6  0x00007f41041a4fee in g_source_iter_next () from /usr/lib64/libglib-2.0.so.0
#7  0x00007f41041a728b in g_main_context_prepare () from /usr/lib64/libglib-2.0.so.0
#8  0x00007f410a23fdca in glib_pollfds_fill (cur_timeout=<synthetic pointer>) at main-loop.c:196
#9  os_host_main_loop_wait (timeout=2491118968) at main-loop.c:235
#10 main_loop_wait (nonblocking=<optimized out>) at main-loop.c:517
---Type <return> to continue, or q <return> to quit---
#11 0x00007f4109e890fd in main_loop () at vl.c:2202
#12 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:5124

In this case,  main thread and colo compare thread process the same GSource concurrently.
(I still didn't figure out why g_main_context_prepare call finalize callback here).

Thanks,


> Thanks
>
>>> Thanks
>>>
>>> .
>>>
>>
>
> .
>
