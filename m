Received: from eggs.gnu.org ([2001:4830:134:3::10]:48582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo0q-00059v-Hl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo0n-0002vf-At
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:36 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo0n-0002ux-5g
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:08:33 -0500
Received: by mail-qt0-x244.google.com with SMTP id g14so16927043qti.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 18:08:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 23:08:04 -0300
Message-Id: <20180123020820.1288-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 00/16] SDHCI: clean v1/v2 Specs (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

Since v8:
- we keep the 'capareg' property, this simplify a lot the series
- the Zynq 7000 uses the datasheet CAPAREG
- reset R-b/A-b

Since v7:
- use error_propagate()

Since v6:
- rebased on upstream to use DEFINE_SDHCI_COMMON_PROPERTIES
- included qtests back
- add PCI qtests
- series was getting big, splitting again; next one is "implement Spec v3"
- following Alistair advice, new properties default to current
  SDHC_CAPAB_REG_DEFAULT (probably 'default' for historical reason, being
  the first capabilities set). This leads to weird properties imho, i.e.
  defaulting 'max-frequency' to 52 MHz, the Exynos SoC has to set this
  property to 0. 
- addressed Alistair reviews
- confirmed the Exynos4210 specs after chatting on IRC with Krzysztof
  Kozlowski who kindly verified in the datasheet.

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

$ git backport-diff with v8
001/16:[----] [--] 'sdhci: use error_propagate(local_err) in realize()'
002/16:[0004] [FC] 'sdhci: add qtest to check the SD capabilities register'
003/16:[----] [--] 'sdhci: add check_capab_readonly() qtest'
004/16:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
005/16:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
006/16:[----] [--] 'sdhci: add qtest to check the SD Spec version'
007/16:[0022] [FC] 'sdhci: add a 'spec_version property' (default to v2)'
008/16:[down] 'sdhci: use a numeric value for the default CAPAB register'
009/16:[down] 'sdhci: simplify sdhci_get_fifolen()'
010/16:[down] 'sdhci: check the Spec v1 capabilities correctness'
011/16:[----] [--] 'sdhci: add BLOCK_SIZE_MASK for DMA'
012/16:[----] [--] 'sdhci: Fix 64-bit ADMA2'
013/16:[down] 'sdhci: check Spec v2 capabilities (DMA and 64-bit bus)'
014/16:[down] 'hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()'
015/16:[down] 'hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)'
016/16:[down] 'hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet'

Philippe Mathieu-Daudé (15):
  sdhci: use error_propagate(local_err) in realize()
  sdhci: add qtest to check the SD capabilities register
  sdhci: add check_capab_readonly() qtest
  sdhci: add a check_capab_baseclock() qtest
  sdhci: add a check_capab_sdma() qtest
  sdhci: add qtest to check the SD Spec version
  sdhci: add a 'spec_version property' (default to v2)
  sdhci: use a numeric value for the default CAPAB register
  sdhci: simplify sdhci_get_fifolen()
  sdhci: check the Spec v1 capabilities correctness
  sdhci: add BLOCK_SIZE_MASK for DMA
  sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
  hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()
  hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)
  hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet

Sai Pavan Boddu (1):
  sdhci: Fix 64-bit ADMA2

 include/hw/sd/sdhci.h  |   2 +
 hw/sd/sdhci-internal.h |  43 ++++++---
 hw/arm/exynos4210.c    |  14 ++-
 hw/arm/xilinx_zynq.c   |  53 +++++-----
 hw/sd/sdhci.c          | 257 ++++++++++++++++++++++++++++++++-----------------
 tests/sdhci-test.c     | 216 +++++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events     |   1 +
 tests/Makefile.include |   3 +
 8 files changed, 464 insertions(+), 125 deletions(-)
 create mode 100644 tests/sdhci-test.c

-- 
2.15.1
