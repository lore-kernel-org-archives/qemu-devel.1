Received: from eggs.gnu.org ([2001:4830:134:3::10]:47373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0Cno-0000LH-Nn
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0Cnj-0004dI-Nc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:31:28 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:33509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0Cnj-0004cU-H2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:31:23 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E049FCAF10
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 22:31:21 +0200 (CEST)
Date: Thu, 5 Oct 2017 22:31:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171005223110.18764fb7@bahia.lan>
In-Reply-To: <1507220690-265042-14-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-14-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/23] ppc: spapr: define core types
 statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar
	E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Thu,  5 Oct 2017 18:24:40 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> spapr core type definition doesn't have any fields that
> require it to be defined at runtime. So replace code
> that fills in TypeInfo at runtime with static TypeInfo
> array that does the same at complie time.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_cpu_core.h |  2 +
>  hw/ppc/spapr_cpu_core.c         | 85 +++++++++++++----------------------------
>  2 files changed, 29 insertions(+), 58 deletions(-)
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
> index 427d47f..01f4ec8 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -217,36 +217,6 @@ err:
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
> -};
> -
>  static Property spapr_cpu_core_properties[] = {
>      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_END_OF_LIST()
> @@ -264,33 +234,32 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
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
> +};
> +
> +DEFINE_TYPES(spapr_cpu_core_type_infos)
