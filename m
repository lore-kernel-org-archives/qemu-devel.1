Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWhbc-0003XS-L2
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 07:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWhbY-0002hG-Iu
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 07:20:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:49086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dWhbY-0002gr-Cs
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 07:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dWhbX-0004qQ-1X
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 11:20:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0A03E2E8194
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 11:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Jul 2017 11:11:59 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1704638 <1704638@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150020341429.6222.13732739204722487038.malonedeb@gac.canonical.com>
Message-Id: <150020351933.6115.6443448612828080198.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1704638] Re: weak symbol access makes qemu in
 user mode hang for mips, mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "Statically compiled test program for mips"
   https://bugs.launchpad.net/qemu/+bug/1704638/+attachment/4915584/+files/=
testpthsigmask-mips

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1704638

Title:
  weak symbol access makes qemu in user mode hang for mips, mips64

Status in QEMU:
  New

Bug description:
  A program that is statically linked and invokes a weak pointer should
  crash (because the weak pointer evaluates to NULL).

  With qemu in user mode, for mips and mips64, it hangs. The process
  needs to be killed with "kill -9".

  How to reproduce for mips:
  - Compile the program: mips-linux-gnu-gcc-5 -O -Wall -static -o testpthsi=
gmask-mips testpthsigmask.c -pthread
  - Set environment variables for running qemu-mips.
  - ~/inst-qemu/2.9.0/bin/qemu-mips testpthsigmask-mips

  How to reproduce for mips64:
  - Compile the program: mips64-linux-gnuabi64-gcc-5 -O -Wall -static -o te=
stpthsigmask-mips64 testpthsigmask.c -lpthread
  - Set environment variables for running qemu-mips64.
  - ~/inst-qemu/2.9.0/bin/qemu-mips64 testpthsigmask-mips64

  When I attach gdb to the process, I see that it is hanging inside
  'gen_intermediate_code':

  $ gdb /home/bruno/inst-qemu/2.9.0/bin/qemu-mips 9726
  ...
  Reading symbols from /home/bruno/inst-qemu/2.9.0/bin/qemu-mips...done.
  Attaching to program: /home/bruno/inst-qemu/2.9.0/bin/qemu-mips, process =
9726
  ...
  (gdb) info threads
    Id   Target Id         Frame =

  * 1    Thread 0x7f1e7e535740 (LWP 9726) "qemu-mips" __lll_lock_wait () at=
 ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
    2    Thread 0x7f1e7d0ad700 (LWP 9727) "qemu-mips" syscall () at ../sysd=
eps/unix/sysv/linux/x86_64/syscall.S:38
  (gdb) where
  #0  __lll_lock_wait () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.=
S:135
  #1  0x00007f1e7d6f1dbd in __GI___pthread_mutex_lock (mutex=3Dmutex@entry=
=3D0x55de1c7ff830 <tcg_ctx+272>) at ../nptl/pthread_mutex_lock.c:80
  #2  0x000055de1c527199 in qemu_mutex_lock (mutex=3Dmutex@entry=3D0x55de1c=
7ff830 <tcg_ctx+272>)
      at /media/develdata/devel/build/qemu-2.9.0/util/qemu-thread-posix.c:60
  #3  0x000055de1c435083 in tb_lock () at /media/develdata/devel/build/qemu=
-2.9.0/translate-all.c:167
  #4  cpu_restore_state (cpu=3Dcpu@entry=3D0x55de1e915cb0, retaddr=3Dretadd=
r@entry=3D94412445741769) at /media/develdata/devel/build/qemu-2.9.0/transl=
ate-all.c:350
  #5  0x000055de1c4658d0 in handle_cpu_signal (old_set=3D0x7ffe5ffd8ea8, is=
_write=3D0, address=3D0, pc=3D94412445741767)
      at /media/develdata/devel/build/qemu-2.9.0/user-exec.c:124
  #6  cpu_mips_signal_handler (host_signum=3Dhost_signum@entry=3D11, pinfo=
