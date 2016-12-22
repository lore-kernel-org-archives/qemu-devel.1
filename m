Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DO-0007lK-4S
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DL-0007CO-GD
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DL-0007C3-7U
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:27 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:50 +0100
Message-Id: <20161222152300.32395-16-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/25] pc: make smbus configurable
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
Message-Id: <1478330391-74060-2-git-send-email-chao.p.peng@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 18 ++++++++++++++++++
 hw/i386/pc_q35.c     | 12 +++++++-----
 include/hw/i386/pc.h |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a9e64a8..40bec88 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2158,6 +2158,20 @@ static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
     pcms->acpi_nvdimm_state.is_enabled = value;
 }
 
+static bool pc_machine_get_smbus(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->smbus;
+}
+
+static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->smbus = value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2169,6 +2183,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->acpi_nvdimm_state.is_enabled = false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
+    pcms->smbus = true;
 }
 
 static void pc_machine_reset(void)
@@ -2329,6 +2344,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_NVDIMM,
         pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort);
+
+    object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
+        pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b40d19e..5efc65a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -248,11 +248,13 @@ static void pc_q35_init(MachineState *machine)
         ehci_create_ich9_with_companions(host_bus, 0x1d);
     }
 
-    /* TODO: Populate SPD eeprom data.  */
-    smbus_eeprom_init(ich9_smb_init(host_bus,
-                                    PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
-                                    0xb100),
-                      8, NULL, 0);
+    if (pcms->smbus) {
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(ich9_smb_init(host_bus,
+                                        PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB_FUNC),
+                                        0xb100),
+                          8, NULL, 0);
+    }
 
     pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4b74130..e5447a0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -63,6 +63,7 @@ struct PCMachineState {
     AcpiNVDIMMState acpi_nvdimm_state;
 
     bool acpi_build_enabled;
+    bool smbus;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
@@ -88,6 +89,7 @@ struct PCMachineState {
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_NVDIMM           "nvdimm"
+#define PC_MACHINE_SMBUS            "smbus"
 
 /**
  * PCMachineClass:
-- 
2.9.3
