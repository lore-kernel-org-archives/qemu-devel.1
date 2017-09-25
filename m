Received: from eggs.gnu.org ([2001:4830:134:3::10]:36760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwLHD-0001U2-1T
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 00:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dwLH9-0002en-UP
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 00:45:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dwLH9-0002dt-N8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 00:45:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dwLH5-000439-VS
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E66E52E8491
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 04:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Sep 2017 04:34:18 -0000
From: =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <launchpad@kempniu.pl>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <150631405842.6013.14629386568088425913.malone@soybean.canonical.com>
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

I cannot reproduce this any more with QEMU 2.9.0.  As I do not really
have time right now to determine which commit fixed this, feel free to
close this bug.  I will reopen it in case the issue resurfaces.  Thanks
for your assistance.

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
