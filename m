Received: from eggs.gnu.org ([2001:4830:134:3::10]:59595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9q-00052T-Fy
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9o-0003Io-Gq
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:61548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA9o-0003Hf-4k
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:56 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:56 +0100
Message-Id: <20181101102303.16439-17-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/23] hw: acpi: Export the PCI hotplug API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>, Jing Liu <jing2.liu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

The ACPI hotplug support for PCI devices APIs are not x86 or even
machine type specific. In order for future machine types to be able to
re-use that code, we export it through the architecture agnostic
hw/acpi folder.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/acpi/aml-build.c         | 194 ++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 192 +----------------------------------
 include/hw/acpi/aml-build.h |   3 +
 3 files changed, 199 insertions(+), 190 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index c5211928da..33db1c1bc8 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -34,6 +34,7 @@
 #include "hw/acpi/tpm.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qnum.h"
+#include "hw/acpi/pcihp.h"
 
 #define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8
 #define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000
@@ -2305,6 +2306,199 @@ Aml *build_pci_host_bridge(Aml *table, AcpiPciBus *pci_host)
     return scope;
 }
 
+void build_acpi_pci_hotplug(Aml *scope)
+{
+    Aml *field;
+    Aml *method;
+
+    aml_append(scope,
+        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
+    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("PCIU", 32));
+    aml_append(field, aml_named_field("PCID", 32));
+    aml_append(scope, field);
+
+    aml_append(scope,
+        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
+    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("B0EJ", 32));
+    aml_append(scope, field);
+
+    aml_append(scope,
+        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
+    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("BNUM", 32));
+    aml_append(scope, field);
+
+    aml_append(scope, aml_mutex("BLCK", 0));
+
+    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
+    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
+    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
+    aml_append(method,
+        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
+    aml_append(method, aml_release(aml_name("BLCK")));
+    aml_append(method, aml_return(aml_int(0)));
+    aml_append(scope, method);
+}
+
+static void build_append_pcihp_notify_entry(Aml *method, int slot)
+{
+    Aml *if_ctx;
+    int32_t devfn = PCI_DEVFN(slot, 0);
+
+    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
+    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
+    aml_append(method, if_ctx);
+}
+
+void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
+                                  bool pcihp_bridge_en)
+{
+    Aml *dev, *notify_method = NULL, *method;
+    QObject *bsel;
+    PCIBus *sec;
+    int i;
+
+    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
+    if (bsel) {
+        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
+        notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(bus->devices); i += PCI_FUNC_MAX) {
+        DeviceClass *dc;
+        PCIDeviceClass *pc;
+        PCIDevice *pdev = bus->devices[i];
+        int slot = PCI_SLOT(i);
+        bool hotplug_enabled_dev;
+        bool bridge_in_acpi;
+
+        if (!pdev) {
+            if (bsel) { /* add hotplug slots for non present devices */
+                dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
+                aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
+                aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
+                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+                aml_append(method,
+                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
+                );
+                aml_append(dev, method);
+                aml_append(parent_scope, dev);
+
+                build_append_pcihp_notify_entry(notify_method, slot);
+            }
+            continue;
+        }
+
+        pc = PCI_DEVICE_GET_CLASS(pdev);
+        dc = DEVICE_GET_CLASS(pdev);
+
+        /* When hotplug for bridges is enabled, bridges are
+         * described in ACPI separately (see build_pci_bus_end).
+         * In this case they aren't themselves hot-pluggable.
+         * Hotplugged bridges *are* hot-pluggable.
+         */
+        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
+            !DEVICE(pdev)->hotplugged;
+
+        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
+
+        if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
+            continue;
+        }
+
+        /* start to compose PCI slot descriptor */
+        dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
+        aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
+
+        if (pc->class_id == PCI_CLASS_DISPLAY_VGA) {
+            /* add VGA specific AML methods */
+            int s3d;
+
+            if (object_dynamic_cast(OBJECT(pdev), "qxl-vga")) {
+                s3d = 3;
+            } else {
+                s3d = 0;
+            }
+
+            method = aml_method("_S1D", 0, AML_NOTSERIALIZED);
+            aml_append(method, aml_return(aml_int(0)));
+            aml_append(dev, method);
+
+            method = aml_method("_S2D", 0, AML_NOTSERIALIZED);
+            aml_append(method, aml_return(aml_int(0)));
+            aml_append(dev, method);
+
+            method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
+            aml_append(method, aml_return(aml_int(s3d)));
+            aml_append(dev, method);
+        } else if (hotplug_enabled_dev) {
+            /* add _SUN/_EJ0 to make slot hotpluggable  */
+            aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
+
+            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+            aml_append(method,
+                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
+            );
+            aml_append(dev, method);
+
+            if (bsel) {
+                build_append_pcihp_notify_entry(notify_method, slot);
+            }
+        } else if (bridge_in_acpi) {
+            /*
+             * device is coldplugged bridge,
+             * add child device descriptions into its scope
+             */
+            PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+
+            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
+        }
+        /* slot descriptor has been composed, add it into parent context */
+        aml_append(parent_scope, dev);
+    }
+
+    if (bsel) {
+        aml_append(parent_scope, notify_method);
+    }
+
+    /* Append PCNT method to notify about events on local and child buses.
+     * Add unconditionally for root since DSDT expects it.
+     */
+    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
+
+    /* If bus supports hotplug select it and notify about local events */
+    if (bsel) {
+        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+        aml_append(method,
+            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
+        );
+        aml_append(method,
+            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
+        );
+    }
+
+    /* Notify about child bus events in any case */
+    if (pcihp_bridge_en) {
+        QLIST_FOREACH(sec, &bus->child, sibling) {
+            int32_t devfn = sec->parent_dev->devfn;
+
+            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
+                continue;
+            }
+
+            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
+        }
+    }
+    aml_append(parent_scope, method);
+    qobject_unref(bsel);
+}
+
 void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host)
 {
     Aml *dev, *pci_scope;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 673c5dfafc..6c9b61cea2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -360,163 +360,6 @@ build_madt(GArray *table_data, BIOSLinker *linker,
                  table_data->len - madt_start, 1, NULL, NULL);
 }
 
