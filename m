Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOuj-0006rL-NE
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOug-0003FC-6p
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60369
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cHOug-0003Ef-0s
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF5mimH073713
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:05 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdmesvrm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:05 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 15 Dec 2016 15:49:02 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu, 15 Dec 2016 16:48:04 +1100
Message-Id: <20161215054812.12602-1-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/8] Add support for the Epson RX8900 RTC to
 the aspeed board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch series adds support for the Epson RX8900 RTC to the
Aspeed board.

The tests use the existing imx25 infrastructure, and some minor
changes have been made to uniquely identify the I2C buses.

Support for named interrupts has been implemented in qtest to
facilitate testing.

Changelog:
v4:
 - Split overloaded patches
 - Fix spelling of Celsius
 - Remove degrees sign from messages
 - Don't force float precision
 - Reformat named interrupt qtest protocol for consistency
 - Minor formatting changes
 - Don't connect the RX8900 INT line to NVIC:22, it should be
   connected to GPIOJ10 on the ASPEED SOC
v3:
 - Add range checks for time components
 - Shorten trace messages
 - Use qemu generated i2c bus names
 - Address style comments from Alexey for rx8900 driver
 - Fix long lines in qtest harness
 - Remove trailing whitespace in hw/arm/pxa
 - Remove stray headers from rx8900 driver
 - Support low voltage detection in rx8900 driver
v2:
 - Avoid using error_report
 - Fix TIE behaviour
 - Move temperature init out of reset, it should not change
   on a soft reset
 - Fix IRQ in test failures
 - Add a NULL check for i2c slave init callbacks, so that we
   no longer need to implement empty init functions.
 - Refactor to use the existing qemu trace infrastructure
 - Move the RX8900 definition into the aspeed machine init
 - It it possible for check_update_interrupt_seconds in the
   rx8900 test to return 6, depending on the alignment with
   the wall clock.
 - Support low voltage detection

Alastair D'Silva (8):
  arm: Uniquely name imx25 I2C buses.
  qtest: Support named interrupts
  qtest: Support setting named GPIOs
  qtest: Fix whitespace
  hw/i2c: Tidy up NULL check for i2c slave init callbacks
  hw/timer: Add Epson RX8900 RTC support
  tests: Test all implemented RX8900 functionality
  arm: Add an RX8900 RTC to the ASpeed board

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |  29 ++
 hw/arm/imx25_pdk.c              |   2 +-
 hw/core/irq.c                   |  18 +-
 hw/i2c/core.c                   |   4 +-
 hw/i2c/imx_i2c.c                |   2 +-
 hw/timer/Makefile.objs          |   2 +
 hw/timer/rx8900.c               | 912 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/rx8900_regs.h          | 141 +++++++
 hw/timer/trace-events           |  31 ++
 include/hw/irq.h                |  13 +-
 qtest.c                         | 103 +++--
 tests/Makefile.include          |   2 +
 tests/libqtest.c                |  85 +++-
 tests/libqtest.h                |  59 +++
 tests/rx8900-test.c             | 882 ++++++++++++++++++++++++++++++++++++++
 16 files changed, 2243 insertions(+), 43 deletions(-)
 create mode 100644 hw/timer/rx8900.c
 create mode 100644 hw/timer/rx8900_regs.h
 create mode 100644 tests/rx8900-test.c

-- 
2.9.3
