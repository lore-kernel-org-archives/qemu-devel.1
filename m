Received: from eggs.gnu.org ([2001:4830:134:3::10]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dLBpE-0001M2-GG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dLBpD-000608-Kx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:11:24 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dLBpD-0005zR-Fo
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:11:23 -0400
Received: by mail-io0-x244.google.com with SMTP id j200so622500ioe.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:11:22 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <20170614140209.29847-3-alex.bennee@linaro.org>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-3-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Wed, 14 Jun 2017 13:10:50 -0400
Message-ID: <CAJhHMCDxE+q34xvMLaK12Spq8RosLZP_i30Dsc=EDqtv0w8+yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/3] tcg-runtime: light re-factor of
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Alex,

On Wed, Jun 14, 2017 at 10:02 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> Just a little precursor re-factoring before I was going to add a trace
> point:
>
>   - single return point, defaulting to tcg_ctx.code_gen_epilogue
>   - move cs_base, pc and flags inside the jump cache hit scope
>   - calculate the tb_jmp_cache hash once
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tcg-runtime.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Phew, glad you got this figured out! I tested it on the images I have
and it works. Please add:

Tested-by: Pranith Kumar <bobby.prani@gmail.com>


>
> diff --git a/tcg-runtime.c b/tcg-runtime.c
> index 7fa90ce508..f4bfa9cea6 100644
> --- a/tcg-runtime.c
> +++ b/tcg-runtime.c
> @@ -147,30 +147,33 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>  void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
>  {
>      CPUState *cpu =3D ENV_GET_CPU(env);
> +    unsigned int addr_hash =3D tb_jmp_cache_hash_func(addr);
> +    void *code_ptr =3D NULL;
>      TranslationBlock *tb;
> -    target_ulong cs_base, pc;
> -    uint32_t flags;
>
> -    tb =3D atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(add=
r)]);
> +    tb =3D atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
>      if (likely(tb)) {
> +        target_ulong cs_base, pc;
> +        uint32_t flags;
> +
>          cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> +
>          if (likely(tb->pc =3D=3D addr && tb->cs_base =3D=3D cs_base &&
>                     tb->flags =3D=3D flags)) {
> -            goto found;
> -        }
> -        tb =3D tb_htable_lookup(cpu, addr, cs_base, flags);
> -        if (likely(tb)) {
> -            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)],=
 tb);
> -            goto found;
> +            code_ptr =3D tb->tc_ptr;
> +        } else {
> +            /* If we didn't find it in the jmp_cache we still might
> +             * find it in the global tb_htable
> +             */
> +            tb =3D tb_htable_lookup(cpu, addr, cs_base, flags);
> +            if (likely(tb)) {
> +                atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
> +                code_ptr =3D tb->tc_ptr;
> +            }
>          }
>      }
> -    return tcg_ctx.code_gen_epilogue;
> - found:
> -    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
> -                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
> -                           tb->tc_ptr, cpu->cpu_index, addr,
> -                           lookup_symbol(addr));
> -    return tb->tc_ptr;
> +
> +    return code_ptr ? code_ptr : tcg_ctx.code_gen_epilogue;
>  }
>
>  void HELPER(exit_atomic)(CPUArchState *env)
> --
> 2.13.0
>
>
