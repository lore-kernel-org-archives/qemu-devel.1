Received: from eggs.gnu.org ([2001:4830:134:3::10]:51549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN409-0004A7-2S
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN407-0006af-Ef
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:41 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN407-0006Zo-4q
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:39 -0500
Received: by mail-pg0-x241.google.com with SMTP id y6so5387977pgp.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:39 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:20 -0600
Message-Id: <1512683181-8420-14-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 13/14] i386: Rename bools in PCMachineState to
 end in _enabled
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

This makes their function more clear and prevents conflicts when adding
the actual devices to the machine state, if necessary.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i386/pc.c         | 18 +++++++++---------
 hw/i386/pc_piix.c    |  3 ++-
 hw/i386/pc_q35.c     |  6 +++---
 include/hw/i386/pc.h |  6 +++---
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 186545d..51f38b8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2184,42 +2184,42 @@ static bool pc_machine_get_smbus(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->smbus;
+    return pcms->smbus_enabled;
 }
 
 static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->smbus = value;
+    pcms->smbus_enabled = value;
 }
 
 static bool pc_machine_get_sata(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->sata;
+    return pcms->sata_enabled;
 }
 
 static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->sata = value;
+    pcms->sata_enabled = value;
 }
 
 static bool pc_machine_get_pit(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->pit;
+    return pcms->pit_enabled;
 }
 
 static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->pit = value;
+    pcms->pit_enabled = value;
 }
 
 static void pc_machine_initfn(Object *obj)
@@ -2233,9 +2233,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->acpi_nvdimm_state.is_enabled = false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
-    pcms->smbus = true;
-    pcms->sata = true;
-    pcms->pit = true;
+    pcms->smbus_enabled = true;
+    pcms->sata_enabled = true;
+    pcms->pit_enabled = true;
 }
 
 static void pc_machine_reset(void)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528..7e87ef0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -237,7 +237,8 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
-                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
+                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
+                         0x4);
 
     pc_nic_init(isa_bus, pci_bus);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d606004..6e4bf1a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,13 +230,13 @@ static void pc_q35_init(MachineState *machine)
 
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
-                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit,
+                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
                          0xff0104);
 
     /* connect pm stuff to lpc */
     ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
 
-    if (pcms->sata) {
+    if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
         ahci = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
@@ -256,7 +256,7 @@ static void pc_q35_init(MachineState *machine)
         ehci_create_ich9_with_companions(host_bus, 0x1d);
     }
 
-    if (pcms->smbus) {
+    if (pcms->smbus_enabled) {
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(ich9_smb_init(host_bus,
                                         PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ef438bd..713aa33 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -50,9 +50,9 @@ struct PCMachineState {
     AcpiNVDIMMState acpi_nvdimm_state;
 
     bool acpi_build_enabled;
-    bool smbus;
-    bool sata;
-    bool pit;
+    bool smbus_enabled;
+    bool sata_enabled;
+    bool pit_enabled;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
-- 
2.7.4
