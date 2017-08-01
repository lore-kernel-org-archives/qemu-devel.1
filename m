Received: from eggs.gnu.org ([2001:4830:134:3::10]:35984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerb-0001J6-FL
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcera-0004qg-ML
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcera-0004qD-Co
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:38:02 -0400
Date: Wed, 2 Aug 2017 00:37:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-11-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] pc: acpi: force FADT rev1 for 440fx based
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, John Arbuckle <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

w2k used to boot on QEMU until revision of FADT has
been bumped to rev3
(commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)

Keep PC machine at rev1 to remain compatible and Q35
at rev3 where w2k isn't supported anyway so OSX could
run as well.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: John Arbuckle <programmingkidx@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6b7bade..b9c245c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -90,6 +90,7 @@ typedef struct AcpiMcfgInfo {
 } AcpiMcfgInfo;
 
 typedef struct AcpiPmInfo {
+    bool force_rev1_fadt;
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
@@ -129,10 +130,13 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     Object *obj = NULL;
     QObject *o;
 
+    pm->force_rev1_fadt = false;
     pm->cpu_hp_io_base = 0;
     pm->pcihp_io_base = 0;
     pm->pcihp_io_len = 0;
     if (piix) {
+        /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
+        pm->force_rev1_fadt = true;
         obj = piix;
         pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
         pm->pcihp_io_base =
@@ -304,6 +308,9 @@ static void fadt_setup(AcpiFadtDescriptorRev3 *fadt, AcpiPmInfo *pm)
         fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_FORCE_APIC_CLUSTER_MODEL);
     }
     fadt->century = RTC_CENTURY;
+    if (pm->force_rev1_fadt) {
+        return;
+    }
 
     fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
     fadt->reset_value = 0xf;
@@ -342,6 +349,8 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     unsigned fw_ctrl_offset = (char *)&fadt->firmware_ctrl - table_data->data;
     unsigned dsdt_entry_offset = (char *)&fadt->dsdt - table_data->data;
     unsigned xdsdt_entry_offset = (char *)&fadt->x_dsdt - table_data->data;
+    int fadt_size = sizeof(*fadt);
+    int rev = 3;
 
     /* FACS address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
@@ -353,12 +362,17 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, dsdt_entry_offset, sizeof(fadt->dsdt),
         ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
-    bios_linker_loader_add_pointer(linker,
-        ACPI_BUILD_TABLE_FILE, xdsdt_entry_offset, sizeof(fadt->x_dsdt),
-        ACPI_BUILD_TABLE_FILE, dsdt_tbl_offset);
+    if (pm->force_rev1_fadt) {
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
-- 
MST
