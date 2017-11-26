Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4y9-0007Rn-JO
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4y1-00032u-UA
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 17:00:09 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:14 -0600
Message-Id: <890b7a4e88ca271acd6f19ce20a7979fbac424ae.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 16/17] tests: run ds-rtc-i2c-test w/
 ppc/mvme3100
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

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include  | 3 ++-
 tests/ds-rtc-i2c-test.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 56045cdf09..062d4e5b7b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -308,6 +308,7 @@ check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
+check-qtest-ppc-y += tests/ds-rtc-i2c-test$(EXESUF)
 
 check-qtest-ppc64-y = tests/spapr-phb-test$(EXESUF)
 gcov-files-ppc64-y = ppc64-softmmu/hw/ppc/spapr_pci.c
@@ -745,7 +746,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
 	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
-tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj-y)
+tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj-y) $(libqos-e500-obj-y)
 tests/m25p80-test$(EXESUF): tests/m25p80-test.o
 tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
 tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
index 0586dbd467..f7dab1863e 100644
--- a/tests/ds-rtc-i2c-test.c
+++ b/tests/ds-rtc-i2c-test.c
@@ -18,6 +18,9 @@
 #define IMX25_I2C_0_BASE 0x43F80000
 #define DS1338_ADDR 0x68
 
+#define E500_CCSR_BASE 0xff700000
+#define DS1375_ADDR 0xd0
+
 static I2CAdapter *i2c;
 static uint8_t addr;
 static bool use_century;
@@ -148,6 +151,11 @@ int main(int argc, char *argv[])
         addr = DS1338_ADDR;
         use_century = false;
 
+    } else if (strcmp(arch, "ppc") == 0) {
+        qtest_start("-machine mvme3100-1152");
+        i2c = e500_i2c_create(E500_CCSR_BASE);
+        addr = DS1375_ADDR;
+        use_century = true;
     }
 
     qtest_add_data_func("/ds-rtc-i2c/set24", test_time_24, test_rtc_set);
-- 
2.11.0
