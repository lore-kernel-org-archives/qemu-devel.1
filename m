Received: from eggs.gnu.org ([2001:4830:134:3::10]:54695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsh4-0007cw-RS
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHsgz-00055e-RI
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:37:02 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:22:37 +0100
Message-ID: <1481894559-13974-2-git-send-email-marcin.krzeminski@nokia.com>
In-Reply-To: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
References: <1481894559-13974-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 1/3] nvic: Add CPU numebr property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

In case of MultiCPU SoC M3 is not always CPU0.
This commit add cpu_id property to allow set CPU
number for NVIC model. Also address space that this used
by NVIC is updated to mach CPU's one.

Signed-off-by: Marcin Krzeminski <marcin.krzeminski@nokia.com>
---
 hw/intc/armv7m_nvic.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 06d8db6..66f0f70 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -34,6 +34,7 @@ typedef struct {
     MemoryRegion container;
     uint32_t num_irq;
     qemu_irq sysresetreq;
+    uint32_t cpu_id;
 } nvic_state;
 
 #define TYPE_NVIC "armv7m_nvic"
@@ -187,11 +188,11 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
     case 0x1c: /* SysTick Calibration Value.  */
         return 10000;
     case 0xd00: /* CPUID Base.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
+        cpu = ARM_CPU(qemu_get_cpu(s->cpu_id));
         return cpu->midr;
     case 0xd04: /* Interrupt Control State.  */
         /* VECTACTIVE */
-        cpu = ARM_CPU(qemu_get_cpu(0));
+        cpu = ARM_CPU(qemu_get_cpu(s->cpu_id));
         val = cpu->env.v7m.exception;
         if (val == 1023) {
             val = 0;
@@ -222,7 +223,7 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
             val |= (1 << 31);
         return val;
     case 0xd08: /* Vector Table Offset.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
+        cpu = ARM_CPU(qemu_get_cpu(s->cpu_id));
         return cpu->env.v7m.vecbase;
     case 0xd0c: /* Application Interrupt/Reset Control.  */
         return 0xfa050000;
@@ -349,7 +350,7 @@ static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
         }
         break;
     case 0xd08: /* Vector Table Offset.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
+        cpu = ARM_CPU(qemu_get_cpu(s->cpu_id));
         cpu->env.v7m.vecbase = value & 0xffffff80;
         break;
     case 0xd0c: /* Application Interrupt/Reset Control.  */
@@ -453,6 +454,11 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
                   "NVIC: Bad write of size %d at offset 0x%x\n", size, offset);
 }
 
+static Property nvic_properties[] = {
+    DEFINE_PROP_UINT32("cpu-id", nvic_state, cpu_id, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static const MemoryRegionOps nvic_sysreg_ops = {
     .read = nvic_sysreg_read,
     .write = nvic_sysreg_write,
@@ -461,13 +467,14 @@ static const MemoryRegionOps nvic_sysreg_ops = {
 
 static const VMStateDescription vmstate_nvic = {
     .name = "armv7m_nvic",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(systick.control, nvic_state),
         VMSTATE_UINT32(systick.reload, nvic_state),
         VMSTATE_INT64(systick.tick, nvic_state),
         VMSTATE_TIMER_PTR(systick.timer, nvic_state),
+	VMSTATE_UINT32(cpu_id, nvic_state),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -494,6 +501,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     nvic_state *s = NVIC(dev);
     NVICClass *nc = NVIC_GET_CLASS(s);
     Error *local_err = NULL;
+    CPUState *cpustate;
 
     /* The NVIC always has only one CPU */
     s->gic.num_cpu = 1;
@@ -531,7 +539,10 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* Map the whole thing into system memory at the location required
      * by the v7M architecture.
      */
-    memory_region_add_subregion(get_system_memory(), 0xe000e000, &s->container);
+
+    cpustate = qemu_get_cpu(s->cpu_id);
+    memory_region_add_subregion(cpustate->as->root, 0xe000e000, &s->container);
+
     s->systick.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
 }
 
@@ -564,6 +575,7 @@ static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
     dc->vmsd  = &vmstate_nvic;
     dc->reset = armv7m_nvic_reset;
     dc->realize = armv7m_nvic_realize;
+    dc->props = nvic_properties;
 }
 
 static const TypeInfo armv7m_nvic_info = {
-- 
2.7.4
