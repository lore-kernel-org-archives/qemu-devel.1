Received: from eggs.gnu.org ([2001:4830:134:3::10]:42848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXG-0007n5-So
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXC-0003aj-AA
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:38 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:29 +0100
Message-Id: <1521549456-14072-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 07/14] hw/arm/smmuv3: Implement MMIO write
 operations
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

Now we have relevant helpers for queue and irq
management, let's implement MMIO write operations.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---
v9 -> v10:
- s/hwaddr/uint64_t in trace-events
- added SMMU_FEATURE_2LVL_STE in this patch
- removed smmu_write64 and created writel/writell infra
- store capped log2size
- mask CR0 reserved bits

v7 -> v8:
- precise in the commit message invalidation commands
  are not yet treated.
- use new queue helpers
- do not decode unhandled commands at this stage
---
 hw/arm/smmuv3-internal.h |   8 +--
 hw/arm/smmuv3.c          | 172 +++++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events      |   6 ++
 3 files changed, 175 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 968fa25..8550be0 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -64,6 +64,8 @@ REG32(CR0,                 0x20)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
+#define SMMU_CR0_RESERVED 0xFFFFFC20
+
 REG32(CR0ACK,              0x24)
 REG32(CR1,                 0x28)
 REG32(CR2,                 0x2c)
@@ -152,10 +154,6 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
     return FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
 }
 
-/* public until callers get introduced */
-void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
-void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
-
 /* Queue Handling */
 
 #define Q_BASE(q)          ((q)->base & SMMU_BASE_ADDR_MASK)
@@ -308,6 +306,6 @@ enum { /* Command completion notification */
             addr;                                             \
         })
 
-int smmuv3_cmdq_consume(SMMUv3State *s);
+#define SMMU_FEATURE_2LVL_STE (1 << 0)
 
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6c9d68b..77ec58d 100644
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
@@ -74,7 +75,7 @@ void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
     }
 }
 
-void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
+static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
 {
     uint32_t pending = s->gerror ^ s->gerrorn;
     uint32_t toggled = s->gerrorn ^ new_gerrorn;
@@ -173,7 +174,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->sid_split = 0;
 }
 
-int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
     SMMUQueue *q = &s->cmdq;
@@ -269,11 +270,170 @@ int smmuv3_cmdq_consume(SMMUv3State *s)
     return 0;
 }
 
