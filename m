Received: from eggs.gnu.org ([2001:4830:134:3::10]:33377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdd-00072g-8n
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eBjdb-0000Oy-EE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:48:37 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon,  6 Nov 2017 07:47:43 -0800
Message-Id: <20171106154813.19936-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/30] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi everyone,

This v3 of the patch series containing the work that I've done in
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


Peter, I didn't hear anything from you about the code of
mcimx7d_add_psci_node(), as discussed here:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg486874.html

so I kept the original code intact. As I mentioned before, my goal was
to be able to boot into vanilla Linux kerenel and have working SMP
without needing to use a PSCI implementing bootloader. If that is
something that new board code shouldn't do, please let me know.

Thanks,
Andrey Smirnov

[v2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg05516.html
[v1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04770.html


Andrey Smirnov (30):
  imx_fec: Do not link to netdev
  imx_fec: Refactor imx_eth_enable_rx()
  imx_fec: Change queue flushing heuristics
  imx_fec: Use ENET_FTRL to determine truncation length
  imx_fec: Use MIN instead of explicit ternary operator
  imx_fec: Emulate SHIFT16 in ENETx_RACC
  imx_fec: Add support for multiple Tx DMA rings
  imx_fec: Use correct length for packet size
  imx_fec: Fix a typo in imx_enet_receive()
  imx_fec: Reserve full 4K page for the register file
  sdhci: Add i.MX specific subtype of SDHCI
  sdhci: Implement write method of ACMD12ERRSTS register
  i.MX: Add code to emulate i.MX7 CCM, PMU and ANALOG IP blocks
  i.MX: Add code to emulate i.MX2 watchdog IP block
  i.MX: Add code to emulate i.MX7 SNVS IP-block
  i.MX: Add code to emulate GPCv2 IP block
  i.MX: Add code to emulate i.MX7 IOMUXC IP block
  i.MX: Add i.MX7 GPT variant
  i.MX: Add code to emulate SDMA IP block
  i.MX: Add code to emulate FlexCAN IP block
  i.MX: Add implementation of i.MX7 GPR IP block
  pci: Add support for Designware IP block
  i.MX: Add code to emulate i.MX7 USBMISC IP block
  i.MX: Add code to emulate i.MX7 ADC IP block
  i.MX: Add code to emulate i.MX7 SRC IP-block
  usb: Add basic code to emulate Chipidea USB IP
  ARM: Add basic code to emulate A7MPCore DAP block
  i.MX: Add code to emulate i.MX LCD block
  i.MX: Add i.MX7 SOC implementation.
  Implement support for i.MX7 Sabre board

 default-configs/arm-softmmu.mak  |   3 +
 hw/arm/Makefile.objs             |   4 +-
 hw/arm/coresight.c               | 120 ++++++++
 hw/arm/fsl-imx6.c                |   1 +
 hw/arm/fsl-imx7.c                | 646 +++++++++++++++++++++++++++++++++++++++
 hw/arm/mcimx7d-sabre.c           | 101 ++++++
 hw/display/Makefile.objs         |   2 +
 hw/display/imx_lcdif.c           |  71 +++++
 hw/dma/Makefile.objs             |   1 +
 hw/dma/imx_sdma.c                |  99 ++++++
 hw/intc/Makefile.objs            |   2 +-
 hw/intc/imx_gpcv2.c              | 125 ++++++++
 hw/misc/Makefile.objs            |   8 +
 hw/misc/imx2_wdt.c               |  88 ++++++
 hw/misc/imx7_adc.c               |  99 ++++++
 hw/misc/imx7_ccm.c               | 233 ++++++++++++++
 hw/misc/imx7_gpr.c               | 119 ++++++++
 hw/misc/imx7_iomuxc.c            |  99 ++++++
 hw/misc/imx7_snvs.c              |  83 +++++
 hw/misc/imx7_src.c               |  93 ++++++
 hw/misc/imx_flexcan.c            |  99 ++++++
 hw/net/imx_fec.c                 | 163 +++++++---
 hw/pci-host/Makefile.objs        |   2 +
 hw/pci-host/designware.c         | 614 +++++++++++++++++++++++++++++++++++++
 hw/sd/sdhci-internal.h           |  15 +
 hw/sd/sdhci.c                    | 130 +++++++-
 hw/timer/imx_gpt.c               |  25 ++
 hw/usb/Makefile.objs             |   2 +
 hw/usb/chipidea.c                | 176 +++++++++++
 hw/usb/imx-usbmisc.c             |  99 ++++++
 include/hw/arm/coresight.h       |  24 ++
 include/hw/arm/fsl-imx7.h        | 233 ++++++++++++++
 include/hw/display/imx_lcdif.h   |  16 +
 include/hw/dma/imx_sdma.h        |  22 ++
 include/hw/intc/imx_gpcv2.h      |  22 ++
 include/hw/misc/imx2_wdt.h       |  34 +++
 include/hw/misc/imx7_adc.h       |  22 ++
 include/hw/misc/imx7_ccm.h       | 130 ++++++++
 include/hw/misc/imx7_gpr.h       |  28 ++
 include/hw/misc/imx7_iomuxc.h    |  22 ++
 include/hw/misc/imx7_snvs.h      |  35 +++
 include/hw/misc/imx7_src.h       |  22 ++
 include/hw/misc/imx_flexcan.h    |  22 ++
 include/hw/net/imx_fec.h         |  24 +-
 include/hw/pci-host/designware.h |  92 ++++++
 include/hw/pci/pci_ids.h         |   2 +
 include/hw/sd/sdhci.h            |   8 +
 include/hw/timer/imx_gpt.h       |   1 +
 include/hw/usb/chipidea.h        |  16 +
 include/hw/usb/imx-usbmisc.h     |  22 ++
 50 files changed, 4074 insertions(+), 45 deletions(-)
 create mode 100644 hw/arm/coresight.c
 create mode 100644 hw/arm/fsl-imx7.c
 create mode 100644 hw/arm/mcimx7d-sabre.c
 create mode 100644 hw/display/imx_lcdif.c
 create mode 100644 hw/dma/imx_sdma.c
 create mode 100644 hw/intc/imx_gpcv2.c
 create mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/misc/imx7_adc.c
 create mode 100644 hw/misc/imx7_ccm.c
 create mode 100644 hw/misc/imx7_gpr.c
 create mode 100644 hw/misc/imx7_iomuxc.c
 create mode 100644 hw/misc/imx7_snvs.c
 create mode 100644 hw/misc/imx7_src.c
 create mode 100644 hw/misc/imx_flexcan.c
 create mode 100644 hw/pci-host/designware.c
 create mode 100644 hw/usb/chipidea.c
 create mode 100644 hw/usb/imx-usbmisc.c
 create mode 100644 include/hw/arm/coresight.h
 create mode 100644 include/hw/arm/fsl-imx7.h
 create mode 100644 include/hw/display/imx_lcdif.h
 create mode 100644 include/hw/dma/imx_sdma.h
 create mode 100644 include/hw/intc/imx_gpcv2.h
 create mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/misc/imx7_adc.h
 create mode 100644 include/hw/misc/imx7_ccm.h
 create mode 100644 include/hw/misc/imx7_gpr.h
 create mode 100644 include/hw/misc/imx7_iomuxc.h
 create mode 100644 include/hw/misc/imx7_snvs.h
 create mode 100644 include/hw/misc/imx7_src.h
 create mode 100644 include/hw/misc/imx_flexcan.h
 create mode 100644 include/hw/pci-host/designware.h
 create mode 100644 include/hw/usb/chipidea.h
 create mode 100644 include/hw/usb/imx-usbmisc.h

-- 
2.13.6
