Received: from eggs.gnu.org ([2001:4830:134:3::10]:43822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2Khh-0006Oq-Lh
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e2Khg-0002wa-Io
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 13:21:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-14-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <527e8753-0b24-e754-4997-82a9c0395f61@amsat.org>
Date: Wed, 11 Oct 2017 14:21:46 -0300
MIME-Version: 1.0
In-Reply-To: <1507578671-158758-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/24] ppc: spapr: define core types
 statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 10/09/2017 04:51 PM, Igor Mammedov wrote:
> spapr core type definition doesn't have any fields that
> require it to be defined at runtime. So replace code
> that fills in TypeInfo at runtime with static TypeInfo
> array that does the same at complie time.

"compile"

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>   - fix rebase conflict: add newly added power9_v2 core
> ---
>  include/hw/ppc/spapr_cpu_core.h |  2 +
>  hw/ppc/spapr_cpu_core.c         | 87 +++++++++++++----------------------------
>  2 files changed, 30 insertions(+), 59 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 93051e9..66dcf52 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -21,6 +21,8 @@
>  #define SPAPR_CPU_CORE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
>  
> +#define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
> +
>  typedef struct sPAPRCPUCore {
>      /*< private >*/
>      CPUCore parent_obj;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b6610dd..550d320 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -217,37 +217,6 @@ err:
>      error_propagate(errp, local_err);
>  }
>  
> -static const char *spapr_core_models[] = {
> -    /* 970 */
> -    "970_v2.2",
> -
> -    /* 970MP variants */
> -    "970mp_v1.0",
> -    "970mp_v1.1",
> -
> -    /* POWER5+ */
> -    "power5+_v2.1",
> -
> -    /* POWER7 */
> -    "power7_v2.3",
> -
> -    /* POWER7+ */
> -    "power7+_v2.1",
> -
> -    /* POWER8 */
> -    "power8_v2.0",
> -
> -    /* POWER8E */
> -    "power8e_v2.1",
> -
> -    /* POWER8NVL */
> -    "power8nvl_v1.0",
> -
> -    /* POWER9 */
> -    "power9_v1.0",
> -    "power9_v2.0",
> -};
> -
>  static Property spapr_cpu_core_properties[] = {
>      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_END_OF_LIST()
> @@ -265,33 +234,33 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>      g_assert(scc->cpu_class);
>  }
>  
> -static const TypeInfo spapr_cpu_core_type_info = {
> -    .name = TYPE_SPAPR_CPU_CORE,
> -    .parent = TYPE_CPU_CORE,
> -    .abstract = true,
> -    .instance_size = sizeof(sPAPRCPUCore),
> -    .class_size = sizeof(sPAPRCPUCoreClass),
> -};
> -
> -static void spapr_cpu_core_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&spapr_cpu_core_type_info);
> -
> -    for (i = 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> -        TypeInfo type_info = {
> -            .parent = TYPE_SPAPR_CPU_CORE,
> -            .instance_size = sizeof(sPAPRCPUCore),
> -            .class_init = spapr_cpu_core_class_init,
> -            .class_data = (void *) spapr_core_models[i],
> -        };
> -
> -        type_info.name = g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> -                                         spapr_core_models[i]);
> -        type_register(&type_info);
> -        g_free((void *)type_info.name);
> +#define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
> +    {                                                   \
> +        .parent = TYPE_SPAPR_CPU_CORE,                  \
> +        .class_data = (void *) cpu_model,               \
> +        .class_init = spapr_cpu_core_class_init,        \
> +        .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
>      }
> -}
>  
> -type_init(spapr_cpu_core_register_types)
> +static const TypeInfo spapr_cpu_core_type_infos[] = {
> +    {
> +        .name = TYPE_SPAPR_CPU_CORE,
> +        .parent = TYPE_CPU_CORE,
> +        .abstract = true,
> +        .instance_size = sizeof(sPAPRCPUCore),
> +        .class_size = sizeof(sPAPRCPUCoreClass),
> +    },
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> +};
> +
> +DEFINE_TYPES(spapr_cpu_core_type_infos)
> 
