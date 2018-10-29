Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMO-0000Cw-NC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAMJ-0007xS-Qh
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:12964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAMJ-0007uo-H3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:25:43 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 17:24:24 +0100
Message-Id: <20181029162441.31631-3-sameo@linux.intel.com>
In-Reply-To: <20181029162441.31631-1-sameo@linux.intel.com>
References: <20181029162441.31631-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 02/19] hw: acpi: Export ACPI build alignment
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is going to be needed by the Hardware-reduced ACPI routines.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/aml-build.c         | 8 ++++++++
 hw/i386/acpi-build.c        | 8 --------
 include/hw/acpi/aml-build.h | 2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd736d..51b608432f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1565,6 +1565,14 @@ unsigned acpi_data_len(GArray *table)
     return table->len;
 }
 
+void acpi_align_size(GArray *blob, unsigned align)
+{
+    /* Align size to multiple of given size. This reduces the chance
+     * we need to change size in the future (breaking cross version migration).
+     */
+    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
+}
+
 void acpi_add_table(GArray *table_offsets, GArray *table_data)
 {
     uint32_t offset = table_data->len;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index c8545238c4..1bf02b6a93 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -282,14 +282,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
                                                NULL));
 }
 
-static void acpi_align_size(GArray *blob, unsigned align)
-{
-    /* Align size to multiple of given size. This reduces the chance
-     * we need to change size in the future (breaking cross version migration).
-     */
-    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
-}
-
 /* FACS */
 static void
 build_facs(GArray *table_data, BIOSLinker *linker)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903c0a..813f51317c 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -6,6 +6,7 @@
 
 /* Reserve RAM space for tables: add another order of magnitude. */
 #define ACPI_BUILD_TABLE_MAX_SIZE         0x200000
+#define ACPI_BUILD_ALIGN_SIZE             0x1000
 
 #define ACPI_BUILD_APPNAME6 "BOCHS "
 #define ACPI_BUILD_APPNAME4 "BXPC"
@@ -384,6 +385,7 @@ build_header(BIOSLinker *linker, GArray *table_data,
              const char *oem_id, const char *oem_table_id);
 void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
+void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
-- 
2.17.2
