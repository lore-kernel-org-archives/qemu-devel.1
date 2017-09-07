Received: from eggs.gnu.org ([2001:4830:134:3::10]:56480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr4-00010O-Jk
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqy-0007eR-Dv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqy-0007cY-5X
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqh-0001Ut-RT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:27:53 +0100
Message-Id: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/31] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Second ARM pull request of this week; this one has my next
set of v8M patches and a handful of more minor stuff from
other people.

thanks
-- PMM

The following changes since commit 8ee5f9b3ecc94e3eb7a8235f4b2c3ec9024807f6:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-09-07 10:45:18 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170907

for you to fetch changes up to c99a55d38dd5b5131f3fcbbaf41828a09ee62544:

  target/arm: Add Jazelle feature (2017-09-07 13:54:55 +0100)

----------------------------------------------------------------
target-arm:
 * cleanups converting to DEFINE_PROP_LINK
 * allwinner-a10: mark as not user-creatable
 * initial patches working towards ARMv8M support
 * implement generating aborts on memory transaction failures
 * make BXJ behave correctly (ie not UNDEF) on ARMv6-and-later

----------------------------------------------------------------
Fam Zheng (6):
      armv7m: Convert bitband.source-memory to DEFINE_PROP_LINK
      armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
      gicv3: Convert to DEFINE_PROP_LINK
      xlnx_zynqmp: Convert to DEFINE_PROP_LINK
      xilinx_axienet: Convert to DEFINE_PROP_LINK
      xilinx_axidma: Convert to DEFINE_PROP_LINK

Peter Maydell (23):
      target/arm: Implement ARMv8M's PMSAv8 registers
      target/arm: Implement new PMSAv8 behaviour
      target/arm: Add state field, feature bit and migration for v8M secure state
      target/arm: Register second AddressSpace for secure v8M CPUs
      target/arm: Add MMU indexes for secure v8M
      target/arm: Make BASEPRI register banked for v8M
      target/arm: Make PRIMASK register banked for v8M
      target/arm: Make FAULTMASK register banked for v8M
      target/arm: Make CONTROL register banked for v8M
      nvic: Add NS alias SCS region
      target/arm: Make VTOR register banked for v8M
      target/arm: Make MPU_MAIR0, MPU_MAIR1 registers banked for v8M
      target/arm: Make MPU_RBAR, MPU_RLAR banked for v8M
      target/arm: Make MPU_RNR register banked for v8M
      target/arm: Make MPU_CTRL register banked for v8M
      target/arm: Make CCR register banked for v8M
      target/arm: Make MMFAR banked for v8M
      target/arm: Make CFSR register banked for v8M
      target/arm: Move regime_is_secure() to target/arm/internals.h
      target/arm: Implement BXNS, and banked stack pointers
      boards.h: Define new flag ignore_memory_transaction_failures
      hw/arm: Set ignore_memory_transaction_failures for most ARM boards
      target/arm: Implement new do_transaction_failed hook

Portia Stephens (1):
      target/arm: Add Jazelle feature

Thomas Huth (1):
      hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_creatable = false

 include/hw/boards.h           |  11 ++
 include/hw/intc/armv7m_nvic.h |   1 +
 include/qom/cpu.h             |   7 +-
 target/arm/cpu.h              | 101 ++++++++++++--
 target/arm/helper.h           |   2 +
 target/arm/internals.h        |  36 +++++
 target/arm/translate.h        |   1 +
 hw/arm/allwinner-a10.c        |   2 +
 hw/arm/armv7m.c               |  16 +--
 hw/arm/aspeed.c               |   3 +
 hw/arm/collie.c               |   1 +
 hw/arm/cubieboard.c           |   1 +
 hw/arm/digic_boards.c         |   1 +
 hw/arm/exynos4_boards.c       |   2 +
 hw/arm/gumstix.c              |   2 +
 hw/arm/highbank.c             |   2 +
 hw/arm/imx25_pdk.c            |   1 +
 hw/arm/integratorcp.c         |   1 +
 hw/arm/kzm.c                  |   1 +
 hw/arm/mainstone.c            |   1 +
 hw/arm/musicpal.c             |   1 +
 hw/arm/netduino2.c            |   1 +
 hw/arm/nseries.c              |   2 +
 hw/arm/omap_sx1.c             |   2 +
 hw/arm/palm.c                 |   1 +
 hw/arm/raspi.c                |   1 +
 hw/arm/realview.c             |   4 +
 hw/arm/sabrelite.c            |   1 +
 hw/arm/spitz.c                |   4 +
 hw/arm/stellaris.c            |   2 +
 hw/arm/tosa.c                 |   1 +
 hw/arm/versatilepb.c          |   2 +
 hw/arm/vexpress.c             |   1 +
 hw/arm/xilinx_zynq.c          |   1 +
 hw/arm/xlnx-ep108.c           |   2 +
 hw/arm/xlnx-zynqmp.c          |   7 +-
 hw/arm/z2.c                   |   1 +
 hw/dma/xilinx_axidma.c        |  16 +--
 hw/intc/arm_gicv3_its_kvm.c   |  19 +--
 hw/intc/armv7m_nvic.c         | 291 ++++++++++++++++++++++++++++++++------
 hw/net/xilinx_axienet.c       |  16 +--
 qom/cpu.c                     |  16 +++
 target/arm/cpu.c              |  88 +++++++++---
 target/arm/helper.c           | 315 +++++++++++++++++++++++++++++++++---------
 target/arm/machine.c          | 105 ++++++++++++--
 target/arm/op_helper.c        |  43 ++++++
 target/arm/translate.c        |  54 +++++++-
 scripts/device-crash-test     |   1 -
 48 files changed, 978 insertions(+), 213 deletions(-)
