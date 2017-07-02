Received: from eggs.gnu.org ([2001:4830:134:3::10]:44245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dRVxu-0002iC-3a
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dRVxr-0008Ke-0n
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:54:30 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dRVxq-0008K5-Qs
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 23:54:26 -0400
Received: by mail-it0-x230.google.com with SMTP id v202so75670256itb.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 20:54:26 -0700 (PDT)
From: ben@skyportsystems.com
Date: Sat,  1 Jul 2017 23:54:03 -0400
Message-Id: <d85f9aef28b70034bc698ef53543cd0f5ac064e4.1498967158.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] tests: Add unit tests for the VM Generation
 ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: imammedo@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

The following tests are implemented:
* test that a GUID passed in by command line is propagated to the guest.
  Read the GUID from guest memory
* test that the "auto" argument to the GUID generates a valid GUID, as
  seen by the guest.
* test that a GUID passed in can be queried from the monitor

  This patch is loosely based on a previous patch from:
  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---

v1->v2: free g_alloc'd tables

 tests/Makefile.include |   2 +
 tests/vmgenid-test.c   | 203 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 tests/vmgenid-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ae889ca..18cd06a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -250,6 +250,7 @@ check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-xhci.c
 check-qtest-i386-y += tests/pc-cpu-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
+check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y += hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
 ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
@@ -760,6 +761,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
+tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
new file mode 100644
index 0000000..e7ba38c
--- /dev/null
+++ b/tests/vmgenid-test.c
@@ -0,0 +1,203 @@
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
+#define VMGENID_GUID_OFFSET 40   /* allow space for
+                                  * OVMF SDT Header Probe Supressor
+                                  */
+#define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
+#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries */
+#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
+
+typedef struct {
+    AcpiTableHeader header;
+    gchar name_op;
+    gchar vgia[4];
+    gchar val_op;
+    uint32_t vgia_val;
+} QEMU_PACKED VgidTable;
+
+static uint32_t acpi_find_vgia(void)
+{
+    uint32_t rsdp_offset;
+    uint32_t guid_offset = 0;
+    AcpiRsdpDescriptor rsdp_table;
+    uint32_t rsdt;
+    AcpiRsdtDescriptorRev1 rsdt_table;
+    int tables_nr;
+    uint32_t *tables;
+    AcpiTableHeader ssdt_table;
+    VgidTable vgid_table;
+    int i;
+
+    /* Tables may take a short time to be set up by the guest */
+    for (i = 0; i < RSDP_TRIES_MAX; i++) {
+        rsdp_offset = acpi_find_rsdp_address();
+        if (rsdp_offset < RSDP_ADDR_INVALID) {
+            break;
+        }
+        g_usleep(RSDP_SLEEP_US);
+    }
+    g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
+
+    acpi_parse_rsdp_table(rsdp_offset, &rsdp_table);
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
+             * That's all we need
+             */
+            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
+            g_assert(vgid_table.name_op == 0x08);  /* name */
+            ACPI_READ_ARRAY(vgid_table.vgia, tables[i]);
+            g_assert(memcmp(vgid_table.vgia, "VGIA", 4) == 0);
+            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
+            g_assert(vgid_table.val_op == 0x0C);  /* dword */
+            ACPI_READ_FIELD(vgid_table.vgia_val, tables[i]);
+            /* The GUID is written at a fixed offset into the fw_cfg file
+             * in order to implement the "OVMF SDT Header probe suppressor"
+             * see docs/specs/vmgenid.txt for more details
+             */
+            guid_offset = vgid_table.vgia_val + VMGENID_GUID_OFFSET;
+            break;
+        }
+    }
+    g_free(tables);
+    return guid_offset;
+}
+
+static void read_guid_from_memory(QemuUUID *guid)
+{
+    uint32_t vmgenid_addr;
+    int i;
+
+    vmgenid_addr = acpi_find_vgia();
+    g_assert(vmgenid_addr);
+
+    /* Read the GUID directly from guest memory */
+    for (i = 0; i < 16; i++) {
+        guid->data[i] = readb(vmgenid_addr + i);
+    }
+    /* The GUID is in little-endian format in the guest, while QEMU
+     * uses big-endian.  Swap after reading.
+     */
+    qemu_uuid_bswap(guid);
+}
+
+static void read_guid_from_monitor(QemuUUID *guid)
+{
+    QDict *rsp, *rsp_ret;
+    const char *guid_str;
+
+    rsp = qmp("{ 'execute': 'query-vm-generation-id' }");
+    if (qdict_haskey(rsp, "return")) {
+        rsp_ret = qdict_get_qdict(rsp, "return");
+        g_assert(qdict_haskey(rsp_ret, "guid"));
+        guid_str = qdict_get_str(rsp_ret, "guid");
+        g_assert(qemu_uuid_parse(guid_str, guid) == 0);
+    }
+    QDECREF(rsp);
+}
+
+static void vmgenid_set_guid_test(void)
+{
+    QemuUUID expected, measured;
+    gchar *cmd;
+
+    g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
+
+    cmd = g_strdup_printf("-machine accel=tcg -device vmgenid,id=testvgid,"
+                          "guid=%s", VGID_GUID);
+    qtest_start(cmd);
+
+    /* Read the GUID from accessing guest memory */
+    read_guid_from_memory(&measured);
+    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
+
+    qtest_quit(global_qtest);
+    g_free(cmd);
+}
+
+static void vmgenid_set_guid_auto_test(void)
+{
+    const char *cmd;
+    QemuUUID measured;
+
+    cmd = "-machine accel=tcg -device vmgenid,id=testvgid," "guid=auto";
+    qtest_start(cmd);
+
+    read_guid_from_memory(&measured);
+
+    /* Just check that the GUID is non-null */
+    g_assert(!qemu_uuid_is_null(&measured));
+
+    qtest_quit(global_qtest);
+}
+
+static void vmgenid_query_monitor_test(void)
+{
+    QemuUUID expected, measured;
+    gchar *cmd;
+
+    g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
+
+    cmd = g_strdup_printf("-machine accel=tcg -device vmgenid,id=testvgid,"
+                          "guid=%s", VGID_GUID);
+    qtest_start(cmd);
+
+    /* Read the GUID via the monitor */
+    read_guid_from_monitor(&measured);
+    g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
+
+    qtest_quit(global_qtest);
+    g_free(cmd);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/vmgenid/vmgenid/set-guid",
+                   vmgenid_set_guid_test);
+    qtest_add_func("/vmgenid/vmgenid/set-guid-auto",
+                   vmgenid_set_guid_auto_test);
+    qtest_add_func("/vmgenid/vmgenid/query-monitor",
+                   vmgenid_query_monitor_test);
+    ret = g_test_run();
+
+    return ret;
+}
-- 
2.7.4
