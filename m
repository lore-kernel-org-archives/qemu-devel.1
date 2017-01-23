Received: from eggs.gnu.org ([2001:4830:134:3::10]:37935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVbF8-0006S6-Nr
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVbF7-0003sm-D8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 04:48:54 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 23 Jan 2017 10:48:43 +0100
Message-Id: <1485164923-17736-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1485164923-17736-1-git-send-email-armbru@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

The PC machines (pc-q35-* pc-i440fx-* pc-* isapc xenfv) automatically
create lsi53c895a SCSI HBAs and SCSI devices to honor -drive if=scsi.
For giggles, try -drive if=scsi,bus=25,media=cdrom --- this makes QEMU
create 25 of them.

The lsi53c895a is thoroughly obsolete (PCI Ultra2 SCSI, ca. 2000), and
currently has no maintainer in QEMU.  megasas is a better choice,
except for old OSes, which lack drivers. virtio-scsi is a much better
choice when you have a driver, but only (newish) Linux comes with one
in the box.  There is no good default that works for all guests.

Instead of supplying the not-so-good default just because we've always
supplied it, make the user pick, by not creating any SCSI HBAs for
-drive if=scsi.  The user now needs to create the SCSI HBA himself
with -device.  The SCSI devices will still be created automatically.

For backward compatibility, keep the traditional behavior for old
machine types.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/pc_piix.c    | 15 ++++++++++++++-
 hw/i386/pc_q35.c     |  7 ++++++-
 include/hw/i386/pc.h |  3 +++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..35e92e4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -292,7 +292,7 @@ static void pc_init1(MachineState *machine,
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
     }
 
-    if (pcmc->pci_enabled) {
+    if (pcmc->pci_enabled && pcmc->legacy_lsi_hba_auto_create) {
         pc_pci_device_init(pci_bus);
     }
 
@@ -449,9 +449,12 @@ DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_9_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
+    pcmc->legacy_lsi_hba_auto_create = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
@@ -472,6 +475,7 @@ DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
@@ -484,6 +488,7 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_6_machine_options(m);
     pcmc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
@@ -497,6 +502,7 @@ DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_5_machine_options(m);
     m->hw_version = "2.4.0";
     pcmc->broken_reserved_end = true;
@@ -521,6 +527,7 @@ DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3,
 static void pc_i440fx_2_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_3_machine_options(m);
     m->hw_version = "2.2.0";
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_2);
@@ -534,6 +541,7 @@ DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2,
 static void pc_i440fx_2_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_2_machine_options(m);
     m->hw_version = "2.1.0";
     m->default_display = NULL;
@@ -550,6 +558,7 @@ DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1,
 static void pc_i440fx_2_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_1_machine_options(m);
     m->hw_version = "2.0.0";
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_0);
@@ -582,6 +591,7 @@ DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0,
 static void pc_i440fx_1_7_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_2_0_machine_options(m);
     m->hw_version = "1.7.0";
     m->default_machine_opts = NULL;
@@ -599,6 +609,7 @@ DEFINE_I440FX_MACHINE(v1_7, "pc-i440fx-1.7", pc_compat_1_7,
 static void pc_i440fx_1_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_1_7_machine_options(m);
     m->hw_version = "1.6.0";
     m->rom_file_has_mr = false;
@@ -858,6 +869,7 @@ DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
 static void pc_i440fx_0_13_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_0_14_machine_options(m);
     m->hw_version = "0.13";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_13);
@@ -1084,6 +1096,7 @@ void igd_passthrough_isa_bridge_create(PCIBus *bus, uint16_t gpu_dev_id)
 static void isapc_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8..571565d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -266,7 +266,7 @@ static void pc_q35_init(MachineState *machine)
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
     pc_nic_init(isa_bus, host_bus);
-    if (pcmc->pci_enabled) {
+    if (pcmc->pci_enabled && pcmc->legacy_lsi_hba_auto_create) {
         pc_pci_device_init(host_bus);
     }
 
@@ -312,8 +312,11 @@ DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
 
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_2_9_machine_options(m);
     m->alias = NULL;
+    pcmc->legacy_lsi_hba_auto_create = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
@@ -333,6 +336,7 @@ DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
 static void pc_q35_2_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
@@ -356,6 +360,7 @@ DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
 static void pc_q35_2_4_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_2_5_machine_options(m);
     m->hw_version = "2.4.0";
     pcmc->broken_reserved_end = true;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 230e9e7..991b87b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -152,6 +152,9 @@ struct PCMachineClass {
     bool save_tsc_khz;
     /* generate legacy CPU hotplug AML */
     bool legacy_cpu_hotplug;
+
+    /* Whether to auto-create lsi53c895a SCSI HBAs */
+    bool legacy_lsi_hba_auto_create;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
-- 
2.7.4
