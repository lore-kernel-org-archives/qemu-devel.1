Received: from eggs.gnu.org ([2001:4830:134:3::10]:47455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7V-0006kM-H0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cEK7R-0005VA-VN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1cEK7R-0005Uj-IZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:05:33 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue,  6 Dec 2016 12:05:23 -0600
Message-Id: <1481047528-16180-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v14 0/5] ARM PMU tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cov@codeaurora.org
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, shannon.zhao@linaro.org, alistair.francis@xilinx.com, croberts@codeaurora.org, alindsay@codeaurora.org, drjones@redhat.com, andre.przywara@arm.com

Changes from v13:
* Rename cp15.h to sysreg.h for ARMv7 and add a new file sysreg.h for ARMv8
* Add macros for read_sysreg() and write_sysreg(). CP15 registers can be
  defined with __ACCESS_CP15() or __ACCESS_CP15_64(). sysreg.h (ARMv8) was
  from Drew's GIC testing code, which can be leveraged when his GIC testing
  code is imported.
* Rewrite PMU testing code based on new macros. All get_xxx() and set_xxx()
  functions are defined in pmu.c based on read_sysreg() and write_sysreg().
  So the code parsing tool, like cscope, can parse them easily.
* Minor fixes inside pmu.c, printf formatting, pmu_probe() func, based on
  Andre's comments.

Note:
Current KVM code has bugs in handling PMCCFILTR write. A fix (see below) is
required for this unit testing code to work correctly under KVM mode.
Link: https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022134.html.

Thanks,
-Wei

Christopher Covington (3):
  arm: Add PMU test
  arm: pmu: Check cycle count increases
  arm: pmu: Add CPI checking

Wei Huang (2):
  arm: rename cp15.h to sysreg.h
  arm: Add support for read_sysreg() and write_sysreg()

 arm/Makefile.common              |   3 +-
 arm/cstart.S                     |   2 +-
 arm/pmu.c                        | 290 +++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg                |  19 +++
 lib/arm/asm/processor.h          |   6 +-
 lib/arm/asm/{cp15.h => sysreg.h} |  25 +++-
 lib/arm64/asm/processor.h        |  11 +-
 lib/arm64/asm/sysreg.h           |  26 ++++
 lib/libcflat.h                   |   4 +-
 9 files changed, 369 insertions(+), 17 deletions(-)
 create mode 100644 arm/pmu.c
 rename lib/arm/asm/{cp15.h => sysreg.h} (68%)
 create mode 100644 lib/arm64/asm/sysreg.h

-- 
1.8.3.1
