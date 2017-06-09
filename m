Received: from eggs.gnu.org ([2001:4830:134:3::10]:52153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJHY5-0005ah-1k
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJHY1-0004rc-UY
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:53:49 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dJHY1-0004n3-Kl
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:53:45 -0400
Received: by mail-wr0-x22d.google.com with SMTP id q97so28856757wrb.2
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 03:53:43 -0700 (PDT)
References: <20170609094812.GA2201@toto>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170609094812.GA2201@toto>
Date: Fri, 09 Jun 2017 11:54:09 +0100
Message-ID: <87zidhbfe6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] AArch64 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, fred.konrad@greensocs.com


Edgar E. Iglesias <edgar.iglesias@gmail.com> writes:

> Hi,
>
> I was running a bunch of tests in preparation for the MMIO/exec
> series but am running into regressions on master.
> I'm at commit 64175afc695c0672876fbbfc31b299c86d562cb4
>
> On the xlnx-zcu102 I see lockups, the console goes unresponsive.
> On one of my vexpress-a15 setups (with an a57), I see weird
> segfaults in user-space.
>
> I bisected this multiple times with each of the test cases
> and all of the bisects bring me to this commit:
> commit e75449a346bf558296966a44277bfd93412c6da6
> Author: Emilio G. Cota <cota@braap.org>
> Date:   Fri Apr 28 14:59:23 2017 -0400
>
>     target/aarch64: optimize indirect branches
>
>
> Does this ring any bells? Are there any known issues at the moment?
> I've copied a GDB backtrace form the ZynqMP lockup at the end
> of this email.

Yes - see the PULL req thread when this got merged:

  Message-ID: <87h8zrdh02.fsf@linaro.org>

I'm currently trying to narrow it down. It's tricky as the problem goes
away when I add fprintfs but it affects both single and multi-thread
modes so I don't think its a race.

It seems to only affect TB's looked up in lookup_tb_ptr via the htable
which is odd.

