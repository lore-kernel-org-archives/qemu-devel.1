Received: from eggs.gnu.org ([209.51.188.92]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0008Fy-5C
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMA-0003ho-1T
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003Ml-Ne
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id m1so6662611wml.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:25 +0000
Message-Id: <20190201160653.13829-20-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/47] hw/arm/armsse: Add unimplemented-device
 stub for CPU local control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The SSE-200 has a "CPU local security control" register bank; add an
unimplemented-device stub for it. (The register bank has only one
interesting register, which allows the guest to lock down changes
to various CPU registers so they cannot be modified further. We
don't support that in our Cortex-M33 model anyway.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-19-peter.maydell@linaro.org
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
