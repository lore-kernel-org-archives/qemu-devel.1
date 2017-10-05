Received: from eggs.gnu.org ([2001:4830:134:3::10]:52919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0D40-0008W2-86
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0D3t-0001ZP-SM
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:48:09 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:40970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0D3t-0001Wi-Iz
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 16:48:05 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B62E1CA832
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 22:48:03 +0200 (CEST)
Date: Thu, 5 Oct 2017 22:47:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171005224742.2289cd3a@bahia.lan>
In-Reply-To: <1507220690-265042-15-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/23] ppc: spapr: use cpu type name
 directly
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

On Thu,  5 Oct 2017 18:24:41 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> replace sPAPRCPUCoreClass::cpu_class with cpu type name
> since it were needed just to get that at points it were
> accessed.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_cpu_core.h |  2 +-
>  hw/ppc/spapr.c                  |  6 ++----
>  hw/ppc/spapr_cpu_core.c         | 13 +++++--------
>  target/ppc/kvm.c                |  2 +-
>  4 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 66dcf52..264ce68 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -34,7 +34,7 @@ typedef struct sPAPRCPUCore {
>  
>  typedef struct sPAPRCPUCoreClass {
>      DeviceClass parent_class;
> -    ObjectClass *cpu_class;
> +    const char *cpu_type;
>  } sPAPRCPUCoreClass;
>  
>  char *spapr_get_cpu_core_type(const char *model);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 01b3012..ad7afd6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3142,8 +3142,7 @@ void spapr_core_release(DeviceState *dev)
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>          sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        const char *typename = object_class_get_name(scc->cpu_class);
> -        size_t size = object_type_get_instance_size(typename);
> +        size_t size = object_type_get_instance_size(scc->cpu_type);
>          int i;
>  
>          for (i = 0; i < cc->nr_threads; i++) {
> @@ -3239,8 +3238,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>      if (smc->pre_2_10_has_unused_icps) {
>          sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc));
> -        const char *typename = object_class_get_name(scc->cpu_class);
> -        size_t size = object_type_get_instance_size(typename);
> +        size_t size = object_type_get_instance_size(scc->cpu_type);
>          int i;
>  
>          for (i = 0; i < cc->nr_threads; i++) {
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 01f4ec8..8e13e52 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -90,8 +90,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>  {
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> -    const char *typename = object_class_get_name(scc->cpu_class);
> -    size_t size = object_type_get_instance_size(typename);
> +    size_t size = object_type_get_instance_size(scc->cpu_type);
>      CPUCore *cc = CPU_CORE(dev);
>      int i;
>  
> @@ -152,8 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(OBJECT(dev));
> -    const char *typename = object_class_get_name(scc->cpu_class);
> -    size_t size = object_type_get_instance_size(typename);
> +    size_t size = object_type_get_instance_size(scc->cpu_type);
>      Error *local_err = NULL;
>      void *obj;
>      int i, j;
> @@ -172,7 +170,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>  
>          obj = sc->threads + i * size;
>  
> -        object_initialize(obj, size, typename);
> +        object_initialize(obj, size, scc->cpu_type);
>          cs = CPU(obj);
>          cpu = POWERPC_CPU(cs);
>          cs->cpu_index = cc->core_id + i;
> @@ -230,14 +228,13 @@ void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>      dc->realize = spapr_cpu_core_realize;
>      dc->unrealize = spapr_cpu_core_unrealizefn;
>      dc->props = spapr_cpu_core_properties;
> -    scc->cpu_class = cpu_class_by_name(TYPE_POWERPC_CPU, data);
> -    g_assert(scc->cpu_class);
> +    scc->cpu_type = data;
>  }
>  
>  #define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
>      {                                                   \
>          .parent = TYPE_SPAPR_CPU_CORE,                  \
> -        .class_data = (void *) cpu_model,               \
> +        .class_data = (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
>          .class_init = spapr_cpu_core_class_init,        \
>          .name = SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
>      }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 171d3d8..c2152ed 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2514,7 +2514,7 @@ static int kvm_ppc_register_host_cpu_type(void)
>      type_info.instance_size = sizeof(sPAPRCPUCore);
>      type_info.instance_init = NULL;
>      type_info.class_init = spapr_cpu_core_class_init;
> -    type_info.class_data = (void *) "host";
> +    type_info.class_data = (void *) POWERPC_CPU_TYPE_NAME("host");
>      type_register(&type_info);
>      g_free((void *)type_info.name);
>  #endif
