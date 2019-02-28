Received: from eggs.gnu.org ([209.51.188.92]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFU-0000SA-Cr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFH-0002BZ-D4
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:29 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFA-000293-Og
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:19 -0500
Received: by mail-oi1-x242.google.com with SMTP id j135so17290274oib.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:16 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:16:51 -0600
Message-Id: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 00/19] Fix/add vmstate handling in some I2C code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org

The following changes since commit 86c7e2f4a93322a76afea5ee6806a83420d1dfea:

  Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-request' into staging (2019-02-26 17:59:41 +0000)

are available in the Git repository at:

  git://github.com/cminyard/qemu.git tags/i2c-for-release-20190228

for you to fetch changes up to c203d4514b9c8c1c3bf25988a81edf3813eb3c6d:

  i2c: Verify that the count passed in to smbus_eeprom_init() is valid (2019-02-27 21:06:08 -0600)

----------------------------------------------------------------
This has been out there long enough, I need to get this in.

This was changed a little bit since my post on Feb 20 (to which
there were no comments) due to changes I had to work around:

Change b296b664abc73253 "smbus: Add a helper to generate SPD EEPROM
data" added a function to include/hw/i2c/smbus.h, which I had to move to
include/hw/smbus_eeprom.h.

There were some changes to hw/i2c/Makefile.objs that I had to fix up.

Beyond that, no changes.

Thanks,

-corey

----------------------------------------------------------------
Corey Minyard (19):
      i2c: Split smbus into parts
      i2c: have I2C receive operation return uint8_t
      arm:i2c: Don't mask return from i2c_recv()
      i2c: Don't check return value from i2c_recv()
      i2c:smbus: Correct the working of quick commands
      i2c:smbus: Simplify write operation
      i2c:smbus: Simplify read handling
      i2c:smbus_eeprom: Get rid of the quick command
      i2c:smbus: Make white space in switch statements consistent
      boards.h: Ignore migration for SMBus devices on older machines
      i2c:pm_smbus: Fix pm_smbus handling of I2C block read
      migration: Add a VMSTATE_BOOL_TEST() macro
      i2c:pm_smbus: Fix state transfer
      i2c:smbus_slave: Add an SMBus vmstate structure
      i2c:smbus_eeprom: Add normal type name and cast to smbus_eeprom.c
      i2c:smbus_eeprom: Add a size constant for the smbus_eeprom size
      i2c:smbus_eeprom: Add vmstate handling to the smbus eeprom
      i2c:smbus_eeprom: Add a reset function to smbus_eeprom
      i2c: Verify that the count passed in to smbus_eeprom_init() is valid

 MAINTAINERS                                |  12 +
 hw/acpi/piix4.c                            |   7 +
 hw/arm/aspeed.c                            |   2 +-
 hw/arm/pxa2xx.c                            |   2 +-
 hw/arm/stellaris.c                         |   2 +-
 hw/arm/tosa.c                              |   4 +-
 hw/arm/z2.c                                |   2 +-
 hw/audio/wm8750.c                          |   2 +-
 hw/display/sii9022.c                       |   2 +-
 hw/display/ssd0303.c                       |   4 +-
 hw/gpio/max7310.c                          |   2 +-
 hw/i2c/Makefile.objs                       |   2 +-
 hw/i2c/aspeed_i2c.c                        |   9 +-
 hw/i2c/core.c                              |  32 +--
 hw/i2c/exynos4210_i2c.c                    |   8 +-
 hw/i2c/i2c-ddc.c                           |   2 +-
 hw/i2c/imx_i2c.c                           |  12 +-
 hw/i2c/pm_smbus.c                          | 119 +++++++--
 hw/i2c/smbus.c                             | 379 -----------------------------
 hw/i2c/smbus_eeprom.c                      | 136 +++++++----
 hw/i2c/smbus_ich9.c                        |  12 +-
 hw/i2c/smbus_master.c                      | 165 +++++++++++++
 hw/i2c/smbus_slave.c                       | 236 ++++++++++++++++++
 hw/i386/pc_piix.c                          |   3 +-
 hw/i386/pc_q35.c                           |   3 +-
 hw/input/lm832x.c                          |   2 +-
 hw/isa/vt82c686.c                          |   1 -
 hw/mips/mips_fulong2e.c                    |   2 +-
 hw/mips/mips_malta.c                       |   2 +-
 hw/misc/pca9552.c                          |   2 +-
 hw/misc/tmp105.c                           |   2 +-
 hw/misc/tmp421.c                           |   2 +-
 hw/nvram/eeprom_at24c.c                    |   4 +-
 hw/ppc/sam460ex.c                          |   2 +-
 hw/timer/ds1338.c                          |   2 +-
 hw/timer/m41t80.c                          |   2 +-
 hw/timer/twl92230.c                        |   2 +-
 include/hw/boards.h                        |   1 +
 include/hw/i2c/i2c.h                       |   7 +-
 include/hw/i2c/pm_smbus.h                  |  17 ++
 include/hw/i2c/smbus_eeprom.h              |  35 +++
 include/hw/i2c/{smbus.h => smbus_master.h} |  54 +---
 include/hw/i2c/smbus_slave.h               | 100 ++++++++
 include/migration/vmstate.h                |   3 +
 44 files changed, 820 insertions(+), 581 deletions(-)
 delete mode 100644 hw/i2c/smbus.c
 create mode 100644 hw/i2c/smbus_master.c
 create mode 100644 hw/i2c/smbus_slave.c
 create mode 100644 include/hw/i2c/smbus_eeprom.h
 rename include/hw/i2c/{smbus.h => smbus_master.h} (54%)
 create mode 100644 include/hw/i2c/smbus_slave.h
