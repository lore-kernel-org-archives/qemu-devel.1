Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSqcl-00083E-UL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSqci-0007Ns-PF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:10:11 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSqci-0007LZ-Es
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 16:10:08 -0400
Received: by mail-wr0-x229.google.com with SMTP id k67so269522833wrc.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 13:10:08 -0700 (PDT)
References: <8737aaeuu5.fsf@linaro.org>
	<CAFEAcA8ZHz4vyBrHV6Vi7227h+_NafgV1oBY0g9sV7zU_8my0w@mail.gmail.com>
	<87van6adhi.fsf@linaro.org>
	<CAFEAcA_DcOMzo=X1Y9O+5VrfeA32i012vpQmqB++aEXH6J1qeg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_DcOMzo=X1Y9O+5VrfeA32i012vpQmqB++aEXH6J1qeg@mail.gmail.com>
Date: Wed, 05 Jul 2017 21:10:05 +0100
Message-ID: <87shiaabmq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu_system_reset_request() broken w.r.t BQL
 locking regime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, maciej.borzecki@rndity.com


Peter Maydell <peter.maydell@linaro.org> writes:

> On 5 July 2017 at 20:30, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 5 July 2017 at 17:01, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>> An interesting bug was reported on #qemu today. It was bisected to
>>>> 8d04fb55 (drop global lock for TCG) and only occurred when QEMU was run
>>>> with taskset -c 0. Originally the fingers where pointed at mttcg but it
>>>> occurs in both single and multi-threaded modes.
>>>>
>>>> I think the problem is qemu_system_reset_request() is certainly racy
>>>> when resetting a running CPU. AFAICT:
>>>>
>>>>   - Guest resets board, writing to some hw address (e.g.
>>>>     arm_sysctl_write)
>>>>   - This triggers qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET)
>>>>   - We exit iowrite and drop the BQL
>>>>   - vl.c schedules qemu_system_reset->qemu_devices_reset...arm_cpu_reset
>>>>   - we start writing new values to CPU env while still in TCG code
>>>>   - CHAOS!
>>>>
>>>> The general solution for this is to ensure these sort of tasks are done
>>>> with safe work in the CPUs context when we know nothing else is running.
>>>> It seems this is probably best done by modifying
>>>> qemu_system_reset_request to queue work up on current_cpu and execute it
>>>> as safe work - I don't think the vl.c thread should ever be messing
>>>> about with calling cpu_reset directly.
>>>
>>> My first thought is that qemu_system_reset() should absolutely
>>> stop every CPU (or other runnable thing like a DMA agent) in the
>>> system.
>>
>> Are all these reset calls system wide though?
>
> It's called 'system_reset' because it resets the entire system...
>
>> After all with PCSI you
>> can bring individual cores up and down. I appreciate the vexpress stuff
>> pre-dates those well defined semantics though.
>
> It's individual core reset that's a more ad-hoc afterthought,
> really.
>
>> vm_stop certainly tries to deal with things gracefully as well as send
>> qapi events, drain IO queues and the rest of it. My only concern is it
>> handles two cases - external vm_stops and those from the current CPU.
>>
>> I think it may be cleaner for CPU originated halts to use the
>> async_safe_run_on_cpu() mechanism.
>
> System reset already has an async component to it -- you call
> qemu_system_reset_request(), which just says "schedule a system
> reset as soon as convenient". qemu_system_reset() is the thing
> that runs later and actually does the job (from the io thread,
> not the CPU thread).
>
> Looking more closely at the vl.c code, it looks like it
> calls pause_all_vcpus() before calling qemu_system_reset():
> shouldn't that be pausing all the TCG CPUs?

Hmm it should - but it doesn't seem to have in this backtrace:

#0  0x000055555593fdd3 in arm_cpu_reset (s=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/target/arm/cpu.c:119
#1  0x0000555555bcc74a in cpu_reset (cpu=0x5555569abb90) at qom/cpu.c:268
#2  0x000055555589d82a in do_cpu_reset (opaque=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/hw/arm/boot.c:570
#3  0x0000555555a257e4 in qemu_devices_reset () at hw/core/reset.c:69
#4  0x00005555559697a8 in qemu_system_reset (reason=SHUTDOWN_CAUSE_GUEST_RESET) at vl.c:1713
#5  0x0000555555969c0d in main_loop_should_exit () at vl.c:1885
#6  0x0000555555969cda in main_loop () at vl.c:1922
#7  0x0000555555971aca in main (argc=16, argv=0x7fffffffd918, envp=0x7fffffffd9a0) at vl.c:4749

