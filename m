Received: from eggs.gnu.org ([2001:4830:134:3::10]:38551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQFB-0000c5-QG
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQF8-0007Tw-IG
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:35:09 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQF8-0007TK-BW
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:35:06 -0400
Received: by mail-lf0-x22c.google.com with SMTP id v20so4335679lfa.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:35:06 -0700 (PDT)
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-2-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614194821.8754-2-rth@twiddle.net>
Date: Thu, 15 Jun 2017 09:35:39 +0100
Message-ID: <87wp8dmyw4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] tcg: Refactor helper_lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com


Richard Henderson <rth@twiddle.net> writes:

> We can call tb_htable_lookup even when the tb_jmp_cache
> is completely empty.  Therefore, un-nest most of the code
> dependent on tb != NULL from the read from the cache.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg-runtime.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/tcg-runtime.c b/tcg-runtime.c
> index 7fa90ce..a35c725 100644
> --- a/tcg-runtime.c
> +++ b/tcg-runtime.c
> @@ -147,30 +147,32 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>  void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
>  {
>      CPUState *cpu = ENV_GET_CPU(env);
> +    void *ret = tcg_ctx.code_gen_epilogue;
>      TranslationBlock *tb;
>      target_ulong cs_base, pc;
> -    uint32_t flags;
> -
> -    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
> -    if (likely(tb)) {
> -        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> -        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
> -                   tb->flags == flags)) {
> -            goto found;
> -        }
> +    uint32_t flags, addr_hash;
> +
> +    addr_hash = tb_jmp_cache_hash_func(addr);
> +    tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
> +    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> +
> +    if (unlikely(!(tb
> +                   && tb->pc == addr
> +                   && tb->cs_base == cs_base
> +                   && tb->flags == flags))) {
>          tb = tb_htable_lookup(cpu, addr, cs_base, flags);
> -        if (likely(tb)) {
> -            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
> -            goto found;
> +        if (!tb) {
> +            return ret;
>          }
> +        atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
>      }
> -    return tcg_ctx.code_gen_epilogue;
> - found:
> +
> +    ret = tb->tc_ptr;
>      qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
>                             "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
> -                           tb->tc_ptr, cpu->cpu_index, addr,
> +                           ret, cpu->cpu_index, addr,
>                             lookup_symbol(addr));
> -    return tb->tc_ptr;
> +    return ret;
>  }
>
>  void HELPER(exit_atomic)(CPUArchState *env)


--
Alex Bennée
