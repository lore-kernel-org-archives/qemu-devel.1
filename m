Received: from eggs.gnu.org ([2001:4830:134:3::10]:45195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiDd-0003tB-Hb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiDa-0003UZ-G6
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:50:05 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiDa-0003UR-BI
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:50:02 -0400
Received: by mail-qk0-x243.google.com with SMTP id b194so1224293qkc.4
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:50:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-9-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <07e00b0b-f561-604a-4b97-0aaa06338407@amsat.org>
Date: Wed, 23 Aug 2017 23:49:58 -0300
MIME-Version: 1.0
In-Reply-To: <1503050939-227939-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 08/27] sparc: replace
 cpu_sparc_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>

On 08/18/2017 07:08 AM, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Fabien Chouteau <chouteau@adacore.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/sparc/cpu.h   | 3 +--
>   hw/sparc/leon3.c     | 2 +-
>   hw/sparc/sun4m.c     | 2 +-
>   hw/sparc64/sparc64.c | 2 +-
>   target/sparc/cpu.c   | 5 -----
>   5 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 0e41916..b45cfb4 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -579,7 +579,6 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
>   
>   #ifndef NO_CPU_IO_DEFS
>   /* cpu_init.c */
> -SPARCCPU *cpu_sparc_init(const char *cpu_model);
>   void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
>   void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>   /* mmu_helper.c */
> @@ -656,7 +655,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
>   int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
>   
>   #ifndef NO_CPU_IO_DEFS
> -#define cpu_init(cpu_model) CPU(cpu_sparc_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
>   #endif
>   
>   #define cpu_signal_handler cpu_sparc_signal_handler
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index d5ff188..56512ec 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -126,7 +126,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>           cpu_model = "LEON3";
>       }
>   
> -    cpu = cpu_sparc_init(cpu_model);
> +    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
>           exit(1);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 89dd8a9..cf47dca 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -797,7 +797,7 @@ static void cpu_devinit(const char *cpu_model, unsigned int id,
>       SPARCCPU *cpu;
>       CPUSPARCState *env;
>   
> -    cpu = cpu_sparc_init(cpu_model);
> +    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
>           exit(1);
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 4e4fdab..ecf38a4 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -353,7 +353,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
>       if (cpu_model == NULL) {
>           cpu_model = default_cpu_model;
>       }
> -    cpu = cpu_sparc_init(cpu_model);
> +    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
>       if (cpu == NULL) {
>           fprintf(stderr, "Unable to find Sparc CPU definition\n");
>           exit(1);
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index fd01cbf..2917021 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -110,11 +110,6 @@ static void sparc_cpu_parse_features(const char *typename, char *features,
>       cpu_legacy_parse_featurestr(typename, features, errp);
>   }
>   
> -SPARCCPU *cpu_sparc_init(const char *cpu_model)
> -{
> -    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> -}
> -
>   void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
>   {
>   #if !defined(TARGET_SPARC64)
> 
