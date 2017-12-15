Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePrPE-0005HY-V2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePrPA-0004U6-0h
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:56:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePrP9-0004PF-Py
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 09:56:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePrP4-00077g-WF
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 14:55:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E9D8A2E80D5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 14:55:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 14:48:18 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1701808 <1701808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149891130681.24932.1838110700653893581.malonedeb@soybean.canonical.com>
Message-Id: <151334929849.11912.10574417332597224784.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701808] Re: stack smashing in or after recvmsg
 system call in aarch64 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This should be fixed by http://patchwork.ozlabs.org/patch/849170/ I
think.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701808

Title:
  stack smashing in or after recvmsg system call in aarch64 user mode

Status in QEMU:
  New

Bug description:
  A program that invokes recvmsg aborts with "*** stack smashing
  detected ***" when run in qemu-aarch64 (user mode), but works fine
  when running on native aarch64 hardware.

  How to reproduce:
  $ aarch64-linux-gnu-gcc-5 -O -Wall /media/develdata/devel/qemu-bug/testpa=
ssfd.c -static -DEXTRA_SPACE=3D0
  $ QEMU_LD_PREFIX=3D/usr/aarch64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-aarc=
h64 ./a.out
  *** stack smashing detected ***: ./a.out terminated
  qemu: uncaught target signal 6 (Aborted) - core dumped

  On native aarch64 hardware:
  $ ./a.out =

  $ echo $?
  0

  The parameter EXTRA_SPACE can be used to add additional space to the
  array that receives the recvmsg data. With -DEXTRA_SPACE=3D9 (or
  larger), the program runs fine. Which suggests that recvmsg is storing
  up to 9 bytes more than allowed in memory.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701808/+subscriptions
