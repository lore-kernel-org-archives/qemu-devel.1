Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNy-0001hN-9e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNt-00031F-Ub
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilNt-000303-Nb
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:21 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNs-0003Qn-U6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:20 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:16:01 +0000
Message-Id: <1488302176-19463-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/21] armv7m: Make NVIC expose a memory region
 rather than mapping itself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the NVIC device expose a memory region for its users
to map, rather than mapping itself into the system memory
space on realize, and get the one user (the ARMv7M object)
to do this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1487604965-23220-7-git-send-email-peter.maydell@linaro.org
---
 hw/arm/armv7m.c       | 7 ++++++-
 hw/intc/armv7m_nvic.c | 7 ++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 3332f34..de97466 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -171,6 +171,7 @@ static void armv7m_instance_init(Object *obj)
 static void armv7m_realize(DeviceState *dev, Error **errp)
 {
     ARMv7MState *s = ARMV7M(dev);
+    SysBusDevice *sbd;
     Error *err = NULL;
     int i;
     char **cpustr;
@@ -232,10 +233,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
 
     /* Wire the NVIC up to the CPU */
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->nvic), 0,
+    sbd = SYS_BUS_DEVICE(&s->nvic);
+    sysbus_connect_irq(sbd, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
     s->cpu->env.nvic = &s->nvic;
 
+    memory_region_add_subregion(&s->container, 0xe000e000,
+                                sysbus_mmio_get_region(sbd, 0));
+
     for (i = 0; i < ARRAY_SIZE(s->bitband); i++) {
         Object *obj = OBJECT(&s->bitband[i]);
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index f2ada39..c814e16 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -19,7 +19,6 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/armv7m_nvic.h"
 #include "target/arm/cpu.h"
-#include "exec/address-spaces.h"
 #include "qemu/log.h"
 #include "trace.h"
 
@@ -1043,10 +1042,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
                           "nvic_sysregs", 0x1000);
     memory_region_add_subregion(&s->container, 0, &s->sysregmem);
 
-    /* Map the whole thing into system memory at the location required
-     * by the v7M architecture.
-     */
-    memory_region_add_subregion(get_system_memory(), 0xe000e000, &s->container);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container);
+
     s->systick.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
 }
 
-- 
2.7.4
