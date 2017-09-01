Received: from eggs.gnu.org ([2001:4830:134:3::10]:36866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpei-0005Yu-Qc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnped-0002th-SK
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:22:56 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:10 +0200
Message-Id: <1504286483-23327-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 07/20] hw/arm/smmuv3: Queue helpers
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

We introduce helpers to read/write into the circular queues.
smmuv3_read_cmdq and smmuv3_write_evtq will become static
later on.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h | 48 ++++++++++++++++++++++++++++++-
 hw/arm/smmuv3.c          | 75 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 2b44ee2..d88f141 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -215,7 +215,53 @@ static inline int smmu_enabled(SMMUV3State *s)
 
 #define SMMU_CMDQ_ERR(s) (SMMU_PENDING_GERRORS(s) & SMMU_GERROR_CMDQ)
 
-void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val);
 void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn);
 
+/***************************
+ * Queue Handling
+ ***************************/
+
+typedef enum {
+    CMD_Q_EMPTY,
+    CMD_Q_FULL,
+    CMD_Q_PARTIALLY_FILLED,
+} SMMUQStatus;
+
+#define Q_ENTRY(q, idx)  (q->base + q->ent_size * idx)
+#define Q_WRAP(q, pc)    ((pc) >> (q)->shift)
+#define Q_IDX(q, pc)     ((pc) & ((1 << (q)->shift) - 1))
+
+static inline SMMUQStatus __smmu_queue_status(SMMUV3State *s, SMMUQueue *q)
+{
+    uint32_t prod = Q_IDX(q, q->prod);
+    uint32_t cons = Q_IDX(q, q->cons);
+
+    if ((prod == cons) && (q->wrap.prod != q->wrap.cons)) {
+        return CMD_Q_FULL;
+    } else if ((prod == cons) && (q->wrap.prod == q->wrap.cons)) {
+        return CMD_Q_EMPTY;
+    }
+    return CMD_Q_PARTIALLY_FILLED;
+}
+#define smmu_is_q_full(s, q) (__smmu_queue_status(s, q) == CMD_Q_FULL)
+#define smmu_is_q_empty(s, q) (__smmu_queue_status(s, q) == CMD_Q_EMPTY)
+
+static inline int __smmu_q_enabled(SMMUV3State *s, uint32_t q)
+{
+    return smmu_read32_reg(s, SMMU_REG_CR0) & q;
+}
+#define smmu_cmd_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_CMDQ_ENABLE)
+#define smmu_evt_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_EVTQ_ENABLE)
+
+static inline void smmu_write_cmdq_err(SMMUV3State *s, uint32_t err_type)
+{
+    uint32_t regval = smmu_read32_reg(s, SMMU_REG_CMDQ_CONS);
+
+    smmu_write32_reg(s, SMMU_REG_CMDQ_CONS,
+                        regval | err_type << SMMU_CMD_CONS_ERR_SHIFT);
+}
+
+MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd);
+void smmuv3_write_evtq(SMMUV3State *s, Evt *evt);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 468134f..2f96463 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -36,7 +36,7 @@
  * @irq: irq type
  * @gerror: gerror new value, only relevant if @irq is GERROR
  */
-void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val)
+static void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val)
 {
     uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
     bool pulse = false;
@@ -84,6 +84,79 @@ void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn)
     trace_smmuv3_write_gerrorn(gerrorn, sanitized, SMMU_PENDING_GERRORS(s));
 }
 
+static MemTxResult smmu_q_read(SMMUQueue *q, void *data)
+{
+    uint64_t addr = Q_ENTRY(q, Q_IDX(q, q->cons));
+    MemTxResult ret;
+
+    ret = smmu_read_sysmem(addr, data, q->ent_size, false);
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+
+    q->cons++;
+    if (q->cons == q->entries) {
+        q->cons = 0;
+        q->wrap.cons++;
+    }
+
+    return ret;
+}
+
+static void smmu_q_write(SMMUQueue *q, void *data)
+{
+    uint64_t addr = Q_ENTRY(q, Q_IDX(q, q->prod));
+
+    smmu_write_sysmem(addr, data, q->ent_size, false);
+
+    q->prod++;
+    if (q->prod == q->entries) {
+        q->prod = 0;
+        q->wrap.prod++;
+    }
+}
+
+MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd)
+{
+    SMMUQueue *q = &s->cmdq;
+    MemTxResult ret = smmu_q_read(q, cmd);
+    uint32_t val = 0;
+
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+
+    val |= (q->wrap.cons << q->shift) | q->cons;
+    smmu_write32_reg(s, SMMU_REG_CMDQ_CONS, val);
+
+    return ret;
+}
+
+void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
+{
+    SMMUQueue *q = &s->evtq;
+    bool was_empty = smmu_is_q_empty(s, q);
+    bool was_full = smmu_is_q_full(s, q);
+    uint32_t val;
+
+    if (!smmu_evt_q_enabled(s)) {
+        return;
+    }
+
+    if (was_full) {
+        return;
+    }
+
+    smmu_q_write(q, evt);
+
+    val = (q->wrap.prod << q->shift) | q->prod;
+    smmu_write32_reg(s, SMMU_REG_EVTQ_PROD, val);
+
+    if (was_empty) {
+        smmuv3_irq_trigger(s, SMMU_IRQ_EVTQ, 0);
+    }
+}
+
 static void smmuv3_init_regs(SMMUV3State *s)
 {
     uint32_t data =
-- 
2.5.5
