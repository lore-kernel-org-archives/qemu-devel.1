Received: from eggs.gnu.org ([2001:4830:134:3::10]:37154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpf3-0005oT-Ho
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpf1-0003Ih-4Z
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:17 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:13 +0200
Message-Id: <1504286483-23327-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/20] hw/arm/smmuv3: Implement translate
 callback
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

This patch implements the IOMMU Memory Region translate()
callback. Most of the code relates to the translation
configuration decoding and check (STE, CD).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3-internal.h | 182 +++++++++++++++++++++++-
 hw/arm/smmuv3.c          | 351 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events      |   9 ++
 3 files changed, 537 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e3e9828..f9f95ae 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -399,7 +399,185 @@ typedef enum evt_err {
     SMMU_EVT_E_PAGE_REQ     = 0x24,
 } SMMUEvtErr;
 
-void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
-                         uint32_t sid, bool is_write, SMMUEvtErr type);
+/*****************************
+ * Configuration Data
+ *****************************/
+
+typedef struct __smmu_data2  STEDesc; /* STE Level 1 Descriptor */
+typedef struct __smmu_data16 Ste;     /* Stream Table Entry(STE) */
+typedef struct __smmu_data2  CDDesc;  /* CD Level 1 Descriptor */
+typedef struct __smmu_data16 Cd;      /* Context Descriptor(CD) */
+
+/*****************************
+ * STE fields
+ *****************************/
+
+#define STE_VALID(x)   extract32((x)->word[0], 0, 1) /* 0 */
+#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
+enum {
+    STE_CONFIG_NONE      = 0,
+    STE_CONFIG_BYPASS    = 4,       /* S1 Bypass    , S2 Bypass */
+    STE_CONFIG_S1        = 5,       /* S1 Translate , S2 Bypass */
+    STE_CONFIG_S2        = 6,       /* S1 Bypass    , S2 Translate */
+    STE_CONFIG_NESTED    = 7,       /* S1 Translate , S2 Translate */
+};
+#define STE_S1FMT(x)   extract32((x)->word[0], 4, 2)
+#define STE_S1CDMAX(x) extract32((x)->word[1], 27, 5)
+#define STE_EATS(x)    extract32((x)->word[2], 28, 2)
+#define STE_STRW(x)    extract32((x)->word[2], 30, 2)
+#define STE_S2VMID(x)  extract32((x)->word[4], 0, 16)
+#define STE_S2T0SZ(x)  extract32((x)->word[5], 0, 6)
+#define STE_S2SL0(x)   extract32((x)->word[5], 6, 2)
+#define STE_S2TG(x)    extract32((x)->word[5], 14, 2)
+#define STE_S2PS(x)    extract32((x)->word[5], 16, 3)
+#define STE_S2AA64(x)  extract32((x)->word[5], 19, 1)
+#define STE_S2HD(x)    extract32((x)->word[5], 24, 1)
+#define STE_S2HA(x)    extract32((x)->word[5], 25, 1)
+#define STE_S2S(x)     extract32((x)->word[5], 26, 1)
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
+static inline int is_ste_bypass(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_BYPASS;
+}
+
+static inline bool is_ste_stage1(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_S1;
+}
+
+static inline bool is_ste_stage2(Ste *ste)
+{
+    return STE_CONFIG(ste) == STE_CONFIG_S2;
+}
+
+/**
+ * is_s2granule_valid - Check the stage 2 translation granule size
+ * advertised in the STE matches any IDR5 supported value
+ */
+static inline bool is_s2granule_valid(Ste *ste)
+{
+    int idr5_format = 0;
+
+    switch (STE_S2TG(ste)) {
+    case 0: /* 4kB */
+        idr5_format = 0x1;
+        break;
+    case 1: /* 64 kB */
+        idr5_format = 0x4;
+        break;
+    case 2: /* 16 kB */
+        idr5_format = 0x2;
+        break;
+    case 3: /* reserved */
+        break;
+    }
+    idr5_format &= SMMU_IDR5_GRAN;
+    return idr5_format;
+}
+
+static inline int oas2bits(int oas_field)
+{
+    switch (oas_field) {
+    case 0b011:
+        return 42;
+    case 0b100:
+        return 44;
+    default:
+        return 32 + (1 << oas_field);
+   }
+}
+
+static inline int pa_range(Ste *ste)
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
+/*****************************
+ * CD fields
+ *****************************/
+#define CD_VALID(x)   extract32((x)->word[0], 30, 1)
+#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
+#define CD_TTB(x, sel)                                      \
+    ({                                                      \
+        uint64_t hi, lo;                                    \
+        hi = extract32((x)->word[(sel) * 2 + 3], 0, 16);    \
+        hi <<= 32;                                          \
+        lo = (x)->word[(sel) * 2 + 2] & ~0xf;               \
+        hi | lo;                                            \
+    })
+
+#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
+#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
+#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
+
+#define CD_T0SZ(x)    CD_TSZ((x), 0)
+#define CD_T1SZ(x)    CD_TSZ((x), 1)
+#define CD_TG0(x)     CD_TG((x), 0)
+#define CD_TG1(x)     CD_TG((x), 1)
+#define CD_EPD0(x)    CD_EPD((x), 0)
+#define CD_EPD1(x)    CD_EPD((x), 1)
+#define CD_IPS(x)     extract32((x)->word[1], 0, 3)
+#define CD_AARCH64(x) extract32((x)->word[1], 9, 1)
+#define CD_TTB0(x)    CD_TTB((x), 0)
+#define CD_TTB1(x)    CD_TTB((x), 1)
+
+#define CDM_VALID(x)    ((x)->word[0] & 0x1)
+
+static inline int is_cd_valid(SMMUV3State *s, Ste *ste, Cd *cd)
+{
+    return CD_VALID(cd);
+}
+
+/**
+ * tg2granule - Decodes the CD translation granule size field according
+ * to the TT in use
+ * @bits: TG0/1 fiels
+ * @tg1: if set, @bits belong to TG1, otherwise belong to TG0
+ */
+static inline int tg2granule(int bits, bool tg1)
+{
+    switch (bits) {
+    case 1:
+        return tg1 ? 14 : 16;
+    case 2:
+        return tg1 ? 12 : 14;
+    case 3:
+        return tg1 ? 16 : 12;
+    default:
+        return 12;
+    }
+}
+
+#define L1STD_L2PTR(stm) ({                                 \
+            uint64_t hi, lo;                            \
+            hi = (stm)->word[1];                        \
+            lo = (stm)->word[0] & ~(uint64_t)0x1f;      \
+            hi << 32 | lo;                              \
+        })
+
+#define L1STD_SPAN(stm) (extract32((stm)->word[0], 0, 4))
 
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7470576..20fbce6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -160,9 +160,9 @@ static void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
 /*
  * smmuv3_record_event - Record an event
  */
