Received: from eggs.gnu.org ([2001:4830:134:3::10]:56893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxCXt-0007us-6Z
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 09:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxCXr-0005Oi-P3
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 09:06:21 -0400
MIME-Version: 1.0
In-Reply-To: <20170407113312.GN13602@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113312.GN13602@stefanha-x1.localdomain>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Sun, 9 Apr 2017 21:06:18 +0800
Message-ID: <CAOGPPbfs8Ht0ei6TEw7pZ8o5nCx5MEUM7EDGX2OG_Ghwe8GD0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Apr 7, 2017 at 7:33 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
>> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
>> >> From: Lidong Chen <lidongchen@tencent.com>
>> >>
>> >> when migration with high speed, mig_save_device_bulk invoke
>> >> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
>> >> this patch limit the time used for bdrv_is_allocated.
>> >
>> > bdrv_is_allocated() is supposed to yield back to the event loop if it
>> > needs to block.  If your VNC session is experiencing jitter then it's
>> > probably because a system call in the bdrv_is_allocated() code path is
>> > synchronous when it should be asynchronous.
>> >
>> > You could try to identify the system call using strace -f -T.  In the
>> > output you'll see the duration of each system call.  I guess there is a
>> > file I/O system call that is taking noticable amounts of time.
>>
>> yes, i find the reason where bdrv_is_allocated needs to block.
>>
>> the mainly reason is caused by qemu_co_mutex_lock invoked by
>> qcow2_co_get_block_status.
>>     qemu_co_mutex_lock(&s->lock);
>>     ret = qcow2_get_cluster_offset(bs, sector_num << 9, &bytes,
>>                                    &cluster_offset);
>>     qemu_co_mutex_unlock(&s->lock);
>>
>> other reason is caused by l2_load invoked by
>> qcow2_get_cluster_offset.
>>
>>     /* load the l2 table in memory */
>>
>>     ret = l2_load(bs, l2_offset, &l2_table);
>>     if (ret < 0) {
>>         return ret;
>>     }
>
> The migration thread is holding the QEMU global mutex, the AioContext,
> and the qcow2 s->lock while the L2 table is read from disk.
>
> The QEMU global mutex is needed for block layer operations that touch
> the global drives list.  bdrv_is_allocated() can be called without the
> global mutex.
>
> The VNC server's file descriptor is not in the BDS AioContext.
> Therefore it can be processed while the migration thread holds the
> AioContext and qcow2 s->lock.
>
> Does the following patch solve the problem?
>
> diff --git a/migration/block.c b/migration/block.c
> index 7734ff7..072fc20 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -276,6 +276,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>      if (bmds->shared_base) {
>          qemu_mutex_lock_iothread();
>          aio_context_acquire(blk_get_aio_context(bb));
> +        qemu_mutex_unlock_iothread();
>          /* Skip unallocated sectors; intentionally treats failure as
>           * an allocated sector */
>          while (cur_sector < total_sectors &&
> @@ -283,6 +284,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>                                    MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>              cur_sector += nr_sectors;
>          }
> +        qemu_mutex_lock_iothread();
>          aio_context_release(blk_get_aio_context(bb));
>          qemu_mutex_unlock_iothread();
>      }
>

this patch don't work. the qemu lockup.
the stack of main thread.
(gdb) bt
#0  0x00007f4256c89264 in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007f4256c84523 in _L_lock_892 () from /lib64/libpthread.so.0
#2  0x00007f4256c84407 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000000000949f47 in qemu_mutex_lock (mutex=0x1b04a60) at
util/qemu-thread-posix.c:60
#4  0x00000000009424cf in aio_context_acquire (ctx=0x1b04a00) at
util/async.c:484
#5  0x0000000000942b86 in thread_pool_completion_bh (opaque=0x1b25a10)
at util/thread-pool.c:168
#6  0x0000000000941610 in aio_bh_call (bh=0x1b1d570) at util/async.c:90
#7  0x00000000009416bb in aio_bh_poll (ctx=0x1b04a00) at util/async.c:118
#8  0x0000000000946baa in aio_dispatch (ctx=0x1b04a00) at util/aio-posix.c:429
#9  0x0000000000941b30 in aio_ctx_dispatch (source=0x1b04a00,
callback=0, user_data=0x0)
    at util/async.c:261
