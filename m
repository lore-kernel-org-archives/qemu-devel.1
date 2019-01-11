Received: from eggs.gnu.org ([209.51.188.92]:58434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghyJY-00027P-E9
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghyJX-00014Z-1a
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:01:40 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:42798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghyJW-0000xg-GV
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:01:38 -0500
Received: by mail-ot1-x32f.google.com with SMTP id v23so13315511otk.9
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:01:18 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 15:01:06 +0000
Message-ID: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Recently I've noticed that test-filter-mirror has been hanging
intermittently, typically when run on some other TCG architecture.
In the instance I've just looked at, this was with s390x guest on
x86-64 host, though I've also seen it on other host archs and
perhaps with other guests.

Below is a backtrace, though it seems to be pretty unhelpful.
Anybody got any theories ? Does the mirror test rely on dirty
memory bitmaps like the migration test (which also hangs
occasionally with TCG due to some bug I'm sure we've investigated
in the past) ?

Processes:
petmay01 10533  0.0  0.0  15624  1400 pts/16   S+   14:22   0:00
                           \_ tests/test-filter-mirror --quiet
--keep-going -m=quick --GTestLogFD=6
petmay01 10534  0.0  0.2 979892 36492 pts/16   Sl+  14:22   0:00
                               \_ s390x-softmmu/qemu-system-s390x
-qtest unix:/tmp/qtest-10533.sock,nowait -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-10533.qmp,nowait,id=char0 -mon
chardev=char0,mode=control -machine accel=qtest -display none -netdev
socket,id=qtest-bn0,fd=4 -device
virtio-net-ccw,netdev=qtest-bn0,id=qtest-e0 -chardev
socket,id=mirror0,path=filter-mirror.Ongzms,server,nowait -object
filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0

Backtrace of all threads in the QEMU process:
Thread 4 (Thread 0x7f59b67ff700 (LWP 10539)):
#0  0x00007f59cf908156 in __sigwait (sig=0x7f59b67fc510, set=<optimised out>)
    at ../sysdeps/unix/sysv/linux/sigwait.c:64
#1  0x00007f59cf908156 in __sigwait (set=<optimised out>, sig=0x7f59b67fc510)
    at ../sysdeps/unix/sysv/linux/sigwait.c:96
#2  0x00005639a87c4c8e in qemu_dummy_cpu_thread_fn (arg=0x5639aa544250)
    at /home/petmay01/linaro/qemu-for-merges/cpus.c:1326
#3  0x00005639a8b8b911 in qemu_thread_start (args=0x5639aa569010)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#4  0x00007f59cf8fe6ba in start_thread (arg=0x7f59b67ff700) at
pthread_create.c:333
#5  0x00007f59cf63441d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 3 (Thread 0x7f59bf1f0700 (LWP 10538)):
#0  0x00007f59cf62874d in poll () at ../sysdeps/unix/syscall-template.S:84
#1  0x00007f59e64e638c in g_main_context_iterate (priority=2147483647,
n_fds=3, fds=0x7f59b0001300, timeout=<optimised out>,
context=0x7f59b00008c0)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gmain.c:4135
#2  0x00007f59e64e638c in g_main_context_iterate
(context=0x7f59b00008c0, block=block@entry=1,
dispatch=dispatch@entry=1, self=<optimised out>)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gmain.c:3835
#3  0x00007f59e64e6712 in g_main_loop_run (loop=0x7f59b00012e0)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gmain.c:4034
#4  0x00005639a88d187a in iothread_run (opaque=0x5639aa512710)
    at /home/petmay01/linaro/qemu-for-merges/iothread.c:74
#5  0x00005639a8b8b911 in qemu_thread_start (args=0x5639aa49d6a0)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#6  0x00007f59cf8fe6ba in start_thread (arg=0x7f59bf1f0700) at
pthread_create.c:333
#7  0x00007f59cf63441d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 2 (Thread 0x7f59bf9f1700 (LWP 10537)):
#0  0x00007f59cf62e4d9 in syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00005639a8b8b58f in qemu_futex_wait (f=0x5639a930a418
<rcu_call_ready_event>, val=4294967295)
    at /home/petmay01/linaro/qemu-for-merges/include/qemu/futex.h:29
#2  0x00005639a8b8b75e in qemu_event_wait (ev=0x5639a930a418
<rcu_call_ready_event>)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:442
#3  0x00005639a8ba41d3 in call_rcu_thread (opaque=0x0)
    at /home/petmay01/linaro/qemu-for-merges/util/rcu.c:261
#4  0x00005639a8b8b911 in qemu_thread_start (args=0x5639aa449ac0)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#5  0x00007f59cf8fe6ba in start_thread (arg=0x7f59bf9f1700) at
pthread_create.c:333
#6  0x00007f59cf63441d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 1 (Thread 0x7f59e9017fc0 (LWP 10534)):
#0  0x00007f59cf628811 in __GI_ppoll (fds=0x5639aa5a1b90, nfds=6,
timeout=<optimised out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:50
#1  0x00005639a8b8534b in qemu_poll_ns (fds=0x5639aa5a1b90, nfds=6, timeout=-1)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-timer.c:322
---Type <return> to continue, or q <return> to quit---
#2  0x00005639a8b86527 in os_host_main_loop_wait (timeout=-1)
    at /home/petmay01/linaro/qemu-for-merges/util/main-loop.c:233
#3  0x00005639a8b865fe in main_loop_wait (nonblocking=0)
    at /home/petmay01/linaro/qemu-for-merges/util/main-loop.c:497
#4  0x00005639a88dab83 in main_loop () at
/home/petmay01/linaro/qemu-for-merges/vl.c:1925
#5  0x00005639a88e25b9 in main (argc=21, argv=0x7ffd344d6138,
envp=0x7ffd344d61e8)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:4669

Backtrace in test-filter-mirror:
Thread 1 (Thread 0x7fd24ab03740 (LWP 10533)):
#0  0x00007fd24a0eb81d in __libc_recv (fd=8, buf=0x7ffcef3a8c58, n=4, flags=0)
    at ../sysdeps/unix/sysv/linux/x86_64/recv.c:28
#1  0x000055e065d2d26a in test_mirror ()
    at /home/petmay01/linaro/qemu-for-merges/tests/test-filter-mirror.c:70
#2  0x00007fd24a67087b in test_case_run (tc=0x55e0676b6a00)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2158
#3  g_test_run_suite_internal (suite=suite@entry=0x55e0676b6060,
path=path@entry=0x0)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2241
#4  0x00007fd24a670a43 in g_test_run_suite_internal
(suite=suite@entry=0x55e0676b6040,
    path=path@entry=0x0) at
/build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2253
#5  0x00007fd24a670a43 in g_test_run_suite_internal
(suite=suite@entry=0x55e0676b6020,
    path=path@entry=0x0) at
/build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2253
#6  0x00007fd24a670c4e in g_test_run_suite (suite=0x55e0676b6020)
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:2328
#7  0x00007fd24a670c71 in g_test_run ()
    at /build/glib2.0-7ZsPUq/glib2.0-2.48.2/./glib/gtestutils.c:1596
#8  0x000055e065d2d4af in main (argc=1, argv=0x7ffcef3a9128)
    at /home/petmay01/linaro/qemu-for-merges/tests/test-filter-mirror.c:92


thanks
-- PMM
