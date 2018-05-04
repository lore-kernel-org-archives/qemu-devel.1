Received: from eggs.gnu.org ([2001:4830:134:3::10]:51821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJG-0005kj-QD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJF-0000iY-KK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJF-0000eG-CU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:53 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJE-00035x-1h
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:52 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:31 +0100
Message-Id: <20180504171540.25813-16-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/24] hw/arm/smmuv3: Wired IRQ and GERROR
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We introduce some helpers to handle wired IRQs and especially
GERROR interrupt. SMMU writes GERROR register on GERROR event
and SW acks GERROR interrupts by setting GERRORn.

The Wired interrupts are edge sensitive hence the pulse usage.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1524665762-31355-6-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 14 +++++++++
 hw/arm/smmuv3.c          | 64 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 8da38d46c0..e27c128c07 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -139,4 +139,18 @@ static inline uint32_t smmuv3_idreg(int regoffset)
     return smmuv3_ids[regoffset / 4];
 }
 
+static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
+}
+
+static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
+}
+
+/* public until callers get introduced */
+void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
+void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b61f274393..c0cedcaba3 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -31,6 +31,70 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-internal.h"
 
+/**
+ * smmuv3_trigger_irq - pulse @irq if enabled and update
+ * GERROR register in case of GERROR interrupt
+ *
+ * @irq: irq type
+ * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
+ */
+void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
+{
+
+    bool pulse = false;
+
+    switch (irq) {
+    case SMMU_IRQ_EVTQ:
+        pulse = smmuv3_eventq_irq_enabled(s);
+        break;
+    case SMMU_IRQ_PRIQ:
+        qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
+        break;
+    case SMMU_IRQ_CMD_SYNC:
+        pulse = true;
+        break;
+    case SMMU_IRQ_GERROR:
+    {
+        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t new_gerrors = ~pending & gerror_mask;
+
+        if (!new_gerrors) {
+            /* only toggle non pending errors */
+            return;
+        }
+        s->gerror ^= new_gerrors;
+        trace_smmuv3_write_gerror(new_gerrors, s->gerror);
+
+        pulse = smmuv3_gerror_irq_enabled(s);
+        break;
+    }
+    }
+    if (pulse) {
+            trace_smmuv3_trigger_irq(irq);
+            qemu_irq_pulse(s->irq[irq]);
+    }
+}
+
+void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+{
+    uint32_t pending = s->gerror ^ s->gerrorn;
+    uint32_t toggled = s->gerrorn ^ new_gerrorn;
+
+    if (toggled & ~pending) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "guest toggles non pending errors = 0x%x\n",
+                      toggled & ~pending);
+    }
+
+    /*
+     * We do not raise any error in case guest toggles bits corresponding
+     * to not active IRQs (CONSTRAINED UNPREDICTABLE)
+     */
+    s->gerrorn = new_gerrorn;
+
+    trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
+}
+
 static void smmuv3_init_regs(SMMUv3State *s)
 {
     /**
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2f3d74a497..b77f8d2d1a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -15,3 +15,6 @@ smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "base
 
 #hw/arm/smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
+smmuv3_trigger_irq(int irq) "irq=%d"
+smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
+smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
-- 
2.17.0
