Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqV-0007YI-V5
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPqQ-0004l4-TB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPqQ-0004kg-N2
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2701F87A6D
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:54:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 11:54:11 +0200
Message-Id: <20180822095421.11765-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/10] Don't check disabled drivers
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

In this v3 series:
- Redo the make clean removal of config-devices.mak

- Remove the CONFIG_SERIAL bits, real solution require more thought (I
  tried to run boot-serial-test on all the architectures with serial
  and it was not good).  Too many coments, will try to do some cleanup
  first.

- isa-testdev: I think that one is ok now
- remove x86_64-softmmu instead of i386-softmmu, consistence is great.
- ivshm: it is trivial
- endiannes: I think now it is correct

- xhci-nec: Now also check for ppc64.  I was tying to test xhci (and
  the other hcds) all architectures.  Let's say that it was not pretty
  either.

This are the patches that I think that are ready to go, please review.

Later, Juan

[v2]
this are the patches from v1 that have been reviewed.  Minor changes
in spelled done.  I expect to move those for 3.1.  I will post the
changes and additons on top of this one.

Complain now, or I will send the pull once 3.1 opens.

ToDo:
- I am working on virtio-pci being split
- I plan to integrate virtio-ccw split from Thomas
- I started trying to "untangle" q35 and piix, but it is really deppe
  tangled.

Should I sent the pull request directly, or go through maintainers?

Thanks, Juan.


[v2]
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


Juan Quintela (10):
  configure: We don't want to clean configuration files
  check: Use land/lor when possible
  check: Only test isa-testdev when it is compiled in
  check: Only test usb-xhci-nec when it is compiled in
  x86_64-softmmu: Configuration is identical to i386-softmmu
  check: Only test ivshm when it is compiled in
  check: Only test boot-serial when sga is compiled in
  check: Move VMXNET3 test to common
  check: Move endianess test to common
  check: Move wdt_ib700 test to common

 Makefile                           |  3 +-
 default-configs/x86_64-softmmu.mak | 67 +-----------------------------
 tests/Makefile.include             | 51 ++++++++---------------
 3 files changed, 21 insertions(+), 100 deletions(-)

-- 
2.17.1
