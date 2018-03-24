Received: from eggs.gnu.org ([208.118.235.92]:43423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezpiu-0001aX-JH
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezphq-0003Kf-J6
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:25:08 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezomq-0005j6-7m
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id u86so211550pfd.2
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:08 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:42 -0700
Message-Id: <20180324192455.12254-2-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 01/14] tests: more thorough tests of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Test current time and set+get round trip.
Separate current time test from set/get
tests to avoid test order issues.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include      |   4 ++
 tests/ds-rtc-common.h       |  67 +++++++++++++++++++++++++
 tests/ds-rtc-current-test.c |  59 ++++++++++++++++++++++
 tests/ds-rtc-set-test.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 tests/ds-rtc-common.h
 create mode 100644 tests/ds-rtc-current-test.c
 create mode 100644 tests/ds-rtc-set-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb218a9539..d256095c88 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -372,6 +372,8 @@ check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
+check-qtest-arm-y += tests/ds-rtc-current-test$(EXESUF)
+check-qtest-arm-y += tests/ds-rtc-set-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 gcov-files-arm-y += hw/misc/tmp105.c
 check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
@@ -771,6 +773,8 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
+tests/ds-rtc-current-test$(EXESUF): tests/ds-rtc-current-test.o $(libqos-imx-obj-y)
+tests/ds-rtc-set-test$(EXESUF): tests/ds-rtc-set-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
new file mode 100644
index 0000000000..c8e6c2bc5b
--- /dev/null
+++ b/tests/ds-rtc-common.h
@@ -0,0 +1,67 @@
+/* Common code for testing of Dallas/Maxim I2C bus RTC devices
+ *
+ * Copyright (c) 2018 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ */
+#ifndef DSRTCCOMMON_H
+#define DSRTCCOMMON_H
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "libqos/i2c.h"
+
+#define IMX25_I2C_0_BASE 0x43F80000
+#define DS1338_ADDR 0x68
+
+static I2CAdapter *i2c;
+static uint8_t addr;
+static bool use_century;
+
+/* input buffer must have at least 7 elements */
+static inline time_t rtc_parse(const uint8_t *buf)
+{
+    struct tm parts;
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
+static time_t rtc_gettime(void)
+{
+    uint8_t buf[7];
+
+    /* zero address pointer */
+    buf[0] = 0;
+    i2c_send(i2c, addr, buf, 1);
+    /* read back current time registers */
+    i2c_recv(i2c, addr, buf, 7);
+
+    return rtc_parse(buf);
+}
+
+#endif /* DSRTCCOMMON_H */
diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
new file mode 100644
index 0000000000..6acbbed9a6
--- /dev/null
+++ b/tests/ds-rtc-current-test.c
@@ -0,0 +1,59 @@
+/* Testing of Dallas/Maxim I2C bus RTC devices
+ *
+ * Copyright (c) 2018 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ */
+#include <stdio.h>
+
+#include "qemu/osdep.h"
+#include "qemu/bcd.h"
+#include "qemu/cutils.h"
+#include "libqtest.h"
+#include "libqos/libqos.h"
+#include "libqos/i2c.h"
+
+#include "ds-rtc-common.h"
+
+/* read back and compare with current system time */
+static
+void test_rtc_current(void)
+{
+    time_t expected, actual;
+    /* relax test to limit false positives when host may be overloaded.
+     * Allow larger delta when running "-m quick"
+     */
+    time_t max_delta = g_test_slow() ? 1 : 30;
+
+    actual = time(NULL);
+    /* new second may start here */
+    expected = rtc_gettime();
+    g_assert_cmpuint(expected, <=, actual + max_delta);
+    g_assert_cmpuint(expected, >=, actual);
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
+        s = qtest_start("-machine imx25-pdk");
+        i2c = imx_i2c_create(s, IMX25_I2C_0_BASE);
+        addr = DS1338_ADDR;
+        use_century = false;
+
+    }
+
+    qtest_add_func("/ds-rtc-i2c/current", test_rtc_current);
+
+    ret = g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
new file mode 100644
index 0000000000..35e1a36281
--- /dev/null
+++ b/tests/ds-rtc-set-test.c
@@ -0,0 +1,117 @@
+/* Testing of Dallas/Maxim I2C bus RTC devices
+ *
+ * Copyright (c) 2018 Michael Davidsaver
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
+#include "ds-rtc-common.h"
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
+    /* relax test to limit false positives when host may be overloaded.
+     * Allow larger delta when running "-m quick"
+     */
+    time_t max_delta = g_test_slow() ? 1 : 30;
+
+    const uint8_t *testtime = raw;
+    time_t expected, actual;
+
+    /* skip address pointer and parse remainder */
+    expected = rtc_parse(&testtime[1]);
+
+    i2c_send(i2c, addr, testtime, 8);
+    /* host may start new second here */
+    actual = rtc_gettime();
+
+    g_assert_cmpuint(expected, <=, actual);
+    g_assert_cmpuint(expected + max_delta, >=, actual);
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
+
+    ret = g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
-- 
2.11.0
