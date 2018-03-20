Received: from eggs.gnu.org ([2001:4830:134:3::10]:50824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mA-0006ZM-Sn
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m8-00084V-SL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:26 -0400
Date: Tue, 20 Mar 2018 05:17:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-12-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/50] acpi: move build_fadt() from i386
 specific to generic ACPI source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

It will be extended and reused by follow up patch for ARM target.

PS:
Since it's generic function now, don't patch FIRMWARE_CTRL, DSDT
fields if they don't point to tables since platform might not
provide them and use X_ variants instead if applicable.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |   3 ++
 hw/acpi/aml-build.c         | 105 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |   6 +--
 hw/i386/acpi-build.c        | 102 ------------------------------------------
 4 files changed, 111 insertions(+), 105 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 8692ccc..6c36903 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -413,4 +413,7 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
 void build_slit(GArray *table_data, BIOSLinker *linker);
+
+void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
+                const char *oem_id, const char *oem_table_id);
 #endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 3fef5f6..8f45298 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1678,3 +1678,108 @@ void build_slit(GArray *table_data, BIOSLinker *linker)
                  "SLIT",
                  table_data->len - slit_start, 1, NULL, NULL);
 }
+
+/* build rev1/rev3 FADT */
+void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
+                const char *oem_id, const char *oem_table_id)
+{
+    int off;
+    int fadt_start = tbl->len;
+
+    acpi_data_push(tbl, sizeof(AcpiTableHeader));
+
+    /* FACS address to be filled by Guest linker at runtime */
+    off = tbl->len;
+    build_append_int_noprefix(tbl, 0, 4); /* FIRMWARE_CTRL */
+    if (f->facs_tbl_offset) { /* don't patch if not supported by platform */
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, off, 4,
+            ACPI_BUILD_TABLE_FILE, *f->facs_tbl_offset);
+    }
+
+    /* DSDT address to be filled by Guest linker at runtime */
+    off = tbl->len;
+    build_append_int_noprefix(tbl, 0, 4); /* DSDT */
+    if (f->dsdt_tbl_offset) { /* don't patch if not supported by platform */
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, off, 4,
+            ACPI_BUILD_TABLE_FILE, *f->dsdt_tbl_offset);
+    }
+
+    /* ACPI1.0: INT_MODEL, ACPI2.0+: Reserved */
+    build_append_int_noprefix(tbl, f->int_model /* Multiple APIC */, 1);
+    /* Preferred_PM_Profile */
+    build_append_int_noprefix(tbl, 0 /* Unspecified */, 1);
+    build_append_int_noprefix(tbl, f->sci_int, 2); /* SCI_INT */
+    build_append_int_noprefix(tbl, f->smi_cmd, 4); /* SMI_CMD */
+    build_append_int_noprefix(tbl, f->acpi_enable_cmd, 1); /* ACPI_ENABLE */
+    build_append_int_noprefix(tbl, f->acpi_disable_cmd, 1); /* ACPI_DISABLE */
+    build_append_int_noprefix(tbl, 0 /* not supported */, 1); /* S4BIOS_REQ */
+    /* ACPI1.0: Reserved, ACPI2.0+: PSTATE_CNT */
+    build_append_int_noprefix(tbl, 0, 1);
+    build_append_int_noprefix(tbl, f->pm1a_evt.address, 4); /* PM1a_EVT_BLK */
+    build_append_int_noprefix(tbl, 0, 4); /* PM1b_EVT_BLK */
+    build_append_int_noprefix(tbl, f->pm1a_cnt.address, 4); /* PM1a_CNT_BLK */
+    build_append_int_noprefix(tbl, 0, 4); /* PM1b_CNT_BLK */
+    build_append_int_noprefix(tbl, 0, 4); /* PM2_CNT_BLK */
+    build_append_int_noprefix(tbl, f->pm_tmr.address, 4); /* PM_TMR_BLK */
+    build_append_int_noprefix(tbl, f->gpe0_blk.address, 4); /* GPE0_BLK */
+    build_append_int_noprefix(tbl, 0, 4); /* GPE1_BLK */
+    /* PM1_EVT_LEN */
+    build_append_int_noprefix(tbl, f->pm1a_evt.bit_width / 8, 1);
+    /* PM1_CNT_LEN */
+    build_append_int_noprefix(tbl, f->pm1a_cnt.bit_width / 8, 1);
+    build_append_int_noprefix(tbl, 0, 1); /* PM2_CNT_LEN */
+    build_append_int_noprefix(tbl, f->pm_tmr.bit_width / 8, 1); /* PM_TMR_LEN */
+    /* GPE0_BLK_LEN */
+    build_append_int_noprefix(tbl, f->gpe0_blk.bit_width / 8, 1);
+    build_append_int_noprefix(tbl, 0, 1); /* GPE1_BLK_LEN */
+    build_append_int_noprefix(tbl, 0, 1); /* GPE1_BASE */
+    build_append_int_noprefix(tbl, 0, 1); /* CST_CNT */
+    build_append_int_noprefix(tbl, f->plvl2_lat, 2); /* P_LVL2_LAT */
+    build_append_int_noprefix(tbl, f->plvl3_lat, 2); /* P_LVL3_LAT */
+    build_append_int_noprefix(tbl, 0, 2); /* FLUSH_SIZE */
+    build_append_int_noprefix(tbl, 0, 2); /* FLUSH_STRIDE */
+    build_append_int_noprefix(tbl, 0, 1); /* DUTY_OFFSET */
+    build_append_int_noprefix(tbl, 0, 1); /* DUTY_WIDTH */
+    build_append_int_noprefix(tbl, 0, 1); /* DAY_ALRM */
+    build_append_int_noprefix(tbl, 0, 1); /* MON_ALRM */
+    build_append_int_noprefix(tbl, f->rtc_century, 1); /* CENTURY */
+    build_append_int_noprefix(tbl, 0, 2); /* IAPC_BOOT_ARCH */
+    build_append_int_noprefix(tbl, 0, 1); /* Reserved */
+    build_append_int_noprefix(tbl, f->flags, 4); /* Flags */
+
+    if (f->rev == 1) {
+        goto build_hdr;
+    }
+
+    build_append_gas_from_struct(tbl, &f->reset_reg); /* RESET_REG */
+    build_append_int_noprefix(tbl, f->reset_val, 1); /* RESET_VALUE */
+    build_append_int_noprefix(tbl, 0, 3); /* Reserved, ACPI 3.0 */
+    build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
+
+    /* XDSDT address to be filled by Guest linker at runtime */
+    off = tbl->len;
+    build_append_int_noprefix(tbl, 0, 8); /* X_DSDT */
+    if (f->xdsdt_tbl_offset) {
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, off, 8,
+            ACPI_BUILD_TABLE_FILE, *f->xdsdt_tbl_offset);
+    }
+
+    build_append_gas_from_struct(tbl, &f->pm1a_evt); /* X_PM1a_EVT_BLK */
+    /* X_PM1b_EVT_BLK */
+    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->pm1a_cnt); /* X_PM1a_CNT_BLK */
+    /* X_PM1b_CNT_BLK */
+    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    /* X_PM2_CNT_BLK */
+    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->pm_tmr); /* X_PM_TMR_BLK */
+    build_append_gas_from_struct(tbl, &f->gpe0_blk); /* X_GPE0_BLK */
+    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0); /* X_GPE1_BLK */
+
+build_hdr:
+    build_header(linker, tbl, (void *)(tbl->data + fadt_start),
+                 "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f7fa795..b644da9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -651,8 +651,8 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 /* FADT */
-static void build_fadt(GArray *table_data, BIOSLinker *linker,
-                       VirtMachineState *vms, unsigned dsdt_tbl_offset)
+static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
+                            VirtMachineState *vms, unsigned dsdt_tbl_offset)
 {
     int fadt_start = table_data->len;
     AcpiFadtDescriptorRev5_1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
@@ -761,7 +761,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     /* FADT MADT GTDT MCFG SPCR pointed to by RSDT */
     acpi_add_table(table_offsets, tables_blob);
-    build_fadt(tables_blob, tables->linker, vms, dsdt);
+    build_fadt_rev5(tables_blob, tables->linker, vms, dsdt);
 
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, vms);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d1b387e..ebde2cd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -298,108 +298,6 @@ build_facs(GArray *table_data, BIOSLinker *linker)
     facs->length = cpu_to_le32(sizeof(*facs));
 }
 
