Received: from eggs.gnu.org ([2001:4830:134:3::10]:52092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGM-0005Mc-Sz
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGL-0003Kb-JO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGL-000355-8r
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:41 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:08 +0800
Message-Id: <20171207101812.23602-7-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 06/10] hw/acpi-build,
 xen-hvm: introduce a Xen-specific ACPI builder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

QEMU on KVM/TCG and Xen requires different sets of guest ACPI tables.
When QEMU builds ACPI for Xen HVM domains, the new Xen-specific ACPI
build function xen_acpi_build() is called instead of the existing path
from acpi_build().

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/acpi-build.c        |  9 ++++++++-
 hw/i386/xen/xen-hvm.c       | 21 +++++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 ++++
 include/hw/xen/xen.h        |  4 ++++
 stubs/xen-hvm.c             |  5 +++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 73519ab3ac..9007ecdaed 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -60,6 +60,7 @@
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/xen/xen.h"
 
 #include "hw/acpi/ipmi.h"
 
@@ -2556,7 +2557,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
 
-static GArray *
+GArray *
 build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
 {
     AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
@@ -2646,6 +2647,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                              64 /* Ensure FACS is aligned */,
                              false /* high memory */);
 
+    if (xen_enabled()) {
+        xen_acpi_build(tables, table_offsets, machine);
+        goto done;
+    }
+
     /*
      * FACS is pointed to by FADT.
      * We place it first since it's the only table that has alignment
@@ -2788,6 +2794,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
 
+ done:
     /* Cleanup memory that's no longer used. */
     g_array_free(table_offsets, true);
 }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 4b29f4052b..3df20ff282 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
@@ -1473,3 +1474,23 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
         memory_global_dirty_log_stop();
     }
 }
+
+void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
+                    MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    GArray *tables_blob = tables->table_data;
+    unsigned int rsdt;
+
+    if (!pcms->acpi_build_enabled) {
+        return;
+    }
+
+    /*
+     * QEMU RSDP and RSDT are only used by hvmloader to enumerate
+     * QEMU-built tables. HVM domains still use Xen-built RSDP and RSDT.
+     */
+    rsdt = tables_blob->len;
+    build_rsdt(tables_blob, tables->linker, table_offsets, 0, 0);
+    build_rsdp(tables->rsdp, tables->linker, rsdt);
+}
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738d76..03369bb7ea 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -393,4 +393,8 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
 void build_slit(GArray *table_data, BIOSLinker *linker);
+
+GArray *build_rsdp(GArray *rsdp_table, BIOSLinker *linker,
+                   unsigned rsdt_tbl_offset);
+
 #endif
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa8fe..2785b8fd35 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -10,6 +10,7 @@
 
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 
 /* xen-machine.c */
@@ -48,4 +49,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
+void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
+                    MachineState *machine);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 3ca6c51b21..58017c1457 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -61,3 +61,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
+
+void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
+                    MachineState *machine)
+{
+}
-- 
2.15.1
