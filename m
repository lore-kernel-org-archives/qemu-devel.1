Received: from eggs.gnu.org ([2001:4830:134:3::10]:39166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cy4EK-0004m2-6r
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cy4EF-0003UG-0V
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:25:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:57085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cy4EE-0003UA-Pl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cy4ED-0005Rp-LU
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 22:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 78B612E80C4
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 22:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Apr 2017 22:16:15 -0000
From: John Snow <1681439@bugs.launchpad.net>
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
	<20170411074558.30236.19938.malone@soybean.canonical.com>
Message-Id: <1132de25-6ede-4efb-849b-36378db81072@redhat.com>
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

On 04/11/2017 03:45 AM, Micha=C5=82 K=C4=99pie=C5=84 wrote:
>> I don't think the assert you are talking about in the subject is added
>> by 9972354856. That assertion was added by 86698a12f and has been
>> present since QEMU 2.6. I don't see the relation immediately to
>> AioContext patches.
> =

> You are right, of course.  Sorry for misleading you about this.  What I
> meant to write was that git bisect pinpoints commit 9972354856 as the
> likely culprit ("likely" because of the makeshift testing methodology
> used).
> =

>> Is this only during boot/shutdown? If not, it looks like there might be
>> some other errors occurring that aggravate the device state and cause a
>> reset by the guest.
> =

> In fact this has never happened to me upon boot or shutdown.  I believe
> the operating system installed on the storage volume I am testing this
> with has some kind of disk-intensive activity scheduled to run about
> twenty minutes after booting.  That is why I have to wait that long
> after booting the VM to determine whether the issue appears.
> =


When you're gonna fail, fail loudly, I suppose.

>> Anyway, what should happen is something like this:
>>
>> - Guest issues a reset request (ide_exec_cmd -> cmd_device_reset)
>> - The device should now be "busy" and cannot accept any more requests (s=
ee the conditional early in ide_exec_cmd)
>> - cmd_device_reset drains any existing requests.
>> - we assert that there are no handles to BH routines that have yet to re=
turn
>>
>> Normally I'd say this is enough; because:
>>
>> Although blk_drain does not prohibit future DMA transfers, it is being
>> called after an explicit reset request from the guest, and so the device
>> should be unable to service any further requests. After existing DMA
>> commands are drained we should be unable to add any further requests.
>>
>> It generally shouldn't be possible to see new requests show up here,
>> unless;
>>
>> (A) We are not guarding ide_exec_cmd properly and a new command is sneak=
ing in while we are trying to reset the device, or
>> (B) blk_drain is not in fact doing what we expect it to (draining all pe=
nding DMA from an outstanding IDE command we are servicing.)
> =

> ide_cancel_dma_sync() is also invoked from bmdma_cmd_writeb() and this
> is in fact the code path taken when the assertion fails.
> =


Yep, I wonder why your guest is trying to cancel DMA, though? Something
else is probably going wrong first.

>> Since you mentioned that you need to enable TRIM support in order to see
>> the behavior, perhaps this is a function of a TRIM command being
>> improperly implemented and causing the guest to panic, and we are indeed
>> not draining TRIM requests properly.
> =

> I am not sure what the relation of TRIM to BMDMA is, but I still cannot
> reproduce the issue without TRIM being enabled.
> =


I suspect there isn't one necessarily, just bad interaction between how
TRIM is implemented and how BMDMA works (or allows guests to cancel
DMA.) My hunch is that this doesn't happen with AHCI because the reset
mechanism and command handling are implemented differently.

Always room to be wrong, though.

>> That's my best wild guess, anyway. If you can't reproduce this
>> elsewhere, can you run some debug version of this to see under which
>> codepath we are invoking reset, and what the running command that we are
>> failing to terminate is?
> =

> I recompiled QEMU with --enable-debug --extra-cflags=3D"-ggdb -O0" and
> attached the output of "bt full".  If this is not enough, please let me
> know.
> =

> =

> ** Attachment added: "Output of "bt full" when the assertion fails"
>    https://bugs.launchpad.net/qemu/+bug/1681439/+attachment/4860013/+file=
s/bt-full.log
> =


Can you compile QEMU from a branch and let me know what kind of info it
barfs out when it dies?

https://github.com/jnsnow/qemu/commit/2baa57a58bba00a45151d8544cfd457197ecf=
a39

Please make backups of your data as appropriate as this is a development
branch not suitable for production use (etc etc etc!)

It's just some dumb printfs so I can see what the device was up to when
it decided to reset itself. I'm hoping that if I can see what command it
is trying to cancel I can work out why it isn't getting canceled correctly.

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
