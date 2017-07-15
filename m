Received: from eggs.gnu.org ([2001:4830:134:3::10]:55092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvn-0004wb-4d
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvj-0005Ev-7r
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:55 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWUvj-0005Ek-2N
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 17:48:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so14193707qta.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 14:48:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ada938f-3a5f-6642-f737-144f99f11167@amsat.org>
Date: Sat, 15 Jul 2017 18:48:46 -0300
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/28] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 07/14/2017 10:51 AM, Igor Mammedov wrote:
> now cpu_mips_init() reimplements subset of cpu_generic_init()
> tasks, so just drop it and use cpu_generic_init() directly.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Yongbok Kim <yongbok.kim@imgtec.com>
> CC: "Hervé Poussineau" <hpoussin@reactos.org>
> ---
>   target/mips/cpu.h       |  3 +--
>   hw/mips/cps.c           |  2 +-
>   hw/mips/mips_fulong2e.c |  2 +-
>   hw/mips/mips_jazz.c     |  2 +-
>   hw/mips/mips_malta.c    |  2 +-
>   hw/mips/mips_mipssim.c  |  2 +-
>   hw/mips/mips_r4k.c      |  2 +-
>   target/mips/translate.c | 17 -----------------
>   8 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 7c2e0bf..efc8025 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -865,10 +865,9 @@ enum {
>   #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
>   
>   void mips_tcg_init(void);
> -MIPSCPU *cpu_mips_init(const char *cpu_model);
>   int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
>   
> -#define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
>   bool cpu_supports_cps_smp(const char *cpu_model);
>   bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
>   void cpu_set_exception_base(int vp_index, target_ulong address);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4ef337d..708899c 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>       bool itu_present = false;
>   
>       for (i = 0; i < s->num_vp; i++) {
> -        cpu = cpu_mips_init(s->cpu_model);
> +        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
>           if (cpu == NULL) {
>               error_setg(errp, "%s: CPU initialization failed",  __func__);
>               return;
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index dbe2805..02a1712 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -277,7 +277,7 @@ static void mips_fulong2e_init(MachineState *machine)
>       if (cpu_model == NULL) {
>           cpu_model = "Loongson-2E";
>       }
> -    cpu = cpu_mips_init(cpu_model);
> +    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 1cef581..ee58c44 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
>       if (cpu_model == NULL) {
>           cpu_model = "R4000";
>       }
> -    cpu = cpu_mips_init(cpu_model);
> +    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 95cdabb..21dd2c3 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -928,7 +928,7 @@ static void create_cpu_without_cps(const char *cpu_model,
>       int i;
>   
>       for (i = 0; i < smp_cpus; i++) {
> -        cpu = cpu_mips_init(cpu_model);
> +        cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>           if (cpu == NULL) {
>               fprintf(stderr, "Unable to find CPU definition\n");
>               exit(1);
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 1b91195..80e2bab 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -162,7 +162,7 @@ mips_mipssim_init(MachineState *machine)
>           cpu_model = "24Kf";
>   #endif
>       }
> -    cpu = cpu_mips_init(cpu_model);
> +    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index f4de9fc..81dba5e 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -191,7 +191,7 @@ void mips_r4k_init(MachineState *machine)
>           cpu_model = "24Kf";
>   #endif
>       }
> -    cpu = cpu_mips_init(cpu_model);
> +    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ae7ca80..ad4242f 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20191,23 +20191,6 @@ void mips_tcg_init(void)
>   
>   #include "translate_init.c"
>   
> -MIPSCPU *cpu_mips_init(const char *cpu_model)
> -{
> -    ObjectClass *oc;
> -    MIPSCPU *cpu;
> -
> -    oc = cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
> -    if (oc == NULL) {
> -        return NULL;
> -    }
> -
> -    cpu = MIPS_CPU(object_new(object_class_get_name(oc)));
> -
> -    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> -
> -    return cpu;
> -}
> -
>   bool cpu_supports_cps_smp(const char *cpu_model)
>   {
>       const mips_def_t *def = cpu_mips_find_by_name(cpu_model);
> 