>
> Thanks,
> Edgar
>
> GDB backtrace:
> (gdb) thread apply all bt
>
> Thread 6 (Thread 0x7fff431fc700 (LWP 28586)):
> #0  0x00007ffff5e2826d in __lll_lock_wait ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x00007ffff5e21dbd in pthread_mutex_lock ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #2  0x0000555555b5cc40 in qemu_mutex_lock (
>     mutex=mutex@entry=0x55555620be80 <qemu_global_mutex>)
>     at /home/edgar/src/c/qemu/qemu/util/qemu-thread-posix.c:61
> #3  0x00005555557bc9cc in qemu_mutex_lock_iothread ()
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1581
> #4  0x000055555578e865 in cpu_handle_interrupt (last_tb=<synthetic pointer>,
>     cpu=0x5555566c40b0) at /home/edgar/src/c/qemu/qemu/cpu-exec.c:491
> #5  cpu_exec (cpu=cpu@entry=0x7fffc543f4f8)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:670
> #6  0x00005555557bcb9f in tcg_cpu_exec (cpu=0x7fffc543f4f8)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1270
> #7  qemu_tcg_cpu_thread_fn (arg=0x7fffc543f4f8)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1473
> #8  0x00007ffff5e1f6ba in start_thread ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #9  0x00007ffff5b5582d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Thread 5 (Thread 0x7fff439fd700 (LWP 28585)):
> #0  0x00007ffff5e2826d in __lll_lock_wait ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x00007ffff5e21dbd in pthread_mutex_lock ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #2  0x0000555555b5cc40 in qemu_mutex_lock (
>     mutex=mutex@entry=0x55555620be80 <qemu_global_mutex>)
>     at /home/edgar/src/c/qemu/qemu/util/qemu-thread-posix.c:61
> #3  0x00005555557bc9cc in qemu_mutex_lock_iothread ()
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1581
> #4  0x000055555578e865 in cpu_handle_interrupt (last_tb=<synthetic pointer>,
>     cpu=0x5555566c40b0) at /home/edgar/src/c/qemu/qemu/cpu-exec.c:491
> #5  cpu_exec (cpu=cpu@entry=0x7fffc54208d0)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:670
> #6  0x00005555557bcb9f in tcg_cpu_exec (cpu=0x7fffc54208d0)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1270
> #7  qemu_tcg_cpu_thread_fn (arg=0x7fffc54208d0)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1473
> #8  0x00007ffff5e1f6ba in start_thread ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #9  0x00007ffff5b5582d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Thread 4 (Thread 0x7fff441fe700 (LWP 28584)):
> #0  0x00007ffff5e21dac in pthread_mutex_lock ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x0000555555b5cc40 in qemu_mutex_lock (
>     mutex=mutex@entry=0x55555620be80 <qemu_global_mutex>)
>     at /home/edgar/src/c/qemu/qemu/util/qemu-thread-posix.c:61
> #2  0x00005555557bc9cc in qemu_mutex_lock_iothread ()
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1581
> #3  0x000055555578e865 in cpu_handle_interrupt (last_tb=<synthetic pointer>,
>     cpu=0x5555566c40b0) at /home/edgar/src/c/qemu/qemu/cpu-exec.c:491
> #4  cpu_exec (cpu=cpu@entry=0x7fffc5401ca8)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:670
> #5  0x00005555557bcb9f in tcg_cpu_exec (cpu=0x7fffc5401ca8)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1270
> #6  qemu_tcg_cpu_thread_fn (arg=0x7fffc5401ca8)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1473
> #7  0x00007ffff5e1f6ba in start_thread ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #8  0x00007ffff5b5582d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Thread 3 (Thread 0x7fff449ff700 (LWP 28583)):
> #0  0x00005555558c4c89 in regime_el (mmu_idx=ARMMMUIdx_S1NSE1,
>     env=0x7fffc53eb310) at /home/edgar/src/c/qemu/qemu/target/arm/helper.c:7028
> #1  regime_tcr (mmu_idx=<optimized out>, env=0x7fffc53eb310)
>     at /home/edgar/src/c/qemu/qemu/target/arm/helper.c:7117
> #2  arm_regime_tbi0 (env=env@entry=0x7fffc53eb310, mmu_idx=<optimized out>,
>     mmu_idx@entry=ARMMMUIdx_S12NSE1)
>     at /home/edgar/src/c/qemu/qemu/target/arm/helper.c:7142
> #3  0x00005555557ba346 in cpu_get_tb_cpu_state (flags=<synthetic pointer>,
>     cs_base=<synthetic pointer>, pc=<synthetic pointer>, env=0x7fffc53eb310)
>     at /home/edgar/src/c/qemu/qemu/target/arm/cpu.h:2571
> #4  helper_lookup_tb_ptr (env=0x7fffc53eb310, addr=18446743524088820436)
>     at /home/edgar/src/c/qemu/qemu/tcg-runtime.c:156
> #5  0x00007fffcf2f7e53 in code_gen_buffer ()
> #6  0x000055555578de7c in cpu_tb_exec (itb=<optimized out>,
>     itb=<optimized out>, cpu=0x7fffc5727478)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:166
> #7  cpu_loop_exec_tb (tb_exit=<synthetic pointer>,
>     last_tb=<synthetic pointer>, tb=<optimized out>, cpu=0x7fffc5727478)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:574
> #8  cpu_exec (cpu=cpu@entry=0x7fffc53e3080)
>     at /home/edgar/src/c/qemu/qemu/cpu-exec.c:672
> #9  0x00005555557bcb9f in tcg_cpu_exec (cpu=0x7fffc53e3080)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1270
> #10 qemu_tcg_cpu_thread_fn (arg=0x7fffc53e3080)
>     at /home/edgar/src/c/qemu/qemu/cpus.c:1473
> #11 0x00007ffff5e1f6ba in start_thread ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #12 0x00007ffff5b5582d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Thread 2 (Thread 0x7fffef7b7700 (LWP 28582)):
> #0  0x00007ffff5b4f8e9 in syscall () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x0000555555b5d385 in qemu_futex_wait (val=<optimized out>,
>     f=<optimized out>) at /home/edgar/src/c/qemu/qemu/include/qemu/futex.h:26
> #2  qemu_event_wait (ev=ev@entry=0x55555661bae4 <rcu_call_ready_event>)
>     at /home/edgar/src/c/qemu/qemu/util/qemu-thread-posix.c:415
> #3  0x0000555555b6cc6e in call_rcu_thread (opaque=<optimized out>)
>     at /home/edgar/src/c/qemu/qemu/util/rcu.c:249
> #4  0x00007ffff5e1f6ba in start_thread ()
>    from /lib/x86_64-linux-gnu/libpthread.so.0
> #5  0x00007ffff5b5582d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>
> Thread 1 (Thread 0x7ffff7f31c00 (LWP 28578)):
> #0  0x00007ffff5b49c21 in ppoll () from /lib/x86_64-linux-gnu/libc.so.6
> #1  0x0000555555b58f39 in ppoll (__ss=0x0, __timeout=0x7fffffffd5f0,
>     __nfds=<optimized out>, __fds=<optimized out>)
>     at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
> #2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>,
>     timeout=timeout@entry=9223371867734611302)
>     at /home/edgar/src/c/qemu/qemu/util/qemu-timer.c:334
> #3  0x0000555555b59d6a in os_host_main_loop_wait (timeout=9223371867734611302)
>     at /home/edgar/src/c/qemu/qemu/util/main-loop.c:255
> #4  main_loop_wait (nonblocking=<optimized out>)
>     at /home/edgar/src/c/qemu/qemu/util/main-loop.c:517
> #5  0x0000555555779057 in main_loop () at /home/edgar/src/c/qemu/qemu/vl.c:1918
> #6  main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
>     at /home/edgar/src/c/qemu/qemu/vl.c:4752
> (gdb)


--
Alex Bennée
