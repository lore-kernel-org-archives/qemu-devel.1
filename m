Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3cl-0003la-SM
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fl3ck-0001SG-JG
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:45:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fl3ck-0001RW-9p
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 22:45:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id h14-v6so511302wrw.13
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 19:45:58 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu,  2 Aug 2018 10:45:21 +0800
Message-Id: <1533177924-24765-4-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1533177924-24765-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1533177924-24765-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC v3 3/6] i386/acpi-build: describe new pci domain
 in AML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Describe new pci segments of host bridges in AML as new pci devices,
with _SEG and _BBN to let them be in DSDT

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/i386/acpi-build.c | 78 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 30bd0d5..4b6ef78 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1832,6 +1832,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
+
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
@@ -1875,6 +1876,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     crs_range_set_init(&crs_range_set);
     bus = PC_MACHINE(machine)->bus;
+    i = 1; // PCI0 is q35 host, pxb starts from 1
     if (bus) {
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
@@ -1890,10 +1892,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             }
 
             scope = aml_scope("\\_SB");
-            dev = aml_device("PC%.02X", bus_num);
+            dev = aml_device("PCI%d", i++);
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_express(bus)) {
                 aml_append(dev, build_q35_osc_method());
             }
@@ -2125,36 +2126,63 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host;
+        QObject *o;
         PCIBus *bus = NULL;
+        uint32_t domain_nr;
+        uint8_t bus_nr;
+        int index = 0;
 
         pci_host = acpi_get_i386_pci_host();
-        if (pci_host) {
+        while (pci_host) {
+            Object *obj = object_property_get_link(pci_host,
+                                               PROP_PXB_PCIE_DEV, NULL);
+            if (!obj) {
+                /* we are in q35 host */
+                obj = pci_host;
+            }
+            o = object_property_get_qobject(obj, PROP_PXB_PCIE_DOMAIN_NR, NULL);
+            assert(o);
+            domain_nr = qnum_get_uint(qobject_to(QNum, o));
+            qobject_unref(o);
+
+            o = object_property_get_qobject(pci_host, "bus_nr", NULL);
+            if (!o) {
+                /* we are in q35 host */
+                bus_nr = 0;
+            } else {
+                bus_nr = qnum_get_uint(qobject_to(QNum, o));
+                qobject_unref(o);
+            }
+
             bus = PCI_HOST_BRIDGE(pci_host)->bus;
-        }
+            if (bus) {
+                Aml *scope = aml_scope("PCI%d", index);
+                aml_append(scope, aml_name_decl("_SEG", aml_int(domain_nr)));
+                aml_append(scope, aml_name_decl("_BBN", aml_int(bus_nr)));
+                /* Scan all PCI buses. Generate tables to support hotplug. */
+                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
-        if (bus) {
-            Aml *scope = aml_scope("PCI0");
-            /* Scan all PCI buses. Generate tables to support hotplug. */
-            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+                /* Only add TPM once */
+                if (index++ == 0 && TPM_IS_TIS(tpm_find())) {
+                    dev = aml_device("ISA.TPM");
+                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+                    crs = aml_resource_template();
+                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
+                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
+                    /*
+                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
+                        Rewrite to take IRQ from TPM device model and
+                        fix default IRQ value there to use some unused IRQ
+                     */
+                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+                    aml_append(dev, aml_name_decl("_CRS", crs));
+                    aml_append(scope, dev);
+                }
 
-            if (TPM_IS_TIS(tpm_find())) {
-                dev = aml_device("ISA.TPM");
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
-                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
-                crs = aml_resource_template();
-                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
-                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
-                /*
-                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
-                    Rewrite to take IRQ from TPM device model and
-                    fix default IRQ value there to use some unused IRQ
-                 */
-                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
-                aml_append(dev, aml_name_decl("_CRS", crs));
-                aml_append(scope, dev);
+                aml_append(sb_scope, scope);
             }
-
-            aml_append(sb_scope, scope);
+            pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
         }
     }
 
-- 
2.7.4
