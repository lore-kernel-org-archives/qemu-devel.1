Received: from eggs.gnu.org ([2001:4830:134:3::10]:38826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdMED-0001lf-F1
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdME9-0006Mb-Js
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:00:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:47630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdME9-0006ML-DX
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 17:00:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdME8-0005eV-8R
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 21:00:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36DE12E8078
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 21:00:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 20:52:31 -0000
From: Luc <1781281@bugs.launchpad.net>
Reply-To: Bug 1781281 <1781281@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153134235209.21545.5674967612897238430.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1781281] [NEW] qemu-ppc64le uncaught target
 signal 4 (Illegal instruction)
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

qemu-ppc64le version 2.12.0
host machine: x86_64 Arch Linux =


I'm currently working on VSX support in libVPX, I'm using qemu to test,
on line 723 of vpx_dsp/ppc/loopfilter_vsx.c, when I change the vec_sub
to vec_subs I get:

qemu: uncaught target signal 4 (Illegal instruction) - core dumped

Thread 1 "qemu-ppc64le" received signal SIGILL, Illegal instruction.
0x00007ffff66d1bf6 in sigsuspend () from /usr/lib/libc.so.6
(gdb) bt
#0  0x00007ffff66d1bf6 in sigsuspend () from /usr/lib/libc.so.6
#1  0x000055555567ee68 in ?? ()
#2  0x000055555567fd18 in ?? ()
#3  0x00005555556805ef in process_pending_signals ()
#4  0x0000555555661e69 in cpu_loop ()
#5  0x000055555561fd72 in main ()

This can be reproduced by downloading this patch (patchset 1):

https://chromium-review.googlesource.com/c/webm/libvpx/+/1134034

and running

qemu-ppc64le -L /home/ltrudeau/x-tools/powerpc64le-unknown-linux-gnu
/powerpc64le-unknown-linux-gnu/sysroot/  ./test_libvpx
--gtest_also_run_disabled_tests "--gtest_filter=3DVSX/*Loop*/*"

I don't observe any issues when running the code on a POWER9 machine.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781281

Title:
  qemu-ppc64le uncaught target signal 4 (Illegal instruction)

Status in QEMU:
  New

Bug description:
  qemu-ppc64le version 2.12.0
  host machine: x86_64 Arch Linux =


  I'm currently working on VSX support in libVPX, I'm using qemu to
  test, on line 723 of vpx_dsp/ppc/loopfilter_vsx.c, when I change the
  vec_sub to vec_subs I get:

  qemu: uncaught target signal 4 (Illegal instruction) - core dumped

  Thread 1 "qemu-ppc64le" received signal SIGILL, Illegal instruction.
  0x00007ffff66d1bf6 in sigsuspend () from /usr/lib/libc.so.6
  (gdb) bt
  #0  0x00007ffff66d1bf6 in sigsuspend () from /usr/lib/libc.so.6
  #1  0x000055555567ee68 in ?? ()
  #2  0x000055555567fd18 in ?? ()
  #3  0x00005555556805ef in process_pending_signals ()
  #4  0x0000555555661e69 in cpu_loop ()
  #5  0x000055555561fd72 in main ()

  This can be reproduced by downloading this patch (patchset 1):

  https://chromium-review.googlesource.com/c/webm/libvpx/+/1134034

  and running

  qemu-ppc64le -L /home/ltrudeau/x-tools/powerpc64le-unknown-linux-gnu
  /powerpc64le-unknown-linux-gnu/sysroot/  ./test_libvpx
  --gtest_also_run_disabled_tests "--gtest_filter=3DVSX/*Loop*/*"

  I don't observe any issues when running the code on a POWER9 machine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781281/+subscriptions
