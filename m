Received: from eggs.gnu.org ([2001:4830:134:3::10]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8Wxz-00056u-2M
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8Wxx-0004dj-VT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8Wxx-0004cm-N0
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:05 -0400
Date: Wed, 10 May 2017 22:07:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494443192-17177-2-git-send-email-mst@redhat.com>
References: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494443192-17177-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] hw/acpi-defs: replace leading X with x_ in
 FADT field names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

At the request of Michael, replace the leading capital X in the FADT
field name Xfacs and Xdsdt with lower case x + underscore.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 4 ++--
 hw/i386/acpi-build.c        | 4 ++--
 tests/bios-tables-test.c    | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 293ee45..93e1eba 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -144,8 +144,8 @@ typedef struct AcpiTableHeader AcpiTableHeader;
     /* ARM-Specific Boot Flags (see below for individual flags) (ACPI 5.1) */ \
     uint16_t arm_boot_flags; \
     uint8_t minor_revision;  /* FADT Minor Revision (ACPI 5.1) */ \
-    uint64_t Xfacs;          /* 64-bit physical address of FACS */ \
-    uint64_t Xdsdt;          /* 64-bit physical address of DSDT */ \
+    uint64_t x_facs;          /* 64-bit physical address of FACS */ \
+    uint64_t x_dsdt;          /* 64-bit physical address of DSDT */ \
     /* 64-bit Extended Power Mgt 1a Event Reg Blk address */ \
     struct AcpiGenericAddress xpm1a_event_block; \
     /* 64-bit Extended Power Mgt 1b Event Reg Blk address */ \
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1d8c645..c75f73e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -341,7 +341,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     AcpiFadtDescriptorRev3 *fadt = acpi_data_push(table_data, sizeof(*fadt));
     unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
     unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
-    unsigned xdsdt_entry_offset = (char *)&fadt->Xdsdt - table_data->data;
+    unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
 
     /* FACS address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
@@ -354,7 +354,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
     bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->Xdsdt),
+        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
 
     build_header(linker, table_data,
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 9c96a67..bdef3b9 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -175,8 +175,8 @@ static void test_acpi_fadt_table(test_data *data)
     ACPI_READ_FIELD(fadt_table->reset_value, addr);
     ACPI_READ_FIELD(fadt_table->arm_boot_flags, addr);
     ACPI_READ_FIELD(fadt_table->minor_revision, addr);
-    ACPI_READ_FIELD(fadt_table->Xfacs, addr);
-    ACPI_READ_FIELD(fadt_table->Xdsdt, addr);
+    ACPI_READ_FIELD(fadt_table->x_facs, addr);
+    ACPI_READ_FIELD(fadt_table->x_dsdt, addr);
     ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_event_block, addr);
     ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1b_event_block, addr);
     ACPI_READ_GENERIC_ADDRESS(fadt_table->xpm1a_control_block, addr);
-- 
MST
