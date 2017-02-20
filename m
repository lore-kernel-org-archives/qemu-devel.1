Received: from eggs.gnu.org ([2001:4830:134:3::10]:40417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0q-0006fe-BX
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0p-0003Uc-DY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 15:35:54 +0000
Message-Id: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/11] ARMv7M: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

This patch series attempts to bring the v7M code
up to something resembling modern practice for
QEMU devices:
 * proper QOM object for the armv7m "container"
   which holds the CPU, NVIC, etc cpu-internal devices"
 * split the systick out into its own device
 * use memory region links rather than having the
   NVIC and bitband map themselves directly into the
   system memory space
 * have stm32f205 create the armv7m container via the
   QOM APIs rather than armv7m_init(), since that fits better
   with the rest of that SoC's code

These patches sit on top of the NVIC rewrite patchset;
you can find a git branch with the whole lot at:

  https://git.linaro.org/people/peter.maydell/qemu-arm.git v7m-qomify

thanks
-- PMM

Peter Maydell (11):
  armv7m: Abstract out the "load kernel" code
  armv7m: Move NVICState struct definition into header
  armv7m: QOMify the armv7m container
  armv7m: Use QOMified armv7m object in armv7m_init()
  armv7m: Make ARMv7M object take memory region link
  armv7m: Make NVIC expose a memory region rather than mapping itself
  armv7m: Make bitband device take the address space to access
  armv7m: Don't put core v7M devices under CONFIG_STELLARIS
  armv7m: Split systick out from NVIC
  stm32f205: Create armv7m object without using armv7m_init()
  stm32f205: Rename 'nvic' local to 'armv7m'

 hw/intc/Makefile.objs             |   2 +-
 hw/timer/Makefile.objs            |   1 +
 include/hw/arm/arm.h              |  12 ++
 include/hw/arm/armv7m.h           |  63 +++++++
 include/hw/arm/armv7m_nvic.h      |  62 +++++++
 include/hw/arm/stm32f205_soc.h    |   4 +-
 include/hw/timer/armv7m_systick.h |  34 ++++
 hw/arm/armv7m.c                   | 380 +++++++++++++++++++++++++-------------
 hw/arm/netduino2.c                |   7 +-
 hw/arm/stm32f205_soc.c            |  28 ++-
 hw/intc/armv7m_nvic.c             | 214 ++++-----------------
 hw/timer/armv7m_systick.c         | 239 ++++++++++++++++++++++++
 default-configs/arm-softmmu.mak   |   2 +
 hw/timer/trace-events             |   6 +
 14 files changed, 733 insertions(+), 321 deletions(-)
 create mode 100644 include/hw/arm/armv7m.h
 create mode 100644 include/hw/arm/armv7m_nvic.h
 create mode 100644 include/hw/timer/armv7m_systick.h
 create mode 100644 hw/timer/armv7m_systick.c

-- 
2.7.4
