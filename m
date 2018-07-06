Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbVCV-0005Xb-7h
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbVCS-0007ui-2a
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:11:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbVCR-0007t3-Rx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:11:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbVCP-0005Vo-0T
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 18:11:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 91B742E81AE
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 18:11:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 18:00:13 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1771948 <1771948@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152662586393.8948.4447581734098771947.malonedeb@chaenomeles.canonical.com>
Message-Id: <153090001332.18292.12386788068966849750.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771948] Re: aarch64 msr CNTFRQ_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking more closely at this, I think this is because you've passed QEMU
a file which it is treating as a Linux kernel. (-kernel treats raw
binaries and uimage files as Linux kernels; it treats ELF files as not
being Linux kernels). Linux expects to be started in EL2, so although
the emulated CPU has EL3, we start your program in EL2. Your program is
therefore not running at the highest available exception level, and
can't write to CNTFRQ_EL0.

For "bare metal" images where you want to do things at EL3, it may be
better to build them as ELF files which are linked to load at address 0.
Note that all four cores will start at address zero simultaneously, so
you'll need a bit of "pen code" to sort the secondaries out from the
primary.
https://github.com/raspberrypi/tools/blob/master/armstubs/armstub8.S
might be useful reference. As I understand it, this is how your code
would be run on real raspi3 hardware too.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771948

Title:
  aarch64 msr CNTFRQ_EL0

Status in QEMU:
  New

Bug description:
  Hello,

  I'm running qemu 2.12 on a raspberry pi 3 with the command:

  qemu-system-aarch64 -M raspi3 -serial stdio -kernel executable.bin

  On my start file (right in the beginning with the highest EL), the
  following instructions:

  ldr x0 , =3D19200000
  msr CNTFRQ_EL0, x0

  =

  and qemu halts on the "msr CNTFRQ_EL0, x0" instruction.

  I believe this is not a normal behavior.

  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771948/+subscriptions
