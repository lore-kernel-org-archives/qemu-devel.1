Received: from eggs.gnu.org ([2001:4830:134:3::10]:39436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6N-0000sj-4x
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6H-0004nG-0w
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:7878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6G-0004Je-KM
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:48 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:46 +0200
Message-Id: <20181022183656.4902-17-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 16/26] hw: fw-build: Add firmware build methods
 and state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

In order to decouple ACPI APIs from specific machine types, we are
adding granular firmware build methods to the generic MachineClass
structure. This way, a new machine type can re-use the high level ACPI
APIs and define some custom table build methods, without having to
duplicate most of the existing implementation only to add small
variations to it.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/boards.h   |  5 ++++
 include/hw/fw-build.h | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 include/hw/fw-build.h

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..a5c8fe6ed2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -5,6 +5,7 @@
 
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
+#include "hw/fw-build.h"
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
@@ -214,6 +215,8 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+
+    FirmwareBuildMethods firmware_build_methods;
 };
 
 /**
@@ -269,6 +272,8 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
+
+    FirmwareBuildState firmware_build_state;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/hw/fw-build.h b/include/hw/fw-build.h
new file mode 100644
index 0000000000..c02434d513
--- /dev/null
+++ b/include/hw/fw-build.h
@@ -0,0 +1,57 @@
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
+#ifndef FW_BUILD_H
+#define FW_BUILD_H
+
+#include "hw/acpi/bios-linker-loader.h"
+
+typedef struct AcpiConfiguration AcpiConfiguration;
+typedef struct AcpiBuildState AcpiBuildState;
+typedef struct AcpiMcfgInfo AcpiMcfgInfo;
+
+typedef struct FirmwareBuildMethods {
+    union {
+        /* ACPI methods */
+        struct {
+            GArray *(*rsdp)(GArray *table_data, BIOSLinker *linker,
+                            unsigned rsdt_tbl_offset);
+            GArray *(*madt)(GArray *table_data, BIOSLinker *linker,
+                            MachineState *ms, AcpiConfiguration *conf);
+            void    (*mcfg)(GArray *table_data, BIOSLinker *linker,
+                            AcpiMcfgInfo *info);
+            void    (*srat)(GArray *table_data, BIOSLinker *linker,
+                            MachineState *machine, AcpiConfiguration *conf);
+            void    (*slit)(GArray *table_data, BIOSLinker *linker);
+
+            /* Overall ACPI table setup function */
+            void    (*setup)(MachineState *ms, AcpiConfiguration *conf);
+        } acpi;
+    };
+} FirmwareBuildMethods;
+
+typedef struct FirmwareBuildState {
+    union {
+        /* ACPI state and configuration */
+        struct {
+            AcpiConfiguration *conf;
+            AcpiBuildState *state;
+        } acpi;
+    };
+} FirmwareBuildState;
+
+#endif
-- 
2.17.2
