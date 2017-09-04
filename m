Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dou7U-0007Cm-LD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dou7P-0007EX-Jy
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:21:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dou7P-0007BH-D2
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:20:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dou7N-0005tX-DJ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:20:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 17:21:15 +0100
Message-Id: <1504542075-28447-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/33] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Third time's the charm...

-- PMM

The following changes since commit 98bfaac788be0ca63d7d010c8d4ba100ff1d8278:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-09-01-v3' into staging (2017-09-04 13:28:09 +0100)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170904-2

for you to fetch changes up to 7229ec5825df6b933f150b54a8a2bedd2de1864c:

  arm_gicv3_kvm: Fix compile warning (2017-09-04 17:13:53 +0100)

----------------------------------------------------------------
target-arm:
 * collection of M profile cleanups and minor bugfixes
 * loader: handle ELF files with overlapping zero-init data
 * virt: allow PMU instantiation with userspace irqchip
 * wdt_aspeed: Add support for the reset width register
 * cpu: Define new cpu_transaction_failed() hook
 * Mark some SoC devices as not user-creatable
 * arm: Fix aa64 ldp register writeback
 * arm_gicv3_kvm: Fix compile warning

----------------------------------------------------------------
Andrew Jeffery (2):
      watchdog: wdt_aspeed: Add support for the reset width register
      aspeed_soc: Propagate silicon-rev to watchdog

Andrew Jones (4):
      hw/arm/virt: add pmu interrupt state
      target/arm/kvm: pmu: split init and set-irq stages
      hw/arm/virt: allow pmu instantiation with userspace irqchip
      target/arm/kvm: pmu: improve error handling

Peter Maydell (22):
      target/arm: Use MMUAccessType enum rather than int
      target/arm: Don't trap WFI/WFE for M profile
      target/arm: Consolidate PMSA handling in get_phys_addr()
      target/arm: Tighten up Thumb decode where new v8M insns will be
      hw/intc/armv7m_nvic.c: Remove out of date comment
      target/arm: Remove incorrect comment about MPU_CTRL
      target/arm: Fix outdated comment about exception exit
      target/arm: Define and use XPSR bit masks
      target/arm: Don't store M profile PRIMASK and FAULTMASK in daif
      target/arm: Don't use cpsr_write/cpsr_read to transfer M profile XPSR
      target/arm: Make arm_cpu_dump_state() handle the M-profile XPSR
      target/arm: Don't calculate lr in arm_v7m_cpu_do_interrupt() until needed
      target/arm: Create and use new function arm_v7m_is_handler_mode()
      armv7m_nvic.h: Move from include/hw/arm to include/hw/intc
      nvic: Implement "user accesses BusFault" SCS region behaviour
      loader: Handle ELF files with overlapping zero-initialized data
      loader: Ignore zero-sized ELF segments
      memory.h: Move MemTxResult type to memattrs.h
      cpu: Define new cpu_transaction_failed() hook
      cputlb: Support generating CPU exceptions on memory transaction failures
      target/arm: Factor out fault delivery code
      target/arm: Allow deliver_fault() caller to specify EA bit

Philippe Mathieu-Daudé (1):
      hw/arm: use defined type name instead of hard-coded string

Pranith Kumar (1):
      arm_gicv3_kvm: Fix compile warning

Richard Henderson (1):
      target/arm: Fix aa64 ldp register writeback

Thomas Huth (2):
      hw/arm/aspeed_soc: Mark devices as user_creatable = false
      hw/arm/digic: Mark device with user_creatable = false

 include/exec/memattrs.h                |  10 +++
 include/exec/memory.h                  |  10 ---
 include/hw/arm/armv7m.h                |   2 +-
 include/hw/elf_ops.h                   |  72 +++++++++++++++++--
 include/hw/{arm => intc}/armv7m_nvic.h |   0
 include/hw/watchdog/wdt_aspeed.h       |   2 +
 include/qom/cpu.h                      |  22 ++++++
 softmmu_template.h                     |   4 +-
 target/arm/cpu.h                       |  56 +++++++++++----
 target/arm/internals.h                 |   5 +-
 target/arm/kvm_arm.h                   |   9 ++-
 accel/tcg/cputlb.c                     |  32 ++++++++-
 hw/arm/armv7m.c                        |   4 +-
 hw/arm/aspeed_soc.c                    |   4 ++
 hw/arm/digic.c                         |   2 +
 hw/arm/exynos4210.c                    |   4 +-
 hw/arm/highbank.c                      |  11 +--
 hw/arm/realview.c                      |   6 +-
 hw/arm/vexpress.c                      |   6 +-
 hw/arm/virt.c                          |  12 +++-
 hw/arm/xilinx_zynq.c                   |  14 ++--
 hw/intc/arm_gicv3_kvm.c                |   2 +-
 hw/intc/armv7m_nvic.c                  |  68 +++++++++++-------
 hw/watchdog/wdt_aspeed.c               |  93 ++++++++++++++++++++++---
 target/arm/cpu.c                       |   7 +-
 target/arm/helper.c                    | 124 ++++++++++++++++-----------------
 target/arm/kvm.c                       |   6 +-
 target/arm/kvm32.c                     |   8 ++-
 target/arm/kvm64.c                     |  63 ++++++++++-------
 target/arm/machine.c                   |  54 +++++++++++++-
 target/arm/op_helper.c                 | 121 +++++++++++++++++---------------
 target/arm/translate-a64.c             |  29 ++++----
 target/arm/translate.c                 | 106 +++++++++++++++++++++-------
 33 files changed, 677 insertions(+), 291 deletions(-)
 rename include/hw/{arm => intc}/armv7m_nvic.h (100%)
