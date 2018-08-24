Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftBD6-0003Vv-Bq
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftBD5-0001C0-1F
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:29:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ftBD4-000149-OJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:29:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ftBCv-0006nL-W7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:28:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 13:28:51 +0100
Message-Id: <20180824122851.4078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/52] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: this clears out a bunch of patches I'd sent over
the last coupled of weeks that have now got reviewed. Mostly
this is MPS2 device support improvements, put there is also
more of the incremental work towards supporting AArch32 Hyp mode,
a floating point bugfix, and the raspi framebuffer viewport support.

v2 fixes a "variable used uninitialized" error in a15mpcore.c.

thanks
-- PMM


The following changes since commit 6b699ae1be9f257478d5eca7ef65dcea270a2796:

  tests/vm: Increase timeout waiting for VM to boot to 5 minutes (2018-08-24 11:31:28 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180824-1

for you to fetch changes up to 239cb6feb298a31faa40b7e97ced107bf9c2f2bf:

  hw/arm/mps2: Fix ID register errors on AN511 and AN385 (2018-08-24 13:17:50 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix rounding errors in scaling float-to-int and int-to-float operations
 * Connect virtualization-related IRQs and memory regions of GICv2
   in boards that use Cortex-A7 or Cortex-A15
 * Support taking exceptions to AArch32 Hyp mode
 * Clear CPSR.IL and CPSR.J on 32-bit exception entry
   (a minor bug fix that won't affect non-buggy guest code)
 * mps2-an505: Implement various missing devices:
   dual timer, watchdogs, counters in the FPGAIO registers,
   some missing ID/control registers, TrustZone Master Security
   Controllers, PL081 DMA controllers, PL022 SPI controllers
 * correct ID register values for mps2-an385, -an511, -an505
 * fix some hardcoded tabs in untouched backwaters of the
   target/arm codebase
 * raspi: Refactor framebuffer property handling code and implement
   support for the virtual framebuffer/viewport

----------------------------------------------------------------
Peter Maydell (48):
      hw/intc/arm_gic: Make per-cpu GICH memory regions 0x200 bytes large
      hw/arm/vexpress: Connect VIRQ and VFIQ
      hw/arm/highbank: Connect VIRQ and VFIQ
      hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
      hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
      hw/cpu/a15mpcore: If CPU has EL2, enable it on the GIC and wire it up
      hw/arm/vexpress: Don't set info->secure_boot if CPU doesn't have EL3
      hw/arm/vexpress: Add "virtualization" property controlling presence of EL2
      target/arm: Implement RAZ/WI HACTLR2
      target/arm: Implement AArch32 HCR and HCR2
      target/arm: Factor out code for taking an AArch32 exception
      target/arm: Implement support for taking exceptions to Hyp mode
      target/arm: Clear CPSR.IL and CPSR.J on 32-bit exception entry
      hw/arm/boot: AArch32 kernels should be started in Hyp mode if available
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
      target/arm: Untabify translate.c
      target/arm: Untabify iwmmxt_helper.c
      target/arm: Remove a handful of stray tabs
      hw/misc/bcm2835_fb: Move config fields to their own struct
      hw/misc/bcm2835_property: Track fb settings using BCM2835FBConfig
      hw/display/bcm2835_fb: Drop unused size and pitch fields
      hw/display/bcm2835_fb: Reset resolution, etc correctly
      hw/display/bcm2835_fb: Abstract out calculation of pitch, size
      hw/display/bcm2835_fb: Fix handling of virtual framebuffer
      hw/display/bcm2835_fb: Validate config settings
      hw/display/bcm2835_fb: Validate bcm2835_fb_mbox_push() config
      hw/arm/mps2: Fix ID register errors on AN511 and AN385

Richard Henderson (4):
      softfloat: Add scaling int-to-float routines
      softfloat: Add scaling float-to-int routines
      target/arm: Use the int-to-float-scale softfloat routines
      target/arm: Use the float-to-int-scale softfloat routines

 hw/misc/Makefile.objs                  |   3 +
 hw/timer/Makefile.objs                 |   1 +
 include/fpu/softfloat.h                | 169 +++++++---
 include/hw/arm/iotkit.h                |  25 +-
 include/hw/display/bcm2835_fb.h        |  59 +++-
 include/hw/misc/iotkit-secctl.h        |  14 +
 include/hw/misc/iotkit-sysctl.h        |  49 +++
 include/hw/misc/iotkit-sysinfo.h       |  37 +++
 include/hw/misc/mps2-fpgaio.h          |  10 +
 include/hw/misc/tz-msc.h               |  79 +++++
 include/hw/ssi/pl022.h                 |  51 +++
 include/hw/timer/cmsdk-apb-dualtimer.h |  72 ++++
 target/arm/cpu.h                       |  16 +-
 fpu/softfloat.c                        | 579 ++++++++++++++++++++++++++-------
 hw/arm/boot.c                          |  11 +
 hw/arm/fsl-imx6ul.c                    |   4 +
 hw/arm/fsl-imx7.c                      |   4 +
 hw/arm/highbank.c                      |   6 +
 hw/arm/iotkit.c                        | 114 ++++++-
 hw/arm/mps2-tz.c                       | 142 +++++++-
 hw/arm/mps2.c                          |  17 +-
 hw/arm/vexpress.c                      |  64 +++-
 hw/cpu/a15mpcore.c                     |  31 +-
 hw/display/bcm2835_fb.c                | 218 ++++++++-----
 hw/intc/arm_gic.c                      |   2 +-
 hw/misc/bcm2835_property.c             | 123 ++++---
 hw/misc/iotkit-secctl.c                |  73 ++++-
 hw/misc/iotkit-sysctl.c                | 261 +++++++++++++++
 hw/misc/iotkit-sysinfo.c               | 128 ++++++++
 hw/misc/mps2-fpgaio.c                  | 146 ++++++++-
 hw/misc/tz-msc.c                       | 308 ++++++++++++++++++
 hw/ssi/pl022.c                         |  57 ++--
 hw/timer/cmsdk-apb-dualtimer.c         | 515 +++++++++++++++++++++++++++++
 target/arm/arm-semi.c                  |   2 +-
 target/arm/helper.c                    | 342 +++++++++++++------
 target/arm/iwmmxt_helper.c             | 234 ++++++-------
 target/arm/translate.c                 | 122 +++----
 MAINTAINERS                            |  10 +
 default-configs/arm-softmmu.mak        |   4 +
 hw/misc/trace-events                   |  16 +
 hw/timer/trace-events                  |   5 +
 41 files changed, 3405 insertions(+), 718 deletions(-)
 create mode 100644 include/hw/misc/iotkit-sysctl.h
 create mode 100644 include/hw/misc/iotkit-sysinfo.h
 create mode 100644 include/hw/misc/tz-msc.h
 create mode 100644 include/hw/ssi/pl022.h
 create mode 100644 include/hw/timer/cmsdk-apb-dualtimer.h
 create mode 100644 hw/misc/iotkit-sysctl.c
 create mode 100644 hw/misc/iotkit-sysinfo.c
 create mode 100644 hw/misc/tz-msc.c
 create mode 100644 hw/timer/cmsdk-apb-dualtimer.c