#10 0x00007f4257670f0e in g_main_context_dispatch () from
/lib64/libglib-2.0.so.0
#11 0x0000000000945282 in glib_pollfds_poll () at util/main-loop.c:213
#12 0x00000000009453a3 in os_host_main_loop_wait (timeout=754229747)
at util/main-loop.c:261
#13 0x000000000094546e in main_loop_wait (nonblocking=0) at util/main-loop.c:517
#14 0x00000000005c7664 in main_loop () at vl.c:1898
#15 0x00000000005ceb27 in main (argc=49, argv=0x7fff7907ab28,
envp=0x7fff7907acb8) at vl.c:4709

the stack of migration thread.
(gdb) bt
#0  0x00007f4256c89264 in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007f4256c84508 in _L_lock_854 () from /lib64/libpthread.so.0
#2  0x00007f4256c843d7 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000000000949f47 in qemu_mutex_lock (mutex=0xfc5200) at
util/qemu-thread-posix.c:60
#4  0x0000000000459e08 in qemu_mutex_lock_iothread () at /root/qemu/cpus.c:1516
#5  0x00000000007d2e04 in mig_save_device_bulk (f=0x2489720,
bmds=0x7f42500008f0)
    at migration/block.c:287
#6  0x00000000007d3579 in blk_mig_save_bulked_block (f=0x2489720) at
migration/block.c:484
#7  0x00000000007d3ebf in block_save_iterate (f=0x2489720,
opaque=0xfd3e20) at migration/block.c:773
#8  0x000000000049e840 in qemu_savevm_state_iterate (f=0x2489720,
postcopy=false)
    at /root/qemu/migration/savevm.c:1044
#9  0x00000000007c635d in migration_thread (opaque=0xf7d160) at
migration/migration.c:1976
#10 0x00007f4256c829d1 in start_thread () from /lib64/libpthread.so.0
#11 0x00007f42569cf8fd in clone () from /lib64/libc.so.6

vcpu thread.
(gdb) bt
#0  0x00007f4256c89264 in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007f4256c84508 in _L_lock_854 () from /lib64/libpthread.so.0
#2  0x00007f4256c843d7 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000000000949f47 in qemu_mutex_lock (mutex=0xfc5200) at
util/qemu-thread-posix.c:60
#4  0x0000000000459e08 in qemu_mutex_lock_iothread () at /root/qemu/cpus.c:1516
#5  0x00000000004146bb in prepare_mmio_access (mr=0x39010f0) at
/root/qemu/exec.c:2703
#6  0x0000000000414ad3 in address_space_read_continue (as=0xf9c520,
addr=1018, attrs=..., buf=
    0x7f4259464000 "%\001", len=1, addr1=2, l=1, mr=0x39010f0) at
/root/qemu/exec.c:2827
#7  0x0000000000414d81 in address_space_read_full (as=0xf9c520,
addr=1018, attrs=..., buf=
    0x7f4259464000 "%\001", len=1) at /root/qemu/exec.c:2895
#8  0x0000000000414e4b in address_space_read (as=0xf9c520, addr=1018,
attrs=..., buf=
    0x7f4259464000 "%\001", len=1, is_write=false) at
/root/qemu/include/exec/memory.h:1671
#9  address_space_rw (as=0xf9c520, addr=1018, attrs=...,
buf=0x7f4259464000 "%\001", len=1, is_write=
    false) at /root/qemu/exec.c:2909
#10 0x00000000004753c9 in kvm_handle_io (port=1018, attrs=...,
data=0x7f4259464000, direction=0, size=
    1, count=1) at /root/qemu/kvm-all.c:1803
#11 0x0000000000475c15 in kvm_cpu_exec (cpu=0x1b827b0) at
/root/qemu/kvm-all.c:2032
#12 0x00000000004591c8 in qemu_kvm_cpu_thread_fn (arg=0x1b827b0) at
/root/qemu/cpus.c:1087
#13 0x00007f4256c829d1 in start_thread () from /lib64/libpthread.so.0
#14 0x00007f42569cf8fd in clone () from /lib64/libc.so.6

the main thread hold qemu_mutex_lock_iothread first, and then
aio_context_acquire.
the migration thread hold aio_context_acquire first, then
qemu_mutex_lock_iothread.
