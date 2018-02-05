Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih1y-0005zi-G1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eih1t-0006hc-Lp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:41:58 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Feb 2018 14:39:24 +0100
Message-Id: <1517837972-1904-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
References: <1517837972-1904-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v8 06/14] hw/arm/smmuv3: Queue helpers
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

We introduce helpers to read/write into the command and event
circular queues.

smmuv3_write_eventq and smmuv3_cmq_consume will become static
in subsequent patches.

Invalidation commands are not yet dealt with. We do not cache
data that need to be invalidated. This will change with vhost
integration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v7 -> v8
- use address_space_rw
- helpers inspired from spec
---
 hw/arm/smmuv3-internal.h | 142 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c          | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   4 ++
 3 files changed, 297 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 72d9c6c..44564ed 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -162,4 +162,146 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
 void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
 void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
 
+/* Queue Handling */
+
+#define LOG2SIZE(q)        extract64((q)->base, 0, 5)
+#define BASE(q)            ((q)->base & SMMU_BASE_ADDR_MASK)
+#define WRAP_MASK(q)       (1 << LOG2SIZE(q))
+#define INDEX_MASK(q)      ((1 << LOG2SIZE(q)) - 1)
+#define WRAP_INDEX_MASK(q) ((1 << (LOG2SIZE(q) + 1)) - 1)
+
+#define Q_CONS_ENTRY(q)  (BASE(q) + \
+                          (q)->entry_size * ((q)->cons & INDEX_MASK(q)))
+#define Q_PROD_ENTRY(q)  (BASE(q) + \
+                          (q)->entry_size * ((q)->prod & INDEX_MASK(q)))
+
+#define Q_CONS(q) ((q)->cons & INDEX_MASK(q))
+#define Q_PROD(q) ((q)->prod & INDEX_MASK(q))
+
+#define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> LOG2SIZE(q))
+#define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> LOG2SIZE(q))
+
+#define Q_FULL(q) \
+    (((((q)->cons) & INDEX_MASK(q)) == \
+      (((q)->prod) & INDEX_MASK(q))) && \
+     ((((q)->cons) & WRAP_MASK(q)) != \
+      (((q)->prod) & WRAP_MASK(q))))
+
+#define Q_EMPTY(q) \
+    (((((q)->cons) & INDEX_MASK(q)) == \
+      (((q)->prod) & INDEX_MASK(q))) && \
+     ((((q)->cons) & WRAP_MASK(q)) == \
+      (((q)->prod) & WRAP_MASK(q))))
+
+#define SMMUV3_CMDQ_ENABLED(s) \
+     (FIELD_EX32(s->cr[0], CR0, CMDQEN))
+
+#define SMMUV3_EVENTQ_ENABLED(s) \
+     (FIELD_EX32(s->cr[0], CR0, EVENTQEN))
+
+static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
+{
+    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
+}
+
+void smmuv3_write_eventq(SMMUv3State *s, Evt *evt);
+
+/* Commands */
+
+enum {
+    SMMU_CMD_PREFETCH_CONFIG = 0x01,
+    SMMU_CMD_PREFETCH_ADDR,
+    SMMU_CMD_CFGI_STE,
+    SMMU_CMD_CFGI_STE_RANGE,
+    SMMU_CMD_CFGI_CD,
+    SMMU_CMD_CFGI_CD_ALL,
+    SMMU_CMD_CFGI_ALL,
+    SMMU_CMD_TLBI_NH_ALL     = 0x10,
+    SMMU_CMD_TLBI_NH_ASID,
+    SMMU_CMD_TLBI_NH_VA,
+    SMMU_CMD_TLBI_NH_VAA,
+    SMMU_CMD_TLBI_EL3_ALL    = 0x18,
+    SMMU_CMD_TLBI_EL3_VA     = 0x1a,
+    SMMU_CMD_TLBI_EL2_ALL    = 0x20,
+    SMMU_CMD_TLBI_EL2_ASID,
+    SMMU_CMD_TLBI_EL2_VA,
+    SMMU_CMD_TLBI_EL2_VAA,  /* 0x23 */
+    SMMU_CMD_TLBI_S12_VMALL  = 0x28,
+    SMMU_CMD_TLBI_S2_IPA     = 0x2a,
+    SMMU_CMD_TLBI_NSNH_ALL   = 0x30,
+    SMMU_CMD_ATC_INV         = 0x40,
+    SMMU_CMD_PRI_RESP,
+    SMMU_CMD_RESUME          = 0x44,
+    SMMU_CMD_STALL_TERM,
+    SMMU_CMD_SYNC,          /* 0x46 */
+};
+
+static const char *cmd_stringify[] = {
+    [SMMU_CMD_PREFETCH_CONFIG] = "SMMU_CMD_PREFETCH_CONFIG",
+    [SMMU_CMD_PREFETCH_ADDR]   = "SMMU_CMD_PREFETCH_ADDR",
+    [SMMU_CMD_CFGI_STE]        = "SMMU_CMD_CFGI_STE",
+    [SMMU_CMD_CFGI_STE_RANGE]  = "SMMU_CMD_CFGI_STE_RANGE",
+    [SMMU_CMD_CFGI_CD]         = "SMMU_CMD_CFGI_CD",
+    [SMMU_CMD_CFGI_CD_ALL]     = "SMMU_CMD_CFGI_CD_ALL",
+    [SMMU_CMD_CFGI_ALL]        = "SMMU_CMD_CFGI_ALL",
+    [SMMU_CMD_TLBI_NH_ALL]     = "SMMU_CMD_TLBI_NH_ALL",
+    [SMMU_CMD_TLBI_NH_ASID]    = "SMMU_CMD_TLBI_NH_ASID",
+    [SMMU_CMD_TLBI_NH_VA]      = "SMMU_CMD_TLBI_NH_VA",
+    [SMMU_CMD_TLBI_NH_VAA]     = "SMMU_CMD_TLBI_NH_VAA",
+    [SMMU_CMD_TLBI_EL3_ALL]    = "SMMU_CMD_TLBI_EL3_ALL",
+    [SMMU_CMD_TLBI_EL3_VA]     = "SMMU_CMD_TLBI_EL3_VA",
+    [SMMU_CMD_TLBI_EL2_ALL]    = "SMMU_CMD_TLBI_EL2_ALL",
+    [SMMU_CMD_TLBI_EL2_ASID]   = "SMMU_CMD_TLBI_EL2_ASID",
+    [SMMU_CMD_TLBI_EL2_VA]     = "SMMU_CMD_TLBI_EL2_VA",
+    [SMMU_CMD_TLBI_EL2_VAA]    = "SMMU_CMD_TLBI_EL2_VAA",
+    [SMMU_CMD_TLBI_S12_VMALL]  = "SMMU_CMD_TLBI_S12_VMALL",
+    [SMMU_CMD_TLBI_S2_IPA]     = "SMMU_CMD_TLBI_S2_IPA",
+    [SMMU_CMD_TLBI_NSNH_ALL]   = "SMMU_CMD_TLBI_NSNH_ALL",
+    [SMMU_CMD_ATC_INV]         = "SMMU_CMD_ATC_INV",
+    [SMMU_CMD_PRI_RESP]        = "SMMU_CMD_PRI_RESP",
+    [SMMU_CMD_RESUME]          = "SMMU_CMD_RESUME",
+    [SMMU_CMD_STALL_TERM]      = "SMMU_CMD_STALL_TERM",
+    [SMMU_CMD_SYNC]            = "SMMU_CMD_SYNC",
+};
+
+/* CMDQ fields */
+
+typedef enum {
+    SMMU_CERROR_NONE = 0,
+    SMMU_CERROR_ILL,
+    SMMU_CERROR_ABT,
+    SMMU_CERROR_ATC_INV_SYNC,
+} SMMUCmdError;
+
+enum { /* Command completion notification */
+    CMD_SYNC_SIG_NONE,
+    CMD_SYNC_SIG_IRQ,
+    CMD_SYNC_SIG_SEV,
+};
+
+#define CMD_TYPE(x)  extract32((x)->word[0], 0, 8)
+#define CMD_SEC(x)   extract32((x)->word[0], 9, 1)
+#define CMD_SEV(x)   extract32((x)->word[0], 10, 1)
+#define CMD_AC(x)    extract32((x)->word[0], 12, 1)
+#define CMD_AB(x)    extract32((x)->word[0], 13, 1)
+#define CMD_CS(x)    extract32((x)->word[0], 12, 2)
+#define CMD_SSID(x)  extract32((x)->word[0], 16, 16)
+#define CMD_SID(x)   ((x)->word[1])
+#define CMD_VMID(x)  extract32((x)->word[1], 0, 16)
+#define CMD_ASID(x)  extract32((x)->word[1], 16, 16)
+#define CMD_STAG(x)  extract32((x)->word[2], 0, 16)
+#define CMD_RESP(x)  extract32((x)->word[2], 11, 2)
+#define CMD_GRPID(x) extract32((x)->word[3], 0, 8)
+#define CMD_SIZE(x)  extract32((x)->word[3], 0, 16)
+#define CMD_LEAF(x)  extract32((x)->word[3], 0, 1)
+#define CMD_SPAN(x)  extract32((x)->word[3], 0, 5)
+#define CMD_ADDR(x) ({                                  \
+            uint64_t addr = (uint64_t)(x)->word[3];     \
+            addr <<= 32;                                \
+            addr |=  extract32((x)->word[3], 12, 20);   \
+            addr;                                       \
+        })
+
+int smmuv3_cmdq_consume(SMMUv3State *s);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6bad7e8..79970d7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -94,6 +94,75 @@ void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(acked, s->gerrorn);
 }
 
