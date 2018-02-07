Received: from eggs.gnu.org ([2001:4830:134:3::10]:43572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHIF-00007s-F2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHID-00037Z-S7
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:11 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue,  6 Feb 2018 20:24:24 -0800
Message-Id: <20180207042438.15422-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/14] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi everyone,

This v5 of the patch series containing the work that I've done in
order to enable support for i.MX7 emulation in QEMU.

As the one before last commit in the series states the supported i.MX7
features are:

    * up to 2 Cortex A9 cores (SMP works with PSCI)
    * A7 MPCORE (identical to A15 MPCORE)
    * 4 GPTs modules
    * 7 GPIO controllers
    * 2 IOMUXC controllers
    * 1 CCM module
    * 1 SVNS module
    * 1 SRC module
    * 1 GPCv2 controller
    * 4 eCSPI controllers
    * 4 I2C controllers
    * 7 i.MX UART controllers
    * 2 FlexCAN controllers
    * 2 Ethernet controllers (FEC)
    * 3 SD controllers (USDHC)
    * 4 WDT modules
    * 1 SDMA module
    * 1 GPR module
    * 2 USBMISC modules
    * 2 ADC modules
    * 1 PCIe controller
    * 3 USB controllers
    * 1 LCD controller
    * 1 ARMv7 DAP IP block

Feedback is welcome!

Changes since [v4]:

    - Rebase patchest on top of latest QEMU master

    - Reworked PCIE emulation code to create MemoryRegions
      only once

    - Fixed incorrect usages of PCI instead of PCIE

    - Fixed device class reported by PCIE bridge

    - Added patch to make pci_data_read() and pci_data_write() usable
      for PCIE devices as well

    - Converted PCIE code to use pci_data_read() and pci_data_write()

    - Added VMStateDescription code for PCIE

    - Collected Reviewed-by tag from Philippe

Changes since [v3]:

    - Changes to FEC were split into a separate set and merged to master

    - Patchest is rebased on latest master

    - Converted to use PSCI DT fixup code that is shared with virt
      platform (now relocated to live in arm/boot.c)

    - Large number of dummy block were converted to use
      create_unimplemented_device() as opposed to its own dedicated
      type

    - Incorporated varios small feedback items

    - Collected Reviewed-by tags from Peter

Changes since [v2]:

    - Added stubs for more blocks that were causing memory
      transactions when booting Linux guest as were revealed by
      additional testing of the patchest

    - Added proper USB emulation code, so now it should be possible to
      emulated guest's USB bus

Changes since [v1]:

    - Patchset no longer relies on "ignore_memory_transaction_failures = false"
      for its functionality

    - As a consequnce of implementing the above a number of patches
      implementing dummy IP block emulation as well as PCIe emulation
      patches that I alluded to in [v1] are now included in this patch
      series

    - "has_el3" property is no longer being set to "false" as a part
      of intialization of A7 CPU. I couldn't reproduce the issues that
      I thought I was having, so I just dropped that code.

    - A number of smaller feedback items from Peter and other has been
      incorporated into the patches.


Thanks,
Andrey Smirnov

[v4] https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03264.html
[v3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04236.html
[v2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg05516.html
[v1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04770.html

Andrey Smirnov (14):
  sdhci: Add i.MX specific subtype of SDHCI
  hw: i.MX: Convert i.MX6 to use TYPE_IMX_USDHC
  i.MX: Add code to emulate i.MX7 CCM, PMU and ANALOG IP blocks
  i.MX: Add code to emulate i.MX2 watchdog IP block
  i.MX: Add code to emulate i.MX7 SNVS IP-block
  i.MX: Add code to emulate GPCv2 IP block
  i.MX: Add i.MX7 GPT variant
  i.MX: Add implementation of i.MX7 GPR IP block
  pci: Use pci_config_size in pci_data_* accessors
  pci: Add support for Designware IP block
  usb: Add basic code to emulate Chipidea USB IP
  i.MX: Add i.MX7 SOC implementation.
  hw/arm: Move virt's PSCI DT fixup code to arm/boot.c
  Implement support for i.MX7 Sabre board

 default-configs/arm-softmmu.mak  |   3 +
 hw/arm/Makefile.objs             |   3 +
 hw/arm/boot.c                    |  65 ++++
 hw/arm/fsl-imx6.c                |   2 +-
 hw/arm/fsl-imx7.c                | 580 ++++++++++++++++++++++++++++++
 hw/arm/mcimx7d-sabre.c           |  90 +++++
 hw/arm/virt.c                    |  61 ----
 hw/intc/Makefile.objs            |   2 +-
 hw/intc/imx_gpcv2.c              | 125 +++++++
 hw/misc/Makefile.objs            |   4 +
 hw/misc/imx2_wdt.c               |  89 +++++
 hw/misc/imx7_ccm.c               | 277 ++++++++++++++
 hw/misc/imx7_gpr.c               | 124 +++++++
 hw/misc/imx7_snvs.c              |  83 +++++
 hw/misc/trace-events             |   4 +
 hw/pci-host/Makefile.objs        |   2 +
 hw/pci-host/designware.c         | 759 +++++++++++++++++++++++++++++++++++++++
 hw/pci/pci_host.c                |  13 +-
 hw/sd/sdhci-internal.h           |  20 ++
 hw/sd/sdhci.c                    | 230 +++++++++++-
 hw/timer/imx_gpt.c               |  25 ++
 hw/usb/Makefile.objs             |   1 +
 hw/usb/chipidea.c                | 176 +++++++++
 include/hw/arm/fsl-imx7.h        | 221 ++++++++++++
 include/hw/intc/imx_gpcv2.h      |  22 ++
 include/hw/misc/imx2_wdt.h       |  33 ++
 include/hw/misc/imx7_ccm.h       | 139 +++++++
 include/hw/misc/imx7_gpr.h       |  28 ++
 include/hw/misc/imx7_snvs.h      |  35 ++
 include/hw/pci-host/designware.h |  97 +++++
 include/hw/pci/pci_ids.h         |   2 +
 include/hw/sd/sdhci.h            |  13 +
 include/hw/timer/imx_gpt.h       |   1 +
 include/hw/usb/chipidea.h        |  16 +
 34 files changed, 3277 insertions(+), 68 deletions(-)
 create mode 100644 hw/arm/fsl-imx7.c
 create mode 100644 hw/arm/mcimx7d-sabre.c
 create mode 100644 hw/intc/imx_gpcv2.c
 create mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/misc/imx7_ccm.c
 create mode 100644 hw/misc/imx7_gpr.c
 create mode 100644 hw/misc/imx7_snvs.c
 create mode 100644 hw/pci-host/designware.c
 create mode 100644 hw/usb/chipidea.c
 create mode 100644 include/hw/arm/fsl-imx7.h
 create mode 100644 include/hw/intc/imx_gpcv2.h
 create mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/misc/imx7_ccm.h
 create mode 100644 include/hw/misc/imx7_gpr.h
 create mode 100644 include/hw/misc/imx7_snvs.h
 create mode 100644 include/hw/pci-host/designware.h
 create mode 100644 include/hw/usb/chipidea.h

-- 
2.14.3
