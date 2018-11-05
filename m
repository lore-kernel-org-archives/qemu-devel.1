Received: from eggs.gnu.org ([2001:4830:134:3::10]:47620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTvp-000147-Iy
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJTvj-000415-Dr
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 20:43:55 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon,  5 Nov 2018 02:40:47 +0100
Message-Id: <20181105014047.26447-25-sameo@linux.intel.com>
In-Reply-To: <20181105014047.26447-1-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 24/24] hw: i386: Refactor PCI host getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Yang Zhong <yang.zhong@intel.com>

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
index 6112cc2149..b532817fb5 100644
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
