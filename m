Received: from eggs.gnu.org ([2001:4830:134:3::10]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fC2Wt-0001Xp-Qe
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fC2Wo-00061i-VY
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:49892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fC2Wo-00060D-Oh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:31:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fC2Wm-00067A-3a
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 12:31:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B54412E818B
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 12:31:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Apr 2018 12:25:08 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701808 <1701808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149891130681.24932.1838110700653893581.malonedeb@soybean.canonical.com>
Message-Id: <152483190887.6994.4153600817846350197.malone@chaenomeles.canonical.com>
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

Confirmed: It's fixed in qemu-2.12.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701808

Title:
  stack smashing in or after recvmsg system call in aarch64 user mode

Status in QEMU:
  Fix Released

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
