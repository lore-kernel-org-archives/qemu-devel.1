Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2Iw-0006WY-NK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2Iu-0000Yv-Rd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:02 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1co2Iu-0000YL-Fg
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:21:00 -0400
Received: by mail-pg0-x242.google.com with SMTP id m5so1133682pgk.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 23:21:00 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Mar 2017 19:20:26 +1300
Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan.eu>
In-Reply-To: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
References: <1489558827-28971-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH v3 1/2] hw/i386: Use Rev3 FADT (ACPI 2.0)
 instead of Rev1 to improve guest OS support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

This updates the FADT generated for x86/64 machine types from Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The intention is to expose the reset register information to guest operating systems which require it, specifically OS X/macOS. Revision 1 FADTs do not contain the fields relating to the reset register.

The new layout and contents remains backwards-compatible with operating systems which only support ACPI 1.0, as the existing fields are not modified by this change, as the 64-bit and 32-bit variants are allowed to co-exist according to the ACPI 2.0 standard. No regressions became apparent in tests with a range of Windows (XP-10) and Linux versions.

The BIOS tables test suite's FADT checksum test has also been updated to reflect the new FADT layout and content.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/i386/acpi-build.c        | 32 +++++++++++++++++--
 include/hw/acpi/acpi-defs.h | 77 +++++++++++++++++++++------------------------
 tests/acpi-utils.h          | 10 ++++++
 tests/bios-tables-test.c    | 23 +++++++++++---
 4 files changed, 93 insertions(+), 49 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2073108..7997f06 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -272,7 +272,7 @@ build_facs(GArray *table_data, BIOSLinker *linker)
 }
 
 /* Load chipset information in FADT */
-static void fadt_setup(AcpiFadtDescriptorRev1 *fadt, AcpiPmInfo *pm)
+static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
 {
     fadt->model = 1;
     fadt->reserved1 = 0;
@@ -304,6 +304,28 @@ static void fadt_setup(AcpiFadtDescriptorRev1 *fadt, AcpiPmInfo *pm)
         fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
     }
     fadt->century = RTC_CENTURY;
+
+    fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
+    fadt->reset_value = 0xf;
+    fadt->reset_register.space_id = AML_SYSTEM_IO;
+    fadt->reset_register.bit_width = 8;
+    fadt->reset_register.address = cpu_to_le64(ICH9_RST_CNT_IOPORT);
+
+    fadt->xpm1a_event_block.space_id = AML_SYSTEM_IO;
+    fadt->xpm1a_event_block.bit_width = fadt->pm1_evt_len * 8;
+    fadt->xpm1a_event_block.address = cpu_to_le64(pm->io_base);
+
+    fadt->xpm1a_control_block.space_id = AML_SYSTEM_IO;
+    fadt->xpm1a_control_block.bit_width = fadt->pm1_cnt_len * 8;
+    fadt->xpm1a_control_block.address = cpu_to_le64(pm->io_base + 0x4);
+
+    fadt->xpm_timer_block.space_id = AML_SYSTEM_IO;
+    fadt->xpm_timer_block.bit_width = fadt->pm_tmr_len * 8;
+    fadt->xpm_timer_block.address = cpu_to_le64(pm->io_base + 0x8);
+
+    fadt->xgpe0_block.space_id = AML_SYSTEM_IO;
+    fadt->xgpe0_block.bit_width = pm->gpe0_blk_len * 8;
+    fadt->xgpe0_block.address = cpu_to_le64(pm->gpe0_blk);
 }
 
 
