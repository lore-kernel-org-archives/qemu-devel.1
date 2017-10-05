Received: from eggs.gnu.org ([2001:4830:134:3::10]:54257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07uD-0000O5-Gt
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07uC-0005J6-7g
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:17:45 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:54657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07uC-0005Ir-2U
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:17:44 -0400
Received: by mail-qt0-x244.google.com with SMTP id i13so25996878qtc.11
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:17:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-7-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa578f78-506e-91c7-206b-9a60a9923cda@amsat.org>
Date: Thu, 5 Oct 2017 12:17:35 -0300
MIME-Version: 1.0
In-Reply-To: <1507211474-188400-7-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/40] cris: cleanup cpu type name
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
Cc: edgar.iglesias@gmail.com

On 10/05/2017 10:50 AM, Igor Mammedov wrote:
> replace ambiguous TYPE macro with a new CRIS_CPU_TYPE_NAME
> and use it consistently in the code.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>   - rename type_init_from_array into DEFINE_TYPES
>   - add & use DEFINE_CRIS_CPU_TYPE (Philippe Mathieu-Daudé <f4bug@amsat.org>)
> 
> CC: edgar.iglesias@gmail.com
> ---
>  target/cris/cpu.h |  3 +++
>  target/cris/cpu.c | 81 +++++++++++++++++++------------------------------------
>  2 files changed, 30 insertions(+), 54 deletions(-)
> 
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index 5d822de..b64fa35 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -269,6 +269,9 @@ enum {
>  
>  #define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
>  
> +#define CRIS_CPU_TYPE_SUFFIX "-" TYPE_CRIS_CPU
> +#define CRIS_CPU_TYPE_NAME(name) (name CRIS_CPU_TYPE_SUFFIX)
> +
>  #define cpu_signal_handler cpu_cris_signal_handler
>  
>  /* MMU modes definitions */
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 88d93f2..adf1bc4 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -71,11 +71,11 @@ static ObjectClass *cris_cpu_class_by_name(const char *cpu_model)
>  
>  #if defined(CONFIG_USER_ONLY)
>      if (strcasecmp(cpu_model, "any") == 0) {
> -        return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
> +        return object_class_by_name(CRIS_CPU_TYPE_NAME("crisv32"));
>      }
>  #endif
>  
> -    typename = g_strdup_printf("%s-" TYPE_CRIS_CPU, cpu_model);
> +    typename = g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);
>      g_free(typename);
>      if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU) ||
> @@ -108,7 +108,7 @@ static void cris_cpu_list_entry(gpointer data, gpointer user_data)
>      const char *typename = object_class_get_name(oc);
>      char *name;
>  
> -    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_CRIS_CPU));
> +    name = g_strndup(typename, strlen(typename) - strlen(CRIS_CPU_TYPE_SUFFIX));
>      (*s->cpu_fprintf)(s->file, "  %s\n", name);
>      g_free(name);
>  }
> @@ -259,38 +259,6 @@ static void crisv32_cpu_class_init(ObjectClass *oc, void *data)
>      ccc->vr = 32;
>  }
>  
> -#define TYPE(model) model "-" TYPE_CRIS_CPU
> -
> -static const TypeInfo cris_cpu_model_type_infos[] = {
> -    {
> -        .name = TYPE("crisv8"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv8_cpu_class_init,
> -    }, {
> -        .name = TYPE("crisv9"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv9_cpu_class_init,
> -    }, {
> -        .name = TYPE("crisv10"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv10_cpu_class_init,
> -    }, {
> -        .name = TYPE("crisv11"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv11_cpu_class_init,
> -    }, {
> -        .name = TYPE("crisv17"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv17_cpu_class_init,
> -    }, {
> -        .name = TYPE("crisv32"),
> -        .parent = TYPE_CRIS_CPU,
> -        .class_init = crisv32_cpu_class_init,
> -    }
> -};
> -
> -#undef TYPE
> -
>  static void cris_cpu_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -324,24 +292,29 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
>      cc->disas_set_info = cris_disas_set_info;
>  }
>  
> -static const TypeInfo cris_cpu_type_info = {
> -    .name = TYPE_CRIS_CPU,
> -    .parent = TYPE_CPU,
> -    .instance_size = sizeof(CRISCPU),
> -    .instance_init = cris_cpu_initfn,
> -    .abstract = true,
> -    .class_size = sizeof(CRISCPUClass),
> -    .class_init = cris_cpu_class_init,
> -};
> +#define DEFINE_CRIS_CPU_TYPE(cpu_model, initfn) \
> +     {                                          \
> +         .parent = TYPE_CRIS_CPU,               \
> +         .class_init = initfn,                  \
> +         .name = CRIS_CPU_TYPE_NAME(cpu_model), \
> +     }
>  
> -static void cris_cpu_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&cris_cpu_type_info);
> -    for (i = 0; i < ARRAY_SIZE(cris_cpu_model_type_infos); i++) {
> -        type_register_static(&cris_cpu_model_type_infos[i]);
> -    }
> -}
> +static const TypeInfo cris_cpu_model_type_infos[] = {
> +    {
> +        .name = TYPE_CRIS_CPU,
> +        .parent = TYPE_CPU,
> +        .instance_size = sizeof(CRISCPU),
> +        .instance_init = cris_cpu_initfn,
> +        .abstract = true,
> +        .class_size = sizeof(CRISCPUClass),
> +        .class_init = cris_cpu_class_init,
> +    },
> +    DEFINE_CRIS_CPU_TYPE("crisv8", crisv8_cpu_class_init),
> +    DEFINE_CRIS_CPU_TYPE("crisv9", crisv9_cpu_class_init),
> +    DEFINE_CRIS_CPU_TYPE("crisv10", crisv10_cpu_class_init),
> +    DEFINE_CRIS_CPU_TYPE("crisv11", crisv11_cpu_class_init),
> +    DEFINE_CRIS_CPU_TYPE("crisv17", crisv17_cpu_class_init),
> +    DEFINE_CRIS_CPU_TYPE("crisv32", crisv32_cpu_class_init),
> +};
>  
> -type_init(cris_cpu_register_types)
> +DEFINE_TYPES(cris_cpu_model_type_infos)
> 
