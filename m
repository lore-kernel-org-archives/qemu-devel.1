Received: from eggs.gnu.org ([2001:4830:134:3::10]:37109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpf0-0005lg-PU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpev-0003Dq-Oe
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:14 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:12 +0200
Message-Id: <1504286483-23327-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/20] hw/arm/smmuv3: Event queue recording
 helper
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

Let's introduce a helper function aiming at recording an
event in the event queue.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

At the moment, for some events we do not fill all the fields.
Typically filling the FetchAddr field resulting of an abort
on page table walk would require to return more information
from this latter in case of error.

However with enabled use cases I have not seen any event
recorded yet.
---
 hw/arm/smmuv3-internal.h | 45 ++++++++++++++++++++++++--
 hw/arm/smmuv3.c          | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a5d60b4..e3e9828 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -259,8 +259,6 @@ static inline void smmu_write_cmdq_err(SMMUV3State *s, uint32_t err_type)
                         regval | err_type << SMMU_CMD_CONS_ERR_SHIFT);
 }
 
-void smmuv3_write_evtq(SMMUV3State *s, Evt *evt);
-
 /*****************************
  * Commands
  *****************************/
@@ -361,4 +359,47 @@ enum { /* Command completion notification */
             addr;                                       \
         })
 
+/*****************************
+ * EVTQ fields
+ *****************************/
+
+#define EVT_Q_OVERFLOW        (1 << 31)
+
+#define EVT_SET_TYPE(x, t)    deposit32((x)->word[0], 0, 8, t)
+#define EVT_SET_SID(x, s)     ((x)->word[1] =  s)
+#define EVT_SET_INPUT_ADDR(x, addr) ({                    \
+            (x)->word[5] = (uint32_t)(addr >> 32);        \
+            (x)->word[4] = (uint32_t)(addr & 0xffffffff); \
+        })
+#define EVT_SET_RNW(x, rnw)     deposit32((x)->word[3], 3, 1, rnw)
+
+/*****************************
+ * Events
+ *****************************/
+
+typedef enum evt_err {
+    SMMU_EVT_OK,
+    SMMU_EVT_F_UUT,
+    SMMU_EVT_C_BAD_SID,
+    SMMU_EVT_F_STE_FETCH,
+    SMMU_EVT_C_BAD_STE,
+    SMMU_EVT_F_BAD_ATS_REQ,
+    SMMU_EVT_F_STREAM_DISABLED,
+    SMMU_EVT_F_TRANS_FORBIDDEN,
+    SMMU_EVT_C_BAD_SSID,
+    SMMU_EVT_F_CD_FETCH,
+    SMMU_EVT_C_BAD_CD,
+    SMMU_EVT_F_WALK_EXT_ABRT,
+    SMMU_EVT_F_TRANS        = 0x10,
+    SMMU_EVT_F_ADDR_SZ,
+    SMMU_EVT_F_ACCESS,
+    SMMU_EVT_F_PERM,
+    SMMU_EVT_F_TLB_CONFLICT = 0x20,
+    SMMU_EVT_F_CFG_CONFLICT = 0x21,
+    SMMU_EVT_E_PAGE_REQ     = 0x24,
+} SMMUEvtErr;
+
+void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
+                         uint32_t sid, bool is_write, SMMUEvtErr type);
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f35fadc..7470576 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -132,7 +132,7 @@ static MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd)
     return ret;
 }
 
-void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
+static void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
 {
     SMMUQueue *q = &s->evtq;
     bool was_empty = smmu_is_q_empty(s, q);
@@ -157,6 +157,88 @@ void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
     }
 }
 
+/*
+ * smmuv3_record_event - Record an event
+ */
+void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
+                         uint32_t sid, IOMMUAccessFlags perm,
+                         SMMUEvtErr type)
+{
+    Evt evt;
+    bool rnw = perm & IOMMU_RO;
+
+    if (!smmu_evt_q_enabled(s)) {
+        return;
+    }
+
+    EVT_SET_TYPE(&evt, type);
+    EVT_SET_SID(&evt, sid);
+    /* SSV=0 (substream invalid) and substreamID= 0 */
+
+    switch (type) {
+    case SMMU_EVT_OK:
+        return;
+    case SMMU_EVT_F_UUT:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        /* PnU and Ind not filled */
+        break;
+    case SMMU_EVT_C_BAD_SID:
+        break;
+    case SMMU_EVT_F_STE_FETCH:
+        /* Implementation defined and FetchAddr not filled yet */
+        break;
+    case SMMU_EVT_C_BAD_STE:
+        break;
+    case SMMU_EVT_F_BAD_ATS_REQ:
+        /* ATS not yet implemented */
+        break;
+    case SMMU_EVT_F_STREAM_DISABLED:
+        break;
+    case SMMU_EVT_F_TRANS_FORBIDDEN:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        break;
+    case SMMU_EVT_C_BAD_SSID:
+        break;
+    case SMMU_EVT_F_CD_FETCH:
+        break;
+    case SMMU_EVT_C_BAD_CD:
+        /* Implementation defined and FetchAddr not filled yet */
+        break;
+    case SMMU_EVT_F_WALK_EXT_ABRT:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        /* Reason, Class, S2, Ind, PnU, FetchAddr not filled yet */
+        break;
+    case SMMU_EVT_F_TRANS:
+    case SMMU_EVT_F_ADDR_SZ:
+    case SMMU_EVT_F_ACCESS:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        /* STAG, Class, S2, InD, PnU, IPA not filled yet */
+        break;
+    case SMMU_EVT_F_PERM:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        /* STAG, TTRnW, Class, S2, InD, PnU, IPA not filled yet */
+        break;
+    case SMMU_EVT_F_TLB_CONFLICT:
+        EVT_SET_INPUT_ADDR(&evt, iova);
+        EVT_SET_RNW(&evt, rnw);
+        /* Reason, S2, InD, PnU, IPA not filled yet */
+        break;
+    case SMMU_EVT_F_CFG_CONFLICT:
+        /* Implementation defined reason not filled yet */
+        break;
+    case SMMU_EVT_E_PAGE_REQ:
+        /* PRI not supported */
+        break;
+    }
+
+    smmuv3_write_evtq(s, &evt);
+}
+
 static void smmuv3_init_regs(SMMUV3State *s)
 {
     uint32_t data =
-- 
2.5.5
