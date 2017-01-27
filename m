Received: from eggs.gnu.org ([2001:4830:134:3::10]:59691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vu-00016g-R1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vt-00059r-RK
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vt-000541-K4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vj-0003OU-7x
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:05 +0000
Message-Id: <1485531137-2362-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/22] armv7m_nvic: keep a pointer to the CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

Many NVIC operations access the CPU state, so store a pointer in
struct nvic_state rather than fetching it via qemu_get_cpu() every
time we need it.

As with the arm_gicv3_common code, we currently just call
qemu_get_cpu() in the NVIC's realize method, but in future we might
want to use a QOM property to pass the CPU to the NVIC.

This imposes an ordering requirement that the CPU is
realized before the NVIC, but that is always true since
both are dealt with in armv7m_init().

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1485285380-10565-3-git-send-email-peter.maydell@linaro.org
[PMM: Use qemu_get_cpu(0) rather than first_cpu; expand
 commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 06d8db6..81dcb83 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -23,6 +23,7 @@
 
 typedef struct {
     GICState gic;
+    ARMCPU *cpu;
     struct {
         uint32_t control;
         uint32_t reload;
@@ -155,7 +156,7 @@ void armv7m_nvic_complete_irq(void *opaque, int irq)
 
 static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
 {
-    ARMCPU *cpu;
+    ARMCPU *cpu = s->cpu;
     uint32_t val;
     int irq;
 
@@ -187,11 +188,9 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
     case 0x1c: /* SysTick Calibration Value.  */
         return 10000;
     case 0xd00: /* CPUID Base.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
         return cpu->midr;
     case 0xd04: /* Interrupt Control State.  */
         /* VECTACTIVE */
-        cpu = ARM_CPU(qemu_get_cpu(0));
         val = cpu->env.v7m.exception;
         if (val == 1023) {
             val = 0;
@@ -222,7 +221,6 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
             val |= (1 << 31);
         return val;
     case 0xd08: /* Vector Table Offset.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
         return cpu->env.v7m.vecbase;
     case 0xd0c: /* Application Interrupt/Reset Control.  */
         return 0xfa050000;
@@ -296,7 +294,7 @@ static uint32_t nvic_readl(nvic_state *s, uint32_t offset)
 
 static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
 {
-    ARMCPU *cpu;
+    ARMCPU *cpu = s->cpu;
     uint32_t oldval;
     switch (offset) {
     case 0x10: /* SysTick Control and Status.  */
@@ -349,7 +347,6 @@ static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
         }
         break;
     case 0xd08: /* Vector Table Offset.  */
-        cpu = ARM_CPU(qemu_get_cpu(0));
         cpu->env.v7m.vecbase = value & 0xffffff80;
         break;
     case 0xd0c: /* Application Interrupt/Reset Control.  */
@@ -495,6 +492,8 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     NVICClass *nc = NVIC_GET_CLASS(s);
     Error *local_err = NULL;
 
+    s->cpu = ARM_CPU(qemu_get_cpu(0));
+    assert(s->cpu);
     /* The NVIC always has only one CPU */
     s->gic.num_cpu = 1;
     /* Tell the common code we're an NVIC */
-- 
2.7.4
