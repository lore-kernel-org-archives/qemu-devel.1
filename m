Received: from eggs.gnu.org ([2001:4830:134:3::10]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih2C-0006BA-RW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih27-0006wp-VF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:42:12 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Feb 2018 14:39:25 +0100
Message-Id: <1517837972-1904-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
References: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v8 07/14] hw/arm/smmuv3: Implement MMIO write
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: tn@semihalf.com, mst@redhat.com, christoffer.dall@linaro.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, edgar.iglesias@gmail.com, linuc.decode@gmail.com, peterx@redhat.com

Now we have relevant helpers for queue and irq
management, let's implement MMIO write operations.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v7 -> v8:
- precise in the commit message invalidation commands
  are not yet treated.
- use new queue helpers
- do not decode unhandled commands at this stage
---
 hw/arm/smmuv3-internal.h |  24 +++++++---
 hw/arm/smmuv3.c          | 111 +++++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events      |   6 +++
 3 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 44564ed..799bce0 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -152,6 +152,25 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
     return extract64(r, offset << 3, 32);
 }
 
+static inline void smmu_write64(uint64_t *r, unsigned offset,
+                                unsigned size, uint64_t value)
+{
+    if (size == 8 && !offset) {
+        *r  = value;
+    }
+
+    /* 32 bit access */
+
+    if (offset && offset != 4)  {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 MMIO write: bad offset/size %u/%u\n",
+                      offset, size);
+        return ;
+    }
+
+    *r = deposit64(*r, offset << 3, 32, value);
+}
+
 /* Interrupts */
 
 #define smmuv3_eventq_irq_enabled(s)                   \
@@ -159,9 +178,6 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
 #define smmuv3_gerror_irq_enabled(s)                  \
     (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN))
 
-void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
-void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
-
 /* Queue Handling */
 
 #define LOG2SIZE(q)        extract64((q)->base, 0, 5)
@@ -302,6 +318,4 @@ enum { /* Command completion notification */
             addr;                                       \
         })
 
-int smmuv3_cmdq_consume(SMMUv3State *s);
-
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 79970d7..8e9eab2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -37,7 +37,8 @@
  * @irq: irq type
  * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
  */
-void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
+static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
+                               uint32_t gerror_mask)
 {
 
     bool pulse = false;
@@ -75,7 +76,7 @@ void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
     }
 }
 
-void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
 {
     uint32_t pending = s->gerror ^ s->gerrorn;
     uint32_t toggled = s->gerrorn ^ new_gerrorn;
@@ -202,7 +203,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->sid_split = 0;
 }
 
-int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
     SMMUQueue *q = &s->cmdq;
@@ -287,7 +288,109 @@ int smmuv3_cmdq_consume(SMMUv3State *s)
 static void smmu_write_mmio(void *opaque, hwaddr addr,
                             uint64_t val, unsigned size)
 {
-    /* not yet implemented */
+    SMMUState *sys = opaque;
+    SMMUv3State *s = ARM_SMMUV3(sys);
+
+    /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
+    addr &= ~0x10000;
+
+    if (size != 4 && size != 8) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 MMIO write: bad size %u\n", size);
+    }
+
+    trace_smmuv3_write_mmio(addr, val, size);
+
+    switch (addr) {
+    case A_CR0:
+        s->cr[0] = val;
+        s->cr0ack = val;
+        /* in case the command queue has been enabled */
+        smmuv3_cmdq_consume(s);
+        return;
+    case A_CR1:
+        s->cr[1] = val;
+        return;
+    case A_CR2:
+        s->cr[2] = val;
+        return;
+    case A_IRQ_CTRL:
+        s->irq_ctrl = val;
+        return;
+    case A_GERRORN:
+        smmuv3_write_gerrorn(s, val);
+        /*
+         * By acknowledging the CMDQ_ERR, SW may notify cmds can
+         * be processed again
+         */
+        smmuv3_cmdq_consume(s);
+        return;
+    case A_GERROR_IRQ_CFG0: /* 64b */
+        smmu_write64(&s->gerror_irq_cfg0, 0, size, val);
+        return;
+    case A_GERROR_IRQ_CFG0 + 4:
+        smmu_write64(&s->gerror_irq_cfg0, 4, size, val);
+        return;
+    case A_GERROR_IRQ_CFG1:
+        s->gerror_irq_cfg1 = val;
+        return;
+    case A_GERROR_IRQ_CFG2:
+        s->gerror_irq_cfg2 = val;
+        return;
+    case A_STRTAB_BASE: /* 64b */
+        smmu_write64(&s->strtab_base, 0, size, val);
+        return;
+    case A_STRTAB_BASE + 4:
+        smmu_write64(&s->strtab_base, 4, size, val);
+        return;
+    case A_STRTAB_BASE_CFG:
+        s->strtab_base_cfg = val;
+        if (FIELD_EX32(val, STRTAB_BASE_CFG, FMT) == 1) {
+            s->sid_split = FIELD_EX32(val, STRTAB_BASE_CFG, SPLIT);
+            s->features |= SMMU_FEATURE_2LVL_STE;
+        }
+        return;
+    case A_CMDQ_BASE: /* 64b */
+        smmu_write64(&s->cmdq.base, 0, size, val);
+        return;
+    case A_CMDQ_BASE + 4: /* 64b */
+        smmu_write64(&s->cmdq.base, 4, size, val);
+        return;
+    case A_CMDQ_PROD:
+        s->cmdq.prod = val;
+        smmuv3_cmdq_consume(s);
+        return;
+    case A_CMDQ_CONS:
+        s->cmdq.cons = val;
+        return;
+    case A_EVENTQ_BASE: /* 64b */
+        smmu_write64(&s->eventq.base, 0, size, val);
+        return;
+    case A_EVENTQ_BASE + 4:
+        smmu_write64(&s->eventq.base, 4, size, val);
+        return;
+    case A_EVENTQ_PROD:
+        s->eventq.prod = val;
+        return;
+    case A_EVENTQ_CONS:
+        s->eventq.cons = val;
+        return;
+    case A_EVENTQ_IRQ_CFG0: /* 64b */
+        s->eventq.prod = val;
+        smmu_write64(&s->eventq_irq_cfg0, 0, size, val);
+        return;
+    case A_EVENTQ_IRQ_CFG0 + 4:
+        smmu_write64(&s->eventq_irq_cfg0, 4, size, val);
+        return;
+    case A_EVENTQ_IRQ_CFG1:
+        s->eventq_irq_cfg1 = val;
+        return;
+    case A_EVENTQ_IRQ_CFG2:
+        s->eventq_irq_cfg2 = val;
+        return;
+    default:
+        error_report("%s unhandled access at 0x%"PRIx64, __func__, addr);
+    }
 }
 
 static uint64_t smmu_read_mmio(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index d73e151..8a4acb9 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -24,3 +24,9 @@ smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
 smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
 smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
+smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
+smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
+smmuv3_write_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
+smmuv3_write_mmio_idr(hwaddr addr, uint64_t val) "write to RO/Unimpl reg 0x%lx val64:0x%lx"
+smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
-- 
2.5.5
