Received: from eggs.gnu.org ([2001:4830:134:3::10]:33481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSiQH-00042v-S5
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gSiQE-0004x9-OD
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:01:33 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 30 Nov 2018 14:00:27 +0100
Message-Id: <20181130130032.11835-4-sameo@linux.intel.com>
In-Reply-To: <20181130130032.11835-1-sameo@linux.intel.com>
References: <20181130130032.11835-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/8] hw: i386: Use correct RSDT length for
 checksum
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

From: Igor Mammedov <imammedo@redhat.com>

AcpiRsdpDescriptor describes revision 2 RSDP table so using sizeof(*rsdp)
for checksum calculation isn't correct since we are adding extra 16 bytes.
But acpi_data_push() zeroes out table, so just by luck we are summing up
exta zeros which still yelds correct checksum.

Fix it up by explicitly stating table size instead of using
pointer arithmetics on stucture.

PS:
Extra 16 bytes are still wasted, but droping them will break migration
for machines older than 2.3 due to size mismatch, for 2.3 and older it's
not an issue since they are using resizable memory regions (a1666142d)
for ACPI blobs. So keep wasting memory to avoid breaking old machines.

Fixes: 72c194f7e (i386: ACPI table generation code from seabios)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 35f17d0d91..fb877648ac 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2550,6 +2550,11 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 static void
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
 {
+    /* AcpiRsdpDescriptor describes revision 2 RSDP table and as result we
+     * allocate extra 16 bytes for pc/q35 RSDP rev1 as well. Keep extra 16 bytes
+     * wasted to make sure we won't breake migration for machine types older
+     * than 2.3 due to size mismatch.
+     */
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
     unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
     unsigned rsdt_pa_offset =
@@ -2567,7 +2572,7 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
         (char *)&rsdp->checksum - rsdp_table->data);
 }
 
-- 
2.19.2
