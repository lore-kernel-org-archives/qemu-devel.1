Received: from eggs.gnu.org ([2001:4830:134:3::10]:37261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEc-0002Dl-PF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYjEZ-0002Vt-II
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 21:01:50 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 23:00:54 -0300
Message-Id: <20180109020054.32553-10-f4bug@amsat.org>
In-Reply-To: <20180109020054.32553-1-f4bug@amsat.org>
References: <20180109020054.32553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 9/9] hw/arm/xlnx-zynqmp: use Linux FDT
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zynqmp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 325642058b..fdcd6801b6 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -24,6 +24,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "hw/sysbus-fdt.h"
 
 #define GIC_NUM_SPI_INTR 160
 
@@ -138,6 +139,7 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    const char *type_name;
 
     for (i = 0; i < num_apus; i++) {
         object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
@@ -150,12 +152,14 @@ static void xlnx_zynqmp_init(Object *obj)
     qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
-        object_initialize(&s->gem[i], sizeof(s->gem[i]), TYPE_CADENCE_GEM);
+        type_name = type_resolve_fdt_alias("cdns,zynqmp-gem");
+        object_initialize(&s->gem[i], sizeof(s->gem[i]), type_name);
         qdev_set_parent_bus(DEVICE(&s->gem[i]), sysbus_get_default());
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
-        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADENCE_UART);
+        type_name = type_resolve_fdt_alias("xlnx,zynqmp-uart");
+        object_initialize(&s->uart[i], sizeof(s->uart[i]), type_name);
         qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus_get_default());
     }
 
@@ -175,13 +179,15 @@ static void xlnx_zynqmp_init(Object *obj)
         qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
     }
 
-    object_initialize(&s->qspi, sizeof(s->qspi), TYPE_XLNX_ZYNQMP_QSPIPS);
+    type_name = type_resolve_fdt_alias("xlnx.zynq-qspi");
+    object_initialize(&s->qspi, sizeof(s->qspi), type_name);
     qdev_set_parent_bus(DEVICE(&s->qspi), sysbus_get_default());
 
     object_initialize(&s->dp, sizeof(s->dp), TYPE_XLNX_DP);
     qdev_set_parent_bus(DEVICE(&s->dp), sysbus_get_default());
 
-    object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
+    type_name = type_resolve_fdt_alias("xlnx,axi-dpdma-1.0");
+    object_initialize(&s->dpdma, sizeof(s->dpdma), type_name);
     qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
 }
 
-- 
2.15.1
