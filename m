Received: from eggs.gnu.org ([2001:4830:134:3::10]:37351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du24s-0006np-NM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du24r-0006Hz-Qh
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:34 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 18 Sep 2017 12:50:43 -0700
Message-Id: <20170918195100.17593-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH 00/17] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi everyone,

This patch series contains the work that I've done in order to enable
support for i.MX7 emulation in QEMU. Majority of the set are just odd
fixes and small features implementation that I had to do to already
exisitng code but last 5 commits contain new emulation code.

As the one before last commit in the series states the supported i.MX7
features are:

    * up to 2 Cortex A9 cores (SMP works with PSCI)
    * A7 MPCORE (identical to A15 MPCORE)
    * 7 i.MX UARTs
    * 1 CCM device
    * 2 Ethernet controllers (FEC)
    * 3 SD controllers (USDHC)
    * 1 SNVS device
    * 1 WDT device

I also have a follow up series that implements bit needes for PCIe
emulation support (DesignWare IP emulation + supporting code) which
I'll be submitting after this series is accepted.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (17):
  imx_fec: Do not link to netdev
  imx_fec: Do not calculate FEC
  imx_fec: Refactor imx_eth_enable_rx()
  imx_fec: Change queue flushing heuristics
  imx_fec: Use ENET_FTRL to determine truncation length
  imx_fec: Use MIN instead of explicit ternary operator
  imx_fec: Emulate SHIFT16 in ENETx_RACC
  imx_fec: Add support for multiple Tx DMA rings
  imx_fec: Use correct length for packet size
  sdhci: Add i.MX specific subtype of SDHCI
  sdhci: Implement write method of ACMD12ERRSTS register
  i.MX: Add i.MX7 CCM, PMU and ANALOG device
  i.MX: Add code to emulate i.MX2 watchdog IP block
  i.MX7: Add code to emulate SNVS IP-block
  include/qemu: Add sizes.h from Linux
  i.MX: Add i.MX7 SOC implementation.
  Implement support for i.MX7 Sabre board

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   2 +
 hw/arm/fsl-imx6.c               |   1 +
 hw/arm/fsl-imx7.c               | 327 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/mcimx7d-sabre.c          | 100 ++++++++++++
 hw/misc/Makefile.objs           |   3 +
 hw/misc/imx2_wdt.c              | 117 ++++++++++++++
 hw/misc/imx7_ccm.c              | 201 ++++++++++++++++++++++++
 hw/misc/imx7_snvs.c             |  84 +++++++++++
 hw/net/imx_fec.c                | 153 ++++++++++++++-----
 hw/sd/sdhci-internal.h          |  15 ++
 hw/sd/sdhci.c                   | 126 +++++++++++++++-
 include/hw/arm/fsl-imx7.h       | 114 ++++++++++++++
 include/hw/misc/imx2_wdt.h      |  36 +++++
 include/hw/misc/imx7_ccm.h      |  76 ++++++++++
 include/hw/misc/imx7_snvs.h     |  35 +++++
 include/hw/net/imx_fec.h        |  26 +++-
 include/hw/sd/sdhci.h           |   8 +
 include/qemu/sizes.h            |  47 ++++++
 19 files changed, 1433 insertions(+), 39 deletions(-)
 create mode 100644 hw/arm/fsl-imx7.c
 create mode 100644 hw/arm/mcimx7d-sabre.c
 create mode 100644 hw/misc/imx2_wdt.c
 create mode 100644 hw/misc/imx7_ccm.c
 create mode 100644 hw/misc/imx7_snvs.c
 create mode 100644 include/hw/arm/fsl-imx7.h
 create mode 100644 include/hw/misc/imx2_wdt.h
 create mode 100644 include/hw/misc/imx7_ccm.h
 create mode 100644 include/hw/misc/imx7_snvs.h
 create mode 100644 include/qemu/sizes.h

-- 
2.13.5
