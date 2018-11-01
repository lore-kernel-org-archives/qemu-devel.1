Received: from eggs.gnu.org ([2001:4830:134:3::10]:59062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA8w-00044c-R3
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA8t-0002rn-50
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:61500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA8s-0002qQ-RZ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:23:59 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:42 +0100
Message-Id: <20181101102303.16439-3-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/23] hw: acpi: Export ACPI build alignment
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This is going to be needed by the Hardware-reduced ACPI routines.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index d0362e1382..81d98fa34f 100644
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
index 6c36903c0a..73fc6659f2 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -384,6 +384,8 @@ build_header(BIOSLinker *linker, GArray *table_data,
              const char *oem_id, const char *oem_table_id);
 void *acpi_data_push(GArray *table_data, unsigned size);
 unsigned acpi_data_len(GArray *table);
+/* Align AML blob size to a multiple of 'align' */
+void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
-- 
2.19.1
