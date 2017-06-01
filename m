Received: from eggs.gnu.org ([2001:4830:134:3::10]:35049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcT-00012R-2I
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcS-00066k-2A
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcR-00064g-Q9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:43 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcK-0007N0-FR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:08 +0100
Message-Id: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/27] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM pullreq; contains some patches that arrived while I
was on holiday, plus the series I sent off before going
away, which got reviewed while I was away.

thanks
-- PMM


The following changes since commit c077a998eb3fcae2d048e3baeb5bc592d30fddde:

  Merge remote-tracking branch 'remotes/riku/tags/pull-linux-user-20170531' into staging (2017-06-01 15:50:40 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170601

for you to fetch changes up to cdc58be430b0bdeaef282e2e70f8135ae531616d:

  hw/arm/virt: fdt: generate distance-map when needed (2017-06-01 17:27:07 +0100)

----------------------------------------------------------------
target-arm queue:
 * virt: numa: provide ACPI distance info when needed
 * aspeed: fix i2c controller bugs
 * aspeed: add temperature sensor device
 * M profile: support MPU
 * gicv3: fix mishandling of BPR1, VBPR1
 * load_uboot_image: don't assume a full header read
 * libvixl: Correct build failures on NetBSD

----------------------------------------------------------------
Andrew Jones (3):
      load_uboot_image: don't assume a full header read
      hw/arm/virt-acpi-build: build SLIT when needed
      hw/arm/virt: fdt: generate distance-map when needed

Cédric Le Goater (6):
      aspeed/i2c: improve command handling
      aspeed/i2c: handle LAST command under the RX command
      aspeed/i2c: introduce a state machine
      aspeed: add some I2C devices to the Aspeed machines
      hw/misc: add a TMP42{1,2,3} device model
      aspeed: add a temp sensor device on I2C bus 3

Kamil Rytarowski (1):
      libvixl: Correct build failures on NetBSD

Michael Davidsaver (4):
      armv7m: Improve "-d mmu" tracing for PMSAv7 MPU
      armv7m: Implement M profile default memory map
      armv7m: Classify faults as MemManage or BusFault
      arm: add MPU support to M profile CPUs

Peter Maydell (12):
      hw/intc/arm_gicv3_cpuif: Fix reset value for VMCR_EL2.VBPR1
      hw/intc/arm_gicv3_cpuif: Don't let BPR be set below its minimum
      hw/intc/arm_gicv3_cpuif: Fix priority masking for NS BPR1
      arm: Use the mmu_idx we're passed in arm_cpu_do_unaligned_access()
      arm: Add support for M profile CPUs having different MMU index semantics
      arm: Use different ARMMMUIdx values for M profile
      arm: Clean up handling of no-MPU PMSA CPUs
      arm: Don't clear ARM_FEATURE_PMSA for no-mpu configs
      arm: Don't let no-MPU PMSA cores write to SCTLR.M
      arm: Remove unnecessary check on cpu->pmsav7_dregion
      arm: All M profile cores are PMSA
      arm: Implement HFNMIENA support for M profile MPU

Wei Huang (1):
      target/arm: clear PMUVER field of AA64DFR0 when vPMU=off

 disas/libvixl/Makefile.objs     |   3 +
 hw/misc/Makefile.objs           |   1 +
 target/arm/cpu.h                | 118 ++++++++++--
 target/arm/translate.h          |   2 +-
 hw/arm/aspeed.c                 |  36 ++++
 hw/arm/virt-acpi-build.c        |   4 +
 hw/arm/virt.c                   |  21 +++
 hw/core/loader.c                |   3 +-
 hw/i2c/aspeed_i2c.c             |  65 ++++++-
 hw/intc/arm_gicv3_cpuif.c       |  50 ++++-
 hw/intc/armv7m_nvic.c           | 104 +++++++++++
 hw/misc/tmp421.c                | 401 ++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c                |  28 ++-
 target/arm/helper.c             | 338 ++++++++++++++++++++++-----------
 target/arm/machine.c            |   7 +-
 target/arm/op_helper.c          |   3 +-
 target/arm/translate-a64.c      |  18 +-
 target/arm/translate.c          |  14 +-
 default-configs/arm-softmmu.mak |   1 +
 19 files changed, 1060 insertions(+), 157 deletions(-)
 create mode 100644 hw/misc/tmp421.c
