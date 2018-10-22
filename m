Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6d-00018K-19
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6b-0005EH-Gv
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:7887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6b-0004fU-5G
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:09 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:50 +0200
Message-Id: <20181022183656.4902-21-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 20/26] hw: acpi: reduced: Generic Event Device
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The ACPI Generic Event Device (GED) is a hardware-reduced specific
device that handles all platform events, including the hotplug ones.
This patch generate the AML code that defines GEDs.
Platforms need to specify their own GedEvent array to describe what kind
of events they want to support through GED. The build_ged_aml routine
takes a GedEvent array that maps a specific GED event to an IRQ number.
Then we use that array to build both the _CRS and the _EVT section
of the GED device.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/reduced.c         | 171 +++++++++++++++++++++++++++++++++++++-
 include/hw/acpi/acpi.h    |   4 +
 include/hw/acpi/reduced.h |  16 ++++
 3 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 0f6397c740..53b57760eb 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -30,6 +30,8 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/cpu.h"
+#include "hw/acpi/pc-hotplug.h"
 #include "hw/acpi/reduced.h"
 
 #include "hw/nvram/fw_cfg.h"
@@ -44,9 +46,34 @@
 
 #include "migration/vmstate.h"
 
+#define GED_DEVICE "GED"
+
+static void acpi_dsdt_add_cpus(MachineState *ms, Aml *dsdt, Aml *scope,
+                               int smp_cpus, AcpiConfiguration *conf)
+{
+    CPUHotplugFeatures opts = {
+        .apci_1_compatible = false,
+        .has_legacy_cphp = false,
+    };
+
+    build_cpus_aml(dsdt, ms, opts, conf->cpu_hotplug_io_base,
+                   "\\_SB", NULL);
+}
+
+static void acpi_dsdt_add_ged(Aml *scope, AcpiConfiguration *conf)
+{
+    if (!conf->ged_events || !conf->ged_events_size) {
+        return;
+    }
+
+    build_ged_aml(scope, "\\_SB."GED_DEVICE,
+                  conf->ged_events, conf->ged_events_size);
+}
+
 /* DSDT */
-static void build_dsdt(GArray *table_data, BIOSLinker *linker,
-                       AcpiPciBus *pci_host)
+static void build_dsdt(MachineState *ms,
+                       GArray *table_data, BIOSLinker *linker,
+                       AcpiPciBus *pci_host, AcpiConfiguration *conf)
 {
     Aml *scope, *dsdt;
 
@@ -58,6 +85,8 @@ static void build_dsdt(GArray *table_data, BIOSLinker *linker,
     if (pci_host->pci_bus) {
         acpi_dsdt_add_pci_bus(dsdt, pci_host);
     }
+    acpi_dsdt_add_cpus(ms, dsdt, scope, smp_cpus, conf);
+    acpi_dsdt_add_ged(dsdt, conf);
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
@@ -118,7 +147,7 @@ static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
 
     /* DSDT is pointed to by FADT */
     dsdt = tables_blob->len;
-    build_dsdt(tables_blob, tables->linker, &acpi_pci_host);
+    build_dsdt(ms, tables_blob, tables->linker, &acpi_pci_host, conf);
 
     /* FADT pointed to by RSDT */
     acpi_add_table(table_offsets, tables_blob);
@@ -253,3 +282,139 @@ void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf)
      */
     acpi_build_tables_cleanup(&tables, false);
 }
