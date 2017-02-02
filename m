Received: from eggs.gnu.org ([2001:4830:134:3::10]:60651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNae-0000Jz-9U
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZNad-000849-4f
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:02:44 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Feb 2017 20:02:14 +0000
Message-Id: <1486065742-28639-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/9] armv7m: Rename nvic_state to NVICState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>

Rename the nvic_state struct to NVICState, to match
our naming conventions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index fe5c303..09975f3 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -21,7 +21,7 @@
 #include "gic_internal.h"
 #include "qemu/log.h"
 
-typedef struct {
+typedef struct NVICState {
     GICState gic;
     ARMCPU *cpu;
     struct {
@@ -35,7 +35,7 @@ typedef struct {
     MemoryRegion container;
     uint32_t num_irq;
     qemu_irq sysresetreq;
-} nvic_state;
+} NVICState;
 
 #define TYPE_NVIC "armv7m_nvic"
 /**
@@ -57,7 +57,7 @@ typedef struct NVICClass {
 #define NVIC_GET_CLASS(obj) \
     OBJECT_GET_CLASS(NVICClass, (obj), TYPE_NVIC)
 #define NVIC(obj) \
-    OBJECT_CHECK(nvic_state, (obj), TYPE_NVIC)
+    OBJECT_CHECK(NVICState, (obj), TYPE_NVIC)
 
 static const uint8_t nvic_id[] = {
     0x00, 0xb0, 0x1b, 0x00, 0x0d, 0xe0, 0x05, 0xb1
@@ -74,7 +74,7 @@ static const uint8_t nvic_id[] = {
 int system_clock_scale;
 
 /* Conversion factor from qemu timer to SysTick frequencies.  */
-static inline int64_t systick_scale(nvic_state *s)
+static inline int64_t systick_scale(NVICState *s)
 {
     if (s->systick.control & SYSTICK_CLKSOURCE)
         return system_clock_scale;
@@ -82,7 +82,7 @@ static inline int64_t systick_scale(nvic_state *s)
         return 1000;
 }
 
-static void systick_reload(nvic_state *s, int reset)
+static void systick_reload(NVICState *s, int reset)
 {
     /* The Cortex-M3 Devices Generic User Guide says that "When the
      * ENABLE bit is set to 1, the counter loads the RELOAD value from the
@@ -101,7 +101,7 @@ static void systick_reload(nvic_state *s, int reset)
 
 static void systick_timer_tick(void * opaque)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     s->systick.control |= SYSTICK_COUNTFLAG;
     if (s->systick.control & SYSTICK_TICKINT) {
         /* Trigger the interrupt.  */
@@ -114,7 +114,7 @@ static void systick_timer_tick(void * opaque)
     }
 }
 
-static void systick_reset(nvic_state *s)
+static void systick_reset(NVICState *s)
 {
     s->systick.control = 0;
     s->systick.reload = 0;
@@ -126,7 +126,7 @@ static void systick_reset(nvic_state *s)
    IRQ is #16.  The internal GIC routines use #32 as the first IRQ.  */
 void armv7m_nvic_set_pending(void *opaque, int irq)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     if (irq >= 16)
         irq += 16;
     gic_set_pending_private(&s->gic, 0, irq);
@@ -135,7 +135,7 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
 /* Make pending IRQ active.  */
 int armv7m_nvic_acknowledge_irq(void *opaque)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     uint32_t irq;
 
     irq = gic_acknowledge_irq(&s->gic, 0, MEMTXATTRS_UNSPECIFIED);
@@ -148,13 +148,13 @@ int armv7m_nvic_acknowledge_irq(void *opaque)
 
 void armv7m_nvic_complete_irq(void *opaque, int irq)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     if (irq >= 16)
         irq += 16;
     gic_complete_irq(&s->gic, 0, irq, MEMTXATTRS_UNSPECIFIED);
 }
 
-static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
+static uint32_t nvic_readl(NVICState *s, uint32_t offset)
 {
     ARMCPU *cpu = s->cpu;
     uint32_t val;
@@ -294,7 +294,7 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
     }
 }
 
-static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
+static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
 {
     ARMCPU *cpu = s->cpu;
     uint32_t oldval;
@@ -425,7 +425,7 @@ static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
 static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
     int i;
     uint32_t val;
@@ -454,7 +454,7 @@ static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
 static void nvic_sysreg_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
-    nvic_state *s = (nvic_state *)opaque;
+    NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
     int i;
 
@@ -486,17 +486,17 @@ static const VMStateDescription vmstate_nvic = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(systick.control, nvic_state),
-        VMSTATE_UINT32(systick.reload, nvic_state),
-        VMSTATE_INT64(systick.tick, nvic_state),
-        VMSTATE_TIMER_PTR(systick.timer, nvic_state),
+        VMSTATE_UINT32(systick.control, NVICState),
+        VMSTATE_UINT32(systick.reload, NVICState),
+        VMSTATE_INT64(systick.tick, NVICState),
+        VMSTATE_TIMER_PTR(systick.timer, NVICState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static void armv7m_nvic_reset(DeviceState *dev)
 {
-    nvic_state *s = NVIC(dev);
+    NVICState *s = NVIC(dev);
     NVICClass *nc = NVIC_GET_CLASS(s);
     nc->parent_reset(dev);
     /* Common GIC reset resets to disabled; the NVIC doesn't have
@@ -513,7 +513,7 @@ static void armv7m_nvic_reset(DeviceState *dev)
 
 static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
-    nvic_state *s = NVIC(dev);
+    NVICState *s = NVIC(dev);
     NVICClass *nc = NVIC_GET_CLASS(s);
     Error *local_err = NULL;
 
@@ -569,7 +569,7 @@ static void armv7m_nvic_instance_init(Object *obj)
      */
     GICState *s = ARM_GIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
-    nvic_state *nvic = NVIC(obj);
+    NVICState *nvic = NVIC(obj);
     /* The ARM v7m may have anything from 0 to 496 external interrupt
      * IRQ lines. We default to 64. Other boards may differ and should
      * set the num-irq property appropriately.
@@ -594,7 +594,7 @@ static const TypeInfo armv7m_nvic_info = {
     .name          = TYPE_NVIC,
     .parent        = TYPE_ARM_GIC_COMMON,
     .instance_init = armv7m_nvic_instance_init,
-    .instance_size = sizeof(nvic_state),
+    .instance_size = sizeof(NVICState),
     .class_init    = armv7m_nvic_class_init,
     .class_size    = sizeof(NVICClass),
 };
-- 
2.7.4
