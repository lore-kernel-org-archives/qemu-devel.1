Received: from eggs.gnu.org ([2001:4830:134:3::10]:49061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7AP-0000Pc-Bb
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7AM-0008DD-L3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7AM-0008Cc-Gc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:14 -0400
Received: by mail-qk0-x242.google.com with SMTP id z14so4613533qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:18:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-26-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6471c319-bc79-0658-71dc-d45a5d4c60ba@amsat.org>
Date: Mon, 2 Oct 2017 17:18:10 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-26-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 25/38] unicore32: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> use new UNICORE32_CPU_TYPE_NAME to compose CPU type
> name and get rid of intermediate
>     UniCore32CPUInfo/uc32_cpu_register_types()
> which is replaced by static TypeInfo array and
> type_init_from_array()
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: gxt@mprc.pku.edu.cn
> ---
>   target/unicore32/cpu.h |  3 +++
>   target/unicore32/cpu.c | 61 +++++++++++++++++---------------------------------
>   2 files changed, 23 insertions(+), 41 deletions(-)
> 
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 7724108..3dc6fbc 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -167,6 +167,9 @@ static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
>   
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model)
>   
> +#define UNICORE32_CPU_TYPE_SUFFIX "-" TYPE_UNICORE32_CPU
> +#define UNICORE32_CPU_TYPE_NAME(model) model UNICORE32_CPU_TYPE_SUFFIX
> +
>   static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc,
>                                           target_ulong *cs_base, uint32_t *flags)
>   {
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 138acc9..3345cfd 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -44,7 +44,7 @@ static ObjectClass *uc32_cpu_class_by_name(const char *cpu_model)
>       ObjectClass *oc;
>       char *typename;
>   
> -    typename = g_strdup_printf("%s-" TYPE_UNICORE32_CPU, cpu_model);
> +    typename = g_strdup_printf(UNICORE32_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);
>       if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_UNICORE32_CPU) ||
> @@ -54,11 +54,6 @@ static ObjectClass *uc32_cpu_class_by_name(const char *cpu_model)
>       return oc;
>   }
>   
> -typedef struct UniCore32CPUInfo {
> -    const char *name;
> -    void (*instance_init)(Object *obj);
> -} UniCore32CPUInfo;
> -
>   static void unicore_ii_cpu_initfn(Object *obj)
>   {
>       UniCore32CPU *cpu = UNICORE32_CPU(obj);
> @@ -90,11 +85,6 @@ static void uc32_any_cpu_initfn(Object *obj)
>       set_snan_bit_is_one(1, &env->ucf64.fp_status);
>   }
>   
> -static const UniCore32CPUInfo uc32_cpus[] = {
> -    { .name = "UniCore-II", .instance_init = unicore_ii_cpu_initfn },
> -    { .name = "any",        .instance_init = uc32_any_cpu_initfn },
> -};
> -
>   static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
>       CPUState *cs = CPU(dev);
> @@ -165,36 +155,25 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
>       dc->vmsd = &vmstate_uc32_cpu;
>   }
>   
> -static void uc32_register_cpu_type(const UniCore32CPUInfo *info)
> -{
> -    TypeInfo type_info = {
> -        .parent = TYPE_UNICORE32_CPU,
> -        .instance_init = info->instance_init,
> -    };
> -
> -    type_info.name = g_strdup_printf("%s-" TYPE_UNICORE32_CPU, info->name);
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -}
> +#define DEFINE_UNICORE32_CPU_TYPE(cpu_model, initfn) \
> +    {                                                \
> +        .parent = TYPE_UNICORE32_CPU,                \
> +        .instance_init = initfn,                     \
> +        .name = UNICORE32_CPU_TYPE_NAME(cpu_model),  \
> +    }
>   
> -static const TypeInfo uc32_cpu_type_info = {
> -    .name = TYPE_UNICORE32_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(UniCore32CPU),
> -    .instance_init = uc32_cpu_initfn,
> -    .abstract = true,
> -    .class_size = sizeof(UniCore32CPUClass),
> -    .class_init = uc32_cpu_class_init,
> +static const TypeInfo uc32_cpu_type_infos[] = {
> +    {
> +        .name = TYPE_UNICORE32_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(UniCore32CPU),
> +        .instance_init = uc32_cpu_initfn,
> +        .abstract = true,
> +        .class_size = sizeof(UniCore32CPUClass),
> +        .class_init = uc32_cpu_class_init,
> +    },
> +    DEFINE_UNICORE32_CPU_TYPE("UniCore-II", unicore_ii_cpu_initfn),
> +    DEFINE_UNICORE32_CPU_TYPE("any", uc32_any_cpu_initfn),
>   };
>   
> -static void uc32_cpu_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&uc32_cpu_type_info);
> -    for (i = 0; i < ARRAY_SIZE(uc32_cpus); i++) {
> -        uc32_register_cpu_type(&uc32_cpus[i]);
> -    }
> -}
> -
> -type_init(uc32_cpu_register_types)
> +type_init_from_array(uc32_cpu_type_infos)
> 