-static void build_append_pcihp_notify_entry(Aml *method, int slot)
-{
-    Aml *if_ctx;
-    int32_t devfn = PCI_DEVFN(slot, 0);
-
-    if_ctx = aml_if(aml_and(aml_arg(0), aml_int(0x1U << slot), NULL));
-    aml_append(if_ctx, aml_notify(aml_name("S%.02X", devfn), aml_arg(1)));
-    aml_append(method, if_ctx);
-}
-
-static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
-                                         bool pcihp_bridge_en)
-{
-    Aml *dev, *notify_method = NULL, *method;
-    QObject *bsel;
-    PCIBus *sec;
-    int i;
-
-    bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
-    if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
-        notify_method = aml_method("DVNT", 2, AML_NOTSERIALIZED);
-    }
-
-    for (i = 0; i < ARRAY_SIZE(bus->devices); i += PCI_FUNC_MAX) {
-        DeviceClass *dc;
-        PCIDeviceClass *pc;
-        PCIDevice *pdev = bus->devices[i];
-        int slot = PCI_SLOT(i);
-        bool hotplug_enabled_dev;
-        bool bridge_in_acpi;
-
-        if (!pdev) {
-            if (bsel) { /* add hotplug slots for non present devices */
-                dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
-                aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
-                aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
-                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-                aml_append(method,
-                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
-                );
-                aml_append(dev, method);
-                aml_append(parent_scope, dev);
-
-                build_append_pcihp_notify_entry(notify_method, slot);
-            }
-            continue;
-        }
-
-        pc = PCI_DEVICE_GET_CLASS(pdev);
-        dc = DEVICE_GET_CLASS(pdev);
-
-        /* When hotplug for bridges is enabled, bridges are
-         * described in ACPI separately (see build_pci_bus_end).
-         * In this case they aren't themselves hot-pluggable.
-         * Hotplugged bridges *are* hot-pluggable.
-         */
-        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
-            !DEVICE(pdev)->hotplugged;
-
-        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
-
-        if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
-            continue;
-        }
-
-        /* start to compose PCI slot descriptor */
-        dev = aml_device("S%.02X", PCI_DEVFN(slot, 0));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
-
-        if (pc->class_id == PCI_CLASS_DISPLAY_VGA) {
-            /* add VGA specific AML methods */
-            int s3d;
-
-            if (object_dynamic_cast(OBJECT(pdev), "qxl-vga")) {
-                s3d = 3;
-            } else {
-                s3d = 0;
-            }
-
-            method = aml_method("_S1D", 0, AML_NOTSERIALIZED);
-            aml_append(method, aml_return(aml_int(0)));
-            aml_append(dev, method);
-
-            method = aml_method("_S2D", 0, AML_NOTSERIALIZED);
-            aml_append(method, aml_return(aml_int(0)));
-            aml_append(dev, method);
-
-            method = aml_method("_S3D", 0, AML_NOTSERIALIZED);
-            aml_append(method, aml_return(aml_int(s3d)));
-            aml_append(dev, method);
-        } else if (hotplug_enabled_dev) {
-            /* add _SUN/_EJ0 to make slot hotpluggable  */
-            aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
-
-            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-            aml_append(method,
-                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
-            );
-            aml_append(dev, method);
-
-            if (bsel) {
-                build_append_pcihp_notify_entry(notify_method, slot);
-            }
-        } else if (bridge_in_acpi) {
-            /*
-             * device is coldplugged bridge,
-             * add child device descriptions into its scope
-             */
-            PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
-
-            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
-        }
-        /* slot descriptor has been composed, add it into parent context */
-        aml_append(parent_scope, dev);
-    }
-
-    if (bsel) {
-        aml_append(parent_scope, notify_method);
-    }
-
-    /* Append PCNT method to notify about events on local and child buses.
-     * Add unconditionally for root since DSDT expects it.
-     */
-    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
-
-    /* If bus supports hotplug select it and notify about local events */
-    if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
-        );
-        aml_append(method,
-            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
-        );
-    }
-
-    /* Notify about child bus events in any case */
-    if (pcihp_bridge_en) {
-        QLIST_FOREACH(sec, &bus->child, sibling) {
-            int32_t devfn = sec->parent_dev->devfn;
-
-            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
-                continue;
-            }
-
-            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
-        }
-    }
-    aml_append(parent_scope, method);
-    qobject_unref(bsel);
-}
-
 static void build_hpet_aml(Aml *table)
 {
     Aml *crs;
@@ -1212,41 +1055,10 @@ static void build_piix4_isa_bridge(Aml *table)
 static void build_piix4_pci_hotplug(Aml *table)
 {
     Aml *scope;
-    Aml *field;
-    Aml *method;
-
-    scope =  aml_scope("_SB.PCI0");
-
-    aml_append(scope,
-        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
-    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("PCIU", 32));
-    aml_append(field, aml_named_field("PCID", 32));
-    aml_append(scope, field);
 
-    aml_append(scope,
-        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
-    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("B0EJ", 32));
-    aml_append(scope, field);
-
-    aml_append(scope,
-        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
-    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("BNUM", 32));
-    aml_append(scope, field);
-
-    aml_append(scope, aml_mutex("BLCK", 0));
-
-    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
-    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
-    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
-    aml_append(method,
-        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
-    aml_append(method, aml_release(aml_name("BLCK")));
-    aml_append(method, aml_return(aml_int(0)));
-    aml_append(scope, method);
+    scope = aml_scope("_SB.PCI0");
 
+    build_acpi_pci_hotplug(scope);
     aml_append(table, scope);
 }
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 64ea371656..2da233a526 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -418,6 +418,9 @@ Aml *build_osc_method(uint32_t value);
 void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info);
 Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi);
 Aml *build_prt(bool is_pci0_prt);
+void build_acpi_pci_hotplug(Aml *scope);
+void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
+                                  bool pcihp_bridge_en);
 void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host);
 Aml *build_pci_host_bridge(Aml *table, AcpiPciBus *pci_host);
 void crs_range_set_init(CrsRangeSet *range_set);
-- 
2.19.1
