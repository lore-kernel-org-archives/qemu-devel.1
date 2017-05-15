Received: from eggs.gnu.org ([2001:4830:134:3::10]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAF1Q-0008Pl-3T
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAF1M-0004ek-T9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:22:44 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:55981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAF1M-0004dn-KK
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:22:40 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 68A191DEE2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:22:39 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
Date: Mon, 15 May 2017 14:22:32 +0200
MIME-Version: 1.0
In-Reply-To: <149484840466.20089.893964776019028654.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 05/15/2017 01:40 PM, Greg Kurz wrote:
> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> is an improvement since we no longer allocate ICP objects that will
> never be used. But it has the side-effect of breaking migration of
> older machine types from older QEMU versions.
> 
> This patch introduces a compat flag in the sPAPR machine class so
> that all pseries machine up to 2.9 go on with the previous behavior
> of pre-allocating ICP objects.

I think this is a quite elegant way to a handle the migration 
regression. Thanks for taking care of it.

Have you tried to simply reparent the ICPs objects to OBJECT(spapr) 
instead of the OBJECT(cpu)  ? 

See some minor comments below.

> While here, we also ensure that object_property_add_child() errors cause
> QEMU to abort for newer machines.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c          |   36 ++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c |   28 ++++++++++++++++++++--------
>  include/hw/ppc/spapr.h  |    2 ++
>  3 files changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c53989bb10b1..ab3683bcd677 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -126,6 +126,7 @@ error:
>  static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>  {
>      sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      Error *local_err = NULL;
>  
>      if (kvm_enabled()) {
> @@ -151,6 +152,38 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
>                                        &local_err);
>      }
>  
> +    if (!spapr->ics) {
> +        goto out;
> +    }
> +
> +    if (smc->must_pre_allocate_icps) {

I am not sure I like 'must', I think 'pre_allocate_icps' should be enough ? 
or simply 'allocate_legacy_icps' ?

> +        int smt = kvmppc_smt_threads();
> +        int nr_servers = DIV_ROUND_UP(max_cpus * smt, smp_threads);

may be we should reintroduce nr_servers at the machine level ? 

> +        int i;
> +
> +        spapr->legacy_icps = g_malloc0(nr_servers * sizeof(ICPState));
> +
> +        for (i = 0; i < nr_servers; i++) {
> +            void* obj = &spapr->legacy_icps[i];

'void *'

> +
> +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
> +            object_property_add_child(OBJECT(spapr), "icp[*]", obj,
> +                                      &error_abort);

David does not like the "icp[*]" syntax.

> +            object_unref(obj);
> +            object_property_add_const_link(obj, "xics", OBJECT(spapr),
> +                                           &error_abort);
> +            object_property_set_bool(obj, true, "realized", &local_err);
> +            if (local_err) {
> +                while (i--) {
> +                    object_unparent(obj);
> +                }
> +                g_free(spapr->legacy_icps);
> +                break;
> +            }
> +        }
> +    }
> +
> +out:
>      error_propagate(errp, local_err);
>  }
>  
> @@ -3256,8 +3289,11 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
>  
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> +    smc->must_pre_allocate_icps = true;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 63d160f7e010..5476647efa06 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>      size_t size = object_type_get_instance_size(typename);
>      CPUCore *cc = CPU_CORE(dev);
>      int i;
> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>  
>      for (i = 0; i < cc->nr_threads; i++) {
>          void *obj = sc->threads + i * size;
> @@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
>          spapr_cpu_destroy(cpu);
> -        object_unparent(cpu->intc);
> +        if (!spapr->legacy_icps) {
> +            object_unparent(cpu->intc);
> +        }
>          cpu_remove_sync(cs);
>          object_unparent(obj);
>      }
> @@ -142,12 +145,19 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      Object *obj;
>  
> -    obj = object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> -    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        goto error;
> +    if (spapr->legacy_icps) {
> +        int index = cpu->parent_obj.cpu_index;
> +
> +        obj = OBJECT(&spapr->legacy_icps[index]);
> +    } else {
> +        obj = object_new(spapr->icp_type);
> +        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> +        object_property_add_const_link(obj, "xics", OBJECT(spapr),
> +                                       &error_abort);
> +        object_property_set_bool(obj, true, "realized", &local_err);
> +        if (local_err) {
> +            goto error;
> +        }
>      }
>  
>      object_property_set_bool(child, true, "realized", &local_err);
> @@ -164,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>      return;
>  
>  error:
> -    object_unparent(obj);
> +    if (!spapr->legacy_icps) {
> +        object_unparent(obj);
> +    }
>      error_propagate(errp, local_err);
>  }
>  
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f888c39d..72cd5af2679b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -53,6 +53,7 @@ struct sPAPRMachineClass {
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
> +    bool must_pre_allocate_icps; /* only for pseries-2.9 and older */
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio, 
>                            hwaddr *mmio32, hwaddr *mmio64,
> @@ -109,6 +110,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
>  
>      const char *icp_type;
> +    ICPState *legacy_icps;
>  };
>  
>  #define H_SUCCESS         0
> 
