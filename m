Received: from eggs.gnu.org ([209.51.188.92]:35766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefQ-0000qs-0A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefM-0002WU-Ej
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefL-0002UQ-TX
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p6so11831173wmc.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:50:55 +0000
Message-Id: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/23] arm: Implement MPS2 AN521 FPGA image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset implements a model of the AN521 FPGA image for the
MPS2 dev board. The AN521 is similar to our existing AN505 model,
except that it is based on the SSE-200 Subsystem for Embedded
rather than the older IoTKit. The SSE-200 is essentially an
updated version of the IoTKit with a few extra devices and
two Cortex-M33 CPUs. Most of the patchset is enhancing our
IoTKit emulation to add the SSE-200 functionality.
The SSE-200 is the part that I'm most interested in, because
the eventual aim is a model of the Musca-B1 devboard, which
also uses the SSE-200:
https://developer.arm.com/products/system-design/development-boards/iot-test-chips-and-boards/musca-b-test-chip-board
The MPS2-AN521 is a convenient stepping stone that allows us to
test the SSE-200 parts.

Patchset structure:
 * patches 1-3 fix some armv7m limitations so we can create
   multiple Cortex-M33s in one board with one starting powered off
 * patches 4-7 rename the IoTKit code/files to ARMSSE and refactor
   it to have an abstract base class that will be subclassed by
   the IoTKit and SSE-200 devices
 * patches 8-20 add the various extra/different SSE-200 features
   (or unimplemented-device stubs for them) governed by feature
   switches
 * patch 21 adds the SSE-200 model which sets those feature switches
 * patches 22 and 23 make the minor mps2-tz changes needed to add
   the AN521 image

Currently unimplemented features:
 * the iotkit-sysctl device has some extra registers on SSE-200:
   FCLK_DIV, SYSCLK_DI, CLOCK_FORCE, INITSVRTOR1, NMI_ENABLE, EWCTRL,
   PDCM_PD_SYS_SENSE, PDCM_PD_SRAM[0123]_SENSE (these will fall into
   the existing bad-offset logging so we can identify if a guest
   is trying to use them)
 * the icache control, CPU local security control register bank,
   the Message Handling Units (MHUs) and Power Policy Units (PPUs)
   are all stubbed out
 * the crypto unit and its non-volatile memory are optional, and
   we do not implement it
 * no CPU power control is implemented -- notably this means that there
   is no way for the guest to ever power up CPU 1, so it will sit
   permanently dormant. Guest images that only use CPU 0 will work fine.

Before we fix the last of those we (ideally) need the "heterogenous
CPU support" patchset to land.

This image can run the Arm Trusted Firmware M built for AN521.

AN521 docs:
http://infocenter.arm.com/help/topic/com.arm.doc.dai0521c/index.html

SSE-200 TRM:
http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf

thanks
-- PMM

Peter Maydell (23):
  armv7m: Don't assume the NVIC's CPU is CPU 0
  armv7m: Make cpu object a child of the armv7m container
  armv7m: Pass through start-powered-off CPU property
  hw/arm/iotkit: Rename IoTKit to ARMSSE
  hw/arm/iotkit: Refactor into abstract base class and subclass
  hw/arm/iotkit: Rename 'iotkit' local variables and functions
  hw/arm/iotkit: Rename files to hw/arm/armsse.[ch]
  hw/misc/iotkit-secctl: Support 4 internal MPCs
  hw/arm/armsse: Make number of SRAM banks parameterised
  hw/arm/armsse: Make SRAM bank size configurable
  hw/arm/armsse: Support dual-CPU configuration
  hw/arm/armsse: Give each CPU its own view of memory
  hw/arm/armsse: Put each CPU in its own cluster object
  iotkit-sysinfo: Make SYS_VERSION and SYS_CONFIG configurable
  hw/arm/armsse: Add unimplemented-device stubs for MHUs
  hw/arm/armsse: Add unimplemented-device stubs for PPUs
  hw/arm/armsse: Add unimplemented-device stub for cache control
    registers
  hw/arm/armsse: Add unimplemented-device stub for CPU local control
    registers
  hw/misc/armsse-cpuid: Implement SSE-200 CPU_IDENTITY register block
  hw/arm/armsse: Add CPU_IDENTITY block to SSE-200
  hw/arm/armsse: Add SSE-200 model
  hw/arm/mps2-tz: Add IRQ infrastructure to support SSE-200
  hw/arm/mps2-tz: Add mps2-an521 model

 hw/arm/Makefile.objs                  |    2 +-
 hw/misc/Makefile.objs                 |    1 +
 include/hw/arm/{iotkit.h => armsse.h} |  113 ++-
 include/hw/arm/armv7m.h               |    1 +
 include/hw/misc/armsse-cpuid.h        |   41 +
 include/hw/misc/iotkit-secctl.h       |    6 +-
 include/hw/misc/iotkit-sysinfo.h      |    6 +
 hw/arm/armsse.c                       | 1241 +++++++++++++++++++++++++
 hw/arm/armv7m.c                       |   23 +-
 hw/arm/iotkit.c                       |  759 ---------------
 hw/arm/mps2-tz.c                      |  121 ++-
 hw/intc/armv7m_nvic.c                 |    3 +-
 hw/misc/armsse-cpuid.c                |  134 +++
 hw/misc/iotkit-secctl.c               |    5 +-
 hw/misc/iotkit-sysinfo.c              |   15 +-
 MAINTAINERS                           |    6 +-
 default-configs/arm-softmmu.mak       |    3 +-
 hw/misc/trace-events                  |    4 +
 18 files changed, 1670 insertions(+), 814 deletions(-)
 rename include/hw/arm/{iotkit.h => armsse.h} (53%)
 create mode 100644 include/hw/misc/armsse-cpuid.h
 create mode 100644 hw/arm/armsse.c
 delete mode 100644 hw/arm/iotkit.c
 create mode 100644 hw/misc/armsse-cpuid.c

-- 
2.20.1
