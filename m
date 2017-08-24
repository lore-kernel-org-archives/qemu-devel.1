Received: from eggs.gnu.org ([2001:4830:134:3::10]:42376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dks9i-0003xX-VU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dks9e-0004Dw-Ri
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:42 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dks9e-0004Dm-MB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:26:38 -0400
Received: by mail-qt0-x242.google.com with SMTP id f63so2117522qtb.1
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 06:26:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-20-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e12a12f-244b-c5e5-adfe-897c526596ba@amsat.org>
Date: Thu, 24 Aug 2017 10:26:35 -0300
MIME-Version: 1.0
In-Reply-To: <1503050939-227939-20-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 19/27] arm: replace cpu_arm_init()
 with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 08/18/2017 07:08 AM, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/arm/cpu.h    | 3 +--
>   hw/arm/musicpal.c   | 2 +-
>   hw/arm/omap1.c      | 2 +-
>   hw/arm/omap2.c      | 2 +-
>   hw/arm/pxa2xx.c     | 4 ++--
>   hw/arm/strongarm.c  | 2 +-
>   target/arm/helper.c | 5 -----
>   7 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index b39d64a..5932ef1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -748,7 +748,6 @@ int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>   int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>   #endif
>   
> -ARMCPU *cpu_arm_init(const char *cpu_model);
>   target_ulong do_arm_semihosting(CPUARMState *env);
>   void aarch64_sync_32_to_64(CPUARMState *env);
>   void aarch64_sync_64_to_32(CPUARMState *env);
> @@ -2001,7 +2000,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
>       return unmasked || pstate_unmasked;
>   }
>   
> -#define cpu_init(cpu_model) CPU(cpu_arm_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
>   
>   #define cpu_signal_handler cpu_arm_signal_handler
>   #define cpu_list arm_cpu_list
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 7e8ab31..a8b3d46 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1593,7 +1593,7 @@ static void musicpal_init(MachineState *machine)
>       if (!cpu_model) {
>           cpu_model = "arm926";
>       }
> -    cpu = cpu_arm_init(cpu_model);
> +    cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
>       if (!cpu) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 3d15ff6..400ba30 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -3863,7 +3863,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>   
>       /* Core */
>       s->mpu_model = omap310;
> -    s->cpu = cpu_arm_init(core);
> +    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
>       if (s->cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index bbf0b7e..ece25ae 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2261,7 +2261,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>   
>       /* Core */
>       s->mpu_model = omap2420;
> -    s->cpu = cpu_arm_init(core ?: "arm1136-r2");
> +    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r2"));
>       if (s->cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index 194b0bc..b0ac3cf 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -2066,7 +2066,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>       if (!revision)
>           revision = "pxa270";
>   
> -    s->cpu = cpu_arm_init(revision);
> +    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
>       if (s->cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> @@ -2196,7 +2196,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
>   
>       s = g_new0(PXA2xxState, 1);
>   
> -    s->cpu = cpu_arm_init("pxa255");
> +    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
>       if (s->cpu == NULL) {
>           fprintf(stderr, "Unable to find CPU definition\n");
>           exit(1);
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 6a45dcc..884242b 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1597,7 +1597,7 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
>           exit(1);
>       }
>   
> -    s->cpu = cpu_arm_init(rev);
> +    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
>   
>       if (!s->cpu) {
>           error_report("Unable to find CPU definition");
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index fa60040..0ec92d3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5233,11 +5233,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>       }
>   }
>   
> -ARMCPU *cpu_arm_init(const char *cpu_model)
> -{
> -    return ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
> -}
> -
>   void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>   {
>       CPUState *cs = CPU(cpu);
> 
