Received: from eggs.gnu.org ([2001:4830:134:3::10]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZd-0004Vs-29
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZY-0004kR-St
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:57 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:16701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=415137b24=anthony.perard@citrix.com>)
	id 1dpaZY-0004jg-Kp
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:40:52 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Wed, 6 Sep 2017 14:40:32 +0100
Message-ID: <20170906134033.13348-3-anthony.perard@citrix.com>
In-Reply-To: <20170906134033.13348-1-anthony.perard@citrix.com>
References: <20170906134033.13348-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/3] hw/acpi: Move acpi_set_pci_info to pcihp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

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

---
Changes in V4:
  - call acpi_set_pci_info only once
  - Add a stub of find_i440fx (for mips_softmmu target)

Changes in V3:
  - move acpi_set_pci_info to pcihp instead

Changes in V2:
  - check for acpi_enabled before calling acpi_set_pci_info.
  - set the property on the root bus only.
---
 hw/acpi/pcihp.c       | 38 ++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  | 32 --------------------------------
 stubs/Makefile.objs   |  1 +
 stubs/pci-host-piix.c |  6 ++++++
 4 files changed, 45 insertions(+), 32 deletions(-)
 create mode 100644 stubs/pci-host-piix.c

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9db3c2eaf2..7da51c0569 100644
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
index 98dd424678..4d19d91e1b 100644
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
 
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217aff..4a33495911 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,3 +40,4 @@ stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += pci-host-piix.o
diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
new file mode 100644
index 0000000000..6ed81b1f21
--- /dev/null
+++ b/stubs/pci-host-piix.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "hw/i386/pc.h"
+PCIBus *find_i440fx(void)
+{
+    return NULL;
+}
-- 
Anthony PERARD
