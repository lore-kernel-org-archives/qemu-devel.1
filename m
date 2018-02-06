Received: from eggs.gnu.org ([2001:4830:134:3::10]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uD-0001D1-Vn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uA-0003J1-MR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:54 -0500
Received: from mail-eopbgr00125.outbound.protection.outlook.com
	([40.107.0.125]:6512
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uA-0003Ia-Cj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:50 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:37 +0300
Message-Id: <20180206203048.11096-24-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 23/34] i386: en/disable vmbus by a machine
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Hyper-V VMBus logically belongs to the machine, so make its presence be
controlled by a boolean property of the machine.

TODO: consider doing this through adding the vmbus-bridge device instead
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc.c         | 34 ++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c    |  5 +++++
 hw/i386/pc_q35.c     |  5 +++++
 util/qemu-config.c   |  4 ++++
 5 files changed, 51 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 744f6a20d2..62b67cd927 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -46,6 +46,7 @@ struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     OnOffAuto smm;
+    bool vmbus;
 
     AcpiNVDIMMState acpi_nvdimm_state;
 
@@ -80,6 +81,7 @@ struct PCMachineState {
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
+#define PC_MACHINE_VMBUS            "vmbus"
 
 /**
  * PCMachineClass:
@@ -209,6 +211,7 @@ void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
 extern int fd_bootchk;
 
 bool pc_machine_is_smm_enabled(PCMachineState *pcms);
+bool pc_machine_is_vmbus_enabled(PCMachineState *pcms);
 void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ccc50baa85..d37072b575 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2178,6 +2178,34 @@ static void pc_machine_set_smm(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &pcms->smm, errp);
 }
 
+bool pc_machine_is_vmbus_enabled(PCMachineState *pcms)
+{
+    if (!pcms->vmbus) {
+        return false;
+    }
+
+    if (!kvm_enabled()) {
+        error_report("VMBus requires KVM");
+        exit(1);
+    }
+
+    return true;
+}
+
+static bool pc_machine_get_vmbus(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->vmbus;
+}
+
+static void pc_machine_set_vmbus(Object *obj, bool vmbus, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->vmbus = vmbus;
+}
+
 static bool pc_machine_get_nvdimm(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2413,6 +2441,12 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit, &error_abort);
+
+    /* no vmbus by default */
+    object_class_property_add_bool(oc, PC_MACHINE_VMBUS,
+        pc_machine_get_vmbus, pc_machine_set_vmbus, &error_abort);
+    object_class_property_set_description(oc, PC_MACHINE_VMBUS,
+        "Enable Hyper-V VMBus", &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a25619dfbf..4a3cb406d5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -56,6 +56,7 @@
 #include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
+#include "hw/vmbus/vmbus.h"
 
 #define MAX_IDE_BUS 2
 
@@ -302,6 +303,10 @@ static void pc_init1(MachineState *machine,
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    if (pc_machine_is_vmbus_enabled(pcms)) {
+        vmbus_create();
+    }
 }
 
 /* Looking for a pc_compat_2_4() function? It doesn't exist.
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ed3a0b8ff7..9e5ce429b4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -50,6 +50,7 @@
 #include "hw/usb.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/vmbus/vmbus.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -279,6 +280,10 @@ static void pc_q35_init(MachineState *machine)
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    if (pc_machine_is_vmbus_enabled(pcms)) {
+        vmbus_create();
+    }
 }
 
 #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 029fec53a9..951a6360a0 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -234,6 +234,10 @@ static QemuOptsList machine_opts = {
             .help = "Up to 8 chars in set of [A-Za-z0-9. ](lower case chars"
                     " converted to upper case) to pass to machine"
                     " loader, boot manager, and guest kernel",
+        },{
+            .name = "vmbus",
+            .type = QEMU_OPT_BOOL,
+            .help = "enable Hyper-V VMBus",
         },
         { /* End of list */ }
     }
-- 
2.14.3
