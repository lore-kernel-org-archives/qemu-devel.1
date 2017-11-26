Received: from eggs.gnu.org ([2001:4830:134:3::10]:56884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xs-00075N-RL
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xo-0002tt-Cv
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:52 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:04 -0600
Message-Id: <027efd940a2268e69d9d6d0363858688b22baf11.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 06/17] tests: rewrite testing for DS RTC devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Replace existing ds1338-test with more thorough
test of time read and set.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include  |   4 +-
 tests/ds-rtc-i2c-test.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ds1338-test.c     |  77 -----------------------
 3 files changed, 164 insertions(+), 79 deletions(-)
 create mode 100644 tests/ds-rtc-i2c-test.c
 delete mode 100644 tests/ds1338-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ad1c219423..56045cdf09 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -348,7 +348,7 @@ check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
-check-qtest-arm-y += tests/ds1338-test$(EXESUF)
+check-qtest-arm-y += tests/ds-rtc-i2c-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 gcov-files-arm-y += hw/misc/tmp105.c
 check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
@@ -745,7 +745,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
-tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
new file mode 100644
index 0000000000..0586dbd467
--- /dev/null
+++ b/tests/ds-rtc-i2c-test.c
@@ -0,0 +1,162 @@
+/* Testing of Dallas/Maxim I2C bus RTC devices
+ *
+ * Copyright (c) 2017 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ */
+#include <stdio.h>
+
+#include "qemu/osdep.h"
+#include "qemu/bcd.h"
+#include "qemu/cutils.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+#include "libqos/libqos.h"
+#include "libqos/i2c.h"
+
+#define IMX25_I2C_0_BASE 0x43F80000
+#define DS1338_ADDR 0x68
+
+static I2CAdapter *i2c;
+static uint8_t addr;
+static bool use_century;
+
+static
+time_t rtc_gettime(void)
+{
+    struct tm parts;
+    uint8_t buf[7];
+
+    buf[0] = 0;
+    i2c_send(i2c, addr, buf, 1);
+    i2c_recv(i2c, addr, buf, 7);
+
+    parts.tm_sec = from_bcd(buf[0]);
+    parts.tm_min = from_bcd(buf[1]);
+    if (buf[2] & 0x40) {
+        /* 12 hour */
+        parts.tm_hour = from_bcd(buf[2] & 0x1f) % 12u;
+        if (buf[2] & 0x20) {
+            parts.tm_hour += 12u;
+        }
+    } else {
+        /* 24 hour */
+        parts.tm_hour = from_bcd(buf[2] & 0x3f);
+    }
+    parts.tm_wday = from_bcd(buf[3]);
+    parts.tm_mday = from_bcd(buf[4]);
+    parts.tm_mon =  from_bcd((buf[5] & 0x1f) - 1u);
+    parts.tm_year = from_bcd(buf[6]);
+    if (!use_century || (buf[5] & 0x80)) {
+        parts.tm_year += 100u;
+    }
+
+    return mktimegm(&parts);
+}
+
+/* read back and compare with current system time */
+static
+void test_rtc_current(void)
+{
+    uint8_t buf;
+    time_t expected, actual;
+
+    /* magic address to zero RTC time offset
+     * as tests may be run in any order
+     */
+    buf = 0xff;
+    i2c_send(i2c, addr, &buf, 1);
+
+    actual = time(NULL);
+    /* new second may start here */
+    expected = rtc_gettime();
+    g_assert_cmpuint(expected, <=, actual + 1);
+    g_assert_cmpuint(expected, >=, actual);
+}
+
+
+static uint8_t test_time_24[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 18:30:53 +0000 */
+    0x53,
+    0x30,
+    0x18, /* 6 PM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
+static uint8_t test_time_12[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 18:30:53 +0000 */
+    0x53,
+    0x30,
+    0x67, /* 6 PM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
+/* write in and read back known time */
+static
+void test_rtc_set(const void *raw)
+{
+    const uint8_t *testtime = raw;
+    uint8_t buf[7];
+    unsigned retry = 2;
+
+    for (; retry; retry--) {
+        i2c_send(i2c, addr, testtime, 8);
+        /* new second may start here */
+        i2c_send(i2c, addr, testtime, 1);
+        i2c_recv(i2c, addr, buf, 7);
+
+        if (testtime[1] == buf[0]) {
+            break;
+        }
+        /* we raced start of second, retry */
+    };
+
+    g_assert_cmpuint(testtime[1], ==, buf[0]);
+    g_assert_cmpuint(testtime[2], ==, buf[1]);
+    g_assert_cmpuint(testtime[3], ==, buf[2]);
+    g_assert_cmpuint(testtime[4], ==, buf[3]);
+    g_assert_cmpuint(testtime[5], ==, buf[4]);
+    if (use_century) {
+        g_assert_cmpuint(testtime[6], ==, buf[5]);
+    } else {
+        g_assert_cmpuint(testtime[6] & 0x7f, ==, buf[5]);
+    }
+    g_assert_cmpuint(testtime[7], ==, buf[6]);
+
+    g_assert_cmpuint(retry, >, 0);
+}
+
+int main(int argc, char *argv[])
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "arm") == 0) {
+        qtest_start("-display none -machine imx25-pdk");
+        i2c = imx_i2c_create(IMX25_I2C_0_BASE);
+        addr = DS1338_ADDR;
+        use_century = false;
+
+    }
+
+    qtest_add_data_func("/ds-rtc-i2c/set24", test_time_24, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12", test_time_12, test_rtc_set);
+    qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
+
+    ret = g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
deleted file mode 100644
index 26968bc82a..0000000000
--- a/tests/ds1338-test.c
+++ /dev/null
@@ -1,77 +0,0 @@
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
-    i2c = imx_i2c_create(IMX25_I2C_0_BASE);
-    addr = DS1338_ADDR;
-
-    qtest_add_func("/ds1338/tx-rx", send_and_receive);
-
-    ret = g_test_run();
-
-    if (s) {
-        qtest_quit(s);
-    }
-    g_free(i2c);
-
-    return ret;
-}
-- 
2.11.0
