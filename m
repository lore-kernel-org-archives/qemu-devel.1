Received: from eggs.gnu.org ([2001:4830:134:3::10]:42862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXJ-0007ou-JC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXF-0003e2-1I
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:41 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:30 +0100
Message-Id: <1521549456-14072-9-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 08/14] hw/arm/smmuv3: Event queue recording
 helper
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

Let's introduce a helper function aiming at recording an
event in the event queue.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10:
- rework SMMU_EVENT_STRING
- trigger a GERROR EVENTQ_ABT_ERR in case of eventq write failure

v8 -> v9:
- add SMMU_EVENT_STRING

v7 -> v8:
- use dma_addr_t instead of hwaddr in smmuv3_record_event()
- introduce struct SMMUEventInfo
- add event_stringify + helpers for all fields
---
 hw/arm/smmuv3-internal.h | 142 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3.c          | 108 +++++++++++++++++++++++++++++++++--
 hw/arm/trace-events      |   1 +
 3 files changed, 243 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 8550be0..8e546bf 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -205,8 +205,6 @@ static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
     s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
 }
 
-void smmuv3_write_eventq(SMMUv3State *s, Evt *evt);
-
 /* Commands */
 
 typedef enum SMMUCommandType {
@@ -308,4 +306,144 @@ enum { /* Command completion notification */
 
 #define SMMU_FEATURE_2LVL_STE (1 << 0)
 
+/* Events */
+
+typedef enum SMMUEventType {
+    SMMU_EVT_OK                 = 0x00,
+    SMMU_EVT_F_UUT              = 0x01,
+    SMMU_EVT_C_BAD_STREAMID     = 0x02,
+    SMMU_EVT_F_STE_FETCH        = 0x03,
+    SMMU_EVT_C_BAD_STE          = 0x04,
+    SMMU_EVT_F_BAD_ATS_TREQ     = 0x05,
+    SMMU_EVT_F_STREAM_DISABLED  = 0x06,
+    SMMU_EVT_F_TRANS_FORBIDDEN  = 0x07,
+    SMMU_EVT_C_BAD_SUBSTREAMID  = 0x08,
+    SMMU_EVT_F_CD_FETCH         = 0x09,
+    SMMU_EVT_C_BAD_CD           = 0x0a,
+    SMMU_EVT_F_WALK_EABT        = 0x0b,
+    SMMU_EVT_F_TRANSLATION      = 0x10,
+    SMMU_EVT_F_ADDR_SIZE        = 0x11,
+    SMMU_EVT_F_ACCESS           = 0x12,
+    SMMU_EVT_F_PERMISSION       = 0x13,
+    SMMU_EVT_F_TLB_CONFLICT     = 0x20,
+    SMMU_EVT_F_CFG_CONFLICT     = 0x21,
+    SMMU_EVT_E_PAGE_REQ         = 0x24,
+} SMMUEventType;
+
+static const char *event_stringify[] = {
+    [SMMU_EVT_OK]                       = "SMMU_EVT_OK",
+    [SMMU_EVT_F_UUT]                    = "SMMU_EVT_F_UUT",
+    [SMMU_EVT_C_BAD_STREAMID]           = "SMMU_EVT_C_BAD_STREAMID",
+    [SMMU_EVT_F_STE_FETCH]              = "SMMU_EVT_F_STE_FETCH",
+    [SMMU_EVT_C_BAD_STE]                = "SMMU_EVT_C_BAD_STE",
+    [SMMU_EVT_F_BAD_ATS_TREQ]           = "SMMU_EVT_F_BAD_ATS_TREQ",
+    [SMMU_EVT_F_STREAM_DISABLED]        = "SMMU_EVT_F_STREAM_DISABLED",
+    [SMMU_EVT_F_TRANS_FORBIDDEN]        = "SMMU_EVT_F_TRANS_FORBIDDEN",
+    [SMMU_EVT_C_BAD_SUBSTREAMID]        = "SMMU_EVT_C_BAD_SUBSTREAMID",
+    [SMMU_EVT_F_CD_FETCH]               = "SMMU_EVT_F_CD_FETCH",
+    [SMMU_EVT_C_BAD_CD]                 = "SMMU_EVT_C_BAD_CD",
+    [SMMU_EVT_F_WALK_EABT]              = "SMMU_EVT_F_WALK_EABT",
+    [SMMU_EVT_F_TRANSLATION]            = "SMMU_EVT_F_TRANSLATION",
+    [SMMU_EVT_F_ADDR_SIZE]              = "SMMU_EVT_F_ADDR_SIZE",
+    [SMMU_EVT_F_ACCESS]                 = "SMMU_EVT_F_ACCESS",
+    [SMMU_EVT_F_PERMISSION]             = "SMMU_EVT_F_PERMISSION",
+    [SMMU_EVT_F_TLB_CONFLICT]           = "SMMU_EVT_F_TLB_CONFLICT",
+    [SMMU_EVT_F_CFG_CONFLICT]           = "SMMU_EVT_F_CFG_CONFLICT",
+    [SMMU_EVT_E_PAGE_REQ]               = "SMMU_EVT_E_PAGE_REQ",
+};
+
+static inline const char *smmu_event_string(SMMUEventType type)
+{
+    return event_stringify[type] ? event_stringify[type] : "UNKNOWN";
+}
+
+/*  Encode an event record */
+typedef struct SMMUEventInfo {
+    SMMUEventType type;
+    uint32_t sid;
+    bool recorded;
+    bool record_trans_faults;
+    union {
+        struct {
+            uint32_t ssid;
+            bool ssv;
+            dma_addr_t addr;
+            bool rnw;
+            bool pnu;
+            bool ind;
+       } f_uut;
+       struct ssid_info {
+            uint32_t ssid;
+            bool ssv;
+       } c_bad_streamid;
+       struct ssid_addr_info {
+            uint32_t ssid;
+            bool ssv;
+            dma_addr_t addr;
+       } f_ste_fetch;
+       struct ssid_info c_bad_ste;
+       struct {
+            dma_addr_t addr;
+            bool rnw;
+       } f_transl_forbidden;
+       struct {
+            uint32_t ssid;
+       } c_bad_substream;
+       struct ssid_addr_info f_cd_fetch;
+       struct ssid_info c_bad_cd;
+       struct full_info {
+            bool stall;
+            uint16_t stag;
+            uint32_t ssid;
+            bool ssv;
+            bool s2;
+            dma_addr_t addr;
+            bool rnw;
+            bool pnu;
+            bool ind;
+            uint8_t class;
+            dma_addr_t addr2;
+       } f_walk_eabt;
+       struct full_info f_translation;
+       struct full_info f_addr_size;
+       struct full_info f_access;
+       struct full_info f_permission;
+       struct ssid_info f_cfg_conflict;
+       /**
+        * not supported yet:
+        * F_BAD_ATS_TREQ
+        * F_BAD_ATS_TREQ
+        * F_TLB_CONFLICT
+        * E_PAGE_REQUEST
+        * IMPDEF_EVENTn
+        */
+    } u;
+} SMMUEventInfo;
+
+/* EVTQ fields */
+
+#define EVT_Q_OVERFLOW        (1 << 31)
+
+#define EVT_SET_TYPE(x, v)              deposit32((x)->word[0], 0 , 8 ,  v)
+#define EVT_SET_SSV(x, v)               deposit32((x)->word[0], 11, 1 ,  v)
+#define EVT_SET_SSID(x, v)              deposit32((x)->word[0], 12, 20, v)
+#define EVT_SET_SID(x, v)               ((x)->word[1] =  v)
+#define EVT_SET_STAG(x, v)              deposit32((x)->word[2], 0 , 16, v)
+#define EVT_SET_STALL(x, v)             deposit32((x)->word[2], 31, 1 , v)
+#define EVT_SET_PNU(x, v)               deposit32((x)->word[3], 1 , 1 , v)
+#define EVT_SET_IND(x, v)               deposit32((x)->word[3], 2 , 1 , v)
+#define EVT_SET_RNW(x, v)               deposit32((x)->word[3], 3 , 1 , v)
+#define EVT_SET_S2(x, v)                deposit32((x)->word[3], 7 , 1 , v)
+#define EVT_SET_CLASS(x, v)             deposit32((x)->word[3], 8 , 2 , v)
+#define EVT_SET_ADDR(x, addr) ({                    \
+            (x)->word[5] = (uint32_t)(addr >> 32);        \
+            (x)->word[4] = (uint32_t)(addr & 0xffffffff); \
+        })
+#define EVT_SET_ADDR2(x, addr) ({                    \
+            deposit32((x)->word[7], 3, 29, addr >> 16);        \
+            deposit32((x)->word[7], 0, 16, addr & 0xffff); \
+        })
+
+void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 77ec58d..30daad6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -116,23 +116,119 @@ static MemTxResult queue_write(SMMUQueue *q, void *data)
     return MEMTX_OK;
 }
 
