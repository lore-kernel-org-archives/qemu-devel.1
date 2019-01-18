Received: from eggs.gnu.org ([209.51.188.92]:47967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkStL-0007j1-V1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkStG-0006X2-8f
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:04:55 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkStC-0006Ay-0G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:04:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so8782946oia.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-20-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 11:44:04 +0000
Message-ID: <CAFEAcA-Sxnq3_MkF2aE92yPZwF1gtENCcG8Vsrr+f_uQWBimhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 19/31] target/arm: Merge TBFLAG_AA_TB{0,
 1} to TBII
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will shortly want to talk about TBI as it relates to data.
> Passing around a pair of variables is less convenient than a
> single variable.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v3: New, split out of a later patch set.
> ---
>  target/arm/cpu.h           |  3 +--
>  target/arm/translate.h     |  3 +--
>  target/arm/helper.c        |  5 ++---
>  target/arm/translate-a64.c | 13 +++++++------
>  4 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c1d511f274..ea9b8ec4a1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2979,8 +2979,7 @@ FIELD(TBFLAG_A32, HANDLER, 21, 1)
>  FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
>
>  /* Bit usage when in AArch64 state */
> -FIELD(TBFLAG_A64, TBI0, 0, 1)
> -FIELD(TBFLAG_A64, TBI1, 1, 1)
> +FIELD(TBFLAG_A64, TBII, 0, 2)
>  FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
>  FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
>  FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index d8a8bb4e9c..bb37d35741 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -26,8 +26,7 @@ typedef struct DisasContext {
>      int user;
>  #endif
>      ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
> -    bool tbi0;         /* TBI0 for EL0/1 or TBI for EL2/3 */
> -    bool tbi1;         /* TBI1 for EL0/1, not used for EL2/3 */
> +    uint8_t tbii;      /* TBI1|TBI0 for EL0/1 or TBI for EL2/3 */
>      bool ns;        /* Use non-secure CPREG bank on access */
>      int fp_excp_el; /* FP exception EL or 0 if enabled */
>      int sve_excp_el; /* SVE exception EL or 0 if enabled */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5ee8761111..f934c80c28 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -13038,10 +13038,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>          *pc = env->pc;
>          flags = FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
>          /* Get control bits for tagged addresses */
> -        flags = FIELD_DP32(flags, TBFLAG_A64, TBI0,
> +        flags = FIELD_DP32(flags, TBFLAG_A64, TBII,
> +                           (arm_regime_tbi1(env, mmu_idx) << 1) |
>                             arm_regime_tbi0(env, mmu_idx));
> -        flags = FIELD_DP32(flags, TBFLAG_A64, TBI1,
> -                           arm_regime_tbi1(env, mmu_idx));
>
>          if (cpu_isar_feature(aa64_sve, cpu)) {
>              int sve_el = sve_exception_el(env, current_el);
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a4dfdf5836..ee92533469 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -276,13 +276,15 @@ void gen_a64_set_pc_im(uint64_t val)
>   */
>  static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>  {
> +    /* Note that TBII is TBI1:TBI0.  */
> +    int tbi = s->tbii;
>
>      if (s->current_el <= 1) {
>          /* Test if NEITHER or BOTH TBI values are set.  If so, no need to
>           * examine bit 55 of address, can just generate code.
>           * If mixed, then test via generated code
>           */
> -        if (s->tbi0 && s->tbi1) {
> +        if (tbi == 3) {
>              TCGv_i64 tmp_reg = tcg_temp_new_i64();
>              /* Both bits set, sign extension from bit 55 into [63:56] will
>               * cover both cases
> @@ -290,7 +292,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>              tcg_gen_shli_i64(tmp_reg, src, 8);
>              tcg_gen_sari_i64(cpu_pc, tmp_reg, 8);
>              tcg_temp_free_i64(tmp_reg);
> -        } else if (!s->tbi0 && !s->tbi1) {
> +        } else if (tbi == 0) {
>              /* Neither bit set, just load it as-is */
>              tcg_gen_mov_i64(cpu_pc, src);
>          } else {
> @@ -300,7 +302,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>
>              tcg_gen_andi_i64(tcg_bit55, src, (1ull << 55));
>
> -            if (s->tbi0) {
> +            if (tbi == 1) {
>                  /* tbi0==1, tbi1==0, so 0-fill upper byte if bit 55 = 0 */
>                  tcg_gen_andi_i64(tcg_tmpval, src,
>                                   0x00FFFFFFFFFFFFFFull);
> @@ -318,7 +320,7 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>              tcg_temp_free_i64(tcg_tmpval);
>          }
>      } else {  /* EL > 1 */
> -        if (s->tbi0) {
> +        if (tbi != 0) {
>              /* Force tag byte to all zero */
>              tcg_gen_andi_i64(cpu_pc, src, 0x00FFFFFFFFFFFFFFull);
>          } else {
> @@ -13806,8 +13808,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>      dc->condexec_cond = 0;
>      core_mmu_idx = FIELD_EX32(tb_flags, TBFLAG_ANY, MMUIDX);
>      dc->mmu_idx = core_to_arm_mmu_idx(env, core_mmu_idx);
> -    dc->tbi0 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI0);
> -    dc->tbi1 = FIELD_EX32(tb_flags, TBFLAG_A64, TBI1);
> +    dc->tbii = FIELD_EX32(tb_flags, TBFLAG_A64, TBII);
>      dc->current_el = arm_mmu_idx_to_el(dc->mmu_idx);
>  #if !defined(CONFIG_USER_ONLY)
>      dc->user = (dc->current_el == 0);
> --
> 2.17.2
>


-- 
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8
