Received: from eggs.gnu.org ([2001:4830:134:3::10]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg64-00018j-Ph
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg63-0001pe-Hr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg63-0001pM-By
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Date: Tue, 10 Jul 2018 03:01:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-8-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 7/7] pc: HACK: acpi: tie in
 _CST object to Processor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>

Based on patch by Igor Mammedov.

This is a hack: we definitely shouldn't do it
unconditionally, and initialization should be handled
differently (through an isa device?). io port to use
should depend on the PC type and should be documented.

Notifications should be supported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  5 +++++
 hw/acpi/cpu.c        |  5 +++++
 hw/i386/acpi-build.c | 10 +++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 316230e570..83b3a84322 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -20,6 +20,11 @@
 
 #define HPET_INTCAP "hpet-intcap"
 
+typedef struct PCCstate {
+    uint32_t latency;
+    uint32_t hint;
+} PCCstate;
+
 /**
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595ecbe..e9e207b033 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -561,6 +561,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                            aml_int(arch_ids->cpus[i].props.node_id)));
             }
 
+            if (1) {
+                method = aml_method("_CST", 0, AML_NOTSERIALIZED);
+                aml_append(method, aml_return(aml_call0("CCST")));
+                aml_append(dev, method);
+            }
             aml_append(cpus_dev, dev);
         }
     }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fff1059a31..da2c830db7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/i386/intel_iommu.h"
 
 #include "hw/acpi/ipmi.h"
+#include "hw/acpi/cst.h"
 
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
@@ -1840,7 +1841,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
         CPUHotplugFeatures opts = {
-            .apci_1_compatible = true, .has_legacy_cphp = true
+            .apci_1_compatible = true, .has_legacy_cphp = true,
         };
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
@@ -2693,6 +2694,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                            tables->vmgenid, tables->linker);
     }
 
+    /* TODO: get a free ioport. This one is PIIX specific. */
+    acpi_add_table(table_offsets, tables_blob);
+    cst_build_acpi(tables_blob, tables->linker, 0xaf20);
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker);
@@ -2891,6 +2896,9 @@ void acpi_setup(void)
 
     build_state = g_malloc0(sizeof *build_state);
 
+    /* TODO: this is not the best place to do it */
+    cst_register(pcms->fw_cfg, 0xaf20);
+
     acpi_build_tables_init(&tables);
     acpi_build(&tables, MACHINE(pcms));
 
-- 
MST
