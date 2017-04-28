Received: from eggs.gnu.org ([2001:4830:134:3::10]:45307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d438r-0008KT-74
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d438n-0002JA-0b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:28:49 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d438m-0002J0-Pr
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:28:44 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w64so38454013wma.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 03:28:44 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-6-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-6-rth@twiddle.net>
Date: Fri, 28 Apr 2017 11:29:14 +0100
Message-ID: <87wpa47rlx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/19] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> This paves the way for upcoming work.
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Message-Id: <1493263764-18657-3-git-send-email-cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg-runtime.c     | 24 ++++++++++++++++++++++++
>  tcg/tcg-runtime.h |  2 ++
>  tcg/tcg.h         |  1 +
>  3 files changed, 27 insertions(+)
>
> diff --git a/tcg-runtime.c b/tcg-runtime.c
> index 4c60c96..8a24bdd 100644
> --- a/tcg-runtime.c
> +++ b/tcg-runtime.c
> @@ -27,6 +27,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/cpu_ldst.h"
>  #include "exec/exec-all.h"
> +#include "exec/tb-hash.h"
>
>  /* 32-bit helpers */
>
> @@ -141,6 +142,29 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>      return ctpop64(arg);
>  }
>
> +void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
> +{
> +    CPUState *cpu = ENV_GET_CPU(env);
> +    TranslationBlock *tb;
> +    target_ulong cs_base, pc;
> +    uint32_t flags;
> +
> +    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
> +    if (likely(tb)) {
> +        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> +        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
> +                   tb->flags == flags)) {
> +            return tb->tc_ptr;
> +        }
> +        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
> +        if (likely(tb)) {
> +            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
> +            return tb->tc_ptr;
> +        }
> +    }
> +    return tcg_ctx.code_gen_epilogue;

Minor comments: I did notice is given we rely on the backends to set this up
in later patches if it is worth adding an assert (or tcg_debug_assert?)
to catch this early if a new backend doesn't set this up?

> +}
> +
>  void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
> diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
> index 114ea6f..c41d38a 100644
> --- a/tcg/tcg-runtime.h
> +++ b/tcg/tcg-runtime.h
> @@ -24,6 +24,8 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
>  DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
>  DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
>
> +DEF_HELPER_FLAGS_2(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env, tl)
> +
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
>  #ifdef CONFIG_SOFTMMU
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 6c216bb..5ec48d1 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -699,6 +699,7 @@ struct TCGContext {
>         extension that allows arithmetic on void*.  */
>      int code_gen_max_blocks;
>      void *code_gen_prologue;
> +    void *code_gen_epilogue;
>      void *code_gen_buffer;
>      size_t code_gen_buffer_size;
>      void *code_gen_ptr;


--
Alex Bennée