-void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
-                         uint32_t sid, IOMMUAccessFlags perm,
-                         SMMUEvtErr type)
+static void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
+                                uint32_t sid, IOMMUAccessFlags perm,
+                                SMMUEvtErr type)
 {
     Evt evt;
     bool rnw = perm & IOMMU_RO;
@@ -306,6 +306,348 @@ static inline void smmu_update_base_reg(SMMUV3State *s, uint64_t *base,
     *base = val & ~(SMMU_BASE_RA | 0x3fULL);
 }
 
+/*
+ * All SMMU data structures are little endian, and are aligned to 8 bytes
+ * L1STE/STE/L1CD/CD, Queue entries in CMDQ/EVTQ/PRIQ
+ */
+static inline int smmu_get_ste(SMMUV3State *s, hwaddr addr, Ste *buf)
+{
+    trace_smmuv3_get_ste(addr);
+    return dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+}
+
+/*
+ * For now we only support CD with a single entry, 'ssid' is used to identify
+ * otherwise
+ */
+static inline int smmu_get_cd(SMMUV3State *s, Ste *ste, uint32_t ssid, Cd *buf)
+{
+    hwaddr addr = STE_CTXPTR(ste);
+
+    if (STE_S1CDMAX(ste) != 0) {
+        error_report("Multilevel Ctx Descriptor not supported yet");
+    }
+
+    trace_smmuv3_get_cd(addr);
+    return dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+}
+
+/**
+ * is_ste_consistent - Check validity of STE
+ * according to 6.2.1 Validity of STE
+ * TODO: check the relevance of each check and compliance
+ * with this spec chapter
+ */
+static bool is_ste_consistent(SMMUV3State *s, Ste *ste)
+{
+    uint32_t _config = STE_CONFIG(ste);
+    uint32_t ste_vmid, ste_eats, ste_s2s, ste_s1fmt, ste_s2aa64, ste_s1cdmax;
+    uint32_t ste_strw;
+    bool strw_unused, addr_out_of_range, granule_supported;
+    bool config[] = {_config & 0x1, _config & 0x2, _config & 0x3};
+
+    ste_vmid = STE_S2VMID(ste);
+    ste_eats = STE_EATS(ste); /* Enable PCIe ATS trans */
+    ste_s2s = STE_S2S(ste);
+    ste_s1fmt = STE_S1FMT(ste);
+    ste_s2aa64 = STE_S2AA64(ste);
+    ste_s1cdmax = STE_S1CDMAX(ste); /*CD bit # S1ContextPtr */
+    ste_strw = STE_STRW(ste); /* stream world control */
+
+    if (!STE_VALID(ste)) {
+        error_report("STE NOT valid");
+        return false;
+    }
+
+    granule_supported = is_s2granule_valid(ste);
+
+    /* As S1/S2 combinations are supported do not check
+     * corresponding STE config values */
+
+    if (!config[2]) {
+        /* Report abort to device, no event recorded */
+        error_report("STE config 0b000 not implemented");
+        return false;
+    }
+
+    if (!SMMU_IDR1_SIDSIZE && ste_s1cdmax && config[0] &&
+        !SMMU_IDR0_CD2L && (ste_s1fmt == 1 || ste_s1fmt == 2)) {
+        error_report("STE inconsistant, CD mismatch");
+        return false;
+    }
+    if (SMMU_IDR0_ATS && ((_config & 0x3) == 0) &&
+        ((ste_eats == 2 && (_config != 0x7 || ste_s2s)) ||
+        (ste_eats == 1 && !ste_s2s))) {
+        error_report("STE inconsistant, EATS/S2S mismatch");
+        return false;
+    }
+    if (config[0] && (SMMU_IDR1_SIDSIZE &&
+        (ste_s1cdmax > SMMU_IDR1_SIDSIZE))) {
+        error_report("STE inconsistant, SSID out of range");
+        return false;
+    }
+
+    strw_unused = (!SMMU_IDR0_S1P || !SMMU_IDR0_HYP || (_config == 4));
+
+    addr_out_of_range = STE_S2TTB(ste) > MAX_PA(ste);
+
+    if (is_ste_stage2(ste)) {
+        if ((ste_s2aa64 && !is_s2granule_valid(ste)) ||
+            (!ste_s2aa64 && !(SMMU_IDR0_TTF & 0x1)) ||
+            (ste_s2aa64 && !(SMMU_IDR0_TTF & 0x2))  ||
+            ((STE_S2HA(ste) || STE_S2HD(ste)) && !ste_s2aa64) ||
+            ((STE_S2HA(ste) || STE_S2HD(ste)) && !SMMU_IDR0_HTTU) ||
+            (STE_S2HD(ste) && (SMMU_IDR0_HTTU == 1)) || addr_out_of_range) {
+            error_report("STE inconsistant");
+            trace_smmuv3_is_ste_consistent(config[1], granule_supported,
+                                           addr_out_of_range, ste_s2aa64,
+                                           STE_S2HA(ste), STE_S2HD(ste),
+                                           STE_S2TTB(ste));
+        return false;
+        }
+    }
+    if (SMMU_IDR0_S2P && (config[0] == 0 && config[1]) &&
+        (strw_unused || !ste_strw) && !SMMU_IDR0_VMID16 && !(ste_vmid >> 8)) {
+        error_report("STE inconsistant, VMID out of range");
+        return false;
+    }
+    return true;
+}
+
+/**
+ * smmu_find_ste - Return the stream table entry associated
+ * to the sid
+ *
+ * @s: smmuv3 handle
+ * @sid: stream ID
+ * @ste: returned stream table entry
+ *
+ * Supports linear and 2-level stream table
+ * Return 0 on success or an SMMUEvtErr enum value otherwise
+ */
+static int smmu_find_ste(SMMUV3State *s, uint16_t sid, Ste *ste)
+{
+    hwaddr addr;
+
+    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
+    /* Check SID range */
+    if (sid > (1 << s->sid_size)) {
+        return SMMU_EVT_C_BAD_SID;
+    }
+    if (s->features & SMMU_FEATURE_2LVL_STE) {
+        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
+        hwaddr l1ptr, l2ptr;
+        STEDesc l1std;
+
+        l1_ste_offset = sid >> s->sid_split;
+        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1ptr = (hwaddr)(s->strtab_base + l1_ste_offset * sizeof(l1std));
+        smmu_read_sysmem(l1ptr, &l1std, sizeof(l1std), false);
+        span = L1STD_SPAN(&l1std);
+
+        if (!span) {
+            /* l2ptr is not valid */
+            error_report("invalid sid=%d (L1STD span=0)", sid);
+            return SMMU_EVT_C_BAD_SID;
+        }
+        max_l2_ste = (1 << span) - 1;
+        l2ptr = L1STD_L2PTR(&l1std);
+        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+                                   l2ptr, l2_ste_offset, max_l2_ste);
+        if (l2_ste_offset > max_l2_ste) {
+            error_report("l2_ste_offset=%d > max_l2_ste=%d",
+                         l2_ste_offset, max_l2_ste);
+            return SMMU_EVT_C_BAD_STE;
+        }
+        addr = L1STD_L2PTR(&l1std) + l2_ste_offset * sizeof(*ste);
+    } else {
+        addr = s->strtab_base + sid * sizeof(*ste);
+    }
+
+    if (smmu_get_ste(s, addr, ste)) {
+        error_report("Unable to Fetch STE");
+        return SMMU_EVT_F_STE_FETCH;
+    }
+
+    return 0;
+}
+
+/**
+ * smmu_cfg_populate_s1 - Populate the stage 1 translation config
+ * from the context descriptor
+ */
+static int smmu_cfg_populate_s1(SMMUTransCfg *cfg, Cd *cd)
+{
+    bool s1a64 = CD_AARCH64(cd);
+    int epd0 = CD_EPD0(cd);
+    int tg;
+
+    cfg->stage   = 1;
+    tg           = epd0 ? CD_TG1(cd) : CD_TG0(cd);
+    cfg->tsz     = epd0 ? CD_T1SZ(cd) : CD_T0SZ(cd);
+    cfg->ttbr    = epd0 ? CD_TTB1(cd) : CD_TTB0(cd);
+    cfg->oas     = oas2bits(CD_IPS(cd));
+
+    if (s1a64) {
+        cfg->tsz = MIN(cfg->tsz, 39);
+        cfg->tsz = MAX(cfg->tsz, 16);
+    }
+    cfg->granule_sz = tg2granule(tg, epd0);
+
+    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    /* fix ttbr - make top bits zero*/
+    cfg->ttbr = extract64(cfg->ttbr, 0, cfg->oas);
+    cfg->aa64 = s1a64;
+    cfg->initial_level  = 4 - (64 - cfg->tsz - 4) / (cfg->granule_sz - 3);
+
+    trace_smmuv3_cfg_stage(cfg->stage, cfg->oas, cfg->tsz, cfg->ttbr,
+                           cfg->aa64, cfg->granule_sz, cfg->initial_level);
+
+    return 0;
+}
+
+/**
+ * smmu_cfg_populate_s2 - Populate the stage 2 translation config
+ * from the Stream Table Entry
+ */
+static int smmu_cfg_populate_s2(SMMUTransCfg *cfg, Ste *ste)
+{
+    bool s2a64 = STE_S2AA64(ste);
+    int default_initial_level;
+    int tg;
+
+    cfg->stage = 2;
+
+    tg           = STE_S2TG(ste);
+    cfg->tsz     = STE_S2T0SZ(ste);
+    cfg->ttbr    = STE_S2TTB(ste);
+    cfg->oas     = pa_range(ste);
+
+    cfg->aa64    = s2a64;
+
+    if (s2a64) {
+        cfg->tsz = MIN(cfg->tsz, 39);
+        cfg->tsz = MAX(cfg->tsz, 16);
+    }
+    cfg->granule_sz = tg2granule(tg, 0);
+
+    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    /* fix ttbr - make top bits zero*/
+    cfg->ttbr = extract64(cfg->ttbr, 0, cfg->oas);
+
+    default_initial_level = 4 - (64 - cfg->tsz - 4) / (cfg->granule_sz - 3);
+    cfg->initial_level = ~STE_S2SL0(ste);
+    if (cfg->initial_level  != default_initial_level) {
+        error_report("%s concatenated translation tables at initial S2 lookup"
+                     " not supported", __func__);
+        return SMMU_EVT_C_BAD_STE;;
+    }
+
+    trace_smmuv3_cfg_stage(cfg->stage, cfg->oas, cfg->tsz, cfg->ttbr,
+                           cfg->aa64, cfg->granule_sz, cfg->initial_level);
+
+    return 0;
+}
+
+/**
+ * smmuv3_decode_config - Prepare the translation configuration
+ * for the @mr iommu region
+ * @mr: iommu memory region the translation config must be prepared for
+ * @cfg: output translation configuration
+ *
+ * return 0 on success or an SMMUEvtErr enum value otherwise
+ */
+static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    int sid = smmu_get_sid(sdev);
+    SMMUV3State *s = sdev->smmu;
+    Ste ste;
+    Cd cd;
+    int ret = 0;
+
+    if (!smmu_enabled(s)) {
+        cfg->disabled = true;
+        return 0;
+    }
+    ret = smmu_find_ste(s, sid, &ste);
+    if (ret) {
+        return ret;
+    }
+
+    if (!STE_VALID(&ste)) {
+        return SMMU_EVT_C_BAD_STE;
+    }
+
+    switch (STE_CONFIG(&ste)) {
+    case STE_CONFIG_BYPASS:
+        cfg->bypassed = true;
+        return 0;
+    case STE_CONFIG_S1:
+         break;
+    case STE_CONFIG_S2:
+         break;
+    default: /* reserved, abort, nested */
+        return SMMU_EVT_F_UUT;
+    }
+
+    /* S1 or S2 */
+
+    if (!is_ste_consistent(s, &ste)) {
+        return SMMU_EVT_C_BAD_STE;
+    }
+
+    if (is_ste_stage1(&ste)) {
+        ret = smmu_get_cd(s, &ste, 0, &cd); /* We dont have SSID yet */
+        if (ret) {
+            return SMMU_EVT_F_CD_FETCH;
+        }
+
+        if (!is_cd_valid(s, &ste, &cd)) {
+            return SMMU_EVT_C_BAD_CD;
+        }
+        return smmu_cfg_populate_s1(cfg, &cd);
+    }
+
+    return smmu_cfg_populate_s2(cfg, &ste);
+}
+
+static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
+                                      IOMMUAccessFlags flag)
+{
+    SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    SMMUV3State *s = sdev->smmu;
+    uint16_t sid = smmu_get_sid(sdev);
+    SMMUEvtErr ret;
+    SMMUTransCfg cfg = {};
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr,
+        .addr_mask = ~(hwaddr)0,
+        .perm = flag,
+    };
+
+    ret = smmuv3_decode_config(mr, &cfg);
+    if (ret || cfg.disabled || cfg.bypassed) {
+        goto out;
+    }
+
+    entry.addr_mask = (1 << cfg.granule_sz) - 1;
+
+    ret = smmu_translate(&cfg, &entry);
+
+    trace_smmuv3_translate(mr->parent_obj.name, sid, addr,
+                           entry.translated_addr, entry.perm, ret);
+out:
+    if (ret) {
+        error_report("%s translation failed for iova=0x%"PRIx64,
+                     mr->parent_obj.name, addr);
+        smmuv3_record_event(s, entry.iova, sid, flag, ret);
+    }
+    return entry;
+}
+
 static int smmuv3_cmdq_consume(SMMUV3State *s)
 {
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
@@ -621,6 +963,9 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate = smmuv3_translate;
 }
 
 static const TypeInfo smmuv3_type_info = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 40f2057..e643fc3 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -34,3 +34,12 @@ smmuv3_write_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" v
 smmuv3_write_mmio_idr(hwaddr addr, uint64_t val) "write to RO/Unimpl reg 0x%lx val64:0x%lx"
 smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
 smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
