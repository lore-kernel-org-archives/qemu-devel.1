Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCd8-0003rA-KZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCd3-0005Qt-Mo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:10 -0500
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCd3-0005PG-Gs
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:05 -0500
Received: by mail-yw0-x235.google.com with SMTP id l19so177092913ywc.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:44:03 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:28 -0800
Message-Id: <b4032bf140321b0b5fd8c0b7ff8e81e6da857dd0.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 9/9] tests: Add unit tests for the VM
 Generation ID feature
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

The following tests are implemented:
* test that a GUID passed in by command line is propagated to the guest.
* test that changing the GUID at runtime via the monitor is reflected in
  the guest.
* test that the "auto" argument to the GUID generates a different, and
  correct GUID as seen by the guest.

  This patch is loosely based on a previous patch from:
  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 tests/Makefile.include |   2 +
 tests/vmgenid-test.c   | 184 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 tests/vmgenid-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 22ea256..e2dcf15 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -239,6 +239,7 @@ check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-xhci.c
 check-qtest-i386-y += tests/pc-cpu-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
+check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y += hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
 ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
@@ -715,6 +716,7 @@ tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
+tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
new file mode 100644
index 0000000..0f5ba07
--- /dev/null
+++ b/tests/vmgenid-test.c
@@ -0,0 +1,184 @@
+/*
+ * QTest testcase for VM Generation ID
+ *
+ * Copyright (c) 2016 Red Hat, Inc.
+ * Copyright (c) 2017 Skyport Systems
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <glib.h>
+#include <string.h>
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "qemu/bitmap.h"
+#include "qemu/uuid.h"
+#include "hw/acpi/acpi-defs.h"
+#include "acpi-utils.h"
+#include "libqtest.h"
+
+#define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
+
+static uint64_t vgia;
+
+typedef struct {
+    AcpiTableHeader header;
+    gchar name_op;
+    gchar vgia[4];
+    gchar val_op;
+    uint64_t vgia_val;
+} QEMU_PACKED VgidTable;
+
+static uint64_t find_vgia(void)
+{
+    uint32_t off;
+    AcpiRsdpDescriptor rsdp_table;
+    uint32_t rsdt;
+    AcpiRsdtDescriptorRev1 rsdt_table;
+    int tables_nr;
+    uint32_t *tables;
+    AcpiTableHeader ssdt_table;
+    VgidTable vgid_table;
+    int i;
+
+    /* First, find the RSDP */
+    for (off = 0xf0000; off < 0x100000; off += 0x10) {
+        uint8_t sig[] = "RSD PTR ";
+
+        for (i = 0; i < sizeof sig - 1; ++i) {
+            sig[i] = readb(off + i);
+        }
+
+        if (!memcmp(sig, "RSD PTR ", sizeof sig)) {
+            break;
+        }
+    }
+    g_assert_cmphex(off, <, 0x100000);
+
+    /* Parse the RSDP header so we can find the RSDT */
+    ACPI_READ_FIELD(rsdp_table.signature, off);
+    ACPI_ASSERT_CMP64(rsdp_table.signature, "RSD PTR ");
+
+    ACPI_READ_FIELD(rsdp_table.checksum, off);
+    ACPI_READ_ARRAY(rsdp_table.oem_id, off);
+    ACPI_READ_FIELD(rsdp_table.revision, off);
+    ACPI_READ_FIELD(rsdp_table.rsdt_physical_address, off);
+
+    rsdt = rsdp_table.rsdt_physical_address;
+    /* read the header */
+    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
+    ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
+
+    /* compute the table entries in rsdt */
+    tables_nr = (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1)) /
+                sizeof(uint32_t);
+    g_assert_cmpint(tables_nr, >, 0);
+
+    /* get the addresses of the tables pointed by rsdt */
+    tables = g_new0(uint32_t, tables_nr);
+    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
+
+    for (i = 0; i < tables_nr; i++) {
+        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
+        if (!strncmp((char *)ssdt_table.oem_table_id, "VMGENID", 7)) {
+            /* the first entry in the table should be VGIA
+             * That's all we need */
+            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
+            g_assert(vgid_table.name_op == 0x08);  /* name */
+            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
+            g_assert(memcmp(vgid_table.vgia, "VGIA", 4) == 0);
+            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
+            g_assert(vgid_table.val_op == 0x0E);  /* qword */
+            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
+            return vgid_table.vgia_val;
+        }
+    }
+    return 0;
+}
+
+static void vmgenid_read_guid(uint8_t *guid)
+{
+    int i;
+
+    if (vgia == 0) {
+        vgia = find_vgia();
+    }
+    g_assert(vgia);
+
+    /* Read the GUID directly from guest memory */
+    for (i = 0; i < 16; i++) {
+        guid[i] = readb(vgia + i);
+    }
+}
+
+static void vmgenid_test(void)
+{
+    uint8_t measured[16];
+    QemuUUID expected;
+    g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
+    vmgenid_read_guid(measured);
+    g_assert(memcmp(measured, expected.data, sizeof(measured)) == 0);
+}
+
+static void vmgenid_set_guid_test(void)
+{
+    QDict *response;
+    gchar *cmd;
+    uint8_t measured[16];
+    QemuUUID expected;
+    g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
+    /* Change the GUID slightly */
+    expected.data[0] += 1;
+
+    cmd = g_strdup_printf("{ 'execute': 'qom-set', 'arguments': { "
+                   "'path': '/machine/peripheral/testvgid', "
+                   "'property': 'guid', 'value': '%s' } }",
+                   qemu_uuid_unparse_strdup(&expected));
+    response = qmp(cmd);
+    g_assert(qdict_haskey(response, "return"));
+    QDECREF(response);
+
+    vmgenid_read_guid(measured);
+    g_assert(memcmp(measured, expected.data, sizeof(measured)) == 0);
+}
+
+static void vmgenid_set_guid_auto_test(void)
+{
+    QDict *response;
+    QemuUUID measured;
+    QemuUUID expected;
+
+    /* Read the initial value */
+    vmgenid_read_guid(expected.data);
+
+    /* Setting to 'auto' generates a random GUID */
+    response = qmp("{ 'execute': 'qom-set', 'arguments': { "
+                   "'path': '/machine/peripheral/testvgid', "
+                   "'property': 'guid', 'value': 'auto' } }");
+
+    g_assert(qdict_haskey(response, "return"));
+    QDECREF(response);
+
+    vmgenid_read_guid(measured.data);
+    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) != 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_start("-machine accel=tcg -device vmgenid,id=testvgid,"
+                "guid=" VGID_GUID);
+    qtest_add_func("/vmgenid/vmgenid", vmgenid_test);
+    qtest_add_func("/vmgenid/vmgenid/set-guid", vmgenid_set_guid_test);
+    qtest_add_func("/vmgenid/vmgenid/set-guid-auto",
+                   vmgenid_set_guid_auto_test);
+    ret = g_test_run();
+
+    qtest_end();
+
+    return ret;
+}
-- 
2.7.4
