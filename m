Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWq-00051C-0s
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWo-0008DQ-Kh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWo-0008CR-Az
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWn-0007px-DF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:09 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:36 +0000
Message-Id: <1513188761-20784-39-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 38/43] nvic: Make systick banked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For the v8M security extension, there should be two systick
devices, which use separate banked systick exceptions. The
register interface is banked in the same way as for other
banked registers, including the existence of an NS alias
region for secure code to access the nonsecure timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1512154296-5652-3-git-send-email-peter.maydell@linaro.org
---
 include/hw/intc/armv7m_nvic.h |  4 +-
 hw/intc/armv7m_nvic.c         | 90 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index ac7997c..8bc2911 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -78,13 +78,15 @@ typedef struct NVICState {
 
     MemoryRegion sysregmem;
     MemoryRegion sysreg_ns_mem;
+    MemoryRegion systickmem;
+    MemoryRegion systick_ns_mem;
     MemoryRegion container;
 
     uint32_t num_irq;
     qemu_irq excpout;
     qemu_irq sysresetreq;
 
-    SysTickState systick;
+    SysTickState systick[M_REG_NUM_BANKS];
 } NVICState;
 
 #endif
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 63f2743..dd49b6c 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1827,6 +1827,36 @@ static const MemoryRegionOps nvic_sysreg_ns_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    NVICState *s = opaque;
+    MemoryRegion *mr;
+
+    /* Direct the access to the correct systick */
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
+    return memory_region_dispatch_write(mr, addr, value, size, attrs);
+}
+
+static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    NVICState *s = opaque;
+    MemoryRegion *mr;
+
+    /* Direct the access to the correct systick */
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
+    return memory_region_dispatch_read(mr, addr, data, size, attrs);
+}
+
+static const MemoryRegionOps nvic_systick_ops = {
+    .read_with_attrs = nvic_systick_read,
+    .write_with_attrs = nvic_systick_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
 static int nvic_post_load(void *opaque, int version_id)
 {
     NVICState *s = opaque;
@@ -2005,17 +2035,16 @@ static void nvic_systick_trigger(void *opaque, int n, int level)
         /* SysTick just asked us to pend its exception.
          * (This is different from an external interrupt line's
          * behaviour.)
-         * TODO: when we implement the banked systicks we must make
-         * this pend the correct banked exception.
+         * n == 0 : NonSecure systick
+         * n == 1 : Secure systick
          */
-        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK, false);
+        armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK, n);
     }
 }
 
 static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
     NVICState *s = NVIC(dev);
-    SysBusDevice *systick_sbd;
     Error *err = NULL;
     int regionlen;
 
@@ -2032,14 +2061,35 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* include space for internal exception vectors */
     s->num_irq += NVIC_FIRST_IRQ;
 
-    object_property_set_bool(OBJECT(&s->systick), true, "realized", &err);
+    object_property_set_bool(OBJECT(&s->systick[M_REG_NS]), true,
+                             "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
-    systick_sbd = SYS_BUS_DEVICE(&s->systick);
-    sysbus_connect_irq(systick_sbd, 0,
-                       qdev_get_gpio_in_named(dev, "systick-trigger", 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), 0,
+                       qdev_get_gpio_in_named(dev, "systick-trigger",
+                                              M_REG_NS));
+
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
+        /* We couldn't init the secure systick device in instance_init
+         * as we didn't know then if the CPU had the security extensions;
+         * so we have to do it here.
+         */
+        object_initialize(&s->systick[M_REG_S], sizeof(s->systick[M_REG_S]),
+                          TYPE_SYSTICK);
+        qdev_set_parent_bus(DEVICE(&s->systick[M_REG_S]), sysbus_get_default());
+
+        object_property_set_bool(OBJECT(&s->systick[M_REG_S]), true,
+                                 "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_S]), 0,
+                           qdev_get_gpio_in_named(dev, "systick-trigger",
+                                                  M_REG_S));
+    }
 
     /* The NVIC and System Control Space (SCS) starts at 0xe000e000
      * and looks like this:
@@ -2073,15 +2123,24 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->sysregmem, OBJECT(s), &nvic_sysreg_ops, s,
                           "nvic_sysregs", 0x1000);
     memory_region_add_subregion(&s->container, 0, &s->sysregmem);
+
+    memory_region_init_io(&s->systickmem, OBJECT(s),
+                          &nvic_systick_ops, s,
+                          "nvic_systick", 0xe0);
+
     memory_region_add_subregion_overlap(&s->container, 0x10,
-                                        sysbus_mmio_get_region(systick_sbd, 0),
-                                        1);
+                                        &s->systickmem, 1);
 
     if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
         memory_region_init_io(&s->sysreg_ns_mem, OBJECT(s),
                               &nvic_sysreg_ns_ops, &s->sysregmem,
                               "nvic_sysregs_ns", 0x1000);
         memory_region_add_subregion(&s->container, 0x20000, &s->sysreg_ns_mem);
+        memory_region_init_io(&s->systick_ns_mem, OBJECT(s),
+                              &nvic_sysreg_ns_ops, &s->systickmem,
+                              "nvic_systick_ns", 0xe0);
+        memory_region_add_subregion_overlap(&s->container, 0x20010,
+                                            &s->systick_ns_mem, 1);
     }
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container);
@@ -2099,12 +2158,17 @@ static void armv7m_nvic_instance_init(Object *obj)
     NVICState *nvic = NVIC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_initialize(&nvic->systick, sizeof(nvic->systick), TYPE_SYSTICK);
-    qdev_set_parent_bus(DEVICE(&nvic->systick), sysbus_get_default());
+    object_initialize(&nvic->systick[M_REG_NS],
+                      sizeof(nvic->systick[M_REG_NS]), TYPE_SYSTICK);
+    qdev_set_parent_bus(DEVICE(&nvic->systick[M_REG_NS]), sysbus_get_default());
+    /* We can't initialize the secure systick here, as we don't know
+     * yet if we need it.
+     */
 
     sysbus_init_irq(sbd, &nvic->excpout);
     qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
-    qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger", 1);
+    qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger",
+                            M_REG_NUM_BANKS);
 }
 
 static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
-- 
2.7.4
