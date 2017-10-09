Received: from eggs.gnu.org ([2001:4830:134:3::10]:56783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1c7I-0005uC-BT
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1c7G-0004wR-F1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:45:24 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:48904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1c7F-0004w6-U0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:45:22 -0400
Received: by mail-wm0-x235.google.com with SMTP id i124so24510140wmf.3
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:45:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-11-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-11-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:45:00 +0100
Message-ID: <CAFEAcA-40ucm8WZOEJC_1r4MdFXEPuX=GM2FC3hKZamLbijM7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 10/20] hw/arm/smmuv3: Implement
 translate callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> This patch implements the IOMMU Memory Region translate()
> callback. Most of the code relates to the translation
> configuration decoding and check (STE, CD).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3-internal.h | 182 +++++++++++++++++++++++-
>  hw/arm/smmuv3.c          | 351 ++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/arm/trace-events      |   9 ++
>  3 files changed, 537 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index e3e9828..f9f95ae 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -399,7 +399,185 @@ typedef enum evt_err {
>      SMMU_EVT_E_PAGE_REQ     = 0x24,
>  } SMMUEvtErr;
>
> -void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
> -                         uint32_t sid, bool is_write, SMMUEvtErr type);
> +/*****************************
> + * Configuration Data
> + *****************************/
> +
> +typedef struct __smmu_data2  STEDesc; /* STE Level 1 Descriptor */
> +typedef struct __smmu_data16 Ste;     /* Stream Table Entry(STE) */
> +typedef struct __smmu_data2  CDDesc;  /* CD Level 1 Descriptor */
> +typedef struct __smmu_data16 Cd;      /* Context Descriptor(CD) */
> +
> +/*****************************
> + * STE fields
> + *****************************/
> +
> +#define STE_VALID(x)   extract32((x)->word[0], 0, 1) /* 0 */
> +#define STE_CONFIG(x)  extract32((x)->word[0], 1, 3)
> +enum {
> +    STE_CONFIG_NONE      = 0,
> +    STE_CONFIG_BYPASS    = 4,       /* S1 Bypass    , S2 Bypass */
> +    STE_CONFIG_S1        = 5,       /* S1 Translate , S2 Bypass */
> +    STE_CONFIG_S2        = 6,       /* S1 Bypass    , S2 Translate */
> +    STE_CONFIG_NESTED    = 7,       /* S1 Translate , S2 Translate */
> +};
> +#define STE_S1FMT(x)   extract32((x)->word[0], 4, 2)
> +#define STE_S1CDMAX(x) extract32((x)->word[1], 27, 5)
> +#define STE_EATS(x)    extract32((x)->word[2], 28, 2)
> +#define STE_STRW(x)    extract32((x)->word[2], 30, 2)
> +#define STE_S2VMID(x)  extract32((x)->word[4], 0, 16)
> +#define STE_S2T0SZ(x)  extract32((x)->word[5], 0, 6)
> +#define STE_S2SL0(x)   extract32((x)->word[5], 6, 2)
> +#define STE_S2TG(x)    extract32((x)->word[5], 14, 2)
> +#define STE_S2PS(x)    extract32((x)->word[5], 16, 3)
> +#define STE_S2AA64(x)  extract32((x)->word[5], 19, 1)
> +#define STE_S2HD(x)    extract32((x)->word[5], 24, 1)
> +#define STE_S2HA(x)    extract32((x)->word[5], 25, 1)
> +#define STE_S2S(x)     extract32((x)->word[5], 26, 1)
> +#define STE_CTXPTR(x)                                           \
> +    ({                                                          \
> +        unsigned long addr;                                     \
> +        addr = (uint64_t)extract32((x)->word[1], 0, 16) << 32;  \
> +        addr |= (uint64_t)((x)->word[0] & 0xffffffc0);          \
> +        addr;                                                   \
> +    })
> +
> +#define STE_S2TTB(x)                                            \
> +    ({                                                          \
> +        unsigned long addr;                                     \
> +        addr = (uint64_t)extract32((x)->word[7], 0, 16) << 32;  \
> +        addr |= (uint64_t)((x)->word[6] & 0xfffffff0);          \
> +        addr;                                                   \
> +    })
> +
> +static inline int is_ste_bypass(Ste *ste)

Types which are acronyms are all-caps, so STE, CD.

