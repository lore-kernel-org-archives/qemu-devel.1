Received: from eggs.gnu.org ([2001:4830:134:3::10]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJa-00086a-K4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-0007ze-IG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJZ-0007x0-8z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJS-0005ql-N3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:44 +0100
Message-Id: <1505411573-27848-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/18] xlnx-zcu102: Manually create the machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

In preperation for future work let's manually create the Xilnx machines.
This will allow us to set properties for the machines in the future.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index e9702ed..5b1f184 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -26,15 +26,24 @@
 #include "qemu/log.h"
 
 typedef struct XlnxZCU102 {
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
 
@@ -116,19 +125,56 @@ static void xlnx_zcu102_init(MachineState *machine)
     arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
 
-static void xlnx_ep108_machine_init(MachineClass *mc)
+static void xlnx_ep108_init(MachineState *machine)
+{
+    XlnxZCU102 *s = EP108_MACHINE(machine);
+
+    xlnx_zynqmp_init(s, machine);
+}
+
+static void xlnx_ep108_machine_instance_init(Object *obj)
 {
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
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("xlnx-ep108", xlnx_ep108_machine_init)
+static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("xlnx-ep108"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xlnx_ep108_machine_class_init,
+    .instance_init = xlnx_ep108_machine_instance_init,
+    .instance_size = sizeof(XlnxZCU102),
+};
 
-static void xlnx_zcu102_machine_init(MachineClass *mc)
+static void xlnx_ep108_machine_init_register_types(void)
 {
+    type_register_static(&xlnx_ep108_machine_init_typeinfo);
+}
+
+static void xlnx_zcu102_init(MachineState *machine)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(machine);
+
+    xlnx_zynqmp_init(s, machine);
+}
+
+static void xlnx_zcu102_machine_instance_init(Object *obj)
+{
+}
+
+static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xilinx ZynqMP ZCU102 board";
     mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
@@ -136,4 +182,18 @@ static void xlnx_zcu102_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
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
2.7.4
