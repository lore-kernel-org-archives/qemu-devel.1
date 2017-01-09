Received: from eggs.gnu.org ([2001:4830:134:3::10]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWR-0002Qg-UV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWQ-00045Y-Kr
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWQ-00043I-DA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:54 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWP-0001S7-HR
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:41 +0000
Message-Id: <1483962824-29185-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/21] hw/arm/virt: remove VirtGuestInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

by moving VirtGuestInfo.fw_cfg to VirtMachineState. This is the
mach-virt equivalent of "pc: Move PcGuestInfo.fw_cfg to
PCMachineState" and "pc: Eliminate PcGuestInfo struct" combined.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-14-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    |  6 +-----
 hw/arm/virt-acpi-build.c |  7 +++----
 hw/arm/virt.c            | 16 +++++++---------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index d200542..eb1c63d 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -77,10 +77,6 @@ typedef struct MemMapEntry {
     hwaddr size;
 } MemMapEntry;
 
-typedef struct VirtGuestInfo {
-    FWCfgState *fw_cfg;
-} VirtGuestInfo;
-
 typedef struct {
     MachineClass parent;
     bool disallow_affinity_adjustment;
@@ -91,8 +87,8 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
-    VirtGuestInfo acpi_guest_info;
     Notifier machine_done;
+    FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
     int32_t gic_version;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3791b81..44b5234 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -825,11 +825,10 @@ static const VMStateDescription vmstate_virt_acpi_build = {
 
 void virt_acpi_setup(VirtMachineState *vms)
 {
-    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
 
-    if (!guest_info->fw_cfg) {
+    if (!vms->fw_cfg) {
         trace_virt_acpi_setup();
         return;
     }
@@ -854,8 +853,8 @@ void virt_acpi_setup(VirtMachineState *vms)
         acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
                           "etc/table-loader", 0);
 
-    fw_cfg_add_file(guest_info->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
-                    tables.tcpalog->data, acpi_data_len(tables.tcpalog));
+    fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
+                    acpi_data_len(tables.tcpalog));
 
     build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
                                               ACPI_BUILD_RSDP_FILE, 0);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6832b8b..7a03f84 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -889,7 +889,7 @@ static void create_flash(const VirtMachineState *vms,
     }
 }
 
-static void create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
+static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
     hwaddr base = vms->memmap[VIRT_FW_CFG].base;
     hwaddr size = vms->memmap[VIRT_FW_CFG].size;
@@ -906,6 +906,7 @@ static void create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
                                  2, base, 2, size);
     g_free(nodename);
+    return fw_cfg;
 }
 
 static void create_pcie_irq_map(const VirtMachineState *vms,
@@ -1133,12 +1134,11 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 
 static void virt_build_smbios(VirtMachineState *vms)
 {
-    FWCfgState *fw_cfg = vms->acpi_guest_info.fw_cfg;
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     const char *product = "QEMU Virtual Machine";
 
-    if (!fw_cfg) {
+    if (!vms->fw_cfg) {
         return;
     }
 
@@ -1153,9 +1153,9 @@ static void virt_build_smbios(VirtMachineState *vms)
                       &smbios_anchor, &smbios_anchor_len);
 
     if (smbios_anchor) {
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-tables",
+        fw_cfg_add_file(vms->fw_cfg, "etc/smbios/smbios-tables",
                         smbios_tables, smbios_tables_len);
-        fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
+        fw_cfg_add_file(vms->fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
 }
@@ -1180,7 +1180,6 @@ static void machvirt_init(MachineState *machine)
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     const char *cpu_model = machine->cpu_model;
-    VirtGuestInfo *guest_info = &vms->acpi_guest_info;
     char **cpustr;
     ObjectClass *oc;
     const char *typename;
@@ -1369,10 +1368,9 @@ static void machvirt_init(MachineState *machine)
      */
     create_virtio_devices(vms, pic);
 
-    create_fw_cfg(vms, &address_space_memory);
-    rom_set_fw(fw_cfg_find());
+    vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
+    rom_set_fw(vms->fw_cfg);
 
-    guest_info->fw_cfg = fw_cfg_find();
     vms->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&vms->machine_done);
 
-- 
2.7.4
