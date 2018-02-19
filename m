Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgk-0007jr-Nh
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgj-0000w9-H2
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:26 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1encgj-0000vE-CT
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:25 -0500
Received: by mail-it0-x242.google.com with SMTP id v194so7420047itb.0
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 20:04:25 -0800 (PST)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 18 Feb 2018 20:03:42 -0800
Message-Id: <20180219040342.12686-6-mdavidsaver@gmail.com>
In-Reply-To: <20180219040342.12686-1-mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 5/5] tests: drop ds1338-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Brook <paul@codesourcery.com>, Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Now redundant to ds-rtc-i2c-test.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include |  2 --
 tests/ds1338-test.c    | 75 --------------------------------------------------
 2 files changed, 77 deletions(-)
 delete mode 100644 tests/ds1338-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f5dcd274e0..8b1e486e32 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -359,7 +359,6 @@ check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
-check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/ds-rtc-i2c-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 gcov-files-arm-y += hw/misc/tmp105.c
@@ -764,7 +763,6 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
-tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
deleted file mode 100644
index 742dad9113..0000000000
--- a/tests/ds1338-test.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * QTest testcase for the DS1338 RTC
- *
- * Copyright (c) 2013 Jean-Christophe Dubois
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "libqtest.h"
-#include "libqos/i2c.h"
-
-#define IMX25_I2C_0_BASE 0x43F80000
-
-#define DS1338_ADDR 0x68
-
-static I2CAdapter *i2c;
-static uint8_t addr;
-
-static inline uint8_t bcd2bin(uint8_t x)
-{
-    return ((x) & 0x0f) + ((x) >> 4) * 10;
-}
-
-static void send_and_receive(void)
-{
-    uint8_t cmd[1];
-    uint8_t resp[7];
-    time_t now = time(NULL);
-    struct tm *tm_ptr = gmtime(&now);
-
-    /* reset the index in the RTC memory */
-    cmd[0] = 0;
-    i2c_send(i2c, addr, cmd, 1);
-
-    /* retrieve the date */
-    i2c_recv(i2c, addr, resp, 7);
-
-    /* check retrieved time againt local time */
-    g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
-    g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
-    g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
-}
-
-int main(int argc, char **argv)
-{
-    QTestState *s = NULL;
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-
-    s = qtest_start("-display none -machine imx25-pdk");
-    i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
-    addr = DS1338_ADDR;
-
-    qtest_add_func("/ds1338/tx-rx", send_and_receive);
-
-    ret = g_test_run();
-
-    qtest_quit(s);
-    g_free(i2c);
-
-    return ret;
-}
-- 
2.11.0
