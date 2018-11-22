Received: from eggs.gnu.org ([2001:4830:134:3::10]:42644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPmMB-00038o-PY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPmMA-0004Rj-UN
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gPmMA-0004RE-P4
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:37:10 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 22 Nov 2018 11:29:34 +0100
Message-Id: <1542882574-109418-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
References: <1542882574-109418-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] arm/virt: acpi: fix incorrect checksums in
 RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameo@linux.intel.com, mst@redhat.com, drjones@redhat.com, peter.maydell@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

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

Fixes: d4bec5d87 (hw/arm/virt-acpi-build: Generate RSDP table)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Shannon Zhao <shannon.zhaosl@gmail.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/arm/virt-acpi-build.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb6..daa093b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -390,9 +390,14 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
 
     /* Checksum to be filled by Guest linker */
     bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
-        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
+        (char *)rsdp - rsdp_table->data, 20 /* ACPI rev 1.0 RSDP size */,
         (char *)&rsdp->checksum - rsdp_table->data);
 
+    /* Extended checksum to be filled by Guest linker */
+    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
+        (char *)rsdp - rsdp_table->data, 36 /* ACPI rev 2.0 RSDP size */,
+        (char *)&rsdp->extended_checksum - rsdp_table->data);
+
     return rsdp_table;
 }
 
-- 
2.7.4
