Received: from eggs.gnu.org ([2001:4830:134:3::10]:36580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpeP-0005Ht-9J
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpeK-0002aS-B1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:37 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:09 +0200
Message-Id: <1504286483-23327-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 06/20] hw/arm/smmuv3: Wired IRQ and GERROR
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

We introduce some helpers to handle wired IRQs and especially
GERROR interrupt. SMMU writes GERROR register on GERROR event
and SW acks GERROR interrupts by setting GERRORn.

The Wired interrupts are edge sensitive.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

Is CMD_SYNC interrupt enabled somewhere?
---
 hw/arm/smmuv3-internal.h | 20 ++++++++++++++++++
 hw/arm/smmuv3.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  2 ++
 3 files changed, 77 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 488acc8..2b44ee2 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -198,4 +198,24 @@ static inline int smmu_enabled(SMMUV3State *s)
     return smmu_read32_reg(s, SMMU_REG_CR0) & SMMU_CR0_SMMU_ENABLE;
 }
 
+/*****************************
+ * Interrupts
+ *****************************/
+
+#define smmu_evt_irq_enabled(s)                   \
+    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_EVENT_EN)
+#define smmu_gerror_irq_enabled(s)                  \
+    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_GERROR_EN)
+#define smmu_pri_irq_enabled(s)                 \
+    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_PRI_EN)
+
+#define SMMU_PENDING_GERRORS(s) \
+    (smmu_read32_reg(s, SMMU_REG_GERROR) ^ \
+     smmu_read32_reg(s, SMMU_REG_GERRORN))
+
+#define SMMU_CMDQ_ERR(s) (SMMU_PENDING_GERRORS(s) & SMMU_GERROR_CMDQ)
+
+void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val);
+void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0a7cd1c..468134f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -29,6 +29,61 @@
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-internal.h"
 
+/**
+ * smmuv3_irq_trigger - pulse @irq if enabled and update
+ * GERROR register in case of GERROR interrupt
+ *
+ * @irq: irq type
+ * @gerror: gerror new value, only relevant if @irq is GERROR
+ */
+void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val)
+{
+    uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
+    bool pulse = false;
+
+    switch (irq) {
+    case SMMU_IRQ_EVTQ:
+        pulse = smmu_evt_irq_enabled(s);
+        break;
+    case SMMU_IRQ_PRIQ:
+        pulse = smmu_pri_irq_enabled(s);
+        break;
+    case SMMU_IRQ_CMD_SYNC:
+        pulse = true;
+        break;
+    case SMMU_IRQ_GERROR:
+    {
+        /* don't toggle an already pending error */
+        bool new_gerrors = ~pending_gerrors & gerror_val;
+        uint32_t gerror = smmu_read32_reg(s, SMMU_REG_GERROR);
+
+        smmu_write32_reg(s, SMMU_REG_GERROR, gerror | new_gerrors);
+
+        /* pulse the GERROR irq only if all fields were acked */
+        pulse = smmu_gerror_irq_enabled(s) && !pending_gerrors;
+        break;
+    }
+    }
+    if (pulse) {
+            trace_smmuv3_irq_trigger(irq,
+                                     smmu_read32_reg(s, SMMU_REG_GERROR),
+                                     SMMU_PENDING_GERRORS(s));
+            qemu_irq_pulse(s->irq[irq]);
+    }
+}
+
+void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn)
+{
+    uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
+    uint32_t sanitized;
+
+    /* Make sure SW does not toggle irqs that are not active */
+    sanitized = gerrorn & pending_gerrors;
+
+    smmu_write32_reg(s, SMMU_REG_GERRORN, sanitized);
+    trace_smmuv3_write_gerrorn(gerrorn, sanitized, SMMU_PENDING_GERRORS(s));
+}
+
 static void smmuv3_init_regs(SMMUV3State *s)
 {
     uint32_t data =
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8affbf7..c1ce8eb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -17,3 +17,5 @@ smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova = 0x%"PRIx64" -> pa =
 
 #hw/arm/smmuv3.c
 smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
+smmuv3_irq_trigger(int irq, uint32_t gerror, uint32_t pending) "irq=%d gerror=0x%x pending gerrors=0x%x"
+smmuv3_write_gerrorn(uint32_t gerrorn, uint32_t sanitized, uint32_t pending) "gerrorn=0x%x sanitized=0x%x pending=0x%x"
-- 
2.5.5
