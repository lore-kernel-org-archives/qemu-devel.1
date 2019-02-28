Received: from eggs.gnu.org ([209.51.188.92]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYt-0001LT-CG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYn-0003cy-6K
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYm-0003GD-Uz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:05 -0500
Received: by mail-wm1-x344.google.com with SMTP id y15so8528011wma.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:08:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:08:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:21 +0000
Message-Id: <20190228110835.16159-3-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/16] hw/arm/armsse: Wire up the MHUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create and connect the MHUs in the SSE-200.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-3-peter.maydell@linaro.org
---
 include/hw/arm/armsse.h |  3 ++-
 hw/arm/armsse.c         | 40 ++++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 7ef871c7dfe..81e082cccf8 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -95,6 +95,7 @@
 #include "hw/misc/iotkit-sysctl.h"
 #include "hw/misc/iotkit-sysinfo.h"
 #include "hw/misc/armsse-cpuid.h"
+#include "hw/misc/armsse-mhu.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
@@ -166,7 +167,7 @@ typedef struct ARMSSE {
     IoTKitSysCtl sysctl;
     IoTKitSysCtl sysinfo;
 
-    UnimplementedDeviceState mhu[2];
+    ARMSSEMHU mhu[2];
     UnimplementedDeviceState ppu[NUM_PPUS];
     UnimplementedDeviceState cachectrl[SSE_MAX_CPUS];
     UnimplementedDeviceState cpusecctrl[SSE_MAX_CPUS];
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 129e7ea7fe0..97e3d5e807e 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -282,9 +282,9 @@ static void armsse_init(Object *obj)
                           sizeof(s->sysinfo), TYPE_IOTKIT_SYSINFO);
     if (info->has_mhus) {
         sysbus_init_child_obj(obj, "mhu0", &s->mhu[0], sizeof(s->mhu[0]),
-                              TYPE_UNIMPLEMENTED_DEVICE);
+                              TYPE_ARMSSE_MHU);
         sysbus_init_child_obj(obj, "mhu1", &s->mhu[1], sizeof(s->mhu[1]),
-                              TYPE_UNIMPLEMENTED_DEVICE);
+                              TYPE_ARMSSE_MHU);
     }
     if (info->has_ppus) {
         for (i = 0; i < info->num_cpus; i++) {
@@ -766,22 +766,28 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     if (info->has_mhus) {
-        for (i = 0; i < ARRAY_SIZE(s->mhu); i++) {
-            char *name;
-            char *port;
+        /*
+         * An SSE-200 with only one CPU should have only one MHU created,
+         * with the region where the second MHU usually is being RAZ/WI.
+         * We don't implement that SSE-200 config; if we want to support
+         * it then this code needs to be enhanced to handle creating the
+         * RAZ/WI region instead of the second MHU.
+         */
+        assert(info->num_cpus == ARRAY_SIZE(s->mhu));
+
+        for (i = 0; i < ARRAY_SIZE(s->mhu); i++) {
+            char *port;
+            int cpunum;
+            SysBusDevice *mhu_sbd = SYS_BUS_DEVICE(&s->mhu[i]);
 
-            name = g_strdup_printf("MHU%d", i);
-            qdev_prop_set_string(DEVICE(&s->mhu[i]), "name", name);
-            qdev_prop_set_uint64(DEVICE(&s->mhu[i]), "size", 0x1000);
             object_property_set_bool(OBJECT(&s->mhu[i]), true,
                                      "realized", &err);
-            g_free(name);
             if (err) {
                 error_propagate(errp, err);
                 return;
             }
             port = g_strdup_printf("port[%d]", i + 3);
-            mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mhu[i]), 0);
+            mr = sysbus_mmio_get_region(mhu_sbd, 0);
             object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr),
                                      port, &err);
             g_free(port);
@@ -789,6 +795,20 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 error_propagate(errp, err);
                 return;
             }
+
+            /*
+             * Each MHU has an irq line for each CPU:
+             *  MHU 0 irq line 0 -> CPU 0 IRQ 6
+             *  MHU 0 irq line 1 -> CPU 1 IRQ 6
+             *  MHU 1 irq line 0 -> CPU 0 IRQ 7
+             *  MHU 1 irq line 1 -> CPU 1 IRQ 7
+             */
+            for (cpunum = 0; cpunum < info->num_cpus; cpunum++) {
+                DeviceState *cpudev = DEVICE(&s->armv7m[cpunum]);
+
+                sysbus_connect_irq(mhu_sbd, cpunum,
+                                   qdev_get_gpio_in(cpudev, 6 + i));
+            }
         }
     }
 
-- 
2.20.1
