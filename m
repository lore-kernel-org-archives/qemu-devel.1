Received: from eggs.gnu.org ([209.51.188.92]:39518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevS-0008OY-R7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002sm-3Y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefe-0002iK-Nz
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:42 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so11831828wmc.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:08 +0000
Message-Id: <20190121185118.18550-14-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/23] hw/arm/armsse: Put each CPU in its own
 cluster object
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

Create a cluster object to hold each CPU in the SSE. They are
logically distinct and may be configured differently (for instance
one may not have an FPU where the other does).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  2 ++
 hw/arm/armsse.c         | 31 ++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 89f19a971f4..999c2e4f7e5 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -80,6 +80,7 @@
 #include "hw/misc/iotkit-sysinfo.h"
 #include "hw/or-irq.h"
 #include "hw/core/split-irq.h"
+#include "hw/cpu/cluster.h"
 
 #define TYPE_ARMSSE "arm-sse"
 #define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
@@ -110,6 +111,7 @@ typedef struct ARMSSE {
 
     /*< public >*/
     ARMv7MState armv7m[SSE_MAX_CPUS];
+    CPUClusterState cluster[SSE_MAX_CPUS];
     IoTKitSecCtl secctl;
     TZPPC apb_ppc0;
     TZPPC apb_ppc1;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 2472dfef3a1..2eb4ea3bfe0 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -147,9 +147,22 @@ static void armsse_init(Object *obj)
     memory_region_init(&s->container, obj, "armsse-container", UINT64_MAX);
 
     for (i = 0; i < info->num_cpus; i++) {
-        char *name = g_strdup_printf("armv7m%d", i);
-        sysbus_init_child_obj(obj, name, &s->armv7m[i], sizeof(s->armv7m),
-                              TYPE_ARMV7M);
+        /*
+         * We put each CPU in its own cluster as they are logically
+         * distinct and may be configured differently.
+         */
+        char *name;
+
+        name = g_strdup_printf("cluster%d", i);
+        object_initialize_child(obj, name, &s->cluster[i],
+                                sizeof(s->cluster[i]), TYPE_CPU_CLUSTER,
+                                &error_abort, NULL);
+        qdev_prop_set_uint32(DEVICE(&s->cluster[i]), "cluster-id", i);
+        g_free(name);
+
+        name = g_strdup_printf("armv7m%d", i);
+        sysbus_init_child_obj(OBJECT(&s->cluster[i]), name,
+                              &s->armv7m[i], sizeof(s->armv7m), TYPE_ARMV7M);
         qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
                              ARM_CPU_TYPE_NAME("cortex-m33"));
         g_free(name);
@@ -406,6 +419,18 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
+        /*
+         * The cluster must be realized after the armv7m container, as
+         * the container's CPU object is only created on realize, and the
+         * CPU must exist and have been parented into the cluster before
+         * the cluster is realized.
+         */
+        object_property_set_bool(OBJECT(&s->cluster[i]),
+                                 true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
 
         /* Connect EXP_IRQ/EXP_CPUn_IRQ GPIOs to the NVIC's lines 32 and up */
         s->exp_irqs[i] = g_new(qemu_irq, s->exp_numirq);
-- 
2.20.1
