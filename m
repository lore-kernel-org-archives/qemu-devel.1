Received: from eggs.gnu.org ([2001:4830:134:3::10]:57606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVd-0007PV-80
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVa-0008Ew-4W
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:57 -0400
Received: from foss.arm.com ([217.140.101.70]:46142)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1fgXVZ-0008Ct-Ud
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:39:54 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 20 Jul 2018 16:39:38 +0100
Message-Id: <20180720153942.26821-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v2 0/4] arm: add GICv2 MMIO tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

I found this in one my branches: this is an updated version of what I sent
end of 2016 [1]. I tried to address all comments that Drew and Eric had at
the time.
Please have a look whether this makes sense.

Changelog v1..v2:
- made many functions void
- use symbolic name for first SPI being number 32
- add test runs with one and three vCPUs
- use gic_version() directly
- factor out test_byte_access()
- drop redundant "filling priorities" test
- dropped GICv3 test

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022352.html

Original cover letter:
======================
The GIC spec mandates certain constraints on how to acccess the MMIO
mapped registers, both in terms of which registers are available and also
in terms of which bits within a register should be masked, for instance.
Since we went through some lengths in the KVM emulation to implement this,
it's about time to give this actually a test beyond what the kernel as a
GIC user actually implements - for instance we ignore priorities in Linux.

This series tries to attack some constraints, on a low-hanging-fruit base.
It focusses on some generic registers and the PRIORITY and TARGETS registers
of GICv2. GICv3 is not covered yet.

This actually revealed genuine bugs in the KVM emulation in the past. KVM
passes these tests now, but QEMU fails some UP and 3-way-SMP tests.

Cheers,
Andre.

Andre Przywara (4):
  mark exit() and abort() as non-returning functions
  arm/arm64: GIC: basic GICv2 MMIO tests
  arm/arm64: GICv2: add GICD_IPRIORITYR testing
  arm/arm64: GICv2: add GICD_ITARGETSR testing

 arm/gic.c         | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  18 +++++
 lib/arm/asm/gic.h |   5 ++
 lib/arm/io.c      |   1 +
 lib/libcflat.h    |   7 +-
 lib/powerpc/io.c  |   1 +
 lib/x86/io.c      |   1 +
 7 files changed, 243 insertions(+), 3 deletions(-)

-- 
2.14.4
