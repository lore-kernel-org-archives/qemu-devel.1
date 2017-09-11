Received: from eggs.gnu.org ([2001:4830:134:3::10]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYP-00015S-Rh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYL-0004ds-TT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGYL-0004UV-Jt
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:33 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:57 +0800
Message-Id: <20170911044157.15403-11-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 10/10] hw/xen-hvm: enable building
 DM ACPI if vNVDIMM is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

If the machine option 'nvdimm' is enabled and QEMU is used as Xen
device model, construct the guest NFIT and ACPI namespace devices of
vNVDIMM and copy them into guest memory.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/acpi/aml-build.c   | 10 +++++++---
 hw/i386/pc.c          | 16 ++++++++++------
 hw/i386/xen/xen-hvm.c | 25 +++++++++++++++++++++++--
 include/hw/xen/xen.h  |  7 +++++++
 stubs/xen-hvm.c       |  4 ++++
 5 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc450e..5f57c1bef3 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
 #include "hw/acpi/aml-build.h"
+#include "hw/xen/xen.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
@@ -1531,9 +1532,12 @@ build_header(BIOSLinker *linker, GArray *table_data,
     h->oem_revision = cpu_to_le32(1);
     memcpy(h->asl_compiler_id, ACPI_BUILD_APPNAME4, 4);
     h->asl_compiler_revision = cpu_to_le32(1);
-    /* Checksum to be filled in by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
-        tbl_offset, len, checksum_offset);
+    /* No linker is used when QEMU is used as Xen device model. */
+    if (!xen_enabled()) {
+        /* Checksum to be filled in by Guest linker */
+        bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
+                                        tbl_offset, len, checksum_offset);
+    }
 }
 
 void *acpi_data_push(GArray *table_data, unsigned size)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5cbdce61a7..7101d380a0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1252,12 +1252,16 @@ void pc_machine_done(Notifier *notifier, void *data)
         }
     }
 
-    acpi_setup();
-    if (pcms->fw_cfg) {
-        pc_build_smbios(pcms);
-        pc_build_feature_control_file(pcms);
-        /* update FW_CFG_NB_CPUS to account for -device added CPUs */
-        fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+    if (!xen_enabled()) {
+        acpi_setup();
+        if (pcms->fw_cfg) {
+            pc_build_smbios(pcms);
+            pc_build_feature_control_file(pcms);
+            /* update FW_CFG_NB_CPUS to account for -device added CPUs */
+            fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
+        }
+    } else {
+        xen_dm_acpi_setup(pcms);
     }
 
     if (pcms->apic_id_limit > 255) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index b74c4ffb9c..d81cc7dbbc 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -265,7 +265,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
         /* RAM already populated in Xen */
         fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
                 " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRATE\n",
-                __func__, size, ram_addr); 
+                __func__, size, ram_addr);
         return;
     }
 
@@ -1251,7 +1251,7 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
 
 static int xen_dm_acpi_needed(PCMachineState *pcms)
 {
-    return 0;
+    return pcms->acpi_nvdimm_state.is_enabled;
 }
 
 static int dm_acpi_buf_init(XenIOState *state)
@@ -1309,6 +1309,20 @@ static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
     return dm_acpi_buf_init(state);
 }
 
+static void xen_dm_acpi_nvdimm_setup(PCMachineState *pcms)
+{
+    GArray *table_offsets = g_array_new(false, true /* clear */,
+                                        sizeof(uint32_t));
+    GArray *table_data = g_array_new(false, true /* clear */, 1);
+
+    nvdimm_build_acpi(table_offsets, table_data,
+                      NULL, &pcms->acpi_nvdimm_state,
+                      MACHINE(pcms)->ram_slots);
+
+    g_array_free(table_offsets, true);
+    g_array_free(table_data, true);
+}
+
 static int xs_write_dm_acpi_blob_entry(const char *name,
                                        const char *entry, const char *value)
 {
@@ -1408,6 +1422,13 @@ int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
     return 0;
 }
 
+void xen_dm_acpi_setup(PCMachineState *pcms)
+{
+    if (pcms->acpi_nvdimm_state.is_enabled) {
+        xen_dm_acpi_nvdimm_setup(pcms);
+    }
+}
+
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     int i, rc;
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 38dcd1a7d4..8c48195e12 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -66,4 +66,11 @@ void xen_register_framebuffer(struct MemoryRegion *mr);
 int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
                            int type);
 
+/*
+ * Build guest ACPI (i.e. DM ACPI, or ACPI built by device model) and
+ * copy them into guest memory. Xen hvmloader will load and merge DM
+ * ACPI with the guest ACPI built by itself.
+ */
+void xen_dm_acpi_setup(PCMachineState *pcms);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 58889ae0fb..c1a6d21efa 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -67,3 +67,7 @@ int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
 {
     return -1;
 }
+
+void xen_dm_acpi_setup(PCMachineState *pcms)
+{
+}
-- 
2.11.0
