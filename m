Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-00085b-OF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-0007xk-Fz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJY-0007iP-7e
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJT-0005rd-Vp
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:46 +0100
Message-Id: <1505411573-27848-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/18] xlnx-zcu102: Add a machine level
 virtualization property
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

Add a machine level virtualization property. This defaults to false and can be
set to true using this machine command line argument:
    -machine xlnx-zcu102,virtualization=on

This follows what the ARM virt machine does.

This property only applies to the ZCU102 machine. The EP108 machine does
not have this property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h |  2 ++
 hw/arm/xlnx-zcu102.c         | 30 +++++++++++++++++++++++++++++-
 hw/arm/xlnx-zynqmp.c         |  3 ++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c2931bf..6eff81a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -91,6 +91,8 @@ typedef struct XlnxZynqMPState {
 
     /* Has the ARM Security extensions?  */
     bool secure;
+    /* Has the ARM Virtualization extensions?  */
+    bool virt;
     /* Has the RPU subsystem?  */
     bool has_rpu;
 }  XlnxZynqMPState;
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bd573c4..42deefd 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -32,6 +32,7 @@ typedef struct XlnxZCU102 {
     MemoryRegion ddr_ram;
 
     bool secure;
+    bool virt;
 } XlnxZCU102;
 
 #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
@@ -58,6 +59,20 @@ static void zcu102_set_secure(Object *obj, bool value, Error **errp)
     s->secure = value;
 }
 
+static bool zcu102_get_virt(Object *obj, Error **errp)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(obj);
+
+    return s->virt;
+}
+
+static void zcu102_set_virt(Object *obj, bool value, Error **errp)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(obj);
+
+    s->virt = value;
+}
+
 static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
 {
     int i;
@@ -87,6 +102,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
                          "ddr-ram", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
                              &error_fatal);
+    object_property_set_bool(OBJECT(&s->soc), s->virt, "virtualization",
+                             &error_fatal);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
 
@@ -154,8 +171,9 @@ static void xlnx_ep108_machine_instance_init(Object *obj)
 {
     XlnxZCU102 *s = EP108_MACHINE(obj);
 
-    /* EP108, we don't support setting secure */
+    /* EP108, we don't support setting secure or virt */
     s->secure = false;
+    s->virt = false;
 }
 
 static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
@@ -201,6 +219,16 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
                                     "Set on/off to enable/disable the ARM "
                                     "Security Extensions (TrustZone)",
                                     NULL);
+
+    /* Default to virt (EL2) being disabled */
+    s->virt = false;
+    object_property_add_bool(obj, "virtualization", zcu102_get_virt,
+                             zcu102_set_virt, NULL);
+    object_property_set_description(obj, "virtualization",
+                                    "Set on/off to enable/disable emulating a "
+                                    "guest CPU which implements the ARM "
+                                    "Virtualization Extensions",
+                                    NULL);
 }
 
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 22c2a33..2b27daf 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -255,7 +255,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
                                  s->secure, "has_el3", NULL);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
-                                 false, "has_el2", NULL);
+                                 s->virt, "has_el2", NULL);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
                                 "reset-cbar", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
@@ -427,6 +427,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
+    DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
     DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
-- 
2.7.4
