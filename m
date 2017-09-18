Received: from eggs.gnu.org ([2001:4830:134:3::10]:43752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtuWo-0004nO-B1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtuWj-0001Uf-Du
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:47:54 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:48129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtuWj-0001UD-2j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:47:49 -0400
Received: by mail-wr0-x229.google.com with SMTP id 108so236729wra.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:47:48 -0700 (PDT)
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<20170914183516.19537-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170914183516.19537-2-richard.henderson@linaro.org>
Date: Mon, 18 Sep 2017 12:47:46 +0100
Message-ID: <8760cgjkil.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/10] target/i386: Convert to
 disas_set_info hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  disas.c                 | 22 ++--------------------
>  monitor.c               | 21 ---------------------
>  target/i386/cpu.c       | 12 ++++++++++++
>  target/i386/translate.c |  8 +-------
>  4 files changed, 15 insertions(+), 48 deletions(-)
>
> diff --git a/disas.c b/disas.c
> index d6a1eb9c8e..2be716fdb2 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -205,16 +205,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
>          cc->disas_set_info(cpu, &s.info);
>      }
>
> -#if defined(TARGET_I386)
> -    if (flags == 2) {
> -        s.info.mach = bfd_mach_x86_64;
> -    } else if (flags == 1) {
> -        s.info.mach = bfd_mach_i386_i8086;
> -    } else {
> -        s.info.mach = bfd_mach_i386_i386;
> -    }
> -    s.info.print_insn = print_insn_i386;
> -#elif defined(TARGET_PPC)
> +#if defined(TARGET_PPC)
>      if ((flags >> 16) & 1) {
>          s.info.endian = BFD_ENDIAN_LITTLE;
>      }
> @@ -390,16 +381,7 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>          cc->disas_set_info(cpu, &s.info);
>      }
>
> -#if defined(TARGET_I386)
> -    if (flags == 2) {
> -        s.info.mach = bfd_mach_x86_64;
> -    } else if (flags == 1) {
> -        s.info.mach = bfd_mach_i386_i8086;
> -    } else {
> -        s.info.mach = bfd_mach_i386_i386;
> -    }
> -    s.info.print_insn = print_insn_i386;
> -#elif defined(TARGET_PPC)
> +#if defined(TARGET_PPC)
>      if (flags & 0xFFFF) {
>          /* If we have a precise definition of the instruction set, use it. */
>          s.info.mach = flags & 0xFFFF;
> diff --git a/monitor.c b/monitor.c
> index 9239f7adde..3f3ebc31ef 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1310,27 +1310,6 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>
>      if (format == 'i') {
>          int flags = 0;
> -#ifdef TARGET_I386
> -        CPUArchState *env = mon_get_cpu_env();
> -        if (wsize == 2) {
> -            flags = 1;
> -        } else if (wsize == 4) {
> -            flags = 0;
> -        } else {
> -            /* as default we use the current CS size */
> -            flags = 0;
> -            if (env) {
> -#ifdef TARGET_X86_64
> -                if ((env->efer & MSR_EFER_LMA) &&
> -                    (env->segs[R_CS].flags & DESC_L_MASK))
> -                    flags = 2;
> -                else
> -#endif
> -                if (!(env->segs[R_CS].flags & DESC_B_MASK))
> -                    flags = 1;
> -            }
> -        }
> -#endif
>  #ifdef TARGET_PPC
>          CPUArchState *env = mon_get_cpu_env();
>          flags = msr_le << 16;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69676e13e1..b869a69c53 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4099,6 +4099,17 @@ static bool x86_cpu_has_work(CPUState *cs)
>              !(env->hflags & HF_SMM_MASK));
>  }
>
> +static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +
> +    info->mach = (env->hflags & HF_CS64_MASK ? bfd_mach_x86_64
> +                  : env->hflags & HF_CS32_MASK ? bfd_mach_i386_i386
> +                  : bfd_mach_i386_i8086);
> +    info->print_insn = print_insn_i386;
> +}
> +
>  static Property x86_cpu_properties[] = {
>  #ifdef CONFIG_USER_ONLY
>      /* apic_id = 0 by default for *-user, see commit 9886e834 */
> @@ -4204,6 +4215,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
>  #endif
>      cc->cpu_exec_enter = x86_cpu_exec_enter;
>      cc->cpu_exec_exit = x86_cpu_exec_exit;
> +    cc->disas_set_info = x86_disas_set_info;
>
>      dc->user_creatable = true;
>  }
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index de0c989763..06c2cb9e64 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8526,15 +8526,9 @@ static void i386_tr_disas_log(const DisasContextBase *dcbase,
>                                CPUState *cpu)
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
> -    int disas_flags = !dc->code32;
>
>      qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
> -#ifdef TARGET_X86_64
> -    if (dc->code64) {
> -        disas_flags = 2;
> -    }
> -#endif
> -    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size, disas_flags);
> +    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size, 0);
>  }
>
>  static const TranslatorOps i386_tr_ops = {


--
Alex Bennée
