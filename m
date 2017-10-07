Received: from eggs.gnu.org ([2001:4830:134:3::10]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0cjw-00016x-EA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0cjt-0003YX-7n
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:12 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e0cjs-0003Xf-V8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:09 -0400
Received: by mail-pg0-x241.google.com with SMTP id l24so2417579pgu.2
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 17:13:08 -0700 (PDT)
Date: Sat, 7 Oct 2017 09:13:05 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171007001305.GC2630@lianli.shorne-pla.net>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-18-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507211474-188400-18-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/40] openrisc: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Oct 05, 2017 at 03:50:51PM +0200, Igor Mammedov wrote:
> use new OPENRISC_CPU_TYPE_NAME to compose CPU type name and get
> rid of intermediate OpenRISCCPUInfo/openrisc_cpu_register_types()
> which is replaced by static TypeInfo array.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

This is nice

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
> v2:  rename type_init_from_array into DEFINE_TYPES
> 
> CC: shorne@gmail.com
> ---
>  target/openrisc/cpu.h |  3 +++
>  target/openrisc/cpu.c | 69 +++++++++++++++++----------------------------------
>  2 files changed, 26 insertions(+), 46 deletions(-)
> 
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index f51b89a..576cf66 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -390,6 +390,9 @@ int cpu_openrisc_get_phys_data(OpenRISCCPU *cpu,
>  
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model)
>  
> +#define OPENRISC_CPU_TYPE_SUFFIX "-" TYPE_OPENRISC_CPU
> +#define OPENRISC_CPU_TYPE_NAME(model) model OPENRISC_CPU_TYPE_SUFFIX
> +
>  #include "exec/cpu-all.h"
>  
>  #define TB_FLAGS_DFLAG 1
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index af9cdcc..629831a 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -108,7 +108,7 @@ static ObjectClass *openrisc_cpu_class_by_name(const char *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>  
> -    typename = g_strdup_printf("%s-" TYPE_OPENRISC_CPU, cpu_model);
> +    typename = g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);
>      g_free(typename);
>      if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU) ||
> @@ -133,16 +133,6 @@ static void openrisc_any_initfn(Object *obj)
>      cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_EVBARP;
>  }
>  
> -typedef struct OpenRISCCPUInfo {
> -    const char *name;
> -    void (*initfn)(Object *obj);
> -} OpenRISCCPUInfo;
> -
> -static const OpenRISCCPUInfo openrisc_cpus[] = {
> -    { .name = "or1200",      .initfn = or1200_initfn },
> -    { .name = "any",         .initfn = openrisc_any_initfn },
> -};
> -
>  static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      OpenRISCCPUClass *occ = OPENRISC_CPU_CLASS(oc);
> @@ -172,40 +162,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
>      cc->gdb_num_core_regs = 32 + 3;
>  }
>  
> -static void cpu_register(const OpenRISCCPUInfo *info)
> -{
> -    TypeInfo type_info = {
> -        .parent = TYPE_OPENRISC_CPU,
> -        .instance_size = sizeof(OpenRISCCPU),
> -        .instance_init = info->initfn,
> -        .class_size = sizeof(OpenRISCCPUClass),
> -    };
> -
> -    type_info.name = g_strdup_printf("%s-" TYPE_OPENRISC_CPU, info->name);
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -}
> -
> -static const TypeInfo openrisc_cpu_type_info = {
> -    .name = TYPE_OPENRISC_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(OpenRISCCPU),
> -    .instance_init = openrisc_cpu_initfn,
> -    .abstract = true,
> -    .class_size = sizeof(OpenRISCCPUClass),
> -    .class_init = openrisc_cpu_class_init,
> -};
> -
> -static void openrisc_cpu_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&openrisc_cpu_type_info);
> -    for (i = 0; i < ARRAY_SIZE(openrisc_cpus); i++) {
> -        cpu_register(&openrisc_cpus[i]);
> -    }
> -}
> -
>  /* Sort alphabetically by type name, except for "any". */
>  static gint openrisc_cpu_list_compare(gconstpointer a, gconstpointer b)
>  {
> @@ -254,4 +210,25 @@ void cpu_openrisc_list(FILE *f, fprintf_function cpu_fprintf)
>      g_slist_free(list);
>  }
>  
> -type_init(openrisc_cpu_register_types)
> +#define DEFINE_OPENRISC_CPU_TYPE(cpu_model, initfn) \
> +    {                                               \
> +        .parent = TYPE_OPENRISC_CPU,                \
> +        .instance_init = initfn,                    \
> +        .name = OPENRISC_CPU_TYPE_NAME(cpu_model),  \
> +    }
> +
> +static const TypeInfo openrisc_cpus_type_infos[] = {
> +    { /* base class should be registered first */
> +        .name = TYPE_OPENRISC_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(OpenRISCCPU),
> +        .instance_init = openrisc_cpu_initfn,
> +        .abstract = true,
> +        .class_size = sizeof(OpenRISCCPUClass),
> +        .class_init = openrisc_cpu_class_init,
> +    },
> +    DEFINE_OPENRISC_CPU_TYPE("or1200", or1200_initfn),
> +    DEFINE_OPENRISC_CPU_TYPE("any", openrisc_any_initfn),
> +};
> +
> +DEFINE_TYPES(openrisc_cpus_type_infos)
> -- 
> 2.7.4
> 
