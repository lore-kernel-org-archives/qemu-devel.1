Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz27W-0005SV-6Z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz27T-0004CN-4O
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:54:58 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz27S-0004CB-Vk
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:54:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id a43so1658843qta.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:54:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-14-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <92115d58-01ce-1e6e-8c5e-54074efa7f72@amsat.org>
Date: Mon, 2 Oct 2017 11:54:51 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/38] moxie: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, green@moxielogic.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> introduce MOXIE_CPU_TYPE_NAME macro and consistently use it
> to construct cpu type names. While at it replace dynamic
> cpu type name composition with static data.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: green@moxielogic.com
> ---
>   target/moxie/cpu.h |  3 +++
>   target/moxie/cpu.c | 56 +++++++++++++++++-------------------------------------
>   2 files changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 75decaa..d37e6a5 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -122,6 +122,9 @@ int cpu_moxie_signal_handler(int host_signum, void *pinfo,
>   
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
>   
> +#define MOXIE_CPU_TYPE_SUFFIX "-" TYPE_MOXIE_CPU
> +#define MOXIE_CPU_TYPE_NAME(model) model MOXIE_CPU_TYPE_SUFFIX
> +
>   #define cpu_signal_handler cpu_moxie_signal_handler
>   
>   static inline int cpu_mmu_index(CPUMoxieState *env, bool ifetch)
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index d4626a1..1ca8f1a 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -92,7 +92,7 @@ static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
>       ObjectClass *oc;
>       char *typename;
>   
> -    typename = g_strdup_printf("%s-" TYPE_MOXIE_CPU, cpu_model);
> +    typename = g_strdup_printf(MOXIE_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);
>       if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) ||
> @@ -139,46 +139,24 @@ static void moxie_any_initfn(Object *obj)
>       /* Set cpu feature flags */
>   }
>   
> -typedef struct MoxieCPUInfo {
> -    const char *name;
> -    void (*initfn)(Object *obj);
> -} MoxieCPUInfo;
> -
> -static const MoxieCPUInfo moxie_cpus[] = {
> -    { .name = "MoxieLite",      .initfn = moxielite_initfn },
> -    { .name = "any",            .initfn = moxie_any_initfn },
> -};
> +#define DEFINE_MOXIE_CPU_TYPE(cpu_model, initfn) \
> +    {                                            \
> +        .parent = TYPE_MOXIE_CPU,                \
> +        .instance_init = initfn,                 \
> +        .name = MOXIE_CPU_TYPE_NAME(cpu_model),  \
> +    }
>   
> -static void cpu_register(const MoxieCPUInfo *info)
> -{
> -    TypeInfo type_info = {
> -        .parent = TYPE_MOXIE_CPU,
> +static const TypeInfo moxie_cpus_type_infos[] = {
> +    { /* base class should be registered first */
> +        .name = TYPE_MOXIE_CPU,
> +        .parent = TYPE_CPU,
>           .instance_size = sizeof(MoxieCPU),
> -        .instance_init = info->initfn,
> +        .instance_init = moxie_cpu_initfn,
>           .class_size = sizeof(MoxieCPUClass),
> -    };
> -
> -    type_info.name = g_strdup_printf("%s-" TYPE_MOXIE_CPU, info->name);
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -}
> -
> -static const TypeInfo moxie_cpu_type_info = {
> -    .name = TYPE_MOXIE_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(MoxieCPU),
> -    .instance_init = moxie_cpu_initfn,
> -    .class_size = sizeof(MoxieCPUClass),
> -    .class_init = moxie_cpu_class_init,
> +        .class_init = moxie_cpu_class_init,
> +    },
> +    DEFINE_MOXIE_CPU_TYPE("MoxieLite", moxielite_initfn),
> +    DEFINE_MOXIE_CPU_TYPE("any", moxie_any_initfn),
>   };
>   
> -static void moxie_cpu_register_types(void)
> -{
> -    int i;
> -    type_register_static(&moxie_cpu_type_info);
> -    for (i = 0; i < ARRAY_SIZE(moxie_cpus); i++) {
> -        cpu_register(&moxie_cpus[i]);
> -    }
> -}
> -
> -type_init(moxie_cpu_register_types)
> +type_init_from_array(moxie_cpus_type_infos)
> 
