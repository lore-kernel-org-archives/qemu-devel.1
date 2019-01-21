Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevR-0008OH-Fz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002u5-LZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002qf-2P
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id 96so24652761wrb.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:11 +0000
Message-Id: <20190121185118.18550-17-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/23] hw/arm/armsse: Add unimplemented-device
 stubs for PPUs
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

Add unimplemented-device stubs for the various Power Policy Unit
devices that the SSE-200 has.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h | 11 ++++++++
 hw/arm/armsse.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index dbfcb280605..9855ec5f269 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -106,6 +106,16 @@
 
 #define SSE_MAX_CPUS 2
 
+/* These define what each PPU in the ppu[] index is for */
+#define CPU0CORE_PPU 0
+#define CPU1CORE_PPU 1
+#define DBG_PPU 2
+#define RAM0_PPU 3
+#define RAM1_PPU 4
+#define RAM2_PPU 5
+#define RAM3_PPU 6
+#define NUM_PPUS 7
+
 typedef struct ARMSSE {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -139,6 +149,7 @@ typedef struct ARMSSE {
     IoTKitSysCtl sysinfo;
 
     UnimplementedDeviceState mhu[2];
+    UnimplementedDeviceState ppu[NUM_PPUS];
 
     /*
      * 'container' holds all devices seen by all CPUs.
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 1f3dc89c8e8..280ba5c78be 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -31,6 +31,7 @@ struct ARMSSEInfo {
     uint32_t sys_version;
     SysConfigFormat sys_config_format;
     bool has_mhus;
+    bool has_ppus;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -41,6 +42,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .sys_version = 0x41743,
         .sys_config_format = IoTKitFormat,
         .has_mhus = false,
+        .has_ppus = false,
     },
 };
 
@@ -265,6 +267,29 @@ static void armsse_init(Object *obj)
         sysbus_init_child_obj(obj, "mhu1", &s->mhu[1], sizeof(s->mhu[1]),
                               TYPE_UNIMPLEMENTED_DEVICE);
     }
+    if (info->has_ppus) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("CPU%dCORE_PPU", i);
+            int ppuidx = CPU0CORE_PPU + i;
+
+            sysbus_init_child_obj(obj, name, &s->ppu[ppuidx],
+                                  sizeof(s->ppu[ppuidx]),
+                                  TYPE_UNIMPLEMENTED_DEVICE);
+            g_free(name);
+        }
+        sysbus_init_child_obj(obj, "DBG_PPU", &s->ppu[DBG_PPU],
+                              sizeof(s->ppu[DBG_PPU]),
+                              TYPE_UNIMPLEMENTED_DEVICE);
+        for (i = 0; i < info->sram_banks; i++) {
+            char *name = g_strdup_printf("RAM%d_PPU", i);
+            int ppuidx = RAM0_PPU + i;
+
+            sysbus_init_child_obj(obj, name, &s->ppu[ppuidx],
+                                  sizeof(s->ppu[ppuidx]),
+                                  TYPE_UNIMPLEMENTED_DEVICE);
+            g_free(name);
+        }
+    }
     object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
                             sizeof(s->nmi_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -329,6 +354,17 @@ static qemu_irq armsse_get_common_irq_in(ARMSSE *s, int irqno)
     }
 }
 
+static void map_ppu(ARMSSE *s, int ppuidx, const char *name, hwaddr addr)
+{
+    /* Map a PPU unimplemented device stub */
+    DeviceState *dev = DEVICE(&s->ppu[ppuidx]);
+
+    qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_uint64(dev, "size", 0x1000);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ppu[ppuidx]), 0, addr);
+}
+
 static void armsse_realize(DeviceState *dev, Error **errp)
 {
     ARMSSE *s = ARMSSE(dev);
@@ -833,6 +869,28 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x50021000);
 
+    if (info->has_ppus) {
+        /* CPUnCORE_PPU for each CPU */
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("CPU%dCORE_PPU", i);
+
+            map_ppu(s, CPU0CORE_PPU + i, name, 0x50023000 + i * 0x2000);
+            /*
+             * We don't support CPU debug so don't create the
+             * CPU0DEBUG_PPU at 0x50024000 and 0x50026000.
+             */
+            g_free(name);
+        }
+        map_ppu(s, DBG_PPU, "DBG_PPU", 0x50029000);
+
+        for (i = 0; i < info->sram_banks; i++) {
+            char *name = g_strdup_printf("RAM%d_PPU", i);
+
+            map_ppu(s, RAM0_PPU + i, name, 0x5002a000 + i * 0x1000);
+            g_free(name);
+        }
+    }
+
     /* This OR gate wires together outputs from the secure watchdogs to NMI */
     object_property_set_int(OBJECT(&s->nmi_orgate), 2, "num-lines", &err);
     if (err) {
-- 
2.20.1
