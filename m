Received: from eggs.gnu.org ([2001:4830:134:3::10]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XR-0003AW-K3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XP-0003Cr-7C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XO-00033w-Rh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4X9-000522-5l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:08 +0100
Message-Id: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
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

ARM queue: mostly patches from me, but also the Smartfusion2 board.

thanks
-- PMM

The following changes since commit 9ee660e7c138595224b65ddc1c5712549f0a278c:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170921' into staging (2017-09-21 14:40:32 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170921

for you to fetch changes up to 6d262dcb7d108eda93813574c2061398084dc795:

  msf2: Add Emcraft's Smartfusion2 SOM kit (2017-09-21 16:36:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * more preparatory work for v8M support
 * convert some omap devices away from old_mmio
 * remove out of date ARM ARM section references in comments
 * add the Smartfusion2 board

----------------------------------------------------------------
Peter Maydell (26):
      target/arm: Implement MSR/MRS access to NS banked registers
      nvic: Add banked exception states
      nvic: Add cached vectpending_is_s_banked state
      nvic: Add cached vectpending_prio state
      nvic: Implement AIRCR changes for v8M
      nvic: Make ICSR.RETTOBASE handle banked exceptions
      nvic: Implement NVIC_ITNS<n> registers
      nvic: Handle banked exceptions in nvic_recompute_state()
      nvic: Make set_pending and clear_pending take a secure parameter
      nvic: Make SHPR registers banked
      nvic: Compare group priority for escalation to HF
      nvic: In escalation to HardFault, support HF not being priority -1
      nvic: Implement v8M changes to fixed priority exceptions
      nvic: Disable the non-secure HardFault if AIRCR.BFHFNMINS is clear
      nvic: Handle v8M changes in nvic_exec_prio()
      target/arm: Handle banking in negative-execution-priority check in cpu_mmu_index()
      nvic: Make ICSR banked for v8M
      nvic: Make SHCSR banked for v8M
      nvic: Support banked exceptions in acknowledge and complete
      target/arm: Remove out of date ARM ARM section references in A64 decoder
      hw/arm/palm.c: Don't use old_mmio for static_ops
      hw/gpio/omap_gpio.c: Don't use old_mmio
      hw/timer/omap_synctimer.c: Don't use old_mmio
      hw/timer/omap_gptimer: Don't use old_mmio
      hw/i2c/omap_i2c.c: Don't use old_mmio
      hw/arm/omap2.c: Don't use old_mmio

Subbaraya Sundeep (5):
      msf2: Add Smartfusion2 System timer
      msf2: Microsemi Smartfusion2 System Register block
      msf2: Add Smartfusion2 SPI controller
      msf2: Add Smartfusion2 SoC
      msf2: Add Emcraft's Smartfusion2 SOM kit

 hw/arm/Makefile.objs            |   1 +
 hw/misc/Makefile.objs           |   1 +
 hw/ssi/Makefile.objs            |   1 +
 hw/timer/Makefile.objs          |   1 +
 include/hw/arm/msf2-soc.h       |  67 +++
 include/hw/intc/armv7m_nvic.h   |  33 +-
 include/hw/misc/msf2-sysreg.h   |  77 ++++
 include/hw/ssi/mss-spi.h        |  58 +++
 include/hw/timer/mss-timer.h    |  64 +++
 target/arm/cpu.h                |  62 ++-
 hw/arm/msf2-soc.c               | 238 +++++++++++
 hw/arm/msf2-som.c               | 105 +++++
 hw/arm/omap2.c                  |  49 ++-
 hw/arm/palm.c                   |  30 +-
 hw/gpio/omap_gpio.c             |  26 +-
 hw/i2c/omap_i2c.c               |  44 +-
 hw/intc/armv7m_nvic.c           | 913 ++++++++++++++++++++++++++++++++++------
 hw/misc/msf2-sysreg.c           | 160 +++++++
 hw/ssi/mss-spi.c                | 404 ++++++++++++++++++
 hw/timer/mss-timer.c            | 289 +++++++++++++
 hw/timer/omap_gptimer.c         |  49 ++-
 hw/timer/omap_synctimer.c       |  35 +-
 target/arm/cpu.c                |   7 +
 target/arm/helper.c             | 142 ++++++-
 target/arm/translate-a64.c      | 227 +++++-----
 default-configs/arm-softmmu.mak |   1 +
 hw/intc/trace-events            |  13 +-
 hw/misc/trace-events            |   5 +
 28 files changed, 2735 insertions(+), 367 deletions(-)
 create mode 100644 include/hw/arm/msf2-soc.h
 create mode 100644 include/hw/misc/msf2-sysreg.h
 create mode 100644 include/hw/ssi/mss-spi.h
 create mode 100644 include/hw/timer/mss-timer.h
 create mode 100644 hw/arm/msf2-soc.c
 create mode 100644 hw/arm/msf2-som.c
 create mode 100644 hw/misc/msf2-sysreg.c
 create mode 100644 hw/ssi/mss-spi.c
 create mode 100644 hw/timer/mss-timer.c
