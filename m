Received: from eggs.gnu.org ([2001:4830:134:3::10]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB4-0008Rm-Mg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB3-0005z0-Kd
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:58 -0500
Received: from mail.kernel.org ([198.145.29.136]:48602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB3-0005yo-AM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:57 -0500
Date: Tue, 10 Jan 2017 07:40:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-37-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 36/41] memhp: merge build_memory_devices() into
 build_memory_hotplug_aml()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

It consolidates memory hotplug AML in one place within DSDT

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/memory_hotplug.h |  2 --
 hw/acpi/memory_hotplug.c         | 14 ++++-----
 hw/i386/acpi-build.c             | 61 ++++++++++++++++++----------------------
 3 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index c70481e..6dc48d2 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -54,6 +54,4 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               uint16_t io_base, uint16_t io_len);
-void build_memory_devices(Aml *sb_scope, int nr_mem,
-                          uint16_t io_base, uint16_t io_len);
 #endif
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index fb40a5e..18b95f2 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -310,9 +310,11 @@ const VMStateDescription vmstate_memory_hotplug = {
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               uint16_t io_base, uint16_t io_len)
 {
+    int i;
     Aml *ifctx;
     Aml *method;
     Aml *pci_scope;
+    Aml *sb_scope;
     Aml *mem_ctrl_dev;
 
     /* scope for memory hotplug controller device node */
@@ -610,19 +612,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     }
     aml_append(pci_scope, mem_ctrl_dev);
     aml_append(table, pci_scope);
-}
-
-void build_memory_devices(Aml *sb_scope, int nr_mem,
-                          uint16_t io_base, uint16_t io_len)
-{
-    int i;
-    Aml *dev;
-    Aml *method;
-    Aml *ifctx;
 
+    sb_scope = aml_scope("_SB");
     /* build memory devices */
     for (i = 0; i < nr_mem; i++) {
         #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
+        Aml *dev;
         const char *s;
 
         dev = aml_device("MP%02X", i);
@@ -673,4 +668,5 @@ void build_memory_devices(Aml *sb_scope, int nr_mem,
         aml_append(method, ifctx);
     }
     aml_append(sb_scope, method);
+    aml_append(table, sb_scope);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a3f9caa..ca4165e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2197,45 +2197,40 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     sb_scope = aml_scope("\\_SB");
     {
-        build_memory_devices(sb_scope, nr_mem, pm->mem_hp_io_base,
-                             pm->mem_hp_io_len);
+        Object *pci_host;
+        PCIBus *bus = NULL;
 
-        {
-            Object *pci_host;
-            PCIBus *bus = NULL;
+        pci_host = acpi_get_i386_pci_host();
+        if (pci_host) {
+            bus = PCI_HOST_BRIDGE(pci_host)->bus;
+        }
 
-            pci_host = acpi_get_i386_pci_host();
-            if (pci_host) {
-                bus = PCI_HOST_BRIDGE(pci_host)->bus;
+        if (bus) {
+            Aml *scope = aml_scope("PCI0");
+            /* Scan all PCI buses. Generate tables to support hotplug. */
+            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
+
+            if (misc->tpm_version != TPM_VERSION_UNSPEC) {
+                dev = aml_device("ISA.TPM");
+                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+                crs = aml_resource_template();
+                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
+                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
+                /*
+                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
+                    Rewrite to take IRQ from TPM device model and
+                    fix default IRQ value there to use some unused IRQ
+                 */
+                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+                aml_append(dev, aml_name_decl("_CRS", crs));
+                aml_append(scope, dev);
             }
 
-            if (bus) {
-                Aml *scope = aml_scope("PCI0");
-                /* Scan all PCI buses. Generate tables to support hotplug. */
-                build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
-
-                if (misc->tpm_version != TPM_VERSION_UNSPEC) {
-                    dev = aml_device("ISA.TPM");
-                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
-                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
-                    crs = aml_resource_template();
-                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
-                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
-                    /*
-                        FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
-                        Rewrite to take IRQ from TPM device model and
-                        fix default IRQ value there to use some unused IRQ
-                     */
-                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
-                    aml_append(dev, aml_name_decl("_CRS", crs));
-                    aml_append(scope, dev);
-                }
-
-                aml_append(sb_scope, scope);
-            }
+            aml_append(sb_scope, scope);
         }
-        aml_append(dsdt, sb_scope);
     }
+    aml_append(dsdt, sb_scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
-- 
MST
