Received: from eggs.gnu.org ([2001:4830:134:3::10]:37855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9Vs-0002Qu-US
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gH9Vf-0002Gu-Pu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:31:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gH9Vd-0002Ft-2U
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:31:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so8375733wmf.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:31:16 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-71-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-71-cota@braap.org>
Date: Mon, 29 Oct 2018 15:31:13 +0000
Message-ID: <875zxkahxa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 71/71] cpus-common: wait on the CPU lock
 for exclusive work completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> The current implementation of exclusive work can suffer from high
> contention when the number of guest CPUs is large (> 16 or so). The
> reason is that all CPUs end up waiting on the same condvar/mutex pair,
> which unnecessarily slows them down to wake up.
<snip>

FWIW this is the commit that breaks the linux-test code. I get the
following:

(gdb) thread apply all bt

Thread 2 (Thread 0x7ffff64d3700 (LWP 33607)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055555574d6db in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>) at /home/alex.bennee/lsrc/qemu.git/include/qemu/futex.h:29
#2  qemu_event_wait (ev=3Dev@entry=3D0x555557c4f428 <rcu_call_ready_event>)=
 at util/qemu-thread-posix.c:442
#3  0x0000555555754158 in call_rcu_thread (opaque=3D<optimized out>) at uti=
l/rcu.c:261
#4  0x00007ffff6b3e6db in start_thread (arg=3D0x7ffff64d3700) at pthread_cr=
eate.c:463
#5  0x00007ffff686788f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

Thread 1 (Thread 0x7ffff7fda500 (LWP 33603)):
#0  safe_syscall_base () at /home/alex.bennee/lsrc/qemu.git/linux-user/host=
/x86_64/safe-syscall.inc.S:75
#1  0x000055555563793a in safe_wait4 (rusage=3D0x0, options=3D<optimized ou=
t>, status=3D0x7fffffffc350, pid=3D1472725552) at /home/alex.bennee/lsrc/qe=
mu.git/linux-user/syscall.c:730
#2  do_syscall1 (cpu_env=3Dcpu_env@entry=3D0x555557c88550, num=3Dnum@entry=
=3D260, arg1=3Darg1@entry=3D33608, arg2=3Darg2@entry=3D274886295360, arg3=
=3D<optimized out>, arg4=3D0, arg5=3D4743376, arg6=3D4743168, arg8=3D0, arg=
7=3D0) at /home/alex.bennee/lsrc/qemu.git/linux-user/syscall.c:8784
#3  0x000055555564225a in do_syscall (cpu_env=3Dcpu_env@entry=3D0x555557c88=
550, num=3D260, arg1=3D33608, arg2=3D274886295360, arg3=3D<optimized out>, =
arg4=3D<optimized out>, arg5=3D4743376, arg6=3D4743168, arg7=3D0, arg8=3D0)=
 at /home/alex.bennee/lsrc/qemu.git/linux-user/syscall.c:11432
#4  0x000055555564bc8a in cpu_loop (env=3D0x555557c88550) at /home/alex.ben=
nee/lsrc/qemu.git/linux-user/aarch64/cpu_loop.c:88
#5  0x00005555555e581c in main (argc=3D<optimized out>, argv=3D0x7fffffffe0=
38, envp=3D<optimized out>) at /home/alex.bennee/lsrc/qemu.git/linux-user/m=
ain.c:819

I don't seem to be able to step through it but it looks like the newly
spawned thread is blocked on the futex and the safe_wait4 never
progresses.

--
Alex Benn=C3=A9e