Thread 4 (Thread 0x7fff731ff700 (LWP 10098)):
#0  0x00007fffdf4f5a15 in do_futex_wait (private=0, abstime=0x7fff731fc670, expected=0, futex_word=0x7fff64cbb5b8) at ../sysdeps/unix/sysv/linux/futex-internal.h:205
#1  0x00007fffdf4f5a15 in do_futex_wait (sem=sem@entry=0x7fff64cbb5b8, abstime=abstime@entry=0x7fff731fc670) at sem_waitcommon.c:111
#2  0x00007fffdf4f5adf in __new_sem_wait_slow (sem=0x7fff64cbb5b8, abstime=0x7fff731fc670) at sem_waitcommon.c:181
#3  0x00007fffdf4f5b92 in sem_timedwait (sem=<optimised out>, abstime=<optimised out>) at sem_timedwait.c:36
#4  0x0000555555d27488 in qemu_sem_timedwait (sem=0x7fff64cbb5b8, ms=10000) at util/qemu-thread-posix.c:271
#5  0x0000555555d20aad in worker_thread (opaque=0x7fff64cbb550) at util/thread-pool.c:92
#6  0x00007fffdf4ed6ba in start_thread (arg=0x7fff731ff700) at pthread_create.c:333
#7  0x00007fffdf2233dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 3 (Thread 0x7fff7ebff700 (LWP 10097)):
#0  0x00007fffdf4f630a in __lll_unlock_wake () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:371
#1  0x00007fffdf4f14ff in __GI___pthread_mutex_unlock (decr=1, mutex=0x55555641ae20 <qemu_global_mutex>) at pthread_mutex_unlock.c:55
#2  0x00007fffdf4f14ff in __GI___pthread_mutex_unlock (mutex=0x55555641ae20 <qemu_global_mutex>) at pthread_mutex_unlock.c:314
#3  0x0000555555d27091 in qemu_mutex_unlock (mutex=0x55555641ae20 <qemu_global_mutex>) at util/qemu-thread-posix.c:88
#4  0x00005555557aa911 in qemu_mutex_unlock_iothread () at /home/alex/lsrc/qemu/qemu.git/cpus.c:1589
#5  0x00005555557d791a in io_writex (env=0x5555569b3e20, iotlbentry=0x5555569c61d0, val=3230662656, addr=268435620, retaddr=140736397128697, size=4) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cputlb.c:800
#6  0x00005555557daabd in io_writel (env=0x5555569b3e20, mmu_idx=3, index=0, val=3230662656, addr=268435620, retaddr=140736397128697) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:265
#7  0x00005555557dadab in helper_le_stl_mmu (env=0x5555569b3e20, addr=268435620, val=3230662656, oi=35, retaddr=140736397128697) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:300
#8  0x00007fffbef533f9 in code_gen_buffer ()
#9  0x00005555557e3c46 in cpu_tb_exec (cpu=0x5555569abb90, itb=0x7fffbef53280 <code_gen_buffer+1327702>) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cpu-exec.c:166
#10 0x00005555557e4976 in cpu_loop_exec_tb (cpu=0x5555569abb90, tb=0x7fffbef53280 <code_gen_buffer+1327702>, last_tb=0x7fff7ebfc638, tb_exit=0x7fff7ebfc634) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cpu-exec.c:574
#11 0x00005555557e4c74 in cpu_exec (cpu=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cpu-exec.c:673
#12 0x00005555557aa132 in tcg_cpu_exec (cpu=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1270
#13 0x00005555557aa359 in qemu_tcg_rr_cpu_thread_fn (arg=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1365
#14 0x00007fffdf4ed6ba in start_thread (arg=0x7fff7ebff700) at pthread_create.c:333
#15 0x00007fffdf2233dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 2 (Thread 0x7fffcf610700 (LWP 10095)):
#0  0x00007fffdf21d499 in syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x0000555555d275d8 in qemu_futex_wait (f=0x5555568528c0 <rcu_gp_event>, val=4294967295) at /home/alex/lsrc/qemu/qemu.git/include/qemu/futex.h:26
#2  0x0000555555d276e3 in qemu_event_wait (ev=0x5555568528c0 <rcu_gp_event>) at util/qemu-thread-posix.c:415
#3  0x0000555555d3ea6c in wait_for_readers () at util/rcu.c:131
#4  0x0000555555d3eb25 in synchronize_rcu () at util/rcu.c:162
#5  0x0000555555d3ecb4 in call_rcu_thread (opaque=0x0) at util/rcu.c:256
#6  0x00007fffdf4ed6ba in start_thread (arg=0x7fffcf610700) at pthread_create.c:333
#7  0x00007fffdf2233dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 1 (Thread 0x7ffff7edff80 (LWP 10091)):
#0  0x000055555593fdd3 in arm_cpu_reset (s=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/target/arm/cpu.c:119
#1  0x0000555555bcc74a in cpu_reset (cpu=0x5555569abb90) at qom/cpu.c:268
#2  0x000055555589d82a in do_cpu_reset (opaque=0x5555569abb90) at /home/alex/lsrc/qemu/qemu.git/hw/arm/boot.c:570
#3  0x0000555555a257e4 in qemu_devices_reset () at hw/core/reset.c:69
#4  0x00005555559697a8 in qemu_system_reset (reason=SHUTDOWN_CAUSE_GUEST_RESET) at vl.c:1713
#5  0x0000555555969c0d in main_loop_should_exit () at vl.c:1885
#6  0x0000555555969cda in main_loop () at vl.c:1922
#7  0x0000555555971aca in main (argc=16, argv=0x7fffffffd918, envp=0x7fffffffd9a0) at vl.c:4749


>
> thanks
> -- PMM


--
Alex Bennée
