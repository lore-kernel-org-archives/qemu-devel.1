Received: from eggs.gnu.org ([2001:4830:134:3::10]:43559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7T-0006Ru-5R
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7P-0007Bu-Rr
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7P-0007Bo-Mt
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:55 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:26 +0100
Message-Id: <1518607234-17739-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] tests/boot-sector: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  Adjust the helper code to
use explicit state instead, and update all callers.

Fix some trailing whitespace while touching the file.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 tests/boot-sector.c      | 8 ++++----
 tests/boot-sector.h      | 6 ++++--
 tests/pxe-test.c         | 2 +-
 tests/vmgenid-test.c     | 2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 2b332ed..65b271a 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -668,7 +668,7 @@ static void test_acpi_one(const char *params, test_data *data)
 
     qtest_start(args);
 
-    boot_sector_test();
+    boot_sector_test(global_qtest);
 
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     test_acpi_rsdp_address(data);
diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index be29d5b..c373f0e 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -5,7 +5,7 @@
  *
  * Authors:
  *  Michael S. Tsirkin <mst@redhat.com>
- *  Victor Kaplansky <victork@redhat.com>    
+ *  Victor Kaplansky <victork@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -130,7 +130,7 @@ int boot_sector_init(char *fname)
 }
 
 /* Loop until signature in memory is OK.  */
-void boot_sector_test(void)
+void boot_sector_test(QTestState *qts)
 {
     uint8_t signature_low;
     uint8_t signature_high;
@@ -146,8 +146,8 @@ void boot_sector_test(void)
      * instruction.
      */
     for (i = 0; i < TEST_CYCLES; ++i) {
-        signature_low = readb(SIGNATURE_ADDR);
-        signature_high = readb(SIGNATURE_ADDR + 1);
+        signature_low = qtest_readb(qts, SIGNATURE_ADDR);
+        signature_high = qtest_readb(qts, SIGNATURE_ADDR + 1);
         signature = (signature_high << 8) | signature_low;
         if (signature == SIGNATURE) {
             break;
diff --git a/tests/boot-sector.h b/tests/boot-sector.h
index 35d61c7..6ee6bb4 100644
--- a/tests/boot-sector.h
+++ b/tests/boot-sector.h
@@ -5,7 +5,7 @@
  *
  * Authors:
  *  Michael S. Tsirkin <mst@redhat.com>
- *  Victor Kaplansky <victork@redhat.com>    
+ *  Victor Kaplansky <victork@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -14,11 +14,13 @@
 #ifndef TEST_BOOT_SECTOR_H
 #define TEST_BOOT_SECTOR_H
 
+#include "libqtest.h"
+
 /* Create boot disk file. fname must be a suitable string for mkstemp() */
 int boot_sector_init(char *fname);
 
 /* Loop until signature in memory is OK.  */
-void boot_sector_test(void);
+void boot_sector_test(QTestState *qts);
 
 /* unlink boot disk file.  */
 void boot_sector_cleanup(const char *fname);
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 5ca8480..6e36796 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -71,7 +71,7 @@ static void test_pxe_one(const testdef_t *test, bool ipv6)
         test->model);
 
     qtest_start(args);
-    boot_sector_test();
+    boot_sector_test(global_qtest);
     qtest_quit(global_qtest);
     g_free(args);
 }
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 7190e68..2ec274e 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -45,7 +45,7 @@ static uint32_t acpi_find_vgia(void)
     int i;
 
     /* Wait for guest firmware to finish and start the payload. */
-    boot_sector_test();
+    boot_sector_test(global_qtest);
 
     /* Tables should be initialized now. */
     rsdp_offset = acpi_find_rsdp_address();
-- 
1.8.3.1
