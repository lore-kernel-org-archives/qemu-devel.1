Received: from eggs.gnu.org ([2001:4830:134:3::10]:35407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNIG-000392-Fa
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNID-0007iI-8u
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:31:28 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:55437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNID-0007hn-3e
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:31:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id x54so12906650qth.12
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:31:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-10-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ea5e63d-8287-84de-b9cd-fd544c22f578@amsat.org>
Date: Tue, 3 Oct 2017 10:31:20 -0300
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
To: Igor Mammedov <imammedo@redhat.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> use new M68K_CPU_TYPE_NAME to compose CPU type names
> and get rid of intermediate M68kCPUInfo/register_cpu_type()
> which is replaced by static TypeInfo array.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
