Received: from eggs.gnu.org ([2001:4830:134:3::10]:33752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotNM-0001KJ-7m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotNH-0002Ul-5j
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:33:24 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dotNH-0002UL-0i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:33:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id p12so449818qkl.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 08:33:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-6-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97ec127f-599d-baeb-91f2-739ec09c04b3@amsat.org>
Date: Mon, 4 Sep 2017 12:33:15 -0300
MIME-Version: 1.0
In-Reply-To: <1504533662-198084-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] pc: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/04/2017 11:01 AM, Igor Mammedov wrote:
> define default CPU type in generic way in pc_machine_class_init()
> and let common machine code to handle cpu_model parsing
> 
> Patch also introduces TARGET_DEFAULT_CPU_TYPE define for 2 purposes:
>    * make foo_machine_class_init() look uniform on every target
>    * use define in [bsd|linux]-user targets to pick default
>      cpu type
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/i386/cpu.h |  9 +++++++++
>   hw/i386/pc.c      | 41 +++++------------------------------------
>   hw/i386/pc_piix.c |  4 +---
>   target/i386/cpu.c |  3 ---
>   4 files changed, 15 insertions(+), 42 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 525d35d..4035a11 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1508,6 +1508,15 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>   
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
>   
> +#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
> +#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
> +
> +#ifdef TARGET_X86_64
> +#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
> +#else
> +#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
> +#endif
> +
>   #define cpu_signal_handler cpu_x86_signal_handler
>   #define cpu_list x86_cpu_list
>   
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2108104..2247ac0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1107,7 +1107,6 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
>   
>   void pc_hot_add_cpu(const int64_t id, Error **errp)
>   {
> -    ObjectClass *oc;
>       MachineState *ms = MACHINE(qdev_get_machine());
>       int64_t apic_id = x86_cpu_apic_id_from_index(id);
>       Error *local_err = NULL;
> @@ -1124,9 +1123,7 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
>           return;
>       }
>   
> -    assert(ms->possible_cpus->cpus[0].cpu); /* BSP is always present */
> -    oc = OBJECT_CLASS(CPU_GET_CLASS(ms->possible_cpus->cpus[0].cpu));
> -    pc_new_cpu(object_class_get_name(oc), apic_id, &local_err);
> +    pc_new_cpu(ms->cpu_type, apic_id, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> @@ -1136,39 +1133,10 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
>   void pc_cpus_init(PCMachineState *pcms)
>   {
>       int i;
> -    CPUClass *cc;
> -    ObjectClass *oc;
> -    const char *typename;
> -    gchar **model_pieces;
>       const CPUArchIdList *possible_cpus;
> -    MachineState *machine = MACHINE(pcms);
> +    MachineState *ms = MACHINE(pcms);
>       MachineClass *mc = MACHINE_GET_CLASS(pcms);
>   
> -    /* init CPUs */
> -    if (machine->cpu_model == NULL) {
> -#ifdef TARGET_X86_64
> -        machine->cpu_model = "qemu64";
> -#else
> -        machine->cpu_model = "qemu32";
> -#endif
> -    }
> -
> -    model_pieces = g_strsplit(machine->cpu_model, ",", 2);
> -    if (!model_pieces[0]) {
> -        error_report("Invalid/empty CPU model name");
> -        exit(1);
> -    }
> -
> -    oc = cpu_class_by_name(TYPE_X86_CPU, model_pieces[0]);
> -    if (oc == NULL) {
> -        error_report("Unable to find CPU definition: %s", model_pieces[0]);
> -        exit(1);
> -    }
> -    typename = object_class_get_name(oc);
> -    cc = CPU_CLASS(oc);
> -    cc->parse_features(typename, model_pieces[1], &error_fatal);
> -    g_strfreev(model_pieces);
> -
>       /* Calculates the limit to CPU APIC ID values
>        *
>        * Limit for the APIC ID value, so that all
> @@ -1177,9 +1145,9 @@ void pc_cpus_init(PCMachineState *pcms)
>        * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init().
>        */
>       pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
> -    possible_cpus = mc->possible_cpu_arch_ids(machine);
> +    possible_cpus = mc->possible_cpu_arch_ids(ms);
>       for (i = 0; i < smp_cpus; i++) {
> -        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fatal);
> +        pc_new_cpu(ms->cpu_type, possible_cpus->cpus[i].arch_id, &error_fatal);
>       }
>   }
>   
> @@ -2360,6 +2328,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       hc->unplug_request = pc_machine_device_unplug_request_cb;
>       hc->unplug = pc_machine_device_unplug_cb;
>       nc->nmi_monitor_handler = x86_nmi;
> +    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>   
>       object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
>           pc_machine_get_hotplug_memory_region_size, NULL,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 46dfd2c..a3f4e2a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -378,9 +378,6 @@ static void pc_compat_0_13(MachineState *machine)
>   
>   static void pc_init_isa(MachineState *machine)
>   {
> -    if (!machine->cpu_model) {
> -        machine->cpu_model = "486";
> -    }
>       x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
>       enable_compat_apic_id_mode();
>       pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
> @@ -1104,6 +1101,7 @@ static void isapc_machine_options(MachineClass *m)
>       pcmc->gigabyte_align = false;
>       pcmc->smbios_legacy_mode = true;
>       pcmc->has_reserved_memory = false;
> +    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>   }
>   
>   DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81576d..a91b2b6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -705,9 +705,6 @@ void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
>   
>   /* CPU class name definitions: */
>   
> -#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
> -#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
> -
>   /* Return type name for a given CPU model name
>    * Caller is responsible for freeing the returned string.
>    */
> 
