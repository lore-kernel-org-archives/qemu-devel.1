Received: from eggs.gnu.org ([209.51.188.92]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm26M-0000EW-Ov
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm26K-0001eF-TR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:52:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm26K-0001bW-Ic
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:52:48 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so24803891otl.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-6-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 13:50:53 +0000
Message-ID: <CAFEAcA_j3HkMWjngXRhLNPZ3yqYrJgM+Kn2RnZJ8za-n33zSiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/11] target/arm: Default handling of
 BTYPE during translation
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

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The branch target exception for guarded pages has high priority,
> and only 8 instructions are valid for that case.  Perform this
> check before doing any other decode.
>
> Clear BTYPE after all insns that neither set BTYPE nor exit via
> exception (DISAS_NORETURN).
>
> Not yet handled are insns that exit via DISAS_NORETURN for some
> other reason, like direct branches.
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index 3d5e8bacac..f73939d7b4 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -71,8 +71,13 @@ typedef struct DisasContext {
>      bool pauth_active;
>      /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
>      bool bt;
> -    /* A copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.  */
> -    uint8_t btype;
> +    /*
> +     * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
> +     *  < 0, set by the current instruction.
> +     */
> +    int8_t btype;

You could have made this int8_t to start with...

> +    /* True if this page is guarded.  */
> +    bool guarded_page;
>      /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
>      int c15_cpar;
>      /* TCG op of the current insn_start.  */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index ca2ae40701..68eb27089a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -128,6 +128,16 @@ static inline int get_a64_user_mem_index(DisasContext *s)
>      return arm_to_core_mmu_idx(useridx);
>  }
>
> +static void reset_btype(DisasContext *s)
> +{
> +    if (s->btype != 0) {
> +        TCGv_i32 zero = tcg_const_i32(0);
> +        tcg_gen_st_i32(zero, cpu_env, offsetof(CPUARMState, btype));
> +        tcg_temp_free_i32(zero);
> +        s->btype = 0;
> +    }
> +}
> +
>  void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>                              fprintf_function cpu_fprintf, int flags)
>  {
> @@ -13716,6 +13726,90 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
>      }
>  }
>
> +/**
> + * is_guarded_page:
> + * @env: The cpu environment
> + * @s: The DisasContext
> + *
> + * Return true if the page is guarded.
> + */
> +static bool is_guarded_page(CPUARMState *env, DisasContext *s)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return false;  /* FIXME */
> +#else
> +    uint64_t addr = s->base.pc_first;
> +    int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
> +    unsigned int index = tlb_index(env, mmu_idx, addr);
> +    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
> +
> +    /*
> +     * We test this immediately after reading an insn, which means
> +     * that any normal page must be in the TLB.  The only exception
> +     * would be for executing from flash or device memory, which
> +     * does not retain the TLB entry.
> +     *
> +     * FIXME: Assume false for those, for now.  We could use
> +     * arm_cpu_get_phys_page_attrs_debug to re-read the page
> +     * table entry even for that case.
> +     */
> +    return (tlb_hit(entry->addr_code, addr) &&
> +            env->iotlb[mmu_idx][index].attrs.guarded);
> +#endif
> +}
> +
> +/**
> + * btype_destination_ok:
> + * @insn: The instruction at the branch destination
> + * @bt: SCTLR_ELx.BT
> + * @btype: PSTATE.BTYPE, and is non-zero
> + *
> + * On a guarded page, there are a limited number of insns
> + * that may be present at the branch target:
> + *   - branch target identifiers,
> + *   - paciasp, pacibsp,
> + *   - BRK insn
> + *   - HLT insn
> + * Anything else causes a Branch Target Exception.
> + *
> + * Return true if the branch is compatible, false to raise BTITRAP.
> + */
> +static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
> +{
> +    if ((insn & 0xfffff01fu) == 0xd503201fu) {
> +        /* HINT space */
> +        switch (extract32(insn, 5, 7)) {
> +        case 031: /* PACIASP */
> +        case 033: /* PACIBSP */

Octal again...

> +            /*
> +             * If SCTLR_ELx.BT, then PACI*SP are not compatible
> +             * with btype == 3.  Otherwise all btype are ok.
> +             */
> +            return !bt || btype != 3;
> +        case 040: /* BTI */
> +            /* Not compatible with any btype.  */
> +            return false;
> +        case 042: /* BTI c */
> +            /* Not compatible with btype == 3 */
> +            return btype != 3;
> +        case 044: /* BTI j */
> +            /* Not compatible with btype == 2 */
> +            return btype != 2;
> +        case 046: /* BTI jc */
> +            /* Compatible with any btype.  */
> +            return true;
> +        }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