+smmuv3_is_ste_consistent(bool cfg, bool granule_supported, bool addr_oor, uint32_t aa64, int s2ha, int s2hd, uint64_t s2ttb ) "config[1]:%d gran:%d addr:%d aa64:%d s2ha:%d s2hd:%d s2ttb:0x%"PRIx64
+smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "SID:0x%x features:0x%x, sid_split:0x%x"
+smmuv3_find_ste_2lvl(uint64_t strtab_base, hwaddr l1ptr, int l1_ste_offset, hwaddr l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%lx l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
+smmuv3_get_ste(hwaddr addr) "STE addr: 0x%"PRIx64
+smmuv3_translate_bypass(const char *n, uint16_t sid, hwaddr addr, bool is_write) "%s sid=%d bypass iova:0x%"PRIx64" is_write=%d"
+smmuv3_translate_in(uint16_t sid, int pci_bus_num, hwaddr strtab_base) "SID:0x%x bus:%d strtab_base:0x%"PRIx64
+smmuv3_get_cd(hwaddr addr) "CD addr: 0x%"PRIx64
+smmuv3_translate(const char *n, uint16_t sid, hwaddr iova, hwaddr translated, int perm, int ret) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x (%d)"
+smmuv3_cfg_stage(int s, uint32_t oas, uint32_t tsz, uint64_t ttbr, bool aa64, uint32_t granule_sz, int initial_level) "TransCFG stage:%d oas:%d tsz:%d ttbr:0x%"PRIx64"  aa64:%d granule_sz:%d, initial_level = %d"
-- 
2.5.5
