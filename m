Received: from eggs.gnu.org ([2001:4830:134:3::10]:52050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3x-0007Oc-4A
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3v-0008Te-V4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3v-0008Ns-N2
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:31 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3n-0005ar-Ph
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:37:56 +0000
Message-Id: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/26] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue, various patches accumulated over the Christmas break.

-- PMM

The following changes since commit 612061b277915fadd80631eb7a6926f48a110c44:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-10' into staging (2018-01-11 11:52:40 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180111

for you to fetch changes up to 0cf09852015e47a5fbb974ff7ac320366afd21ee:

  hw/intc/arm_gic: reserved register addresses are RAZ/WI (2018-01-11 13:25:40 +0000)

----------------------------------------------------------------
target-arm queue:
 * add aarch64_be linux-user target
 * Virt: ACPI: fix qemu assert due to re-assigned table data address
 * imx_fec: various bug fixes and cleanups
 * hw/timer/pxa2xx_timer: replace hw_error() -> qemu_log_mask()
 * hw/sd/pxa2xx_mmci: add read/write() trace events
 * linux-user/arm/nwfpe: Check coprocessor number for FPA emulation
 * target/arm: Make disas_thumb2_insn() generate its own UNDEF exceptions
 * hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
 * hw/intc/arm_gic: reserved register addresses are RAZ/WI

----------------------------------------------------------------
Andrey Smirnov (11):
      imx_fec: Do not link to netdev
      imx_fec: Refactor imx_eth_enable_rx()
      imx_fec: Change queue flushing heuristics
      imx_fec: Move Tx frame buffer away from the stack
      imx_fec: Use ENET_FTRL to determine truncation length
      imx_fec: Use MIN instead of explicit ternary operator
      imx_fec: Emulate SHIFT16 in ENETx_RACC
      imx_fec: Add support for multiple Tx DMA rings
      imx_fec: Use correct length for packet size
      imx_fec: Fix a typo in imx_enet_receive()
      imx_fec: Reserve full FSL_IMX25_FEC_SIZE page for the register file

Michael Weiser (8):
      linux-user: Add support for big-endian aarch64
      linux-user: Add separate aarch64_be uname
      linux-user: Fix endianess of aarch64 signal trampoline
      configure: Add aarch64_be-linux-user target
      linux-user: Add aarch64_be magic numbers to qemu-binfmt-conf.sh
      linux-user: Separate binfmt arm CPU families
      linux-user: Activate armeb handler registration
      target/arm: Fix stlxp for aarch64_be

Peter Maydell (4):
      linux-user/arm/nwfpe: Check coprocessor number for FPA emulation
      target/arm: Make disas_thumb2_insn() generate its own UNDEF exceptions
      hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
      hw/intc/arm_gic: reserved register addresses are RAZ/WI

Philippe Mathieu-Daudé (2):
      hw/timer/pxa2xx_timer: replace hw_error() -> qemu_log_mask()
      hw/sd/pxa2xx_mmci: add read/write() trace events

Zhaoshenglong (1):
      Virt: ACPI: fix qemu assert due to re-assigned table data address

 configure                                 |   5 +-
 include/hw/arm/fsl-imx25.h                |   1 -
 include/hw/net/imx_fec.h                  |  27 +++-
 linux-user/aarch64/target_syscall.h       |   4 +
 hw/arm/fsl-imx6.c                         |   1 +
 hw/arm/virt-acpi-build.c                  |  18 ++-
 hw/intc/arm_gic.c                         |   5 +-
 hw/intc/arm_gicv3_dist.c                  |  13 ++
 hw/intc/arm_gicv3_its_common.c            |   8 +-
 hw/intc/arm_gicv3_redist.c                |  13 ++
 hw/net/imx_fec.c                          | 210 +++++++++++++++++++++++-------
 hw/sd/pxa2xx_mmci.c                       |  78 +++++++----
 hw/timer/pxa2xx_timer.c                   |  17 ++-
 linux-user/arm/nwfpe/fpa11.c              |   9 ++
 linux-user/main.c                         |   6 +
 linux-user/signal.c                       |  10 +-
 target/arm/helper-a64.c                   |   7 +-
 target/arm/translate.c                    |  23 ++--
 default-configs/aarch64_be-linux-user.mak |   1 +
 hw/sd/trace-events                        |   4 +
 scripts/qemu-binfmt-conf.sh               |  15 ++-
 21 files changed, 356 insertions(+), 119 deletions(-)
 create mode 100644 default-configs/aarch64_be-linux-user.mak
