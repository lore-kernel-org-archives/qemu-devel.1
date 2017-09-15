Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dszze-0002I0-MW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dszzb-0004j7-D4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:25:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:44067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dszzb-0004ib-6p
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:25:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dszza-0005UD-4W
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 23:25:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1844B2E846C
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 23:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Sep 2017 23:08:04 -0000
From: James Clarke <jrtc27@jrtc27.com>
Reply-To: Bug 1594394 <1594394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160620140124.12349.60184.malonedeb@wampee.canonical.com>
Message-Id: <150551688452.31599.18054112881631628633.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1594394] Re: Using setreuid / setegid crashes
 x86_64 user-mode target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

And to confirm, while somewhat of a hack, that patch does indeed fix
aptitude as expected (as well as my minimal test case I wrote when
debugging this before stumbling upon this bug report).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1594394

Title:
  Using setreuid / setegid crashes x86_64 user-mode target

Status in QEMU:
  New

Bug description:
  When setreuid() or setegid() are called from x86_64 target code in
  user mode, qemu crashes inside the NPTL signal handlers.  x86 targets
  do not directly use a syscall to handle setreuid() / setegid();
  instead the x86 NPTL implementation sets up a temporary data region in
  memory (__xidcmd) and issues a signal (SIGRT1) to all threads,
  allowing the handler for that signal to issue the syscall.  Under
  qemu, __xidcmd remains null (see variable display below backtrace).

  Backtrace:
  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x3fff85c74fc0 (LWP 74517)]
  0x000000006017491c in sighandler_setxid (sig=3D33, si=3D0x3fff85c72d08, c=
tx=3D0x3fff85c71f90) at nptl-init.c:263
  263     nptl-init.c: No such file or directory.
  (gdb) thread apply all bt

  Thread 3 (Thread 0x3fff87e8efc0 (LWP 74515)):
  #0  0x00000000601cc430 in syscall ()
  #1  0x0000000060109080 in futex_wait (val=3D<optimized out>, ev=3D<optimi=
zed out>) at /build/qemu/util/qemu-thread-posix.c:292
  #2  qemu_event_wait (ev=3D0x62367bb0 <rcu_call_ready_event>) at /build/qe=
mu/util/qemu-thread-posix.c:399
  #3  0x000000006010f73c in call_rcu_thread (opaque=3D<optimized out>) at /=
build/qemu/util/rcu.c:250
  #4  0x0000000060176f8c in start_thread (arg=3D0x3fff87e8efc0) at pthread_=
create.c:336
  #5  0x00000000601cebf4 in clone ()

  Thread 2 (Thread 0x3fff85c74fc0 (LWP 74517)):
  #0  0x000000006017491c in sighandler_setxid (sig=3D33, si=3D0x3fff85c72d0=
8, ctx=3D0x3fff85c71f90) at nptl-init.c:263
  #1  <signal handler called>
  #2  0x00000000601cc42c in syscall ()
  #3  0x0000000060044b08 in safe_futex (val3=3D<optimized out>, uaddr2=3D0x=
0, timeout=3D<optimized out>, val=3D<optimized out>, op=3D128, uaddr=3D<opt=
imized out>) at /build/qemu/linux-user/syscall.c:748
  #4  do_futex (val3=3D<optimized out>, uaddr2=3D275186650880, timeout=3D0,=
 val=3D1129, op=3D128, uaddr=3D275186651116) at /build/qemu/linux-user/sysc=
all.c:6201
  #5  do_syscall (cpu_env=3D0x1000abfd350, num=3D<optimized out>, arg1=3D27=
5186651116, arg2=3D<optimized out>, arg3=3D1129, arg4=3D0, arg5=3D275186650=
880, arg6=3D<optimized out>, arg7=3D0, arg8=3D0)
      at /build/qemu/linux-user/syscall.c:10651
  #6  0x00000000600347b8 in cpu_loop (env=3D0x1000abfd350) at /build/qemu/l=
inux-user/main.c:317
  #7  0x0000000060036ae0 in clone_func (arg=3D0x3fffc4c2ca38) at /build/qem=
u/linux-user/syscall.c:5445
  #8  0x0000000060176f8c in start_thread (arg=3D0x3fff85c74fc0) at pthread_=
create.c:336
  #9  0x00000000601cebf4 in clone ()

  Thread 1 (Thread 0x1000aa05000 (LWP 74511)):
  #0  0x00000000601cc430 in syscall ()
  #1  0x0000000060044b08 in safe_futex (val3=3D<optimized out>, uaddr2=3D0x=
0, timeout=3D<optimized out>, val=3D<optimized out>, op=3D128, uaddr=3D<opt=
imized out>) at /build/qemu/linux-user/syscall.c:748
  #2  do_futex (val3=3D<optimized out>, uaddr2=3D1, timeout=3D0, val=3D1, o=
p=3D128, uaddr=3D275078324992) at /build/qemu/linux-user/syscall.c:6201
  #3  do_syscall (cpu_env=3D0x1000aa23890, num=3D<optimized out>, arg1=3D27=
5078324992, arg2=3D<optimized out>, arg3=3D1, arg4=3D0, arg5=3D1, arg6=3D<o=
ptimized out>, arg7=3D0, arg8=3D0) at /build/qemu/linux-user/syscall.c:10651
  #4  0x00000000600347b8 in cpu_loop (env=3D0x1000aa23890) at /build/qemu/l=
inux-user/main.c:317
  #5  0x00000000600020e4 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at /build/qemu/linux-user/main.c:4779
  (gdb) p __xidcmd
  $1 =3D (struct xid_command *) 0x0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1594394/+subscriptions
