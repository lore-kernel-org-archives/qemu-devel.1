Received: from eggs.gnu.org ([2001:4830:134:3::10]:44146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquz-0000ov-Iy
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquy-0003zh-75
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:49 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquy-0003z9-29
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:48 -0500
Received: by mail-qt0-x243.google.com with SMTP id a16so3882041qtj.3
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:49:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:49:25 -0300
Message-Id: <20180103214925.16677-5-f4bug@amsat.org>
In-Reply-To: <20180103214925.16677-1-f4bug@amsat.org>
References: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 4/4] tests: add some sdcard qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdbus-test.c     | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   2 +
 2 files changed, 153 insertions(+)
 create mode 100644 tests/sdbus-test.c

diff --git a/tests/sdbus-test.c b/tests/sdbus-test.c
new file mode 100644
index 0000000000..9c38be13cb
--- /dev/null
+++ b/tests/sdbus-test.c
@@ -0,0 +1,151 @@
+/*
+ * QTest testcase for the SD/MMC cards
+ *
+ * Copyright (c) 2017 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/cutils.h"
+
+#include "libqtest.h"
+#include "libqos/sdbus.h"
+
+enum {
+    PROTO_SD,
+    PROTO_MMC,
+    PROTO_SPI,
+    PROTO_COUNT
+};
+
+static const char *proto_name[PROTO_COUNT] = {
+    [PROTO_SD]  = "sd",
+    [PROTO_MMC] = "mmc",
+    [PROTO_SPI] = "spi"
+};
+
+static const char *machines[PROTO_COUNT] = {
+    [PROTO_SD] = "nuri",
+    //[PROTO_MMC] = "vexpress-a9",
+    //[PROTO_SPI] = "lm3s6965evb"
+};
+
+static const uint64_t sizes[] = {
+    //512 * M_BYTE,
+    //1 * G_BYTE,
+    4 * G_BYTE,
+    //64 * G_BYTE,
+};
+
+typedef struct {
+    int protocol;
+    uint64_t size;
+} TestCase;
+
+static void test1(SDBusAdapter *mmc, uint64_t size)
+{
+    uint8_t *response;
+    uint16_t rca;
+    ssize_t sz;
+
+    sz = sdbus_do_cmd(mmc, GO_IDLE_STATE, 0, NULL);
+    g_assert_cmpuint(sz, ==, 0);
+
+    sz = sdbus_do_cmd(mmc, SEND_IF_COND, 0x1aa, NULL);
+    //g_assert_cmpuint(sz, ==, 0);
+
+    sz = sdbus_do_acmd(mmc, SEND_OP_COND, 0x40300000, 0, NULL);
+    g_assert_cmpuint(sz, ==, 4);
+
+    /* CID */
+    sz = sdbus_do_cmd(mmc, ALL_SEND_CID, 0, &response);
+    g_assert_cmpuint(sz, ==, 16);
+    g_assert_cmpmem (&response[3], 5, "QEMU!", 5);
+    g_assert_cmphex(be32_to_cpu(*(uint32_t *)&response[9]), ==, 0xdeadbeef);
+    g_free(response);
+
+    /* RCA */
+    sz = sdbus_do_cmd(mmc, SEND_RELATIVE_ADDR, 0, &response);
+    g_assert_cmpuint(sz, ==, 4);
+    rca = be16_to_cpu(*(uint16_t *)response);
+    g_assert_cmphex(rca, ==, 0x4567);
+    g_free(response);
+
+    /* CSD */
+    sz = sdbus_do_cmd(mmc, SEND_CSD, rca << 16, &response);
+    g_assert_cmpuint(sz, ==, 16);
+    g_assert_cmphex(response[3], ==, 0x32);
+    g_assert_cmphex(response[4], ==, 0x5b); /* class */
+    g_assert_cmphex(response[5], ==, 0x59);
+    /* (SDHC test) */
+    g_assert_cmphex(be32_to_cpu(*(uint32_t *)&response[6]),
+                    ==, (size >> 19) - 1);
+    g_assert_cmphex(response[10], ==, 0x7f);
+    g_assert_cmphex(response[11], ==, 0x80);
+    g_assert_cmphex(response[12], ==, 0x0a);
+    g_assert_cmphex(response[13], ==, 0x40);
+    g_assert_cmphex(response[14], ==, 0);
+    g_assert_cmphex(response[15], ==, 0);
+    g_free(response);
+
+    sz = sdbus_do_cmd(mmc, SELECT_CARD, rca << 16, NULL);
+
+    sz = sdbus_do_acmd(mmc, SEND_SCR, 0, rca, &response);
+    g_assert_cmpuint(sz, ==, 4);
+    g_free(response);
+
+    // TODO 8x: sdcard_read_data len 512
+
+    //sz = sdbus_do_acmd(mmc, SEND_STATUS, 0, rca, &response);
+    //g_free(response);
+}
+
+static void sdcard_tests(gconstpointer data)
+{
+    const TestCase *test = data;
+    SDBusAdapter *sdbus;
+
+    global_qtest = qtest_startf("-machine %s "
+                         "-drive if=sd,driver=null-co,size=%lu,id=mmc0",
+                         machines[test->protocol], test->size);
+    sdbus = qmp_sdbus_create("sd-bus");
+
+    test1(sdbus, test->size);
+    g_free(sdbus);
+
+    qtest_quit(global_qtest);
+}
+
+int main(int argc, char **argv)
+{
+    const char *arch = qtest_get_arch();
+    int iproto, isize;
+    gchar *path;
+    TestCase *test;
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "arm") == 0 || strcmp(arch, "aarch64") == 0) {
+        for (iproto = 0; iproto < PROTO_COUNT; iproto++) {
+            if (!machines[iproto]) {
+                continue;
+            }
+            for (isize = 0; isize < ARRAY_SIZE(sizes); isize++) {
+                test = g_new(TestCase, 1);
+
+                test->protocol = iproto;
+                test->size = sizes[isize];
+
+                path = g_strdup_printf("sdcard/%s/%lu", proto_name[iproto], sizes[isize]);
+                qtest_add_data_func(path, test, sdcard_tests);
+                g_free(path);
+                // g_free(test)?
+            }
+        }
+    }
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 409784a189..e4434cdfff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -348,6 +348,7 @@ check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
+check-qtest-arm-y = tests/sdbus-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 gcov-files-arm-y += hw/misc/tmp105.c
@@ -748,6 +749,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
+tests/sdbus-test$(EXESUF): tests/sdbus-test.o $(libqos-obj-y)
 tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
-- 
2.15.1
