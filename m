Received: from eggs.gnu.org ([2001:4830:134:3::10]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQ2-0001c4-Ri
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dQZQ1-0007mU-HI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dQZQ1-0007mH-9J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:23:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C5AD1E2D4
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 13:23:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Jun 2017 15:23:06 +0200
Message-Id: <20170629132310.18865-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170629132310.18865-1-marcandre.lureau@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/7] tests: add simple vmcoreinfo test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This test is based off vmgenid test from Ben Warren
<ben@skyportsystems.com>. It simply checks the vmcoreinfo ACPI device
is present and that the memory region associated can be read.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vmcoreinfo-test.c | 130 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/Makefile.include  |   2 +
 2 files changed, 132 insertions(+)
 create mode 100644 tests/vmcoreinfo-test.c

diff --git a/tests/vmcoreinfo-test.c b/tests/vmcoreinfo-test.c
new file mode 100644
index 0000000000..c8b073366e
--- /dev/null
+++ b/tests/vmcoreinfo-test.c
@@ -0,0 +1,130 @@
+/*
+ * QTest testcase for VM coreinfo device
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Copyright (c) 2017 Skyport Systems
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+#define VMCOREINFO_OFFSET 40     /* allow space for
+                                  * OVMF SDT Header Probe Supressor
+                                  */
+#define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
+#define RSDP_SLEEP_US     100000   /* Sleep for 100ms between tries */
+#define RSDP_TRIES_MAX    100      /* Max total time is 10 seconds */
+
+typedef struct {
+    AcpiTableHeader header;
+    gchar name_op;
+    gchar vcia[4];
+    gchar val_op;
+    uint32_t vcia_val;
+} QEMU_PACKED VgidTable;
+
+static uint32_t acpi_find_vcia(void)
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
+    /* Tables may take a short time to be set up by the guest */
+    for (i =3D 0; i < RSDP_TRIES_MAX; i++) {
+        off =3D acpi_find_rsdp_address();
+        if (off < RSDP_ADDR_INVALID) {
+            break;
+        }
+        g_usleep(RSDP_SLEEP_US);
+    }
+    g_assert_cmphex(off, <, RSDP_ADDR_INVALID);
+
+    acpi_parse_rsdp_table(off, &rsdp_table);
+
+    rsdt =3D rsdp_table.rsdt_physical_address;
+    /* read the header */
+    ACPI_READ_TABLE_HEADER(&rsdt_table, rsdt);
+    ACPI_ASSERT_CMP(rsdt_table.signature, "RSDT");
+
+    /* compute the table entries in rsdt */
+    tables_nr =3D (rsdt_table.length - sizeof(AcpiRsdtDescriptorRev1)) /
+                sizeof(uint32_t);
+    g_assert_cmpint(tables_nr, >, 0);
+
+    /* get the addresses of the tables pointed by rsdt */
+    tables =3D g_new0(uint32_t, tables_nr);
+    ACPI_READ_ARRAY_PTR(tables, tables_nr, rsdt);
+
+    for (i =3D 0; i < tables_nr; i++) {
+        ACPI_READ_TABLE_HEADER(&ssdt_table, tables[i]);
+        if (!strncmp((char *)ssdt_table.oem_table_id, "VMCOREIN", 8)) {
+            /* the first entry in the table should be VCIA
+             * That's all we need
+             */
+            ACPI_READ_FIELD(vgid_table.name_op, tables[i]);
+            g_assert(vgid_table.name_op =3D=3D 0x08);  /* name */
+            ACPI_READ_ARRAY(vgid_table.vcia, tables[i]);
+            g_assert(memcmp(vgid_table.vcia, "VCIA", 4) =3D=3D 0);
+            ACPI_READ_FIELD(vgid_table.val_op, tables[i]);
+            g_assert(vgid_table.val_op =3D=3D 0x0C);  /* dword */
+            ACPI_READ_FIELD(vgid_table.vcia_val, tables[i]);
+            /* The GUID is written at a fixed offset into the fw_cfg fil=
e
+             * in order to implement the "OVMF SDT Header probe suppress=
or"
+             * see docs/specs/vmgenid.txt for more details
+             */
+            g_free(tables);
+            return vgid_table.vcia_val;
+        }
+    }
+    g_free(tables);
+    return 0;
+}
+
+static void vmcoreinfo_test(void)
+{
+    gchar *cmd;
+    uint32_t vmci_addr;
+    int i;
+
+    cmd =3D g_strdup_printf("-machine accel=3Dtcg -device vmcoreinfo,id=3D=
vmci");
+    qtest_start(cmd);
+
+    vmci_addr =3D acpi_find_vcia();
+    g_assert(vmci_addr);
+
+    for (i =3D 0; i < 4096; i++) {
+        /* check the memory region can be read */
+        readb(vmci_addr + i);
+    }
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
+    qtest_add_func("/vmcoreinfo/test", vmcoreinfo_test);
+    ret =3D g_test_run();
+
+    return ret;
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ae889cae02..67ddac40d8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -250,6 +250,7 @@ check-qtest-i386-y +=3D tests/usb-hcd-xhci-test$(EXES=
UF)
 gcov-files-i386-y +=3D hw/usb/hcd-xhci.c
 check-qtest-i386-y +=3D tests/pc-cpu-test$(EXESUF)
 check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
+check-qtest-i386-y +=3D tests/vmcoreinfo-test$(EXESUF)
 gcov-files-i386-y +=3D hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_NET_TEST_i386) +=3D tests/vhost-user-tes=
t$(EXESUF)
 ifeq ($(CONFIG_VHOST_NET_TEST_i386),)
@@ -760,6 +761,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-ut=
il-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
+tests/vmcoreinfo-test$(EXESUF): tests/vmcoreinfo-test.o tests/acpi-utils=
.o
=20
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,=
"LINK","$(TARGET_DIR)$@")
--=20
2.13.1.395.gf7b71de06
