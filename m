Received: from eggs.gnu.org ([2001:4830:134:3::10]:39381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLuJJ-0004ra-M9
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLuJI-0006e2-HN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:13:41 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLuJI-0006dq-A3
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:13:40 -0500
Received: by mail-ot0-x233.google.com with SMTP id p3so15350296oti.5
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 09:13:40 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 17:13:19 +0000
Message-ID: <CAFEAcA_ffAw2jz9Sp-hxi_ZvdVjCYynk_0Lk2zFOSCMqCpHgxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] deadlock in rcu_init_lock() in usermode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Hi; in https://bugs.linaro.org/show_bug.cgi?id=3259 comment 27
Stuart provides backtraces of a deadlock in user-mode in the RCU
code.

Specifically, thread 3 (the thread which is running the guest code
which makes the clone syscall to do the fork) is blocked
waiting for the rcu_sync_lock in rcu_init_lock()

Thread 3 (Thread 0x7f85abefa700 (LWP 9233)):
#0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007f85aab5d19d in __GI___pthread_mutex_lock
(mutex=0x563ee0c3e280 <rcu_sync_lock>) at
../nptl/pthread_mutex_lock.c:80
#2  0x0000563ede6ec6b2 in qemu_mutex_lock (mutex=0x563ee0c3e280
<rcu_sync_lock>) at util/qemu-thread-posix.c:65
#3  0x0000563ede6f5127 in rcu_init_lock () at util/rcu.c:340
#4  0x00007f85aa84bc55 in __libc_fork () at ../sysdeps/nptl/fork.c:96
#5  0x0000563ede5c093f in do_fork (env=0x563ee21e9880, flags=17,
newsp=274910760592, parent_tidptr=274910765568, newtls=9231,
child_tidptr=7) at /home/stumon01/repos/qemu/linux-user/syscall.c:6381
#6  0x0000563ede5c86dd in do_syscall (cpu_env=0x563ee21e9880, num=220,
arg1=16657, arg2=274910760592, arg3=274910765568, arg4=9231, arg5=7,
arg6=6, arg7=0, arg8=0)
    at /home/stumon01/repos/qemu/linux-user/syscall.c:9856
#7  0x0000563ede5b13e7 in cpu_loop (env=0x563ee21e9880) at
/home/stumon01/repos/qemu/linux-user/main.c:814
#8  0x0000563ede5c0401 in clone_func (arg=0x7ffcf12be8c0) at
/home/stumon01/repos/qemu/linux-user/syscall.c:6264
#9  0x00007f85aab5a7fc in start_thread (arg=0x7f85abefa700) at
pthread_create.c:465
#10 0x00007f85aa887b0f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

but the rcu_sync_lock is held by the rcu thread:

Thread 2 (Thread 0x7f85aa500700 (LWP 9232)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x0000563ede6ece6e in qemu_futex_wait (f=0x563ee0c3e220
<rcu_gp_event>, val=4294967295) at
/home/stumon01/repos/qemu/include/qemu/futex.h:29
#2  0x0000563ede6ed035 in qemu_event_wait (ev=0x563ee0c3e220
<rcu_gp_event>) at util/qemu-thread-posix.c:442
#3  0x0000563ede6f4bfc in wait_for_readers () at util/rcu.c:131
#4  0x0000563ede6f4cb5 in synchronize_rcu () at util/rcu.c:162
#5  0x0000563ede6f4e44 in call_rcu_thread (opaque=0x0) at util/rcu.c:256
#6  0x00007f85aab5a7fc in start_thread (arg=0x7f85aa500700) at
pthread_create.c:465
#7  0x00007f85aa887b0f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

which AIUI won't drop the rcu_sync_lock until all threads leave
the RCU critical section, which won't ever happen because thread 17
is in the rcu_lead_lock() section inside cpu_exec() and has blocked
waiting for the mmap_lock:

Thread 17 (Thread 0x7f85a9b7c700 (LWP 9276)):
#0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007f85aab5d19d in __GI___pthread_mutex_lock
(mutex=0x563ee0c38ce0 <mmap_mutex>) at ../nptl/pthread_mutex_lock.c:80
#2  0x0000563ede5d16a8 in mmap_lock () at
/home/stumon01/repos/qemu/linux-user/mmap.c:33
#3  0x0000563ede5a9ad9 in tb_find (cpu=0x7f85a59c71e0, last_tb=0x0,
tb_exit=0, cf_mask=524288) at
/home/stumon01/repos/qemu/accel/tcg/cpu-exec.c:392
#4  0x0000563ede5aa2b5 in cpu_exec (cpu=0x7f85a59c71e0) at
/home/stumon01/repos/qemu/accel/tcg/cpu-exec.c:735
#5  0x0000563ede5b12c6 in cpu_loop (env=0x7f85a59cf480) at
/home/stumon01/repos/qemu/linux-user/main.c:808
#6  0x0000563ede5c0401 in clone_func (arg=0x7f85abef8220) at
/home/stumon01/repos/qemu/linux-user/syscall.c:6264
#7  0x00007f85aab5a7fc in start_thread (arg=0x7f85a9b7c700) at
pthread_create.c:465
#8  0x00007f85aa887b0f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

...and thread 3 is holding the mmap lock because it called
fork_start() before calling the fork() libc function (which
is what provoked us to call rcu_init_lock(), which was
registered via pthread_atfork()).


How should this deadlock be broken ?

thanks
-- PMM
