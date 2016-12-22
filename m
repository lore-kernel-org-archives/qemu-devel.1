Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007lH-4A
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DM-0007Cf-Kx
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DM-0007CV-BT
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:28 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:51 +0100
Message-Id: <20161222152300.32395-17-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/25] pc: make sata configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chao Peng <chao.p.peng@linux.intel.com>

From: Chao Peng <chao.p.peng@linux.intel.com>

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Message-Id: <1478330391-74060-3-git-send-email-chao.p.peng@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 29 ++++++++++++++++++++++++-----
 hw/i386/pc_q35.c     | 24 ++++++++++++++----------
 include/hw/i386/pc.h |  2 ++
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 40bec88..b0beea3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -400,13 +400,13 @@ static void pc_cmos_init_late(void *opaque)
     int i, trans;
 
     val = 0;
-    if (ide_get_geometry(arg->idebus[0], 0,
-                         &cylinders, &heads, &sectors) >= 0) {
+    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 0,
+                                           &cylinders, &heads, &sectors) >= 0) {
         cmos_init_hd(s, 0x19, 0x1b, cylinders, heads, sectors);
         val |= 0xf0;
     }
-    if (ide_get_geometry(arg->idebus[0], 1,
-                         &cylinders, &heads, &sectors) >= 0) {
+    if (arg->idebus[0] && ide_get_geometry(arg->idebus[0], 1,
+                                           &cylinders, &heads, &sectors) >= 0) {
         cmos_init_hd(s, 0x1a, 0x24, cylinders, heads, sectors);
         val |= 0x0f;
     }
@@ -418,7 +418,8 @@ static void pc_cmos_init_late(void *opaque)
            geometry.  It is always such that: 1 <= sects <= 63, 1
            <= heads <= 16, 1 <= cylinders <= 16383. The BIOS
            geometry can be different if a translation is done. */
-        if (ide_get_geometry(arg->idebus[i / 2], i % 2,
+        if (arg->idebus[i / 2] &&
+            ide_get_geometry(arg->idebus[i / 2], i % 2,
                              &cylinders, &heads, &sectors) >= 0) {
             trans = ide_get_bios_chs_trans(arg->idebus[i / 2], i % 2) - 1;
             assert((trans & ~3) == 0);
@@ -2172,6 +2173,20 @@ static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
     pcms->smbus = value;
 }
 
+static bool pc_machine_get_sata(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->sata;
+}
+
+static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->sata = value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2184,6 +2199,7 @@ static void pc_machine_initfn(Object *obj)
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus = true;
+    pcms->sata = true;
 }
 
 static void pc_machine_reset(void)
@@ -2347,6 +2363,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
+
+    object_class_property_add_bool(oc, PC_MACHINE_SATA,
+        pc_machine_get_sata, pc_machine_set_sata, &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 5efc65a..205c33e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -232,16 +232,20 @@ static void pc_q35_init(MachineState *machine)
     /* connect pm stuff to lpc */
     ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
 
-    /* ahci and SATA device, for q35 1 ahci controller is built-in */
-    ahci = pci_create_simple_multifunction(host_bus,
-                                           PCI_DEVFN(ICH9_SATA1_DEV,
-                                                     ICH9_SATA1_FUNC),
-                                           true, "ich9-ahci");
-    idebus[0] = qdev_get_child_bus(&ahci->qdev, "ide.0");
-    idebus[1] = qdev_get_child_bus(&ahci->qdev, "ide.1");
-    g_assert(MAX_SATA_PORTS == ICH_AHCI(ahci)->ahci.ports);
-    ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
-    ahci_ide_create_devs(ahci, hd);
+    if (pcms->sata) {
+        /* ahci and SATA device, for q35 1 ahci controller is built-in */
+        ahci = pci_create_simple_multifunction(host_bus,
+                                               PCI_DEVFN(ICH9_SATA1_DEV,
+                                                         ICH9_SATA1_FUNC),
+                                               true, "ich9-ahci");
+        idebus[0] = qdev_get_child_bus(&ahci->qdev, "ide.0");
+        idebus[1] = qdev_get_child_bus(&ahci->qdev, "ide.1");
+        g_assert(MAX_SATA_PORTS == ICH_AHCI(ahci)->ahci.ports);
+        ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
+        ahci_ide_create_devs(ahci, hd);
+    } else {
+        idebus[0] = idebus[1] = NULL;
+    }
 
     if (machine_usb(machine)) {
         /* Should we create 6 UHCI according to ich9 spec? */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e5447a0..9535f4a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -64,6 +64,7 @@ struct PCMachineState {
 
     bool acpi_build_enabled;
     bool smbus;
+    bool sata;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
@@ -90,6 +91,7 @@ struct PCMachineState {
 #define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_NVDIMM           "nvdimm"
 #define PC_MACHINE_SMBUS            "smbus"
+#define PC_MACHINE_SATA             "sata"
 
 /**
  * PCMachineClass:
-- 
2.9.3
