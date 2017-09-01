Received: from eggs.gnu.org ([2001:4830:134:3::10]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cascardo@canonical.com>) id 1dno95-0008By-9q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cascardo@canonical.com>) id 1dno92-00052d-82
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:46:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cascardo@canonical.com>)
	id 1dno92-00051G-1L
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:46:08 -0400
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Fri,  1 Sep 2017 12:45:42 -0300
Message-Id: <20170901154542.5687-1-cascardo@canonical.com>
Subject: [Qemu-devel] [PATCH] x86/acpi: build SRAT when memory hotplug is
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Linux uses SRAT to determine the maximum memory in a system, which is
used to determine whether to use the swiotlb for IOMMU or not for a
device that supports only 32 bits of addresses.

When there is no NUMA configuration, qemu will not build SRAT. And when
memory hotplug is done, some Linux device drivers start failing.

Tested by running with -m 512M,slots=8,maxmem=1G, adding the memory,
putting that online and using the system. Without the patch, swiotlb is
not used and ATA driver fails. With the patch, swiotlb is used, no
driver failure is observed.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 hw/i386/acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 98dd424678..fb94249779 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2645,6 +2645,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     GArray *tables_blob = tables->table_data;
     AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
     Object *vmgenid_dev;
+    ram_addr_t hotplugabble_address_space_size =
+        object_property_get_int(OBJECT(pcms), PC_MACHINE_MEMHP_REGION_SIZE,
+                                NULL);
 
     acpi_get_pm_info(&pm);
     acpi_get_misc_info(&misc);
@@ -2708,7 +2711,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             build_tpm2(tables_blob, tables->linker);
         }
     }
-    if (pcms->numa_nodes) {
+    if (pcms->numa_nodes || hotplugabble_address_space_size) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
         if (have_numa_distance) {
-- 
2.11.0
