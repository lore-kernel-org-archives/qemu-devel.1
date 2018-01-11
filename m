Received: from eggs.gnu.org ([2001:4830:134:3::10]:58880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZju5-000589-Iz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZju0-00028t-Mm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:56:49 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Jan 2018 17:56:05 -0300
Message-Id: <20180111205626.23291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/21] SDHCI: clean Specs v1/v2,
 implement Spec v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org

Since v5:
- addressed Alistair reviews
- dropped "abstract generic-sdhci"
- dropped Linux Device Tree names
- split qtests in another series
- change the bcm2835 minimum blocksize to 1KB (Andrew Baumann)
- added Alistair R-b
- based on Alistair work:
  - add SD tunning sequence via Host Control 2 to use UHS-I cards
  - add CMD/DAT[] fields in the Present State (used in next series
    to switch card voltage)

based on Alistair work:
- add SD tunning sequence via Host Control 2 to use UHS-I cards
- add CMD/DAT[] fields in the Present State (used in next series
  to switch card voltage)

Since v4 ("SDHCI: add qtests and fix few issues"):
- spec_version default to v2 (current behaviour)
- addressed Alistair review (no v1, tell user about valid version)

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

$ git backport-diff # with v4
001/21:[0007] [FC] 'sdhci: add a 'spec_version property' (default to v2)'
002/21:[0005] [FC] 'sdhci: add basic Spec v1 capabilities'
003/21:[----] [-C] 'sdhci: add max-block-length capability (Spec v1)'
004/21:[0003] [FC] 'sdhci: add clock capabilities (Spec v1)'
005/21:[0004] [FC] 'sdhci: add DMA and 64-bit capabilities (Spec v2)'
006/21:[----] [--] 'sdhci: add BLOCK_SIZE_MASK for DMA'
007/21:[----] [--] 'sdhci: Fix 64-bit ADMA2'
008/21:[0008] [FC] 'sdhci: add v3 capabilities'
009/21:[0002] [FC] 'sdhci: rename the hostctl1 register'
010/21:[----] [--] 'hw/arm/exynos4210: implement SDHCI Spec v2'
011/21:[----] [--] 'hw/arm/xilinx_zynq: implement SDHCI Spec v2'
012/21:[0007] [FC] 'hw/arm/bcm2835_peripherals: implement SDHCI Spec v3'
013/21:[down] 'hw/arm/bcm2835_peripherals: change maximum block size to 1kB'
014/21:[0003] [FC] 'hw/arm/fsl-imx6: implement SDHCI Spec v3'
015/21:[----] [--] 'hw/arm/xilinx_zynqmp: implement SDHCI Spec v3'
016/21:[----] [-C] 'sdhci: remove the deprecated 'capareg' property'
017/21:[----] [--] 'sdhci: add Spec v4.2 register definitions'
018/21:[down] 'sdhci: implement the Host Control 2 register for the tunning sequence'
019/21:[down] 'sdbus: add trace events'
020/21:[down] 'sdhci: implement UHS-I voltage switch'
021/21:[down] 'sdhci: implement CMD/DAT[] fields in the Present State register'

Based-on: 20180111193021.17466-14-f4bug@amsat.org

Philippe Mathieu-Daudé (20):
  sdhci: sdhci: add a 'spec_version property' (default to v2)
  sdhci: add basic Spec v1 capabilities
  sdhci: add max-block-length capability (Spec v1)
  sdhci: add clock capabilities (Spec v1)
  sdhci: add DMA and 64-bit capabilities (Spec v2)
  sdhci: add BLOCK_SIZE_MASK for DMA
  sdhci: add v3 capabilities
  sdhci: rename the hostctl1 register
  hw/arm/exynos4210: implement SDHCI Spec v2
  hw/arm/xilinx_zynq: implement SDHCI Spec v2
  hw/arm/bcm2835_peripherals: implement SDHCI Spec v3
  hw/arm/bcm2835_peripherals: change maximum block size to 1kB
  hw/arm/fsl-imx6: implement SDHCI Spec v3
  hw/arm/xilinx_zynqmp: implement SDHCI Spec v3
  sdhci: remove the deprecated 'capareg' property
  sdhci: add Spec v4.2 register definitions
  sdhci: implement the Host Control 2 register for the tunning sequence
  sdbus: add trace events
  sdhci: implement UHS-I voltage switch
  sdhci: implement CMD/DAT[] fields in the Present State register

Sai Pavan Boddu (1):
  sdhci: Fix 64-bit ADMA2

 hw/sd/sdhci-internal.h       |  74 ++++++++++--
 include/hw/sd/sd.h           |  20 ++++
 include/hw/sd/sdhci.h        |  21 +++-
 hw/arm/bcm2835_peripherals.c |  33 ++++--
 hw/arm/exynos4210.c          |  13 +-
 hw/arm/fsl-imx6.c            |  13 ++
 hw/arm/xilinx_zynq.c         |  64 ++++++----
 hw/arm/xlnx-zynqmp.c         |  38 ++++--
 hw/sd/core.c                 |  61 +++++++++-
 hw/sd/sd.c                   |  29 +++++
 hw/sd/sdhci.c                | 274 ++++++++++++++++++++++++++++---------------
 hw/sd/trace-events           |   8 ++
 12 files changed, 490 insertions(+), 158 deletions(-)

-- 
2.15.1
