Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAxA-0002CL-CH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAx6-0004lO-N8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:16085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHAx6-0004bl-Ax
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:44 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 18:01:51 +0100
Message-Id: <20181029170159.3801-12-sameo@linux.intel.com>
In-Reply-To: <20181029170159.3801-1-sameo@linux.intel.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 11/19] hw: acpi: Do not create hotplug
 method when handler is not defined
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

CPU and memory ACPI hotplug are not necessarily handled through SCI
events. For example, with Hardware-reduced ACPI, the GED device will
manage ACPI hotplug entirely.
As a consequence, we make the CPU and memory specific events AML
generation optional. The code will only be added when the method name is
not NULL.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/acpi/cpu.c            |  8 +++++---
 hw/acpi/memory_hotplug.c | 11 +++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f10b190019..cd41377b5a 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -569,9 +569,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     aml_append(sb_scope, cpus_dev);
     aml_append(table, sb_scope);
 
-    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
-    aml_append(table, method);
+    if (event_handler_method) {
+        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
+        aml_append(table, method);
+    }
 
     g_free(cphp_res_path);
 }
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8c7c1013f3..db2c4df961 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -715,10 +715,13 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     }
     aml_append(table, dev_container);
 
-    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
-    aml_append(method,
-        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
-    aml_append(table, method);
+    if (event_handler_method) {
+        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
+        aml_append(method,
+                   aml_call0(MEMORY_DEVICES_CONTAINER "."
+                             MEMORY_SLOT_SCAN_METHOD));
+        aml_append(table, method);
+    }
 
     g_free(mhp_res_path);
 }
-- 
2.17.2
