Received: from eggs.gnu.org ([2001:4830:134:3::10]:37383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fkAyn-0001J5-Ok
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fkAym-0001Bn-Lm
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:25:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 17:24:53 +0100
Message-Id: <20180730162458.23186-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] mps2: Implement FPGAIO counters and
 dual-timer
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

This patchset adds some missing timer and counter devices
to the MPS2 boards:

 * the MPS2 "fpgaio" register bank includes some registers
   which provide various kinds of free-running counter
 * the boards have an instance fo the CMSDK "dual timer module"

Together these are sufficient for QEMU's mps2-an505
emulation to pass the "timer test" subsection of the
self-test program which can be found (behind a clickthrough
EULA) in the Cortex-M33_IoT_kit_2_0.zip at:
 https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/download-fpga-images

The dual-timer patch ended up a bit big; I can try to split
that up if people would prefer that for review.

thanks
-- PMM

Peter Maydell (5):
  hw/misc/mps2-fpgaio: Implement 1Hz and 100Hz counters
  hw/misc/mps2-fpgaio: Implement PSCNTR and COUNTER
  hw/timer/cmsdk-apb-dualtimer: Implement CMSDK dual timer module
  hw/arm/iotkit: Wire up the dualtimer
  hw/arm/mps2: Wire up dual-timer in mps2-an385 and mps2-an511

 hw/timer/Makefile.objs                 |   1 +
 include/hw/arm/iotkit.h                |   3 +-
 include/hw/misc/mps2-fpgaio.h          |  10 +
 include/hw/timer/cmsdk-apb-dualtimer.h |  72 ++++
 hw/arm/iotkit.c                        |   8 +-
 hw/arm/mps2.c                          |  11 +
 hw/misc/mps2-fpgaio.c                  | 146 ++++++-
 hw/timer/cmsdk-apb-dualtimer.c         | 515 +++++++++++++++++++++++++
 MAINTAINERS                            |   2 +
 default-configs/arm-softmmu.mak        |   1 +
 hw/timer/trace-events                  |   5 +
 11 files changed, 767 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/timer/cmsdk-apb-dualtimer.h
 create mode 100644 hw/timer/cmsdk-apb-dualtimer.c

-- 
2.17.1
