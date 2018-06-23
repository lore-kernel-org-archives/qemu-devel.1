Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqdF-0001PC-9V
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 18:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqdC-0005KV-42
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 18:03:45 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqdB-0005KI-UX
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 18:03:42 -0400
Received: by mail-qk0-x22a.google.com with SMTP id a195-v6so5620937qkg.3
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 15:03:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
Message-ID: <78984868-7d48-f1ad-af81-3c2c5ac730ce@amsat.org>
Date: Sat, 23 Jun 2018 19:03:36 -0300
MIME-Version: 1.0
In-Reply-To: <2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

> But this one for example never exit:
> 
> xtensa-softmmu/tests$ ../qemu-system-xtensa -M sim -cpu dc232b
> -nographic -semihosting -icount 6 -kernel ./test_mmu.tst -d in_asm
> ...
> ----------------
> IN:
> 0xd0001b0a:  wdtlb	a2, a3
> 
> ----------------
> IN:
> 0xd0001b0d:  l32r	a2, 0xd0000540
> 0xd0001b10:  l32r	a3, 0xd0000544
> 0xd0001b13:  l32r	a4, 0xd0000534
> 0xd0001b16:  sub	a4, a4, a3
> 0xd0001b19:  loop	a4, 0xd0001b26
> 
> ----------------
> IN:
> 0xd0001b1c:  l8ui	a5, a3, 0
> 0xd0001b1f:  s8i	a5, a2, 0
> 0xd0001b22:  addi.n	a2, a2, 1
> 0xd0001b24:  addi.n	a3, a3, 1
> 
> ----------------
> IN:
> 0xd0001b26:  l32r	a2, 0xd0000540
> 0xd0001b29:  l32r	a3, 0xd000053c
> 0xd0001b2c:  jx	a2
> 
> ----------------
> IN:
> 0x00007fff:  l32i	a2, a3, 0
> 

Also it never quit (return to shell):

xtensa-softmmu/tests$ ../qemu-system-xtensa -M sim -cpu dc232b
-nographic -semihosting -icount 6 -kernel ./test_mmu.tst
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) q
HANG

(gdb) info threads
  Id   Target Id         Frame
* 1    Thread 0x7fdfead6bf80 (LWP 1645) 0x00007fdfce6dc4ec in
futex_wait_cancelable (private=<optimized out>, expected=0,
    futex_word=0x55b9940ae288 <qemu_pause_cond+40>) at
../sysdeps/unix/sysv/linux/futex-internal.h:88
  2    Thread 0x7fdfbfc79700 (LWP 1646) syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  3    Thread 0x7fdfbf478700 (LWP 1647) 0x00007fdfce4016d6 in __GI_ppoll
(fds=0x7fdfb0000b20, nfds=1, timeout=<optimized out>,
    timeout@entry=0x0, sigmask=sigmask@entry=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
  4    Thread 0x7fdfbcc77700 (LWP 1648) qemu_spin_lock (spin=<optimized
out>) at /source/qemu/include/qemu/thread.h:111

(gdb) thread apply all bt

Thread 4 (Thread 0x7fdfbcc77700 (LWP 1648)):
#0  0x000055b993a62fe0 in qemu_spin_lock (spin=<optimized out>) at
/source/qemu/include/qemu/thread.h:111
#1  0x000055b993a62fe0 in page_lock (pd=<optimized out>) at
/source/qemu/accel/tcg/translate-all.c:655
#2  0x000055b993a62fe0 in page_lock_pair
(ret_p1=ret_p1@entry=0x7fdfbcc74550, phys1=phys1@entry=100667391,
ret_p2=ret_p2@entry=0x7fdfbcc74558, phys2=phys2@entry=100663296,
alloc=alloc@entry=1) at /source/qemu/accel/tcg/translate-all.c:873
#3  0x000055b993a63643 in tb_link_page (phys_page2=100663296,
phys_pc=100667391, tb=<optimized out>)
    at /source/qemu/accel/tcg/translate-all.c:1602