@@ -313,9 +335,10 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
            unsigned facs_tbl_offset, unsigned dsdt_tbl_offset,
            const char *oem_id, const char *oem_table_id)
 {
-    AcpiFadtDescriptorRev1 *fadt = acpi_data_push(table_data, sizeof(*fadt));
+    AcpiFadtDescriptorRev3 *fadt = acpi_data_push(table_data, sizeof(*fadt));
     unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
     unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
+    unsigned xdsdt_entry_offset = (char *)&fadt->Xdsdt - table_data->data;
 
     /* FACS address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
@@ -327,9 +350,12 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->Xdsdt),
+        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
 
     build_header(linker, table_data,
-                 (void *)fadt, "FACP", sizeof(*fadt), 1, oem_id, oem_table_id);
+                 (void *)fadt, "FACP", sizeof(*fadt), 3, oem_id, oem_table_id);
 }
 
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 4cc3630..293ee45 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -131,17 +131,37 @@ typedef struct AcpiTableHeader AcpiTableHeader;
     uint8_t  duty_width;   /* Bit width of duty cycle field in p_cnt reg */ \
     uint8_t  day_alrm;     /* Index to day-of-month alarm in RTC CMOS RAM */ \
     uint8_t  mon_alrm;     /* Index to month-of-year alarm in RTC CMOS RAM */ \
-    uint8_t  century;      /* Index to century in RTC CMOS RAM */
-
-struct AcpiFadtDescriptorRev1
-{
-    ACPI_FADT_COMMON_DEF
-    uint8_t  reserved4;              /* Reserved */
-    uint8_t  reserved4a;             /* Reserved */
-    uint8_t  reserved4b;             /* Reserved */
-    uint32_t flags;
-} QEMU_PACKED;
-typedef struct AcpiFadtDescriptorRev1 AcpiFadtDescriptorRev1;
+    uint8_t  century;      /* Index to century in RTC CMOS RAM */ \
+    /* IA-PC Boot Architecture Flags (see below for individual flags) */ \
+    uint16_t boot_flags; \
+    uint8_t reserved;    /* Reserved, must be zero */ \
+    /* Miscellaneous flag bits (see below for individual flags) */ \
+    uint32_t flags; \
+    /* 64-bit address of the Reset register */ \
+    struct AcpiGenericAddress reset_register; \
+    /* Value to write to the reset_register port to reset the system */ \
+    uint8_t reset_value; \
+    /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */ \
+    uint16_t arm_boot_flags; \
+    uint8_t minor_revision;  /* FADT Minor Revision (ACPI 5.1) */ \
+    uint64_t Xfacs;          /* 64-bit physical address of FACS */ \
+    uint64_t Xdsdt;          /* 64-bit physical address of DSDT */ \
+    /* 64-bit Extended Power Mgt 1a Event Reg Blk address */ \
+    struct AcpiGenericAddress xpm1a_event_block; \
+    /* 64-bit Extended Power Mgt 1b Event Reg Blk address */ \
+    struct AcpiGenericAddress xpm1b_event_block; \
+    /* 64-bit Extended Power Mgt 1a Control Reg Blk address */ \
+    struct AcpiGenericAddress xpm1a_control_block; \
+    /* 64-bit Extended Power Mgt 1b Control Reg Blk address */ \
+    struct AcpiGenericAddress xpm1b_control_block; \
+    /* 64-bit Extended Power Mgt 2 Control Reg Blk address */ \
+    struct AcpiGenericAddress xpm2_control_block; \
+    /* 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */ \
+    struct AcpiGenericAddress xpm_timer_block; \
+    /* 64-bit Extended General Purpose Event 0 Reg Blk address */ \
+    struct AcpiGenericAddress xgpe0_block; \
+    /* 64-bit Extended General Purpose Event 1 Reg Blk address */ \
+    struct AcpiGenericAddress xgpe1_block; \
 
 struct AcpiGenericAddress {
     uint8_t space_id;        /* Address space where struct or register exists */
@@ -151,38 +171,13 @@ struct AcpiGenericAddress {
     uint64_t address;        /* 64-bit address of struct or register */
 } QEMU_PACKED;
 
+struct AcpiFadtDescriptorRev3 {
+    ACPI_FADT_COMMON_DEF
+} QEMU_PACKED;
+typedef struct AcpiFadtDescriptorRev3 AcpiFadtDescriptorRev3;
+
 struct AcpiFadtDescriptorRev5_1 {
     ACPI_FADT_COMMON_DEF
-    /* IA-PC Boot Architecture Flags (see below for individual flags) */
-    uint16_t boot_flags;
-    uint8_t reserved;    /* Reserved, must be zero */
-    /* Miscellaneous flag bits (see below for individual flags) */
-    uint32_t flags;
-    /* 64-bit address of the Reset register */
-    struct AcpiGenericAddress reset_register;
-    /* Value to write to the reset_register port to reset the system */
-    uint8_t reset_value;
-    /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */
-    uint16_t arm_boot_flags;
-    uint8_t minor_revision;  /* FADT Minor Revision (ACPI 5.1) */
-    uint64_t Xfacs;          /* 64-bit physical address of FACS */
-    uint64_t Xdsdt;          /* 64-bit physical address of DSDT */
-    /* 64-bit Extended Power Mgt 1a Event Reg Blk address */
-    struct AcpiGenericAddress xpm1a_event_block;
-    /* 64-bit Extended Power Mgt 1b Event Reg Blk address */
-    struct AcpiGenericAddress xpm1b_event_block;
-    /* 64-bit Extended Power Mgt 1a Control Reg Blk address */
-    struct AcpiGenericAddress xpm1a_control_block;
-    /* 64-bit Extended Power Mgt 1b Control Reg Blk address */
-    struct AcpiGenericAddress xpm1b_control_block;
-    /* 64-bit Extended Power Mgt 2 Control Reg Blk address */
-    struct AcpiGenericAddress xpm2_control_block;
-    /* 64-bit Extended Power Mgt Timer Ctrl Reg Blk address */
-    struct AcpiGenericAddress xpm_timer_block;
-    /* 64-bit Extended General Purpose Event 0 Reg Blk address */
-    struct AcpiGenericAddress xgpe0_block;
-    /* 64-bit Extended General Purpose Event 1 Reg Blk address */
-    struct AcpiGenericAddress xgpe1_block;
     /* 64-bit Sleep Control register (ACPI 5.0) */
     struct AcpiGenericAddress sleep_control;
     /* 64-bit Sleep Status register (ACPI 5.0) */
diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 9f9a2d5..59bf978 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -87,6 +87,16 @@ typedef struct {
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
 } while (0)
 
+#define ACPI_READ_GENERIC_ADDRESS(field, addr)       \
+    do {                                             \
+        ACPI_READ_FIELD((field).space_id, addr);     \
+        ACPI_READ_FIELD((field).bit_width, addr);    \
+        ACPI_READ_FIELD((field).bit_offset, addr);   \
+        ACPI_READ_FIELD((field).access_width, addr); \
+        ACPI_READ_FIELD((field).address, addr);      \
+    } while (0);
+
+
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(void);
 void acpi_parse_rsdp_table(uint32_t addr, AcpiRsdpDescriptor *rsdp_table);
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 88dbf97..9c96a67 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -29,7 +29,7 @@ typedef struct {
     uint32_t rsdp_addr;
     AcpiRsdpDescriptor rsdp_table;
     AcpiRsdtDescriptorRev1 rsdt_table;
-    AcpiFadtDescriptorRev1 fadt_table;
+    AcpiFadtDescriptorRev3 fadt_table;
     AcpiFacsDescriptorRev1 facs_table;
     uint32_t *rsdt_tables_addr;
     int rsdt_tables_nr;
@@ -126,7 +126,7 @@ static void test_acpi_rsdt_table(test_data *data)
 
 static void test_acpi_fadt_table(test_data *data)
 {
-    AcpiFadtDescriptorRev1 *fadt_table = &data->fadt_table;
+    AcpiFadtDescriptorRev3 *fadt_table = &data->fadt_table;
     uint32_t addr;
 
     /* FADT table comes first */
@@ -168,10 +168,23 @@ static void test_acpi_fadt_table(test_data *data)
     ACPI_READ_FIELD(fadt_table->day_alrm, addr);
     ACPI_READ_FIELD(fadt_table->mon_alrm, addr);
     ACPI_READ_FIELD(fadt_table->century, addr);
-    ACPI_READ_FIELD(fadt_table->reserved4, addr);
-    ACPI_READ_FIELD(fadt_table->reserved4a, addr);
-    ACPI_READ_FIELD(fadt_table->reserved4b, addr);
+    ACPI_READ_FIELD(fadt_table->boot_flags, addr);
+    ACPI_READ_FIELD(fadt_table->reserved, addr);
     ACPI_READ_FIELD(fadt_table->flags, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->reset_register, addr);
+    ACPI_READ_FIELD(fadt_table->reset_value, addr);
+    ACPI_READ_FIELD(fadt_table->arm_boot_flags, addr);
+    ACPI_READ_FIELD(fadt_table->minor_revision, addr);
+    ACPI_READ_FIELD(fadt_table->Xfacs, addr);
+    ACPI_READ_FIELD(fadt_table->Xdsdt, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_event_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_event_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm2_control_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm_timer_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe0_block, addr);
+    ACPI_READ_GENERIC_ADDRESS(fadt_table->xgpe1_block, addr);
 
     ACPI_ASSERT_CMP(fadt_table->signature, "FACP");
     g_assert(!acpi_calc_checksum((uint8_t *)fadt_table, fadt_table->length));
-- 
2.3.2 (Apple Git-55)
