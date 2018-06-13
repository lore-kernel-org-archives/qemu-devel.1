Received: from eggs.gnu.org ([2001:4830:134:3::10]:53590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1Eh-0003di-7F
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT1Ee-0006Qo-2p
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:34:35 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:41336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT1Ed-0006Pi-Nj
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:34:31 -0400
Received: from player771.ha.ovh.net (unknown [10.109.108.42])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1C21413B98F
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:34:30 +0200 (CEST)
Date: Wed, 13 Jun 2018 10:34:20 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613103420.042d75f2@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180613065707.30766-2-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Clean up cpu realize/unrealize
 paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 13 Jun 2018 16:57:01 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_cpu_init() and spapr_cpu_destroy() are only called from the spapr
> cpu core realize/unrealize paths, and really can only be called from there.
> 
> Those are all short functions, so fold the pairs together for simplicity.
> While we're there rename some functions and change some parameter types
> for brevity and clarity.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_cpu_core.c | 69 +++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f3e9b879b2..7fdb3b6667 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -83,26 +83,6 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>  }
>  
> -static void spapr_cpu_destroy(PowerPCCPU *cpu)
> -{
> -    qemu_unregister_reset(spapr_cpu_reset, cpu);
> -}
> -
> -static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> -                           Error **errp)
> -{
> -    CPUPPCState *env = &cpu->env;
> -
> -    /* Set time-base frequency to 512 MHz */
> -    cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> -
> -    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> -    kvmppc_set_papr(cpu);
> -
> -    qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);
> -}
> -
>  /*
>   * Return the sPAPR CPU core type for @model which essentially is the CPU
>   * model specified with -cpu cmdline option.
> @@ -122,44 +102,47 @@ const char *spapr_get_cpu_core_type(const char *cpu_type)
>      return object_class_get_name(oc);
>  }
>  
> -static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
> +static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
> +{
> +    qemu_unregister_reset(spapr_cpu_reset, cpu);
> +    object_unparent(cpu->intc);
> +    cpu_remove_sync(CPU(cpu));
> +    object_unparent(OBJECT(cpu));
> +}
> +
> +static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
>  {
>      sPAPRCPUCore *sc = SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc = CPU_CORE(dev);
>      int i;
>  
>      for (i = 0; i < cc->nr_threads; i++) {
> -        Object *obj = OBJECT(sc->threads[i]);
> -        DeviceState *dev = DEVICE(obj);
> -        CPUState *cs = CPU(dev);
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -
> -        spapr_cpu_destroy(cpu);
> -        object_unparent(cpu->intc);
> -        cpu_remove_sync(cs);
> -        object_unparent(obj);
> +        spapr_unrealize_vcpu(sc->threads[i]);
>      }
>      g_free(sc->threads);
>  }
>  
> -static void spapr_cpu_core_realize_child(Object *child,
> -                                         sPAPRMachineState *spapr, Error **errp)
> +static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> +                               Error **errp)
>  {
> +    CPUPPCState *env = &cpu->env;
>      Error *local_err = NULL;
> -    CPUState *cs = CPU(child);
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
> -    object_property_set_bool(child, true, "realized", &local_err);
> +    object_property_set_bool(OBJECT(cpu), true, "realized", &local_err);
>      if (local_err) {
>          goto error;
>      }
>  
> -    spapr_cpu_init(spapr, cpu, &local_err);
> -    if (local_err) {
> -        goto error;
> -    }
> +    /* Set time-base frequency to 512 MHz */
> +    cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> +
> +    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> +    kvmppc_set_papr(cpu);
>  
> -    cpu->intc = icp_create(child, spapr->icp_type, XICS_FABRIC(spapr),
> +    qemu_register_reset(spapr_cpu_reset, cpu);
> +    spapr_cpu_reset(cpu);
> +
> +    cpu->intc = icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
>                             &local_err);
>      if (local_err) {
>          goto error;
> @@ -220,9 +203,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>      }
>  
>      for (j = 0; j < cc->nr_threads; j++) {
> -        obj = OBJECT(sc->threads[j]);
> -
> -        spapr_cpu_core_realize_child(obj, spapr, &local_err);
> +        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
> @@ -249,7 +230,7 @@ static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
>      sPAPRCPUCoreClass *scc = SPAPR_CPU_CORE_CLASS(oc);
>  
>      dc->realize = spapr_cpu_core_realize;
> -    dc->unrealize = spapr_cpu_core_unrealizefn;
> +    dc->unrealize = spapr_cpu_core_unrealize;
>      dc->props = spapr_cpu_core_properties;
>      scc->cpu_type = data;
>  }
