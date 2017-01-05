Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmH-0001gb-Kr
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmE-0001PX-44
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cOzmD-0001O9-QZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v054Xi59016473
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 23:35:44 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27sa7ramgw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:35:44 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 5 Jan 2017 14:35:41 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu,  5 Jan 2017 15:34:23 +1100
Message-Id: <20170105043430.3176-1-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/7] Add support for the Epson RX8900 RTC to
 the aspeed board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch series adds support for the Epson RX8900 RTC to the
Aspeed board.

The tests use the existing imx25 infrastructure, and some minor
changes have been made to uniquely identify the I2C buses.

Support for named interrupts has been implemented in qtest to
facilitate testing.

Changelog:
v5:
 - Use time functions for time manipulation (note: check-patch
   incorrectly reports an error on timercmp())
 - Refactor weekday validation
 - Defer time offset calculation until the I2C transaction is
   complete as partial updates can result in incorrect offsets
 - Cosmetic changes as requested by Adrew Jeffery
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

Alastair D'Silva (7):
  arm: Uniquely name imx25 I2C buses.
  qtest: Support named interrupts
  qtest: Support setting named GPIOs
  qtest: Fix whitespace
  hw/timer: Add Epson RX8900 RTC support
  tests: Test all implemented RX8900 functionality
  arm: Add an RX8900 RTC to the ASpeed board

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |  29 ++
 hw/arm/imx25_pdk.c              |   2 +-
 hw/core/irq.c                   |  18 +-
 hw/i2c/imx_i2c.c                |   2 +-
 hw/timer/Makefile.objs          |   2 +
 hw/timer/rx8900.c               | 914 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/rx8900_regs.h          | 141 +++++++
 hw/timer/trace-events           |  31 ++
 include/hw/irq.h                |  13 +-
 qtest.c                         | 103 +++--
 tests/Makefile.include          |   2 +
 tests/libqtest.c                |  85 +++-
 tests/libqtest.h                |  59 +++
 tests/rx8900-test.c             | 880 ++++++++++++++++++++++++++++++++++++++
 15 files changed, 2241 insertions(+), 41 deletions(-)
 create mode 100644 hw/timer/rx8900.c
 create mode 100644 hw/timer/rx8900_regs.h
 create mode 100644 tests/rx8900-test.c

-- 
2.9.3
