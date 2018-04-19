Received: from eggs.gnu.org ([2001:4830:134:3::10]:37040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f99vT-0001PP-2u
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f99vO-0001JW-GR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:48:38 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:39594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f99vO-0000ra-73
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:48:34 -0400
Received: from player168.ha.ovh.net (unknown [10.109.122.16])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6ABA9BF026
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:48:31 +0200 (CEST)
Date: Thu, 19 Apr 2018 15:48:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180419154823.0e937610@bahia.lan>
In-Reply-To: <20180417071722.9399-2-david@gibson.dropbear.id.au>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 01/10] spapr: Avoid redundant
 calls to spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 17 Apr 2018 17:17:13 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> af81cf323c1 "spapr: CPU hotplug support" added a direct call to
> spapr_cpu_reset() in spapr_cpu_init(), as well as registering it as a
> reset callback.  That was in order to make sure that the reset function
> got called for a newly hotplugged cpu, which would miss the global machine
> reset.
> 
> However, this change means that spapr_cpu_reset() gets called twice for
> normal cold-plugged cpus: once from spapr_cpu_init(), then again during
> the system reset.  As well as being ugly in its redundancy, the first call
> happens before the machine reset calls have happened, which will cause
> problems for some things we're going to want to add.
> 
> So, we remove the reset call from spapr_cpu_init().  We instead put an
> explicit reset call in the hotplug specific path.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

I had sent a tentative patch to do something similar earlier this year:

https://patchwork.ozlabs.org/patch/862116/

but it got nacked for several reasons, one of them being you were
"always wary of using the hotplugged parameter, because what qemu
means by it often doesn't line up with what PAPR means by it."

>  hw/ppc/spapr.c                  |  6 ++++--
>  hw/ppc/spapr_cpu_core.c         | 13 ++++++++++++-
>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7b2bc4e25d..81b50af3b5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3370,9 +3370,11 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>          if (hotplugged) {

... but you rely on it here. Can you explain why it is
okay now ?

Also, if QEMU is started with -incoming and the CPU core
is hotplugged before migration begins, the following will
return false:

static inline bool spapr_drc_hotplugged(DeviceState *dev)
{
    return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
}

and the CPU core won't be reset.

>              /*
> -             * Send hotplug notification interrupt to the guest only
> -             * in case of hotplugged CPUs.
> +             * For hotplugged CPUs, we need to reset them (they missed
> +             * out on the system reset), and send the guest a
> +             * notification
>               */
> +            spapr_cpu_core_reset(core);

spapr_cpu_reset() also sets the compat mode, which is used
to set some properties in the DT, ie, this should be called
before spapr_populate_hotplug_cpu_dt().

>              spapr_hotplug_req_add_by_index(drc);
>          } else {
>              spapr_drc_reset(drc);
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 94afeb399e..aa17626cda 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -70,7 +70,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
>      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
>  
>      qemu_register_reset(spapr_cpu_reset, cpu);
> -    spapr_cpu_reset(cpu);

spapr_cpu_reset() also sets cs->halted to 1, to let the guest start
non-boot CPUs with an RTAS call. With this change, a hotplugged CPU
is started right away and may run in the guest before the hotplug
path could even reset it.

Not sure how to handle that other than setting halted to 1 in
spapr_cpu_init() as well, but you already nacked that approach
because it would mean "poking specifics in a CPU that hasn't
already been set to a known state by a reset"... 

>  }
>  
>  /*
> @@ -208,6 +207,18 @@ err:
>      error_propagate(errp, local_err);
>  }
>  
> +void spapr_cpu_core_reset(sPAPRCPUCore *sc)
> +{
> +    CPUCore *cc = CPU_CORE(sc);
> +    int i;
> +
> +    for (i = 0; i < cc->nr_threads; i++) {
> +        PowerPCCPU *cpu = sc->threads[i];
> +
> +        spapr_cpu_reset(cpu);
> +    }
> +}
> +
>  static Property spapr_cpu_core_properties[] = {
>      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_END_OF_LIST()
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
> index 1129f344aa..1a38544706 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -38,4 +38,6 @@ typedef struct sPAPRCPUCoreClass {
>  } sPAPRCPUCoreClass;
>  
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
> +void spapr_cpu_core_reset(sPAPRCPUCore *sc);
> +
>  #endif
