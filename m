Received: from eggs.gnu.org ([2001:4830:134:3::10]:41795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku1-0003QK-SR
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku0-0007DY-R6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:29 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:10:54 +0100
Message-Id: <20180820141116.9118-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/22] MPS devices: FPGAIO, timer, watchdogs,
 MSC, DMA, SPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This patchset is a combination of the remaining patches
from the v1 patchsets
 * mps2: Implement FPGAIO counters and dual-timer
 * arm: Implement MPS2 watchdogs and DMA

plus some new patches which clean up the PL022 and
instantiate it in the MPS2, and one final patch to fix
some SCC config register values.

Patches which need review:
1, 3, 4, 5, 8, 9, 10, 11, 15-22
(2, 6, 7, 12, 13, 14 have been reviewed already in v1)

Changes since v1:
 * some patches that were reviewed have been upstreamed
 * I have split the sysinfo registers out of "iotkit-sysctl"
   and into their own "iotkit-sysinfo" devices
 * patches 15-22 are new

These are all the enhancements I plan to make to the MPS2
boards. I won't be doing anything more except in response to
bug reports.

thanks
-- PMM

Peter Maydell (22):
  hw/misc/mps2-fpgaio: Implement 1Hz and 100Hz counters
  hw/misc/mps2-fpgaio: Implement PSCNTR and COUNTER
  hw/timer/cmsdk-apb-dualtimer: Implement CMSDK dual timer module
  hw/arm/iotkit: Wire up the dualtimer
  hw/arm/mps2: Wire up dual-timer in mps2-an385 and mps2-an511
  hw/arm/iotkit: Wire up the watchdogs
  hw/arm/iotkit: Wire up the S32KTIMER
  hw/misc/iotkit-sysctl: Implement IoTKit system control element
  hw/misc/iotkit-sysinfo: Implement IoTKit system information block
  hw/misc/iotkit: Wire up the sysctl and sysinfo register blocks
  hw/misc/tz-msc: Model TrustZone Master Security Controller
  hw/misc/iotkit-secctl: Wire up registers for controlling MSCs
  hw/arm/iotkit: Wire up the lines for MSCs
  hw/arm/mps2-tz: Create PL081s and MSCs
  hw/ssi/pl022: Allow use as embedded-struct device
  hw/ssi/pl022: Set up reset function in class init
  hw/ssi/pl022: Don't directly call vmstate_register()
  hw/ssi/pl022: Use DeviceState::realize rather than SysBusDevice::init
  hw/ssi/pl022: Correct wrong value for PL022_INT_RT
  hw/ssi/pl022: Correct wrong DMACR and ICR handling
  hw/arm/mps2-tz: Instantiate SPI controllers
  hw/arm/mps2-tz: Fix MPS2 SCC config register values

 hw/misc/Makefile.objs                  |   3 +
 hw/timer/Makefile.objs                 |   1 +
 include/hw/arm/iotkit.h                |  25 +-
 include/hw/misc/iotkit-secctl.h        |  14 +
 include/hw/misc/iotkit-sysctl.h        |  49 +++
 include/hw/misc/iotkit-sysinfo.h       |  37 ++
 include/hw/misc/mps2-fpgaio.h          |  10 +
 include/hw/misc/tz-msc.h               |  79 ++++
 include/hw/ssi/pl022.h                 |  51 +++
 include/hw/timer/cmsdk-apb-dualtimer.h |  72 ++++
 hw/arm/iotkit.c                        | 114 +++++-
 hw/arm/mps2-tz.c                       | 142 ++++++-
 hw/arm/mps2.c                          |  11 +
 hw/misc/iotkit-secctl.c                |  73 +++-
 hw/misc/iotkit-sysctl.c                | 261 +++++++++++++
 hw/misc/iotkit-sysinfo.c               | 128 ++++++
 hw/misc/mps2-fpgaio.c                  | 146 ++++++-
 hw/misc/tz-msc.c                       | 308 +++++++++++++++
 hw/ssi/pl022.c                         |  57 +--
 hw/timer/cmsdk-apb-dualtimer.c         | 515 +++++++++++++++++++++++++
 MAINTAINERS                            |  10 +
 default-configs/arm-softmmu.mak        |   4 +
 hw/misc/trace-events                   |  16 +
 hw/timer/trace-events                  |   5 +
 24 files changed, 2049 insertions(+), 82 deletions(-)
 create mode 100644 include/hw/misc/iotkit-sysctl.h
 create mode 100644 include/hw/misc/iotkit-sysinfo.h
 create mode 100644 include/hw/misc/tz-msc.h
 create mode 100644 include/hw/ssi/pl022.h
 create mode 100644 include/hw/timer/cmsdk-apb-dualtimer.h
 create mode 100644 hw/misc/iotkit-sysctl.c
 create mode 100644 hw/misc/iotkit-sysinfo.c
 create mode 100644 hw/misc/tz-msc.c
 create mode 100644 hw/timer/cmsdk-apb-dualtimer.c

-- 
2.18.0
