Received: from eggs.gnu.org ([2001:4830:134:3::10]:46069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2O-0003Mv-RM
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2N-0003j0-K6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:16 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 31 Aug 2017 16:34:25 -0700
Message-ID: <be926a221e31f7aaefe8558965a644a7ced817f2.1504222314.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1504222314.git.alistair.francis@xilinx.com>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/5] xlnx-zcu102: Add a machine level
 virtualization property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

Add a machine level virtualization property. This defaults to false and can be
set to true using this machine command line argument:
    -machine xlnx-zcu102,virtualization=on

This follows what the ARM virt machine does.

This property only applies to the ZCU102 machine. The EP108 machine does
not have this property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/arm/xlnx-zcu102.c         | 30 +++++++++++++++++++++++++++++-
 hw/arm/xlnx-zynqmp.c         |  3 ++-
 include/hw/arm/xlnx-zynqmp.h |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 080507831a..40c1f5bbf6 100644
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
@@ -200,6 +218,16 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
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
index 9eceadbdc8..37a8bf2ccd 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -260,7 +260,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
                                  s->secure, "has_el3", NULL);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]),
-                                 false, "has_el2", NULL);
+                                 s->virt, "has_el2", NULL);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
                                 "reset-cbar", &error_abort);
         object_property_set_bool(OBJECT(&s->apu_cpu[i]), true, "realized",
@@ -432,6 +432,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
+    DEFINE_PROP_BOOL("virtualization", XlnxZynqMPState, virt, false),
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c2931bf39c..6eff81a995 100644
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
-- 
2.11.0
