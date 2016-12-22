Received: from eggs.gnu.org ([2001:4830:134:3::10]:37862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DP-0007oR-6V
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DN-0007Cs-Q8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DN-0007Cj-H8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:29 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:52 +0100
Message-Id: <20161222152300.32395-18-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/25] pc: make pit configurable
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
Message-Id: <1478330391-74060-4-git-send-email-chao.p.peng@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 21 ++++++++++++++++++++-
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  3 ++-
 include/hw/i386/pc.h |  3 +++
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b0beea3..25e8586 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1536,6 +1536,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
                           bool create_fdctrl,
                           bool no_vmport,
+                          bool has_pit,
                           uint32_t hpet_irqs)
 {
     int i;
@@ -1589,7 +1590,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
 
     qemu_register_boot_set(pc_boot_set, *rtc_state);
 
-    if (!xen_enabled()) {
+    if (!xen_enabled() && has_pit) {
         if (kvm_pit_in_kernel()) {
             pit = kvm_pit_init(isa_bus, 0x40);
         } else {
@@ -2187,6 +2188,20 @@ static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
     pcms->sata = value;
 }
 
+static bool pc_machine_get_pit(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->pit;
+}
+
+static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->pit = value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2200,6 +2215,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus = true;
     pcms->sata = true;
+    pcms->pit = true;
 }
 
 static void pc_machine_reset(void)
@@ -2366,6 +2382,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_SATA,
         pc_machine_get_sata, pc_machine_set_sata, &error_abort);
+
+    object_class_property_add_bool(oc, PC_MACHINE_PIT,
+        pc_machine_get_pit, pc_machine_set_pit, &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a54a468..5e1adbe 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -235,7 +235,7 @@ static void pc_init1(MachineState *machine,
 
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
-                         (pcms->vmport != ON_OFF_AUTO_ON), 0x4);
+                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit, 0x4);
 
     pc_nic_init(isa_bus, pci_bus);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 205c33e..d042fe0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -227,7 +227,8 @@ static void pc_q35_init(MachineState *machine)
 
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
-                         (pcms->vmport != ON_OFF_AUTO_ON), 0xff0104);
+                         (pcms->vmport != ON_OFF_AUTO_ON), pcms->pit,
+                         0xff0104);
 
     /* connect pm stuff to lpc */
     ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9535f4a..b37bc5b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -65,6 +65,7 @@ struct PCMachineState {
     bool acpi_build_enabled;
     bool smbus;
     bool sata;
+    bool pit;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
@@ -92,6 +93,7 @@ struct PCMachineState {
 #define PC_MACHINE_NVDIMM           "nvdimm"
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
+#define PC_MACHINE_PIT              "pit"
 
 /**
  * PCMachineClass:
@@ -264,6 +266,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
                           bool create_fdctrl,
                           bool no_vmport,
+                          bool has_pit,
                           uint32_t hpet_irqs);
 void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd);
 void pc_cmos_init(PCMachineState *pcms,
-- 
2.9.3
