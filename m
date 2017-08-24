Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiAz-0002yq-V0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiAy-0002jV-N8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:47:22 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiAy-0002jD-JA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:47:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id e15so1152675qti.5
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:47:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-5-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12eda37d-c853-2c10-bc82-b4b03c98262b@amsat.org>
Date: Wed, 23 Aug 2017 23:47:16 -0300
MIME-Version: 1.0
In-Reply-To: <1503050939-227939-5-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 04/27] sparc: move adhoc
 CPUSPARCState initialization to realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 08/18/2017 07:08 AM, Igor Mammedov wrote:
> SPARCCPU::env was initialized from previosuly set properties

"previously"

> (with help of sparc_cpu_parse_features) in cpu_sparc_register().
> However there is not reason to keep it there as this task is
> typically done at realize time. So move post properties
> initialization into sparc_cpu_realizefn, which brings
> cpu_sparc_init() closer to cpu_generic_init().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/sparc/cpu.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index e735d73..7f74b1c 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -109,7 +109,6 @@ static void sparc_cpu_parse_features(CPUState *cs, char *features,
>   
>   static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
>   {
> -    CPUSPARCState *env = &cpu->env;
>       char *s = g_strdup(cpu_model);
>       char *featurestr = strtok(s, ",");
>       Error *err = NULL;
> @@ -122,19 +121,6 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
>           return -1;
>       }
>   
> -    env->version = env->def.iu_version;
> -    env->fsr = env->def.fpu_version;
> -    env->nwindows = env->def.nwindows;
> -#if !defined(TARGET_SPARC64)
> -    env->mmuregs[0] |= env->def.mmu_version;
> -    cpu_sparc_set_id(env, 0);
> -    env->mxccregs[7] |= env->def.mxcc_version;
> -#else
> -    env->mmu_version = env->def.mmu_version;
> -    env->maxtl = env->def.maxtl;
> -    env->version |= env->def.maxtl << 8;
> -    env->version |= env->def.nwindows - 1;
> -#endif
>       return 0;
>   }
>   
> @@ -817,15 +803,29 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
>       CPUState *cs = CPU(dev);
>       SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
> -#if defined(CONFIG_USER_ONLY)
>       SPARCCPU *cpu = SPARC_CPU(dev);
>       CPUSPARCState *env = &cpu->env;
>   
> +#if defined(CONFIG_USER_ONLY)
>       if ((env->def.features & CPU_FEATURE_FLOAT)) {
>           env->def.features |= CPU_FEATURE_FLOAT128;
>       }
>   #endif
>   
> +    env->version = env->def.iu_version;
> +    env->fsr = env->def.fpu_version;
> +    env->nwindows = env->def.nwindows;
> +#if !defined(TARGET_SPARC64)
> +    env->mmuregs[0] |= env->def.mmu_version;
> +    cpu_sparc_set_id(env, 0);
> +    env->mxccregs[7] |= env->def.mxcc_version;
> +#else
> +    env->mmu_version = env->def.mmu_version;
> +    env->maxtl = env->def.maxtl;
> +    env->version |= env->def.maxtl << 8;
> +    env->version |= env->def.nwindows - 1;
> +#endif
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> 
