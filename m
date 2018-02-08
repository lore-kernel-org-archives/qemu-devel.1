Received: from eggs.gnu.org ([2001:4830:134:3::10]:41757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNF-0007ZW-Q4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNC-0003Ij-Ke
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:37 -0500
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:34909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejpNC-0003Hn-Dv
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:48:34 -0500
Received: by mail-qt0-x233.google.com with SMTP id g14so6982031qti.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:48:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Feb 2018 13:47:48 -0300
Message-Id: <20180208164818.7961-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 00/30] SDHCI: clean v1/2 Specs,
 UHS-I cards tuning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

This series is expected to be taken by Paolo (he plan to fix few things).

It includes the last versions of both series:
- SDHCI: clean v1/v2 Specs (part 2)
- SDHCI: add tuning sequence for UHS-I cards (part 3)

Since v10:
- rebased
- add Paolo's R-b in patch 2
- rename patch 11 subject (Alistair)
- add Alistair's R-b in "UHS-I cards tuning sequence" patches

Thanks Paolo!

Phil.

$ git backport-diff with v10
001/30:[----] [--] 'sdhci: use error_propagate(local_err) in realize()'
002/30:[----] [--] 'sdhci: add qtest to check the SD capabilities register'
003/30:[----] [--] 'sdhci: add check_capab_readonly() qtest'
004/30:[----] [--] 'sdhci: add a check_capab_baseclock() qtest'
005/30:[----] [--] 'sdhci: add a check_capab_sdma() qtest'
006/30:[----] [--] 'sdhci: add qtest to check the SD Spec version'
007/30:[----] [--] 'sdhci: add a 'spec_version property' (default to v2)'
008/30:[----] [--] 'sdhci: use a numeric value for the default CAPAB register'
009/30:[----] [--] 'sdhci: simplify sdhci_get_fifolen()'
010/30:[----] [--] 'sdhci: check the Spec v1 capabilities correctness'
011/30:[down] 'sdhci: replace DMA magic value by BLOCK_SIZE_MASK'
012/30:[----] [--] 'sdhci: Fix 64-bit ADMA2'
013/30:[----] [--] 'sdhci: check Spec v2 capabilities (DMA and 64-bit bus)'
014/30:[----] [--] 'hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()'
015/30:[----] [--] 'hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)'
016/30:[----] [--] 'hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet'
$ git backport-diff with v9
017/30:[----] [--] 'sdhci: add support for v3 capabilities'
018/30:[----] [--] 'sdhci: rename the hostctl1 register'
019/30:[----] [--] 'sdhci: implement the Host Control 2 register (tuning sequence)'
020/30:[----] [--] 'sdbus: add trace events'
021/30:[----] [--] 'sdhci: implement UHS-I voltage switch'
022/30:[----] [--] 'sdhci: implement CMD/DAT[] fields in the Present State register'
023/30:[0002] [FC] 'hw/arm/bcm2835_peripherals: implement SDHCI Spec v3'
024/30:[----] [--] 'hw/arm/bcm2835_peripherals: change maximum block size to 1kB'
025/30:[----] [--] 'hw/arm/fsl-imx6: implement SDHCI Spec. v3'
026/30:[----] [-C] 'hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet'
027/30:[----] [--] 'hw/arm/xilinx_zynqmp: enable the UHS-I mode'
028/30:[----] [-C] 'sdhci: check Spec v3 capabilities qtest'
029/30:[0006] [FC] 'sdhci: add a check_capab_v3() qtest'
030/30:[----] [--] 'sdhci: add Spec v4.2 register definitions'

Philippe Mathieu-Daudé (29):
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
  sdhci: replace DMA magic value by BLOCK_SIZE_MASK
  sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
  hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()
  hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)
  hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet
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

Sai Pavan Boddu (1):
  sdhci: Fix 64-bit ADMA2

 include/hw/sd/sd.h           |  20 +++
 include/hw/sd/sdhci.h        |   6 +-
 hw/sd/sdhci-internal.h       |  77 +++++++--
 hw/arm/bcm2835_peripherals.c |  23 +--
 hw/arm/exynos4210.c          |  14 +-
 hw/arm/fsl-imx6.c            |   7 +
 hw/arm/xilinx_zynq.c         |  53 ++++---
 hw/arm/xlnx-zynqmp.c         |  30 ++--
 hw/sd/core.c                 |  61 ++++++-
 hw/sd/sd.c                   |  29 ++++
 hw/sd/sdhci.c                | 367 +++++++++++++++++++++++++++++++------------
 hw/sd/trace-events           |   9 ++
 tests/sdhci-test.c           | 246 +++++++++++++++++++++++++++++
 tests/Makefile.include       |   4 +
 14 files changed, 790 insertions(+), 156 deletions(-)
 create mode 100644 tests/sdhci-test.c

-- 
2.16.1
