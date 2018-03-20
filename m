Received: from eggs.gnu.org ([2001:4830:134:3::10]:42786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGX8-0007dh-4x
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGX3-0003Rk-4H
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:30 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:27 +0100
Message-Id: <1521549456-14072-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 05/14] hw/arm/smmuv3: Wired IRQ and GERROR
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

We introduce some helpers to handle wired IRQs and especially
GERROR interrupt. SMMU writes GERROR register on GERROR event
and SW acks GERROR interrupts by setting GERRORn.

The Wired interrupts are edge sensitive hence the pulse usage.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---
v9 - v10:
- s/hwaddr/uint64_t in trace-events
- use qemu_log_mask LOG_UNIMP on PRI IRQ
- add a comment saying smmuv3_trigger_irq and smmuv3_write_gerrorn
  will become static later on
- write gerrorn without filtering (ie. even if the guest toggles non
  active IRQs)
- pulse if at least one new IRQ type
- smmuv3_eventq_irq_enabled and smmuv3_gerror_irq_enabled become
  static inline

v7 -> v8:
- remove SMMU_PENDING_GERRORS macro
- properly toggle gerror
- properly sanitize gerrorn write
---
 hw/arm/smmuv3-internal.h | 36 +++++++++++----------------
 hw/arm/smmuv3.c          | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  3 +++
 3 files changed, 81 insertions(+), 22 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a6461fe..32f81d4 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -129,28 +129,6 @@ typedef struct Evt  {
     uint32_t word[8];
 } Evt;
 
-/**
- * smmu_read64 - 64-bit register read utility function supporting
- * aligned 32-bit word access to both 32-bit halves and aligned 64-bit
- * access.
- *
- * @r: register address
- * @offset: byte offset if 32-bit access
- * @size: read byte size
- */
-static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
-                                   unsigned size)
-{
-    if (size == 8) {
-        return r;
-    }
-
-    /* 32 bit access */
-    assert(!offset || offset == 4);
-
-    return extract64(r, offset << 3, 32);
-}
-
 static inline uint32_t smmuv3_idreg(int regoffset)
 {
     /*
@@ -164,4 +142,18 @@ static inline uint32_t smmuv3_idreg(int regoffset)
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
index 3472163..990c02e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -30,6 +30,70 @@
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
index 2f3d74a..b77f8d2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -15,3 +15,6 @@ smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "base
 
 #hw/arm/smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
+smmuv3_trigger_irq(int irq) "irq=%d"
+smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
+smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
-- 
2.5.5
