Received: from eggs.gnu.org ([209.51.188.92]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevR-00081G-Lf
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefg-0002vd-Jw
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefg-0002uC-9b
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:44 -0500
Received: by mail-wm1-x344.google.com with SMTP id r24so6819237wmh.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:15 +0000
Message-Id: <20190121185118.18550-21-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/23] hw/arm/armsse: Add CPU_IDENTITY block to
 SSE-200
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

Instantiate a copy of the CPU_IDENTITY register block for each CPU
in an SSE-200.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  3 +++
 hw/arm/armsse.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 961dbb3032a..3914e8e4bf2 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -78,6 +78,7 @@
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/misc/iotkit-sysctl.h"
 #include "hw/misc/iotkit-sysinfo.h"
+#include "hw/misc/armsse-cpuid.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
@@ -153,6 +154,8 @@ typedef struct ARMSSE {
     UnimplementedDeviceState cachectrl[SSE_MAX_CPUS];
     UnimplementedDeviceState cpusecctrl[SSE_MAX_CPUS];
 
+    ARMSSECPUID cpuid[SSE_MAX_CPUS];
+
     /*
      * 'container' holds all devices seen by all CPUs.
      * 'cpu_container[i]' is the view that CPU i has: this has the
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 9c111ac6a40..eb691faf720 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -34,6 +34,7 @@ struct ARMSSEInfo {
     bool has_ppus;
     bool has_cachectrl;
     bool has_cpusecctrl;
+    bool has_cpuid;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -47,6 +48,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_ppus = false,
         .has_cachectrl = false,
         .has_cpusecctrl = false,
+        .has_cpuid = false,
     },
 };
 
@@ -314,6 +316,16 @@ static void armsse_init(Object *obj)
             g_free(name);
         }
     }
+    if (info->has_cpuid) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("cpuid%d", i);
+
+            sysbus_init_child_obj(obj, name, &s->cpuid[i],
+                                  sizeof(s->cpuid[i]),
+                                  TYPE_ARMSSE_CPUID);
+            g_free(name);
+        }
+    }
     object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
                             sizeof(s->nmi_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -864,6 +876,22 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             memory_region_add_subregion(&s->cpu_container[i], 0x50011000, mr);
         }
     }
+    if (info->has_cpuid) {
+        for (i = 0; i < info->num_cpus; i++) {
+            MemoryRegion *mr;
+
+            qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
+            object_property_set_bool(OBJECT(&s->cpuid[i]), true,
+                                     "realized", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+
+            mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpuid[i]), 0);
+            memory_region_add_subregion(&s->cpu_container[i], 0x4001F000, mr);
+        }
+    }
 
     /* 0x40020000 .. 0x4002ffff : ARMSSE system control peripheral region */
     /* Devices behind APB PPC1:
-- 
2.20.1
