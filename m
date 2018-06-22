Received: from eggs.gnu.org ([2001:4830:134:3::10]:41315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWGku-00011P-Ic
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWGks-0000Dr-SJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:45:16 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 22 Jun 2018 09:44:58 +0200
Message-Id: <1529653501-15358-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529653501-15358-1-git-send-email-eric.auger@redhat.com>
References: <1529653501-15358-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/4] hw/arm/smmuv3: Fix translate error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, jia.he@hxt-semitech.com, hejianet@gmail.com

From: Jia He <hejianet@gmail.com>

In case the STE's config is "Bypass" we currently don't set the
IOMMUTLBEntry perm flags and the access does not succeed. Also
if the config is 0b0xx (Aborted/Reserved), decode_ste and
smmuv3_decode_config currently returns -EINVAL and we don't enter
the expected code path: we record an event whereas we should not.

This patch fixes those bugs and simplifies the error handling.
decode_ste and smmuv3_decode_config now return 0 if aborted or
bypassed config was found. Only bad config info produces negative
error values. In smmuv3_translate we more clearly differentiate
errors, bypass/smmu disabled, aborted and success cases. Also
trace points are differentiated.

Fixes: 9bde7f0674fe ("hw/arm/smmuv3: Implement translate callback")
Reported-by: jia.he@hxt-semitech.com
Signed-off-by: jia.he@hxt-semitech.com
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v2 -> v3:
- added Peter's R-b

v1 -> v2:
- set addr_mask in case of bypass and disabled. Mandated for
  vhost use case since a411c84b561baa94b28165c52f21c33517ee8f59
  "exec: extract address_space_translate_iommu, fix page_mask
  corner case"
---
 hw/arm/smmuv3-internal.h | 12 +++++-
 hw/arm/smmuv3.c          | 96 +++++++++++++++++++++++++++++++++---------------
 hw/arm/trace-events      |  7 ++--
 3 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index a9d714b..bab25d6 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -23,6 +23,14 @@
 
 #include "hw/arm/smmu-common.h"
 
