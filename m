Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZI03-0007XG-4r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZI02-0003Ko-5R
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:39 -0500
Date: Tue, 18 Dec 2018 11:13:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-24-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/30] hw: arm: acpi: Fix incorrect checksums
 in RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, qemu-arm@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

When RSDP table was introduced (d4bec5d87), we calculated only legacy
checksum, and that was incorrect as it
 - specified rev=2 and forgot about extended checksum.
 - legacy checksum calculated on full table instead of the 1st 20 bytes

Fix it by adding extended checksum calculation and using correct
size for legacy checksum.

While at it use explicit constants to specify sub/full tables
sizes instead of relying on AcpiRsdpDescriptor size and fields offsets.
The follow up commits will convert this table to build_append_int_noprefix() API,
will use constants anyway and remove unused AcpiRsdpDescriptor structure.

Based on "[PATCH v5 05/24] hw: acpi: Implement XSDT support for  RSDP"
by Samuel Ortiz, who did it right in his impl.

Fixes: d4bec5d87 ("hw/arm/virt-acpi-build: Generate RSDP table")
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Shannon Zhao <shannon.zhaosl@gmail.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt-acpi-build.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index fcaa350892..0835900052 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -390,8 +390,13 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
         (char *)&rsdp->checksum - rsdp_table->data);
+
+    /* Extended checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, 36 /* ACPI rev 2.0 RSDP size */,
+        (char *)&rsdp->extended_checksum - rsdp_table->data);
 }
 
 static void
-- 
MST
