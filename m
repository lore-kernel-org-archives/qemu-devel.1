Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJa-00085o-1A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-0007yS-0O
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJY-0007vb-Pf
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJT-0005rC-Aj
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:45 +0100
Message-Id: <1505411573-27848-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/18] xlnx-zcu102: Add a machine level secure
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

From: Alistair Francis <alistair.francis@xilinx.com>

Add a machine level secure property. This defaults to false and can be
set to true using this machine command line argument:
    -machine xlnx-zcu102,secure=on

This follows what the ARM virt machine does.

This property only applies to the ZCU102 machine. The EP108 machine does
not have this property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 5b1f184..bd573c4 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -30,6 +30,8 @@ typedef struct XlnxZCU102 {
 
     XlnxZynqMPState soc;
     MemoryRegion ddr_ram;
+
+    bool secure;
 } XlnxZCU102;
 
 #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
@@ -42,6 +44,20 @@ typedef struct XlnxZCU102 {
 
 static struct arm_boot_info xlnx_zcu102_binfo;
 
+static bool zcu102_get_secure(Object *obj, Error **errp)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(obj);
+
+    return s->secure;
+}
+
+static void zcu102_set_secure(Object *obj, bool value, Error **errp)
+{
+    XlnxZCU102 *s = ZCU102_MACHINE(obj);
+
+    s->secure = value;
+}
+
 static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
 {
     int i;
@@ -69,6 +85,8 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineState *machine)
 
     object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
                          "ddr-ram", &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
+                             &error_fatal);
 
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
 
@@ -134,6 +152,10 @@ static void xlnx_ep108_init(MachineState *machine)
 
 static void xlnx_ep108_machine_instance_init(Object *obj)
 {
+    XlnxZCU102 *s = EP108_MACHINE(obj);
+
+    /* EP108, we don't support setting secure */
+    s->secure = false;
 }
 
 static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
@@ -169,6 +191,16 @@ static void xlnx_zcu102_init(MachineState *machine)
 
 static void xlnx_zcu102_machine_instance_init(Object *obj)
 {
+    XlnxZCU102 *s = ZCU102_MACHINE(obj);
+
+    /* Default to secure mode being disabled */
+    s->secure = false;
+    object_property_add_bool(obj, "secure", zcu102_get_secure,
+                             zcu102_set_secure, NULL);
+    object_property_set_description(obj, "secure",
+                                    "Set on/off to enable/disable the ARM "
+                                    "Security Extensions (TrustZone)",
+                                    NULL);
 }
 
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
-- 
2.7.4
