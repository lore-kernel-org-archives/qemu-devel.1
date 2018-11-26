Received: from eggs.gnu.org ([2001:4830:134:3::10]:37671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmR-0000m0-GH
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmM-0004Pe-Ma
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:39 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 26 Nov 2018 17:29:34 +0100
Message-Id: <20181126162942.21258-2-sameo@linux.intel.com>
In-Reply-To: <20181126162942.21258-1-sameo@linux.intel.com>
References: <20181126162942.21258-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] hw: acpi: The RSDP build API can return
 void
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

For both x86 and ARM architectures, the internal RSDP build API can
return void as the current return value is unused.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/virt-acpi-build.c | 4 +---
 hw/i386/acpi-build.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb697c..fcaa350892 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 }
 
 /* RSDP */
-static GArray *
+static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
@@ -392,8 +392,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
         (char *)rsdp - rsdp_table->data, sizeof *rsdp,
         (char *)&rsdp->checksum - rsdp_table->data);
-
-    return rsdp_table;
 }
 
 static void
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 236a20eaa8..35f17d0d91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2547,7 +2547,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
 
-static GArray *
+static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
@@ -2569,8 +2569,6 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
         (char *)rsdp - rsdp_table->data, sizeof *rsdp,
         (char *)&rsdp->checksum - rsdp_table->data);
-
-    return rsdp_table;
 }
 
 typedef
-- 
2.19.1
