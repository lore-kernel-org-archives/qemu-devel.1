Received: from eggs.gnu.org ([2001:4830:134:3::10]:52328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduo-0004PE-S3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdte-0006US-3F
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtc-0006SH-J0
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdta-00076o-B3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:30 +0100
Message-Id: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/45] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First pullreq of the 3.1 release cycle, with lots of
Arm related patches accumulated during freeze. Most
notable here is Luc's GICv2 virtualization support and
my execute-from-MMIO patches.

I stopped looking at my to-review queue towards the
end of freeze, since 45 patches is already pushing what
I consider a reasonable sized pullreq; once this goes into
master I'll start working through it again.

thanks
-- PMM

The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:

  Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180814

for you to fetch changes up to 054e7adf4e64e4acb3b033348ebf7cc871baa34f:

  target/arm: Fix typo in helper_sve_movz_d (2018-08-14 17:17:22 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement more of ARMv6-M support
 * Support direct execution from non-RAM regions;
   use this to implmeent execution from small (<1K) MPU regions
 * GICv2: implement the virtualization extensions
 * support a virtualization-capable GICv2 in the virt and
   xlnx-zynqmp boards
 * arm: Fix return code of arm_load_elf() so we can detect
   failure to load the file correctly
 * Implement HCR_EL2.TGE ("trap general exceptions") bit
 * Implement tailchaining for M profile cores
 * Fix bugs in SVE compare, saturating add/sub, WHILE, MOVZ

----------------------------------------------------------------
Adam Lackorzynski (1):
      arm: Fix return code of arm_load_elf

Julia Suvorova (4):
      target/arm: Forbid unprivileged mode for M Baseline
      nvic: Handle ARMv6-M SCS reserved registers
      arm: Add ARMv6-M programmer's model support
      nvic: Change NVIC to support ARMv6-M

Luc Michel (20):
      intc/arm_gic: Refactor operations on the distributor
      intc/arm_gic: Implement GICD_ISACTIVERn and GICD_ICACTIVERn registers
      intc/arm_gic: Remove some dead code and put some functions static
      vmstate.h: Provide VMSTATE_UINT16_SUB_ARRAY
      intc/arm_gic: Add the virtualization extensions to the GIC state
      intc/arm_gic: Add virtual interface register definitions
      intc/arm_gic: Add virtualization extensions helper macros and functions
      intc/arm_gic: Refactor secure/ns access check in the CPU interface
      intc/arm_gic: Add virtualization enabled IRQ helper functions
      intc/arm_gic: Implement virtualization extensions in gic_(activate_irq|drop_prio)
      intc/arm_gic: Implement virtualization extensions in gic_acknowledge_irq
      intc/arm_gic: Implement virtualization extensions in gic_(deactivate|complete_irq)
      intc/arm_gic: Implement virtualization extensions in gic_cpu_(read|write)
      intc/arm_gic: Wire the vCPU interface
      intc/arm_gic: Implement the virtual interface registers
      intc/arm_gic: Implement gic_update_virt() function
      intc/arm_gic: Implement maintenance interrupt generation
      intc/arm_gic: Improve traces
      xlnx-zynqmp: Improve GIC wiring and MMIO mapping
      arm/virt: Add support for GICv2 virtualization extensions

Peter Maydell (16):
      accel/tcg: Pass read access type through to io_readx()
      accel/tcg: Handle get_page_addr_code() returning -1 in hashtable lookups
      accel/tcg: Handle get_page_addr_code() returning -1 in tb_check_watchpoint()
      accel/tcg: tb_gen_code(): Create single-insn TB for execution from non-RAM
      accel/tcg: Return -1 for execution from MMIO regions in get_page_addr_code()
      target/arm: Allow execution from small regions
      accel/tcg: Check whether TLB entry is RAM consistently with how we set it up
      target/arm: Mask virtual interrupts if HCR_EL2.TGE is set
      target/arm: Honour HCR_EL2.TGE and MDCR_EL2.TDE in debug register access checks
      target/arm: Honour HCR_EL2.TGE when raising synchronous exceptions
      target/arm: Provide accessor functions for HCR_EL2.{IMO, FMO, AMO}
      target/arm: Treat SCTLR_EL1.M as if it were zero when HCR_EL2.TGE is set
      target/arm: Improve exception-taken logging
      target/arm: Initialize exc_secure correctly in do_v7m_exception_exit()
      target/arm: Restore M-profile CONTROL.SPSEL before any tailchaining
      target/arm: Implement tailchaining for M profile cores

Richard Henderson (4):
      target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
      target/arm: Fix typo in do_sat_addsub_64
      target/arm: Reorganize SVE WHILE
      target/arm: Fix typo in helper_sve_movz_d

 accel/tcg/softmmu_template.h     |  11 +-
 hw/intc/gic_internal.h           | 282 +++++++++--
 include/exec/exec-all.h          |   2 -
 include/hw/arm/virt.h            |   4 +-
 include/hw/arm/xlnx-zynqmp.h     |   4 +-
 include/hw/intc/arm_gic_common.h |  43 +-
 include/hw/intc/armv7m_nvic.h    |   1 +
 include/migration/vmstate.h      |   3 +
 include/qom/cpu.h                |   6 +
 target/arm/cpu.h                 |  62 ++-
 accel/tcg/cpu-exec.c             |   3 +
 accel/tcg/cputlb.c               | 111 +----
 accel/tcg/translate-all.c        |  23 +-
 exec.c                           |   6 -
 hw/arm/boot.c                    |   8 +-
 hw/arm/virt-acpi-build.c         |   6 +-
 hw/arm/virt.c                    |  52 ++-
 hw/arm/xlnx-zynqmp.c             |  92 +++-
 hw/intc/arm_gic.c                | 987 +++++++++++++++++++++++++++++++--------
 hw/intc/arm_gic_common.c         | 154 ++++--
 hw/intc/arm_gic_kvm.c            |  31 +-
 hw/intc/arm_gicv3_cpuif.c        |  19 +-
 hw/intc/armv7m_nvic.c            |  82 +++-
 memory.c                         |   3 +-
 target/arm/cpu.c                 |   4 +
 target/arm/helper.c              | 127 +++--
 target/arm/op_helper.c           |  14 +
 target/arm/sve_helper.c          |  19 +-
 target/arm/translate-sve.c       |  51 +-
 hw/intc/trace-events             |  12 +-
 30 files changed, 1724 insertions(+), 498 deletions(-)
