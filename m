Received: from eggs.gnu.org ([2001:4830:134:3::10]:59028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oa-0007qh-S9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oa-0002Ct-16
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5OZ-00029H-QG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OY-0003X2-W7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:45:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:52 +0100
Message-Id: <1500295494-8991-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/18] hw/arm/mps2: Add SCC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add the SCC to the MPS2 board models.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1500029487-14822-8-git-send-email-peter.maydell@linaro.org
---
 hw/arm/mps2.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4121816..80ee79e 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -34,6 +34,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/timer/cmsdk-apb-timer.h"
+#include "hw/misc/mps2-scc.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -44,6 +45,7 @@ typedef struct {
     MachineClass parent;
     MPS2FPGAType fpga_type;
     const char *cpu_model;
+    uint32_t scc_id;
 } MPS2MachineClass;
 
 typedef struct {
@@ -60,6 +62,7 @@ typedef struct {
     MemoryRegion blockram_m2;
     MemoryRegion blockram_m3;
     MemoryRegion sram;
+    MPS2SCC scc;
 } MPS2MachineState;
 
 #define TYPE_MPS2_MACHINE "mps2"
@@ -102,7 +105,7 @@ static void mps2_common_init(MachineState *machine)
     MPS2MachineState *mms = MPS2_MACHINE(machine);
     MPS2MachineClass *mmc = MPS2_MACHINE_GET_CLASS(machine);
     MemoryRegion *system_memory = get_system_memory();
-    DeviceState *armv7m;
+    DeviceState *armv7m, *sccdev;
 
     if (!machine->cpu_model) {
         machine->cpu_model = mmc->cpu_model;
@@ -297,6 +300,16 @@ static void mps2_common_init(MachineState *machine)
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
     cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
 
+    object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
+    sccdev = DEVICE(&mms->scc);
+    qdev_set_parent_bus(armv7m, sysbus_get_default());
+    qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
+    qdev_prop_set_uint32(sccdev, "scc-aid", 0x02000008);
+    qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
+    object_property_set_bool(OBJECT(&mms->scc), true, "realized",
+                             &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
+
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
@@ -319,6 +332,7 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN385 FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN385;
     mmc->cpu_model = "cortex-m3";
+    mmc->scc_id = 0x41040000 | (385 << 4);
 }
 
 static void mps2_an511_class_init(ObjectClass *oc, void *data)
@@ -329,6 +343,7 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mc->desc = "ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3";
     mmc->fpga_type = FPGA_AN511;
     mmc->cpu_model = "cortex-m3";
+    mmc->scc_id = 0x4104000 | (511 << 4);
 }
 
 static const TypeInfo mps2_info = {
-- 
2.7.4
