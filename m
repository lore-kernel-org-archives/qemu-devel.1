Received: from eggs.gnu.org ([2001:4830:134:3::10]:40473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcSH-00086X-32
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcSF-0003ru-Pe
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:53 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 16:05:06 +0000
Message-Id: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 00/18] arm: Add virtualization to GICv3,
 and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

This patchset adds support for the Virtualization extensions to QEMU's
GICv3 emulation. This was the last missing piece that was stopping
us from turning on the EL2 support in the CPU model, so the patchset
also adds support for enabling it all on the virt board via the
'-machine virtualization=on' option.

The result works well enough to allow booting a KVM outer guest kernel
and then running QEMU + an inner guest under KVM inside it. The outer
guest KVM also passes the kvm-unit-tests GIC tests.

Changes v1->v2:
 * rebased on master; some of the earlier patches in v1
   have now gone into master, as has Drew's ACPI cleanup set
 * new patch "psci.c: If EL2 implemented, start CPUs in EL2"
   fixes the problems with SMP configs not starting properly
 * includes Drew's changes to report SMC vs HVC in ACPI
   (slightly tweaked by me)

Patches 1, 4-13, 15, 16 still need review.

Git branch for this:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git gicv3-virt

thanks
-- PMM

Andrew Jones (1):
  hw/arm/virt-acpi-build: use SMC if booting in EL2

Peter Maydell (17):
  hw/intc/arm_gicv3: Add external IRQ lines for VIRQ and VFIQ
  hw/intc/arm_gic: Add external IRQ lines for VIRQ and VFIQ
  target-arm: Expose output GPIO line for VCPU maintenance interrupt
  hw/arm/virt: Wire VIRQ, VFIQ, maintenance irq lines from GIC to CPU
  target-arm: Add ARMCPU fields for GIC CPU i/f config
  hw/intc/gicv3: Add defines for ICH system register fields
  hw/intc/gicv3: Add data fields for virtualization support
  hw/intc/arm_gicv3: Add accessors for ICH_ system registers
  hw/intc/arm_gicv3: Implement ICV_ registers which are just accessors
  hw/intc/arm_gicv3: Implement ICV_ HPPIR, DIR and RPR registers
  hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR
  hw/intc/arm_gicv3: Implement gicv3_cpuif_virt_update()
  hw/intc/arm_gicv3: Implement EL2 traps for CPU i/f regs
  hw/arm/virt: Support using SMC for PSCI
  target/arm/psci.c: If EL2 implemented, start CPUs in EL2
  target-arm: Enable EL2 feature bit on A53 and A57
  hw/arm/virt: Add board property to enable EL2

 hw/intc/gicv3_internal.h           |   79 +++
 include/hw/arm/virt.h              |    5 +-
 include/hw/intc/arm_gic_common.h   |    2 +
 include/hw/intc/arm_gicv3_common.h |   21 +
 target/arm/cpu.h                   |    9 +
 hw/arm/virt-acpi-build.c           |   29 +-
 hw/arm/virt.c                      |   87 ++-
 hw/arm/xlnx-zynqmp.c               |    2 +
 hw/intc/arm_gic_common.c           |    6 +
 hw/intc/arm_gicv3_common.c         |   31 +
 hw/intc/arm_gicv3_cpuif.c          | 1351 +++++++++++++++++++++++++++++++++++-
 target/arm/cpu.c                   |   15 +
 target/arm/cpu64.c                 |    8 +
 target/arm/psci.c                  |   25 +-
 hw/intc/trace-events               |   33 +
 15 files changed, 1642 insertions(+), 61 deletions(-)

-- 
2.7.4
