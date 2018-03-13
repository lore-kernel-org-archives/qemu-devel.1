Received: from eggs.gnu.org ([2001:4830:134:3::10]:57744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshb-0005Ly-SL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsha-0002hS-Lj
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsha-0002gR-CZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:26 -0400
Received: by mail-wm0-x242.google.com with SMTP id u10so666626wmu.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:26 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:13 +0100
Message-Id: <20180313224719.4954-4-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/69] q35: change default NIC to e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The e1000 NIC is getting old and is not a very good default for a
PCIe machine type.  Change it to e1000e, which should be supported
by a good number of guests.

In particular, drivers for 82574 were added first to Linux 2.6.27 (2008)
and Windows 2008 R2.  This does mean that Windows 2008 will not work
anymore with Q35 machine types and a default "-net nic -net xxx" network
configuration; it did work before because it does have an AHCI driver.
However, Windows 2008 has been declared out of main stream support
in 2015.  It will get out of extended support in 2020.  Windows 2008
R2 has the same end of support dates and, since the two are basically
Vista vs. Windows 7, R2 probably is more popular.

Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 7 ++++---
 hw/i386/pc_piix.c    | 6 +++++-
 hw/i386/pc_q35.c     | 8 +++++++-
 include/hw/i386/pc.h | 3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 35fcb6efdf..dc1f535697 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1619,18 +1619,19 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     }
 }
 
-void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
+void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
 {
     int i;
 
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
+        const char *model = nd->model ? nd->model : pcmc->default_nic_model;
 
-        if (!pci_bus || (nd->model && strcmp(nd->model, "ne2k_isa") == 0)) {
+        if (g_str_equal(model, "ne2k_isa")) {
             pc_init_ne2k_isa(isa_bus, nd);
         } else {
-            pci_nic_init_nofail(nd, pci_bus, "e1000", NULL);
+            pci_nic_init_nofail(nd, pci_bus, model, NULL);
         }
     }
     rom_reset_order_override();
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8658bcba63..0f1966d547 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -240,7 +240,7 @@ static void pc_init1(MachineState *machine,
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
                          (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
 
-    pc_nic_init(isa_bus, pci_bus);
+    pc_nic_init(pcmc, isa_bus, pci_bus);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     if (pcmc->pci_enabled) {
@@ -417,6 +417,9 @@ static void pc_xen_hvm_init(MachineState *machine)
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    pcmc->default_nic_model = "e1000";
+
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
     m->default_machine_opts = "firmware=bios-256k.bin";
@@ -1114,6 +1117,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->gigabyte_align = false;
     pcmc->smbios_legacy_mode = true;
     pcmc->has_reserved_memory = false;
+    pcmc->default_nic_model = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0c0bc48137..9ae916327e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -272,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
-    pc_nic_init(isa_bus, host_bus);
+    pc_nic_init(pcmc, isa_bus, host_bus);
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
@@ -294,6 +294,9 @@ static void pc_q35_init(MachineState *machine)
 
 static void pc_q35_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    pcmc->default_nic_model = "e1000e";
+
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
     m->units_per_default_bus = 1;
@@ -316,7 +319,10 @@ DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
 
 static void pc_q35_2_11_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_2_12_machine_options(m);
+    pcmc->default_nic_model = "e1000";
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0..e81654eb7f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -114,6 +114,7 @@ struct PCMachineClass {
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
+    const char *default_nic_model;
 
     /* Compat options: */
 
@@ -248,7 +249,7 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
 void pc_cmos_init(PCMachineState *pcms,
                   BusState *ide0, BusState *ide1,
                   ISADevice *s);
-void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus);
+void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 void pc_pci_device_init(PCIBus *pci_bus);
 
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
-- 
2.14.3