-static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
+static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
+                               uint64_t value, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_GERROR_IRQ_CFG0:
+        s->gerror_irq_cfg0 = value;
+        return MEMTX_OK;
+    case A_STRTAB_BASE:
+        s->strtab_base = value;
+        return MEMTX_OK;
+    case A_CMDQ_BASE:
+        s->cmdq.base = value;
+        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
+        if (s->cmdq.log2size > SMMU_CMDQS) {
+            s->cmdq.log2size = SMMU_CMDQS;
+        }
+        return MEMTX_OK;
+    case A_EVENTQ_BASE:
+        s->eventq.base = value;
+        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
+        if (s->eventq.log2size > SMMU_EVENTQS) {
+            s->eventq.log2size = SMMU_EVENTQS;
+        }
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0:
+        s->eventq_irq_cfg0 = value;
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s Unexpected 64-bit access to 0x%"PRIx64" (WI)\n",
+                      __func__, offset);
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
+                               uint64_t value, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_CR0:
+        s->cr[0] = value;
+        s->cr0ack = value & ~SMMU_CR0_RESERVED;
+        /* in case the command queue has been enabled */
+        smmuv3_cmdq_consume(s);
+        return MEMTX_OK;
+    case A_CR1:
+        s->cr[1] = value;
+        return MEMTX_OK;
+    case A_CR2:
+        s->cr[2] = value;
+        return MEMTX_OK;
+    case A_IRQ_CTRL:
+        s->irq_ctrl = value;
+        return MEMTX_OK;
+    case A_GERRORN:
+        smmuv3_write_gerrorn(s, value);
+        /*
+         * By acknowledging the CMDQ_ERR, SW may notify cmds can
+         * be processed again
+         */
+        smmuv3_cmdq_consume(s);
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0: /* 64b */
+        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, value);
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG0 + 4:
+        s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 32, 32, value);
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG1:
+        s->gerror_irq_cfg1 = value;
+        return MEMTX_OK;
+    case A_GERROR_IRQ_CFG2:
+        s->gerror_irq_cfg2 = value;
+        return MEMTX_OK;
+    case A_STRTAB_BASE: /* 64b */
+        s->strtab_base = deposit64(s->strtab_base, 0, 32, value);
+        return MEMTX_OK;
+    case A_STRTAB_BASE + 4:
+        s->strtab_base = deposit64(s->strtab_base, 32, 32, value);
+        return MEMTX_OK;
+    case A_STRTAB_BASE_CFG:
+        s->strtab_base_cfg = value;
+        if (FIELD_EX32(value, STRTAB_BASE_CFG, FMT) == 1) {
+            s->sid_split = FIELD_EX32(value, STRTAB_BASE_CFG, SPLIT);
+            s->features |= SMMU_FEATURE_2LVL_STE;
+        }
+        return MEMTX_OK;
+    case A_CMDQ_BASE: /* 64b */
+        s->cmdq.base = deposit64(s->cmdq.base, 0, 32, value);
+        s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
+        if (s->cmdq.log2size > SMMU_CMDQS) {
+            s->cmdq.log2size = SMMU_CMDQS;
+        }
+        return MEMTX_OK;
+    case A_CMDQ_BASE + 4: /* 64b */
+        s->cmdq.base = deposit64(s->cmdq.base, 32, 32, value);
+        return MEMTX_OK;
+    case A_CMDQ_PROD:
+        s->cmdq.prod = value;
+        smmuv3_cmdq_consume(s);
+        return MEMTX_OK;
+    case A_CMDQ_CONS:
+        s->cmdq.cons = value;
+        return MEMTX_OK;
+    case A_EVENTQ_BASE: /* 64b */
+        s->eventq.base = deposit64(s->eventq.base, 0, 32, value);
+        s->eventq.log2size = extract64(s->eventq.base, 0, 5);
+        if (s->eventq.log2size > SMMU_EVENTQS) {
+            s->eventq.log2size = SMMU_EVENTQS;
+        }
+        return MEMTX_OK;
+    case A_EVENTQ_BASE + 4:
+        s->eventq.base = deposit64(s->eventq.base, 32, 32, value);
+        return MEMTX_OK;
+    case A_EVENTQ_PROD:
+        s->eventq.prod = value;
+        return MEMTX_OK;
+    case A_EVENTQ_CONS:
+        s->eventq.cons = value;
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0: /* 64b */
+        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 0, 32, value);
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG0 + 4:
+        s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 32, 32, value);
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG1:
+        s->eventq_irq_cfg1 = value;
+        return MEMTX_OK;
+    case A_EVENTQ_IRQ_CFG2:
+        s->eventq_irq_cfg2 = value;
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
+                      __func__, offset);
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t value,
                                    unsigned size, MemTxAttrs attrs)
 {
-    /* not yet implemented */
-    return MEMTX_ERROR;
+    SMMUState *sys = opaque;
+    SMMUv3State *s = ARM_SMMUV3(sys);
+    MemTxResult r;
+
+    /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
+    offset &= ~0x10000;
+
+    switch (size) {
+    case 8:
+        r = smmu_writell(s, offset, value, attrs);
+        break;
+    case 4:
+        r = smmu_writel(s, offset, value, attrs);
+        break;
+    default:
+        r = MEMTX_ERROR;
+        break;
+    }
+
+    trace_smmuv3_write_mmio(offset, value, size, r);
+    return r;
 }
 
 static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 38b35fa..781542a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -23,3 +23,9 @@ smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t con
 smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
 smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
+smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
+smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
+smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
+smmuv3_write_mmio_idr(uint64_t addr, uint64_t val) "write to RO/Unimpl reg 0x%lx val64:0x%lx"
+smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
-- 
2.5.5
