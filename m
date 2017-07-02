Received: from eggs.gnu.org ([2001:4830:134:3::10]:51984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRnrR-0003pk-Pm
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRnrO-0004FQ-Oa
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:58643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRnrO-0004DS-I2
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRnrL-00069j-He
	for <qemu-devel@nongnu.org>; Sun, 02 Jul 2017 23:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8269A2E8194
	for <qemu-devel@nongnu.org>; Sun,  2 Jul 2017 23:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jul 2017 22:54:12 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701971 <1701971@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149903601307.6257.7341525830619997074.malonedeb@gac.canonical.com>
Message-Id: <149903605292.15314.14134338642856039589.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701971] Re: multithreading not working right
 under qemu user mode for sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "Compiled test program"
   https://bugs.launchpad.net/qemu/+bug/1701971/+attachment/4908118/+files/=
test-tls

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701971

Title:
  multithreading not working right under qemu user mode for sh4

Status in QEMU:
  New

Bug description:
  In a multithreaded program running under qemu-sh4 (version 2.9.0),
  thread termination and/or pthread_join is not working right.

  The attached program works natively on all kinds of platforms, and
  under qemu user mode emulation for at least alpha, armelhf, aarch64,
  powerpc64le.

  How to reproduce:
  - Compile the program: sh4-linux-gnu-gcc-5 -O -Wall -lpthread -o test-tls=
 test-tls.c
  - Set environment variables for running qemu-sh4.
  - ~/inst-qemu/2.9.0/bin/qemu-sh4 test-tls

  Expected behaviour: After the "Worker xxxxx dying" line, the main()
  function prints "OK", and the program terminates.

  Actual behaviour (only on sh4): After the "Worker xxxxx dying" line, it h=
angs. Attaching gdb to qemu shows 15 threads with a stack trace like
  #0  safe_syscall_base () at /build/qemu-2.9.0/linux-user/host/x86_64/safe=
-syscall.inc.S:75
  #1  0x00005584f86f4c48 in safe_futex (uaddr=3D<optimized out>, op=3Dop@en=
try=3D128, val=3Dval@entry=3D2, timeout=3D<optimized out>, uaddr2=3Duaddr2@=
entry=3D0x0, =

      val3=3Dval3@entry=3D-161181992) at /build/qemu-2.9.0/linux-user/sysca=
ll.c:921
  #2  0x00005584f870353b in do_futex (val3=3D-161181992, uaddr2=3D413462462=
4, timeout=3D0, val=3D<optimized out>, op=3D<optimized out>, uaddr=3D<optim=
ized out>)
      at /build/qemu-2.9.0/linux-user/syscall.c:7147
  #3  do_syscall (cpu_env=3D<optimized out>, num=3D240, arg1=3D<optimized o=
ut>, arg2=3D<optimized out>, arg3=3D<optimized out>, arg4=3D0, arg5=3D-1603=
42672, =

      arg6=3D-161181992, arg7=3D0, arg8=3D0) at /build/qemu-2.9.0/linux-use=
r/syscall.c:11692
  #4  0x00005584f86f454a in cpu_loop (env=3Denv@entry=3D0x5584fb3d04f8) at =
/build/qemu-2.9.0/linux-user/main.c:2676
  #5  0x00005584f86f5dd5 in clone_func (arg=3D0x7fff4d485c20) at /build/qem=
u-2.9.0/linux-user/syscall.c:6234
  #6  0x00007f08f05a46ba in start_thread (arg=3D0x7f08f1368700) at pthread_=
create.c:333
  #7  0x00007f08f02da3dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109

  and 1 thread with a stack trace like
  #0  safe_syscall_base () at /build/qemu-2.9.0/linux-user/host/x86_64/safe=
-syscall.inc.S:75
  #1  0x00005584f86f4c48 in safe_futex (uaddr=3D<optimized out>, op=3Dop@en=
try=3D0, val=3Dval@entry=3D18875, timeout=3D<optimized out>, uaddr2=3Duaddr=
2@entry=3D0x0, =

      val3=3Dval3@entry=3D-161180376) at /build/qemu-2.9.0/linux-user/sysca=
ll.c:921
  #2  0x00005584f870353b in do_futex (val3=3D-161180376, uaddr2=3D413510176=
8, timeout=3D0, val=3D<optimized out>, op=3D<optimized out>, uaddr=3D<optim=
ized out>)
      at /build/qemu-2.9.0/linux-user/syscall.c:7147
  #3  do_syscall (cpu_env=3D<optimized out>, num=3D240, arg1=3D<optimized o=
ut>, arg2=3D<optimized out>, arg3=3D<optimized out>, arg4=3D0, arg5=3D-1598=
65528, =

      arg6=3D-161180376, arg7=3D0, arg8=3D0) at /build/qemu-2.9.0/linux-use=
r/syscall.c:11692
  #4  0x00005584f86f454a in cpu_loop (env=3D0x5584fb3b99a8) at /build/qemu-=
2.9.0/linux-user/main.c:2676
  #5  0x00005584f86c12d3 in main (argc=3D<optimized out>, argv=3D0x7fff4d48=
78b8, envp=3D<optimized out>)
      at /build/qemu-2.9.0/linux-user/main.c:4860

  and 1 thread with a stack trace like
  #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  #1  0x00005584f876eab5 in qemu_futex_wait (val=3D<optimized out>, f=3D<op=
timized out>) at /build/qemu-2.9.0/include/qemu/futex.h:26
  #2  qemu_event_wait (ev=3Dev@entry=3D0x5584faa43d84 <rcu_call_ready_event=
>) at /build/qemu-2.9.0/util/qemu-thread-posix.c:399
  #3  0x00005584f87748ce in call_rcu_thread (opaque=3D<optimized out>) at /=
build/qemu-2.9.0/util/rcu.c:249
  #4  0x00007f08f05a46ba in start_thread (arg=3D0x7f08eff62700) at pthread_=
create.c:333
  #5  0x00007f08f02da3dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701971/+subscriptions