+
+#define CPU_SCAN_METHOD   "CSCN"
+
+static Aml *ged_event_aml(GedEvent *event)
+{
+    if (!event) {
+        return NULL;
+    }
+
+    switch (event->event) {
+    case GED_CPU_HOTPLUG:
+        /* We run a complete CPU SCAN when getting a CPU hotplug event */
+        return aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD);
+    case GED_MEMORY_HOTPLUG:
+    case GED_PCI_HOTPLUG:
+    case GED_NVDIMM_HOTPLUG:
+        /* Not supported for now */
+        return NULL;
+    default:
+        break;
+    }
+
+    return NULL;
+}
+
+void build_ged_aml(Aml *table, const char *name,
+                   GedEvent *events, uint8_t events_size)
+{
+    Aml *crs = aml_resource_template();
+    Aml *evt;
+    Aml *zero = aml_int(0);
+    Aml *one = aml_int(1);
+    Aml *dev = aml_device("%s", name);
+    Aml *has_irq = aml_local(0);
+    Aml *while_ctx;
+    uint8_t i;
+
+    /*
+     * For each GED event we:
+     * - Add an interrupt to the CRS section.
+     * - Add a conditional block for each event, inside a while loop.
+     *   This is semantically equivalent to a switch/case implementation.
+     */
+    evt = aml_method("_EVT", 1, AML_SERIALIZED);
+    {
+        Aml *irq = aml_arg(0);
+        Aml *ged_aml;
+        Aml *if_ctx, *else_ctx;
+
+        /* Local0 = One */
+        aml_append(evt, aml_store(one, has_irq));
+
+
+        /*
+         * Here we want to call a method for each supported GED event type.
+         * The resulting ASL code looks like:
+         *
+         * Local0 = One
+         * While ((Local0 == One))
+         * {
+         *    Local0 = Zero
+         *    If (Arg0 == irq0)
+         *    {
+         *        MethodEvent0()
+         *        Local0 = Zero
+         *    }
+         *    ElseIf (Arg0 == irq1)
+         *    {
+         *        MethodEvent1()
+         *        Local0 = Zero
+         *    }
+         *    ElseIf (Arg0 == irq2)
+         *    {
+         *        MethodEvent2()
+         *        Local0 = Zero
+         *    }
+         * }
+         */
+
+        /* While ((Local0 == One)) */
+        while_ctx = aml_while(aml_equal(has_irq, one));
+        {
+            else_ctx = NULL;
+
+            /*
+             * Clear loop condition, we don't want to enter an infinite loop.
+             * Local0 = Zero
+             */
+            aml_append(while_ctx, aml_store(zero, has_irq));
+            for (i = 0; i < events_size; i++) {
+                ged_aml = ged_event_aml(&events[i]);
+                if (!ged_aml) {
+                    continue;
+                }
+
+                /* _CRS interrupt */
+                aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                              AML_LEVEL,
+                                              AML_ACTIVE_HIGH,
+                                              AML_EXCLUSIVE,
+                                              &events[i].irq, 1));
+
+                /* If ((Arg0 == irq))*/
+                if_ctx = aml_if(aml_equal(irq, aml_int(events[i].irq)));
+                {
+                    /* AML for this specific type of event */
+                    aml_append(if_ctx, ged_aml);
+                }
+
+                /*
+                 * We append the first if to the while context.
+                 * Other ifs will be elseifs.
+                 */
+                if (!else_ctx) {
+                    aml_append(while_ctx, if_ctx);
+                } else {
+                    aml_append(else_ctx, if_ctx);
+                    aml_append(while_ctx, else_ctx);
+                }
+
+                if (i != events_size - 1) {
+                    else_ctx = aml_else();
+                }
+            }
+        }
+
+        aml_append(evt, while_ctx);
+    }
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0013")));
+    aml_append(dev, aml_name_decl("_UID", zero));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(dev, evt);
+
+    aml_append(table, dev);
+}
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 6a94452928..564443ff27 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -24,6 +24,7 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/acpi/reduced.h"
 #include "hw/hotplug.h"
 #include "hw/mem/nvdimm.h"
 
@@ -224,6 +225,9 @@ struct AcpiConfiguration {
     uint64_t *node_mem;
     bool apic_xrupt_override;
     unsigned apic_id_limit;
+    uint16_t cpu_hotplug_io_base;
+    GedEvent *ged_events;
+    uint8_t ged_events_size;
 
     /* Build state */
     AcpiBuildState *build_state;
diff --git a/include/hw/acpi/reduced.h b/include/hw/acpi/reduced.h
index 94a5aac9eb..b326af9bad 100644
--- a/include/hw/acpi/reduced.h
+++ b/include/hw/acpi/reduced.h
@@ -19,6 +19,22 @@
 #ifndef HW_ACPI_REDUCED_H
 #define HW_ACPI_REDUCED_H
 
+typedef struct Aml Aml;
+
+typedef enum {
+    GED_CPU_HOTPLUG    = 1,
+    GED_MEMORY_HOTPLUG = 2,
+    GED_PCI_HOTPLUG    = 3,
+    GED_NVDIMM_HOTPLUG = 4,
+} GedEventType;
+
+typedef struct GedEvent {
+    uint32_t     irq;
+    GedEventType event;
+} GedEvent;
+
 void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf);
+void build_ged_aml(Aml *table, const char* name,
+                   GedEvent *events, uint8_t events_size);
 
 #endif
-- 
2.17.2
