Received: from eggs.gnu.org ([2001:4830:134:3::10]:57303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0VP-0002ch-H2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0VL-00069Y-7v
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:51:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:43658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0VL-00069A-1T
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:51:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0VJ-0005fI-6x
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:51:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E69E2E8535
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:51:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:44:05 -0000
From: Thomas Huth <1681439@bugs.launchpad.net>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <153483384643.3659.16443075742979907556.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681439] Re: qemu-system-x86_64:
 hw/ide/core.c:685: ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb ==
 NULL' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
     Assignee: John Snow (jnsnow) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681439

Title:
  qemu-system-x86_64: hw/ide/core.c:685: ide_cancel_dma_sync: Assertion
  `s->bus->dma->aiocb =3D=3D NULL' failed.

Status in QEMU:
  Incomplete

Bug description:
  Since upgrading to QEMU 2.8.0, my Windows 7 64-bit virtual machines
  started crashing due to the assertion quoted in the summary failing.
  The assertion in question was added by commit 9972354856 ("block: add
  BDS field to count in-flight requests").  My tests show that setting
  discard=3Dunmap is needed to reproduce the issue.  Speaking of
  reproduction, it is a bit flaky, because I have been unable to come up
  with specific instructions that would allow the issue to be triggered
  outside of my environment, but I do have a semi-sane way of testing that
  appears to depend on a specific initial state of data on the underlying
  storage volume, actions taken within the VM and waiting for about 20
  minutes.

  Here is the shortest QEMU command line that I managed to reproduce the
  bug with:

      qemu-system-x86_64 \
          -machine pc-i440fx-2.7,accel=3Dkvm \
          -m 3072 \
          -drive file=3D/dev/lvm/qemu,format=3Draw,if=3Dide,discard=3Dunmap=
 \
  	-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhos=
t=3Don \
          -device virtio-net-pci,netdev=3Dhostnet0 \
  	-vnc :0

  The underlying storage (/dev/lvm/qemu) is a thin LVM snapshot.

  QEMU was compiled using:

      ./configure --python=3D/usr/bin/python2.7 --target-list=3Dx86_64-soft=
mmu
      make -j3

  My virtualization environment is not really a critical one and
  reproduction is not that much of a hassle, so if you need me to gather
  further diagnostic information or test patches, I will be happy to help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681439/+subscriptions
