Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOq-00016i-UC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ceFOp-0000Tb-Jc
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:40 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:33554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ceFOp-0000TE-DO
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:18:39 -0500
Received: by mail-ot0-x230.google.com with SMTP id 73so5304800otj.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 22:18:39 -0800 (PST)
From: ben@skyportsystems.com
Date: Wed, 15 Feb 2017 22:18:17 -0800
Message-Id: <56acb26636bb86ff1f04145c2911100f15e2689c.1487224954.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v7 7/8] tests: Add unit tests for the VM
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
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

The following tests are implemented:
* test that a GUID passed in by command line is propagated to the guest.
  Read the GUID both from guest memory and from the monitor
* test that the "auto" argument to the GUID generates a valid GUID, as
  seen by the guest.

  This patch is loosely based on a previous patch from:
  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 tests/Makefile.include |   2 +
 tests/vmgenid-test.c   | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 tests/vmgenid-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 143507e..8d36341 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -241,6 +241,7 @@ check-qtest-i386-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-xhci.c
 check-qtest-i386-y += tests/pc-cpu-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
+check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
 gcov-files-i386-y += hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
 ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
@@ -726,6 +727,7 @@ tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
+tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/acpi-utils.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
new file mode 100644
index 0000000..1741455
--- /dev/null
+++ b/tests/vmgenid-test.c
@@ -0,0 +1,174 @@
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
+#define VMGENID_GUID_OFFSET      40   /* allow space for
+                                       * OVMF SDT Header Probe Supressor
+                                       */
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
+    off = acpi_find_rsdp_address();
+    g_assert_cmphex(off, <, 0x100000);
+
+    acpi_parse_rsdp_table(off, &rsdp_table);
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
+            return vgid_table.vgia_val + VMGENID_GUID_OFFSET;
+        }
+    }
+    return 0;
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
+static void vmgenid_test(void)
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
+    /* Read the GUID via the monitor */
+    read_guid_from_monitor(&measured);
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
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/vmgenid/vmgenid", vmgenid_test);
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
