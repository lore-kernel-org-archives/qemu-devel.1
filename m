Received: from eggs.gnu.org ([2001:4830:134:3::10]:33231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj3Zx-0005MU-7e
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cj3Zu-0006PW-3U
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:42:01 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cj3Zt-0006PI-PS
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:41:58 -0500
Received: by mail-wr0-x236.google.com with SMTP id u48so29313134wrc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 04:41:57 -0800 (PST)
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
Date: Wed, 01 Mar 2017 12:41:56 +0000
Message-ID: <874lzd2mp7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 01/03/17 11:36, Alex Bennée wrote:
>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> I got a make check failure on aarch64 host running a sparc64 test:
>>>
>>>
>>> TEST: tests/prom-env-test... (pid=13573)
>>>   /sparc64/prom-env/sun4u:                                             **
>>> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
>>> assertion failed: (qemu_mutex_iothread_locked())
>>
>> So the assertions where added with MTTCG. The design specifies which
>> bits should be protected by the BQL and cpu->interrupt_request is one of
>> them. This is because cpu->interrupt_request is often a cross-vCPU
>> action (one vCPU triggering an interrupt on another) so there is a
>> chance of racing if not protected.
>>
>> It's odd this is showing up on a aarch64 host though when it didn't hit
>> on my x86_64 host while testing.
>>
>> As most of this stuff is triggered by hardware emulation the BQL should
>> be in effect when handling MMIO for device emulation. There where other
>> entry points in ARM which could trigger stuff which is why we add
>> locking for things like ARM_CP_IO which are co-processor register
>> accesses which trigger other things in the system.
>>
>> What will be useful for all these reports is the backtrace. Then it's
>> fairly simple to identify the thing triggering the interrupt and
>> identify the correct place for the locking.
>
> Hi Alex,
>
> Here's the backtrace from my test case of qemu-system-sparc running on
> an x86_64 host that I posted yesterday:
>
>
> $ gdb --args ./qemu-system-sparc -cdrom
> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso -boot d
> GNU gdb (GDB) 7.4.1-debian
> Copyright (C) 2012 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>...
> Reading symbols from /home/build/rel-qemu-git/bin/qemu-system-sparc...done.
> (gdb) r
> Starting program: /home/build/rel-qemu-git/bin/qemu-system-sparc -cdrom
> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso -boot d
> warning: no loadable sections found in added symbol-file system-supplied
> DSO at 0x7ffff7ffa000
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> [New Thread 0x7fffe9eee700 (LWP 18040)]
> [New Thread 0x7fffe66d6700 (LWP 18041)]
> [New Thread 0x7fffe5ed5700 (LWP 18042)]
> qemu-system-sparc: -cdrom
> /home/build/src/qemu/image/sparc32/debian-40r4a-sparc-netinst.iso:
> warning: bus=0,unit=2 is deprecated with this machine type
> [Thread 0x7fffe66d6700 (LWP 18041) exited]
> [New Thread 0x7fffe66d6700 (LWP 18043)]
> **
> ERROR:/home/build/src/qemu/git/qemu/translate-common.c:34:tcg_handle_interrupt:
> assertion failed: (qemu_mutex_iothread_locked())
>
> Program received signal SIGABRT, Aborted.
> [Switching to Thread 0x7fffe5ed5700 (LWP 18042)]
> 0x00007ffff2939125 in *__GI_raise (sig=<optimized out>) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>
>
>
> 64      ../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) thread apply all bt
>
> Thread 5 (Thread 0x7fffe66d6700 (LWP 18043)):
> #0  sem_timedwait () at
> ../nptl/sysdeps/unix/sysv/linux/x86_64/sem_timedwait.S:106
> #1  0x000055555591435c in qemu_sem_timedwait (sem=0x5555561ad408,
> ms=10000) at util/qemu-thread-posix.c:255
> #2  0x000055555590cb51 in worker_thread (opaque=0x5555561ad3a0) at
> util/thread-pool.c:92
> #3  0x00007ffff2c9ab50 in start_thread (arg=<optimized out>) at
> pthread_create.c:304
> #4  0x00007ffff29e4fbd in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> #5  0x0000000000000000 in ?? ()
>
> Thread 4 (Thread 0x7fffe5ed5700 (LWP 18042)):
> #0  0x00007ffff2939125 in *__GI_raise (sig=<optimized out>) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
> #1  0x00007ffff293c3a0 in *__GI_abort () at abort.c:92
> #2  0x00007ffff407e477 in g_assertion_message () from
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #3  0x00007ffff407e994 in g_assertion_message_expr () from
> /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #4  0x000055555561b54f in tcg_handle_interrupt (cpu=0x5555561b3af0,
> mask=2) at /home/build/src/qemu/git/qemu/translate-common.c:34
> #5  0x00005555556a8e7d in cpu_interrupt (cpu=0x5555561b3af0, mask=2) at
> /home/build/src/qemu/git/qemu/include/qom/cpu.h:801
> #6  0x00005555556a95ec in cpu_check_irqs (env=0x5555561bbd80) at
> /home/build/src/qemu/git/qemu/hw/sparc/sun4m.c:157

