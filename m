Received: from eggs.gnu.org ([2001:4830:134:3::10]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cynjk-0003Xb-LM
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 19:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cynjh-000349-KE
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 19:01:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:38690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cynjh-00033F-EI
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 19:01:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cynjf-0001C6-Cc
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 23:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E6592E80CB
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 23:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Apr 2017 22:52:09 -0000
From: John Snow <1681439@bugs.launchpad.net>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
	<20170412075155.31027.48612.malone@wampee.canonical.com>
Message-Id: <28e63b3d-a9d5-ffab-c770-2b886782a34a@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1681439] Re: qemu-system-x86_64:
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

On 04/12/2017 03:51 AM, Micha=C5=82 K=C4=99pie=C5=84 wrote:

>     $ tail -20 qemu.log
>     =

>     =3D=3D ide_cancel_dma_sync =3D=3D
>     =

>     ATA Registers:
>     cmd	0x06
>     feature	0x01
>     error	0x00
>     nsector	0x00000001
>     sector	0x00
>     lcyl	0x00
>     hcyl	0x00
>     hob_feature	0x00
>     hob_nsector	0x00
>     hob_sector	0x00
>     hob_lcyl	0x00
>     hob_hcyl	0x00
>     select	0x60
>     status	0x58
>     lba48	0x00000000
>     qemu-system-x86_64: hw/ide/core.c:704: ide_cancel_dma_sync: Assertion=
 `s->bus->dma->aiocb =3D=3D NULL' failed.
>     $ grep ^cmd qemu.log | sort | uniq -c
>         128 cmd	0x06
>      151854 cmd	0xc8
>      217496 cmd	0xca
> =

> I am happy to help if any further debugging is required.
> =


Whoops, I misunderstood exactly how often cancel would be invoked here,
sorry about that. It looks like when DMA is finished and the guest
signals that it's over, we cancel any outstanding DMA just to be safe,
and that'd explain the nearly 400,000 calls in your logs.

However, this looks like it might legitimately be trying to cancel a
TRIM command (I don't know why ...) but we don't clean up after those
properly.

Let's try and see if this doesn't fix your problem:
https://github.com/jnsnow/qemu/commit/57bf2ccdfe8dd35838c1e6642bf9bd76dc9ad=
1a9

Optionally, you can delete the printf from the last patch if you want.
I'm still a little concerned that your guest is trying to cancel
in-flight commands which I didn't think would happen under normal
circumstances unless some other problem arose, but I think this will
clear up the assert for us.

Thanks,
-John

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681439

Title:
  qemu-system-x86_64: hw/ide/core.c:685: ide_cancel_dma_sync: Assertion
  `s->bus->dma->aiocb =3D=3D NULL' failed.

Status in QEMU:
  New

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
