Received: from eggs.gnu.org ([2001:4830:134:3::10]:59978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edov5-0000WO-SM
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edov1-0004Ug-3f
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:06:43 -0500
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edov0-0004UF-Ta
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:06:39 -0500
Received: by mail-qt0-x22a.google.com with SMTP id z11so26363120qtm.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:06:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:06:16 -0300
Message-Id: <20180123030630.26613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/14] SDHCI: add tuning sequence for UHS-I
 cards (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This series add minimum features required by Spec v3 to support UHS-I cards.

Since v7:
- we keep the 'capareg' property, this simplify a lot the series
- the ZynqMP uses the datasheet CAPAREG
- reset R-b/A-b

Note: https://www.google.com.ar/search?q=sdhci_imx0+caps show various console
      output with i.MX6 capareg value of 0x0377c800 

Since v6:
- rebased on upstream
- included spec v3 qtest back

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

$ git backport-diff
001/14:[down] 'sdhci: add support for v3 capabilities'
002/14:[----] [--] 'sdhci: rename the hostctl1 register'
003/14:[----] [--] 'sdhci: implement the Host Control 2 register (tuning sequence)'
004/14:[----] [--] 'sdbus: add trace events'
005/14:[0006] [FC] 'sdhci: implement UHS-I voltage switch'
006/14:[----] [--] 'sdhci: implement CMD/DAT[] fields in the Present State register'
007/14:[0015] [FC] 'hw/arm/bcm2835_peripherals: implement SDHCI Spec. v3'
008/14:[0003] [FC] 'hw/arm/bcm2835_peripherals: change maximum block size to 1kB'
009/14:[0014] [FC] 'hw/arm/fsl-imx6: implement SDHCI Spec. v3'
010/14:[0017] [FC] 'hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet'
011/14:[down] 'hw/arm/xilinx_zynqmp: enable the UHS-I mode'
012/14:[0010] [FC] 'sdhci: check Spec v3 capabilities qtest'
013/14:[----] [--] 'sdhci: add a check_capab_v3() qtest'
014/14:[0019] [FC] 'sdhci: add Spec v4.2 register definitions'

Based-on: 20180123020820.1288-17-f4bug@amsat.org

Philippe Mathieu-Daudé (14):
  sdhci: add support for v3 capabilities
  sdhci: rename the hostctl1 register
  sdhci: implement the Host Control 2 register (tuning sequence)
  sdbus: add trace events
  sdhci: implement UHS-I voltage switch
  sdhci: implement CMD/DAT[] fields in the Present State register
  hw/arm/bcm2835_peripherals: implement SDHCI Spec v3
  hw/arm/bcm2835_peripherals: change maximum block size to 1kB
  hw/arm/fsl-imx6: implement SDHCI Spec. v3
  hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet
  hw/arm/xilinx_zynqmp: enable the UHS-I mode
  sdhci: check Spec v3 capabilities qtest
  sdhci: add a check_capab_v3() qtest
  sdhci: add Spec v4.2 register definitions

 include/hw/sd/sd.h           |  20 ++++++++
 include/hw/sd/sdhci.h        |   4 +-
 hw/sd/sdhci-internal.h       |  34 ++++++++++++
 hw/arm/bcm2835_peripherals.c |  23 +++++----
 hw/arm/fsl-imx6.c            |   7 +++
 hw/arm/xlnx-zynqmp.c         |  30 +++++++----
 hw/sd/core.c                 |  61 +++++++++++++++++++++-
 hw/sd/sd.c                   |  29 +++++++++++
 hw/sd/sdhci.c                | 120 ++++++++++++++++++++++++++++++++++++++-----
 hw/sd/trace-events           |   8 +++
 tests/sdhci-test.c           |  29 +++++++++++
 tests/Makefile.include       |   1 +
 12 files changed, 330 insertions(+), 36 deletions(-)

-- 
2.15.1
