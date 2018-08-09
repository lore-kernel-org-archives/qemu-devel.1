Received: from eggs.gnu.org ([2001:4830:134:3::10]:47173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZQ-0005wY-2K
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZO-0003NX-LV
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Aug 2018 14:00:59 +0100
Message-Id: <20180809130115.28951-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/16] arm: Implement MPS2 watchdogs and DMA
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

This patchset adds some more missing devices to the MPS2 AN505
board model:

Patches 1-3 implement and wire up the CMSDK APB watchdog devices.

Patch 4 adds a CMSDK timer device that had been forgotten.

Ppatches 5-6 implement and wire up the "system control element",
which is some simple control/ID registers in the IoTKit

Patches 7-16 are the meat of the patchset, and add support
for the DMA controllers and their associated Master Security
Controllers. A TrustZone MSC sits in front of a device which
can be a bus master (such as a DMA controller) and allows secure
software to configure it to either pass through or reject transactions
made by that bus master. Rejected transactions may be configured to
either be aborted, or to behave as RAZ/WI. An interrupt can be
signalled for a rejected transaction. The AN505 has four
PL081 DMA controllers, each with its own MSC.

Patches 10-15 are various minor cleanups and bugfixes in
the PL081 model that are needed for its use in the AN505.
In particular the PL081 was previously entirely broken as
it would hw_error() as soon as the guest enabled the DMA
engine. I assume this was either accidentally left-in debug code,
or a deliberate choice to guard a never-tested implementation
so as to be able to identify when we had guest code to test it
with. (Linux for the realview/versatile boards never tries to
use the PL08x there for DMA.)

This patchset is sufficient for the "DMA" test in the AN505
self-test binary to pass. (I suspect it is not giving the
PL081 or MSC a very thorough workout, though.)

Based-on: <20180730162458.23186-1-peter.maydell@linaro.org>
("[PATCH 0/5] mps2: Implement FPGAIO counters and dual-timer")

thanks
-- PMM

Peter Maydell (16):
  hw/watchdog/cmsdk_apb_watchdog: Implement CMSDK APB watchdog module
  nvic: Expose NMI line
  hw/arm/iotkit: Wire up the watchdogs
  hw/arm/iotkit: Wire up the S32KTIMER
  hw/misc/iotkit-sysctl: Implement IoTKit system control element
  hw/misc/iotkit: Wire up the system control element
  hw/misc/tz-msc: Model TrustZone Master Security Controller
  hw/misc/iotkit-secctl: Wire up registers for controlling MSCs
  hw/arm/iotkit: Wire up the lines for MSCs
  hw/dma/pl080: Allow use as embedded-struct device
  hw/dma/pl080: Support all three interrupt lines
  hw/dma/pl080: Don't use CPU address space for DMA accesses
  hw/dma/pl080: Provide device reset function
  hw/dma/pl080: Correct bug in register address decode logic
  hw/dma/pl080: Remove hw_error() if DMA is enabled
  hw/arm/mps2-tz: Create PL081s and MSCs

 Makefile.objs                            |   1 +
 hw/misc/Makefile.objs                    |   2 +
 hw/watchdog/Makefile.objs                |   1 +
 include/hw/arm/iotkit.h                  |  20 +-
 include/hw/dma/pl080.h                   |  71 +++++
 include/hw/misc/iotkit-secctl.h          |  14 +
 include/hw/misc/iotkit-sysctl.h          |  50 ++++
 include/hw/misc/tz-msc.h                 |  79 ++++++
 include/hw/watchdog/cmsdk-apb-watchdog.h |  59 ++++
 hw/arm/armv7m.c                          |   1 +
 hw/arm/iotkit.c                          |  99 ++++++-
 hw/arm/mps2-tz.c                         | 101 ++++++-
 hw/arm/realview.c                        |   8 +-
 hw/arm/versatilepb.c                     |   9 +-
 hw/dma/pl080.c                           | 113 ++++----
 hw/intc/armv7m_nvic.c                    |  19 ++
 hw/misc/iotkit-secctl.c                  |  73 ++++-
 hw/misc/iotkit-sysctl.c                  | 324 ++++++++++++++++++++++
 hw/misc/tz-msc.c                         | 308 +++++++++++++++++++++
 hw/watchdog/cmsdk-apb-watchdog.c         | 326 +++++++++++++++++++++++
 MAINTAINERS                              |   7 +
 default-configs/arm-softmmu.mak          |   3 +
 hw/intc/trace-events                     |   1 +
 hw/misc/trace-events                     |  16 ++
 hw/watchdog/trace-events                 |   6 +
 25 files changed, 1632 insertions(+), 79 deletions(-)
 create mode 100644 include/hw/dma/pl080.h
 create mode 100644 include/hw/misc/iotkit-sysctl.h
 create mode 100644 include/hw/misc/tz-msc.h
 create mode 100644 include/hw/watchdog/cmsdk-apb-watchdog.h
 create mode 100644 hw/misc/iotkit-sysctl.c
 create mode 100644 hw/misc/tz-msc.c
 create mode 100644 hw/watchdog/cmsdk-apb-watchdog.c
 create mode 100644 hw/watchdog/trace-events

-- 
2.17.1
