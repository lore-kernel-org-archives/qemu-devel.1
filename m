Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAl-0005zn-P1
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIAAg-0004Or-Uf
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:61548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIAAg-0003Hf-KW
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:50 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:23:03 +0100
Message-Id: <20181101102303.16439-24-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 23/23] hw: i386: Refactor PCI host getter
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

Now that the ACPI builder methods are added, we can reach the ACPI
configuration pointer from the MachineState pointer. From there we can
get to the PCI host pointer and return it.

This makes the PCI host getter an ACPI, architecture agnostic function.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/aml-build.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 33db1c1bc8..e8b087fcf5 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -22,6 +22,8 @@
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/builder.h"
+#include "hw/mem/memory-device.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
@@ -1617,23 +1619,15 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
-/*
- * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
- */
 Object *acpi_get_pci_host(void)
 {
-    PCIHostState *host;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    AcpiBuilder *ab = ACPI_BUILDER(ms);
+    AcpiConfiguration *acpi_conf;
 
-    host = OBJECT_CHECK(PCIHostState,
-                        object_resolve_path("/machine/i440fx", NULL),
-                        TYPE_PCI_HOST_BRIDGE);
-    if (!host) {
-        host = OBJECT_CHECK(PCIHostState,
-                            object_resolve_path("/machine/q35", NULL),
-                            TYPE_PCI_HOST_BRIDGE);
-    }
+    acpi_conf = acpi_builder_configuration(ab);
 
-    return OBJECT(host);
+    return OBJECT(acpi_conf->pci_host);
 }
 
 
-- 
2.19.1
