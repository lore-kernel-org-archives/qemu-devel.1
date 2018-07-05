Received: from eggs.gnu.org ([2001:4830:134:3::10]:58163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rx-0004bo-Vc
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8ru-0006Lc-Gj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:41 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8ru-0006LE-Aa
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:38 -0400
Received: by mail-pl0-x243.google.com with SMTP id y8-v6so1625896plr.9
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:38 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:20:01 -0700
Message-Id: <20180705182001.16537-15-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 14/14] tests: drop ds1338-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

redundant to ds-rtc-*-test.c

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include |  2 --
 tests/ds1338-test.c    | 75 --------------------------------------------------
 2 files changed, 77 deletions(-)
 delete mode 100644 tests/ds1338-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6ce5a9ff4d..8cf438260b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -377,7 +377,6 @@ check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/pca9552-test$(EXESUF)
-check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/ds-rtc-current-test$(EXESUF)
 check-qtest-arm-y += tests/ds-rtc-set-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
@@ -788,7 +787,6 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
-tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/ds-rtc-current-test$(EXESUF): tests/ds-rtc-current-test.o $(libqos-imx-obj-y)
 tests/ds-rtc-set-test$(EXESUF): tests/ds-rtc-set-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
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
