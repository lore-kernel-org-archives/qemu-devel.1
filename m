Received: from eggs.gnu.org ([2001:4830:134:3::10]:42236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBna7-0004ZO-EL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBna3-0000E2-Ia
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:01:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:52756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBna3-0000DE-Bs
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:01:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBnZy-0003c6-Iv
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 20:01:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 184482E80D1
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 20:01:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:48:40 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1727737 <1727737@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150902607840.5143.15937446061017284272.malonedeb@chaenomeles.canonical.com>
Message-Id: <150999772080.20841.8541516792894539320.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727737] Re: qemu-arm stalls on a GCC sanitizer
 test since qemu-2.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks. With that extra library, if I run with QEMU_STRACE=3D1 the
following looks very suspicious:

28865 getpid() =3D 28865
28865 mmap2(NULL,2101248,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,=
0) =3D 0x43234000
28865 mprotect(0x43234000,4096,PROT_NONE) =3D 0
28865 rt_sigprocmask(SIG_BLOCK,0x40e077bc,0x40e0783c) =3D 0
28865 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_UNTRACED,child_stack=3D0x43=
434ff8,parent_tidptr=3D0x00000000,tl
s=3D0x00000000,child_tidptr=3D0x00000000) =3D -1 errno=3D22 (Invalid argume=
nt)
28865 rt_sigprocmask(SIG_SETMASK,0x40e0783c,NULL) =3D 0
28865 getpid() =3D 28865
28865 sched_yield(1082131140,0,0,0,1084256812,1084256808) =3D 0
28865 sched_yield(0,0,0,0,1084256812,1084256808) =3D 0
28865 sched_yield(0,0,0,0,1084256812,1084256808) =3D 0
28865 sched_yield(0,0,0,0,1084256812,1084256808) =3D 0


It looks like the test case is (a) calling clone() with non-standard flags =
and (b) not checking whether it failed (presumably it then hangs forever wa=
iting for the non-existent second thread to do something).

This has started failing because we tightened up the handling of flags
in our clone() syscall implementation: instead of blithely accepting any
combination of flags but only giving you the behaviour that glibc
pthread_create() gives, we now fail the clone() syscall if you ask for
some behaviour we can't implement with pthread_create() or fork(). In
this case you've asked for CLONE_VM|CLONE_FS|CLONE_FILES, which is very
nearly a pthread thread but you also need
CLONE_SIGHAND|CLONE_THREAD|CLONESYSVSEM. Also you ask for
CLONE_UNTRACED, which we can't support.

It's unfortunate that this tightening up of the checks means that some
programs which ask for things we can't do but don't actually care about
them will no longer run, but I think this is overall better than
behaving wrongly for guest programs which do care, since we can't tell
which is which.


** Tags added: linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1727737

Title:
  qemu-arm stalls on a GCC sanitizer test since qemu-2.7

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  I have noticed that several GCC/sanitizer tests fail with timeout when
  executed under QEMU.

  After a bit of investigation, I have noticed that this worked with
  qemu-2.7, and started failing with qemu-2.8, and still fails with
  qemu-2.10.1

  I'm attaching a tarball containing:
  alloca_instruments_all_paddings.exe : the testcase, and the needed libs:
  lib/librt.so.1
  lib/libdl.so.2
  lib/ld-linux-armhf.so.3
  lib/libasan.so.5
  lib/libc.so.6
  lib/libgcc_s.so.1
  lib/libpthread.so.0
  lib/libm.so.6

  To reproduce the problem:
  $ qemu-arm -cpu any -R 0 -L $PWD $PWD/alloca_instruments_all_paddings.exe
  returns in less than a second with qemu-2.7, and never with qemu-2.8

  Using -d in_asm suggests that the program "almost" completes and qemu see=
ms to stall on:
  0x40b6eb44: e08f4004 add r4, pc, r4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1727737/+subscriptions
