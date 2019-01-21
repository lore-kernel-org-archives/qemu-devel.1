Received: from eggs.gnu.org ([209.51.188.92]:39234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevR-0008Da-WD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002ti-GT
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002r1-1w
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so24610847wrt.7
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:12 +0000
Message-Id: <20190121185118.18550-18-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/23] hw/arm/armsse: Add unimplemented-device
 stub for cache control registers
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

The SSE-200 gives each CPU a register bank to use to control its
L1 instruction cache. Put in an unimplemented-device stub for this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  1 +
 hw/arm/armsse.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 9855ec5f269..9d830057d5c 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -150,6 +150,7 @@ typedef struct ARMSSE {
 
     UnimplementedDeviceState mhu[2];
     UnimplementedDeviceState ppu[NUM_PPUS];
+    UnimplementedDeviceState cachectrl[SSE_MAX_CPUS];
 
     /*
      * 'container' holds all devices seen by all CPUs.
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 280ba5c78be..41e4a781e11 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -32,6 +32,7 @@ struct ARMSSEInfo {
     SysConfigFormat sys_config_format;
     bool has_mhus;
     bool has_ppus;
+    bool has_cachectrl;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -43,6 +44,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .sys_config_format = IoTKitFormat,
         .has_mhus = false,
         .has_ppus = false,
+        .has_cachectrl = false,
     },
 };
 
@@ -290,6 +292,16 @@ static void armsse_init(Object *obj)
             g_free(name);
         }
     }
+    if (info->has_cachectrl) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("cachectrl%d", i);
+
+            sysbus_init_child_obj(obj, name, &s->cachectrl[i],
+                                  sizeof(s->cachectrl[i]),
+                                  TYPE_UNIMPLEMENTED_DEVICE);
+            g_free(name);
+        }
+    }
     object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
                             sizeof(s->nmi_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -795,7 +807,32 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(DEVICE(&s->ppc_irq_orgate), 0,
                           armsse_get_common_irq_in(s, 10));
 
-    /* 0x40010000 .. 0x4001ffff: private CPU region: unused in IoTKit */
+    /*
+     * 0x40010000 .. 0x4001ffff (and the 0x5001000... secure-only alias):
+     * private per-CPU region (all these devices are SSE-200 only):
+     *  0x50010000: L1 icache control registers
+     *  0x50011000: CPUSECCTRL (CPU local security control registers)
+     *  0x4001f000 and 0x5001f000: CPU_IDENTITY register block
+     */
+    if (info->has_cachectrl) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("cachectrl%d", i);
+            MemoryRegion *mr;
+
+            qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
+            g_free(name);
+            qdev_prop_set_uint64(DEVICE(&s->cachectrl[i]), "size", 0x1000);
+            object_property_set_bool(OBJECT(&s->cachectrl[i]), true,
+                                     "realized", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+
+            mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cachectrl[i]), 0);
+            memory_region_add_subregion(&s->cpu_container[i], 0x50010000, mr);
+        }
+    }
 
     /* 0x40020000 .. 0x4002ffff : ARMSSE system control peripheral region */
     /* Devices behind APB PPC1:
-- 
2.20.1
