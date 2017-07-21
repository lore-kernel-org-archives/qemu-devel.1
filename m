Received: from eggs.gnu.org ([2001:4830:134:3::10]:49292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYUIQ-0000iq-Tz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dYUIM-000751-1C
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dYUIL-00074N-OM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:25 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 21 Jul 2017 11:32:11 +0200
Message-Id: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Programmingkid <programmingkidx@gmail.com>, Phil Dennis-Jordan <lists@philjordan.eu>, "Michael S. Tsirkin" <mst@redhat.com>

w2k used to boot on QEMU until we bumped revision of FADT to rev3
(commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)

Considering that w2k is ancient and long time EOLed, leave default
rev3 but make pc-i440fx-2.9 and older machine types to force rev1
so old setups won't break (w2k could boot).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Programmingkid <programmingkidx@gmail.com>
CC: Phil Dennis-Jordan <lists@philjordan.eu>
CC: "Michael S. Tsirkin" <mst@redhat.com>

Only compile test since I don't have w2k to test with

---
 include/hw/i386/pc.h |  1 +
 hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
 hw/i386/pc_piix.c    |  2 ++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d80859b..d6f65dd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -122,6 +122,7 @@ struct PCMachineClass {
     bool rsdp_in_ram;
     int legacy_acpi_table_size;
     unsigned acpi_data_size;
+    bool force_rev1_fadt;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade..227f9ad 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -272,7 +272,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
 }
 
 /* Load chipset information in FADT */
-static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
+static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm, bool rev1)
 {
     fadt->model = 1;
     fadt->reserved1 = 0;
@@ -304,6 +304,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
         fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
     }
     fadt->century = RTC_CENTURY;
+    if (rev1) {
+        return;
+    }
 
     fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
     fadt->reset_value = 0xf;
@@ -335,6 +338,7 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
 /* FADT */
 static void
 build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
+           MachineState *machine,
            unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
            const char *oem_id, const char *oem_table_id)
 {
@@ -342,6 +346,9 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
     unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
     unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    int fadt_size = sizeof(*fadt);
+    int rev = 3;
 
     /* FACS address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
@@ -349,16 +356,21 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
         ACPI_BUILD_TABLE_FILE, facs_tbl_offset);
 
     /* DSDT address to be filled by Guest linker */
-    fadt_setup(fadt, pm);
+    fadt_setup(fadt, pm, pcmc->force_rev1_fadt);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
-    bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
-        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+    if (pcmc->force_rev1_fadt) {
+        rev = 1;
+        fadt_size = offsetof(typeof(*fadt), reset_register);
+    } else {
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
+            ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+    }
 
     build_header(linker, table_data,
-                 (void *)fadt, "FACP", sizeof(*fadt), 3, oem_id, oem_table_id);
+                 (void *)fadt, "FACP", fadt_size, rev, oem_id, oem_table_id);
 }
 
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
@@ -2667,7 +2679,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     /* ACPI tables pointed to by RSDT */
     fadt = tables_blob->len;
     acpi_add_table(table_offsets, tables_blob);
-    build_fadt(tables_blob, tables->linker, &pm, facs, dsdt,
+    build_fadt(tables_blob, tables->linker, &pm, machine, facs, dsdt,
                slic_oem.id, slic_oem.table_id);
     aml_len += tables_blob->len - fadt;
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 11b4336..bc61332 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -449,9 +449,11 @@ DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_10_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
+    pcmc->force_rev1_fadt = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
 }
 
-- 
2.7.4
