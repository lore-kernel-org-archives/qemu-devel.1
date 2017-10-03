Received: from eggs.gnu.org ([2001:4830:134:3::10]:33560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOX5-0007pP-2B
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOX0-0000eJ-5u
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dzOWz-0000Wz-RQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:50:46 -0400
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-10-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <88f78890-228d-9aea-a1e3-0464d99d6f74@vivier.eu>
Date: Tue, 3 Oct 2017 16:50:34 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/38] m68k: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 02/10/2017 à 11:07, Igor Mammedov a écrit :
> use new M68K_CPU_TYPE_NAME to compose CPU type names
> and get rid of intermediate M68kCPUInfo/register_cpu_type()
> which is replaced by static TypeInfo array.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: laurent@vivier.eu
> ---
>  target/m68k/cpu.h |  3 +++
>  target/m68k/cpu.c | 75 ++++++++++++++++++++-----------------------------------
>  2 files changed, 30 insertions(+), 48 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index d936547..afae5f6 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -323,6 +323,9 @@ void register_m68k_insns (CPUM68KState *env);
>  
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_M68K_CPU, cpu_model)
>  
> +#define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
> +#define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
> +
>  #define cpu_signal_handler cpu_m68k_signal_handler
>  #define cpu_list m68k_cpu_list
>  
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 8c70e08..f0f90e9 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -87,7 +87,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>  
> -    typename = g_strdup_printf("%s-" TYPE_M68K_CPU, cpu_model);
> +    typename = g_strdup_printf(M68K_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);
>      g_free(typename);
>      if (oc != NULL && (object_class_dynamic_cast(oc, TYPE_M68K_CPU) == NULL ||
> @@ -202,23 +202,6 @@ static void any_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
>  }
>  
> -typedef struct M68kCPUInfo {
> -    const char *name;
> -    void (*instance_init)(Object *obj);
> -} M68kCPUInfo;
> -
> -static const M68kCPUInfo m68k_cpus[] = {
> -    { .name = "m68000", .instance_init = m68000_cpu_initfn },
> -    { .name = "m68020", .instance_init = m68020_cpu_initfn },
> -    { .name = "m68030", .instance_init = m68030_cpu_initfn },
> -    { .name = "m68040", .instance_init = m68040_cpu_initfn },
> -    { .name = "m68060", .instance_init = m68060_cpu_initfn },
> -    { .name = "m5206", .instance_init = m5206_cpu_initfn },
> -    { .name = "m5208", .instance_init = m5208_cpu_initfn },
> -    { .name = "cfv4e", .instance_init = cfv4e_cpu_initfn },
> -    { .name = "any",   .instance_init = any_cpu_initfn },
> -};
> -
>  static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -295,36 +278,32 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
>      dc->vmsd = &vmstate_m68k_cpu;
>  }
>  
> -static void register_cpu_type(const M68kCPUInfo *info)
> -{
> -    TypeInfo type_info = {
> -        .parent = TYPE_M68K_CPU,
> -        .instance_init = info->instance_init,
> -    };
> -
> -    type_info.name = g_strdup_printf("%s-" TYPE_M68K_CPU, info->name);
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -}
> +#define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
> +    {                                           \
> +        .name = M68K_CPU_TYPE_NAME(cpu_model),  \
> +        .instance_init = initfn,                \
> +        .parent = TYPE_M68K_CPU,                \
> +    }
>  
> -static const TypeInfo m68k_cpu_type_info = {
> -    .name = TYPE_M68K_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(M68kCPU),
> -    .instance_init = m68k_cpu_initfn,
> -    .abstract = true,
> -    .class_size = sizeof(M68kCPUClass),
> -    .class_init = m68k_cpu_class_init,
> +static const TypeInfo m68k_cpus_type_infos[] = {
> +    { /* base class should be registered first */
> +        .name = TYPE_M68K_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(M68kCPU),
> +        .instance_init = m68k_cpu_initfn,
> +        .abstract = true,
> +        .class_size = sizeof(M68kCPUClass),
> +        .class_init = m68k_cpu_class_init,
> +    },
> +    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),
>  };
>  
> -static void m68k_cpu_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&m68k_cpu_type_info);
> -    for (i = 0; i < ARRAY_SIZE(m68k_cpus); i++) {
> -        register_cpu_type(&m68k_cpus[i]);
> -    }
> -}
> -
> -type_init(m68k_cpu_register_types)
> +type_init_from_array(m68k_cpus_type_infos)
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>
