Received: from eggs.gnu.org ([2001:4830:134:3::10]:39669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6y-0001V9-DH
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6w-0005Za-Cl
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:7889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6t-0004iw-BW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:28 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:54 +0200
Message-Id: <20181022183656.4902-25-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 24/26] hw: acpi: reduced: Add SRAT table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Yang Zhong <yang.zhong@intel.com>

If the platform is a NUMA enabled, we add the SRAT table to the ACPI
build. It is up to the calling platform to define its own SRAT build
method or use the aml-build.c one.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/reduced.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 3754258335..9d0c5ba01e 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -188,6 +188,16 @@ static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
     acpi_add_table(table_offsets, tables_blob);
     mc->firmware_build_methods.acpi.madt(tables_blob, tables->linker, ms, conf);
 
+    if (conf->numa_nodes) {
+        acpi_add_table(table_offsets, tables_blob);
+        mc->firmware_build_methods.acpi.srat(tables_blob, tables->linker,
+                                             ms, conf);
+        if (have_numa_distance) {
+            acpi_add_table(table_offsets, tables_blob);
+            mc->firmware_build_methods.acpi.slit(tables_blob, tables->linker);
+        }
+    }
+
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
         mc->firmware_build_methods.acpi.mcfg(tables_blob,
-- 
2.17.2
