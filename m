Received: from eggs.gnu.org ([2001:4830:134:3::10]:41530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMY-0005hs-Px
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMV-0005II-Oj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMV-00059T-Di
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:27 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:19 -0200
Message-Id: <20181211180129.7661-15-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/24] virt: Eliminate separate instance_init
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

All instance_init functions for all virt machine-types run
exactly the same code, so we don't need separate functions.  We
only need to set instance_init for TYPE_VIRT_MACHINE.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181205205827.19387-2-ehabkost@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/virt.c | 87 +++++++++++++--------------------------------------
 1 file changed, 21 insertions(+), 66 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index beaf6bc439..17f1b49d11 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,7 +74,6 @@
     static const TypeInfo machvirt_##major##_##minor##_info = { \
         .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
         .parent = TYPE_VIRT_MACHINE, \
-        .instance_init = virt_##major##_##minor##_instance_init, \
         .class_init = virt_##major##_##minor##_class_init, \
     }; \
     static void machvirt_machine_##major##_##minor##_init(void) \
@@ -1778,26 +1777,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = virt_machine_device_plug_cb;
 }
 
-static const TypeInfo virt_machine_info = {
-    .name          = TYPE_VIRT_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .abstract      = true,
-    .instance_size = sizeof(VirtMachineState),
-    .class_size    = sizeof(VirtMachineClass),
-    .class_init    = virt_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
-    },
-};
-
-static void machvirt_machine_init(void)
-{
-    type_register_static(&virt_machine_info);
-}
-type_init(machvirt_machine_init);
-
-static void virt_4_0_instance_init(Object *obj)
+static void virt_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1867,6 +1847,26 @@ static void virt_4_0_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static const TypeInfo virt_machine_info = {
+    .name          = TYPE_VIRT_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .abstract      = true,
+    .instance_size = sizeof(VirtMachineState),
+    .class_size    = sizeof(VirtMachineClass),
+    .class_init    = virt_machine_class_init,
+	.instance_init = virt_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+         { TYPE_HOTPLUG_HANDLER },
+         { }
+    },
+};
+
+static void machvirt_machine_init(void)
+{
+    type_register_static(&virt_machine_info);
+}
+type_init(machvirt_machine_init);
+
 static void virt_machine_4_0_options(MachineClass *mc)
 {
 }
@@ -1875,11 +1875,6 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
 #define VIRT_COMPAT_3_1 \
     HW_COMPAT_3_1
 
-static void virt_3_1_instance_init(Object *obj)
-{
-    virt_4_0_instance_init(obj);
-}
-
 static void virt_machine_3_1_options(MachineClass *mc)
 {
     virt_machine_4_0_options(mc);
@@ -1890,11 +1885,6 @@ DEFINE_VIRT_MACHINE(3, 1)
 #define VIRT_COMPAT_3_0 \
     HW_COMPAT_3_0
 
-static void virt_3_0_instance_init(Object *obj)
-{
-    virt_3_1_instance_init(obj);
-}
-
 static void virt_machine_3_0_options(MachineClass *mc)
 {
     virt_machine_3_1_options(mc);
@@ -1905,11 +1895,6 @@ DEFINE_VIRT_MACHINE(3, 0)
 #define VIRT_COMPAT_2_12 \
     HW_COMPAT_2_12
 
-static void virt_2_12_instance_init(Object *obj)
-{
-    virt_3_0_instance_init(obj);
-}
-
 static void virt_machine_2_12_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
@@ -1924,11 +1909,6 @@ DEFINE_VIRT_MACHINE(2, 12)
 #define VIRT_COMPAT_2_11 \
     HW_COMPAT_2_11
 
-static void virt_2_11_instance_init(Object *obj)
-{
-    virt_2_12_instance_init(obj);
-}
-
 static void virt_machine_2_11_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
@@ -1942,11 +1922,6 @@ DEFINE_VIRT_MACHINE(2, 11)
 #define VIRT_COMPAT_2_10 \
     HW_COMPAT_2_10
 
-static void virt_2_10_instance_init(Object *obj)
-{
-    virt_2_11_instance_init(obj);
-}
-
 static void virt_machine_2_10_options(MachineClass *mc)
 {
     virt_machine_2_11_options(mc);
@@ -1959,11 +1934,6 @@ DEFINE_VIRT_MACHINE(2, 10)
 #define VIRT_COMPAT_2_9 \
     HW_COMPAT_2_9
 
-static void virt_2_9_instance_init(Object *obj)
-{
-    virt_2_10_instance_init(obj);
-}
-
 static void virt_machine_2_9_options(MachineClass *mc)
 {
     virt_machine_2_10_options(mc);
@@ -1974,11 +1944,6 @@ DEFINE_VIRT_MACHINE(2, 9)
 #define VIRT_COMPAT_2_8 \
     HW_COMPAT_2_8
 
-static void virt_2_8_instance_init(Object *obj)
-{
-    virt_2_9_instance_init(obj);
-}
-
 static void virt_machine_2_8_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
@@ -1995,11 +1960,6 @@ DEFINE_VIRT_MACHINE(2, 8)
 #define VIRT_COMPAT_2_7 \
     HW_COMPAT_2_7
 
-static void virt_2_7_instance_init(Object *obj)
-{
-    virt_2_8_instance_init(obj);
-}
-
 static void virt_machine_2_7_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
@@ -2016,11 +1976,6 @@ DEFINE_VIRT_MACHINE(2, 7)
 #define VIRT_COMPAT_2_6 \
     HW_COMPAT_2_6
 
-static void virt_2_6_instance_init(Object *obj)
-{
-    virt_2_7_instance_init(obj);
-}
-
 static void virt_machine_2_6_options(MachineClass *mc)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-- 
2.18.0.rc1.1.g3f1ff2140
