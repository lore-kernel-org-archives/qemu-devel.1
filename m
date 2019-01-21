Received: from eggs.gnu.org ([209.51.188.92]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevN-000888-SZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefk-0002yI-3O
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:49 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefj-0002xS-QF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so11842356wml.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:18 +0000
Message-Id: <20190121185118.18550-24-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 23/23] hw/arm/mps2-tz: Add mps2-an521 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Add a model of the MPS2 FPGA image described in Application Note
AN521. This is identical to the AN505 image, except that it uses
the SSE-200 rather than the IoTKit and so has two Cortex-M33 CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 95adcd478ab..f5f0b0e0fa5 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -15,6 +15,7 @@
  * as seen by the guest depend significantly on the FPGA image.
  * This source file covers the following FPGA images, for TrustZone cores:
  *  "mps2-an505" -- Cortex-M33 as documented in ARM Application Note AN505
+ *  "mps2-an521" -- Dual Cortex-M33 as documented in Application Note AN521
  *
  * Links to the TRM for the board itself and to the various Application
  * Notes which document the FPGA images can be found here:
@@ -24,10 +25,16 @@
  * http://infocenter.arm.com/help/topic/com.arm.doc.100112_0200_06_en/versatile_express_cortex_m_prototyping_systems_v2m_mps2_and_v2m_mps2plus_technical_reference_100112_0200_06_en.pdf
  * Application Note AN505:
  * http://infocenter.arm.com/help/topic/com.arm.doc.dai0505b/index.html
+ * Application Note AN521:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.dai0521c/index.html
  *
  * The AN505 defers to the Cortex-M33 processor ARMv8M IoT Kit FVP User Guide
  * (ARM ECM0601256) for the details of some of the device layout:
  *   http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
+ * Similarly, the AN521 uses the SSE-200, and the SSE-200 TRM defines
+ * most of the device layout:
+ *  http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ *
  */
 
 #include "qemu/osdep.h"
@@ -64,6 +71,7 @@ typedef struct {
     MachineClass parent;
     MPS2TZFPGAType fpga_type;
     uint32_t scc_id;
+    const char *armsse_type;
 } MPS2TZMachineClass;
 
 typedef struct {
@@ -93,6 +101,7 @@ typedef struct {
 
 #define TYPE_MPS2TZ_MACHINE "mps2tz"
 #define TYPE_MPS2TZ_AN505_MACHINE MACHINE_TYPE_NAME("mps2-an505")
+#define TYPE_MPS2TZ_AN521_MACHINE MACHINE_TYPE_NAME("mps2-an521")
 
 #define MPS2TZ_MACHINE(obj) \
     OBJECT_CHECK(MPS2TZMachineState, obj, TYPE_MPS2TZ_MACHINE)
@@ -379,7 +388,7 @@ static void mps2tz_common_init(MachineState *machine)
     }
 
     sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
-                          sizeof(mms->iotkit), TYPE_IOTKIT);
+                          sizeof(mms->iotkit), mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
                              "memory", &error_abort);
@@ -632,7 +641,6 @@ static void mps2tz_class_init(ObjectClass *oc, void *data)
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
 
     mc->init = mps2tz_common_init;
-    mc->max_cpus = 1;
     iic->check = mps2_tz_idau_check;
 }
 
@@ -642,9 +650,28 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
 
     mc->desc = "ARM MPS2 with AN505 FPGA image for Cortex-M33";
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mmc->scc_id = 0x41045050;
+    mmc->armsse_type = TYPE_IOTKIT;
+}
+
+static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
+
+    mc->desc = "ARM MPS2 with AN521 FPGA image for dual Cortex-M33";
+    mc->default_cpus = 2;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mmc->fpga_type = FPGA_AN521;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mmc->scc_id = 0x41045210;
+    mmc->armsse_type = TYPE_SSE200;
 }
 
 static const TypeInfo mps2tz_info = {
@@ -666,10 +693,17 @@ static const TypeInfo mps2tz_an505_info = {
     .class_init = mps2tz_an505_class_init,
 };
 
+static const TypeInfo mps2tz_an521_info = {
+    .name = TYPE_MPS2TZ_AN521_MACHINE,
+    .parent = TYPE_MPS2TZ_MACHINE,
+    .class_init = mps2tz_an521_class_init,
+};
+
 static void mps2tz_machine_init(void)
 {
     type_register_static(&mps2tz_info);
     type_register_static(&mps2tz_an505_info);
+    type_register_static(&mps2tz_an521_info);
 }
 
 type_init(mps2tz_machine_init);
-- 
2.20.1
