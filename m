Received: from eggs.gnu.org ([2001:4830:134:3::10]:33997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpBA-00005P-Hz
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB6-0005zN-HJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:04 -0500
Received: from mail.kernel.org ([198.145.29.136]:48630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpB6-0005zI-7V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:41:00 -0500
Date: Tue, 10 Jan 2017 07:40:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-38-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 37/41] memhp: move GPE handler_E03 into
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

>From this patch all the memory hotplug related AML
bits are consolidated in one place within DSTD.
Follow up patches will utilize that to simplify
memory hotplug related C/AML code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 include/hw/acpi/memory_hotplug.h |  6 +++---
 hw/acpi/memory_hotplug.c         | 42 ++++++++++++++++++++++++++--------------
 hw/i386/acpi-build.c             |  7 ++-----
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 6dc48d2..37e2706 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -49,9 +49,9 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
 
 #define MEMORY_HOTPLUG_DEVICE        "MHPD"
 #define MEMORY_SLOT_SCAN_METHOD      "MSCN"
-#define MEMORY_HOTPLUG_HANDLER_PATH "\\_SB.PCI0." \
-     MEMORY_HOTPLUG_DEVICE "." MEMORY_SLOT_SCAN_METHOD
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
-                              uint16_t io_base, uint16_t io_len);
+                              uint16_t io_base, uint16_t io_len,
+                              const char *res_root,
+                              const char *event_handler_method);
 #endif
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 18b95f2..49e856f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -308,18 +308,19 @@ const VMStateDescription vmstate_memory_hotplug = {
 };
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
-                              uint16_t io_base, uint16_t io_len)
+                              uint16_t io_base, uint16_t io_len,
+                              const char *res_root,
+                              const char *event_handler_method)
 {
     int i;
     Aml *ifctx;
     Aml *method;
-    Aml *pci_scope;
     Aml *sb_scope;
     Aml *mem_ctrl_dev;
+    char *scan_path;
+    char *mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
 
-    /* scope for memory hotplug controller device node */
-    pci_scope = aml_scope("_SB.PCI0");
-    mem_ctrl_dev = aml_device(MEMORY_HOTPLUG_DEVICE);
+    mem_ctrl_dev = aml_device("%s", mhp_res_path);
     {
         Aml *crs;
         Aml *field;
@@ -610,47 +611,50 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
         }
         aml_append(mem_ctrl_dev, method);
     }
-    aml_append(pci_scope, mem_ctrl_dev);
-    aml_append(table, pci_scope);
+    aml_append(table, mem_ctrl_dev);
 
     sb_scope = aml_scope("_SB");
     /* build memory devices */
     for (i = 0; i < nr_mem; i++) {
-        #define BASEPATH "\\_SB.PCI0." MEMORY_HOTPLUG_DEVICE "."
         Aml *dev;
-        const char *s;
+        char *s;
 
         dev = aml_device("MP%02X", i);
         aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
 
         method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
-        s = BASEPATH MEMORY_SLOT_CRS_METHOD;
+        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_CRS_METHOD);
         aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+        g_free(s);
         aml_append(dev, method);
 
         method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-        s = BASEPATH MEMORY_SLOT_STATUS_METHOD;
+        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_STATUS_METHOD);
         aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+        g_free(s);
         aml_append(dev, method);
 
         method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
-        s = BASEPATH MEMORY_SLOT_PROXIMITY_METHOD;
+        s = g_strdup_printf("%s.%s", mhp_res_path,
+                            MEMORY_SLOT_PROXIMITY_METHOD);
         aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+        g_free(s);
         aml_append(dev, method);
 
         method = aml_method("_OST", 3, AML_NOTSERIALIZED);
-        s = BASEPATH MEMORY_SLOT_OST_METHOD;
-
+        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_OST_METHOD);
         aml_append(method, aml_return(aml_call4(
             s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
         )));
+        g_free(s);
         aml_append(dev, method);
 
         method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-        s = BASEPATH MEMORY_SLOT_EJECT_METHOD;
+        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_EJECT_METHOD);
         aml_append(method, aml_return(aml_call2(
                    s, aml_name("_UID"), aml_arg(0))));
+        g_free(s);
         aml_append(dev, method);
 
         aml_append(sb_scope, dev);
@@ -669,4 +673,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     }
     aml_append(sb_scope, method);
     aml_append(table, sb_scope);
+
+    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
+    scan_path = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_SCAN_METHOD);
+    aml_append(method, aml_call0(scan_path));
+    g_free(scan_path);
+    aml_append(table, method);
+
+    g_free(mhp_res_path);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ca4165e..9f3cfba 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1926,7 +1926,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                        "\\_SB.PCI0", "\\_GPE._E02");
     }
     build_memory_hotplug_aml(dsdt, nr_mem, pm->mem_hp_io_base,
-                             pm->mem_hp_io_len);
+                             pm->mem_hp_io_len,
+                             "\\_SB.PCI0", "\\_GPE._E03");
 
     scope =  aml_scope("_GPE");
     {
@@ -1941,10 +1942,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(scope, method);
         }
 
-        method = aml_method("_E03", 0, AML_NOTSERIALIZED);
-        aml_append(method, aml_call0(MEMORY_HOTPLUG_HANDLER_PATH));
-        aml_append(scope, method);
-
         if (pcms->acpi_nvdimm_state.is_enabled) {
             method = aml_method("_E04", 0, AML_NOTSERIALIZED);
             aml_append(method, aml_notify(aml_name("\\_SB.NVDR"),
-- 
MST
