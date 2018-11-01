Received: from eggs.gnu.org ([2001:4830:134:3::10]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAX-0005jx-Po
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAW-0003xG-6x
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:61557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIAAV-0003NB-Sm
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:40 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:59 +0100
Message-Id: <20181101102303.16439-20-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 19/23] hw: acpi: Define ACPI tables builder
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

In order to decouple ACPI APIs from specific machine types, we are
creating an ACPI builder interface that each ACPI platform can choose to
implement.
This way, a new machine type can re-use the high level ACPI APIs and
define some custom table build methods, without having to duplicate most
of the existing implementation only to add small variations to it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/Makefile.objs     |   1 +
 hw/acpi/builder.c         |  97 ++++++++++++++++++++++++++++++++++++
 include/hw/acpi/builder.h | 100 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 hw/acpi/builder.c
 create mode 100644 include/hw/acpi/builder.h

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bcb44..2f383adc6f 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
 common-obj-y += aml-build.o
+common-obj-y += builder.o
 
 common-obj-$(CONFIG_IPMI) += ipmi.o
 common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
diff --git a/hw/acpi/builder.c b/hw/acpi/builder.c
new file mode 100644
index 0000000000..c29a614793
--- /dev/null
+++ b/hw/acpi/builder.c
@@ -0,0 +1,97 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "hw/acpi/builder.h"
+
+void acpi_builder_rsdp(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       unsigned rsdt_tbl_offset)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+
+    if (abm && abm->rsdp) {
+        abm->rsdp(table_data, linker, rsdt_tbl_offset);
+    }
+}
+
+void acpi_builder_madt(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       MachineState *ms, AcpiConfiguration *conf)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+
+    if (abm && abm->madt) {
+        abm->madt(table_data, linker, ms, conf);
+    }
+}
+
+void acpi_builder_mcfg(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       AcpiMcfgInfo *info)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+
+    if (abm && abm->mcfg) {
+        abm->mcfg(table_data, linker, info);
+    }
+}
+
+void acpi_builder_srat(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       MachineState *machine, AcpiConfiguration *conf)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+
+    if (abm && abm->srat) {
+        abm->srat(table_data, linker, machine, conf);
+    }
+}
+
+void acpi_builder_slit(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+
+    if (abm && abm->slit) {
+        abm->slit(table_data, linker);
+    }
+}
+
+AcpiConfiguration *acpi_builder_configuration(AcpiBuilder *builder)
+{
+    AcpiBuilderMethods *abm = ACPI_BUILDER_GET_METHODS(builder);
+    if (abm && abm->configuration) {
+        return abm->configuration(builder);
+    }
+    return NULL;
+}
+
+static const TypeInfo acpi_builder_info = {
+    .name          = TYPE_ACPI_BUILDER,
+    .parent        = TYPE_INTERFACE,
+    .class_size    = sizeof(AcpiBuilderMethods),
+};
+
+static void acpi_builder_register_type(void)
+{
+    type_register_static(&acpi_builder_info);
+}
+
+type_init(acpi_builder_register_type)
diff --git a/include/hw/acpi/builder.h b/include/hw/acpi/builder.h
new file mode 100644
index 0000000000..a63b88ffe9
--- /dev/null
+++ b/include/hw/acpi/builder.h
@@ -0,0 +1,100 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef ACPI_BUILDER_H
+#define ACPI_BUILDER_H
+
+#include "qemu/osdep.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "qom/object.h"
+
+#define TYPE_ACPI_BUILDER "acpi-builder"
+
+#define ACPI_BUILDER_METHODS(klass) \
+     OBJECT_CLASS_CHECK(AcpiBuilderMethods, (klass), TYPE_ACPI_BUILDER)
+#define ACPI_BUILDER_GET_METHODS(obj) \
+     OBJECT_GET_CLASS(AcpiBuilderMethods, (obj), TYPE_ACPI_BUILDER)
+#define ACPI_BUILDER(obj)                                       \
+     INTERFACE_CHECK(AcpiBuilder, (obj), TYPE_ACPI_BUILDER)
+
+typedef struct AcpiConfiguration AcpiConfiguration;
+typedef struct AcpiBuildState AcpiBuildState;
+typedef struct AcpiMcfgInfo AcpiMcfgInfo;
+
+typedef struct AcpiBuilder {
+    /* <private> */
+    Object Parent;
+} AcpiBuilder;
+
+/**
+ * AcpiBuildMethods:
+ *
+ * Interface to be implemented by a machine type that needs to provide
+ * custom ACPI tables build method.
+ *
+ * @parent: Opaque parent interface.
+ * @rsdp: ACPI RSDP (Root System Description Pointer) table build callback.
+ * @madt: ACPI MADT (Multiple APIC Description Table) table build callback.
+ * @mcfg: ACPI MCFG table build callback.
+ * @srat: ACPI SRAT (System/Static Resource Affinity Table)
+ *        table build callback.
+ * @slit: ACPI SLIT (System Locality System Information Table)
+ *        table build callback.
+ * @configuration: ACPI configuration getter.
+ *                 This is used to query the machine instance for its
+ *                 AcpiConfiguration pointer.
+ */
+typedef struct AcpiBuilderMethods {
+    /* <private> */
+    InterfaceClass parent;
+
+    /* <public> */
+    void (*rsdp)(GArray *table_data, BIOSLinker *linker,
+                 unsigned rsdt_tbl_offset);
+    void (*madt)(GArray *table_data, BIOSLinker *linker,
+                 MachineState *ms, AcpiConfiguration *conf);
+    void (*mcfg)(GArray *table_data, BIOSLinker *linker,
+                 AcpiMcfgInfo *info);
+    void (*srat)(GArray *table_data, BIOSLinker *linker,
+                 MachineState *machine, AcpiConfiguration *conf);
+    void (*slit)(GArray *table_data, BIOSLinker *linker);
+
+    AcpiConfiguration *(*configuration)(AcpiBuilder *builder);
+} AcpiBuilderMethods;
+
+void acpi_builder_rsdp(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       unsigned rsdt_tbl_offset);
+
+void acpi_builder_madt(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       MachineState *ms, AcpiConfiguration *conf);
+
+void acpi_builder_mcfg(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       AcpiMcfgInfo *info);
+
+void acpi_builder_srat(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker,
+                       MachineState *machine, AcpiConfiguration *conf);
+
+void acpi_builder_slit(AcpiBuilder *builder,
+                       GArray *table_data, BIOSLinker *linker);
+
+AcpiConfiguration *acpi_builder_configuration(AcpiBuilder *builder);
+
+#endif
-- 
2.19.1
