Received: from eggs.gnu.org ([2001:4830:134:3::10]:48992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7l-0006YZ-V8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7k-0004sK-Js
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7k-0004rT-9T
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:12 -0400
Date: Fri, 8 Sep 2017 17:19:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-5-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] hw/acpi: Move acpi_set_pci_info to pcihp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>, Sander Eikelenboom <linux@eikelenboom.it>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Anthony PERARD <anthony.perard@citrix.com>

HW part of ACPI PCI hotplug in QEMU depends on ACPI_PCIHP_PROP_BSEL
being set on a PCI bus that supports ACPI hotplug. It should work
regardless of the source of ACPI tables (QEMU generator/legacy SeaBIOS/Xen).
So move ACPI_PCIHP_PROP_BSEL initialization into HW ACPI implementation
part from QEMU's ACPI table generator.

To do PCI passthrough with Xen, the property ACPI_PCIHP_PROP_BSEL needs
to be set, but this was done only when ACPI tables are built which is
not needed for a Xen guest. The need for the property starts with commit
"pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
(f0c9d64a68b776374ec4732424a3e27753ce37b6).

Adding find_i440fx into stubs so that mips-softmmu target can be built.

Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c       | 38 ++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  | 32 --------------------------------
 stubs/pci-host-piix.c |  6 ++++++
 stubs/Makefile.objs   |  1 +
 4 files changed, 45 insertions(+), 32 deletions(-)
 create mode 100644 stubs/pci-host-piix.c

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9db3c2e..7da51c0 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -75,6 +75,43 @@ static int acpi_pcihp_get_bsel(PCIBus *bus)
     }
 }
 
+/* Assign BSEL property to all buses.  In the future, this can be changed
+ * to only assign to buses that support hotplug.
+ */
+static void *acpi_set_bsel(PCIBus *bus, void *opaque)
+{
+    unsigned *bsel_alloc = opaque;
+    unsigned *bus_bsel;
+
+    if (qbus_is_hotpluggable(BUS(bus))) {
+        bus_bsel = g_malloc(sizeof *bus_bsel);
+
+        *bus_bsel = (*bsel_alloc)++;
+        object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                       bus_bsel, &error_abort);
+    }
+
+    return bsel_alloc;
+}
+
+static void acpi_set_pci_info(void)
+{
+    static bool bsel_is_set;
+    PCIBus *bus;
+    unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
+
+    if (bsel_is_set) {
+        return;
+    }
+    bsel_is_set = true;
+
+    bus = find_i440fx(); /* TODO: Q35 support */
+    if (bus) {
+        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
+        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
+    }
+}
+
 static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
 {
     AcpiPciHpFind *find = opaque;
@@ -177,6 +214,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
 
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
+    acpi_set_pci_info();
     acpi_pcihp_update(s);
 }
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 98dd424..4d19d91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -493,36 +493,6 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
                  table_data->len - madt_start, 1, NULL, NULL);
 }
 
-/* Assign BSEL property to all buses.  In the future, this can be changed
- * to only assign to buses that support hotplug.
- */
-static void *acpi_set_bsel(PCIBus *bus, void *opaque)
-{
-    unsigned *bsel_alloc = opaque;
-    unsigned *bus_bsel;
-
-    if (qbus_is_hotpluggable(BUS(bus))) {
-        bus_bsel = g_malloc(sizeof *bus_bsel);
-
-        *bus_bsel = (*bsel_alloc)++;
-        object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                       bus_bsel, &error_abort);
-    }
-
-    return bsel_alloc;
-}
-
-static void acpi_set_pci_info(void)
-{
-    PCIBus *bus = find_i440fx(); /* TODO: Q35 support */
-    unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
-
-    if (bus) {
-        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
-        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
-    }
-}
-
 static void build_append_pcihp_notify_entry(Aml *method, int slot)
 {
     Aml *if_ctx;
@@ -2888,8 +2858,6 @@ void acpi_setup(void)
 
     build_state = g_malloc0(sizeof *build_state);
 
-    acpi_set_pci_info();
-
     acpi_build_tables_init(&tables);
     acpi_build(&tables, MACHINE(pcms));
 
diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
new file mode 100644
index 0000000..6ed81b1
--- /dev/null
+++ b/stubs/pci-host-piix.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/i386/pc.h"
+PCIBus *find_i440fx(void)
+{
+    return NULL;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217..4a33495 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,3 +40,4 @@ stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += pci-host-piix.o
-- 
MST
