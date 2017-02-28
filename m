Received: from eggs.gnu.org ([2001:4830:134:3::10]:40196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cih66-00005x-By
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cih65-0000Sv-6l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cih64-0000Rx-WA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cih63-0003Ch-88
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:41:39 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 12:41:38 +0000
Message-Id: <1488285698-21781-1-git-send-email-peter.maydell@linaro.org>
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

v1->v2 changes: drop the sd card-reparenting patch
and the 2 raspi2 patches that depend on it.

-- PMM

The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170228

for you to fetch changes up to f3a6339a5bbc160d327299c67bb68c6d07fa4a61:

  hw/arm/exynos: Fix proper mapping of CPUs by providing real cluster ID (2017-02-28 12:08:20 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi2: implement RNG module
 * raspi2: implement new SD card controller (but don't wire it up)
 * sdhci: bugfixes for block transfers
 * virt: fix cpu object reference leak
 * Add missing fp_access_check() to aarch64 crypto instructions
 * cputlb: Don't assume do_unassigned_access() never returns
 * virt: Add a user option to disallow ITS instantiation
 * i.MX timers: fix reset handling
 * ARMv7M NVIC: rewrite to fix broken priority handling and masking
 * exynos: Fix proper mapping of CPUs by providing real cluster ID
 * exynos: Fix Linux kernel division by zero for PLLs

----------------------------------------------------------------
Clement Deschamps (1):
      bcm2835_sdhost: add bcm2835 sdhost controller

Eric Auger (1):
      hw/arm/virt: Add a user option to disallow ITS instantiation

Igor Mammedov (1):
      hw/arm/virt: fix cpu object reference leak

Krzysztof Kozlowski (2):
      hw/arm/exynos: Fix Linux kernel division by zero for PLLs
      hw/arm/exynos: Fix proper mapping of CPUs by providing real cluster ID

Kurban Mallachiev (1):
      ARM i.MX timers: fix reset handling

Marcin Chojnacki (1):
      target-arm: Implement BCM2835 hardware RNG

Michael Davidsaver (5):
      armv7m: Rewrite NVIC to not use any GIC code
      arm: gic: Remove references to NVIC
      armv7m: Escalate exceptions to HardFault if necessary
      armv7m: Simpler and faster exception start
      armv7m: VECTCLRACTIVE and VECTRESET are UNPREDICTABLE

Nick Reilly (1):
      Add missing fp_access_check() to aarch64 crypto instructions

Peter Maydell (10):
      bcm2835_rng: Use qcrypto_random_bytes() rather than rand()
      cputlb: Don't assume do_unassigned_access() never returns
      armv7m: Rename nvic_state to NVICState
      armv7m: Implement reading and writing of PRIGROUP
      armv7m: Fix condition check for taking exceptions
      armv7m: Remove unused armv7m_nvic_acknowledge_irq() return value
      armv7m: Extract "exception taken" code into functions
      armv7m: Check exception return consistency
      armv7m: Raise correct kind of UsageFault for attempts to execute ARM code
      armv7m: Allow SHCSR writes to change pending and active bits

Prasad J Pandit (4):
      sd: sdhci: mask transfer mode register value
      sd: sdhci: check transfer mode register in multi block transfer
      sd: sdhci: conditionally invoke multi block transfer
      sd: sdhci: Remove block count enable check in single block transfers

 hw/misc/Makefile.objs                |   3 +-
 hw/sd/Makefile.objs                  |   1 +
 hw/intc/gic_internal.h               |   7 +-
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/arm/virt.h                |   1 +
 include/hw/misc/bcm2835_rng.h        |  27 ++
 include/hw/sd/bcm2835_sdhost.h       |  48 ++
 target/arm/cpu.h                     |  23 +-
 cputlb.c                             |  15 +-
 hw/arm/bcm2835_peripherals.c         |  15 +
 hw/arm/exynos4210.c                  |  18 +
 hw/arm/virt.c                        |  32 +-
 hw/intc/arm_gic.c                    |  31 +-
 hw/intc/arm_gic_common.c             |  23 +-
 hw/intc/armv7m_nvic.c                | 885 ++++++++++++++++++++++++++++-------
 hw/misc/bcm2835_rng.c                | 149 ++++++
 hw/misc/exynos4210_clk.c             | 164 +++++++
 hw/sd/bcm2835_sdhost.c               | 429 +++++++++++++++++
 hw/sd/sdhci.c                        |  25 +-
 hw/timer/imx_gpt.c                   |  33 +-
 linux-user/main.c                    |   1 +
 target/arm/cpu.c                     |  16 +-
 target/arm/helper.c                  | 245 +++++++---
 target/arm/translate-a64.c           |  12 +
 target/arm/translate.c               |   8 +-
 hw/intc/trace-events                 |  15 +
 26 files changed, 1897 insertions(+), 331 deletions(-)
 create mode 100644 include/hw/misc/bcm2835_rng.h
 create mode 100644 include/hw/sd/bcm2835_sdhost.h
 create mode 100644 hw/misc/bcm2835_rng.c
 create mode 100644 hw/misc/exynos4210_clk.c
 create mode 100644 hw/sd/bcm2835_sdhost.c
