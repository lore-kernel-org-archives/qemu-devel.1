Received: from eggs.gnu.org ([2001:4830:134:3::10]:37192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUL-0003yy-Qm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUK-0005cl-QU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUK-0005cL-Ir
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:44 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUJ-0003DU-MU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:06 +0100
Message-Id: <20180820103212.2810-20-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/25] nvic: Expose NMI line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On real v7M hardware, the NMI line is an externally visible signal
that an SoC or board can toggle to assert an NMI. Expose it in
our QEMU NVIC and armv7m container objects so that a board model
can wire it up if it needs to.

In particular, the MPS2 watchdog is wired to NMI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/armv7m.c       |  1 +
 hw/intc/armv7m_nvic.c | 19 +++++++++++++++++++
 hw/intc/trace-events  |  1 +
 3 files changed, 21 insertions(+)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 878613994d2..4bf9131b81e 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -202,6 +202,7 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
      */
     qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
     qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
+    qdev_pass_gpios(DEVICE(&s->nvic), dev, "NMI");
 
     /* Wire the NVIC up to the CPU */
     sbd = SYS_BUS_DEVICE(&s->nvic);
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 351b69ab40b..0d816fdd2cc 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -774,6 +774,24 @@ static void set_irq_level(void *opaque, int n, int level)
     }
 }
 
+/* callback when external NMI line is changed */
+static void nvic_nmi_trigger(void *opaque, int n, int level)
+{
+    NVICState *s = opaque;
+
+    trace_nvic_set_nmi_level(level);
+
+    /*
+     * The architecture doesn't specify whether NMI should share
+     * the normal-interrupt behaviour of being resampled on
+     * exception handler return. We choose not to, so just
+     * set NMI pending here and don't track the current level.
+     */
+    if (level) {
+        armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
+    }
+}
+
 static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
 {
     ARMCPU *cpu = s->cpu;
@@ -2382,6 +2400,7 @@ static void armv7m_nvic_instance_init(Object *obj)
     qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
     qdev_init_gpio_in_named(dev, nvic_systick_trigger, "systick-trigger",
                             M_REG_NUM_BANKS);
+    qdev_init_gpio_in_named(dev, nvic_nmi_trigger, "NMI", 1);
 }
 
 static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 81c7c399f7d..7769869a135 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -192,6 +192,7 @@ nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (pr
 nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
 nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
 nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
+nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
 nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 
-- 
2.18.0
