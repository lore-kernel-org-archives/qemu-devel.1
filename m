Received: from eggs.gnu.org ([2001:4830:134:3::10]:50567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPxB-00054i-Or
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPx8-0003ge-IN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:37 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com
	([104.47.38.74]:63443
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1diPx8-0003g2-5v
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:34 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 17 Aug 2017 11:52:04 -0700
Message-ID: <27222215579bf5d179393e24bb11140846c62948.1502993370.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1502993370.git.alistair.francis@xilinx.com>
References: <cover.1502993370.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/5] xlnx-zcu102: Manually create the
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

In preperation for future work let's manually create the Xilnx machines.
This will allow us to set properties for the machines in the future.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zcu102.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 133a6a31a8..71261313b5 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -26,15 +26,25 @@
 #include "qemu/log.h"
 
 typedef struct XlnxZCU102 {
+
+    MachineState parent_obj;
+
     XlnxZynqMPState soc;
     MemoryRegion ddr_ram;
 } XlnxZCU102;
 
+#define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
+#define ZCU102_MACHINE(obj) \
+    OBJECT_CHECK(XlnxZCU102, (obj), TYPE_ZCU102_MACHINE)
+
+#define TYPE_EP108_MACHINE   MACHINE_TYPE_NAME("xlnx-ep108")
+#define EP108_MACHINE(obj) \
+    OBJECT_CHECK(XlnxZCU102, (obj), TYPE_EP108_MACHINE)
+
 static struct arm_boot_info xlnx_zcu102_binfo;
 
-static void xlnx_zcu102_init(MachineState *machine)
+static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
 {
-    XlnxZCU102 *s = g_new0(XlnxZCU102, 1);
     int i;
     uint64_t ram_size = machine->ram_size;
 
@@ -116,22 +126,73 @@ static void xlnx_zcu102_init(MachineState *machine)
     arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
 
-static void xlnx_ep108_machine_init(MachineClass *mc)
+static void xlnx_ep108_init(MachineState *machine)
 {
+    XlnxZCU102 *s = EP108_MACHINE(machine);
+
+    xlnx_zynqmp_init(s, machine);
+}
+
+static void xlnx_ep108_machine_instance_init(Object *obj)
+{
+}
+
+static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP EP108 board";
-    mc->init = xlnx_zcu102_init;
+    mc->init = xlnx_ep108_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
 }
 
-DEFINE_MACHINE("xlnx-ep108", xlnx_ep108_machine_init)
+static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("xlnx-ep108"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xlnx_ep108_machine_class_init,
+    .instance_init = xlnx_ep108_machine_instance_init,
+    .instance_size = sizeof(XlnxZCU102),
+};
+
+static void xlnx_ep108_machine_init_register_types(void)
+{
+    type_register_static(&xlnx_ep108_machine_init_typeinfo);
+}
+
+static void xlnx_zcu102_init(MachineState *machine)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(machine);
+
+    xlnx_zynqmp_init(s, machine);
+}
 
-static void xlnx_zcu102_machine_init(MachineClass *mc)
+static void xlnx_zcu102_machine_instance_init(Object *obj)
 {
+}
+
+static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP ZCU102 board";
     mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
 }
 
-DEFINE_MACHINE("xlnx-zcu102", xlnx_zcu102_machine_init)
+static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("xlnx-zcu102"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xlnx_zcu102_machine_class_init,
+    .instance_init = xlnx_zcu102_machine_instance_init,
+    .instance_size = sizeof(XlnxZCU102),
+};
+
+static void xlnx_zcu102_machine_init_register_types(void)
+{
+    type_register_static(&xlnx_zcu102_machine_init_typeinfo);
+}
+
+type_init(xlnx_zcu102_machine_init_register_types)
+type_init(xlnx_ep108_machine_init_register_types)
-- 
2.11.0
