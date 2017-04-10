Received: from eggs.gnu.org ([2001:4830:134:3::10]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxgop-0004Lo-0C
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 17:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxgol-0004Ww-RB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 17:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:52129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxgol-0004We-IM
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 17:25:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxgoi-0005XN-Vg
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B1082E81A1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Apr 2017 21:17:21 -0000
From: John Snow <1681439@bugs.launchpad.net>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <20170410211721.31471.80977.malone@wampee.canonical.com>
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

I don't think the assert you are talking about in the subject is added
by 9972354856. That assertion was added by 86698a12f and has been
present since QEMU 2.6. I don't see the relation immediately to
AioContext patches.

Is this only during boot/shutdown? If not, it looks like there might be
some other errors occurring that aggravate the device state and cause a
reset by the guest.

Anyway, what should happen is something like this:

- Guest issues a reset request (ide_exec_cmd -> cmd_device_reset)
- The device should now be "busy" and cannot accept any more requests (see =
the conditional early in ide_exec_cmd)
- cmd_device_reset drains any existing requests.
- we assert that there are no handles to BH routines that have yet to return

Normally I'd say this is enough; because:

Although blk_drain does not prohibit future DMA transfers, it is being
called after an explicit reset request from the guest, and so the device
should be unable to service any further requests. After existing DMA
commands are drained we should be unable to add any further requests.

It generally shouldn't be possible to see new requests show up here,
unless;

(A) We are not guarding ide_exec_cmd properly and a new command is sneaking=
 in while we are trying to reset the device, or
(B) blk_drain is not in fact doing what we expect it to (draining all pendi=
ng DMA from an outstanding IDE command we are servicing.)

Since you mentioned that you need to enable TRIM support in order to see
the behavior, perhaps this is a function of a TRIM command being
improperly implemented and causing the guest to panic, and we are indeed
not draining TRIM requests properly.

That's my best wild guess, anyway. If you can't reproduce this
elsewhere, can you run some debug version of this to see under which
codepath we are invoking reset, and what the running command that we are
failing to terminate is?

--js

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
