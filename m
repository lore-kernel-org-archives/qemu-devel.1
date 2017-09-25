Received: from eggs.gnu.org ([2001:4830:134:3::10]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwTdl-0005Dg-Iz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwTdk-0006Ha-2T
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:41 -0400
Date: Mon, 25 Sep 2017 15:41:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170925154134.7b4b8cde@nial.brq.redhat.com>
In-Reply-To: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 25 Sep 2017 11:47:33 +0200
Greg Kurz <groug@kaod.org> wrote:

> The CPU core abstraction belongs to the machine code. This also gets
> rid of some code duplication.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> but this is already handled by the following cleanup patch:
> 
> https://patchwork.ozlabs.org/patch/817598/
> ---
>  hw/ppc/spapr.c                  |    4 ++++
>  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++------------
>  include/hw/ppc/spapr_cpu_core.h |    2 +-
>  target/ppc/kvm.c                |   12 ------------
>  4 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0ce3ec87ac59..e82c8532ffb0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *machine)
>      }
>  
>      /* init CPUs */
> +    if (kvm_enabled()) {
> +        spapr_cpu_core_register_host_type();
> +    }
why don't we create it statically in hw/ppc/spapr_cpu_core.c
like it's done in x86, i.e.

  static void x86_cpu_register_types(void)                                         
  {                                                                                
  ...                              
  #ifdef CONFIG_KVM                                                                
      type_register_static(&host_x86_cpu_type_info);                               
  #endif                                                                           
  } 
  type_init(x86_cpu_register_types)

and do the same for host CPU as well?

my gripe with 'dynamic' types is that it creates problems
if one needs to access type information before type is created.
In my use-case it's before machine_init() is called but
after kvm is initialized, so I was sort of 'fine' with way
it's currently handled /i.e. still too much convoluted with
aliases redefinition and all but sort of 'manageable' /.

However I'd very much prefer static type info so it
could be used regardless of place/time it's accessed.

I can add a couple patches to that effect into upcomming
cpu_model removal series, if that's ok for PPC folks.


> +
>      if (machine->cpu_model == NULL) {
>          machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
>      }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index c08ee7571a50..6e224ba029ec 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -317,7 +317,7 @@ static Property spapr_cpu_core_properties[] = {
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
> @@ -337,6 +337,20 @@ static const TypeInfo spapr_cpu_core_type_info = {
>      .class_size = sizeof(sPAPRCPUCoreClass),
>  };
>  
> +static void spapr_cpu_core_register_type(const char *model_name)
> +{
> +    TypeInfo type_info = {
> +        .parent = TYPE_SPAPR_CPU_CORE,
> +        .instance_size = sizeof(sPAPRCPUCore),
> +        .class_init = spapr_cpu_core_class_init,
> +        .class_data = (void *) model_name,
> +    };
> +
> +    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, model_name);
> +    type_register(&type_info);
> +    g_free((void *)type_info.name);
> +}
> +
>  static void spapr_cpu_core_register_types(void)
>  {
>      int i;
> @@ -344,18 +358,14 @@ static void spapr_cpu_core_register_types(void)
>      type_register_static(&spapr_cpu_core_type_info);
>  
>      for (i = 0; i < ARRAY_SIZE(spapr_core_models); i++) {
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
> +        spapr_cpu_core_register_type(spapr_core_models[i]);
>      }
> +
> +}
> +
> +void spapr_cpu_core_register_host_type(void)
> +{
> +    spapr_cpu_core_register_type("host");
>  }
>  
>  type_init(spapr_cpu_core_register_types)
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 93051e9ecf56..e3e906343048 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -36,5 +36,5 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
>  
>  char *spapr_get_cpu_core_type(const char *model);
> -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> +void spapr_cpu_core_register_host_type(void);
>  #endif
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 5b281b2f1b6d..8dd80993ec9e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -37,7 +37,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
> -#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
>  #include "sysemu/watchdog.h"
>  #include "trace.h"
> @@ -2502,17 +2501,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>      oc = object_class_by_name(type_info.name);
>      g_assert(oc);
>  
> -#if defined(TARGET_PPC64)
> -    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
> -    type_info.parent = TYPE_SPAPR_CPU_CORE,
> -    type_info.instance_size = sizeof(sPAPRCPUCore);
> -    type_info.instance_init = NULL;
> -    type_info.class_init = spapr_cpu_core_class_init;
> -    type_info.class_data = (void *) "host";
> -    type_register(&type_info);
> -    g_free((void *)type_info.name);
> -#endif
> -
>      /*
>       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
>       * we want "POWER8" to be a "family" alias that points to the current
> 
> 
