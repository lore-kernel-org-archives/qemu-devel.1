Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQJLg-0000wA-6s
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQJLf-0005Rc-9Q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 17:18:36 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Jun 2018 23:18:25 +0200
Message-Id: <1528233505-25842-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm: Remove the deprecated xlnx-ep108
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

It has been marked as deprecated since QEMU v2.11, so it is time to
remove this now. The xlnx-zcu102 machine is very much the same and
can be used as a replacement instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/xlnx-zcu102.c | 62 ++--------------------------------------------------
 qemu-doc.texi        |  5 -----
 2 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index c70278c..f26fd8e 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -39,10 +39,6 @@ typedef struct XlnxZCU102 {
 #define ZCU102_MACHINE(obj) \
     OBJECT_CHECK(XlnxZCU102, (obj), TYPE_ZCU102_MACHINE)
 
-#define TYPE_EP108_MACHINE   MACHINE_TYPE_NAME("xlnx-ep108")
-#define EP108_MACHINE(obj) \
-    OBJECT_CHECK(XlnxZCU102, (obj), TYPE_EP108_MACHINE)
-
 static struct arm_boot_info xlnx_zcu102_binfo;
 
 static bool zcu102_get_secure(Object *obj, Error **errp)
@@ -73,8 +69,9 @@ static void zcu102_set_virt(Object *obj, bool value, Error **errp)
     s->virt = value;
 }
 
-static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
+static void xlnx_zcu102_init(MachineState *machine)
 {
+    XlnxZCU102 *s = ZCU102_MACHINE(machine);
     int i;
     uint64_t ram_size = machine->ram_size;
 
@@ -183,60 +180,6 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
     arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
 
-static void xlnx_ep108_init(MachineState *machine)
-{
-    XlnxZCU102 *s = EP108_MACHINE(machine);
-
-    if (!qtest_enabled()) {
-        info_report("The Xilinx EP108 machine is deprecated, please use the "
-                    "ZCU102 machine (which has the same features) instead.");
-    }
-
-    xlnx_zynqmp_init(s, machine);
-}
-
-static void xlnx_ep108_machine_instance_init(Object *obj)
-{
-    XlnxZCU102 *s = EP108_MACHINE(obj);
-
-    /* EP108, we don't support setting secure or virt */
-    s->secure = false;
-    s->virt = false;
-}
-
-static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Xilinx ZynqMP EP108 board (Deprecated, please use xlnx-zcu102)";
-    mc->init = xlnx_ep108_init;
-    mc->block_default_type = IF_IDE;
-    mc->units_per_default_bus = 1;
-    mc->ignore_memory_transaction_failures = true;
-    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
-    mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
-}
-
-static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
-    .name       = MACHINE_TYPE_NAME("xlnx-ep108"),
-    .parent     = TYPE_MACHINE,
-    .class_init = xlnx_ep108_machine_class_init,
-    .instance_init = xlnx_ep108_machine_instance_init,
-    .instance_size = sizeof(XlnxZCU102),
-};
-
-static void xlnx_ep108_machine_init_register_types(void)
-{
-    type_register_static(&xlnx_ep108_machine_init_typeinfo);
-}
-
-static void xlnx_zcu102_init(MachineState *machine)
-{
-    XlnxZCU102 *s = ZCU102_MACHINE(machine);
-
-    xlnx_zynqmp_init(s, machine);
-}
-
 static void xlnx_zcu102_machine_instance_init(Object *obj)
 {
     XlnxZCU102 *s = ZCU102_MACHINE(obj);
@@ -289,4 +232,3 @@ static void xlnx_zcu102_machine_init_register_types(void)
 }
 
 type_init(xlnx_zcu102_machine_init_register_types)
-type_init(xlnx_ep108_machine_init_register_types)
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f00706b..2effe66 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2965,11 +2965,6 @@ support page sizes < 4096 any longer.
 
 @section System emulator machines
 
-@subsection Xilinx EP108 (since 2.11.0)
-
-The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' machine.
-The ``xlnx-zcu102'' machine has the same features and capabilites in QEMU.
-
 @section Block device options
 
 @subsection "backing": "" (since 2.12.0)
-- 
1.8.3.1