#4  0x000055b993a63643 in tb_gen_code (cpu=cpu@entry=0x55b9943eb760,
pc=pc@entry=32767, cs_base=cs_base@entry=0, flags=flags@entry=98304,
cflags=cflags@entry=131072) at /source/qemu/accel/tcg/translate-all.c:1794
#5  0x000055b993a61937 in tb_find (cf_mask=131072, tb_exit=0,
last_tb=0x0, cpu=0x18000) at /source/qemu/accel/tcg/cpu-exec.c:401
#6  0x000055b993a61937 in cpu_exec (cpu=cpu@entry=0x55b9943eb760) at
/source/qemu/accel/tcg/cpu-exec.c:721
#7  0x000055b993a307a1 in tcg_cpu_exec (cpu=0x55b9943eb760) at
/source/qemu/cpus.c:1362
#8  0x000055b993a307a1 in qemu_tcg_rr_cpu_thread_fn (arg=<optimized
out>) at /source/qemu/cpus.c:1461
#9  0x00007fdfce6d65aa in start_thread (arg=0x7fdfbcc77700) at
pthread_create.c:463
#10 0x00007fdfce40bcbf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 3 (Thread 0x7fdfbf478700 (LWP 1647)):
#0  0x00007fdfce4016d6 in __GI_ppoll (fds=0x7fdfb0000b20, nfds=1,
timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x000055b993c33109 in ppoll (__ss=0x0, __timeout=0x0,
__nfds=<optimized out>, __fds=<optimized out>)
    at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
#2  0x000055b993c33109 in qemu_poll_ns (fds=<optimized out>,
nfds=<optimized out>, timeout=<optimized out>)
    at /source/qemu/util/qemu-timer.c:322
#3  0x000055b993c34dce in aio_poll (ctx=0x55b9943b35c0,
blocking=blocking@entry=true) at /source/qemu/util/aio-posix.c:629
#4  0x000055b993a9897e in iothread_run (opaque=0x55b9943b3360) at
/source/qemu/iothread.c:64
#5  0x00007fdfce6d65aa in start_thread (arg=0x7fdfbf478700) at
pthread_create.c:463
#6  0x00007fdfce40bcbf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 2 (Thread 0x7fdfbfc79700 (LWP 1646)):
#0  0x00007fdfce4068f9 in syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055b993c370eb in qemu_futex_wait (val=<optimized out>,
f=<optimized out>) at /source/qemu/include/qemu/futex.h:29
#2  0x000055b993c370eb in qemu_event_wait (ev=ev@entry=0x55b9940e49c8
<rcu_call_ready_event>)
    at /source/qemu/util/qemu-thread-posix.c:445
#3  0x000055b993c476a8 in call_rcu_thread (opaque=<optimized out>) at
/source/qemu/util/rcu.c:261
#4  0x00007fdfce6d65aa in start_thread (arg=0x7fdfbfc79700) at
pthread_create.c:463
#5  0x00007fdfce40bcbf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7fdfead6bf80 (LWP 1645)):
#0  0x00007fdfce6dc4ec in futex_wait_cancelable (private=<optimized
out>, expected=0, futex_word=0x55b9940ae288 <qemu_pause_cond+40>)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0x00007fdfce6dc4ec in __pthread_cond_wait_common (abstime=0x0,
mutex=0x55b9940ae2e0 <qemu_global_mutex>, cond=0x55b9940ae260
<qemu_pause_cond>) at pthread_cond_wait.c:502
#2  0x00007fdfce6dc4ec in __pthread_cond_wait
(cond=cond@entry=0x55b9940ae260 <qemu_pause_cond>,
mutex=mutex@entry=0x55b9940ae2e0 <qemu_global_mutex>) at
pthread_cond_wait.c:655
#3  0x000055b993c36c9f in qemu_cond_wait_impl
(cond=cond@entry=0x55b9940ae260 <qemu_pause_cond>,
mutex=mutex@entry=0x55b9940ae2e0 <qemu_global_mutex>,
file=file@entry=0x55b993c52bdb "/source/qemu/cpus.c", line=line@entry=1809)
    at /source/qemu/util/qemu-thread-posix.c:164
#4  0x000055b993a30ce0 in pause_all_vcpus () at /source/qemu/cpus.c:1809
#5  0x000055b993a30d6a in do_vm_stop (state=RUN_STATE_SHUTDOWN,
send_stop=<optimized out>) at /source/qemu/cpus.c:1010
#6  0x000055b9939ef579 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at /source/qemu/vl.c:4605
