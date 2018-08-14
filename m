Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdv5-0004bb-VW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtt-0006cw-Js
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdts-0006bj-42
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtq-0007DE-6H
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:44 +0100
Message-Id: <20180814181815.23348-15-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/45] intc/arm_gic: Remove some dead code and
 put some functions static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Some functions are now only used in arm_gic.c, put them static. Some of
them where only used by the NVIC implementation and are not used
anymore, so remove them.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-4-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gic_internal.h |  4 ----
 hw/intc/arm_gic.c      | 23 ++---------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 6f8d242904b..a2075a94dbb 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -75,11 +75,7 @@
 /* The special cases for the revision property: */
 #define REV_11MPCORE 0
 
-void gic_set_pending_private(GICState *s, int cpu, int irq);
 uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs);
-void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs);
-void gic_update(GICState *s);
-void gic_init_irqs_and_distributor(GICState *s);
 void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                            MemTxAttrs attrs);
 
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 53b749d2167..b8eba6e5944 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -71,7 +71,7 @@ static inline bool gic_has_groups(GICState *s)
 
 /* TODO: Many places that call this routine could be optimized.  */
 /* Update interrupt status after enabled or pending bits have been changed.  */
-void gic_update(GICState *s)
+static void gic_update(GICState *s)
 {
     int best_irq;
     int best_prio;
@@ -137,19 +137,6 @@ void gic_update(GICState *s)
     }
 }
 
-void gic_set_pending_private(GICState *s, int cpu, int irq)
-{
-    int cm = 1 << cpu;
-
-    if (gic_test_pending(s, irq, cm)) {
-        return;
-    }
-
-    DPRINTF("Set %d pending cpu %d\n", irq, cpu);
-    GIC_DIST_SET_PENDING(irq, cm);
-    gic_update(s);
-}
-
 static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
                                  int cm, int target)
 {
@@ -579,7 +566,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
     GIC_DIST_CLEAR_ACTIVE(irq, cm);
 }
 
-void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
+static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
 {
     int cm = 1 << cpu;
     int group;
@@ -1488,12 +1475,6 @@ static const MemoryRegionOps gic_cpu_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-/* This function is used by nvic model */
-void gic_init_irqs_and_distributor(GICState *s)
-{
-    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops);
-}
-
 static void arm_gic_realize(DeviceState *dev, Error **errp)
 {
     /* Device instance realize function for the GIC sysbus device */
-- 
2.18.0
