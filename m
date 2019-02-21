Received: from eggs.gnu.org ([209.51.188.92]:52319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXv-000071-7r
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXu-0007XS-1W
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:11 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXt-0007Wv-PD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id h22so7303743wmb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:58:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.58.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:58:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:39 +0000
Message-Id: <20190221185739.25362-22-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/21] hw/arm/armsse: Make 0x5... alias region
 work for per-CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The region 0x40010000 .. 0x4001ffff and its secure-only alias
at 0x50010000... are for per-CPU devices. We implement this by
giving each CPU its own container memory region, where the
per-CPU devices live. Unfortunately, the alias region which
makes devices mapped at 0x4... addresses also appear at 0x5...
is only implemented in the overall "all CPUs" container. The
effect of this bug is that the CPU_IDENTITY register block appears
only at 0x4001f000, but not at the 0x5001f000 alias where it should
also appear. Guests (like very recent Arm Trusted Firmware-M)
which try to access it at 0x5001f000 will crash.

Fix this by moving the handling for this alias from the "all CPUs"
container to the per-CPU container. (We leave the aliases for
0x1... and 0x3... in the overall container, because there are
no per-CPU devices there.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190215180500.6906-1-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/armsse.h |  2 +-
 hw/arm/armsse.c         | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 84879f40dd8..7ef871c7dfe 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -186,7 +186,7 @@ typedef struct ARMSSE {
     MemoryRegion cpu_container[SSE_MAX_CPUS];
     MemoryRegion alias1;
     MemoryRegion alias2;
-    MemoryRegion alias3;
+    MemoryRegion alias3[SSE_MAX_CPUS];
     MemoryRegion sram[MAX_SRAM_BANKS];
 
     qemu_irq *exp_irqs[SSE_MAX_CPUS];
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 50da41f64c5..129e7ea7fe0 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -110,15 +110,16 @@ static bool irq_is_common[32] = {
     /* 30, 31: reserved */
 };
 
-/* Create an alias region of @size bytes starting at @base
+/*
+ * Create an alias region in @container of @size bytes starting at @base
  * which mirrors the memory starting at @orig.
  */
-static void make_alias(ARMSSE *s, MemoryRegion *mr, const char *name,
-                       hwaddr base, hwaddr size, hwaddr orig)
+static void make_alias(ARMSSE *s, MemoryRegion *mr, MemoryRegion *container,
+                       const char *name, hwaddr base, hwaddr size, hwaddr orig)
 {
-    memory_region_init_alias(mr, NULL, name, &s->container, orig, size);
+    memory_region_init_alias(mr, NULL, name, container, orig, size);
     /* The alias is even lower priority than unimplemented_device regions */
-    memory_region_add_subregion_overlap(&s->container, base, mr, -1500);
+    memory_region_add_subregion_overlap(container, base, mr, -1500);
 }
 
 static void irq_status_forwarder(void *opaque, int n, int level)
@@ -607,16 +608,21 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Set up the big aliases first */
-    make_alias(s, &s->alias1, "alias 1", 0x10000000, 0x10000000, 0x00000000);
-    make_alias(s, &s->alias2, "alias 2", 0x30000000, 0x10000000, 0x20000000);
+    make_alias(s, &s->alias1, &s->container, "alias 1",
+               0x10000000, 0x10000000, 0x00000000);
+    make_alias(s, &s->alias2, &s->container,
+               "alias 2", 0x30000000, 0x10000000, 0x20000000);
     /* The 0x50000000..0x5fffffff region is not a pure alias: it has
      * a few extra devices that only appear there (generally the
      * control interfaces for the protection controllers).
      * We implement this by mapping those devices over the top of this
-     * alias MR at a higher priority.
+     * alias MR at a higher priority. Some of the devices in this range
+     * are per-CPU, so we must put this alias in the per-cpu containers.
      */
-    make_alias(s, &s->alias3, "alias 3", 0x50000000, 0x10000000, 0x40000000);
-
+    for (i = 0; i < info->num_cpus; i++) {
+        make_alias(s, &s->alias3[i], &s->cpu_container[i],
+                   "alias 3", 0x50000000, 0x10000000, 0x40000000);
+    }
 
     /* Security controller */
     object_property_set_bool(OBJECT(&s->secctl), true, "realized", &err);
-- 
2.20.1
