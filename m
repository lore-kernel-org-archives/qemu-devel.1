Received: from eggs.gnu.org ([2001:4830:134:3::10]:41522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eMI4F-0005sb-MT
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eMI4C-0008DR-Hn
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:35:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:54345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eMI4C-0008Aw-4o
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:35:40 -0500
Date: Tue, 5 Dec 2017 19:35:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20171205135447.GA29422@stefanha-x1.localdomain>
Message-ID: <alpine.BSF.2.21.1712051856040.96903@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1712041954200.69360@zero.eik.bme.hu>
	<20171205135447.GA29422@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Debugging io deadlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 5 Dec 2017, Stefan Hajnoczi wrote:
> On Mon, Dec 04, 2017 at 08:22:48PM +0100, BALATON Zoltan wrote:
>> I'm seeing a possible deadlock that I don't know how to debug. Any hint on
>> how to find the cause or what should be checked further to identify the
>> reason why this is happening and how to fix it is greatly appreciated.
>>
>> Here are the state of threads:
>>
>> (gdb) info thr
>>   Id   Target Id         Frame
>> * 4    Thread 0x7fffba76c700 (LWP 3445) "qemu-system-ppc" 0x0000555555cbec04 in worker_thread (opaque=0x7fffe40c9000) at util/thread-pool.c:92
>>   3    Thread 0x7fffe8829700 (LWP 3443) "qemu-system-ppc" 0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
>>   2    Thread 0x7ffff111b700 (LWP 3442) "qemu-system-ppc" 0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
>>   1    Thread 0x7ffff7fc7b00 (LWP 3441) "qemu-system-ppc" 0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
>> (gdb) bt
>> #0  0x00007ffff78d4830 in sem_timedwait () from /lib64/libpthread.so.0
>> #1  0x0000555555cc572e in qemu_sem_timedwait (sem=0x7fffe40c9078, ms=10000) at util/qemu-thread-posix.c:289
>> #2  0x0000555555cbec04 in worker_thread (opaque=0x7fffe40c9000) at util/thread-pool.c:92
>> #3  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
>> #4  0x00007ffff42d062d in clone () from /lib64/libc.so.6
>> (gdb) thr 3
>> [Switching to thread 3 (Thread 0x7fffe8829700 (LWP 3443))]
>> #0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
>> (gdb) bt
>> #0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
>> #1  0x0000555555cc5458 in qemu_cond_wait (cond=0x555556b47b90, mutex=0x5555565b5220 <qemu_global_mutex>) at util/qemu-thread-posix.c:161
>> #2  0x00005555557e6690 in qemu_tcg_wait_io_event (cpu=0x7ffff7e20010) at cpus.c:1084
>> #3  0x00005555557e6f00 in qemu_tcg_rr_cpu_thread_fn (arg=0x7ffff7e20010) at cpus.c:1396
>> #4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
>> #5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
>> (gdb) thr 2
>> [Switching to thread 2 (Thread 0x7ffff111b700 (LWP 3442))]
>> #0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
>> (gdb) bt
>> #0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
>> #1  0x0000555555cc58a7 in qemu_futex_wait (f=0x555556a01134 <rcu_call_ready_event>, val=4294967295) at include/qemu/futex.h:29
>> #2  0x0000555555cc5a74 in qemu_event_wait (ev=0x555556a01134 <rcu_call_ready_event>) at util/qemu-thread-posix.c:442
>> #3  0x0000555555cdd92c in call_rcu_thread (opaque=0x0) at util/rcu.c:249
>> #4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
>> #5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
>> (gdb) thr 1
>> [Switching to thread 1 (Thread 0x7ffff7fc7b00 (LWP 3441))]
>> #0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
>> (gdb) bt
>> #0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
>> #1  0x0000555555cbfe86 in qemu_poll_ns (fds=0x555557c17620, nfds=5, timeout=29806320) at util/qemu-timer.c:334
>> #2  0x0000555555cc0eab in os_host_main_loop_wait (timeout=29806320) at util/main-loop.c:255
>> #3  0x0000555555cc0f7d in main_loop_wait (nonblocking=0) at util/main-loop.c:515
>> #4  0x000055555599e2b3 in main_loop () at vl.c:1995
>> #5  0x00005555559a6353 in main (argc=21, argv=0x7fffffffdef8, envp=0x7fffffffdfa8) at vl.c:4911
>>
>> Then if I wait a little, thread 4 exits due to sem_timedwait returning -1
>> with errno=ETIMEDOUT leaving other threads waiting for something to happen
>> but this is apparently a deadlock as it will be stuck here (thread 1-3 are
>> still as above). Any idea why this could happen and how to debug it furhter?
>
> Are you using the latest qemu.git/master?

Yes I'm on git master. Even 044897ef4 "target/ppc: Fix system lockups 
caused by interrupt_request state corruption" does not help which looked 
like it may be related but the hang happens with this as well the same 
way.

> Commit ef6dada8b44e1e7c4bec5c1115903af9af415b50 ("util/async: use
> atomic_mb_set in qemu_bh_cancel") fixes hangs that occur with the thread
> pool (Thread 4 in your example).  I'm not sure if this applies to your
> hang though...
>
> It looks like Thread 3 isn't running guest code because the cpu wants to
> sleep (is it halted?).

Looks like it's halted waiting for something (maybe io but I see no other 
thread that could wake this so I'm not sure what's happening):

#2  0x00005555557e66c0 in qemu_tcg_wait_io_event (cpu=0x7ffff7e20010) at cpus.c:1084
1084	        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
(gdb) p *cpu
$4 = {parent_obj = {parent_obj = {class = 0x555556a954f0, free = 0x7ffff500c6e0 <g_free>, properties = 0x555556b1a860, ref = 2,
   parent = 0x555556b19f00}, id = 0x0, canonical_path = 0x555556b48e40 "/machine/unattached/device[0]", realized = true,
   pending_deleted_event = false, opts = 0x0, hotplugged = 0, parent_bus = 0x0, gpios = {lh_first = 0x0}, child_bus = {
   lh_first = 0x0}, num_child_bus = 0, instance_id_alias = -1, alias_required_for_version = 0}, nr_cores = 1, nr_threads = 1,
   thread = 0x555556b48b70, thread_id = 3554, running = false, has_waiter = false, halt_cond = 0x555556b48b90,
   thread_kicked = false, created = true, stop = false, stopped = false, unplug = false, crash_occurred = false,
   exit_request = false, cflags_next_tb = 4294967295, interrupt_request = 4, singlestep_enabled = 0, icount_budget = 0,
   icount_extra = 0, jmp_env = {{__jmpbuf = {140737094260480, -3807285253765841529, 140737488344321, 4096, 140737094260480, 0,
   -3807285253770035833, -7026543154144068217}, __mask_was_saved = 0, __saved_mask = {__val = {0 <repeats 16 times>}}}},
   work_mutex = {lock = {__data = {__lock = 0, __count = 0, __owner = 0, __nusers = 0, __kind = 0, __spins = 0, __elision = 0,
   __list = {__prev = 0x0, __next = 0x0}}, __size = '\000' <repeats 39 times>, __align = 0}, initialized = true},
   queued_work_first = 0x0, queued_work_last = 0x0, cpu_ases = 0x555556b48ab0, num_ases = 1, as = 0x555556b48a30,
   memory = 0x555556b19b70, env_ptr = 0x7ffff7e282b0, tb_jmp_cache = 8< trimmed for brevity >8, gdb_regs = 0x555556b48a00,
   gdb_num_regs = 104, gdb_num_g_regs = 71, node = {tqe_next = 0x0, tqe_prev = 0x555556450020 <cpus>}, breakpoints = {
   tqh_first = 0x0, tqh_last = 0x7ffff7e28220}, watchpoints = {tqh_first = 0x0, tqh_last = 0x7ffff7e28230}, watchpoint_hit = 0x0,
   opaque = 0x0, mem_io_pc = 140737109809995, mem_io_vaddr = 3774989057, kvm_fd = 0, kvm_state = 0x0, kvm_run = 0x0,
   trace_dstate_delayed = {0}, trace_dstate = {0}, cpu_index = 0, halted = 1, can_do_io = 1, exception_index = -1,
   vcpu_dirty = false, throttle_thread_scheduled = false, ignore_memory_transaction_failures = false, icount_decr = {
   u32 = 4294964112, u16 = {low = 62352, high = 65535}}, hax_vcpu = 0x0, pending_tlb_flush = 0}
(gdb) p *cpu->halt_cond
$5 = {cond = {__data = {__lock = 0, __futex = 205, __total_seq = 103, __wakeup_seq = 102, __woken_seq = 102,
   __mutex = 0x5555565b6260 <qemu_global_mutex>, __nwaiters = 2, __broadcast_seq = 102},
   __size = "\000\000\000\000\315\000\000\000g\000\000\000\000\000\000\000f\000\000\000\000\000\000\000f\000\000\000\000\000\000\000`b[VUU\000\000\002\000\000\000f\000\000",
   __align = 880468295680}, initialized = true}

If I enable PPC_DEBUG_IRQ in hw/ppc/ppc.c I see some IRQs (such as 
decrementer and external when keys are pressed) are still raised and 
lowered while it appears to hang but somehow it's not progressing and the 
CPU sits waiting. So maybe it's running but waiting for some event that 
does not happen on QEMU like it does on real HW? I don't really know what 
to look for so if anyone has any more ideas then please share.

Thank you,
BALATON Zoltan
