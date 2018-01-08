Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZa9-000125-Ck
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZa6-0006oK-7g
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:43:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:32 -0300
Message-Id: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/31] SDHCI: make it abstract,
 add inherited devices, add qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Since v4 ("SDHCI: add qtests and fix few issues"):
- spec_version default to v2 (current behaviour)
- addressed Alistair review (no v1, tell user about valid version)
- generic-sdhci is now abstract, added more sdhci device following Linux
  Device Tree names:
  - hw/arm/fsl-imx6: "fsl,imx6q-usdhc"
  - hw/arm/exynos4210: "samsung,exynos4210-dw-mshc"
  - hw/arm/bcm2835_peripherals: "brcm,bcm2835-sdhci"
  - hw/arm/xilinx_zynq: "arasan,sdhci-4.9a"
  - hw/arm/xilinx_zynqmp: "arasan,sdhci-8.9a"

Since v3:
- no change, but split back in 2 series, 1st part is "SDHCI: housekeeping v5",
Based-on: 20180103180805.18140-18-f4bug@amsat.org

Since v2:
- more detailed 'capabilities', all boards converted to use these properties
- since all qtests pass, removed the previous 'capareg' property
- added Stefan/Alistair R-b
- corrected 'access' LED behavior (Alistair's review)
- more uses of the registerfields API
- remove some dead code
- cosmetix:
  - added more comments
  - renamed a pair of registers
  - reordered few struct members

Note, the bcm2835 seems to have 1KB minimum blocksize, however the current
model is implemented with 512B. I didn't change the current value.

Since v1:
- addressed Alistair Francis review comments, added some R-b
- only move register defines to "sd-internal.h"
- fixed deposit64() arguments
- dropped unuseful s->fifo_buffer = NULL
- use a qemu_irq for the LED, restrict the logging to ON/OFF
- fixed a trace format string error
- included Andrey Smirnov ACMD12ERRSTS write patch
- dropped few unuseful patches, and separate the Python polemical ones for later

>From the "SDHCI housekeeping" series:
- 1: we restrict part of "sd/sd.h" into local "sd-internal.h",
- 2,3: we somehow beautiful the code, no logical changes,
- 4-7: we refactor the common sysbus/pci qdev code,
- 8-10: we add plenty of trace events which will result useful later,
- 11: we finally expose a "dma-memory" property.
>From the "SDHCI: add a qtest and fix few issues" series:
- 12,13: fix registers
- 14,15: boards can specify which SDHCI Spec to use (v2 and v3 so far)
- 15-20: HCI qtest

Regards,

Phil.

[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/31:[0006] [FC] 'sdhci: add a spec_version property'
002/31:[----] [-C] 'sdhci: add basic Spec v1 capabilities'
003/31:[----] [-C] 'sdhci: add max-block-length capability (Spec v1)'
004/31:[0002] [FC] 'sdhci: add clock capabilities (Spec v1)'
005/31:[----] [--] 'sdhci: add DMA and 64-bit capabilities (Spec v2)'
006/31:[----] [--] 'sdhci: add BLOCK_SIZE_MASK for DMA'
007/31:[----] [--] 'sdhci: Fix 64-bit ADMA2'
008/31:[down] 'hw/sd: clean/reorder the Makefile adding few comments'
009/31:[down] 'sdhci: add a common class'
010/31:[down] 'sdhci: add a Designware/Samsung host controller'
011/31:[down] 'hw/arm/exynos4210: use the "samsung,exynos4210-dw-mshc" device'
012/31:[down] 'sdhci: add the generic Arasan SDHCI 4.9a PHY controller'
013/31:[down] 'hw/arm/xilinx_zynq: use the "arasan,sdhci-4.9a" device'
014/31:[----] [--] 'sdhci: add qtest to check the SD Spec version'
015/31:[----] [--] 'sdhci: check Spec v2 capabilities qtest'
016/31:[0007] [FC] 'sdhci: add v3 capabilities'
017/31:[----] [--] 'sdhci: rename the hostctl1 register'
018/31:[down] 'sdhci: add the Broadcom BCM2835 SDHCI controller'
019/31:[down] 'hw/arm/bcm2835_peripherals: use the "brcm,bcm2835-sdhci" device'
020/31:[down] 'sdhci: add the Freescale controller for i.MX'
021/31:[down] 'hw/arm/fsl-imx6: use the "fsl,imx6q-usdhc" controller'
022/31:[down] 'sdhci: add the generic Arasan SDHCI 8.9a PHY'
023/31:[down] 'hw/arm/xilinx_zynqmp: use the "arasan,sdhci-8.9a" device'
024/31:[down] 'sdhci: let the SYSBUS_SDHCI type be abstract'
025/31:[----] [--] 'sdhci: check Spec v3 capabilities qtest'
026/31:[----] [-C] 'sdhci: remove the deprecated 'capareg' property'
027/31:[----] [--] 'sdhci: add check_capab_readonly() qtest'
028/31:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
029/31:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
030/31:[----] [--] 'sdhci: add a check_capab_v3() qtest'
031/31:[----] [--] 'sdhci: add Spec v4.2 register definitions'

Philippe Mathieu-Daudé (30):
  sdhci: add a spec_version property
  sdhci: add basic Spec v1 capabilities
  sdhci: add max-block-length capability (Spec v1)
  sdhci: add clock capabilities (Spec v1)
  sdhci: add DMA and 64-bit capabilities (Spec v2)
  sdhci: add BLOCK_SIZE_MASK for DMA
  hw/sd: clean/reorder the Makefile adding few comments
  sdhci: add a common class
  sdhci: add a Designware/Samsung host controller
  hw/arm/exynos4210: use the "samsung,exynos4210-dw-mshc" device
  sdhci: add the generic Arasan SDHCI 4.9a PHY controller
  hw/arm/xilinx_zynq: use the "arasan,sdhci-4.9a" device
  sdhci: add qtest to check the SD Spec version
  sdhci: check Spec v2 capabilities qtest
  sdhci: add v3 capabilities
  sdhci: rename the hostctl1 register
  sdhci: add the Broadcom BCM2835 SDHCI controller
  hw/arm/bcm2835_peripherals: use the "brcm,bcm2835-sdhci" device
  sdhci: add the Freescale controller for i.MX
  hw/arm/fsl-imx6: use the "fsl,imx6q-usdhc" controller
  sdhci: add the generic Arasan SDHCI 8.9a PHY
  hw/arm/xilinx_zynqmp: use the "arasan,sdhci-8.9a" device
  sdhci: let the SYSBUS_SDHCI type be abstract
  sdhci: check Spec v3 capabilities qtest
  sdhci: remove the deprecated 'capareg' property
  sdhci: add check_capab_readonly() qtest
  sdhci: add a check_capab_baseclock() qtest
  sdhci: add a check_capab_sdma() qtest
  sdhci: add a check_capab_v3() qtest
  sdhci: add Spec v4.2 register definitions

Sai Pavan Boddu (1):
  sdhci: Fix 64-bit ADMA2

 include/hw/sd/sdhci.h        |  32 +++++-
 hw/sd/sdhci-internal.h       |  70 +++++++++++--
 hw/arm/bcm2835_peripherals.c |  19 +---
 hw/arm/exynos4210.c          |  12 +--
 hw/arm/fsl-imx6.c            |   2 +-
 hw/arm/xilinx_zynq.c         |  41 +++-----
 hw/arm/xlnx-zynqmp.c         |   2 +-
 hw/sd/arasan_sdhci.c         | 124 ++++++++++++++++++++++
 hw/sd/bcm2835_sdhci.c        |  77 ++++++++++++++
 hw/sd/dw-mshc.c              |  64 ++++++++++++
 hw/sd/fsl-sdhc.c             |  58 +++++++++++
 hw/sd/sdhci.c                | 240 ++++++++++++++++++++++++++-----------------
 hw/sd/Makefile.objs          |  14 ++-
 tests/sdhci-test.c           | 177 +++++++++++++++++++++++++++++++
 tests/Makefile.include       |   3 +
 15 files changed, 774 insertions(+), 161 deletions(-)
 create mode 100644 hw/sd/arasan_sdhci.c
 create mode 100644 hw/sd/bcm2835_sdhci.c
 create mode 100644 hw/sd/dw-mshc.c
 create mode 100644 hw/sd/fsl-sdhc.c
 create mode 100644 tests/sdhci-test.c

-- 
2.15.1
