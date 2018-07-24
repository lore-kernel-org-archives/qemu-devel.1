Received: from eggs.gnu.org ([2001:4830:134:3::10]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyv-00089Z-Dy
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhvyu-00036l-Hj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:59:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:59:45 +0100
Message-Id: <20180724115950.17316-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] target/arm: Implement HCR_EL2.TGE ("trap
 general exceptions")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In the Arm architecture the HCR_EL2.TGE bit allows software to
configure the CPU so that all exceptions that would target EL1
are instead delivered to EL2. This patchset adds support for
this to QEMU.

The required behaviour is described in the ARMv8 Arm ARM documentation
of the HCR_EL2.TGE bit (in section D10.2.45 of DDI0487C.a):
 * all exceptions that would normally go to NS EL1 must go to NS EL2
 * SCTLR_EL1.M is treated as zero when NS
 * virtual interrupts are disabled
 * exception returns to NS EL1 are treated as illegal exception returns
   (and effectively the CPU cannot execute at NS EL1)
 * HCR_EL2.{FMO,IMO,AMO} are treated as one
 * MDCR_EL2.{TDRA,TDOSA,TDA,TDE} are treated as one

Parts of this we have already implemented:
 * the logic to route asynchronous exceptions (ie interrupts) in
   arm_phys_excp_target_el() already correctly handles the TGE==1 case
 * exception return code in HELPER(exception_return) for AArch64 and
   bad_mode_switch() for AArch32 already catch the exception returns
   which are illegal if TGE==1

This patchset provides the remaining parts, which turn out to
be fairly straightforward. (I was worried that this was going to
require complicated changes to all the sysreg access check code...)

(Needs a fresh git master to apply, since there's a textual
dependency on commit 042374c92e83.)

thanks
-- PMM

Peter Maydell (5):
  target/arm: Mask virtual interrupts if HCR_EL2.TGE is set
  target/arm: Honour HCR_EL2.TGE and MDCR_EL2.TDE in debug register
    access checks
  target/arm: Honour HCR_EL2.TGE when raising synchronous exceptions
  target/arm: Provide accessor functions for HCR_EL2.{IMO,FMO,AMO}
  target/arm: Treat SCTLR_EL1.M as if it were zero when HCR_EL2.TGE is
    set

 target/arm/cpu.h          | 62 ++++++++++++++++++++++++++++++++++++---
 hw/intc/arm_gicv3_cpuif.c | 19 ++++++------
 target/arm/helper.c       | 32 ++++++++++++++------
 target/arm/op_helper.c    | 14 +++++++++
 4 files changed, 105 insertions(+), 22 deletions(-)

-- 
2.17.1
