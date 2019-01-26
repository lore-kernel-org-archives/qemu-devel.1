Received: from eggs.gnu.org ([209.51.188.92]:38313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnOae-0000ap-Dd
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 09:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gnOac-0003KF-Fj
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 09:05:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:36498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gnOaa-0003Hb-Fw
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 09:05:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gnOaV-0007NY-OU
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 14:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B6D442E8050
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 14:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Jan 2019 13:57:58 -0000
From: Szabolcs Nagy <1813398@bugs.launchpad.net>
Reply-To: Bug 1813398 <1813398@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154851076407.2082.8506477460504942900.malonedeb@wampee.canonical.com>
Message-Id: <154851107891.17559.454127515252493278.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813398] Re: qemu user calls malloc after fork in
 multi-threaded process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813398

Title:
  qemu user calls malloc after fork in multi-threaded process

Status in QEMU:
  New

Bug description:
  qemu user may hang in malloc on a musl based system because
  it calls malloc after fork (in a pthread_atfork handler)
  in the child process.

  this is undefined behaviour since the parent process is
  multi-threaded and only as-safe functions may be called
  in the child then. (if malloc/free is called concurrently
  with fork the malloc state will be corrupted in the child,
  it works on glibc because glibc takes the malloc locks
  before the fork syscall, but that breaks the as-safety of
  fork and thus non-conforming to posix)

  discussed at
  https://www.openwall.com/lists/musl/2019/01/26/1

  the bug is hard to reproduce (requires the call_rcu thread
  to call free concurrently with do_fork in the main thread),
  this one is observed with qemu-arm 3.1.0 running on x86_64
  executing an arm busybox sh:

  (gdb) bt
  #0  malloc (n=3D<optimized out>, n@entry=3D9) at src/malloc/malloc.c:306
  #1  0x0000000060184ad3 in g_malloc (n_bytes=3Dn_bytes@entry=3D9) at gmem.=
c:99
  #2  0x000000006018bcab in g_strdup (str=3D<optimized out>, str@entry=3D0x=
60200abf "call_rcu") at gstrfuncs.c:363
  #3  0x000000006016e31d in qemu_thread_create (thread=3Dthread@entry=3D0x7=
ffe367d1870, name=3Dname@entry=3D0x60200abf "call_rcu", =

      start_routine=3Dstart_routine@entry=3D0x60174c00 <call_rcu_thread>, a=
rg=3Darg@entry=3D0x0, mode=3Dmode@entry=3D1)
      at /home/pmos/build/src/qemu-3.1.0/util/qemu-thread-posix.c:526
  #4  0x0000000060174b99 in rcu_init_complete () at /home/pmos/build/src/qe=
mu-3.1.0/util/rcu.c:327
  #5  0x00000000601c4fac in __fork_handler (who=3D1) at src/thread/pthread_=
atfork.c:26
  #6  0x00000000601be8db in fork () at src/process/fork.c:33
  #7  0x000000006009d191 in do_fork (env=3D0x627aaed0, flags=3Dflags@entry=
=3D17, newsp=3Dnewsp@entry=3D0, parent_tidptr=3Dparent_tidptr@entry=3D0, =

      newtls=3Dnewtls@entry=3D0, child_tidptr=3Dchild_tidptr@entry=3D0) at =
/home/pmos/build/src/qemu-3.1.0/linux-user/syscall.c:5528
  #8  0x00000000600af894 in do_syscall1 (cpu_env=3Dcpu_env@entry=3D0x627aae=
d0, num=3Dnum@entry=3D2, arg1=3Darg1@entry=3D0, arg2=3Darg2@entry=3D-870019=
2, =

      arg3=3D<optimized out>, arg4=3D8, arg5=3D1015744, arg6=3D-74144, arg7=
=3D0, arg8=3D0) at /home/pmos/build/src/qemu-3.1.0/linux-user/syscall.c:7042
  #9  0x00000000600a835c in do_syscall (cpu_env=3Dcpu_env@entry=3D0x627aaed=
0, num=3D2, arg1=3D0, arg2=3D-8700192, arg3=3D<optimized out>, =

      arg4=3D<optimized out>, arg5=3D1015744, arg6=3D-74144, arg7=3D0, arg8=
=3D0) at /home/pmos/build/src/qemu-3.1.0/linux-user/syscall.c:11533
  #10 0x00000000600c265f in cpu_loop (env=3Denv@entry=3D0x627aaed0) at /hom=
e/pmos/build/src/qemu-3.1.0/linux-user/arm/cpu_loop.c:360
  #11 0x00000000600417a2 in main (argc=3D<optimized out>, argv=3D0x7ffe367d=
57b8, envp=3D<optimized out>)
      at /home/pmos/build/src/qemu-3.1.0/linux-user/main.c:819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813398/+subscriptions
