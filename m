Received: from eggs.gnu.org ([2001:4830:134:3::10]:53446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFdZn-0005Al-QJ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fFdZk-0007Te-JT
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:41:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fFdZk-0007SP-DB
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fFdZi-0005IK-M8
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A54D82E80D2
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 10:40:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 May 2018 10:33:34 -0000
From: ChristianEhrhardt <1769053@bugs.launchpad.net>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
Message-Id: <152568921469.6485.15990399219355923244.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769053] Re: Cannot start a guest with more than
 1TB of RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> Interesting; I thought this was supposed to work.

Exactly that was my thought when triaging it initially
Furthermore I assume people working la57 (https://lwn.net/Articles/730925/)=
 and such ran tests on much bigger sizes.

> Ah right Dan, if you're seeing the 40 bits physical in the guest you
definitely need to try the flags I suggest in comment 6; host-phys-
bits=3Dtrue should work for you.

I tested Bionic to be at least on libvirt 4.0 / qemu 2.11.1 when we want
to check things under the "supposed to work now" flag.

Defaults:
Host:  address sizes   : 46 bits physical, 48 bits virtual
Guest: address sizes   : 40 bits physical, 48 bits virtual

I ensured that with option -cpu host,host-phys-bits=3Dtrue set I successful=
ly get what my host can provide in the guest:
Guest: address sizes   : 46 bits physical, 48 bits virtual

Starting a guest with that >1TB (that would be mostly on swap if needed) wo=
rks just fine as expected. Here ~1063 GB from /proc/meminfo
MemTotal:       1114676492 kB

I also checked a more compatible approach like -cpu qemu64,phys-bits=3D42
and that works as well.

IMHO - if anything - one could argue that libvirt/qemu could be smarter
about e.g. auto adding those arguments (or print a warning) when
crossing a certain memory size.

So for now I'd stick to the "actually works" summary and keep the status
to incomplete.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769053

Title:
  Cannot start a guest with more than 1TB of RAM

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Attempting to start a KVM guest with more than 1TB of RAM fails.

  It looks like we might need some extra patches:
  https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
  ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
  Uname: Linux 4.15.0-20-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7
  Architecture: amd64
  CurrentDesktop: Unity:Unity7:ubuntu
  Date: Fri May  4 16:21:14 2018
  InstallationDate: Installed on 2017-04-05 (393 days ago)
  InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64 (20161012.2)
  MachineType: Dell Inc. XPS 13 9360
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic root=3D/dev/ma=
pper/ubuntu--vg-root ro quiet splash transparent_hugepage=3Dmadvise vt.hand=
off=3D1
  SourcePackage: qemu
  UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
  dmi.bios.date: 02/26/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: 2.6.2
  dmi.board.name: 0PF86Y
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 9
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:pnXPS1393=
60:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
  dmi.product.family: XPS
  dmi.product.name: XPS 13 9360
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
