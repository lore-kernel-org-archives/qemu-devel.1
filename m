Received: from eggs.gnu.org ([2001:4830:134:3::10]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewULr-0003tw-PV
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewULo-00082e-MG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:59:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewULo-00081m-FZ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:59:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewULl-0004cv-Ja
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:59:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CABE12E8215
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:56:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 14:46:58 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1751674 <1751674@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151960470707.11772.10064243852456470443.malonedeb@gac.canonical.com>
Message-Id: <152112521835.3967.3459879049205051049.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751674] Re: qemu-system-arm segmentation fault
 trying to dump VM memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

What's happening here is that the memory range you're asking to dump
(physaddrs 0 to 0x3fffffff) includes a lot of devices, including the
interrupt controller, which is at 0x1e000000. There's a longstanding bug
in the GIC code where it will crash if you try to access its per-CPU
register bank from some context that isn't a guest CPU (including the
monitor or the QEMU gdb stub), because it doesn't know which CPU's
version of the registers you wanted. That's what you've run into here.

However, I suspect you didn't really want to try to take a memory dump of a=
 pile of devices. The RAM in the vexpress-a9 board starts at 0x60000000, so=
 if you wanted the RAM then try
  pmemsave 0x60000000 0x9fffffff memory.dmp

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751674

Title:
  qemu-system-arm segmentation fault trying to dump VM memory

Status in QEMU:
  New

Bug description:
  Qemu segfaults trying to generate a VM memory dump:

  $ QEMU_AUDIO_DRV=3Dnone qemu-git-src/arm-softmmu/qemu-system-arm -M vexpr=
ess-a9 -smp 4 -m 1024 -machine secure=3Doff,dump-guest-core=3Don -kernel li=
nux-4.9.75/arch/arm/boot/zImage -append "root=3D/dev/mmcblk0 rw rootfstype=
=3Dext4 mem=3D1024M net.ifnames=3D0 console=3DttyAMA0" -dtb vexpress-v2p-ca=
9.dtb -sd armv7-hd.qcow2 -netdev tap,ifname=3Dtap_armv7,script=3Dno,downscr=
ipt=3Dno,id=3Dnet0 -device virtio-net-device,mac=3D00:AA:AD:BB:FF:02,netdev=
=3Dnet0  -monitor stdio -serial vc  -loadvm SS0
  QEMU 2.11.50 monitor - type 'help' for more information
  (qemu) pmemsave 0 0x3FFFFFFF memory.dmp
  Segmentation fault (core dumped)

  $ git rev-parse HEAD
  b384cd95eb9c6f73ad84ed1bb0717a26e29cc78f

  It's the second time I try to submit this bug, I think last time it
  failed because the attached core dump size (400M compressed). Have a
  look if you can get that file, otherwise I will try to update this
  ticket once it's created:

  (Error ID: OOPS-65553b72bc14be693eb1e37814ff9267)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751674/+subscriptions
