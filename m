Received: from eggs.gnu.org ([2001:4830:134:3::10]:39701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf73-0001ZT-JX
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6y-0005an-B0
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:7887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6u-0004fU-Jv
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:30 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:53 +0200
Message-Id: <20181022183656.4902-24-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 23/26] hw: acpi: reduced: Add reboot support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jing Liu <jing2.liu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Jing Liu <jing2.liu@linux.intel.com>

We only need to expose it through FADT.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/acpi/reduced.c         | 7 ++++++-
 include/hw/acpi/reduced.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 329d5112ca..3754258335 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -128,10 +128,15 @@ static void build_fadt_reduced(GArray *table_data, BIOSLinker *linker,
     AcpiFadtData fadt = {
         .rev = 5,
         .minor_ver = 1,
-        .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
+        .flags = (1 << ACPI_FADT_F_HW_REDUCED_ACPI) |
+                 (1 << ACPI_FADT_F_RESET_REG_SUP),
         .dsdt_tbl_offset = &dsdt_tbl_offset,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
         .arm_boot_arch = 0,
+        .reset_reg = { .space_id = AML_AS_SYSTEM_IO,
+                      .bit_width = 8, .bit_offset = 0,
+                      .address = ACPI_REDUCED_RESET_IOPORT },
+        .reset_val = ACPI_REDUCED_RESET_VALUE,
         .sleep_control_reg = { .space_id = AML_AS_SYSTEM_IO,
                               .bit_width = 8, .bit_offset = 0,
                               .address = ACPI_REDUCED_SLEEP_CONTROL_IOPORT },
diff --git a/include/hw/acpi/reduced.h b/include/hw/acpi/reduced.h
index 3d3c003353..bcd266afd0 100644
--- a/include/hw/acpi/reduced.h
+++ b/include/hw/acpi/reduced.h
@@ -22,6 +22,8 @@
 #define ACPI_REDUCED_SLEEP_LEVEL          5
 #define ACPI_REDUCED_SLEEP_ENABLE         (1 << 5) /* SLP_EN */
 #define ACPI_REDUCED_SLEEP_CONTROL_IOPORT 0x3B0
+#define ACPI_REDUCED_RESET_IOPORT         0x3C0
+#define ACPI_REDUCED_RESET_VALUE          4
 
 typedef struct Aml Aml;
 
-- 
2.17.2
