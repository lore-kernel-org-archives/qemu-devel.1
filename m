Received: from eggs.gnu.org ([209.51.188.92]:52095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1AD-0000oq-EF
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1AB-0000VL-Bg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:45 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1A7-0000RD-Dz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so24589745otm.13
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110124951.15473-1-richard.henderson@linaro.org>
	<20190110124951.15473-2-richard.henderson@linaro.org>
In-Reply-To: <20190110124951.15473-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:52:34 +0000
Message-ID: <CAFEAcA9OhGnjLOiaSwUa1OGd7sQ3M2cVXrGqUCokb2p0nBHE1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Add TBFLAG_A64_TBID,
 split out gen_top_byte_ignore
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

On Thu, 10 Jan 2019 at 12:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split out gen_top_byte_ignore in preparation of handling these
> data accesses; the new tbflags field is not yet honored.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  1 +
>  target/arm/translate.h     |  3 ++-
>  target/arm/helper.c        |  1 +
>  target/arm/translate-a64.c | 40 +++++++++++++++++---------------------
>  4 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 929f16dd6b..02e6dcce25 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2996,6 +2996,7 @@ FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
>  FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
>  FIELD(TBFLAG_A64, BT, 9, 1)
>  FIELD(TBFLAG_A64, BTYPE, 10, 2)
> +FIELD(TBFLAG_A64, TBID, 12, 2)
>
>  static inline bool bswap_code(bool sctlr_b)
>  {
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index f73939d7b4..17748ddfb9 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -26,7 +26,8 @@ typedef struct DisasContext {
>      int user;
>  #endif
>      ARMMMUIdx mmu_idx; /* MMU index to use for normal loads/stores */
> -    uint8_t tbii;      /* TBI1|TBI0 for EL0/1 or TBI for EL2/3 */
> +    uint8_t tbii;      /* TBI1|TBI0 for insns */
> +    uint8_t tbid;      /* TBI1|TBI0 for data */
>      bool ns;        /* Use non-secure CPREG bank on access */
>      int fp_excp_el; /* FP exception EL or 0 if enabled */
>      int sve_excp_el; /* SVE exception EL or 0 if enabled */
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4e9ea2ed39..8c28c6d044 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -13108,6 +13108,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>              }
>
>              flags = FIELD_DP32(flags, TBFLAG_A64, TBII, tbii);
> +            flags = FIELD_DP32(flags, TBFLAG_A64, TBID, tbid);
>          }
>  #endif
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index f225517077..9548252782 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -284,31 +284,17 @@ void gen_a64_set_pc_im(uint64_t val)
>      tcg_gen_movi_i64(cpu_pc, val);
>  }
>
> -/* Load the PC from a generic TCG variable.
> - *
> - * If address tagging is enabled via the TCR TBI bits, then loading
> - * an address into the PC will clear out any tag in it:
> - *  + for EL2 and EL3 there is only one TBI bit, and if it is set
> - *    then the address is zero-extended, clearing bits [63:56]
> - *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
> - *    and TBI1 controls addressses with bit 55 == 1.
> - *    If the appropriate TBI bit is set for the address then
> - *    the address is sign-extended from bit 55 into bits [63:56]
> - *
> - * We can avoid doing this for relative-branches, because the
> - * PC + offset can never overflow into the tag bits (assuming
> - * that virtual addresses are less than 56 bits wide, as they
> - * are currently), but we must handle it for branch-to-register.
> +/*
> + * Handle Top Byte Ignore (TBI) bits.
> + * We have concatenated tbi{1,0} into tbi.
>   */

This seems to have replaced a usefully explanatory comment
with a very terse one...

> -static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
> +static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
> +                                TCGv_i64 src, int tbi)
>  {
> -    /* Note that TBII is TBI1:TBI0.  */
> -    int tbi = s->tbii;
> -
>      if (s->current_el <= 1) {
>          if (tbi != 0) {
>              /* Sign-extend from bit 55.  */
> -            tcg_gen_sextract_i64(cpu_pc, src, 0, 56);
> +            tcg_gen_sextract_i64(dst, src, 0, 56);
>
>              if (tbi != 3) {
>                  TCGv_i64 tcg_zero = tcg_const_i64(0);
> @@ -327,13 +313,22 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>      } else {
>          if (tbi != 0) {
>              /* Force tag byte to all zero */
> -            tcg_gen_extract_i64(cpu_pc, src, 0, 56);
> +            tcg_gen_extract_i64(dst, src, 0, 56);
>              return;
>          }
>      }
>
>      /* Load unmodified address */
> -    tcg_gen_mov_i64(cpu_pc, src);
> +    tcg_gen_mov_i64(dst, src);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
