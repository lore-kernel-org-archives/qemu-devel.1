Received: from eggs.gnu.org ([2001:4830:134:3::10]:47523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCd0-0003jI-N6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcz-0005Ov-NT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:02 -0500
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:32973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcz-0005On-Hf
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:01 -0500
Received: by mail-yw0-x22c.google.com with SMTP id u68so3013803ywg.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:44:01 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:27 -0800
Message-Id: <9c90a6dd473ee547c050c052c161e7fdb0f8a5d3.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 8/9] tests: Move reusable ACPI macros into a
 new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

Also usable by upcoming VM Generation ID tests

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 tests/acpi-utils.h       | 75 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/bios-tables-test.c | 72 +---------------------------------------------
 2 files changed, 76 insertions(+), 71 deletions(-)
 create mode 100644 tests/acpi-utils.h

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
new file mode 100644
index 0000000..d5e5eff
--- /dev/null
+++ b/tests/acpi-utils.h
@@ -0,0 +1,75 @@
+#ifndef TEST_ACPI_UTILS_H
+#define TEST_ACPI_UTILS_H
+
+/* DSDT and SSDTs format */
+typedef struct {
+    AcpiTableHeader header;
+    gchar *aml;            /* aml bytecode from guest */
+    gsize aml_len;
+    gchar *aml_file;
+    gchar *asl;            /* asl code generated from aml */
+    gsize asl_len;
+    gchar *asl_file;
+    bool tmp_files_retain;   /* do not delete the temp asl/aml */
+} QEMU_PACKED AcpiSdtTable;
+
+#define ACPI_READ_FIELD(field, addr)           \
+    do {                                       \
+        switch (sizeof(field)) {               \
+        case 1:                                \
+            field = readb(addr);               \
+            break;                             \
+        case 2:                                \
+            field = readw(addr);               \
+            break;                             \
+        case 4:                                \
+            field = readl(addr);               \
+            break;                             \
+        case 8:                                \
+            field = readq(addr);               \
+            break;                             \
+        default:                               \
+            g_assert(false);                   \
+        }                                      \
+        addr += sizeof(field);                  \
+    } while (0);
+
+#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
+    do {                                        \
+        int idx;                                \
+        for (idx = 0; idx < length; ++idx) {    \
+            ACPI_READ_FIELD(arr[idx], addr);    \
+        }                                       \
+    } while (0);
+
+#define ACPI_READ_ARRAY(arr, addr)                               \
+    ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
+
+#define ACPI_READ_TABLE_HEADER(table, addr)                      \
+    do {                                                         \
+        ACPI_READ_FIELD((table)->signature, addr);               \
+        ACPI_READ_FIELD((table)->length, addr);                  \
+        ACPI_READ_FIELD((table)->revision, addr);                \
+        ACPI_READ_FIELD((table)->checksum, addr);                \
+        ACPI_READ_ARRAY((table)->oem_id, addr);                  \
+        ACPI_READ_ARRAY((table)->oem_table_id, addr);            \
+        ACPI_READ_FIELD((table)->oem_revision, addr);            \
+        ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
+        ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
+    } while (0);
+
+#define ACPI_ASSERT_CMP(actual, expected) do { \
+    uint32_t ACPI_ASSERT_CMP_le = cpu_to_le32(actual); \
+    char ACPI_ASSERT_CMP_str[5] = {}; \
+    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 4); \
+    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
+} while (0)
+
+#define ACPI_ASSERT_CMP64(actual, expected) do { \
+    uint64_t ACPI_ASSERT_CMP_le = cpu_to_le64(actual); \
+    char ACPI_ASSERT_CMP_str[9] = {}; \
+    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 8); \
+    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
+} while (0)
+
+#endif  /* TEST_ACPI_UTILS_H */
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 5404805..c642f7f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -17,6 +17,7 @@
 #include "hw/acpi/acpi-defs.h"
 #include "hw/smbios/smbios.h"
 #include "qemu/bitmap.h"
+#include "acpi-utils.h"
 #include "boot-sector.h"
 
 #define MACHINE_PC "pc"
@@ -24,18 +25,6 @@
 
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
-/* DSDT and SSDTs format */
-typedef struct {
-    AcpiTableHeader header;
-    gchar *aml;            /* aml bytecode from guest */
-    gsize aml_len;
-    gchar *aml_file;
-    gchar *asl;            /* asl code generated from aml */
-    gsize asl_len;
-    gchar *asl_file;
-    bool tmp_files_retain;   /* do not delete the temp asl/aml */
-} QEMU_PACKED AcpiSdtTable;
-
 typedef struct {
     const char *machine;
     const char *variant;
@@ -53,65 +42,6 @@ typedef struct {
     int required_struct_types_len;
 } test_data;
 
-#define ACPI_READ_FIELD(field, addr)           \
-    do {                                       \
-        switch (sizeof(field)) {               \
-        case 1:                                \
-            field = readb(addr);               \
-            break;                             \
-        case 2:                                \
-            field = readw(addr);               \
-            break;                             \
-        case 4:                                \
-            field = readl(addr);               \
-            break;                             \
-        case 8:                                \
-            field = readq(addr);               \
-            break;                             \
-        default:                               \
-            g_assert(false);                   \
-        }                                      \
-        addr += sizeof(field);                  \
-    } while (0);
-
-#define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
-    do {                                        \
-        int idx;                                \
-        for (idx = 0; idx < length; ++idx) {    \
-            ACPI_READ_FIELD(arr[idx], addr);    \
-        }                                       \
-    } while (0);
-
-#define ACPI_READ_ARRAY(arr, addr)                               \
-    ACPI_READ_ARRAY_PTR(arr, sizeof(arr)/sizeof(arr[0]), addr)
-
-#define ACPI_READ_TABLE_HEADER(table, addr)                      \
-    do {                                                         \
-        ACPI_READ_FIELD((table)->signature, addr);               \
-        ACPI_READ_FIELD((table)->length, addr);                  \
-        ACPI_READ_FIELD((table)->revision, addr);                \
-        ACPI_READ_FIELD((table)->checksum, addr);                \
-        ACPI_READ_ARRAY((table)->oem_id, addr);                  \
-        ACPI_READ_ARRAY((table)->oem_table_id, addr);            \
-        ACPI_READ_FIELD((table)->oem_revision, addr);            \
-        ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
-        ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
-    } while (0);
-
-#define ACPI_ASSERT_CMP(actual, expected) do { \
-    uint32_t ACPI_ASSERT_CMP_le = cpu_to_le32(actual); \
-    char ACPI_ASSERT_CMP_str[5] = {}; \
-    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 4); \
-    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
-} while (0)
-
-#define ACPI_ASSERT_CMP64(actual, expected) do { \
-    uint64_t ACPI_ASSERT_CMP_le = cpu_to_le64(actual); \
-    char ACPI_ASSERT_CMP_str[9] = {}; \
-    memcpy(ACPI_ASSERT_CMP_str, &ACPI_ASSERT_CMP_le, 8); \
-    g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
-} while (0)
-
 static char disk[] = "tests/acpi-test-disk-XXXXXX";
 static const char *data_dir = "tests/acpi-test-data";
 #ifdef CONFIG_IASL
-- 
2.7.4
