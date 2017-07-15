Received: from eggs.gnu.org ([2001:4830:134:3::10]:55023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvX-0004NH-6O
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvT-0004ym-Ao
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:39 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvT-0004yR-6C
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:35 -0400
Received: by mail-qk0-x242.google.com with SMTP id v17so14188320qka.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 14:48:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-2-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43e3d47e-4f50-3fe3-ed58-c69f5fe0136f@amsat.org>
Date: Sat, 15 Jul 2017 18:48:30 -0300
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/28] mips: cpu: move mmu/fpu/mvp_init to
 realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>

On 07/14/2017 10:51 AM, Igor Mammedov wrote:
> it will help to replace custom cpu_mips_init() with cpu_generic_init().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Yongbok Kim <yongbok.kim@imgtec.com>
> ---
>   target/mips/cpu.h            | 3 +++
>   target/mips/cpu.c            | 9 +++++++++
>   target/mips/translate.c      | 7 -------
>   target/mips/translate_init.c | 6 +++---
>   4 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 4a4747a..9c32228 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1070,4 +1070,7 @@ static inline void QEMU_NORETURN do_raise_exception(CPUMIPSState *env,
>       do_raise_exception_err(env, exception, 0, pc);
>   }
>   
> +void mips_cpu_mmu_init(CPUMIPSState *env, const mips_def_t *def);
> +void mips_cpu_fpu_init(CPUMIPSState *env, const mips_def_t *def);
> +void mips_cpu_mvp_init(CPUMIPSState *env, const mips_def_t *def);
>   #endif /* MIPS_CPU_H */
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 1bb66b7..82afdaa 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -122,9 +122,18 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info) {
>   static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> +    MIPSCPU *cpu = MIPS_CPU(dev);
> +    CPUMIPSState *env = &cpu->env;
>       MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +    env->exception_base = (int32_t)0xBFC00000;
> +#ifndef CONFIG_USER_ONLY
> +    mips_cpu_mmu_init(env, env->cpu_model);
> +#endif
> +    mips_cpu_fpu_init(env, env->cpu_model);
> +    mips_cpu_mvp_init(env, env->cpu_model);
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 559f8fe..7b3ae81 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20203,13 +20203,6 @@ MIPSCPU *cpu_mips_init(const char *cpu_model)
>       cpu = MIPS_CPU(object_new(TYPE_MIPS_CPU));
>       env = &cpu->env;
>       env->cpu_model = def;
> -    env->exception_base = (int32_t)0xBFC00000;
> -
> -#ifndef CONFIG_USER_ONLY
> -    mmu_init(env, def);
> -#endif
> -    fpu_init(env, def);
> -    mvp_init(env, def);
>   
>       object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
>   
> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
> index 6ae23e4..c771ff1 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -851,7 +851,7 @@ static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
>       env->tlb->helper_tlbinvf = r4k_helper_tlbinvf;
>   }
>   
> -static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
> +void mips_cpu_mmu_init(CPUMIPSState *env, const mips_def_t *def)
>   {
>       MIPSCPU *cpu = mips_env_get_cpu(env);
>   
> @@ -876,7 +876,7 @@ static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
>   }
>   #endif /* CONFIG_USER_ONLY */
>   
> -static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
> +void mips_cpu_fpu_init(CPUMIPSState *env, const mips_def_t *def)
>   {
>       int i;
>   
> @@ -886,7 +886,7 @@ static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
>       memcpy(&env->active_fpu, &env->fpus[0], sizeof(env->active_fpu));
>   }
>   
> -static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
> +void mips_cpu_mvp_init(CPUMIPSState *env, const mips_def_t *def)
>   {
>       env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
>   
> 
