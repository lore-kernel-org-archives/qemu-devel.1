Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eLwKZ-00088b-Ht
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 14:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eLwKV-0006tN-Jr
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 14:23:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:63329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eLwKV-0006rK-9m
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 14:23:03 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 624857456B3
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 20:22:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 3325D74569D
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 20:22:48 +0100 (CET)
Date: Mon, 4 Dec 2017 20:22:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1712041954200.69360@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Debugging io deadlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I'm seeing a possible deadlock that I don't know how to debug. Any hint on 
how to find the cause or what should be checked further to identify the 
reason why this is happening and how to fix it is greatly appreciated.

Here are the state of threads:

(gdb) info thr
   Id   Target Id         Frame
* 4    Thread 0x7fffba76c700 (LWP 3445) "qemu-system-ppc" 0x0000555555cbec04 in worker_thread (opaque=0x7fffe40c9000) at util/thread-pool.c:92
   3    Thread 0x7fffe8829700 (LWP 3443) "qemu-system-ppc" 0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
   2    Thread 0x7ffff111b700 (LWP 3442) "qemu-system-ppc" 0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
   1    Thread 0x7ffff7fc7b00 (LWP 3441) "qemu-system-ppc" 0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff78d4830 in sem_timedwait () from /lib64/libpthread.so.0
#1  0x0000555555cc572e in qemu_sem_timedwait (sem=0x7fffe40c9078, ms=10000) at util/qemu-thread-posix.c:289
#2  0x0000555555cbec04 in worker_thread (opaque=0x7fffe40c9000) at util/thread-pool.c:92
#3  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
#4  0x00007ffff42d062d in clone () from /lib64/libc.so.6
(gdb) thr 3
[Switching to thread 3 (Thread 0x7fffe8829700 (LWP 3443))]
#0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
(gdb) bt
#0  0x00007ffff78d267f in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000555555cc5458 in qemu_cond_wait (cond=0x555556b47b90, mutex=0x5555565b5220 <qemu_global_mutex>) at util/qemu-thread-posix.c:161
#2  0x00005555557e6690 in qemu_tcg_wait_io_event (cpu=0x7ffff7e20010) at cpus.c:1084
#3  0x00005555557e6f00 in qemu_tcg_rr_cpu_thread_fn (arg=0x7ffff7e20010) at cpus.c:1396
#4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
#5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
(gdb) thr 2
[Switching to thread 2 (Thread 0x7ffff111b700 (LWP 3442))]
#0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff42cad29 in syscall () from /lib64/libc.so.6
#1  0x0000555555cc58a7 in qemu_futex_wait (f=0x555556a01134 <rcu_call_ready_event>, val=4294967295) at include/qemu/futex.h:29
#2  0x0000555555cc5a74 in qemu_event_wait (ev=0x555556a01134 <rcu_call_ready_event>) at util/qemu-thread-posix.c:442
#3  0x0000555555cdd92c in call_rcu_thread (opaque=0x0) at util/rcu.c:249
#4  0x00007ffff78cd5bd in start_thread () from /lib64/libpthread.so.0
#5  0x00007ffff42d062d in clone () from /lib64/libc.so.6
(gdb) thr 1
[Switching to thread 1 (Thread 0x7ffff7fc7b00 (LWP 3441))]
#0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff42c4e31 in ppoll () from /lib64/libc.so.6
#1  0x0000555555cbfe86 in qemu_poll_ns (fds=0x555557c17620, nfds=5, timeout=29806320) at util/qemu-timer.c:334
#2  0x0000555555cc0eab in os_host_main_loop_wait (timeout=29806320) at util/main-loop.c:255
#3  0x0000555555cc0f7d in main_loop_wait (nonblocking=0) at util/main-loop.c:515
#4  0x000055555599e2b3 in main_loop () at vl.c:1995
#5  0x00005555559a6353 in main (argc=21, argv=0x7fffffffdef8, envp=0x7fffffffdfa8) at vl.c:4911

Then if I wait a little, thread 4 exits due to sem_timedwait returning -1 
with errno=ETIMEDOUT leaving other threads waiting for something to happen 
but this is apparently a deadlock as it will be stuck here (thread 1-3 are 
still as above). Any idea why this could happen and how to debug it 
furhter?

Thank you,
BALATON Zoltan