=3Dpinfo@entry=3D0x7ffe5ffd8eb0, puc=3Dpuc@entry=3D0x7ffe5ffd8d80)
      at /media/develdata/devel/build/qemu-2.9.0/user-exec.c:229
  #7  0x000055de1c4803be in host_signal_handler (host_signum=3D11, info=3D0=
x7ffe5ffd8eb0, puc=3D0x7ffe5ffd8d80)
      at /media/develdata/devel/build/qemu-2.9.0/linux-user/signal.c:646
  #8  <signal handler called>
  #9  __bswap_32 (__bsx=3D<optimized out>) at /usr/include/x86_64-linux-gnu=
/bits/byteswap.h:47
  #10 bswap32 (x=3D<optimized out>) at /media/develdata/devel/build/qemu-2.=
9.0/include/qemu/bswap.h:21
  #11 ldl_be_p (ptr=3D<optimized out>) at /media/develdata/devel/build/qemu=
-2.9.0/include/qemu/bswap.h:434
  #12 cpu_ldl_code (env=3D0x55de1e91df48, ptr=3D0) at /media/develdata/deve=
l/build/qemu-2.9.0/include/exec/cpu_ldst_useronly_template.h:68
  #13 gen_intermediate_code (env=3Denv@entry=3D0x55de1e91df48, tb=3Dtb@entr=
y=3D0x7f1e7b288e58)
      at /media/develdata/devel/build/qemu-2.9.0/target/mips/translate.c:19=
962
  #14 0x000055de1c4352e6 in tb_gen_code (cpu=3Dcpu@entry=3D0x55de1e915cb0, =
pc=3Dpc@entry=3D0, cs_base=3Dcs_base@entry=3D0, flags=3Dflags@entry=3D162, =
cflags=3D<optimized out>, =

      cflags@entry=3D0) at /media/develdata/devel/build/qemu-2.9.0/translat=
e-all.c:1295
  #15 0x000055de1c436a7a in tb_find (tb_exit=3D0, last_tb=3D0x0, cpu=3D<opt=
imized out>) at /media/develdata/devel/build/qemu-2.9.0/cpu-exec.c:365
  #16 cpu_exec (cpu=3D<optimized out>) at /media/develdata/devel/build/qemu=
-2.9.0/cpu-exec.c:673
  #17 0x000055de1c466278 in cpu_loop (env=3D0x55de1e91df48) at /media/devel=
data/devel/build/qemu-2.9.0/linux-user/main.c:2236
  #18 0x000055de1c433103 in main (argc=3D<optimized out>, argv=3D0x7ffe5ffd=
9de8, envp=3D<optimized out>)
      at /media/develdata/devel/build/qemu-2.9.0/linux-user/main.c:4860
  (gdb) thread 2
  [Switching to thread 2 (Thread 0x7f1e7d0ad700 (LWP 9727))]
  #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  38      ../sysdeps/unix/sysv/linux/x86_64/syscall.S: Datei oder Verzeichn=
is nicht gefunden.
  (gdb) where
  #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  #1  0x000055de1c527605 in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /media/develdata/devel/build/qemu-2.9.0/include/qemu/futex=
.h:26
  #2  qemu_event_wait (ev=3Dev@entry=3D0x55de1e82c124 <rcu_call_ready_event=
>) at /media/develdata/devel/build/qemu-2.9.0/util/qemu-thread-posix.c:399
  #3  0x000055de1c52d41e in call_rcu_thread (opaque=3D<optimized out>) at /=
media/develdata/devel/build/qemu-2.9.0/util/rcu.c:249
  #4  0x00007f1e7d6ef6ba in start_thread (arg=3D0x7f1e7d0ad700) at pthread_=
create.c:333
  #5  0x00007f1e7d4253dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1704638/+subscriptions
