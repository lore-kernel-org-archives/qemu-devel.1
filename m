Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchj-0001rx-Ok
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchg-0006a4-Kq
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:25:03 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:20 -0600
Message-Id: <20171120032420.9134-13-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 12/12] tests: add mvme3100-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Exercise some features of the mvme3100 CPLD logic
and read from the eeprom w/ VPD.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include |  3 ++
 tests/mvme3100-test.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tests/mvme3100-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ad1c219423..7ea041a885 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -372,6 +372,8 @@ check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-console-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 
+check-qtest-ppc-$(CONFIG_E500) += tests/mvme3100-test$(EXESUF)
+
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
 
@@ -781,6 +783,7 @@ tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/ac97-test$(EXESUF): tests/ac97-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
+tests/mvme3100-test$(EXESUF): tests/mvme3100-test.o $(libqos-e500-obj-y)
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
 tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
diff --git a/tests/mvme3100-test.c b/tests/mvme3100-test.c
new file mode 100644
index 0000000000..6dde8d1d29
--- /dev/null
+++ b/tests/mvme3100-test.c
@@ -0,0 +1,79 @@
+#include <stdio.h>
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/libqos.h"
+#include "libqos/i2c.h"
+
+#define assert_equal(A, B) g_assert_cmphex((A), ==, (B))
+
+static
+I2CAdapter *i2c;
+
+static
+void test_ccsr(void)
+{
+    /* CCSRBAR is self referential */
+    assert_equal(readl(0xff700000), 0x000ff700);
+
+    /* introspect memory size */
+    assert_equal(readl(0xff702080), 0x80000000);
+    /* value is (ram_size-1)>>24 */
+    assert_equal(readl(0xff702000), 15);
+}
+
+static
+void test_cpld(void)
+{
+    /* read/write to test register */
+    assert_equal(readl(0xe2000010), 0x00000000);
+    assert_equal(readl(0xe2000014), 0xffffffff);
+
+    writel(0xe2000010, 0x12345678);
+
+    assert_equal(readl(0xe2000010), 0x12345678);
+    assert_equal(readl(0xe2000014), 0x12345678 ^ 0xffffffff);
+}
+
+static
+void test_eeprom(void)
+{
+    char buf[] = "\x00\x00MOTOROLA";
+
+    /* 1. zero address pointer
+     * 2. write 8 bytes,
+     * 3. re-zero address pointer
+     */
+    i2c_send(i2c, 0xa8, (uint8_t *)buf, 10);
+    i2c_send(i2c, 0xa8, (uint8_t *)buf, 2);
+
+    /* read 8 bytes */
+    i2c_recv(i2c, 0xa8, (uint8_t *)buf, 8);
+    buf[8] = '\0';
+
+    /* Read header for Motorola VPD info */
+    g_assert_cmpstr(buf, ==, "MOTOROLA");
+}
+
+int main(int argc, char *argv[])
+{
+    int ret;
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_start("-machine mvme3100-1152");
+
+    i2c = e500_i2c_create(0xff700000);
+
+    qtest_add_func("/mvme3100/ccsr", test_ccsr);
+    qtest_add_func("/mvme3100/cpld", test_cpld);
+    qtest_add_func("/mvme3100/eeprom", test_eeprom);
+
+    ret = g_test_run();
+
+    printf("Tests done\n");
+
+    qtest_end();
+    printf("Tests end\n");
+
+    return ret;
+}
-- 
2.11.0
