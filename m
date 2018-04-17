Received: from eggs.gnu.org ([2001:4830:134:3::10]:48339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8OCb-0005Ty-JB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8OCX-0001zb-1O
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:51:09 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8OCW-0001wL-PC
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:51:04 -0400
Received: by mail-ot0-x242.google.com with SMTP id w4-v6so1867295ote.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 03:51:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-10-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-10-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 11:50:43 +0100
Message-ID: <CAFEAcA975eWahb21gKHXJ0g1yenkmuYx4dysNgPZb_qEQ7FCMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 09/17] hw/arm/smmuv3: Implement
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
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:38, Eric Auger <eric.auger@redhat.com> wrote:
> This patch implements the IOMMU Memory Region translate()
> callback. Most of the code relates to the translation
> configuration decoding and check (STE, CD).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

> +/* @ssid > 0 not supported yet */
> +static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
> +                       CD *buf, SMMUEventInfo *event)
> +{
> +    dma_addr_t addr = STE_CTXPTR(ste);
> +    int ret;
> +
> +    trace_smmuv3_get_cd(addr);
> +    /* TODO: guarantee 64-bit single-copy atomicity */
> +    ret = dma_memory_read(&address_space_memory, addr,
> +                           (void *)buf, sizeof(*buf));
> +    if (ret != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
> +        event->type = SMMU_EVT_F_CD_FETCH;
> +        event->u.f_ste_fetch.addr = addr;
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +/* Returns <0 if the caller has no need to purse the translation */

Typo, but I'm not sure what you meant instead of "purse".

> +static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> +                      STE *ste, SMMUEventInfo *event)
> +{
> +    uint32_t config = STE_CONFIG(ste);
> +    int ret = -EINVAL;
> +
> +    if (STE_CFG_ABORT(config)) {
> +        cfg->aborted = true; /* abort but don't record any event */
> +        return ret;
> +    }
> +
> +    if (STE_CFG_BYPASS(config)) {
> +        cfg->bypassed = true;
> +        return ret;
> +    }
> +
> +    if (!STE_VALID(ste)) {
> +        goto bad_ste;
> +    }

This check is happening too late -- if STE.V is 0 then other STE fields
must be ignored, including STE.Config, so it has to be done as the first
thing in this function.

> +
> +    if (STE_CFG_S2_ENABLED(config)) {
> +        qemu_log_mask(LOG_UNIMP, "SMMUv3 does not support stage 2 yet\n");
> +        goto bad_ste;
> +    }
> +
> +    if (STE_S1CDMAX(ste) != 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "SMMUv3 does not support multiple context descriptors yet\n");
> +        goto bad_ste;
> +    }
> +
> +    if (STE_S1STALLD(ste)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "SMMUv3 S1 stalling fault model not allowed yet\n");
> +        goto bad_ste;
> +    }
> +    return 0;
> +
> +bad_ste:
> +    event->type = SMMU_EVT_C_BAD_STE;
> +    return -EINVAL;
> +}

> +static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> +{
> +    int ret = -EINVAL;
> +    int i;
> +
> +    if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
> +        goto bad_cd;
> +    }
> +
> +    /* we support only those at the moment */
> +    cfg->aa64 = true;
> +    cfg->stage = 1;
> +
> +    cfg->oas = oas2bits(CD_IPS(cd));
> +    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> +    cfg->tbi = CD_TBI(cd);
> +    cfg->asid = CD_ASID(cd);
> +
> +    trace_smmuv3_decode_cd(cfg->oas);
> +
> +    /* decode data dependent on TT */
> +    for (i = 0; i <= 1; i++) {
> +        int tg, tsz;
> +        SMMUTransTableInfo *tt = &cfg->tt[i];
> +
> +        cfg->tt[i].disabled = CD_EPD(cd, i);
> +        if (cfg->tt[i].disabled) {
> +            continue;
> +        }
> +
> +        if (!CD_A(cd)) {
> +            goto bad_cd; /* SMMU_IDR0.TERM_MODEL == 1 */
> +        }
> +        if (CD_S(cd)) {
> +            goto bad_cd; /* !STE_SECURE && SMMU_IDR0.STALL_MODEL == 1 */
> +        }
> +        if (CD_HA(cd) || CD_HD(cd)) {
> +            goto bad_cd; /* HTTU = 0 */
> +        }

The location of this check means you're going to be ignoring HA and HD
if EPD0 and EPD1 are both zero, which isn't what the spec says.
Since the HA/HD bits aren't dependent on EPD*, it would make more sense
for this check to be outside the for() loop. This applies
to some of the other checks too: check the pseudocode CD_ILLEGAL
expression and in particular which parts of it involve checks for
N_TRANS_CFG0 or N_TRANSL_CFG1. At least the CD_A and CD_S checks
should also be outside the loop.

> +
> +        tsz = CD_TSZ(cd, i);
> +        if (tsz < 16 || tsz > 39) {
> +            goto bad_cd;
> +        }
> +
> +        tg = CD_TG(cd, i);
> +        tt->granule_sz = tg2granule(tg, i);
> +        if ((tt->granule_sz != 12 && tt->granule_sz != 16) || CD_ENDI(cd)) {
> +            goto bad_cd;
> +        }
> +
> +        tt->tsz = tsz;
> +        tt->initial_level = 4 - (64 - tsz - 4) / (tt->granule_sz - 3);
> +        tt->ttb = CD_TTB(cd, i);
> +        if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
> +            goto bad_cd;
> +        }
> +        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb,
> +                                  tt->granule_sz, tt->initial_level);
> +    }
> +
> +    event->record_trans_faults = CD_R(cd);
> +
> +    return 0;
> +
> +bad_cd:
> +    event->type = SMMU_EVT_C_BAD_CD;
> +    return ret;
> +}

thanks
-- PMM