+typedef enum SMMUTranslationStatus {
+    SMMU_TRANS_DISABLE,
+    SMMU_TRANS_ABORT,
+    SMMU_TRANS_BYPASS,
+    SMMU_TRANS_ERROR,
+    SMMU_TRANS_SUCCESS,
+} SMMUTranslationStatus;
+
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
@@ -315,7 +323,7 @@ enum { /* Command completion notification */
 /* Events */
 
 typedef enum SMMUEventType {
-    SMMU_EVT_OK                 = 0x00,
+    SMMU_EVT_NONE               = 0x00,
     SMMU_EVT_F_UUT                    ,
     SMMU_EVT_C_BAD_STREAMID           ,
     SMMU_EVT_F_STE_FETCH              ,
@@ -337,7 +345,7 @@ typedef enum SMMUEventType {
 } SMMUEventType;
 
 static const char *event_stringify[] = {
-    [SMMU_EVT_OK]                       = "SMMU_EVT_OK",
+    [SMMU_EVT_NONE]                     = "no recorded event",
     [SMMU_EVT_F_UUT]                    = "SMMU_EVT_F_UUT",
     [SMMU_EVT_C_BAD_STREAMID]           = "SMMU_EVT_C_BAD_STREAMID",
     [SMMU_EVT_F_STE_FETCH]              = "SMMU_EVT_F_STE_FETCH",
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9783309..70b8f29 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "exec/address-spaces.h"
+#include "cpu.h"
 #include "trace.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
@@ -154,7 +155,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     EVT_SET_SID(&evt, info->sid);
 
     switch (info->type) {
-    case SMMU_EVT_OK:
+    case SMMU_EVT_NONE:
         return;
     case SMMU_EVT_F_UUT:
         EVT_SET_SSID(&evt, info->u.f_uut.ssid);
@@ -312,12 +313,11 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
     return 0;
 }
 
-/* Returns <0 if the caller has no need to continue the translation */
+/* Returns < 0 in case of invalid STE, 0 otherwise */
 static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
-    int ret = -EINVAL;
 
     if (!STE_VALID(ste)) {
         goto bad_ste;
@@ -326,13 +326,13 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     config = STE_CONFIG(ste);
 
     if (STE_CFG_ABORT(config)) {
-        cfg->aborted = true; /* abort but don't record any event */
-        return ret;
+        cfg->aborted = true;
+        return 0;
     }
 
     if (STE_CFG_BYPASS(config)) {
         cfg->bypassed = true;
-        return ret;
+        return 0;
     }
 
     if (STE_CFG_S2_ENABLED(config)) {
@@ -509,7 +509,7 @@ bad_cd:
  *       the different configuration decoding steps
  * @event: must be zero'ed by the caller
  *
- * return < 0 if the translation needs to be aborted (@event is filled
+ * return < 0 in case of config decoding error (@event is filled
  * accordingly). Return 0 otherwise.
  */
 static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
@@ -518,19 +518,26 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     uint32_t sid = smmu_get_sid(sdev);
     SMMUv3State *s = sdev->smmu;
-    int ret = -EINVAL;
+    int ret;
     STE ste;
     CD cd;
 
-    if (smmu_find_ste(s, sid, &ste, event)) {
+    ret = smmu_find_ste(s, sid, &ste, event);
+    if (ret) {
         return ret;
     }
 
-    if (decode_ste(s, cfg, &ste, event)) {
+    ret = decode_ste(s, cfg, &ste, event);
+    if (ret) {
         return ret;
     }
 
-    if (smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event)) {
+    if (cfg->aborted || cfg->bypassed) {
+        return 0;
+    }
+
+    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
+    if (ret) {
         return ret;
     }
 
@@ -543,8 +550,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUEventInfo event = {.type = SMMU_EVT_OK, .sid = sid};
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid};
     SMMUPTWEventInfo ptw_info = {};
+    SMMUTranslationStatus status;
     SMMUTransCfg cfg = {};
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
@@ -553,23 +561,28 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
-    int ret = 0;
 
     if (!smmu_enabled(s)) {
-        goto out;
+        status = SMMU_TRANS_DISABLE;
+        goto epilogue;
     }
 
-    ret = smmuv3_decode_config(mr, &cfg, &event);
-    if (ret) {
-        goto out;
+    if (smmuv3_decode_config(mr, &cfg, &event)) {
+        status = SMMU_TRANS_ERROR;
+        goto epilogue;
     }
 
     if (cfg.aborted) {
-        goto out;
+        status = SMMU_TRANS_ABORT;
+        goto epilogue;
     }
 
-    ret = smmu_ptw(&cfg, addr, flag, &entry, &ptw_info);
-    if (ret) {
+    if (cfg.bypassed) {
+        status = SMMU_TRANS_BYPASS;
+        goto epilogue;
+    }
+
+    if (smmu_ptw(&cfg, addr, flag, &entry, &ptw_info)) {
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event.type = SMMU_EVT_F_WALK_EABT;
@@ -609,18 +622,41 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         default:
             g_assert_not_reached();
         }
+        status = SMMU_TRANS_ERROR;
+    } else {
+        status = SMMU_TRANS_SUCCESS;
     }
-out:
-    if (ret) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s translation failed for iova=0x%"PRIx64"(%d)\n",
-                      mr->parent_obj.name, addr, ret);
-        entry.perm = IOMMU_NONE;
-        smmuv3_record_event(s, &event);
-    } else if (!cfg.aborted) {
+
+epilogue:
+    switch (status) {
+    case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
-        trace_smmuv3_translate(mr->parent_obj.name, sid, addr,
-                               entry.translated_addr, entry.perm);
+        trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
+                                       entry.translated_addr, entry.perm);
+        break;
+    case SMMU_TRANS_DISABLE:
+        entry.perm = flag;
+        entry.addr_mask = ~TARGET_PAGE_MASK;
+        trace_smmuv3_translate_disable(mr->parent_obj.name, sid, addr,
+                                      entry.perm);
+        break;
+    case SMMU_TRANS_BYPASS:
+        entry.perm = flag;
+        entry.addr_mask = ~TARGET_PAGE_MASK;
+        trace_smmuv3_translate_bypass(mr->parent_obj.name, sid, addr,
+                                      entry.perm);
+        break;
+    case SMMU_TRANS_ABORT:
+        /* no event is recorded on abort */
+        trace_smmuv3_translate_abort(mr->parent_obj.name, sid, addr,
+                                     entry.perm);
+        break;
+    case SMMU_TRANS_ERROR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s translation failed for iova=0x%"PRIx64"(%s)\n",
+                      mr->parent_obj.name, addr, smmu_event_string(event.type));
+        smmuv3_record_event(s, &event);
+        break;
     }
 
     return entry;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2d92727..0ab66bb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -33,9 +33,10 @@ smmuv3_record_event(const char *type, uint32_t sid) "%s sid=%d"
 smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "SID:0x%x features:0x%x, sid_split:0x%x"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
-smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=%d bypass iova:0x%"PRIx64" is_write=%d"
-smmuv3_translate_in(uint16_t sid, int pci_bus_num, uint64_t strtab_base) "SID:0x%x bus:%d strtab_base:0x%"PRIx64
+smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=%d bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=%d STE bypass iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=%d abort on iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
-smmuv3_translate(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d"
-- 
2.5.5
