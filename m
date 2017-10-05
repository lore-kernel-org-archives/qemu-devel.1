Received: from eggs.gnu.org ([2001:4830:134:3::10]:39402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0E7X-0004hP-LS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0E7U-0002Sf-IJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:55:55 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:48793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0E7U-0002P8-Ap
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:55:52 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7E608C89A0
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 23:55:50 +0200 (CEST)
Date: Thu, 5 Oct 2017 23:55:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171005235539.23ff41a6@bahia.lan>
In-Reply-To: <1507220690-265042-16-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-16-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/23] ppc: spapr: register 'host' core
 type along with the rest of core types
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
	E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Thu,  5 Oct 2017 18:24:42 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> consolidate 'host' core type registration by moving it from
> KVM specific code into spapr_cpu_core.c, similar like it's
> done in x86 target.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

On the way you could have dropped this line in target/ppc/kvm.c:

#include "hw/ppc/spapr_cpu_core.h"

Note, there's also:

#if defined(TARGET_PPC64)
#include "hw/ppc/spapr_cpu_core.h"
#endif

but Philippe (on Cc) has already sent a patch to drop this one:

https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg06499.html

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_cpu_core.h |  1 -
>  hw/ppc/spapr_cpu_core.c         |  5 ++++-
>  target/ppc/kvm.c                | 11 -----------
>  3 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 264ce68..42765de 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -38,5 +38,4 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
>  
>  char *spapr_get_cpu_core_type(const char *model);
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
>  #endif
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8e13e52..f2da4be 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -220,7 +220,7 @@ static Property spapr_cpu_core_properties[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
> @@ -257,6 +257,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
>      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> +#ifdef CONFIG_KVM
> +    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> +#endif
>  };
>  
>  DEFINE_TYPES(spapr_cpu_core_type_infos)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c2152ed..cb5777a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2508,17 +2508,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      oc = object_class_by_name(type_info.name);
>      g_assert(oc);
>  
> -#if defined(TARGET_PPC64)
> -    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> -    type_info.parent = TYPE_SPAPR_CPU_CORE,
> -    type_info.instance_size = sizeof(sPAPRCPUCore);
> -    type_info.instance_init = NULL;
> -    type_info.class_init = spapr_cpu_core_class_init;
> -    type_info.class_data = (void *) POWERPC_CPU_TYPE_NAME("host");
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -#endif
> -
>      /*
>       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
>       * we want "POWER8" to be a "family" alias that points to the current
