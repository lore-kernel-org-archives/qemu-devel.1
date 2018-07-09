Received: from eggs.gnu.org ([2001:4830:134:3::10]:50242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fccum-0001RM-QN
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fccuj-0006v5-Ks
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fccuj-0006ud-CR
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 16:37:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Jul 2018 17:37:31 -0300
Message-Id: <20180709203731.19865-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0] pc: Use "3.0+" constant as default
 SMBIOS version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>

Every time we create new PC machine-types in QEMU, the defaults
for SMBIOS fields change unnecessarily because the version field
defaults to MachineClass::name.

This can cause unexpected side-effects, like triggering license
reactivation on guest software, or changing the VM memory layout
because of BIOS table size changes.

Change the SMBIOS version string for pc-*-3.0 to "3.0+" to avoid
doing this on every QEMU release, and keep compatible version
strings on older machine-types using a new
MachineClass::smbios_version field.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
I just noticed that we started using mc->name on arm/virt since
commit dfadc3bfb458efefb72e13a57b62f138c464a577.
Should arm/virt start using "3.0+" too?
---
 include/hw/i386/pc.h | 3 +++
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 5 +++--
 hw/i386/pc_q35.c     | 3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4d99d69681..aea0fcaadb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,6 +134,9 @@ struct PCMachineClass {
 
     /* use DMA capable linuxboot option rom */
     bool linuxboot_dma_enabled;
+
+    /* Version field for SMBIOS Type 1, Type 2, Type 3, and Type 4 structs */
+    const char *smbios_version;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 50d5553991..47877e7071 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2379,6 +2379,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
+    pcmc->smbios_version = "3.0+";
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..f19c8b82d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -168,10 +168,9 @@ static void pc_init1(MachineState *machine,
     pc_guest_info_init(pcms);
 
     if (pcmc->smbios_defaults) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
-                            mc->name, pcmc->smbios_legacy_mode,
+                            pcmc->smbios_version, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
                             SMBIOS_ENTRY_POINT_21);
     }
@@ -440,9 +439,11 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
 
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_3_0_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
+    pcmc->smbios_version = m->name;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 532241e3f8..d6551ed8e9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -146,7 +146,7 @@ static void pc_q35_init(MachineState *machine)
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", "Standard PC (Q35 + ICH9, 2009)",
-                            mc->name, pcmc->smbios_legacy_mode,
+                            pcmc->smbios_version, pcmc->smbios_legacy_mode,
                             pcmc->smbios_uuid_encoded,
                             SMBIOS_ENTRY_POINT_21);
     }
@@ -336,6 +336,7 @@ static void pc_q35_2_11_machine_options(MachineClass *m)
 
     pc_q35_2_12_machine_options(m);
     pcmc->default_nic_model = "e1000";
+    pcmc->smbios_version = m->name;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
