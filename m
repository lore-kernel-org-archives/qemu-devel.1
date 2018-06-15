Received: from eggs.gnu.org ([2001:4830:134:3::10]:60687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfS-0001Z9-76
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfQ-0006BY-T7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfQ-00065w-Bm
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:32 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfO-0003eq-IN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:49 +0100
Message-Id: <20180615142521.19143-12-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/43] arm: Don't crash if user tries to use a
 Cortex-M CPU without an NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Cortex-M CPU and its NVIC are two intimately intertwined parts of
the same hardware; it is not possible to use one without the other.
Unfortunately a lot of our board models don't do any sanity checking
on the CPU type the user asks for, so a command line like
    qemu-system-arm -M versatilepb -cpu cortex-m3
will create an M3 without an NVIC, and coredump immediately.
In the other direction, trying a non-M-profile CPU in an M-profile
board won't blow up, but doesn't do anything useful either:
    qemu-system-arm -M lm3s6965evb -cpu arm926

Add some checking in the NVIC and CPU realize functions that the
user isn't trying to use an NVIC without an M-profile CPU or
an M-profile CPU without an NVIC, so we can produce a helpful
error message rather than a core dump.

Fixes: https://bugs.launchpad.net/qemu/+bug/1766896
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180601160355.15393-1-peter.maydell@linaro.org
---
 hw/arm/armv7m.c       |  7 ++++++-
 hw/intc/armv7m_nvic.c |  6 +++++-
 target/arm/cpu.c      | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index a4ab7d20696..9e00d4037c5 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -178,6 +178,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    /* Tell the CPU where the NVIC is; it will fail realize if it doesn't
+     * have one.
+     */
+    s->cpu->env.nvic = &s->nvic;
+
     object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -202,7 +208,6 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     sbd = SYS_BUS_DEVICE(&s->nvic);
     sysbus_connect_irq(sbd, 0,
                        qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
-    s->cpu->env.nvic = &s->nvic;
 
     memory_region_add_subregion(&s->container, 0xe000e000,
                                 sysbus_mmio_get_region(sbd, 0));
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index c51151fa8a9..661be8878a8 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2183,7 +2183,11 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     int regionlen;
 
     s->cpu = ARM_CPU(qemu_get_cpu(0));
-    assert(s->cpu);
+
+    if (!s->cpu || !arm_feature(&s->cpu->env, ARM_FEATURE_M)) {
+        error_setg(errp, "The NVIC can only be used with a Cortex-M CPU");
+        return;
+    }
 
     if (s->num_irq > NVIC_MAX_IRQ) {
         error_setg(errp, "num-irq %d exceeds NVIC maximum", s->num_irq);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab047b94021..e1de45e904c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -767,6 +767,24 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    /* The NVIC and M-profile CPU are two halves of a single piece of
+     * hardware; trying to use one without the other is a command line
+     * error and will result in segfaults if not caught here.
+     */
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        if (!env->nvic) {
+            error_setg(errp, "This board cannot be used with Cortex-M CPUs");
+            return;
+        }
+    } else {
+        if (env->nvic) {
+            error_setg(errp, "This board can only be used with Cortex-M CPUs");
+            return;
+        }
+    }
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.17.1
