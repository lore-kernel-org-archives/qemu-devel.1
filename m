Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwm-00059x-Tu
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwl-0004ws-Jn
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwl-0004uJ-9P
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:15 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:46 +0800
Message-Id: <20170320001249.25521-8-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 07/10] xen-hvm: initiate building
 DM ACPI on i386 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

If QEMU is running as Xen device model and Xen needs ACPI (e.g. NFIT)
from QEMU, initiate building DM ACPI.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 hw/i386/pc.c         | 16 ++++++++++------
 include/hw/xen/xen.h |  2 ++
 xen-hvm-stub.c       |  4 ++++
 xen-hvm.c            | 23 ++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e05f..6b76720c35 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1256,12 +1256,16 @@ void pc_machine_done(Notifier *notifier, void *data)
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
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index d67cdd8c7d..2e2f4bf60d 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -65,4 +65,6 @@ void xen_register_framebuffer(struct MemoryRegion *mr);
 int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
                            int type);
 
+void xen_dm_acpi_setup(PCMachineState *pcms);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
index a6c018505c..1231faabda 100644
--- a/xen-hvm-stub.c
+++ b/xen-hvm-stub.c
@@ -67,3 +67,7 @@ int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
 {
     return -1;
 }
+
+void xen_dm_acpi_setup(PCMachineState *pcms)
+{
+}
diff --git a/xen-hvm.c b/xen-hvm.c
index 4ddc47e5f1..0c36dd11da 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -1268,7 +1268,7 @@ static ram_addr_t dm_acpi_buf_alloc(size_t length)
 
 static int xen_dm_acpi_required(PCMachineState *pcms)
 {
-    return 0;
+    return pcms->acpi_nvdimm_state.is_enabled;
 }
 
 static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
@@ -1280,6 +1280,27 @@ static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
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
-- 
2.12.0
