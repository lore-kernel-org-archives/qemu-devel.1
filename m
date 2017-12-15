Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgTl-0005Ty-VT
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgTi-0000dI-QJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:16:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:15:27 -0300
Message-Id: <20171215031547.31006-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/20] SDHCI: housekeeping,
 add a qtest and fix few issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/20:[----] [-C] 'sdhci: clean up includes'
002/20:[0004] [FC] 'sdhci: use deposit64()'
003/20:[----] [--] 'sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"'
004/20:[----] [--] 'sdhci: refactor same sysbus/pci properties into a common one'
005/20:[----] [--] 'sdhci: refactor common sysbus/pci realize() into sdhci_realizefn()'
006/20:[----] [--] 'sdhci: refactor common sysbus/pci class_init() into sdhci_class_init()'
007/20:[0001] [FC] 'sdhci: refactor common sysbus/pci unrealize() into sdhci_unrealizefn()'
008/20:[----] [--] 'sdhci: use qemu_log_mask(UNIMP) instead of fprintf()'
009/20:[0004] [FC] 'sdhci: convert the DPRINT() calls into trace events'
010/20:[down] 'sdhci: add a GPIO for the access control LED'
011/20:[0032] [FC] 'sdhci: add a "dma-memory" property'
012/20:[0006] [FC] 'sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only'
013/20:[down] 'sdhci: Implement write method of ACMD12ERRSTS register'
014/20:[----] [-C] 'sdhci: add a "sd-spec-version" property'
015/20:[----] [-C] 'sdhci: some ARM boards do support SD_HOST_SPECv3_VERS'
016/20:[0001] [FC] 'sdhci: add qtest to check the SD Spec version'
017/20:[----] [--] 'sdhci: add check_capab_readonly() qtest'
018/20:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
019/20:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
020/20:[----] [--] 'sdhci: add a check_capab_v3() qtest'

Based-on: 20171213051736.17755-5-f4bug@amsat.org
          (Trivial changes in "registerfields.h")

Andrey Smirnov (1):
  sdhci: Implement write method of ACMD12ERRSTS register

Philippe Mathieu-Daudé (19):
  sdhci: clean up includes
  sdhci: use deposit64()
  sdhci: move MASK_TRNMOD with other SDHC_TRN* defines in "sd-internal.h"
  sdhci: refactor same sysbus/pci properties into a common one
  sdhci: refactor common sysbus/pci realize() into sdhci_realizefn()
  sdhci: refactor common sysbus/pci class_init() into sdhci_class_init()
  sdhci: refactor common sysbus/pci unrealize() into sdhci_unrealizefn()
  sdhci: use qemu_log_mask(UNIMP) instead of fprintf()
  sdhci: convert the DPRINT() calls into trace events
  sdhci: add a GPIO for the access control LED
  sdhci: add a "dma-memory" property
  sdhci: fix CAPAB/MAXCURR registers, both are 64bit and read-only
  sdhci: add a "sd-spec-version" property
  sdhci: some ARM boards do support SD_HOST_SPECv3_VERS
  sdhci: add qtest to check the SD Spec version
  sdhci: add check_capab_readonly() qtest
  sdhci: add a check_capab_baseclock() qtest
  sdhci: add a check_capab_sdma() qtest
  sdhci: add a check_capab_v3() qtest

 include/hw/sd/sdhci.h        |  22 +++-
 hw/sd/sdhci-internal.h       |   9 +-
 hw/arm/bcm2835_peripherals.c |   7 ++
 hw/arm/fsl-imx6.c            |   6 +
 hw/arm/xilinx_zynq.c         |   2 +
 hw/sd/sdhci.c                | 267 +++++++++++++++++++++++++------------------
 hw/sd/trace-events           |  15 +++
 tests/sdhci-test.c           | 152 ++++++++++++++++++++++++
 tests/Makefile.include       |   2 +
 9 files changed, 359 insertions(+), 123 deletions(-)
 create mode 100644 tests/sdhci-test.c

-- 
2.15.1
