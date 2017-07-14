Received: from eggs.gnu.org ([2001:4830:134:3::10]:33371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW2I9-00077d-IJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW2I5-00029h-He
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW2I5-00029H-8t
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:01 -0400
Date: Fri, 14 Jul 2017 18:13:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1500045231-23322-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] vmgenid-test: use boot-sector infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>

There's no requirement for RSDP to be installed last
by the firmware, so in rare cases vmgen id test hits
a race: RSDP is there but VM GEN ID isn't.

To fix, switch to common boot sector infrastructure.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vmgenid-test.c   | 45 +++++++++++++++++++++++++++++----------------
 tests/Makefile.include |  2 +-
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index e7ba38c..0556ba2 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -15,6 +15,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/uuid.h"
 #include "hw/acpi/acpi-defs.h"
+#include "boot-sector.h"
 #include "acpi-utils.h"
 #include "libqtest.h"
 
@@ -23,8 +24,6 @@
                                   * OVMF SDT Header Probe Supressor
                                   */
 #define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
-#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries */
-#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
 
 typedef struct {
     AcpiTableHeader header;
@@ -47,14 +46,12 @@ static uint32_t acpi_find_vgia(void)
     VgidTable vgid_table;
     int i;
 
-    /* Tables may take a short time to be set up by the guest */
-    for (i = 0; i < RSDP_TRIES_MAX; i++) {
-        rsdp_offset = acpi_find_rsdp_address();
-        if (rsdp_offset < RSDP_ADDR_INVALID) {
-            break;
-        }
-        g_usleep(RSDP_SLEEP_US);
-    }
+    /* Wait for guest firmware to finish and start the payload. */
+    boot_sector_test();
+
+    /* Tables should be initialized now. */
+    rsdp_offset = acpi_find_rsdp_address();
+
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
 
     acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
@@ -131,6 +128,18 @@ static void read_guid_from_monitor(QemuUUID *guid)
     QDECREF(rsp);
 }
 
+static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
+
+static char *guid_cmd_strdup(const char *guid)
+{
+    return g_strdup_printf("-machine accel=tcg "
+                           "-device vmgenid,id=testvgid,guid=%s "
+                           "-drive id=hd0,if=none,file=%s,format=raw "
+                           "-device ide-hd,drive=hd0 ",
+                           guid, disk);
+}
+
+
 static void vmgenid_set_guid_test(void)
 {
     QemuUUID expected, measured;
@@ -138,8 +147,7 @@ static void vmgenid_set_guid_test(void)
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    cmd = g_strdup_printf("-machine accel=tcg -device vmgenid,id=testvgid,"
-                          "guid=%s", VGID_GUID);
+    cmd = guid_cmd_strdup(VGID_GUID);
     qtest_start(cmd);
 
     /* Read the GUID from accessing guest memory */
@@ -152,10 +160,10 @@ static void vmgenid_set_guid_test(void)
 
 static void vmgenid_set_guid_auto_test(void)
 {
-    const char *cmd;
+    char *cmd;
     QemuUUID measured;
 
-    cmd = "-machine accel=tcg -device vmgenid,id=testvgid," "guid=auto";
+    cmd = guid_cmd_strdup("auto");
     qtest_start(cmd);
 
     read_guid_from_memory(&measured);
@@ -164,6 +172,7 @@ static void vmgenid_set_guid_auto_test(void)
     g_assert(!qemu_uuid_is_null(&measured));
 
     qtest_quit(global_qtest);
+    g_free(cmd);
 }
 
 static void vmgenid_query_monitor_test(void)
@@ -173,8 +182,7 @@ static void vmgenid_query_monitor_test(void)
 
     g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
 
-    cmd = g_strdup_printf("-machine accel=tcg -device vmgenid,id=testvgid,"
-                          "guid=%s", VGID_GUID);
+    cmd = guid_cmd_strdup(VGID_GUID);
     qtest_start(cmd);
 
     /* Read the GUID via the monitor */
@@ -189,6 +197,10 @@ int main(int argc, char **argv)
 {
     int ret;
 
+    ret = boot_sector_init(disk);
+    if(ret)
+        return ret;
+
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/vmgenid/vmgenid/set-guid",
@@ -198,6 +210,7 @@ int main(int argc, char **argv)
     qtest_add_func("/vmgenid/vmgenid/query-monitor",
                    vmgenid_query_monitor_test);
     ret = g_test_run();
+    boot_sector_cleanup(disk);
 
     return ret;
 }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 18cd06a..aef374b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -761,7 +761,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
-tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
+tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
-- 
MST
