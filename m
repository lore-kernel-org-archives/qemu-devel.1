Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zL-0007C1-90
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zG-00086y-Kk
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:46:31 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zG-00086e-EM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:46:26 -0400
Received: by mail-qk0-x243.google.com with SMTP id w63so2430811qkd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:46:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-3-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <578ced11-b54e-8de6-64f1-d346141f0ec4@amsat.org>
Date: Mon, 2 Oct 2017 11:46:22 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/38] alpha: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Introduce ALPHA_CPU_TYPE_NAME macro to replace rather ununique
> TYPE macro that alpha uses. With new macro it will follow
> the same naming convention as other targets.
> 
> While at it put scattered TypeInfo into one array which places
> type desriptions at one place and reduces code a bit.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: rth@twiddle.net
> ---
>   target/alpha/cpu.h |   3 ++
>   target/alpha/cpu.c | 107 +++++++++++++++++------------------------------------
>   2 files changed, 37 insertions(+), 73 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 6ae2409..0a9ad35 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -470,6 +470,9 @@ void alpha_translate_init(void);
>   
>   #define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
>   
> +#define ALPHA_CPU_TYPE_SUFFIX "-" TYPE_ALPHA_CPU
> +#define ALPHA_CPU_TYPE_NAME(model) model ALPHA_CPU_TYPE_SUFFIX
> +
>   void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>   /* you can call this signal handler from your SIGBUS and SIGSEGV
>      signal handlers to inform the virtual CPU of exceptions. non zero
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index b8a21f4..81a39c4 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -108,21 +108,18 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>   }
>   
>   /* Models */
> -
> -#define TYPE(model) model "-" TYPE_ALPHA_CPU
> -
>   typedef struct AlphaCPUAlias {
>       const char *alias;
>       const char *typename;
>   } AlphaCPUAlias;
>   
>   static const AlphaCPUAlias alpha_cpu_aliases[] = {
> -    { "21064",   TYPE("ev4") },
> -    { "21164",   TYPE("ev5") },
> -    { "21164a",  TYPE("ev56") },
> -    { "21164pc", TYPE("pca56") },
> -    { "21264",   TYPE("ev6") },
> -    { "21264a",  TYPE("ev67") },
> +    { "21064",   ALPHA_CPU_TYPE_NAME("ev4") },
> +    { "21164",   ALPHA_CPU_TYPE_NAME("ev5") },
> +    { "21164a",  ALPHA_CPU_TYPE_NAME("ev56") },
> +    { "21164pc", ALPHA_CPU_TYPE_NAME("pca56") },
> +    { "21264",   ALPHA_CPU_TYPE_NAME("ev6") },
> +    { "21264a",  ALPHA_CPU_TYPE_NAME("ev67") },
>   };
>   
>   static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
> @@ -145,7 +142,7 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
>           }
>       }
>   
> -    typename = g_strdup_printf("%s-" TYPE_ALPHA_CPU, cpu_model);
> +    typename = g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
>       oc = object_class_by_name(typename);
>       g_free(typename);
>       if (oc != NULL && object_class_is_abstract(oc)) {
> @@ -155,7 +152,7 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
>       /* TODO: remove match everything nonsense */
>       /* Default to ev67; no reason not to emulate insns by default. */
>       if (!oc) {
> -        oc = object_class_by_name(TYPE("ev67"));
> +        oc = object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
>       }
>   
>       return oc;
> @@ -169,12 +166,6 @@ static void ev4_cpu_initfn(Object *obj)
>       env->implver = IMPLVER_2106x;
>   }
>   
> -static const TypeInfo ev4_cpu_type_info = {
> -    .name = TYPE("ev4"),
> -    .parent = TYPE_ALPHA_CPU,
> -    .instance_init = ev4_cpu_initfn,
> -};
> -
>   static void ev5_cpu_initfn(Object *obj)
>   {
>       AlphaCPU *cpu = ALPHA_CPU(obj);
> @@ -183,12 +174,6 @@ static void ev5_cpu_initfn(Object *obj)
>       env->implver = IMPLVER_21164;
>   }
>   
> -static const TypeInfo ev5_cpu_type_info = {
> -    .name = TYPE("ev5"),
> -    .parent = TYPE_ALPHA_CPU,
> -    .instance_init = ev5_cpu_initfn,
> -};
> -
>   static void ev56_cpu_initfn(Object *obj)
>   {
>       AlphaCPU *cpu = ALPHA_CPU(obj);
> @@ -197,12 +182,6 @@ static void ev56_cpu_initfn(Object *obj)
>       env->amask |= AMASK_BWX;
>   }
>   
> -static const TypeInfo ev56_cpu_type_info = {
> -    .name = TYPE("ev56"),
> -    .parent = TYPE("ev5"),
> -    .instance_init = ev56_cpu_initfn,
> -};
> -
>   static void pca56_cpu_initfn(Object *obj)
>   {
>       AlphaCPU *cpu = ALPHA_CPU(obj);
> @@ -211,12 +190,6 @@ static void pca56_cpu_initfn(Object *obj)
>       env->amask |= AMASK_MVI;
>   }
>   
> -static const TypeInfo pca56_cpu_type_info = {
> -    .name = TYPE("pca56"),
> -    .parent = TYPE("ev56"),
> -    .instance_init = pca56_cpu_initfn,
> -};
> -
>   static void ev6_cpu_initfn(Object *obj)
>   {
>       AlphaCPU *cpu = ALPHA_CPU(obj);
> @@ -226,12 +199,6 @@ static void ev6_cpu_initfn(Object *obj)
>       env->amask = AMASK_BWX | AMASK_FIX | AMASK_MVI | AMASK_TRAP;
>   }
>   
> -static const TypeInfo ev6_cpu_type_info = {
> -    .name = TYPE("ev6"),
> -    .parent = TYPE_ALPHA_CPU,
> -    .instance_init = ev6_cpu_initfn,
> -};
> -
>   static void ev67_cpu_initfn(Object *obj)
>   {
>       AlphaCPU *cpu = ALPHA_CPU(obj);
> @@ -240,17 +207,6 @@ static void ev67_cpu_initfn(Object *obj)
>       env->amask |= AMASK_CIX | AMASK_PREFETCH;
>   }
>   
> -static const TypeInfo ev67_cpu_type_info = {
> -    .name = TYPE("ev67"),
> -    .parent = TYPE("ev6"),
> -    .instance_init = ev67_cpu_initfn,
> -};
> -
> -static const TypeInfo ev68_cpu_type_info = {
> -    .name = TYPE("ev68"),
> -    .parent = TYPE("ev67"),
> -};
> -
>   static void alpha_cpu_initfn(Object *obj)
>   {
>       CPUState *cs = CPU(obj);
> @@ -303,26 +259,31 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
>       cc->gdb_num_core_regs = 67;
>   }
>   
> -static const TypeInfo alpha_cpu_type_info = {
> -    .name = TYPE_ALPHA_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(AlphaCPU),
> -    .instance_init = alpha_cpu_initfn,
> -    .abstract = true,
> -    .class_size = sizeof(AlphaCPUClass),
> -    .class_init = alpha_cpu_class_init,
> +#define DEFINE_ALPHA_CPU_TYPE(base_type, cpu_model, initfn) \
> +     {                                                      \
> +         .parent = base_type,                               \
> +         .instance_init = initfn,                           \
> +         .name = ALPHA_CPU_TYPE_NAME(cpu_model),            \
> +     }
> +
> +static const TypeInfo alpha_cpu_type_infos[] = {
> +    {
> +        .name = TYPE_ALPHA_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(AlphaCPU),
> +        .instance_init = alpha_cpu_initfn,
> +        .abstract = true,
> +        .class_size = sizeof(AlphaCPUClass),
> +        .class_init = alpha_cpu_class_init,
> +    },
> +    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev4", ev4_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev5", ev5_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev5"), "ev56", ev56_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev56"), "pca56",
> +                          pca56_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(TYPE_ALPHA_CPU, "ev6", ev6_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev6"), "ev67", ev67_cpu_initfn),
> +    DEFINE_ALPHA_CPU_TYPE(ALPHA_CPU_TYPE_NAME("ev67"), "ev68", NULL),
>   };
>   
> -static void alpha_cpu_register_types(void)
> -{
> -    type_register_static(&alpha_cpu_type_info);
> -    type_register_static(&ev4_cpu_type_info);
> -    type_register_static(&ev5_cpu_type_info);
> -    type_register_static(&ev56_cpu_type_info);
> -    type_register_static(&pca56_cpu_type_info);
> -    type_register_static(&ev6_cpu_type_info);
> -    type_register_static(&ev67_cpu_type_info);
> -    type_register_static(&ev68_cpu_type_info);
> -}
> -
> -type_init(alpha_cpu_register_types)
> +type_init_from_array(alpha_cpu_type_infos)
> 
