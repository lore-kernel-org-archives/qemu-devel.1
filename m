Received: from eggs.gnu.org ([209.51.188.92]:39097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevS-000888-D0
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002uI-Mt
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002rQ-Bb
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id j2so24705781wrw.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:13 +0000
Message-Id: <20190121185118.18550-19-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/23] hw/arm/armsse: Add unimplemented-device
 stub for CPU local control registers
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

The SSE-200 has a "CPU local security control" register bank; add an
unimplemented-device stub for it. (The register bank has only one
interesting register, which allows the guest to lock down changes
to various CPU registers so they cannot be modified further. We
don't support that in our Cortex-M33 model anyway.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h |  1 +
 hw/arm/armsse.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 9d830057d5c..961dbb3032a 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -151,6 +151,7 @@ typedef struct ARMSSE {
     UnimplementedDeviceState mhu[2];
     UnimplementedDeviceState ppu[NUM_PPUS];
     UnimplementedDeviceState cachectrl[SSE_MAX_CPUS];
+    UnimplementedDeviceState cpusecctrl[SSE_MAX_CPUS];
 
     /*
      * 'container' holds all devices seen by all CPUs.
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 41e4a781e11..9c111ac6a40 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -33,6 +33,7 @@ struct ARMSSEInfo {
     bool has_mhus;
     bool has_ppus;
     bool has_cachectrl;
+    bool has_cpusecctrl;
 };
 
 static const ARMSSEInfo armsse_variants[] = {
@@ -45,6 +46,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_mhus = false,
         .has_ppus = false,
         .has_cachectrl = false,
+        .has_cpusecctrl = false,
     },
 };
 
@@ -302,6 +304,16 @@ static void armsse_init(Object *obj)
             g_free(name);
         }
     }
+    if (info->has_cpusecctrl) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("cpusecctrl%d", i);
+
+            sysbus_init_child_obj(obj, name, &s->cpusecctrl[i],
+                                  sizeof(s->cpusecctrl[i]),
+                                  TYPE_UNIMPLEMENTED_DEVICE);
+            g_free(name);
+        }
+    }
     object_initialize_child(obj, "nmi-orgate", &s->nmi_orgate,
                             sizeof(s->nmi_orgate), TYPE_OR_IRQ,
                             &error_abort, NULL);
@@ -833,6 +845,25 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             memory_region_add_subregion(&s->cpu_container[i], 0x50010000, mr);
         }
     }
+    if (info->has_cpusecctrl) {
+        for (i = 0; i < info->num_cpus; i++) {
+            char *name = g_strdup_printf("CPUSECCTRL%d", i);
+            MemoryRegion *mr;
+
+            qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
+            g_free(name);
+            qdev_prop_set_uint64(DEVICE(&s->cpusecctrl[i]), "size", 0x1000);
+            object_property_set_bool(OBJECT(&s->cpusecctrl[i]), true,
+                                     "realized", &err);
+            if (err) {
+                error_propagate(errp, err);
+                return;
+            }
+
+            mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpusecctrl[i]), 0);
+            memory_region_add_subregion(&s->cpu_container[i], 0x50011000, mr);
+        }
+    }
 
     /* 0x40020000 .. 0x4002ffff : ARMSSE system control peripheral region */
     /* Devices behind APB PPC1:
-- 
2.20.1
