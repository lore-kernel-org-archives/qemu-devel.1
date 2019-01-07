Received: from eggs.gnu.org ([209.51.188.92]:59960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTH0-0004QQ-72
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTGy-00035y-7c
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:40:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTGy-00035M-0w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:40:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so47135otl.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-18-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:40:35 +0000
Message-ID: <CAFEAcA9k9rwE=_uU0z0Go7unZB4FTs84k6S3wzp-nzf5hRtsPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 17/27] target/arm: Create
 ARMVAParameters and helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split out functions to extract the virtual address parameters.
> Let the functions choose T0 or T1 address space half, if present.
> Extract (most of) the control bits that vary between EL or Tx.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v2: Incorporate feedback wrt VTCR, HTCR, and more.
> ---
>  target/arm/internals.h |  16 +++
>  target/arm/helper.c    | 286 +++++++++++++++++++++++------------------
>  2 files changed, 174 insertions(+), 128 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1d0d0392c9..9ef9d01ee2 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -935,4 +935,20 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
>  ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
>  #endif
>
> +/*
> + * Parameters of a given virtual address, as extracted from a the

"a" or "the" but not both :-)

> + * translation control register (TCR) for a given regime.
> + */
> +typedef struct ARMVAParameters {
> +    unsigned tsz    : 8;
> +    unsigned select : 1;
> +    bool tbi        : 1;
> +    bool epd        : 1;
> +    bool hpd        : 1;
> +    bool ha         : 1;
> +    bool hd         : 1;
> +    bool using16k   : 1;
> +    bool using64k   : 1;
> +} ARMVAParameters;
> +
>  #endif
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b1c0ff923f..3422fa5943 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9744,6 +9744,133 @@ static uint8_t convert_stage2_attrs(CPUARMState *env, uint8_t s2attrs)
>      return (hiattr << 6) | (hihint << 4) | (loattr << 2) | lohint;
>  }
>
> +static ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
> +                                          ARMMMUIdx mmu_idx, bool data)
> +{
> +    uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
> +    uint32_t el = regime_el(env, mmu_idx);
> +    bool tbi, tbid, epd, hpd, ha, hd, using16k, using64k;
> +    int select, tsz;
> +
> +    /* Bit 55 is always between the two regions, and is canonical for
> +     * determining if address tagging is enabled.
> +     */
> +    select = extract64(va, 55, 1);
> +
> +    if (el > 1) {
> +        tsz = extract32(tcr, 0, 6);
> +        using64k = extract32(tcr, 14, 1);
> +        using16k = extract32(tcr, 15, 1);
> +        if (mmu_idx == ARMMMUIdx_S2NS) {
> +            /* VTCR_EL2 */
> +            tbi = tbid = hpd = false;
> +        } else {
> +            tbi = extract32(tcr, 20, 1);
> +            hpd = extract32(tcr, 24, 1);
> +            tbid = extract32(tcr, 29, 1);
> +        }
> +        ha = extract32(tcr, 21, 1);
> +        hd = extract32(tcr, 22, 1);
> +        epd = false;
> +    } else if (!select) {
> +        tsz = extract32(tcr, 0, 6);
> +        epd = extract32(tcr, 7, 1);
> +        using64k = extract32(tcr, 14, 1);
> +        using16k = extract32(tcr, 15, 1);
> +        tbi = extract64(tcr, 37, 1);
> +        ha = extract64(tcr, 39, 1);
> +        hd = extract64(tcr, 40, 1);
> +        hpd = extract64(tcr, 41, 1);
> +        tbid = extract64(tcr, 51, 1);
> +    } else {
> +        int tg = extract32(tcr, 30, 2);
> +        using16k = tg == 1;
> +        using64k = tg == 3;
> +        tsz = extract32(tcr, 16, 6);
> +        epd = extract32(tcr, 23, 1);
> +        tbi = extract64(tcr, 38, 1);
> +        ha = extract64(tcr, 39, 1);
> +        hd = extract64(tcr, 40, 1);
> +        hpd = extract64(tcr, 42, 1);
> +        tbid = extract64(tcr, 52, 1);
> +    }
> +    tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
> +    tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
> +
> +    return (ARMVAParameters) {
> +        .tsz = tsz,
> +        .select = select,
> +        .tbi = tbi & (data | !tbid),

This check on TBID is a behaviour change, isn't it ?
Can we please keep the "no change refactoring" separate from
"add new behaviour"? This patch is tricky enough to review
already. (I like the way the code ends up, but it has taken
me a fair amount of time to try to confirm that it does indeed
do the same thing as the old code, and I'm still not completely
sure about the changes in the ttbr select logic, though I
think it ends up doing the same thing.)

Similarly, .ha and .hd are new, I think, so could be added
in a later patch (presumably with whatever uses them).

thanks
-- PMM
