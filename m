Received: from eggs.gnu.org ([2001:4830:134:3::10]:51570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN40A-0004Br-EV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN408-0006bI-9X
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:42 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN407-0006at-WD
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:40 -0500
Received: by mail-pf0-x241.google.com with SMTP id n6so5683043pfa.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:39 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:21 -0600
Message-Id: <1512683181-8420-15-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 14/14] pc: Add an SMB0 ACPI device to q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This is so I2C devices can be found in the ACPI namespace.  Currently
that's only IPMI, but devices can be easily added now.

Adding the devices required some PCI information, and the bus itself
to be added to the PCMachineState structure.

Note that this only works on Q35, the ACPI for PIIX4 is not capable
of handling an SMBus device.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i386/acpi-build.c                 |  15 +++++++++++++++
 hw/i386/pc_piix.c                    |  12 ++++++------
 hw/i386/pc_q35.c                     |   9 +++++----
 include/hw/i386/pc.h                 |   2 ++
 tests/acpi-test-data/q35/DSDT        | Bin 7828 -> 7866 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7845 -> 7883 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8291 -> 8329 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7903 -> 7941 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9193 -> 9231 bytes
 9 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 84d82bc..9ec8268 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1859,6 +1859,18 @@ static Aml *build_q35_osc_method(void)
     return method;
 }
 
+static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
+{
+    Aml *scope = aml_scope("_SB.PCI0");
+    Aml *dev = aml_device("SMB0");
+
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
+    aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
+    build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1910,6 +1922,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_q35_pci0_int(dsdt);
+        if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
+            build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
+        }
     }
 
     if (pcmc->legacy_cpu_hotplug) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7e87ef0..2a7ae72 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -276,15 +276,14 @@ static void pc_init1(MachineState *machine,
 
     if (pcmc->pci_enabled && acpi_enabled) {
         DeviceState *piix4_pm;
-        I2CBus *smbus;
 
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
         /* TODO: Populate SPD eeprom data.  */
-        smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
-                              pcms->gsi[9], smi_irq,
-                              pc_machine_is_smm_enabled(pcms),
-                              &piix4_pm);
-        smbus_eeprom_init(smbus, 8, NULL, 0);
+        pcms->smbus = piix4_pm_init(pci_bus, piix3_devfn + 3, 0xb100,
+                                    pcms->gsi[9], smi_irq,
+                                    pc_machine_is_smm_enabled(pcms),
+                                    &piix4_pm);
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
         object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  TYPE_HOTPLUG_HANDLER,
@@ -489,6 +488,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
     pcmc->linuxboot_dma_enabled = false;
+    pcmc->do_not_add_smb_acpi = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6e4bf1a..0777bb3 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -258,10 +258,10 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->smbus_enabled) {
         /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(ich9_smb_init(host_bus,
-                                        PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
-                                        0xb100),
-                          8, NULL, 0);
+        pcms->smbus = ich9_smb_init(host_bus,
+                                    PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
+                                    0xb100);
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
     pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
@@ -358,6 +358,7 @@ static void pc_q35_2_6_machine_options(MachineClass *m)
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
     pcmc->linuxboot_dma_enabled = false;
+    pcmc->do_not_add_smb_acpi = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 713aa33..5b19d10 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ struct PCMachineState {
     HotplugHandler *acpi_dev;
     ISADevice *rtc;
     PCIBus *bus;
+    I2CBus *smbus;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
 
@@ -122,6 +123,7 @@ struct PCMachineClass {
     bool rsdp_in_ram;
     int legacy_acpi_table_size;
     unsigned acpi_data_size;
+    bool do_not_add_smb_acpi;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index aa402cca667f82ed0a2dc4969508d8f6e38ad910..3d95d15cedc4727a07652b5055bb3fb6553e9521 100644
GIT binary patch
delta 62
zcmbPYyUUi#CD<iommC8FWBNueV@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{Gz|tN{Dz4qN~L

delta 24
fcmdmGJH?jECD<ioiW~z2quNF;W690QlHsfXSdIp5

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index fc3e79c583ababf5615e76ba2f7bc3df1483abb4..8d7c4dcd9dbd1f7b8c06fb20e526fca7d9e99b45 100644
GIT binary patch
delta 62
zcmZ2#d)k)ECD<k8v>XEiBl|`!V@Xw2z4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN%{G#mtN`_@4nP0^

delta 24
fcmX?YyVRD;CD<iosT>0X<FSog#*&+pB{Nt7V*LkE

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index fd3cb3421814d0383863dc780d9a2a9077b727a3..8b4c0dabb7e986a42178f40db858fd976a25d0f9 100644
GIT binary patch
delta 62
zcmaFt(CNtK66_MvsldR%_+TTKv81Z1UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB11m?o
Rqe~DEGlM+CW*bR$b^sC74x9i0

delta 24
fcmeBleC)vG66_L^tiZs)IDaFTvE=4tNi}u=T=E93

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 332237529e114256384c051858fdac36b024c72e..c765b9fc8f8a878159f4acd89eb7e881162d9bcb 100644
GIT binary patch
delta 62
zcmca_+iJ(<66_MfD$l^c*u9afPEu7>FFx2QKET=2Ai7C1*w@K`Bi_T)g@;Xmft4fP
R(Itq7nL(ambGu{&D**Ah4tW3o

delta 24
fcmZp*yKl?o66_LkUygx+(R(9To#f_qlHsfXV=o7a

diff --git a/tests/acpi-test-data/q35/DSDT.memhp b/tests/acpi-test-data/q35/DSDT.memhp
index f0a27e1a3093ff7525f62b7509ea44dfe9eb8908..eb08477a6b90726dd7722d095d0be548d913c4ac 100644
GIT binary patch
delta 62
zcmaFq-tWQX66_Mfufo8<n6Z(|SW;D0FFx2QKET=2Ai7C1*w@K`Bi_T)g@;Xmft4fP
R(Itq7nL(amvyJ3hE&%EV4p9IA

delta 24
fcmeD8c<IjN66_N4Qkj8)QDY;QvE=4t$u(R6W2XmV

-- 
2.7.4
