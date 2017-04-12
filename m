Received: from eggs.gnu.org ([2001:4830:134:3::10]:51825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyDDO-0006ok-KI
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cyDDJ-0004xV-P4
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:01:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:42827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cyDDJ-0004x4-KP
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:01:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cyDDH-0004Cq-TH
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 08:01:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DA0102E800F
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 08:01:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2017 07:51:55 -0000
From: =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <launchpad@kempniu.pl>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <20170412075155.31027.48612.malone@wampee.canonical.com>
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

> > ide_cancel_dma_sync() is also invoked from bmdma_cmd_writeb() and this
> > is in fact the code path taken when the assertion fails.
> > =

> =

> Yep, I wonder why your guest is trying to cancel DMA, though? Something
> else is probably going wrong first.

Beats me.

> Can you compile QEMU from a branch and let me know what kind of info it
> barfs out when it dies?
> =

> https://github.com/jnsnow/qemu/commit/2baa57a58bba00a45151d8544cfd457197e=
cfa39
> =

> Please make backups of your data as appropriate as this is a development
> branch not suitable for production use (etc etc etc!)
> =

> It's just some dumb printfs so I can see what the device was up to when
> it decided to reset itself. I'm hoping that if I can see what command it
> is trying to cancel I can work out why it isn't getting canceled correctl=
y.

It looks like the command being canceled when the assertion fails is
DSM, which explains why it does not happen with TRIM disabled (I retried
the test twice to make sure the canceled command is consistent; it is):

    $ tail -20 qemu.log
    =

    =3D=3D ide_cancel_dma_sync =3D=3D
    =

    ATA Registers:
    cmd	0x06
    feature	0x01
    error	0x00
    nsector	0x00000001
    sector	0x00
    lcyl	0x00
    hcyl	0x00
    hob_feature	0x00
    hob_nsector	0x00
    hob_sector	0x00
    hob_lcyl	0x00
    hob_hcyl	0x00
    select	0x60
    status	0x58
    lba48	0x00000000
    qemu-system-x86_64: hw/ide/core.c:704: ide_cancel_dma_sync: Assertion `=
s->bus->dma->aiocb =3D=3D NULL' failed.
    $ grep ^cmd qemu.log | sort | uniq -c
        128 cmd	0x06
     151854 cmd	0xc8
     217496 cmd	0xca

I am happy to help if any further debugging is required.

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
