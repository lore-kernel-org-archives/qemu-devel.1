Received: from eggs.gnu.org ([2001:4830:134:3::10]:44545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5WS5-00024M-Fr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5WRz-00078k-IA
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:31:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:60692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e5WRz-00078H-Ay
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:30:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e5WRx-0003wE-HQ
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 811752E80CB
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Oct 2017 12:18:10 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1725267 <1725267@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150850189101.17148.14929440782690831821.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1725267] [NEW] armeb regression since qemu
 version 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Hi,

I have noticed a regression when I upgraded from qemu-armeb 2.7 to 2.8,
and the problem is still present with version 2.10.1.

I am using qemu for GCC validation, noticed problems with testcases
involving atomics, I'm attaching here atomic-exchange-4.exe.

# with 2.7:
$ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/atomi=
c-exchange-4.exe
$ echo $?
0
# with 2.8, 2.10.1:
$ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/atomi=
c-exchange-4.exe
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted (core dumped)
$ echo $?
134

The source code is gcc/testsuite/gcc.dg/atomic-exchange-4.c

Running with -d in_asm shows a difference early in the startup code:
IN: _dl_sysdep_start
[...]
0x40a17790:  908ff103      addls	pc, pc, r3, lsl #2

and then the next address is not the same with qemu 2.7 and 2.10.1

I hope you have enough data/information to reproduce and confirm/fix the
problem.

Thanks

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "testcase with ld.so and needed *.so"
   https://bugs.launchpad.net/bugs/1725267/+attachment/4978665/+files/atomi=
c-armeb.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1725267

Title:
  armeb regression since qemu version 2.8

Status in QEMU:
  New

Bug description:
  Hi,

  I have noticed a regression when I upgraded from qemu-armeb 2.7 to
  2.8, and the problem is still present with version 2.10.1.

  I am using qemu for GCC validation, noticed problems with testcases
  involving atomics, I'm attaching here atomic-exchange-4.exe.

  # with 2.7:
  $ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/ato=
mic-exchange-4.exe
  $ echo $?
  0
  # with 2.8, 2.10.1:
  $ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/ato=
mic-exchange-4.exe
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)
  $ echo $?
  134

  The source code is gcc/testsuite/gcc.dg/atomic-exchange-4.c

  Running with -d in_asm shows a difference early in the startup code:
  IN: _dl_sysdep_start
  [...]
  0x40a17790:  908ff103      addls	pc, pc, r3, lsl #2

  and then the next address is not the same with qemu 2.7 and 2.10.1

  I hope you have enough data/information to reproduce and confirm/fix
  the problem.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1725267/+subscriptions
