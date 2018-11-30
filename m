Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSiQO-00049j-Kg
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSiQE-0004wl-Em
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:01:40 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 30 Nov 2018 14:00:28 +0100
Message-Id: <20181130130032.11835-5-sameo@linux.intel.com>
In-Reply-To: <20181130130032.11835-1-sameo@linux.intel.com>
References: <20181130130032.11835-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/8] hw: arm: Carry RSDP specific data
 through AcpiRsdpData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Ben Warren <ben@skyportsystems.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

That will allow us to generalize the ARM build_rsdp() routine to support
both legacy RSDP (The current i386 implementation) and extended RSDP
(The ARM implementation).

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/acpi-defs.h |  8 ++++++++
 hw/arm/virt-acpi-build.c    | 18 +++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index af8e023968..8425ecb8c6 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -53,6 +53,14 @@ struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer */
 } QEMU_PACKED;
 typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
 
+typedef struct AcpiRsdpData {
+    uint8_t oem_id[6]; /* OEM identification */
+    uint8_t revision;  /* Must be 0 for 1.0, 2 for 2.0 */
+
+    unsigned *rsdt_tbl_offset;
+    unsigned *xsdt_tbl_offset;
+} AcpiRsdpData;
+
 /* Table structure from Linux kernel (the ACPI tables are under the
    BSD license) */
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0835900052..ce8bfa5a37 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -368,7 +368,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 
 /* RSDP */
 static void
-build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
+build_rsdp(GArray *rsdp_table, BIOSLinker *linker, AcpiRsdpData *rsdp_data)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
     unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
@@ -379,14 +379,14 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
                              true /* fseg memory */);
 
     memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
-    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
+    memcpy(rsdp->oem_id, rsdp_data->oem_id, sizeof(rsdp->oem_id));
     rsdp->length = cpu_to_le32(sizeof(*rsdp));
-    rsdp->revision = 0x02;
+    rsdp->revision = rsdp_data->revision;
 
     /* Address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_RSDP_FILE, xsdt_pa_offset, xsdt_pa_size,
-        ACPI_BUILD_TABLE_FILE, xsdt_tbl_offset);
+        ACPI_BUILD_TABLE_FILE, *rsdp_data->xsdt_tbl_offset);
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
@@ -857,7 +857,15 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
 
     /* RSDP is in FSEG memory, so allocate it separately */
-    build_rsdp(tables->rsdp, tables->linker, xsdt);
+    {
+        AcpiRsdpData rsdp_data = {
+            .revision = 2,
+            .oem_id = ACPI_BUILD_APPNAME6,
+            .xsdt_tbl_offset = &xsdt,
+            .rsdt_tbl_offset = NULL,
+        };
+        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
+    }
 
     /* Cleanup memory that's no longer used. */
     g_array_free(table_offsets, true);
-- 
2.19.2
