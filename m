Received: from eggs.gnu.org ([2001:4830:134:3::10]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHQ-0002Gs-0k
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHO-0007KL-4g
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHN-0007JA-PA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHM-0000DM-DD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:54 +0100
Message-Id: <20180626165658.31394-29-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/32] hw/arm/smmuv3: IOTLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We emulate a TLB cache of size SMMU_IOTLB_MAX_SIZE=256.
It is implemented as a hash table whose key is a combination
of the 16b asid and 48b IOVA (Jenkins hash).

Entries are invalidated on TLB invalidation commands, either
globally, or per asid, or per asid/iova.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1529653501-15358-4-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 13 +++++
 hw/arm/smmu-common.c         | 60 ++++++++++++++++++++++
 hw/arm/smmuv3.c              | 98 ++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events          |  9 ++++
 4 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7ce95ca0dcb..d173806f1a3 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -67,6 +67,8 @@ typedef struct SMMUTransCfg {
     uint8_t tbi;               /* Top Byte Ignore */
     uint16_t asid;
     SMMUTransTableInfo tt[2];
+    uint32_t iotlb_hits;       /* counts IOTLB hits for this asid */
+    uint32_t iotlb_misses;     /* counts IOTLB misses for this asid */
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
@@ -89,6 +91,11 @@ typedef struct SMMUPciBus {
     SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
 } SMMUPciBus;
 
+typedef struct SMMUIOTLBKey {
+    uint64_t iova;
+    uint16_t asid;
+} SMMUIOTLBKey;
+
 typedef struct SMMUState {
     /* <private> */
     SysBusDevice  dev;
@@ -147,4 +154,10 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
 /* Return the iommu mr associated to @sid, or NULL if none */
 IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 
+#define SMMU_IOTLB_MAX_SIZE 256
+
+void smmu_iotlb_inv_all(SMMUState *s);
+void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
+void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
+
 #endif  /* HW_ARM_SMMU_COMMON */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index db242c73dfb..f66e444f6f4 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -24,11 +24,43 @@
 #include "qom/cpu.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/jhash.h"
 
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* IOTLB Management */
+
+inline void smmu_iotlb_inv_all(SMMUState *s)
+{
+    trace_smmu_iotlb_inv_all();
+    g_hash_table_remove_all(s->iotlb);
+}
+
+static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    uint16_t asid = *(uint16_t *)user_data;
+    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+
+    return iotlb_key->asid == asid;
+}
+
+inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
+{
+    SMMUIOTLBKey key = {.asid = asid, .iova = iova};
+
+    trace_smmu_iotlb_inv_iova(asid, iova);
+    g_hash_table_remove(s->iotlb, &key);
+}
+
+inline void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
+{
+    trace_smmu_iotlb_inv_asid(asid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
+}
+
 /* VMSAv8-64 Translation */
 
 /**
@@ -328,6 +360,31 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
     return NULL;
 }
 
+static guint smmu_iotlb_key_hash(gconstpointer v)
+{
+    SMMUIOTLBKey *key = (SMMUIOTLBKey *)v;
+    uint32_t a, b, c;
+
+    /* Jenkins hash */
+    a = b = c = JHASH_INITVAL + sizeof(*key);
+    a += key->asid;
+    b += extract64(key->iova, 0, 32);
+    c += extract64(key->iova, 32, 32);
+
+    __jhash_mix(a, b, c);
+    __jhash_final(a, b, c);
+
+    return c;
+}
+
+static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
+{
+    const SMMUIOTLBKey *k1 = v1;
+    const SMMUIOTLBKey *k2 = v2;
+
+    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
+}
+
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
@@ -340,6 +397,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         return;
     }
     s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+    s->iotlb = g_hash_table_new_full(smmu_iotlb_key_hash, smmu_iotlb_key_equal,
+                                     g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
     if (s->primary_bus) {
@@ -354,6 +413,7 @@ static void smmu_base_reset(DeviceState *dev)
     SMMUState *s = ARM_SMMU(dev);
 
     g_hash_table_remove_all(s->configs);
+    g_hash_table_remove_all(s->iotlb);
 }
 
 static Property smmu_dev_properties[] = {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index df704c26f8a..b6dc7ed6de6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -605,6 +605,10 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid};
     SMMUPTWEventInfo ptw_info = {};
     SMMUTranslationStatus status;
+    SMMUState *bs = ARM_SMMU(s);
+    uint64_t page_mask, aligned_addr;
+    IOMMUTLBEntry *cached_entry = NULL;
+    SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
@@ -613,6 +617,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
+    SMMUIOTLBKey key, *new_key;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -637,7 +642,57 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    if (smmu_ptw(cfg, addr, flag, &entry, &ptw_info)) {
+    tt = select_tt(cfg, addr);
+    if (!tt) {
+        if (event.record_trans_faults) {
+            event.type = SMMU_EVT_F_TRANSLATION;
+            event.u.f_translation.addr = addr;
+            event.u.f_translation.rnw = flag & 0x1;
+        }
+        status = SMMU_TRANS_ERROR;
+        goto epilogue;
+    }
+
+    page_mask = (1ULL << (tt->granule_sz)) - 1;
+    aligned_addr = addr & ~page_mask;
+
+    key.asid = cfg->asid;
+    key.iova = aligned_addr;
+
+    cached_entry = g_hash_table_lookup(bs->iotlb, &key);
+    if (cached_entry) {
+        cfg->iotlb_hits++;
+        trace_smmu_iotlb_cache_hit(cfg->asid, aligned_addr,
+                                   cfg->iotlb_hits, cfg->iotlb_misses,
+                                   100 * cfg->iotlb_hits /
+                                   (cfg->iotlb_hits + cfg->iotlb_misses));
+        if ((flag & IOMMU_WO) && !(cached_entry->perm & IOMMU_WO)) {
+            status = SMMU_TRANS_ERROR;
+            if (event.record_trans_faults) {
+                event.type = SMMU_EVT_F_PERMISSION;
+                event.u.f_permission.addr = addr;
+                event.u.f_permission.rnw = flag & 0x1;
+            }
+        } else {
+            status = SMMU_TRANS_SUCCESS;
+        }
+        goto epilogue;
+    }
+
+    cfg->iotlb_misses++;
+    trace_smmu_iotlb_cache_miss(cfg->asid, addr & ~page_mask,
+                                cfg->iotlb_hits, cfg->iotlb_misses,
+                                100 * cfg->iotlb_hits /
+                                (cfg->iotlb_hits + cfg->iotlb_misses));
+
+    if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
+        smmu_iotlb_inv_all(bs);
+    }
+
+    cached_entry = g_new0(IOMMUTLBEntry, 1);
+
+    if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
+        g_free(cached_entry);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event.type = SMMU_EVT_F_WALK_EABT;
@@ -679,6 +734,10 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         }
         status = SMMU_TRANS_ERROR;
     } else {
+        new_key = g_new0(SMMUIOTLBKey, 1);
+        new_key->asid = cfg->asid;
+        new_key->iova = aligned_addr;
+        g_hash_table_insert(bs->iotlb, new_key, cached_entry);
         status = SMMU_TRANS_SUCCESS;
     }
 
