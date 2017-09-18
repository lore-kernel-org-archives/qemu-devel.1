Received: from eggs.gnu.org ([2001:4830:134:3::10]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du4GU-000711-8x
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du4GQ-0006Wm-Pc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:11:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Sep 2017 19:11:24 -0300
Message-Id: <20170918221124.17159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] msf2: drop cpu_model to directly use cpu type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
after Igor comment:
http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04709.html

Fam: I'm trying your patchew "apply over series" feature on these 2 series,
     hoping they get both applied before my patch:

Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
Based-on: 1505762601-27143-6-git-send-email-sundeep.lkml@gmail.com

 include/hw/arm/msf2-soc.h |  1 +
 hw/arm/msf2-soc.c         |  3 ++-
 hw/arm/msf2-som.c         | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index afea23db38..3cfe5c76ee 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -50,6 +50,7 @@ typedef struct MSF2State {
 
     ARMv7MState armv7m;
 
+    char *cpu_type;
     char *part_name;
     uint64_t envm_size;
     uint64_t esram_size;
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index abba3d888b..6f97fa9fe3 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -111,7 +111,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
-    qdev_prop_set_string(armv7m, "cpu-model", "cortex-m3");
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
@@ -201,6 +201,7 @@ static Property m2sxxx_soc_properties[] = {
      * part name specifies the type of SmartFusion2 device variant(this
      * property is for information purpose only.
      */
+    DEFINE_PROP_STRING("cpu-type", MSF2State, cpu_type),
     DEFINE_PROP_STRING("part-name", MSF2State, part_name),
     DEFINE_PROP_UINT64("eNVM-size", MSF2State, envm_size, MSF2_ENVM_MAX_SIZE),
     DEFINE_PROP_UINT64("eSRAM-size", MSF2State, esram_size,
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index d3956965ab..0795a3a3a1 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -24,11 +24,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "qemu/cutils.h"
 #include "hw/arm/msf2-soc.h"
+#include "cpu.h"
 
 #define DDR_BASE_ADDRESS      0xA0000000
 #define DDR_SIZE              (64 * M_BYTE)
@@ -41,18 +43,26 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     DeviceState *dev;
     DeviceState *spi_flash;
     MSF2State *soc;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     DriveInfo *dinfo = drive_get_next(IF_MTD);
     qemu_irq cs_line;
     SSIBus *spi_bus;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ddr = g_new(MemoryRegion, 1);
 
+    if (strcmp(machine->cpu_type, mc->default_cpu_type) != 0) {
+        error_report("This board can only be used with CPU %s",
+                     mc->default_cpu_type);
+    }
+
     memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
     dev = qdev_create(NULL, TYPE_MSF2_SOC);
     qdev_prop_set_string(dev, "part-name", "M2S010");
+    qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
+
     qdev_prop_set_uint64(dev, "eNVM-size", M2S010_ENVM_SIZE);
     qdev_prop_set_uint64(dev, "eSRAM-size", M2S010_ESRAM_SIZE);
 
@@ -89,6 +99,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
 {
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
-- 
2.14.1
