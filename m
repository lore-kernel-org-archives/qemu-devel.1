Received: from eggs.gnu.org ([2001:4830:134:3::10]:40689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaZ-0005lM-Ko
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaW-0003Ey-Td
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:07 -0400
Received: from smtp.citrix.com ([66.165.176.89]:18727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3958fb005=anthony.perard@citrix.com>)
	id 1diNaW-0003Ee-KY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:24:04 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 17 Aug 2017 17:23:46 +0100
Message-ID: <20170817162347.1590-3-anthony.perard@citrix.com>
In-Reply-To: <20170817162347.1590-1-anthony.perard@citrix.com>
References: <20170817162347.1590-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 v3 2/3] hw/acpi: Move
 acpi_set_pci_info to pcihp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Bruce Rogers <brogers@suse.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This means that the function will be call and the property
acpi-pcihp-bsel will be set even if ACPI build is disable.

To do PCI passthrough with Xen, the property acpi-pcihp-bsel needs to be
set, but this was done only when ACPI tables are built which is not
needed for a Xen guest. The need for the property starts with commit
"pc: pcihp: avoid adding ACPI_PCIHP_PROP_BSEL twice"
(f0c9d64a68b776374ec4732424a3e27753ce37b6).

Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

---
Changes in V3:
  - move acpi_set_pci_info to pcihp instead

Changes in V2:
  - check for acpi_enabled before calling acpi_set_pci_info.
  - set the property on the root bus only.

This patch would be a canditade to backport to 2.9, along with
"hw/acpi: Limit hotplug to root bus on legacy mode"

CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Bruce Rogers <brogers@suse.com>
---
 hw/acpi/pcihp.c      | 31 +++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c | 32 --------------------------------
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 9db3c2eaf2..44e8842db8 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -75,6 +75,36 @@ static int acpi_pcihp_get_bsel(PCIBus *bus)
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
+    PCIBus *bus = find_i440fx(); /* TODO: Q35 support */
+    unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
+
+    if (bus) {
+        /* Scan all PCI buses. Set property to enable acpi based hotplug. */
+        pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
+    }
+}
+
 static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
 {
     AcpiPciHpFind *find = opaque;
@@ -177,6 +207,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
 
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
 
-- 
Anthony PERARD
