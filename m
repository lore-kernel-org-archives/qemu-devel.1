Received: from eggs.gnu.org ([209.51.188.92]:56232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hBRtF-0001TG-56
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 18:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hBRtD-0006Nb-3D
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 18:28:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hBRtC-0006Mm-Fg
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 18:28:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id f10so5974653otb.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 15:28:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 3 Apr 2019 00:28:16 +0200
Message-ID: <CAL1e-=i8fUExfeinjYYrc-g19KoEJnUSXpiiL=bwr5E9OEHY+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Cc: amarkovic@wavecomp.com, qemu-devel@nongnu.org, richard.henderson@linaro.org, aurelien@aurel32.net, arikalo@wavecomp.com

On Apr 2, 2019 5:20 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com>
wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Optimize set of MSA instructions ILVEV, using directly
> tcg registers and performing logic on them instead of
> using helpers.
>
> In the following table, the first column is the performance
> before this patch. The second represents the performance,
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is the solution
> which is implemented in this patch.
>
>  instr    ||   before    || no-deposit ||  with-deposit
> ========================================================
>  ilvev.b  ||  126.92 ms  ||  24.52 ms  ||  24.43 ms
>  ilvev.h  ||   93.67 ms  ||  23.92 ms  ||  23.86 ms
>  ilvev.w  ||  117.86 ms  ||  23.83 ms  ||  22.17 ms
>  ilvev.d  ||   45.49 ms  ||  19.74 ms  ||  19.71 ms
>
> The solution with deposit is suggested by Richard Henderson.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |   1 -
>  target/mips/msa_helper.c |   9 ----
>  target/mips/translate.c  | 105
++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 104 insertions(+), 11 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 02e16c7..82f6a40 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32,
i32)
>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a7ea6aa..d5c3842 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
>      } while (0)
>  MSA_FN_DF(ilvr_df)
>  #undef MSA_DO
> -
> -#define MSA_DO(DF)                      \
> -    do {                                \
> -        pwx->DF[2*i]   = pwt->DF[2*i];  \
> -        pwx->DF[2*i+1] = pws->DF[2*i];  \
> -    } while (0)
> -MSA_FN_DF(ilvev_df)
> -#undef MSA_DO
> -
>  #undef MSA_LOOP_COND
>
>  #define MSA_LOOP_COND(DF) \
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 04406d6..e26c6a6 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -28974,6 +28974,94 @@ static inline void gen_ilvod_d(CPUMIPSState
*env, uint32_t wd,
>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
>  }
>
> +/*
> + * [MSA] ILVEV.B wd, ws, wt
> + *
> + *   Vector Interleave Even (byte data elements)
> + *
> + */
> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    const uint64_t mask = 0x00ff00ff00ff00ffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVEV.H wd, ws, wt
> + *
> + *   Vector Interleave Even (halfword data elements)
> + *
> + */
> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    TCGv_i64 t2 = tcg_temp_new_i64();
> +    const uint64_t mask = 0x0000ffff0000ffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVEV.W wd, ws, wt
> + *
> + *   Vector Interleave Even (word data elements)
> + *
> + */
> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +    const uint64_t mask = 0x00000000ffffffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws * 2], 32, 32);
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d[ws * 2 + 1],
32, 32);
> +
> +    tcg_temp_free_i64(t1);
> +}
> +

This can be further optimized this way: (doublecheck the accuracy, writing
from home)

gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
                                uint32_t ws, uint32_t wt)
{
    tcg_gen_shli_i64(msa_wr_d[wd * 2], msa_wr_d[ws * 2], 32);
    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[wt * 2], 0, 32);

tcg_gen_shli_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1], 32);
    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d[wt * 2 + 1], 0,
32);

}

> +/*
> + * [MSA] ILVEV.D wd, ws, wt
> + *
> + *   Vector Interleave Even (Double data elements)
> + *
> + */
> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> +}
> +
>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>  {
>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> @@ -29130,7 +29218,22 @@ static void gen_msa_3r(CPUMIPSState *env,
DisasContext *ctx)
>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
>          break;
>      case OPC_ILVEV_df:
> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> +        switch (df) {
> +        case DF_BYTE:
> +            gen_ilvev_b(env, wd, ws, wt);
> +            break;
> +        case DF_HALF:
> +            gen_ilvev_h(env, wd, ws, wt);
> +            break;
> +        case DF_WORD:
> +            gen_ilvev_w(env, wd, ws, wt);
> +            break;
> +        case DF_DOUBLE:
> +            gen_ilvev_d(env, wd, ws, wt);
> +            break;
> +        default:
> +            assert(0);
> +        }
>          break;
>      case OPC_BINSR_df:
>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
> --
> 2.7.4
>
>