@@ -687,6 +746,9 @@ epilogue:
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = flag;
+        entry.translated_addr = cached_entry->translated_addr +
+                                    (addr & page_mask);
+        entry.addr_mask = cached_entry->addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm);
         break;
@@ -832,10 +894,39 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             smmuv3_flush_config(sdev);
             break;
         }
-        case SMMU_CMD_TLBI_NH_ALL:
         case SMMU_CMD_TLBI_NH_ASID:
-        case SMMU_CMD_TLBI_NH_VA:
+        {
+            uint16_t asid = CMD_ASID(&cmd);
+
+            trace_smmuv3_cmdq_tlbi_nh_asid(asid);
+            smmu_iotlb_inv_asid(bs, asid);
+            break;
+        }
+        case SMMU_CMD_TLBI_NH_ALL:
+        case SMMU_CMD_TLBI_NSNH_ALL:
+            trace_smmuv3_cmdq_tlbi_nh();
+            smmu_iotlb_inv_all(bs);
+            break;
         case SMMU_CMD_TLBI_NH_VAA:
+        {
+            dma_addr_t addr = CMD_ADDR(&cmd);
+            uint16_t vmid = CMD_VMID(&cmd);
+
+            trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
+            smmu_iotlb_inv_all(bs);
+            break;
+        }
+        case SMMU_CMD_TLBI_NH_VA:
+        {
+            uint16_t asid = CMD_ASID(&cmd);
+            uint16_t vmid = CMD_VMID(&cmd);
+            dma_addr_t addr = CMD_ADDR(&cmd);
+            bool leaf = CMD_LEAF(&cmd);
+
+            trace_smmuv3_cmdq_tlbi_nh_va(vmid, asid, addr, leaf);
+            smmu_iotlb_inv_iova(bs, asid, addr);
+            break;
+        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
@@ -844,7 +935,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_EL2_VAA:
         case SMMU_CMD_TLBI_S12_VMALL:
         case SMMU_CMD_TLBI_S2_IPA:
-        case SMMU_CMD_TLBI_NSNH_ALL:
         case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 8ee4c21dd77..be69c5ddfe4 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -12,6 +12,11 @@ smmu_ptw_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr,
 smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+smmu_iotlb_cache_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_cache_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_inv_all(void) "IOTLB invalidate all"
+smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
+smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 
 #hw/arm/smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -45,4 +50,8 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
+smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
+smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =%d addr=0x%"PRIx64
+smmuv3_cmdq_tlbi_nh(void) ""
+smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
-- 
2.17.1
