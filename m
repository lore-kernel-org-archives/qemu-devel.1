Received: from eggs.gnu.org ([2001:4830:134:3::10]:49577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEFWs-0000TA-87
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEFWn-0001SR-5L
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:16:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:56532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEFWm-0001Re-VE
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:15:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEFWj-0002Zh-LB
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 14:15:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9E2122E80CE
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 14:15:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 14:00:43 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1727737 <1727737@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150902607840.5143.15937446061017284272.malonedeb@chaenomeles.canonical.com>
Message-Id: <151058164318.28255.17292220902034659220.malone@gac.canonical.com>
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

Thanks for the clarification.

But how does the target get the actual syscall return code, if
do_syscall() is supposed to return negative-target-errno?

I mean, in general the target code will check if the syscall returned -1, a=
nd only then query errno?
But if QEMU's do_syscall returns -errno, and put this value in r0 (for arm)=
 how is the target code supposed to work?

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
