Received: from eggs.gnu.org ([2001:4830:134:3::10]:40204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDyZ-0000pY-FL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDyW-0005R8-Dj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:31 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDyW-0005Qi-7v
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:28 -0400
Received: by mail-wr0-x234.google.com with SMTP id 77so25504575wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:30:28 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149943131289.8972.14899352517803578316.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149943131289.8972.14899352517803578316.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:30:25 +0100
Message-ID: <871spm9f4e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 15/27] target/arm: [tcg,
 a64] Port to init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c |   36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4270ac3847..5c04ff3d8b 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11190,21 +11190,12 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
>      free_tmp_a64(s);
>  }
>
> -void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
> -                               TranslationBlock *tb)
> +static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
> +                                               CPUState *cpu)
>  {
> -    CPUARMState *env = cs->env_ptr;
> -    ARMCPU *cpu = arm_env_get_cpu(env);
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
> -    target_ulong next_page_start;
> -    int max_insns;
> -
> -    dc->base.tb = tb;
> -    dc->base.pc_first = dc->base.tb->pc;
> -    dc->base.pc_next = dc->base.pc_first;
> -    dc->base.is_jmp = DISAS_NEXT;
> -    dc->base.num_insns = 0;
> -    dc->base.singlestep_enabled = cs->singlestep_enabled;
> +    CPUARMState *env = cpu->env_ptr;
> +    ARMCPU *arm_cpu = arm_env_get_cpu(env);
>
>      dc->pc = dc->base.pc_first;
>      dc->condjmp = 0;
> @@ -11230,7 +11221,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
>      dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
>      dc->vec_len = 0;
>      dc->vec_stride = 0;
> -    dc->cp_regs = cpu->cp_regs;
> +    dc->cp_regs = arm_cpu->cp_regs;
>      dc->features = env->features;
>
>      /* Single step state. The code-generation logic here is:
> @@ -11254,6 +11245,23 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
>      dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
>
>      init_tmp_a64_array(dc);
> +}
> +
> +void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
> +                               TranslationBlock *tb)
> +{
> +    CPUARMState *env = cs->env_ptr;
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    target_ulong next_page_start;
> +    int max_insns;
> +
> +    dc->base.tb = tb;
> +    dc->base.pc_first = dc->base.tb->pc;
> +    dc->base.pc_next = dc->base.pc_first;
> +    dc->base.is_jmp = DISAS_NEXT;
> +    dc->base.num_insns = 0;
> +    dc->base.singlestep_enabled = cs->singlestep_enabled;
> +    aarch64_tr_init_disas_context(&dc->base, cs);
>
>      next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>      max_insns = dc->base.tb->cflags & CF_COUNT_MASK;


--
Alex Bennée
