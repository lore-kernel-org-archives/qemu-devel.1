Received: from eggs.gnu.org ([2001:4830:134:3::10]:48393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz78p-0007tJ-6Q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz78m-00068H-GQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:16:39 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz78m-00067r-Ao
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:16:36 -0400
Received: by mail-qk0-x241.google.com with SMTP id z12so1445125qkb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:16:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-31-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9f91f5b4-7762-b0f9-8c62-316310a9551c@amsat.org>
Date: Mon, 2 Oct 2017 17:16:31 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-31-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 30/38] sparc: sun4u/sun4v/niagara: use
 generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: mark.cave-ayland@ilande.co.uk
> CC: atar4qemu@gmail.com
> ---
>   include/hw/sparc/sparc64.h | 3 +--
>   hw/sparc64/niagara.c       | 4 ++--
>   hw/sparc64/sparc64.c       | 8 ++------
>   hw/sparc64/sun4u.c         | 8 +++-----
>   4 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
> index 7748939..ca3bb4b 100644
> --- a/include/hw/sparc/sparc64.h
> +++ b/include/hw/sparc/sparc64.h
> @@ -1,5 +1,4 @@
>   
> -SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
> -                              const char *dflt_cpu_model, uint64_t prom_addr);
> +SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
>   
>   void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level);
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 9a8d610..7a72332 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -106,8 +106,7 @@ static void niagara_init(MachineState *machine)
>       MemoryRegion *sysmem = get_system_memory();
>   
>       /* init CPUs */
> -    sparc64_cpu_devinit(machine->cpu_model, "Sun UltraSparc T1",
> -                        NIAGARA_PROM_BASE);
> +    sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
>       /* set up devices */
>       memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
>                                            NIAGARA_HV_RAM_SIZE);
> @@ -174,6 +173,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
>       mc->init = niagara_init;
>       mc->max_cpus = 1; /* XXX for now */
>       mc->default_boot_order = "c";
> +    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
>   }
>   
>   static const TypeInfo niagara_type = {
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 097d529..9453e2c 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -339,8 +339,7 @@ void cpu_tick_set_limit(CPUTimer *timer, uint64_t limit)
>       }
>   }
>   
> -SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
> -                              const char *default_cpu_model, uint64_t prom_addr)
> +SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
>   {
>       SPARCCPU *cpu;
>       CPUSPARCState *env;
> @@ -350,10 +349,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
>       uint32_t  stick_frequency = 100 * 1000000;
>       uint32_t hstick_frequency = 100 * 1000000;
>   
> -    if (cpu_model == NULL) {
> -        cpu_model = default_cpu_model;
> -    }
> -    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> +    cpu = SPARC_CPU(cpu_create(cpu_type));
>       env = &cpu->env;
>   
>       env->tick = cpu_timer_create("tick", cpu, tick_irq,
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index c3280aa..d53fad8 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -73,7 +73,6 @@
>   #define IVEC_MAX             0x40
>   
>   struct hwdef {
> -    const char * const default_cpu_model;
>       uint16_t machine_id;
>       uint64_t prom_addr;
>       uint64_t console_serial_base;
> @@ -439,8 +438,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       int onboard_nic_idx;
>   
>       /* init CPUs */
> -    cpu = sparc64_cpu_devinit(machine->cpu_model, hwdef->default_cpu_model,
> -                              hwdef->prom_addr);
> +    cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
>   
>       /* set up devices */
>       ram_init(0, machine->ram_size);
> @@ -569,14 +567,12 @@ enum {
>   static const struct hwdef hwdefs[] = {
>       /* Sun4u generic PC-like machine */
>       {
> -        .default_cpu_model = "TI UltraSparc IIi",
>           .machine_id = sun4u_id,
>           .prom_addr = 0x1fff0000000ULL,
>           .console_serial_base = 0,
>       },
>       /* Sun4v generic PC-like machine */
>       {
> -        .default_cpu_model = "Sun UltraSparc T1",
>           .machine_id = sun4v_id,
>           .prom_addr = 0x1fff0000000ULL,
>           .console_serial_base = 0,
> @@ -605,6 +601,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
>       mc->max_cpus = 1; /* XXX for now */
>       mc->is_default = 1;
>       mc->default_boot_order = "c";
> +    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
>   }
>   
>   static const TypeInfo sun4u_type = {
> @@ -622,6 +619,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type = IF_IDE;
>       mc->max_cpus = 1; /* XXX for now */
>       mc->default_boot_order = "c";
> +    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
>   }
>   
>   static const TypeInfo sun4v_type = {
> 
