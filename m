Received: from eggs.gnu.org ([2001:4830:134:3::10]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXP-0007vL-Am
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXN-0003ik-55
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:31 +0100
Message-Id: <1521549456-14072-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 09/14] hw/arm/smmuv3: Implement translate
 callback
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

This patch implements the IOMMU Memory Region translate()
callback. Most of the code relates to the translation
configuration decoding and check (STE, CD).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---
v9 -> v10:
- s/hwaddr/uint64_t in trace-events
- use qemu_log_mask(LOG_UNIMP, in some situations where assert
  was done
- report bad_ste if stage2 is found in STE
- check TTB does not exceed IPS
- fix oas2bits, CD_TTB
- tg2granule handles illegal cases
- convert L1STD_L2PTR macro into an inline function
- added S1STALLD, CD_A, CD_S, CD_HA, CD_HD checks

v8 -> v9:
- use SMMU_EVENT_STRING macro
- get rid of last erro_report's
- decode asid
- handle config abort before ptw
- add 64-bit single-copy atomic comment

v7 -> v8:
- use address_space_rw
- s/Ste/STE, s/Cd/CD
- use dma_memory_read
- remove everything related to stage 2
- collect data for both TTx
- renamings
- pass the event handle all along the config decoding path
- decode tbi, ars
---
 hw/arm/smmuv3-internal.h | 160 +++++++++++++++++++++
 hw/arm/smmuv3.c          | 360 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   9 ++
 3 files changed, 529 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 8e546bf..ef6dd76 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -446,4 +446,164 @@ typedef struct SMMUEventInfo {
 
 void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
 
+/* Configuration Data */
+
+/* STE Level 1 Descriptor */
+typedef struct STEDesc {
+    uint32_t word[2];
+} STEDesc;
+
+/* CD Level 1 Descriptor */
+typedef struct CDDesc {
+    uint32_t word[2];
+} CDDesc;
+
+/* Stream Table Entry(STE) */
+typedef struct STE {
+    uint32_t word[16];
+} STE;
+
+/* Context Descriptor(CD) */
+typedef struct CD {
+    uint32_t word[16];
+} CD;
+
+/* STE fields */
+
+#define STE_VALID(x)   extract32((x)->word[0], 0, 1)
+
+#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
+#define STE_CFG_S1_ENABLED(config) (config & 0x1)
+#define STE_CFG_S2_ENABLED(config) (config & 0x2)
+#define STE_CFG_ABORT(config)      (!(config & 0x4))
+#define STE_CFG_BYPASS(config)     (config == 0x4)
+
+#define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
+#define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
+#define STE_S1STALLD(x)    extract32((x)->word[2], 27, 1)
+#define STE_EATS(x)        extract32((x)->word[2], 28, 2)
+#define STE_STRW(x)        extract32((x)->word[2], 30, 2)
+#define STE_S2VMID(x)      extract32((x)->word[4], 0 , 16)
+#define STE_S2T0SZ(x)      extract32((x)->word[5], 0 , 6)
+#define STE_S2SL0(x)       extract32((x)->word[5], 6 , 2)
+#define STE_S2TG(x)        extract32((x)->word[5], 14, 2)
+#define STE_S2PS(x)        extract32((x)->word[5], 16, 3)
+#define STE_S2AA64(x)      extract32((x)->word[5], 19, 1)
+#define STE_S2HD(x)        extract32((x)->word[5], 24, 1)
+#define STE_S2HA(x)        extract32((x)->word[5], 25, 1)
+#define STE_S2S(x)         extract32((x)->word[5], 26, 1)
+#define STE_CTXPTR(x)                                           \
+    ({                                                          \
+        unsigned long addr;                                     \
+        addr = (uint64_t)extract32((x)->word[1], 0, 16) << 32;  \
+        addr |= (uint64_t)((x)->word[0] & 0xffffffc0);          \
+        addr;                                                   \
+    })
+
+#define STE_S2TTB(x)                                            \
+    ({                                                          \
+        unsigned long addr;                                     \
+        addr = (uint64_t)extract32((x)->word[7], 0, 16) << 32;  \
+        addr |= (uint64_t)((x)->word[6] & 0xfffffff0);          \
+        addr;                                                   \
+    })
+
+static inline int oas2bits(int oas_field)
+{
+    switch (oas_field) {
+    case 0:
+        return 32;
+    case 1:
+        return 36;
+    case 2:
+        return 40;
+    case 3:
+        return 42;
+    case 4:
+        return 44;
+    case 5:
+        return 48;
+    }
+    return -1;
+}
+
+static inline int pa_range(STE *ste)
+{
+    int oas_field = MIN(STE_S2PS(ste), SMMU_IDR5_OAS);
+
+    if (!STE_S2AA64(ste)) {
+        return 40;
+    }
+
+    return oas2bits(oas_field);
+}
+
+#define MAX_PA(ste) ((1 << pa_range(ste)) - 1)
+
+/* CD fields */
+
+#define CD_VALID(x)   extract32((x)->word[0], 30, 1)
+#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
+#define CD_TTB(x, sel)                                      \
+    ({                                                      \
+        uint64_t hi, lo;                                    \
+        hi = extract32((x)->word[(sel) * 2 + 3], 0, 19);    \
+        hi <<= 32;                                          \
+        lo = (x)->word[(sel) * 2 + 2] & ~0xfULL;            \
+        hi | lo;                                            \
+    })
+
+#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
+#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
+#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
+#define CD_ENDI(x)       extract32((x)->word[0], 15, 1)
+#define CD_IPS(x)        extract32((x)->word[1], 0 , 3)
+#define CD_TBI(x)        extract32((x)->word[1], 6 , 2)
+#define CD_HD(x)         extract32((x)->word[1], 10 , 1)
+#define CD_HA(x)         extract32((x)->word[1], 11 , 1)
+#define CD_S(x)          extract32((x)->word[1], 12, 1)
+#define CD_R(x)          extract32((x)->word[1], 13, 1)
+#define CD_A(x)          extract32((x)->word[1], 14, 1)
+#define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
+
+#define CDM_VALID(x)    ((x)->word[0] & 0x1)
+
+static inline int is_cd_valid(SMMUv3State *s, STE *ste, CD *cd)
+{
+    return CD_VALID(cd);
+}
+
+/**
+ * tg2granule - Decodes the CD translation granule size field according
+ * to the ttbr in use
+ * @bits: TG0/1 fields
+ * @ttbr: ttbr index in use
+ */
+static inline int tg2granule(int bits, int ttbr)
+{
+    switch (bits) {
+    case 0:
+        return ttbr ? 0  : 12;
+    case 1:
+        return ttbr ? 14 : 16;
+    case 2:
+        return ttbr ? 12 : 14;
+    case 3:
+        return ttbr ? 16 :  0;
+    default:
+        return 0;
+    }
+}
+
+static inline uint64_t l1std_l2ptr(STEDesc *desc)
+{
+    uint64_t hi, lo;
+
+    hi = desc->word[1];
+    lo = desc->word[0] & ~0x1fULL;
+    return hi << 32 | lo;
+}
+
+#define L1STD_SPAN(stm) (extract32((stm)->word[0], 0, 4))
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 30daad6..4f5186d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -270,6 +270,363 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->sid_split = 0;
 }
 
+static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
+                        SMMUEventInfo *event)
+{
+    int ret;
+
+    trace_smmuv3_get_ste(addr);
+    /* TODO: guarantee 64-bit single-copy atomicity */
+    ret = dma_memory_read(&address_space_memory, addr,
+                          (void *)buf, sizeof(*buf));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
+        event->type = SMMU_EVT_F_STE_FETCH;
+        event->u.f_ste_fetch.addr = addr;
+        return -EINVAL;
+    }
+    return 0;
+
+}
+
+/* @ssid > 0 not supported yet */
+static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
+                       CD *buf, SMMUEventInfo *event)
+{
+    dma_addr_t addr = STE_CTXPTR(ste);
+    int ret;
+
+    trace_smmuv3_get_cd(addr);
+    /* TODO: guarantee 64-bit single-copy atomicity */
+    ret = dma_memory_read(&address_space_memory, addr,
+                           (void *)buf, sizeof(*buf));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
+        event->type = SMMU_EVT_F_CD_FETCH;
+        event->u.f_ste_fetch.addr = addr;
+        return -EINVAL;
+    }
+    return 0;
+}
+
+/* Returns <0 if the caller has no need to purse the translation */
+static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
+                      STE *ste, SMMUEventInfo *event)
+{
+    uint32_t config = STE_CONFIG(ste);
+    int ret = -EINVAL;
+
+    if (STE_CFG_ABORT(config)) {
+        cfg->aborted = true; /* abort but don't record any event */
+        return ret;
+    }
+
+    if (STE_CFG_BYPASS(config)) {
+        cfg->bypassed = true;
+        return ret;
+    }
+
+    if (!STE_VALID(ste)) {
+        goto bad_ste;
+    }
+
+    if (STE_CFG_S2_ENABLED(config)) {
+        qemu_log_mask(LOG_UNIMP, "SMMUv3 does not support stage 2 yet\n");
+        goto bad_ste;
+    }
+
+    if (STE_S1CDMAX(ste) != 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SMMUv3 does not support multiple context descriptors yet\n");
+        goto bad_ste;
+    }
+
+    if (STE_S1STALLD(ste)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SMMUv3 S1 stalling fault model not allowed yet\n");
+        goto bad_ste;
+    }
+    return 0;
+
+bad_ste:
+    event->type = SMMU_EVT_C_BAD_STE;
+    return -EINVAL;
+}
+
+/**
+ * smmu_find_ste - Return the stream table entry associated
+ * to the sid
+ *
+ * @s: smmuv3 handle
+ * @sid: stream ID
+ * @ste: returned stream table entry
+ * @event: handle to an event info
+ *
+ * Supports linear and 2-level stream table
+ * Return 0 on success, -EINVAL otherwise
+ */
+static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
+                         SMMUEventInfo *event)
+{
+    dma_addr_t addr;
+    int ret;
+
+    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
+    /* Check SID range */
+    if (sid > (1 << SMMU_IDR1_SIDSIZE)) {
+        event->type = SMMU_EVT_C_BAD_STREAMID;
+        return -EINVAL;
+    }
+    if (s->features & SMMU_FEATURE_2LVL_STE) {
+        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
+        dma_addr_t strtab_base, l1ptr, l2ptr;
+        STEDesc l1std;
+
+        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK;
+        l1_ste_offset = sid >> s->sid_split;
+        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
+        /* TODO: guarantee 64-bit single-copy atomicity */
+        ret = dma_memory_read(&address_space_memory, l1ptr,
+                              (uint8_t *)&l1std, sizeof(l1std));
+        if (ret != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
+            event->type = SMMU_EVT_F_STE_FETCH;
+            event->u.f_ste_fetch.addr = l1ptr;
+            return -EINVAL;
+        }
+
+        span = L1STD_SPAN(&l1std);
+
+        if (!span) {
+            /* l2ptr is not valid */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "invalid sid=%d (L1STD span=0)\n", sid);
+            event->type = SMMU_EVT_C_BAD_STREAMID;
+            return -EINVAL;
+        }
+        max_l2_ste = (1 << span) - 1;
+        l2ptr = l1std_l2ptr(&l1std);
+        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+                                   l2ptr, l2_ste_offset, max_l2_ste);
+        if (l2_ste_offset > max_l2_ste) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "l2_ste_offset=%d > max_l2_ste=%d\n",
+                          l2_ste_offset, max_l2_ste);
+            event->type = SMMU_EVT_C_BAD_STE;
+            return -EINVAL;
+        }
+        addr = l2ptr + l2_ste_offset * sizeof(*ste);
+    } else {
+        addr = s->strtab_base + sid * sizeof(*ste);
+    }
+
+    if (smmu_get_ste(s, addr, ste, event)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
+{
+    int ret = -EINVAL;
+    int i;
+
+    if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
+        goto bad_cd;
+    }
+
+    /* we support only those at the moment */
+    cfg->aa64 = true;
+    cfg->stage = 1;
+
+    cfg->oas = oas2bits(CD_IPS(cd));
+    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    cfg->tbi = CD_TBI(cd);
+    cfg->asid = CD_ASID(cd);
+
+    trace_smmuv3_decode_cd(cfg->oas);
+
+    /* decode data dependent on TT */
+    for (i = 0; i <= 1; i++) {
+        int tg, tsz;
+        SMMUTransTableInfo *tt = &cfg->tt[i];
+
+        cfg->tt[i].disabled = CD_EPD(cd, i);
+        if (cfg->tt[i].disabled) {
+            continue;
+        }
+
+        if (!CD_A(cd)) {
+            goto bad_cd; /* SMMU_IDR0.TERM_MODEL == 1 */
+        }
+        if (CD_S(cd)) {
+            goto bad_cd; /* !STE_SECURE && SMMU_IDR0.STALL_MODEL == 1 */
+        }
+        if (CD_HA(cd) || CD_HD(cd)) {
+            goto bad_cd; /* HTTU = 0 */
+        }
+
+        tsz = CD_TSZ(cd, i);
+        if (tsz < 16 || tsz > 39) {
+            goto bad_cd;
+        }
+
+        tg = CD_TG(cd, i);
+        tt->granule_sz = tg2granule(tg, i);
+        if ((tt->granule_sz != 12 && tt->granule_sz != 16) || CD_ENDI(cd)) {
+            goto bad_cd;
+        }
+
+        tt->tsz = tsz;
+        tt->initial_level = 4 - (64 - tsz - 4) / (tt->granule_sz - 3);
+        tt->ttb = CD_TTB(cd, i);
+        if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
+            goto bad_cd;
+        }
+        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb,
+                                  tt->granule_sz, tt->initial_level);
+    }
+
+    event->record_trans_faults = CD_R(cd);
+
+    return 0;
+
+bad_cd:
+    event->type = SMMU_EVT_C_BAD_CD;
+    return ret;
+}
+
+/**
+ * smmuv3_decode_config - Prepare the translation configuration
+ * for the @mr iommu region
+ * @mr: iommu memory region the translation config must be prepared for
+ * @cfg: output translation configuration which is populated through
+ *       the different configuration decoding steps
+ * @event: must be zero'ed by the caller
+ *
+ * return < 0 if the translation needs to be aborted (@event is filled
+ * accordingly). Return 0 otherwise.
+ */
+static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
+                                SMMUEventInfo *event)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    uint32_t sid = smmu_get_sid(sdev);
+    SMMUv3State *s = sdev->smmu;
+    int ret = -EINVAL;
+    STE ste;
+    CD cd;
+
+    if (smmu_find_ste(s, sid, &ste, event)) {
+        return ret;
+    }
+
+    if (decode_ste(s, cfg, &ste, event)) {
+        return ret;
+    }
+
+    if (smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event)) {
+        return ret;
+    }
+
+    return decode_cd(cfg, &cd, event);
+}
+
+static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
+                                      IOMMUAccessFlags flag)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    SMMUv3State *s = sdev->smmu;
+    uint32_t sid = smmu_get_sid(sdev);
+    SMMUEventInfo event = {.type = SMMU_EVT_OK, .sid = sid};
+    SMMUPTWEventInfo ptw_info = {};
+    SMMUTransCfg cfg = {};
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+    int ret = 0;
+
+    if (!smmu_enabled(s)) {
+        goto out;
+    }
+
+    ret = smmuv3_decode_config(mr, &cfg, &event);
+    if (ret) {
+        goto out;
+    }
+
+    if (cfg.aborted) {
+        goto out;
+    }
+
+    ret = smmu_ptw(&cfg, addr, flag, &entry, &ptw_info);
+    if (ret) {
+        switch (ptw_info.type) {
+        case SMMU_PTW_ERR_WALK_EABT:
+            event.type = SMMU_EVT_F_WALK_EABT;
+            event.u.f_walk_eabt.addr = addr;
+            event.u.f_walk_eabt.rnw = flag & 0x1;
+            event.u.f_walk_eabt.class = 0x1;
+            event.u.f_walk_eabt.addr2 = ptw_info.addr;
+            break;
+        case SMMU_PTW_ERR_TRANSLATION:
+            if (event.record_trans_faults) {
+                event.type = SMMU_EVT_F_TRANSLATION;
+                event.u.f_translation.addr = addr;
+                event.u.f_translation.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ADDR_SIZE:
+            if (event.record_trans_faults) {
+                event.type = SMMU_EVT_F_ADDR_SIZE;
+                event.u.f_addr_size.addr = addr;
+                event.u.f_addr_size.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ACCESS:
+            if (event.record_trans_faults) {
+                event.type = SMMU_EVT_F_ACCESS;
+                event.u.f_access.addr = addr;
+                event.u.f_access.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_PERMISSION:
+            if (event.record_trans_faults) {
+                event.type = SMMU_EVT_F_PERMISSION;
+                event.u.f_permission.addr = addr;
+                event.u.f_permission.rnw = flag & 0x1;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    trace_smmuv3_translate(mr->parent_obj.name, sid, addr,
+                           entry.translated_addr, entry.perm);
+out:
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s translation failed for iova=0x%"PRIx64" (%s)\n",
+                      mr->parent_obj.name, addr, smmu_event_string(event.type));
+        entry.perm = IOMMU_NONE;
+        smmuv3_record_event(s, &event);
+    } else if (!cfg.aborted) {
+        entry.perm = flag;
+    }
+
+    return entry;
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
@@ -797,6 +1154,9 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate = smmuv3_translate;
 }
 
 static const TypeInfo smmuv3_type_info = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 9936e10..032de48 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -30,3 +30,12 @@ smmuv3_write_mmio_idr(uint64_t addr, uint64_t val) "write to RO/Unimpl reg 0x%lx
 smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
 smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
 smmuv3_record_event(const char *type, uint32_t sid) "%s sid=%d"
+smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "SID:0x%x features:0x%x, sid_split:0x%x"
+smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%lx l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
+smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
+smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=%d bypass iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_in(uint16_t sid, int pci_bus_num, uint64_t strtab_base) "SID:0x%x bus:%d strtab_base:0x%"PRIx64
+smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
+smmuv3_translate(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
+smmuv3_decode_cd(uint32_t oas) "oas=%d"
+smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, int initial_level) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d, initial_level = %d"
-- 
2.5.5
