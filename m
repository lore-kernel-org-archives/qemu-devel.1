Received: from eggs.gnu.org ([2001:4830:134:3::10]:37794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmc-0000ub-7l
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJma-0004Zw-Ff
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:50 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 26 Nov 2018 17:29:38 +0100
Message-Id: <20181126162942.21258-6-sameo@linux.intel.com>
In-Reply-To: <20181126162942.21258-1-sameo@linux.intel.com>
References: <20181126162942.21258-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/8] hw: arm: Convert the RSDP build to the
 buid_append_foo() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

build_rsdp() is now closely following the ACPI spec instead of filling a
mapped and packed C structure.
With this change we will eventually be able to get rid of the
AcpiRsdpDescriptor structure as we're just appending values to the RSDP
file directly and not mapping this structure in memory any more.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/acpi/acpi-defs.h | 22 ++++++++++++++
 hw/arm/virt-acpi-build.c    | 60 ++++++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index e7fd24c6c5..9b2f6b8043 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -61,9 +61,31 @@ typedef struct AcpiRsdpData {
     unsigned *xsdt_tbl_offset;
 } AcpiRsdpData;
 
+/* RSDP signature */
+#define ACPI_RSDP_SIGNATURE "RSD PTR "
+
+/* RSDP Revisions */
 #define ACPI_RSDP_REV_1 0
 #define ACPI_RSDP_REV_2 2
 
+/* RSDP lengths */
+#define ACPI_RSDP_REV_1_LEN    20
+#define ACPI_RSDP_REV_2_LEN    36
+#define ACPI_RSDP_SIG_LEN      8
+#define ACPI_RSDP_OEMID_LEN    6
+#define ACPI_RSDP_REVISION_LEN 1
+#define ACPI_RSDP_LEN_LEN      4
+#define ACPI_RSDP_CHECKSUM_LEN 1
+#define ACPI_RSDP_RESERVED_LEN 3
+
+/* RSDP offsets */
+#define ACPI_RSDP_CHECKSUM_OFFSET     8
+#define ACPI_RSDP_REVISION_OFFSET     15
+#define ACPI_RSDP_RSDT_OFFSET         16
+#define ACPI_RSDP_XSDT_OFFSET         24
+#define ACPI_RSDP_EXT_CHECKSUM_OFFSET 32
+
+
 /* Table structure from Linux kernel (the ACPI tables are under the
    BSD license) */
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2dad465ecf..d47978a55e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -368,35 +368,53 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 
 /* RSDP */
 static void
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
+build_rsdp(GArray *tbl, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
 {
-    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
-    unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
-    unsigned xsdt_pa_offset =
-        (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
-
-    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
+    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, tbl, 16,
                              true /* fseg memory */);
 
-    memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
-    memcpy(rsdp->oem_id, rsdp_data->oem_id, sizeof(rsdp->oem_id));
-    rsdp->length = cpu_to_le32(sizeof(*rsdp));
-    rsdp->revision = rsdp_data->revision;
+    /* RSDP signature */
+    g_array_append_vals(tbl, ACPI_RSDP_SIGNATURE, ACPI_RSDP_SIG_LEN);
+
+    /* Space for the checksum */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
+
+    /* OEM ID */
+    g_array_append_vals(tbl, rsdp_data->oem_id, ACPI_RSDP_OEMID_LEN);
+
+    /* Revision */
+    build_append_int_noprefix(tbl, rsdp_data->revision,
+                              ACPI_RSDP_REVISION_LEN);
 
-    /* Address to be filled by Guest linker */
+    /* Space for the RSDT address (32 bit) */
+    build_append_int_noprefix(tbl, 0, 4);
+
+    /* Length */
+    build_append_int_noprefix(tbl, ACPI_RSDP_REV_2_LEN, ACPI_RSDP_LEN_LEN);
+
+    /* XSDT address to be filled by guest linker */
+    build_append_int_noprefix(tbl, 0, 8); /* XSDT address (64 bit) */
     bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, *rsdp_data->xsdt_tbl_offset);
+                                   ACPI_BUILD_RSDP_FILE,
+                                   ACPI_RSDP_XSDT_OFFSET, 8,
+                                   ACPI_BUILD_TABLE_FILE,
+                                   *rsdp_data->xsdt_tbl_offset);
+
+    /* Space for the extended checksum */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_CHECKSUM_LEN);
+
+    /* Space for the reserved bytes */
+    build_append_int_noprefix(tbl, 0, ACPI_RSDP_RESERVED_LEN);
 
-    /* Checksum to be filled by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
-        (char *)&rsdp->checksum - rsdp_table->data);
+    /* Checksum to be filled by guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
+                                    ACPI_RSDP_REV_1_LEN,
+                                    ACPI_RSDP_CHECKSUM_OFFSET);
 
     /* Extended checksum to be filled by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, 36 /* ACPI rev 2.0 RSDP size */,
-        (char *)&rsdp->extended_checksum - rsdp_table->data);
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE, 0,
+                                    ACPI_RSDP_REV_2_LEN,
+                                    ACPI_RSDP_EXT_CHECKSUM_OFFSET);
 }
 
 static void
-- 
2.19.1