Am I correct assuming all the helper functions themselves are concerned
with the vCPU environment they are running in? If so it looking like
cpu_check_irqs() would be the place to wrap the BQL lock in.

I'll make the change and test against your test case.

> #7  0x00005555556be063 in cpu_put_psr (env=0x5555561bbd80, val=76554214)
> at /home/build/src/qemu/git/qemu/target/sparc/win_helper.c:89
> #8  0x00005555556be3bd in helper_wrpsr (env=0x5555561bbd80,
> new_psr=76554214) at
> /home/build/src/qemu/git/qemu/target/sparc/win_helper.c:156
> #9  0x00007fffe71cd75c in code_gen_buffer ()
> #10 0x000055555561a3e6 in cpu_tb_exec (cpu=0x5555561b3af0,
> itb=0x7fffe68618b0) at /home/build/src/qemu/git/qemu/cpu-exec.c:165
> #11 0x000055555561b176 in cpu_loop_exec_tb (cpu=0x5555561b3af0,
> tb=0x7fffe68618b0, last_tb=0x7fffe5ed4988, tb_exit=0x7fffe5ed4984,
> sc=0x7fffe5ed49a0) at /home/build/src/qemu/git/qemu/cpu-exec.c:584
> #12 0x000055555561b484 in cpu_exec (cpu=0x5555561b3af0) at
> /home/build/src/qemu/git/qemu/cpu-exec.c:686
> #13 0x0000555555654bb9 in tcg_cpu_exec (cpu=0x5555561b3af0) at
> /home/build/src/qemu/git/qemu/cpus.c:1251
> #14 0x0000555555654e8c in qemu_tcg_rr_cpu_thread_fn (arg=0x5555561b3af0)
> at /home/build/src/qemu/git/qemu/cpus.c:1347
> #15 0x00007ffff2c9ab50 in start_thread (arg=<optimized out>) at
> pthread_create.c:304
> #16 0x00007ffff29e4fbd in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> #17 0x0000000000000000 in ?? ()
>
> Thread 2 (Thread 0x7fffe9eee700 (LWP 18040)):
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:39
> #1  0x00005555559144fe in qemu_futex_wait (f=0x555556117664,
> val=4294967295) at /home/build/src/qemu/git/qemu/include/qemu/futex.h:26
> #2  0x00005555559146a6 in qemu_event_wait (ev=0x555556117664) at
> util/qemu-thread-posix.c:399
> #3  0x000055555592c936 in call_rcu_thread (opaque=0x0) at util/rcu.c:249
> #4  0x00007ffff2c9ab50 in start_thread (arg=<optimized out>) at
> pthread_create.c:304
> #5  0x00007ffff29e4fbd in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> #6  0x0000000000000000 in ?? ()
>
> Thread 1 (Thread 0x7ffff7ed6ba0 (LWP 18037)):
> #0  0x00007ffff29da431 in ppoll (fds=<optimized out>, nfds=<optimized
> out>, timeout=<optimized out>, sigmask=<optimized out>) at
> ../sysdeps/unix/sysv/linux/ppoll.c:58
> #1  0x000055555590e22d in qemu_poll_ns (fds=0x55555969a880, nfds=5,
> timeout=3689801) at util/qemu-timer.c:333
> #2  0x000055555590f69f in os_host_main_loop_wait (timeout=3689801) at
> util/main-loop.c:254
> #3  0x000055555590f779 in main_loop_wait (nonblocking=0) at
> util/main-loop.c:508
> #4  0x00005555556d6aae in main_loop () at vl.c:1897
> #5  0x00005555556dec9d in main (argc=5, argv=0x7fffffffea48,
> envp=0x7fffffffea78) at vl.c:4675
>
>
> HTH,
>
> Mark.


--
Alex Bennée
