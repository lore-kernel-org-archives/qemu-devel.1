Received: from eggs.gnu.org ([209.51.188.92]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVdl-0004Rn-1R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVdj-0004pU-T7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVdj-0004ns-3K
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:29:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id o5so6960355pls.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:29:54 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
Date: Tue, 30 Apr 2019 09:29:48 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>  #define VSX_LXVL(name, lj)                                              \
>  void helper_##name(CPUPPCState *env, target_ulong addr,                 \
> -                   target_ulong xt_num, target_ulong rb)                \
> +                   target_ulong xt, target_ulong rb)                    \
>  {                                                                       \
> +    ppc_vsr_t *r = &env->vsr[xt];                                       \
> +    int nb = GET_NB(env->gpr[rb]);                                      \
>      int i;                                                              \
> -    ppc_vsr_t xt;                                                       \
> -    uint64_t nb = GET_NB(rb);                                           \
>                                                                          \
> -    xt.s128 = int128_zero();                                            \
> +    r->s128 = int128_zero();                                            \
>      if (nb) {                                                           \
>          nb = (nb >= 16) ? 16 : nb;                                      \
>          if (msr_le && !lj) {                                            \
>              for (i = 16; i > 16 - nb; i--) {                            \
> -                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
> +                r->VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
>                  addr = addr_add(env, addr, 1);                          \
>              }                                                           \
>          } else {                                                        \
>              for (i = 0; i < nb; i++) {                                  \
> -                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
> +                r->VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
>                  addr = addr_add(env, addr, 1);                          \
>              }                                                           \
>          }                                                               \
>      }                                                                   \
> -    putVSR(xt_num, &xt, env);                                           \
>  }

Similarly, this modifies env->vsr[xt] before all exceptions are recognized.

> @@ -304,12 +304,14 @@ static void gen_##name(DisasContext *ctx)                       \
>          }                                                       \
>      }                                                           \
>      EA = tcg_temp_new();                                        \
> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>      gen_set_access_type(ctx, ACCESS_INT);                       \
>      gen_addr_register(ctx, EA);                                 \
> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>      tcg_temp_free(EA);                                          \
>      tcg_temp_free(xt);                                          \
> +    tcg_temp_free(rb);                                          \
>  }

Why are you adjusting the function to pass the rB register number rather than
the contents of rB?  That seems the wrong way around...


r~
