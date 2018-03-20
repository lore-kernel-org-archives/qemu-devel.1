Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGX3-0007U8-3W
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGX1-0003QI-AG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:25 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:28 +0100
Message-Id: <1521549456-14072-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 06/14] hw/arm/smmuv3: Queue helpers
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

We introduce helpers to read/write into the command and event
circular queues.

smmuv3_write_eventq and smmuv3_cmq_consume will become static
in subsequent patches.

Invalidation commands are not yet dealt with. We do not cache
data that need to be invalidated. This will change with vhost
integration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---
v9 -> v10:
- simplified macros
- s/BASE/Q_BASE
- use log2size field
- static inline functions replacing some macros
- simplified queue_prod_incr/queue_cons_incr and use deposit32
- trace for cmdq_consume failure

v8 -> v9:
- fix CMD_SSID & CMD_ADDR + some renamings
- do cons increment after the execution of the command
- add Q_INCONSISTENT()

v7 -> v8
- use address_space_rw
- helpers inspired from spec
---
 hw/arm/smmuv3-internal.h | 154 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c          | 136 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   5 ++
 3 files changed, 295 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 32f81d4..968fa25 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -156,4 +156,158 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
 void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
 void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
 
+/* Queue Handling */
+
+#define Q_BASE(q)          ((q)->base & SMMU_BASE_ADDR_MASK)
+#define WRAP_MASK(q)       (1 << (q)->log2size)
+#define INDEX_MASK(q)      (((1 << (q)->log2size)) - 1)
+#define WRAP_INDEX_MASK(q) ((1 << ((q)->log2size + 1)) - 1)
+
+#define Q_CONS(q) ((q)->cons & INDEX_MASK(q))
+#define Q_PROD(q) ((q)->prod & INDEX_MASK(q))
+
+#define Q_CONS_ENTRY(q)  (Q_BASE(q) + (q)->entry_size * Q_CONS(q))
+#define Q_PROD_ENTRY(q)  (Q_BASE(q) + (q)->entry_size * Q_PROD(q))
+
+#define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
+#define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
+
+static inline bool smmuv3_q_full(SMMUQueue *q)
+{
+    return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
+}
+
+static inline bool smmuv3_q_empty(SMMUQueue *q)
+{
+    return (q->cons & WRAP_INDEX_MASK(q)) == (q->prod & WRAP_INDEX_MASK(q));
+}
+
+static inline void queue_prod_incr(SMMUQueue *q)
+{
+    q->prod = (q->prod + 1) & WRAP_INDEX_MASK(q);
+}
+
+static inline void queue_cons_incr(SMMUQueue *q)
+{
+    q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
+}
+
+static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
+}
+
+static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
+}
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
+typedef enum SMMUCommandType {
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
+} SMMUCommandType;
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
+static inline const char *smmu_cmd_string(SMMUCommandType type)
+{
+    return cmd_stringify[type] ? cmd_stringify[type] : "UNKNOWN";
+}
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
+#define CMD_TYPE(x)         extract32((x)->word[0], 0 , 8)
+#define CMD_SSEC(x)         extract32((x)->word[0], 10, 1)
+#define CMD_SSV(x)          extract32((x)->word[0], 11, 1)
+#define CMD_RESUME_AC(x)    extract32((x)->word[0], 12, 1)
+#define CMD_RESUME_AB(x)    extract32((x)->word[0], 13, 1)
+#define CMD_SYNC_CS(x)      extract32((x)->word[0], 12, 2)
+#define CMD_SSID(x)         extract32((x)->word[0], 12, 20)
+#define CMD_SID(x)          ((x)->word[1])
+#define CMD_VMID(x)         extract32((x)->word[1], 0 , 16)
+#define CMD_ASID(x)         extract32((x)->word[1], 16, 16)
+#define CMD_RESUME_STAG(x)  extract32((x)->word[2], 0 , 16)
+#define CMD_RESP(x)         extract32((x)->word[2], 11, 2)
+#define CMD_LEAF(x)         extract32((x)->word[2], 0 , 1)
+#define CMD_STE_RANGE(x)    extract32((x)->word[2], 0 , 5)
+#define CMD_ADDR(x) ({                                        \
+            uint64_t high = (uint64_t)(x)->word[3];           \
+            uint64_t low = extract32((x)->word[2], 12, 20);    \
+            uint64_t addr = high << 32 | (low << 12);         \
+            addr;                                             \
+        })
+
+int smmuv3_cmdq_consume(SMMUv3State *s);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 990c02e..6c9d68b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -94,6 +94,46 @@ void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
 }
 
+static inline MemTxResult queue_read(SMMUQueue *q, void *data)
+{
+    dma_addr_t addr = Q_CONS_ENTRY(q);
+
+    return dma_memory_read(&address_space_memory, addr, data, q->entry_size);
+}
+
+static MemTxResult queue_write(SMMUQueue *q, void *data)
+{
+    dma_addr_t addr = Q_PROD_ENTRY(q);
+    MemTxResult ret;
+
+    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size);
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+
+    queue_prod_incr(q);
+    return MEMTX_OK;
+}
+
+void smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+{
+    SMMUQueue *q = &s->eventq;
+
+    if (!smmuv3_eventq_enabled(s)) {
+        return;
+    }
+
+    if (smmuv3_q_full(q)) {
+        return;
+    }
+
+    queue_write(q, evt);
+
+    if (smmuv3_q_empty(q)) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+    }
+}
+
 static void smmuv3_init_regs(SMMUv3State *s)
 {
     /**
@@ -133,6 +173,102 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->sid_split = 0;
 }
 
+int smmuv3_cmdq_consume(SMMUv3State *s)
+{
+    SMMUCmdError cmd_error = SMMU_CERROR_NONE;
+    SMMUQueue *q = &s->cmdq;
+    SMMUCommandType type = 0;
+
+    if (!smmuv3_cmdq_enabled(s)) {
+        return 0;
+    }
+    /*
+     * some commands depend on register values, typically CR0. In case those
+     * register values change while handling the command, spec says it
+     * is UNPREDICTABLE whether the command is interpreted under the new
+     * or old value.
+     */
+
+    while (!smmuv3_q_empty(q)) {
+        uint32_t pending = s->gerror ^ s->gerrorn;
+        Cmd cmd;
+
+        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
+                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
+
+        if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
+            break;
+        }
+
+        if (queue_read(q, &cmd) != MEMTX_OK) {
+            cmd_error = SMMU_CERROR_ABT;
+            break;
+        }
+
+        type = CMD_TYPE(&cmd);
+
+        trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
+
+        switch (type) {
+        case SMMU_CMD_SYNC:
+            if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
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
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Illegal command type: %d\n", CMD_TYPE(&cmd));
+            break;
+        }
+        if (cmd_error) {
+            break;
+        }
+        /*
+         * We only increment the cons index after the completion of
+         * the command. We do that because the SYNC returns immediately
+         * and does not check the completion of previous commands
+         */
+        queue_cons_incr(q);
+    }
+
+    if (cmd_error) {
+        trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
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
 static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
                                    unsigned size, MemTxAttrs attrs)
 {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index b77f8d2..38b35fa 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -18,3 +18,8 @@ smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr:
 smmuv3_trigger_irq(int irq) "irq=%d"
 smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
 smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
+smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
+smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
+smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
+smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
+smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
-- 
2.5.5
