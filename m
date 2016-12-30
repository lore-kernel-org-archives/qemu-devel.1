Received: from eggs.gnu.org ([2001:4830:134:3::10]:43424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0Y-0002RQ-On
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0X-0000JR-BU
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:14 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0X-0000JE-3T
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:13 -0500
Received: by mail-pg0-x244.google.com with SMTP id g1so22376845pgn.0
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:13 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:45 -0600
Message-Id: <1483111310-24808-15-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 14/19] pc: Add an SMB0 ACPI device to q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

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
 tests/acpi-test-data/q35/DSDT        | Bin 8770 -> 8808 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 8787 -> 8825 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 9233 -> 9271 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 8845 -> 8883 bytes
 8 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b8a16cf..d7fbef4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1975,6 +1975,18 @@ static Aml *build_q35_osc_method(void)
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
@@ -2038,6 +2050,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_q35_pci0_int(dsdt);
+        if (pcms->smbus && !pcmc->do_not_add_smb_acpi) {
+            build_smb0(dsdt, pcms->smbus, ICH9_SMB_DEV, ICH9_SMB_FUNC);
+        }
     }
 
     if (pcmc->legacy_cpu_hotplug) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3bfe464..4dfb5d5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -274,15 +274,14 @@ static void pc_init1(MachineState *machine,
 
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
@@ -466,6 +465,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
+    pcmc->do_not_add_smb_acpi = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 5f67c45..7976480 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -255,10 +255,10 @@ static void pc_q35_init(MachineState *machine)
 
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
@@ -326,6 +326,7 @@ static void pc_q35_2_6_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug = true;
+    pcmc->do_not_add_smb_acpi = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_6);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f165f69..90ba3d8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -52,6 +52,7 @@ struct PCMachineState {
     HotplugHandler *acpi_dev;
     ISADevice *rtc;
     PCIBus *bus;
+    I2CBus *smbus;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
 
@@ -136,6 +137,7 @@ struct PCMachineClass {
     bool rsdp_in_ram;
     int legacy_acpi_table_size;
     unsigned acpi_data_size;
+    bool do_not_add_smb_acpi;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
diff --git a/tests/acpi-test-data/q35/DSDT b/tests/acpi-test-data/q35/DSDT
index 58fbb3d2e2dc8e8256984744bfb9411feb2e35fe..113fb3a860c9465edb4cae69318fe8c063ce3077 100644
GIT binary patch
delta 62
zcmX@)^1_A7CD<h-Ly3Wbv2G(*qok^;UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB11m?o
Rqe~DEGlM+C<}S${8~_;u4~_r;

delta 24
fcmaFia>#|tCD<jzNr{1h(RL$OqvYm|lG`}|Vsi(d

diff --git a/tests/acpi-test-data/q35/DSDT.bridge b/tests/acpi-test-data/q35/DSDT.bridge
index c392802a95cb5690c6719b7909c9f8fa2213e503..2f31562df229dbec6a17e5eafbc549d7fb6f179e 100644
GIT binary patch
delta 62
zcmccY^3#ROCD<jTQi*|qQEnqwqok^;UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB11m?o
Rqe~DEGlM+C<}S&T8~_r;4{`ti

delta 24
gcmezAa@mE;CD<h-Sc!pw@$N>hM#;?^B~New0Bqt2g8%>k

diff --git a/tests/acpi-test-data/q35/DSDT.cphp b/tests/acpi-test-data/q35/DSDT.cphp
index a0ce6b3264c69999c6e82a8ae7bab49338e4819b..f309211c279b562a5649458ccf0c078c4660d247 100644
GIT binary patch
delta 62
zcmbQ}vE75qCD<jzT!n#w@%u)uMoCpwz4&0K_yA{5gXkv7U|%N#j(87G7aleN23C%E
RN0%TTW(IkN&0Ui1TmTRp4^IF9

delta 24
fcmdn)G0}s|CD<iIP=$ekaoa|&M#;?^CEK_FTkHp5

diff --git a/tests/acpi-test-data/q35/DSDT.ipmibt b/tests/acpi-test-data/q35/DSDT.ipmibt
index 0ea38e1e72977e82053b087a6bd2e4ea21373420..7777de5996292205e1a365298db7f31291a24cfa 100644
GIT binary patch
delta 62
zcmeBm-R#Qc66_MPS&4yxaq&j3Gm@&Rdhx+d@d3`B2GLED!M;ug9Pu8WE<9`k46GdS
SjxIqw%nb4jo3Bdl-~a$63lJ;-

delta 24
fcmdn&+Uv^Y66_MvtHi*-n6#1WjO6A&lG`}|Vkrnc

-- 
2.7.4
