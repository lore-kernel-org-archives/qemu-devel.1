Received: from eggs.gnu.org ([2001:4830:134:3::10]:45220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFF-0006zS-7e
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOFA-0003Pt-6y
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOF9-0003OO-UP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89EBB402312B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:34:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 13:33:37 +0200
Message-Id: <20180717113402.5510-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/25] Don't "check" disabled drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

We can disable drivers with "<foo>-softmmu/config-devices.mak".  But
if we remove drivers there and do "make check", we still try to test
that devices (that are compiled in).  This is a list with the removal
of the ovbious ones.

While I was doing this I fonund:
- we remove <foo>-softmmu/config-devices.mak when we do make clean
  That is an "user" configuration file, we shouldn't do that.
- Use land/lor for consistence
- CONFIG_SERIAL was defined twice for all configurations that include
  pci.mak, fix it.
- pvpanic: We can do the same tricks that everywhere to be able to
  compile it out.

To do a better job, we are in trouble because we only have
"config-devices.mak", but not config-devices.h, so we can't disable
part of the tests/files when we don't want them.  Bigger culprits here
are usb and virtio devices, basically all of them depend of the others
one way or another.

Motivation:

- I compile *lots* of times a day, so it is great to be able to
  compile less devices, it takes less time.
- But if I want to do make check, I need to compile basically a full
  configuration for that platform, so we are at square one.

There are still things that still take too long:
- e1000*/virtio-net pxe test.  It takes more than one second for each,
  and we have e1000/virtio-net/e1000p/virtio-net(again).
- qom tests.  We check _all_ machine types here.  In fast mode, IMHO
  we would only want something like pc-3.0 and q35-30 in fast mode
  (in slow mode everything is ok).
- migration tests: yes, they also took around 5-6 seconds in total,
  and we are adding new tests.  Something needs to be done here.

Time to do "make check" on my laptop (reasonably fast laptop from this
Jannuary) is almost 3mins.  This makes it too long to run continously
for testing that I haven't broken anything.

In another submission I wil send some examples on "how" to disable
other drivers that we can't do now.  But it requires that we generate
config-devices.h to be able to apply them (or yet more complicated
things of registration, see how virtio devices needs to be disabled)

Please review, Juan.

Juan Quintela (25):
  configure: We don't want to clean configuration files
  config:  CONFIG_SERIAL* is already in pci.mak
  check: Use land/lor when possible
  check: Only test vmxnet3 when it is compiled in
  check: Only test ne2000 when it is compiled in
  check: Only test eepro100 when it is compiled in
  check: Only test pcnet when it is compiled in
  check: Only test rtl8139 when it is compiled in
  check: Only test es1370 when it is compiled in
  check: Only test ac97 when it is compiled in
  check: Only test hda when it is compiled in
  check: Only test ipack when it is compiled in
  check: Only test isa-testdev when it is compiled in
  check: Only test ioh3420 when it is compiled in
  check: Only test i82801b11 when it is compiled in
  check: Only test sdhci when it is compiled in
  check: Only test wdt_ib700 when it is compiled in
  check: Only test pvpanic when it is compiled in
  check: Only test nvme when it is compiled in
  check: Only test usb-xhci-nec when it is compiled in
  check: Only test usb-ohci when it is compiled in
  check: Only test usb-uhci devices when they are compiled in
  check: Only test usb-ehci when it is compiled in
  check: Only test ivshm when it is compiled in
  check: Only test tpm devices when they are compiled in

 Makefile                                |   2 +-
 default-configs/alpha-softmmu.mak       |   2 -
 default-configs/arm-softmmu.mak         |   2 -
 default-configs/hppa-softmmu.mak        |   3 -
 default-configs/i386-softmmu.mak        |   2 -
 default-configs/mips-softmmu-common.mak |   2 -
 default-configs/ppc-softmmu.mak         |   1 -
 default-configs/ppcemb-softmmu.mak      |   2 -
 default-configs/sh4-softmmu.mak         |   2 -
 default-configs/sh4eb-softmmu.mak       |   2 -
 default-configs/sparc64-softmmu.mak     |   2 -
 default-configs/x86_64-softmmu.mak      |   2 -
 hw/misc/pvpanic.c                       |  11 --
 include/hw/misc/pvpanic.h               |  11 +-
 tests/Makefile.include                  | 144 ++++++++++++------------
 15 files changed, 81 insertions(+), 109 deletions(-)

-- 
2.17.1
