Received: from eggs.gnu.org ([2001:4830:134:3::10]:39249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHqGi-0005YS-81
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHqGe-0006vA-9q
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:01:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHqGe-0006ut-0R
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:01:36 -0500
Received: by mail-wm0-x244.google.com with SMTP id a20so4662959wme.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 03:01:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <94eb2c0bfa1c6a9fec0543057483@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66919538-7a30-73aa-7b55-13fdf59156cc@redhat.com>
Date: Fri, 16 Dec 2016 12:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <94eb2c0bfa1c6a9fec0543057483@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: Fix eflags.TF/#DB handling of
 syscall/sysret insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Evans <dje@google.com>, qemu-devel@nongnu.org, rth@twiddle.net



On 07/12/2016 00:06, Doug Evans wrote:
> Hi.
> 
> While qemu's behaviour matches what one would expect from reading
> the docs, it does not match what I'm seeing on h/w.
> Can anyone else confirm what the correct behaviour is here?
> 
> ---
> 
> The syscall and sysret instructions behave a bit differently:
> TF is checked after the instruction completes.
> This allows the o/s to disable #DB at a syscall by adding TF to FMASK.
> And then when the sysret is executed the #DB is taken "as if" the
> syscall insn just completed.
> 
> Signed-off-by: Doug Evans <dje@google.com>
> ---
>  target-i386/bpt_helper.c | 12 ++++++++++++
>  target-i386/helper.h     |  1 +
>  target-i386/translate.c  | 29 ++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/target-i386/bpt_helper.c b/target-i386/bpt_helper.c
> index 6fd7fe0..d771461 100644
> --- a/target-i386/bpt_helper.c
> +++ b/target-i386/bpt_helper.c
> @@ -244,6 +244,18 @@ void helper_single_step(CPUX86State *env)
>      raise_exception(env, EXCP01_DB);
>  }
> 
> +void helper_rechecking_single_step(CPUX86State *env)
> +{
> +    if ((env->eflags & TF_MASK) != 0)
> +    {
> +#ifndef CONFIG_USER_ONLY
> +        check_hw_breakpoints(env, true);
> +        env->dr[6] |= DR6_BS;
> +#endif
> +        raise_exception(env, EXCP01_DB);
> +    }

Please call helper_single_step here.  Also, a comment on coding
style---the brace goes on the same line as the "if".  You can use
scripts/checkpatch.pl to check the form of your patch.

Do not use your email client to send patches, as that might result in
format=flowed messages which look good in the client but cannot be
processed by the tools.  Use git send-email instead.

Thanks,

Paolo

> +}
> +
>  void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
>  {
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target-i386/helper.h b/target-i386/helper.h
> index 4e859eb..bd9b2cf 100644
> --- a/target-i386/helper.h
> +++ b/target-i386/helper.h
> @@ -79,6 +79,7 @@ DEF_HELPER_2(cmpxchg16b_unlocked, void, env, tl)
>  DEF_HELPER_2(cmpxchg16b, void, env, tl)
>  #endif
>  DEF_HELPER_1(single_step, void, env)
> +DEF_HELPER_1(rechecking_single_step, void, env)
>  DEF_HELPER_1(cpuid, void, env)
>  DEF_HELPER_1(rdtsc, void, env)
>  DEF_HELPER_1(rdtscp, void, env)
> diff --git a/target-i386/translate.c b/target-i386/translate.c
> index 9fd1a04..42d036e 100644
> --- a/target-i386/translate.c
> +++ b/target-i386/translate.c
> @@ -2500,8 +2500,10 @@ static void gen_bnd_jmp(DisasContext *s)
>  }
> 
>  /* Generate an end of block. Trace exception is also generated if needed.
> -   If IIM, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
> -static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
> +   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.
> +   If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
> +   S->TF.  This is used by the syscall/sysret insns.  */
> +static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
>  {
>      gen_update_cc_op(s);
> 
> @@ -2517,6 +2519,9 @@ static void gen_eob_inhibit_irq(DisasContext *s,
> bool inhibit)
>      }
>      if (s->singlestep_enabled) {
>          gen_helper_debug(cpu_env);
> +    } else if (recheck_tf) {
> +        gen_helper_rechecking_single_step(cpu_env);
> +        tcg_gen_exit_tb(0);
>      } else if (s->tf) {
>          gen_helper_single_step(cpu_env);
>      } else {
> @@ -2525,10 +2530,17 @@ static void gen_eob_inhibit_irq(DisasContext *s,
> bool inhibit)
>      s->is_jmp = DISAS_TB_JUMP;
>  }
> 
> +/* End of block.
> +   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
> +static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
> +{
> +    gen_eob_worker(s, inhibit, false);
> +}
> +
>  /* End of block, resetting the inhibit irq flag.  */
>  static void gen_eob(DisasContext *s)
>  {
> -    gen_eob_inhibit_irq(s, false);
> +    gen_eob_worker(s, false, false);
>  }
> 
>  /* generate a jump to eip. No segment change must happen before as a
> @@ -7108,7 +7120,10 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>          if (s->lma) {
>              set_cc_op(s, CC_OP_EFLAGS);
>          }
> -        gen_eob(s);
> +        /* TF handling for the syscall insn is different. The TF bit is
> checked
> +           after the syscall insn completes. This allows #DB to not be
> +           generated after one has entered CPL0 if TF is set in FMASK.  */
> +        gen_eob_worker(s, false, true);
>          break;
>      case 0x107: /* sysret */
>          if (!s->pe) {
> @@ -7119,7 +7134,11 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>              if (s->lma) {
>                  set_cc_op(s, CC_OP_EFLAGS);
>              }
> -            gen_eob(s);
> +            /* TF handling for the sysret insn is different. The TF bit is
> +               checked after the sysret insn completes. This allows #DB
> to be
> +               generated "as if" the syscall insn in userspace has just
> +               completed.  */
> +            gen_eob_worker(s, false, true);
>          }
>          break;
>  #endif
