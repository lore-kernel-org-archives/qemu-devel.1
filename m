Received: from eggs.gnu.org ([2001:4830:134:3::10]:38173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaTS-0005mY-1h
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaTO-0004rV-Px
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:38:26 -0400
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:41898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaTO-0004qe-IN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:38:22 -0400
Received: by mail-ua0-x22f.google.com with SMTP id h1-v6so8764912uao.8
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:38:22 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
Date: Tue, 31 Jul 2018 15:38:16 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 45/76] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 084ad6a..1d3dc9e 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -397,10 +397,13 @@ static int do_store_exclusive(CPUMIPSState *env)
>      target_ulong addr;
>      target_ulong page_addr;
>      target_ulong val;
> +    uint32_t val_wp = 0;
> +    uint32_t llnewval_wp = 0;
>      int flags;
>      int segv = 0;
>      int reg;
>      int d;
> +    int wp;
>  
>      addr = env->lladdr;
>      page_addr = addr & TARGET_PAGE_MASK;
> @@ -412,19 +415,31 @@ static int do_store_exclusive(CPUMIPSState *env)
>      } else {
>          reg = env->llreg & 0x1f;
>          d = (env->llreg & 0x20) != 0;
> -        if (d) {
> -            segv = get_user_s64(val, addr);
> +        wp = (env->llreg & 0x40) != 0;
> +        if (!wp) {
> +            if (d) {
> +                segv = get_user_s64(val, addr);
> +            } else {
> +                segv = get_user_s32(val, addr);
> +            }
>          } else {
>              segv = get_user_s32(val, addr);
> +            segv |= get_user_s32(val_wp, addr);
> +            llnewval_wp = env->llnewval_wp;
>          }
>          if (!segv) {
> -            if (val != env->llval) {
> +            if (val != env->llval && val_wp == llnewval_wp) {
>                  env->active_tc.gpr[reg] = 0;
>              } else {
> -                if (d) {
> -                    segv = put_user_u64(env->llnewval, addr);
> +                if (!wp) {
> +                    if (d) {
> +                        segv = put_user_u64(env->llnewval, addr);
> +                    } else {
> +                        segv = put_user_u32(env->llnewval, addr);
> +                    }
>                  } else {
>                      segv = put_user_u32(env->llnewval, addr);
> +                    segv |= put_user_u32(env->llnewval_wp, addr + 4);
>                  }
>                  if (!segv) {
>                      env->active_tc.gpr[reg] = 1;
...
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index b2a780a..deca307 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -14,6 +14,8 @@ DEF_HELPER_4(swr, void, env, tl, tl, int)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(ll, tl, env, tl, int)
>  DEF_HELPER_4(sc, tl, env, tl, tl, int)
> +DEF_HELPER_5(llwp, void, env, tl, i32, i32, i32)
> +DEF_HELPER_4(scwp, tl, env, tl, i64, int)
>  #ifdef TARGET_MIPS64
>  DEF_HELPER_3(lld, tl, env, tl, int)
>  DEF_HELPER_4(scd, tl, env, tl, tl, int)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index b3eef9f..cb83b6d 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -380,6 +380,19 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
>  #endif
>  #undef HELPER_LD_ATOMIC
>  
> +void helper_llwp(CPUMIPSState *env, target_ulong addr, uint32_t reg1,
> +                 uint32_t reg2, uint32_t mem_idx)
> +{
> +    if (addr & 0x7) {
> +        env->CP0_BadVAddr = addr;
> +        do_raise_exception(env, EXCP_AdEL, GETPC());
> +    }
> +    env->lladdr = do_translate_address(env, addr, 0, GETPC());
> +    env->active_tc.gpr[reg1] = env->llval = do_lw(env, addr, mem_idx, GETPC());
> +    env->active_tc.gpr[reg2] = env->llval_wp = do_lw(env, addr + 4, mem_idx,
> +                                                     GETPC());
> +}
> +
>  #define HELPER_ST_ATOMIC(name, ld_insn, st_insn, almask)                      \
>  target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
>                             target_ulong arg2, int mem_idx)                    \
> @@ -406,6 +419,28 @@ HELPER_ST_ATOMIC(sc, lw, sw, 0x3)
>  HELPER_ST_ATOMIC(scd, ld, sd, 0x7)
>  #endif
>  #undef HELPER_ST_ATOMIC
> +
> +target_ulong helper_scwp(CPUMIPSState *env, target_ulong addr,
> +                         uint64_t data, int mem_idx)
> +{
> +    uint32_t tmp;
> +    uint32_t tmp2;
> +
> +    if (addr & 0x7) {
> +        env->CP0_BadVAddr = addr;
> +        do_raise_exception(env, EXCP_AdES, GETPC());
> +    }
> +    if (do_translate_address(env, addr, 1, GETPC()) == env->lladdr) {
> +        tmp = do_lw(env, addr, mem_idx, GETPC());
> +        tmp2 = do_lw(env, addr + 4, mem_idx, GETPC());
> +        if (tmp == env->llval && tmp2 == env->llval_wp) {
> +            do_sw(env, addr, (uint32_t) data, mem_idx, GETPC());
> +            do_sw(env, addr + 4, (uint32_t) *(&data + 4), mem_idx, GETPC());
> +            return 1;
> +        }
> +    }
> +    return 0;
> +}
>  #endif
>  
>  #ifdef TARGET_WORDS_BIGENDIAN

All of this should be unused code.


> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ea6fdeb..c4b6a26 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1459,6 +1459,7 @@ typedef struct DisasContext {
>      bool nan2008;
>      bool abs2008;
>      bool has_isa_mode;
> +    bool xnp;
>  } DisasContext;
>  
>  #define DISAS_STOP       DISAS_TARGET_0
> @@ -2348,6 +2349,31 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>      tcg_temp_free(t0);
>  }
>  
> +static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
> +                    uint32_t reg1, uint32_t reg2)
> +{
> +    TCGv taddr = tcg_temp_new();
> +    TCGv_i64 tval = tcg_temp_new_i64();
> +    TCGv tmp1 = tcg_temp_new();
> +    TCGv tmp2 = tcg_temp_new();
> +
> +    gen_base_offset_addr(ctx, taddr, base, offset);
> +    tcg_gen_qemu_ld64(tval, taddr, ctx->mem_idx);
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    tcg_gen_extr_i64_tl(tmp2, tmp1, tval);
> +#else
> +    tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
> +#endif
> +    gen_store_gpr(tmp1, reg1);
> +    tcg_temp_free(tmp1);
> +    gen_store_gpr(tmp2, reg2);
> +    tcg_temp_free(tmp2);
> +    tcg_gen_st_i64(tval, cpu_env, offsetof(CPUMIPSState, llval_wp));
> +    tcg_temp_free_i64(tval);
> +    tcg_gen_st_tl(taddr, cpu_env, offsetof(CPUMIPSState, lladdr));
> +    tcg_temp_free(taddr);
> +}
> +
>  /* Store */
>  static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
>                      int base, int offset)
> @@ -2444,6 +2470,48 @@ static void gen_st_cond (DisasContext *ctx, uint32_t opc, int rt,
>      tcg_temp_free(t0);
>  }
>  
> +static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
> +                    uint32_t reg1, uint32_t reg2)
> +{
> +    TCGv taddr = tcg_temp_new();
> +    TCGv lladdr = tcg_temp_new();
> +    TCGv_i64 tval = tcg_temp_new_i64();
> +    TCGv_i64 llval = tcg_temp_new_i64();
> +    TCGv_i64 val = tcg_temp_new_i64();
> +    TCGv tmp1 = tcg_temp_new();
> +    TCGv tmp2 = tcg_temp_new();
> +    TCGLabel *lab_fail = gen_new_label();
> +    TCGLabel *lab_done = gen_new_label();
> +
> +    gen_base_offset_addr(ctx, taddr, base, offset);
> +
> +    tcg_gen_ld_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
> +    tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
> +
> +    gen_load_gpr(tmp1, reg1);
> +    gen_load_gpr(tmp2, reg2);
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    tcg_gen_concat_tl_i64(tval, tmp2, tmp1);
> +#else
> +    tcg_gen_concat_tl_i64(tval, tmp1, tmp2);
> +#endif
> +
> +    tcg_gen_ld_i64(llval, cpu_env, offsetof(CPUMIPSState, llval_wp));
> +    tcg_gen_atomic_cmpxchg_i64(val, taddr, llval, tval,
> +                               ctx->mem_idx, MO_64);
> +    tcg_gen_movi_tl(cpu_gpr[reg1], 1);
> +    tcg_gen_brcond_i64(TCG_COND_EQ, val, llval, lab_done);
> +
> +    gen_set_label(lab_fail);
> +
> +    tcg_gen_movi_tl(cpu_gpr[reg1], 0);
> +
> +    gen_set_label(lab_done);
> +    tcg_gen_movi_tl(lladdr, -1);
> +    tcg_gen_st_tl(lladdr, cpu_env, offsetof(CPUMIPSState, lladdr));
> +}

Because you have the implementation inline here.

And, two unprotected uses of cpu_gpr[reg1].


r~