+static uint32_t queue_index_inc(uint32_t val,
+                                uint32_t qidx_mask, uint32_t qwrap_mask)
+{
+    uint32_t i = (val + 1) & qidx_mask;
+
+    if (i <= (val & qidx_mask)) {
+        i = ((val & qwrap_mask) ^ qwrap_mask) | i;
+    } else {
+        i = (val & qwrap_mask) | i;
+    }
+    return i;
+}
+
+static MemTxResult smmu_queue_read(SMMUQueue *q, void *data)
+{
+    dma_addr_t addr = Q_CONS_ENTRY(q);
+    MemTxResult ret;
+
+    ret = dma_memory_read(&address_space_memory, addr,
+                          (uint8_t *)data, q->entry_size);
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+
+    q->cons = queue_index_inc(q->cons, INDEX_MASK(q), WRAP_MASK(q));
+    return ret;
+}
+
+static void smmu_queue_write(SMMUQueue *q, void *data)
+{
+    dma_addr_t addr = Q_PROD_ENTRY(q);
+    MemTxResult ret;
+
+    ret = dma_memory_write(&address_space_memory, addr,
+                           (uint8_t *)data, q->entry_size);
+    if (ret != MEMTX_OK) {
+        return;
+    }
+
+    q->prod = queue_index_inc(q->prod, INDEX_MASK(q), WRAP_MASK(q));
+}
+
+static inline MemTxResult smmuv3_read_cmdq(SMMUv3State *s, Cmd *cmd)
+{
+    SMMUQueue *q = &s->cmdq;
+    return smmu_queue_read(q, cmd);
+}
+
+void smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+{
+    SMMUQueue *q = &s->eventq;
+    bool q_empty = Q_EMPTY(q);
+    bool q_full = Q_FULL(q);
+
+    if (!SMMUV3_EVENTQ_ENABLED(s)) {
+        return;
+    }
+
+    if (q_full) {
+        return;
+    }
+
+    smmu_queue_write(q, evt);
+
+    if (q_empty) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+    }
+}
+
 static void smmuv3_init_regs(SMMUv3State *s)
 {
     /**
@@ -133,6 +202,88 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->sid_split = 0;
 }
 
+int smmuv3_cmdq_consume(SMMUv3State *s)
+{
+    SMMUCmdError cmd_error = SMMU_CERROR_NONE;
+    SMMUQueue *q = &s->cmdq;
+
+
+    if (!SMMUV3_CMDQ_ENABLED(s)) {
+        return 0;
+    }
+
+    while (!Q_EMPTY(q)) {
+        uint32_t pending = s->gerror ^ s->gerrorn;
+        uint32_t type;
+        Cmd cmd;
+
+        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
+                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
+
+        if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
+            break;
+        }
+
+        if (smmuv3_read_cmdq(s, &cmd) != MEMTX_OK) {
+            cmd_error = SMMU_CERROR_ABT;
+            break;
+        }
+
+        type = CMD_TYPE(&cmd);
+
+        switch (type) {
+        case SMMU_CMD_SYNC:
+            if (CMD_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
+                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
+            }
+            break;
+        case SMMU_CMD_PREFETCH_CONFIG:
+        case SMMU_CMD_PREFETCH_ADDR:
+        case SMMU_CMD_CFGI_STE:
+        case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
+        case SMMU_CMD_CFGI_CD:
+        case SMMU_CMD_CFGI_CD_ALL:
+        case SMMU_CMD_TLBI_NH_ALL:
+        case SMMU_CMD_TLBI_NH_ASID:
+        case SMMU_CMD_TLBI_NH_VA:
+        case SMMU_CMD_TLBI_NH_VAA:
+        case SMMU_CMD_TLBI_EL3_ALL:
+        case SMMU_CMD_TLBI_EL3_VA:
+        case SMMU_CMD_TLBI_EL2_ALL:
+        case SMMU_CMD_TLBI_EL2_ASID:
+        case SMMU_CMD_TLBI_EL2_VA:
+        case SMMU_CMD_TLBI_EL2_VAA:
+        case SMMU_CMD_TLBI_S12_VMALL:
+        case SMMU_CMD_TLBI_S2_IPA:
+        case SMMU_CMD_TLBI_NSNH_ALL:
+        case SMMU_CMD_ATC_INV:
+        case SMMU_CMD_PRI_RESP:
+        case SMMU_CMD_RESUME:
+        case SMMU_CMD_STALL_TERM:
+            trace_smmuv3_unhandled_cmd(type);
+            break;
+        default:
+            cmd_error = SMMU_CERROR_ILL;
+            error_report("Illegal command type: %d", CMD_TYPE(&cmd));
+            break;
+        }
+        if (type != SMMU_CERROR_ILL) {
+            trace_smmuv3_cmdq_opcode(cmd_stringify[type]);
+        }
+    }
+
+    if (cmd_error) {
+        error_report("GERROR_CMDQ: CONS.ERR=%d", cmd_error);
+        smmu_write_cmdq_err(s, cmd_error);
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+    }
+
+    trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
+                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
+
+    return 0;
+}
+
 static void smmu_write_mmio(void *opaque, hwaddr addr,
                             uint64_t val, unsigned size)
 {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 957a67e..d73e151 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -20,3 +20,7 @@ smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" va
 smmuv3_trigger_irq(int irq) "irq=%d"
 smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new gerror=0x%x"
 smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new gerrorn=0x%x"
+smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
+smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
+smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
+smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
-- 
2.5.5
