Received: from eggs.gnu.org ([2001:4830:134:3::10]:47683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSeMC-0007J0-Uf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fSeMA-0003iX-7W
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:08:48 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 12 Jun 2018 10:08:27 +0200
Message-Id: <1528790908-23441-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] hw/arm/smmuv3: IOTLB emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, jia.he@hxt-semitech.com, hejianet@gmail.com

We emulate a TLB cache of size SMMU_IOTLB_MAX_SIZE=256.
It is implemented as a hash table whose key is a combination
of the 16b asid and 48b IOVA (Jenkins hash).

Entries are invalidated on TLB invalidation commands, either
globally, or per asid, or per asid/iova.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- add comment about Jenkins Hash
- remove init of iotlb_hits, misses

v1:
- Add new trace point when smmu is bypassed
- s/iotlb_miss/iotlb_misses, s/iotlb_hit/iotlb_hits
- use SMMUIOTLBKey as a key

Credit to Tomasz Nowicki who did the first implementation of
this IOTLB implementation, inspired of intel_iommu implementation.
---
 hw/arm/smmu-common.c         | 60 +++++++++++++++++++++++++++
 hw/arm/smmuv3.c              | 98 ++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events          |  9 ++++
 include/hw/arm/smmu-common.h | 13 ++++++
 4 files changed, 176 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 264e096..16cd33a 100644
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
+    /* Henkins hash */
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
+    SMMUIOTLBKey *k1 = (SMMUIOTLBKey *)v1;
+    SMMUIOTLBKey *k2 = (SMMUIOTLBKey *)v2;
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
index 4c41f51..cc21f4c 100644
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
+        cfg->iotlb_hits += 1;
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
+    cfg->iotlb_misses += 1;
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
index 5bddfeb..8ad900c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -12,6 +12,11 @@ smmu_ptw_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr,
 smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+smmu_iotlb_cache_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, float p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%.1f"
+smmu_iotlb_cache_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, float p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%.1f"
+smmu_iotlb_inv_all(void) "IOTLB invalidate all"
+smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
+smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 
 #hw/arm/smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -42,6 +47,10 @@ smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d"
 smmuv3_cmdq_cfgi_ste(int streamid) "     |_ streamid =%d"
 smmuv3_cmdq_cfgi_ste_range(int start, int end) "     |_ start=0x%d - end=0x%d"
+smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "     |_ vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
+smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "     |_ vmid =%d addr=0x%"PRIx64
+smmuv3_cmdq_tlbi_nh(void) ""
+smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "     |_ streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, float perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%.1f)"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 7ce95ca..d173806 100644
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
-- 
2.5.5
