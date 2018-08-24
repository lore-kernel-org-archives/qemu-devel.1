Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tk-00079f-67
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Ti-0003Sk-Tp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Ti-0003LC-HH
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Th-0006Qf-Hu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:03 +0100
Message-Id: <20180824093343.11346-13-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/52] hw/arm/vexpress: Add "virtualization"
 property controlling presence of EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a "virtualization" property to the vexpress-a15 board,
controlling presence of EL2. As with EL3, we default to
enabling it, but the user can disable it if they have an
older guest which can't cope with it being present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180821132811.17675-10-peter.maydell@linaro.org
---
 hw/arm/vexpress.c | 56 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 3631f4de3a4..c02d18ee618 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -172,6 +172,7 @@ typedef struct {
 typedef struct {
     MachineState parent;
     bool secure;
+    bool virt;
 } VexpressMachineState;
 
 #define TYPE_VEXPRESS_MACHINE   "vexpress"
@@ -203,7 +204,7 @@ struct VEDBoardInfo {
 };
 
 static void init_cpus(const char *cpu_type, const char *privdev,
-                      hwaddr periphbase, qemu_irq *pic, bool secure)
+                      hwaddr periphbase, qemu_irq *pic, bool secure, bool virt)
 {
     DeviceState *dev;
     SysBusDevice *busdev;
@@ -216,6 +217,11 @@ static void init_cpus(const char *cpu_type, const char *privdev,
         if (!secure) {
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
+        if (!virt) {
+            if (object_property_find(cpuobj, "has_el2", NULL)) {
+                object_property_set_bool(cpuobj, false, "has_el2", NULL);
+            }
+        }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
             object_property_set_int(cpuobj, periphbase,
@@ -289,7 +295,8 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x60000000, ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
-    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic, vms->secure);
+    init_cpus(cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
+              vms->secure, vms->virt);
 
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
 
@@ -370,7 +377,8 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x80000000, ram);
 
     /* 0x2c000000 A15MPCore private memory region (GIC) */
-    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secure);
+    init_cpus(cpu_type, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secure,
+              vms->virt);
 
     /* A15 daughterboard peripherals: */
 
@@ -724,6 +732,20 @@ static void vexpress_set_secure(Object *obj, bool value, Error **errp)
     vms->secure = value;
 }
 
+static bool vexpress_get_virt(Object *obj, Error **errp)
+{
+    VexpressMachineState *vms = VEXPRESS_MACHINE(obj);
+
+    return vms->virt;
+}
+
+static void vexpress_set_virt(Object *obj, bool value, Error **errp)
+{
+    VexpressMachineState *vms = VEXPRESS_MACHINE(obj);
+
+    vms->virt = value;
+}
+
 static void vexpress_instance_init(Object *obj)
 {
     VexpressMachineState *vms = VEXPRESS_MACHINE(obj);
@@ -738,6 +760,32 @@ static void vexpress_instance_init(Object *obj)
                                     NULL);
 }
 
+static void vexpress_a15_instance_init(Object *obj)
+{
+    VexpressMachineState *vms = VEXPRESS_MACHINE(obj);
+
+    /*
+     * For the vexpress-a15, EL2 is by default enabled if EL3 is,
+     * but can also be specifically set to on or off.
+     */
+    vms->virt = true;
+    object_property_add_bool(obj, "virtualization", vexpress_get_virt,
+                             vexpress_set_virt, NULL);
+    object_property_set_description(obj, "virtualization",
+                                    "Set on/off to enable/disable the ARM "
+                                    "Virtualization Extensions "
+                                    "(defaults to same as 'secure')",
+                                    NULL);
+}
+
+static void vexpress_a9_instance_init(Object *obj)
+{
+    VexpressMachineState *vms = VEXPRESS_MACHINE(obj);
+
+    /* The A9 doesn't have the virt extensions */
+    vms->virt = false;
+}
+
 static void vexpress_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -784,12 +832,14 @@ static const TypeInfo vexpress_a9_info = {
     .name = TYPE_VEXPRESS_A9_MACHINE,
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
+    .instance_init = vexpress_a9_instance_init,
 };
 
 static const TypeInfo vexpress_a15_info = {
     .name = TYPE_VEXPRESS_A15_MACHINE,
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
+    .instance_init = vexpress_a15_instance_init,
 };
 
 static void vexpress_machine_init(void)
-- 
2.18.0
