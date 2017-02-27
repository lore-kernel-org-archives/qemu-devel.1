Received: from eggs.gnu.org ([2001:4830:134:3::10]:52273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfl-0002Sn-Ii
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfh-0001xO-IM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:21 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfh-0001uO-7K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfQ-0002II-Fj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:00 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:29 +0000
Message-Id: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/30] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queu; includes all the NVIC rewrite patches.
The QOMify-armv7m patchset hasn't got enough review just
yet but I may be able to sneak it in before freeze
tomorrow if it gets review. Didn't want to hold this lot
up waiting, anyway.

thanks
-- PMM


The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170227

for you to fetch changes up to 94d5bcf5a7f3799660b62098a5183f161aad0601:

  hw/arm/exynos: Fix proper mapping of CPUs by providing real cluster ID (2017-02-27 17:23:16 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi2: implement RNG module, GPIO and new SD card controller
   (sufficient to boot new raspbian kernels)
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
Clement Deschamps (4):
      bcm2835_sdhost: add bcm2835 sdhost controller
      hw/sd: add card-reparenting function
      bcm2835_gpio: add bcm2835 gpio controller
      bcm2835: add sdhost and gpio controllers

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

 hw/gpio/Makefile.objs                |   1 +
 hw/misc/Makefile.objs                |   3 +-
 hw/sd/Makefile.objs                  |   1 +
 hw/intc/gic_internal.h               |   7 +-
 include/hw/arm/bcm2835_peripherals.h |   6 +
 include/hw/arm/virt.h                |   1 +
 include/hw/gpio/bcm2835_gpio.h       |  39 ++
 include/hw/misc/bcm2835_rng.h        |  27 ++
 include/hw/sd/bcm2835_sdhost.h       |  48 ++
 include/hw/sd/sd.h                   |  11 +
 target/arm/cpu.h                     |  23 +-
 cputlb.c                             |  15 +-
 hw/arm/bcm2835_peripherals.c         |  58 ++-
 hw/arm/exynos4210.c                  |  18 +
 hw/arm/virt.c                        |  32 +-
 hw/gpio/bcm2835_gpio.c               | 353 ++++++++++++++
 hw/intc/arm_gic.c                    |  31 +-
 hw/intc/arm_gic_common.c             |  23 +-
 hw/intc/armv7m_nvic.c                | 885 ++++++++++++++++++++++++++++-------
 hw/misc/bcm2835_rng.c                | 149 ++++++
 hw/misc/exynos4210_clk.c             | 164 +++++++
 hw/sd/bcm2835_sdhost.c               | 429 +++++++++++++++++
 hw/sd/core.c                         |  30 ++
 hw/sd/sdhci.c                        |  25 +-
 hw/timer/imx_gpt.c                   |  33 +-
 linux-user/main.c                    |   1 +
 target/arm/cpu.c                     |  16 +-
 target/arm/helper.c                  | 245 +++++++---
 target/arm/translate-a64.c           |  12 +
 target/arm/translate.c               |   8 +-
 hw/intc/trace-events                 |  15 +
 31 files changed, 2376 insertions(+), 333 deletions(-)
 create mode 100644 include/hw/gpio/bcm2835_gpio.h
 create mode 100644 include/hw/misc/bcm2835_rng.h
 create mode 100644 include/hw/sd/bcm2835_sdhost.h
 create mode 100644 hw/gpio/bcm2835_gpio.c
 create mode 100644 hw/misc/bcm2835_rng.c
 create mode 100644 hw/misc/exynos4210_clk.c
 create mode 100644 hw/sd/bcm2835_sdhost.c
