Received: from eggs.gnu.org ([2001:4830:134:3::10]:39699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf73-0001ZS-IV
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6y-0005at-C4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:7878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6u-0004Je-JS
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:30 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:52 +0200
Message-Id: <20181022183656.4902-23-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 22/26] hw: acpi: reduced: Add shutdown support
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

Hardware-reduced ACPI uses SLEEP_CONTROL_REG to enter S5 sleep state.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/acpi/aml-build.c         |  2 +-
 hw/acpi/reduced.c           | 15 +++++++++++++++
 include/hw/acpi/acpi-defs.h |  1 +
 include/hw/acpi/reduced.h   |  4 ++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f462bb8313..752642a67a 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2922,7 +2922,7 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
     }
 
     /* SLEEP_CONTROL_REG */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->sleep_control_reg);
     /* SLEEP_STATUS_REG */
     build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
 
diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
index 33d413a255..329d5112ca 100644
--- a/hw/acpi/reduced.c
+++ b/hw/acpi/reduced.c
@@ -80,6 +80,17 @@ static void acpi_dsdt_add_ged(Aml *scope, AcpiConfiguration *conf)
                   conf->ged_events, conf->ged_events_size);
 }
 
+static void acpi_dsdt_add_sleep_state(Aml *scope)
+{
+    Aml *pkg = aml_package(4);
+
+    aml_append(pkg, aml_int(ACPI_REDUCED_SLEEP_LEVEL));
+    aml_append(pkg, aml_int(0));
+    aml_append(pkg, aml_int(0));
+    aml_append(pkg, aml_int(0));
+    aml_append(scope, aml_name_decl("_S5", pkg));
+}
+
 /* DSDT */
 static void build_dsdt(MachineState *ms,
                        GArray *table_data, BIOSLinker *linker,
@@ -98,6 +109,7 @@ static void build_dsdt(MachineState *ms,
     acpi_dsdt_add_memory_hotplug(ms, dsdt);
     acpi_dsdt_add_cpus(ms, dsdt, scope, smp_cpus, conf);
     acpi_dsdt_add_ged(dsdt, conf);
+    acpi_dsdt_add_sleep_state(scope);
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
@@ -120,6 +132,9 @@ static void build_fadt_reduced(GArray *table_data, BIOSLinker *linker,
         .dsdt_tbl_offset = &dsdt_tbl_offset,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
         .arm_boot_arch = 0,
+        .sleep_control_reg = { .space_id = AML_AS_SYSTEM_IO,
+                              .bit_width = 8, .bit_offset = 0,
+                              .address = ACPI_REDUCED_SLEEP_CONTROL_IOPORT },
     };
 
     build_fadt(table_data, linker, &fadt, NULL, NULL);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 6e1726e0a2..10b7bf9c98 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -112,6 +112,7 @@ typedef struct AcpiFadtData {
     unsigned *facs_tbl_offset; /* FACS offset in */
     unsigned *dsdt_tbl_offset;
     unsigned *xdsdt_tbl_offset;
+    struct AcpiGenericAddress sleep_control_reg;  /* SLEEP_CONTROL_REG */
 } AcpiFadtData;
 
 #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
diff --git a/include/hw/acpi/reduced.h b/include/hw/acpi/reduced.h
index b326af9bad..3d3c003353 100644
--- a/include/hw/acpi/reduced.h
+++ b/include/hw/acpi/reduced.h
@@ -19,6 +19,10 @@
 #ifndef HW_ACPI_REDUCED_H
 #define HW_ACPI_REDUCED_H
 
+#define ACPI_REDUCED_SLEEP_LEVEL          5
+#define ACPI_REDUCED_SLEEP_ENABLE         (1 << 5) /* SLP_EN */
+#define ACPI_REDUCED_SLEEP_CONTROL_IOPORT 0x3B0
+
 typedef struct Aml Aml;
 
 typedef enum {
-- 
2.17.2
