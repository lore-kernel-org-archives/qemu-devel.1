Received: from eggs.gnu.org ([2001:4830:134:3::10]:49501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgV-0007Z3-1q
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgT-0000TK-Mw
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:11 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:52331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1encgT-0000TB-HN
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:09 -0500
Received: by mail-it0-x241.google.com with SMTP id o13so7693085ito.2
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 20:04:09 -0800 (PST)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 18 Feb 2018 20:03:39 -0800
Message-Id: <20180219040342.12686-3-mdavidsaver@gmail.com>
In-Reply-To: <20180219040342.12686-1-mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 2/5] tests: more thorough test of ds1338
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

Test current time and set+get round trip.

The set+get test is repeated 4 times.  These cases are
spread across a single day in an attempt to trigger some potential
issues regardless of the timezone of the machine running the tests.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include  |   2 +
 tests/ds-rtc-i2c-test.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tests/ds-rtc-i2c-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a1bcbffe12..f5dcd274e0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -360,6 +360,7 @@ check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
+check-qtest-arm-y += tests/ds-rtc-i2c-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 gcov-files-arm-y += hw/misc/tmp105.c
 check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
@@ -764,6 +765,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
new file mode 100644
index 0000000000..464eb08558
--- /dev/null
+++ b/tests/ds-rtc-i2c-test.c
@@ -0,0 +1,193 @@
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
+        /* HOUR register is 1-12. */
+        parts.tm_hour = from_bcd(buf[2] & 0x1f);
+        g_assert_cmpuint(parts.tm_hour, >=, 1);
+        g_assert_cmpuint(parts.tm_hour, <=, 12);
+        parts.tm_hour %= 12u; /* wrap 12 -> 0 */
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
+static uint8_t test_time_24_12am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 00:30:53 +0000 */
+    0x53,
+    0x30,
+    0x00, /* 12 AM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
+static uint8_t test_time_24_6am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 06:30:53 +0000 */
+    0x53,
+    0x30,
+    0x06, /* 6 AM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
+static uint8_t test_time_24_12pm[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 12:30:53 +0000 */
+    0x53,
+    0x30,
+    0x12, /* 12 PM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
+static uint8_t test_time_24_6pm[8] = {
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
+    g_assert_cmpuint(testtime[1], ==, buf[0]); /* SEC */
+    g_assert_cmpuint(testtime[2], ==, buf[1]); /* MIN */
+    g_assert_cmpuint(testtime[3], ==, buf[2]); /* HOUR */
+    /* skip comparing Day of Week.  Not handled correctly */
+    g_assert_cmpuint(testtime[5], ==, buf[4]); /* DoM */
+    if (use_century) {
+        g_assert_cmpuint(testtime[6], ==, buf[5]); /* MON+century */
+    } else {
+        g_assert_cmpuint(testtime[6] & 0x7f, ==, buf[5]); /* MON */
+    }
+    g_assert_cmpuint(testtime[7], ==, buf[6]); /* YEAR */
+
+    g_assert_cmpuint(retry, >, 0);
+}
+
+int main(int argc, char *argv[])
+{
+    int ret;
+    const char *arch = qtest_get_arch();
+    QTestState *s = NULL;
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "arm") == 0) {
+        s = qtest_start("-display none -machine imx25-pdk");
+        i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
+        addr = DS1338_ADDR;
+        use_century = false;
+
+    }
+
+    qtest_add_data_func("/ds-rtc-i2c/set24_12am", test_time_24_12am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, test_rtc_set);
+    qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
+
+    ret = g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
-- 
2.11.0
