Received: from eggs.gnu.org ([209.51.188.92]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMC-0008Fe-Qu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003hN-SI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003Ku-Hd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id t200so6821043wmt.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:19 +0000
Message-Id: <20190201160653.13829-14-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/47] hw/arm/armsse: Give each CPU its own view
 of memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Give each CPU its own container memory region. This is necessary
for two reasons:
 * some devices are instantiated one per CPU and the CPU sees only
   its own device
 * since a memory region can only be put into one container, we must
   give each armv7m object a different MemoryRegion as its 'memory'
   property, or a dual-CPU configuration will assert on realize when
   the second armv7m object tries to put the MR into a container when
   it is already in the first armv7m object's container

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-13-peter.maydell@linaro.org
---
 include/hw/arm/armsse.h | 10 ++++++++++
 hw/arm/armsse.c         | 22 ++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index faf5dfed252..89f19a971f4 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -135,7 +135,17 @@ typedef struct ARMSSE {
     IoTKitSysCtl sysctl;
     IoTKitSysCtl sysinfo;
 
+    /*
+     * 'container' holds all devices seen by all CPUs.
+     * 'cpu_container[i]' is the view that CPU i has: this has the
+     * per-CPU devices of that CPU, plus as the background 'container'
+     * (or an alias of it, since we can only use it directly once).
+     * container_alias[i] is the alias of 'container' used by CPU i+1;
+     * CPU 0 can use 'container' directly.
+     */
     MemoryRegion container;
+    MemoryRegion container_alias[SSE_MAX_CPUS - 1];
+    MemoryRegion cpu_container[SSE_MAX_CPUS];
     MemoryRegion alias1;
     MemoryRegion alias2;
     MemoryRegion alias3;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 5cb2b78b1fc..2472dfef3a1 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -153,6 +153,15 @@ static void armsse_init(Object *obj)
         qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
                              ARM_CPU_TYPE_NAME("cortex-m33"));
         g_free(name);
+        name = g_strdup_printf("arm-sse-cpu-container%d", i);
+        memory_region_init(&s->cpu_container[i], obj, name, UINT64_MAX);
+        g_free(name);
+        if (i > 0) {
+            name = g_strdup_printf("arm-sse-container-alias%d", i);
+            memory_region_init_alias(&s->container_alias[i - 1], obj,
+                                     name, &s->container, 0, UINT64_MAX);
+            g_free(name);
+        }
     }
 
     sysbus_init_child_obj(obj, "secctl", &s->secctl, sizeof(s->secctl),
@@ -332,7 +341,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * 0x50000000..0x5fffffff  alias of 0x40000000..0x4fffffff
      */
 
-    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
+    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -2);
 
     for (i = 0; i < info->num_cpus; i++) {
         DeviceState *cpudev = DEVICE(&s->armv7m[i]);
@@ -373,7 +382,16 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 return;
             }
         }
-        object_property_set_link(cpuobj, OBJECT(&s->container), "memory", &err);
+
+        if (i > 0) {
+            memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
+                                                &s->container_alias[i - 1], -1);
+        } else {
+            memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
+                                                &s->container, -1);
+        }
+        object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
+                                 "memory", &err);
         if (err) {
             error_propagate(errp, err);
             return;
-- 
2.20.1
