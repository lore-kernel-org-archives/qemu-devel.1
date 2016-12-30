Received: from eggs.gnu.org ([2001:4830:134:3::10]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0V-0002Oa-GB
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0U-0000IN-9A
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:11 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0U-0000I0-2R
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:10 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so12188106pfg.0
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:44 -0600
Message-Id: <1483111310-24808-14-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 13/19] pc: Add _enabled to the end of some
 boolean flags
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

This makes the function of the variable more clear and avoids
some conflicts in later patches.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i386/pc.c         | 37 +++++++++++++++++++------------------
 hw/i386/pc_piix.c    |  3 ++-
 hw/i386/pc_q35.c     |  6 +++---
 include/hw/i386/pc.h |  6 +++---
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 25e8586..56a535d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2160,46 +2160,46 @@ static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
     pcms->acpi_nvdimm_state.is_enabled = value;
 }
 
-static bool pc_machine_get_smbus(Object *obj, Error **errp)
+static bool pc_machine_get_smbus_enabled(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->smbus;
+    return pcms->smbus_enabled;
 }
 
-static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
+static void pc_machine_set_smbus_enabled(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->smbus = value;
+    pcms->smbus_enabled = value;
 }
 
-static bool pc_machine_get_sata(Object *obj, Error **errp)
+static bool pc_machine_get_sata_enabled(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->sata;
+    return pcms->sata_enabled;
 }
 
-static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
+static void pc_machine_set_sata_enabled(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->sata = value;
+    pcms->sata_enabled = value;
 }
 
-static bool pc_machine_get_pit(Object *obj, Error **errp)
+static bool pc_machine_get_pit_enabled(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    return pcms->pit;
+    return pcms->pit_enabled;
 }
 
-static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
+static void pc_machine_set_pit_enabled(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
 
-    pcms->pit = value;
+    pcms->pit_enabled = value;
 }
 
 static void pc_machine_initfn(Object *obj)
@@ -2213,9 +2213,9 @@ static void pc_machine_initfn(Object *obj)
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
@@ -2378,13 +2378,14 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
         pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort);
 
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
-        pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
+        pc_machine_get_smbus_enabled, pc_machine_set_smbus_enabled,
+        &error_abort);
 
     object_class_property_add_bool(oc, PC_MACHINE_SATA,
-        pc_machine_get_sata, pc_machine_set_sata, &error_abort);
+        pc_machine_get_sata_enabled, pc_machine_set_sata_enabled, &error_abort);
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
-        pc_machine_get_pit, pc_machine_set_pit, &error_abort);
+        pc_machine_get_pit_enabled, pc_machine_set_pit_enabled, &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e1adbe..3bfe464 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -235,7 +235,8 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
-                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
+                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit_enabled,
+                         0x4);
 
     pc_nic_init(isa_bus, pci_bus);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d042fe0..5f67c45 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -227,13 +227,13 @@ static void pc_q35_init(MachineState *machine)
 
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
@@ -253,7 +253,7 @@ static void pc_q35_init(MachineState *machine)
         ehci_create_ich9_with_companions(host_bus, 0x1d);
     }
 
-    if (pcms->smbus) {
+    if (pcms->smbus_enabled) {
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(ich9_smb_init(host_bus,
                                         PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b22e699..f165f69 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -63,9 +63,9 @@ struct PCMachineState {
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
