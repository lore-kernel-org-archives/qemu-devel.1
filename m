Received: from eggs.gnu.org ([209.51.188.92]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevU-0008Da-D5
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefa-0002qQ-MP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefY-0002e8-V7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so24610974wra.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:04 +0000
Message-Id: <20190121185118.18550-10-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/23] hw/arm/armsse: Make number of SRAM banks
 parameterised
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

The SSE-200 has four banks of SRAM, each with its own
Memory Protection Controller, where the IoTKit has only one.
Make the number of SRAM banks a field in ARMSSEInfo.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  9 +++--
 hw/arm/armsse.c         | 78 ++++++++++++++++++++++++++---------------
 2 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index ff512054988..99714aa63cd 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -90,6 +90,11 @@
 #define NUM_EXTERNAL_PPCS (IOTS_NUM_AHB_EXP_PPC + IOTS_NUM_APB_EXP_PPC)
 #define NUM_PPCS (NUM_EXTERNAL_PPCS + 2)
 
+#define MAX_SRAM_BANKS 4
+#if MAX_SRAM_BANKS > IOTS_NUM_MPC
+#error Too many SRAM banks
+#endif
+
 typedef struct ARMSSE {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -99,7 +104,7 @@ typedef struct ARMSSE {
     IoTKitSecCtl secctl;
     TZPPC apb_ppc0;
     TZPPC apb_ppc1;
-    TZMPC mpc;
+    TZMPC mpc[IOTS_NUM_MPC];
     CMSDKAPBTIMER timer0;
     CMSDKAPBTIMER timer1;
     CMSDKAPBTIMER s32ktimer;
@@ -123,7 +128,7 @@ typedef struct ARMSSE {
     MemoryRegion alias1;
     MemoryRegion alias2;
     MemoryRegion alias3;
-    MemoryRegion sram0;
+    MemoryRegion sram[MAX_SRAM_BANKS];
 
     qemu_irq *exp_irqs;
     qemu_irq ppc0_irq;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 074c1d3a6cf..b639b54e0db 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -20,11 +20,13 @@
 
 struct ARMSSEInfo {
     const char *name;
+    int sram_banks;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
     {
         .name = TYPE_IOTKIT,
+        .sram_banks = 1,
     },
 };
 
@@ -118,8 +120,12 @@ static void armsse_forward_sec_resp_cfg(ARMSSE *s)
 static void armsse_init(Object *obj)
 {
     ARMSSE *s = ARMSSE(obj);
+    ARMSSEClass *asc = ARMSSE_GET_CLASS(obj);
+    const ARMSSEInfo *info = asc->info;
     int i;
 
+    assert(info->sram_banks <= MAX_SRAM_BANKS);
+
     memory_region_init(&s->container, obj, "armsse-container", UINT64_MAX);
 
     sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
@@ -133,12 +139,17 @@ static void armsse_init(Object *obj)
                           TYPE_TZ_PPC);
     sysbus_init_child_obj(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
                           TYPE_TZ_PPC);
-    sysbus_init_child_obj(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
+    for (i = 0; i < info->sram_banks; i++) {
+        char *name = g_strdup_printf("mpc%d", i);
+        sysbus_init_child_obj(obj, name, &s->mpc[i],
+                              sizeof(s->mpc[i]), TYPE_TZ_MPC);
+        g_free(name);
+    }
     object_initialize_child(obj, "mpc-irq-orgate", &s->mpc_irq_orgate,
                             sizeof(s->mpc_irq_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
 
-    for (i = 0; i < IOTS_NUM_EXP_MPC + 1; i++) {
+    for (i = 0; i < IOTS_NUM_EXP_MPC + info->sram_banks; i++) {
         char *name = g_strdup_printf("mpc-irq-splitter-%d", i);
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
 
@@ -199,6 +210,8 @@ static void armsse_mpcexp_status(void *opaque, int n, int level)
 static void armsse_realize(DeviceState *dev, Error **errp)
 {
     ARMSSE *s = ARMSSE(dev);
+    ARMSSEClass *asc = ARMSSE_GET_CLASS(dev);
+    const ARMSSEInfo *info = asc->info;
     int i;
     MemoryRegion *mr;
     Error *err = NULL;
@@ -335,35 +348,41 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out_named(dev_secctl, "sec_resp_cfg", 0,
                                 qdev_get_gpio_in(dev_splitter, 0));
 
-    /* This RAM lives behind the Memory Protection Controller */
-    memory_region_init_ram(&s->sram0, NULL, "armsse.sram0", 0x00008000, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    /* Each SRAM bank lives behind its own Memory Protection Controller */
+    for (i = 0; i < info->sram_banks; i++) {
+        char *ramname = g_strdup_printf("armsse.sram%d", i);
+        SysBusDevice *sbd_mpc;
+
+        memory_region_init_ram(&s->sram[i], NULL, ramname, 0x00008000, &err);
+        g_free(ramname);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
+                                 "downstream", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_property_set_bool(OBJECT(&s->mpc[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        /* Map the upstream end of the MPC into the right place... */
+        sbd_mpc = SYS_BUS_DEVICE(&s->mpc[i]);
+        memory_region_add_subregion(&s->container, 0x20000000 + i * 0x8000,
+                                    sysbus_mmio_get_region(sbd_mpc, 1));
+        /* ...and its register interface */
+        memory_region_add_subregion(&s->container, 0x50083000 + i * 0x1000,
+                                    sysbus_mmio_get_region(sbd_mpc, 0));
     }
-    object_property_set_link(OBJECT(&s->mpc), OBJECT(&s->sram0),
-                             "downstream", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    object_property_set_bool(OBJECT(&s->mpc), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    /* Map the upstream end of the MPC into the right place... */
-    memory_region_add_subregion(&s->container, 0x20000000,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mpc),
-                                                       1));
-    /* ...and its register interface */
-    memory_region_add_subregion(&s->container, 0x50083000,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mpc),
-                                                       0));
 
     /* We must OR together lines from the MPC splitters to go to the NVIC */
     object_property_set_int(OBJECT(&s->mpc_irq_orgate),
-                            IOTS_NUM_EXP_MPC + 1, "num-lines", &err);
+                            IOTS_NUM_EXP_MPC + info->sram_banks,
+                            "num-lines", &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -636,7 +655,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up the splitters for the MPC IRQs */
-    for (i = 0; i < IOTS_NUM_EXP_MPC + 1; i++) {
+    for (i = 0; i < IOTS_NUM_EXP_MPC + info->sram_banks; i++) {
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
         DeviceState *dev_splitter = DEVICE(splitter);
 
@@ -659,7 +678,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                                                          "mpcexp_status", i));
         } else {
             /* Splitter input is from our own MPC */
-            qdev_connect_gpio_out_named(DEVICE(&s->mpc), "irq", 0,
+            qdev_connect_gpio_out_named(DEVICE(&s->mpc[i - IOTS_NUM_EXP_MPC]),
+                                        "irq", 0,
                                         qdev_get_gpio_in(dev_splitter, 0));
             qdev_connect_gpio_out(dev_splitter, 0,
                                   qdev_get_gpio_in_named(dev_secctl,
-- 
2.20.1