-void smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
+static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
 {
     SMMUQueue *q = &s->eventq;
+    MemTxResult r;
+
+    if (!smmuv3_eventq_enabled(s)) {
+        return MEMTX_ERROR;
+    }
+
+    if (smmuv3_q_full(q)) {
+        return MEMTX_ERROR;
+    }
+
+    r = queue_write(q, evt);
+    if (r != MEMTX_OK) {
+        return r;
+    }
+
+    if (smmuv3_q_empty(q)) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+    }
+    return MEMTX_OK;
+}
+
+void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
+{
+    Evt evt;
+    MemTxResult r;
 
     if (!smmuv3_eventq_enabled(s)) {
         return;
     }
 
-    if (smmuv3_q_full(q)) {
+    EVT_SET_TYPE(&evt, info->type);
+    EVT_SET_SID(&evt, info->sid);
+
+    switch (info->type) {
+    case SMMU_EVT_OK:
         return;
+    case SMMU_EVT_F_UUT:
+        EVT_SET_SSID(&evt, info->u.f_uut.ssid);
+        EVT_SET_SSV(&evt,  info->u.f_uut.ssv);
+        EVT_SET_ADDR(&evt, info->u.f_uut.addr);
+        EVT_SET_RNW(&evt,  info->u.f_uut.rnw);
+        EVT_SET_PNU(&evt,  info->u.f_uut.pnu);
+        EVT_SET_IND(&evt,  info->u.f_uut.ind);
+        break;
+    case SMMU_EVT_C_BAD_STREAMID:
+        EVT_SET_SSID(&evt, info->u.c_bad_streamid.ssid);
+        EVT_SET_SSV(&evt,  info->u.c_bad_streamid.ssv);
+        break;
+    case SMMU_EVT_F_STE_FETCH:
+        EVT_SET_SSID(&evt, info->u.f_ste_fetch.ssid);
+        EVT_SET_SSV(&evt,  info->u.f_ste_fetch.ssv);
+        EVT_SET_ADDR(&evt, info->u.f_ste_fetch.addr);
+        break;
+    case SMMU_EVT_C_BAD_STE:
+        EVT_SET_SSID(&evt, info->u.c_bad_ste.ssid);
+        EVT_SET_SSV(&evt,  info->u.c_bad_ste.ssv);
+        break;
+    case SMMU_EVT_F_STREAM_DISABLED:
+        break;
+    case SMMU_EVT_F_TRANS_FORBIDDEN:
+        EVT_SET_ADDR(&evt, info->u.f_transl_forbidden.addr);
+        EVT_SET_RNW(&evt, info->u.f_transl_forbidden.rnw);
+        break;
+    case SMMU_EVT_C_BAD_SUBSTREAMID:
+        EVT_SET_SSID(&evt, info->u.c_bad_substream.ssid);
+        break;
+    case SMMU_EVT_F_CD_FETCH:
+        EVT_SET_SSID(&evt, info->u.f_cd_fetch.ssid);
+        EVT_SET_SSV(&evt,  info->u.f_cd_fetch.ssv);
+        EVT_SET_ADDR(&evt, info->u.f_cd_fetch.addr);
+        break;
+    case SMMU_EVT_C_BAD_CD:
+        EVT_SET_SSID(&evt, info->u.c_bad_cd.ssid);
+        EVT_SET_SSV(&evt,  info->u.c_bad_cd.ssv);
+        break;
+    case SMMU_EVT_F_WALK_EABT:
+    case SMMU_EVT_F_TRANSLATION:
+    case SMMU_EVT_F_ADDR_SIZE:
+    case SMMU_EVT_F_ACCESS:
+    case SMMU_EVT_F_PERMISSION:
+        EVT_SET_STALL(&evt, info->u.f_walk_eabt.stall);
+        EVT_SET_STAG(&evt, info->u.f_walk_eabt.stag);
+        EVT_SET_SSID(&evt, info->u.f_walk_eabt.ssid);
+        EVT_SET_SSV(&evt, info->u.f_walk_eabt.ssv);
+        EVT_SET_S2(&evt, info->u.f_walk_eabt.s2);
+        EVT_SET_ADDR(&evt, info->u.f_walk_eabt.addr);
+        EVT_SET_RNW(&evt, info->u.f_walk_eabt.rnw);
+        EVT_SET_PNU(&evt, info->u.f_walk_eabt.pnu);
+        EVT_SET_IND(&evt, info->u.f_walk_eabt.ind);
+        EVT_SET_CLASS(&evt, info->u.f_walk_eabt.class);
+        EVT_SET_ADDR2(&evt, info->u.f_walk_eabt.addr2);
+        break;
+    case SMMU_EVT_F_CFG_CONFLICT:
+        EVT_SET_SSID(&evt, info->u.f_cfg_conflict.ssid);
+        EVT_SET_SSV(&evt,  info->u.f_cfg_conflict.ssv);
+        break;
+    /* rest is not implemented */
+    case SMMU_EVT_F_BAD_ATS_TREQ:
+    case SMMU_EVT_F_TLB_CONFLICT:
+    case SMMU_EVT_E_PAGE_REQ:
+    default:
+        g_assert_not_reached();
     }
 
-    queue_write(q, evt);
-
-    if (smmuv3_q_empty(q)) {
-        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
+    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
+    r = smmuv3_write_eventq(s, &evt);
+    if (r != MEMTX_OK) {
+        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
     }
+    info->recorded = true;
 }
 
 static void smmuv3_init_regs(SMMUv3State *s)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 781542a..9936e10 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -29,3 +29,4 @@ smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr:
 smmuv3_write_mmio_idr(uint64_t addr, uint64_t val) "write to RO/Unimpl reg 0x%lx val64:0x%lx"
 smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
 smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_record_event(const char *type, uint32_t sid) "%s sid=%d"
-- 
2.5.5