> +{
> +    return STE_CONFIG(ste) == STE_CONFIG_BYPASS;
> +}
> +
> +static inline bool is_ste_stage1(Ste *ste)
> +{
> +    return STE_CONFIG(ste) == STE_CONFIG_S1;
> +}
> +
> +static inline bool is_ste_stage2(Ste *ste)
> +{
> +    return STE_CONFIG(ste) == STE_CONFIG_S2;
> +}
> +
> +/**
> + * is_s2granule_valid - Check the stage 2 translation granule size
> + * advertised in the STE matches any IDR5 supported value
> + */
> +static inline bool is_s2granule_valid(Ste *ste)
> +{
> +    int idr5_format = 0;
> +
> +    switch (STE_S2TG(ste)) {
> +    case 0: /* 4kB */
> +        idr5_format = 0x1;
> +        break;
> +    case 1: /* 64 kB */
> +        idr5_format = 0x4;
> +        break;
> +    case 2: /* 16 kB */
> +        idr5_format = 0x2;
> +        break;
> +    case 3: /* reserved */
> +        break;
> +    }
> +    idr5_format &= SMMU_IDR5_GRAN;
> +    return idr5_format;
> +}
> +
> +static inline int oas2bits(int oas_field)
> +{
> +    switch (oas_field) {
> +    case 0b011:
> +        return 42;
> +    case 0b100:
> +        return 44;
> +    default:
> +        return 32 + (1 << oas_field);
> +   }
> +}
> +
> +static inline int pa_range(Ste *ste)
> +{
> +    int oas_field = MIN(STE_S2PS(ste), SMMU_IDR5_OAS);
> +
> +    if (!STE_S2AA64(ste)) {
> +        return 40;
> +    }
> +
> +    return oas2bits(oas_field);
> +}
> +
> +#define MAX_PA(ste) ((1 << pa_range(ste)) - 1)
> +
> +/*****************************
> + * CD fields
> + *****************************/
> +#define CD_VALID(x)   extract32((x)->word[0], 30, 1)
> +#define CD_ASID(x)    extract32((x)->word[1], 16, 16)
> +#define CD_TTB(x, sel)                                      \
> +    ({                                                      \
> +        uint64_t hi, lo;                                    \
> +        hi = extract32((x)->word[(sel) * 2 + 3], 0, 16);    \
> +        hi <<= 32;                                          \
> +        lo = (x)->word[(sel) * 2 + 2] & ~0xf;               \
> +        hi | lo;                                            \
> +    })
> +
> +#define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
> +#define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
> +#define CD_EPD(x, sel)   extract32((x)->word[0], (16 * (sel)) + 14, 1)
> +
> +#define CD_T0SZ(x)    CD_TSZ((x), 0)
> +#define CD_T1SZ(x)    CD_TSZ((x), 1)
> +#define CD_TG0(x)     CD_TG((x), 0)
> +#define CD_TG1(x)     CD_TG((x), 1)
> +#define CD_EPD0(x)    CD_EPD((x), 0)
> +#define CD_EPD1(x)    CD_EPD((x), 1)
> +#define CD_IPS(x)     extract32((x)->word[1], 0, 3)
> +#define CD_AARCH64(x) extract32((x)->word[1], 9, 1)
> +#define CD_TTB0(x)    CD_TTB((x), 0)
> +#define CD_TTB1(x)    CD_TTB((x), 1)
> +
> +#define CDM_VALID(x)    ((x)->word[0] & 0x1)
> +
> +static inline int is_cd_valid(SMMUV3State *s, Ste *ste, Cd *cd)
> +{
> +    return CD_VALID(cd);
> +}
> +
> +/**
> + * tg2granule - Decodes the CD translation granule size field according
> + * to the TT in use
> + * @bits: TG0/1 fiels
> + * @tg1: if set, @bits belong to TG1, otherwise belong to TG0
> + */
> +static inline int tg2granule(int bits, bool tg1)
> +{
> +    switch (bits) {
> +    case 1:
> +        return tg1 ? 14 : 16;
> +    case 2:
> +        return tg1 ? 12 : 14;
> +    case 3:
> +        return tg1 ? 16 : 12;
> +    default:
> +        return 12;
> +    }
> +}
> +
> +#define L1STD_L2PTR(stm) ({                                 \
> +            uint64_t hi, lo;                            \
> +            hi = (stm)->word[1];                        \
> +            lo = (stm)->word[0] & ~(uint64_t)0x1f;      \
> +            hi << 32 | lo;                              \
> +        })
> +
> +#define L1STD_SPAN(stm) (extract32((stm)->word[0], 0, 4))
>
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7470576..20fbce6 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -160,9 +160,9 @@ static void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
>  /*
>   * smmuv3_record_event - Record an event
>   */
> -void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
> -                         uint32_t sid, IOMMUAccessFlags perm,
> -                         SMMUEvtErr type)
> +static void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
> +                                uint32_t sid, IOMMUAccessFlags perm,
> +                                SMMUEvtErr type)
>  {
>      Evt evt;
>      bool rnw = perm & IOMMU_RO;
> @@ -306,6 +306,348 @@ static inline void smmu_update_base_reg(SMMUV3State *s, uint64_t *base,
>      *base = val & ~(SMMU_BASE_RA | 0x3fULL);
>  }
>
> +/*
> + * All SMMU data structures are little endian, and are aligned to 8 bytes
> + * L1STE/STE/L1CD/CD, Queue entries in CMDQ/EVTQ/PRIQ
> + */
> +static inline int smmu_get_ste(SMMUV3State *s, hwaddr addr, Ste *buf)
> +{
> +    trace_smmuv3_get_ste(addr);
> +    return dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));

Why dma_memory_read() here when we were using other memory access
functions for things like TLB table walks earlier?

Incidentally, the spec requires us to perform memory accesses as
at least 64-bit single-copy atomic (see 3.21.3) -- does this do that?
(This gets important with SMP when the guest on another CPU might
be updating the STE or page table entry at the same time as we're
reading it...)

> +}
> +
> +/*
> + * For now we only support CD with a single entry, 'ssid' is used to identify
> + * otherwise
> + */
> +static inline int smmu_get_cd(SMMUV3State *s, Ste *ste, uint32_t ssid, Cd *buf)
> +{
> +    hwaddr addr = STE_CTXPTR(ste);
> +
> +    if (STE_S1CDMAX(ste) != 0) {
> +        error_report("Multilevel Ctx Descriptor not supported yet");
> +    }
> +
> +    trace_smmuv3_get_cd(addr);
> +    return dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
> +}
> +
> +/**
> + * is_ste_consistent - Check validity of STE
> + * according to 6.2.1 Validity of STE
> + * TODO: check the relevance of each check and compliance
> + * with this spec chapter

Good idea :-)

thanks
-- PMM
