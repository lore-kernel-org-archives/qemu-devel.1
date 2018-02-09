Received: from eggs.gnu.org ([2001:4830:134:3::10]:39613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Si-0000vg-Le
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sh-0001s6-Ca
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:24 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sh-0001oy-4S
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:23 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6SZ-0002XO-Ih
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:15 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:02:44 +0000
Message-Id: <20180209110314.11766-1-peter.maydell@linaro.org>
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

Another lump of target-arm patches. I still have some patches in
my to-review queue, but this is a big enough set that I wanted
to send it out.

thanks
-- PMM

The following changes since commit 04bb7fe2bf55bdf66d5b7a5a719b40bbb4048178:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180208' into staging (2018-02-08 17:41:15 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180209

for you to fetch changes up to bbba7757bacc9f890a3f028d328b4b429dbe78ec:

  hw/core/generic-loader: Allow PC to be set on command line (2018-02-09 10:55:40 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support M profile derived exceptions on exception entry and exit
 * Implement AArch64 v8.2 crypto insns (SHA-512, SHA-3, SM3, SM4)
 * Implement working i.MX6 SD controller
 * Various devices preparatory to i.MX7 support
 * Preparatory patches for SVE emulation
 * v8M: Fix bug in implementation of 'TT' insn
 * Give useful error if user tries to use userspace GICv3 with KVM

----------------------------------------------------------------
Andrey Smirnov (10):
      sdhci: Add i.MX specific subtype of SDHCI
      hw: i.MX: Convert i.MX6 to use TYPE_IMX_USDHC
      i.MX: Add code to emulate i.MX7 CCM, PMU and ANALOG IP blocks
      i.MX: Add code to emulate i.MX2 watchdog IP block
      i.MX: Add code to emulate i.MX7 SNVS IP-block
      i.MX: Add code to emulate GPCv2 IP block
      i.MX: Add i.MX7 GPT variant
      i.MX: Add implementation of i.MX7 GPR IP block
      usb: Add basic code to emulate Chipidea USB IP
      hw/arm: Move virt's PSCI DT fixup code to arm/boot.c

Ard Biesheuvel (5):
      target/arm: implement SHA-512 instructions
      target/arm: implement SHA-3 instructions
      target/arm: implement SM3 instructions
      target/arm: implement SM4 instructions
      target/arm: enable user-mode SHA-3, SM3, SM4 and SHA-512 instruction support

Christoffer Dall (1):
      target/arm/kvm: gic: Prevent creating userspace GICv3 with KVM

Peter Maydell (9):
      target/arm: Add armv7m_nvic_set_pending_derived()
      target/arm: Split "get pending exception info" from "acknowledge it"
      target/arm: Add ignore_stackfaults argument to v7m_exception_taken()
      target/arm: Make v7M exception entry stack push check MPU
      target/arm: Make v7m_push_callee_stack() honour MPU
      target/arm: Make exception vector loads honour the SAU
      target/arm: Handle exceptions during exception stack pop
      target/arm/translate.c: Fix missing 'break' for TT insns
      hw/core/generic-loader: Allow PC to be set on command line

Richard Henderson (5):
      target/arm: Expand vector registers for SVE
      target/arm: Add predicate registers for SVE
      target/arm: Add SVE to migration state
      target/arm: Add ZCR_ELx
      target/arm: Add SVE state to TB->FLAGS

 hw/intc/Makefile.objs       |   2 +-
 hw/misc/Makefile.objs       |   4 +
 hw/usb/Makefile.objs        |   1 +
 hw/sd/sdhci-internal.h      |  23 ++
 include/hw/intc/imx_gpcv2.h |  22 ++
 include/hw/misc/imx2_wdt.h  |  33 +++
 include/hw/misc/imx7_ccm.h  | 139 +++++++++++
 include/hw/misc/imx7_gpr.h  |  28 +++
 include/hw/misc/imx7_snvs.h |  35 +++
 include/hw/sd/sdhci.h       |  13 ++
 include/hw/timer/imx_gpt.h  |   1 +
 include/hw/usb/chipidea.h   |  16 ++
 target/arm/cpu.h            | 120 ++++++++--
 target/arm/helper.h         |  12 +
 target/arm/kvm_arm.h        |   4 +
 target/arm/translate.h      |   2 +
 hw/arm/boot.c               |  65 ++++++
 hw/arm/fsl-imx6.c           |   2 +-
 hw/arm/virt.c               |  61 -----
 hw/core/generic-loader.c    |   2 +-
 hw/intc/armv7m_nvic.c       |  98 +++++++-
 hw/intc/imx_gpcv2.c         | 125 ++++++++++
 hw/misc/imx2_wdt.c          |  89 +++++++
 hw/misc/imx7_ccm.c          | 277 ++++++++++++++++++++++
 hw/misc/imx7_gpr.c          | 124 ++++++++++
 hw/misc/imx7_snvs.c         |  83 +++++++
 hw/sd/sdhci.c               | 230 ++++++++++++++++++-
 hw/timer/imx_gpt.c          |  25 ++
 hw/usb/chipidea.c           | 176 ++++++++++++++
 linux-user/elfload.c        |  19 ++
 target/arm/cpu64.c          |   4 +
 target/arm/crypto_helper.c  | 277 +++++++++++++++++++++-
 target/arm/helper.c         | 548 +++++++++++++++++++++++++++++++++++++-------
 target/arm/machine.c        |  88 ++++++-
 target/arm/translate-a64.c  | 350 +++++++++++++++++++++++++++-
 target/arm/translate.c      |   8 +-
 hw/intc/trace-events        |   5 +-
 hw/misc/trace-events        |   4 +
 38 files changed, 2928 insertions(+), 187 deletions(-)
 create mode 100644 include/hw/intc/imx_gpcv2.h
 create mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/misc/imx7_ccm.h
 create mode 100644 include/hw/misc/imx7_gpr.h
 create mode 100644 include/hw/misc/imx7_snvs.h
 create mode 100644 include/hw/usb/chipidea.h
 create mode 100644 hw/intc/imx_gpcv2.c
 create mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/misc/imx7_ccm.c
 create mode 100644 hw/misc/imx7_gpr.c
 create mode 100644 hw/misc/imx7_snvs.c
 create mode 100644 hw/usb/chipidea.c