-/* FADT */
-static void
-build_fadt(GArray *tbl, BIOSLinker *linker, AcpiFadtData *f,
-           const char *oem_id, const char *oem_table_id)
-{
-    int off;
-    int fadt_start = tbl->len;
-
-    acpi_data_push(tbl, sizeof(AcpiTableHeader));
-
-    /* FACS address to be filled by Guest linker at runtime */
-    off = tbl->len;
-    build_append_int_noprefix(tbl, 0, 4); /* FIRMWARE_CTRL */
-    bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, off, 4,
-        ACPI_BUILD_TABLE_FILE, *f->facs_tbl_offset);
-
-    /* DSDT address to be filled by Guest linker at runtime */
-    off = tbl->len;
-    build_append_int_noprefix(tbl, 0, 4); /* DSDT */
-    bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, off, 4,
-        ACPI_BUILD_TABLE_FILE, *f->dsdt_tbl_offset);
-
-    /* ACPI1.0: INT_MODEL, ACPI2.0+: Reserved */
-    build_append_int_noprefix(tbl, f->int_model /* Multiple APIC */, 1);
-    /* Preferred_PM_Profile */
-    build_append_int_noprefix(tbl, 0 /* Unspecified */, 1);
-    build_append_int_noprefix(tbl, f->sci_int, 2); /* SCI_INT */
-    build_append_int_noprefix(tbl, f->smi_cmd, 4); /* SMI_CMD */
-    build_append_int_noprefix(tbl, f->acpi_enable_cmd, 1); /* ACPI_ENABLE */
-    build_append_int_noprefix(tbl, f->acpi_disable_cmd, 1); /* ACPI_DISABLE */
-    build_append_int_noprefix(tbl, 0 /* not supported */, 1); /* S4BIOS_REQ */
-    /* ACPI1.0: Reserved, ACPI2.0+: PSTATE_CNT */
-    build_append_int_noprefix(tbl, 0, 1);
-    build_append_int_noprefix(tbl, f->pm1a_evt.address, 4); /* PM1a_EVT_BLK */
-    build_append_int_noprefix(tbl, 0, 4); /* PM1b_EVT_BLK */
-    build_append_int_noprefix(tbl, f->pm1a_cnt.address, 4); /* PM1a_CNT_BLK */
-    build_append_int_noprefix(tbl, 0, 4); /* PM1b_CNT_BLK */
-    build_append_int_noprefix(tbl, 0, 4); /* PM2_CNT_BLK */
-    build_append_int_noprefix(tbl, f->pm_tmr.address, 4); /* PM_TMR_BLK */
-    build_append_int_noprefix(tbl, f->gpe0_blk.address, 4); /* GPE0_BLK */
-    build_append_int_noprefix(tbl, 0, 4); /* GPE1_BLK */
-    /* PM1_EVT_LEN */
-    build_append_int_noprefix(tbl, f->pm1a_evt.bit_width / 8, 1);
-    /* PM1_CNT_LEN */
-    build_append_int_noprefix(tbl, f->pm1a_cnt.bit_width / 8, 1);
-    build_append_int_noprefix(tbl, 0, 1); /* PM2_CNT_LEN */
-    build_append_int_noprefix(tbl, f->pm_tmr.bit_width / 8, 1); /* PM_TMR_LEN */
-    /* GPE0_BLK_LEN */
-    build_append_int_noprefix(tbl, f->gpe0_blk.bit_width / 8, 1);
-    build_append_int_noprefix(tbl, 0, 1); /* GPE1_BLK_LEN */
-    build_append_int_noprefix(tbl, 0, 1); /* GPE1_BASE */
-    build_append_int_noprefix(tbl, 0, 1); /* CST_CNT */
-    build_append_int_noprefix(tbl, f->plvl2_lat, 2); /* P_LVL2_LAT */
-    build_append_int_noprefix(tbl, f->plvl3_lat, 2); /* P_LVL3_LAT */
-    build_append_int_noprefix(tbl, 0, 2); /* FLUSH_SIZE */
-    build_append_int_noprefix(tbl, 0, 2); /* FLUSH_STRIDE */
-    build_append_int_noprefix(tbl, 0, 1); /* DUTY_OFFSET */
-    build_append_int_noprefix(tbl, 0, 1); /* DUTY_WIDTH */
-    build_append_int_noprefix(tbl, 0, 1); /* DAY_ALRM */
-    build_append_int_noprefix(tbl, 0, 1); /* MON_ALRM */
-    build_append_int_noprefix(tbl, f->rtc_century, 1); /* CENTURY */
-    build_append_int_noprefix(tbl, 0, 2); /* IAPC_BOOT_ARCH */
-    build_append_int_noprefix(tbl, 0, 1); /* Reserved */
-    build_append_int_noprefix(tbl, f->flags, 4); /* Flags */
-
-    if (f->rev == 1) {
-        goto build_hdr;
-    }
-
-    build_append_gas_from_struct(tbl, &f->reset_reg); /* RESET_REG */
-    build_append_int_noprefix(tbl, f->reset_val, 1); /* RESET_VALUE */
-    build_append_int_noprefix(tbl, 0, 3); /* Reserved, ACPI 3.0 */
-    build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
-
-    /* XDSDT address to be filled by Guest linker at runtime */
-    off = tbl->len;
-    build_append_int_noprefix(tbl, 0, 8); /* X_DSDT */
-    if (f->xdsdt_tbl_offset) {
-        bios_linker_loader_add_pointer(linker,
-            ACPI_BUILD_TABLE_FILE, off, 8,
-            ACPI_BUILD_TABLE_FILE, *f->xdsdt_tbl_offset);
-    }
-
-    build_append_gas_from_struct(tbl, &f->pm1a_evt); /* X_PM1a_EVT_BLK */
-    /* X_PM1b_EVT_BLK */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
-    build_append_gas_from_struct(tbl, &f->pm1a_cnt); /* X_PM1a_CNT_BLK */
-    /* X_PM1b_CNT_BLK */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
-    /* X_PM2_CNT_BLK */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
-    build_append_gas_from_struct(tbl, &f->pm_tmr); /* X_PM_TMR_BLK */
-    build_append_gas_from_struct(tbl, &f->gpe0_blk); /* X_GPE0_BLK */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0); /* X_GPE1_BLK */
-
-build_hdr:
-    build_header(linker, tbl, (void *)(tbl->data + fadt_start),
-                 "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
-}
-
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry)
 {
-- 
MST
