Received: from eggs.gnu.org ([2001:4830:134:3::10]:56798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUw58-0004h5-RW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUw53-0002WS-RZ
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:28:38 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:58617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUw53-0002WB-KK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:28:33 -0400
Received: from player691.ha.ovh.net (unknown [10.109.105.78])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id D748FB6B3E
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 17:28:31 +0200 (CEST)
Date: Mon, 18 Jun 2018 17:28:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618172823.4ffd5166@bahia.lan>
In-Reply-To: <20180618063606.2513-4-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] spapr: Add cpu_apply hook to
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On Mon, 18 Jun 2018 16:36:00 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr capabilities have an apply hook to actually activate (or deactivate)
> the feature in the system at reset time.  However, a number of capabilities
> affect the setup of cpus, and need to be applied to each of them -
> including hotplugged cpus for extra complication.  To make this simpler,
> add an optional cpu_apply hook that is called from spapr_cpu_reset().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_caps.c     | 19 +++++++++++++++++++
>  hw/ppc/spapr_cpu_core.c |  2 ++
>  include/hw/ppc/spapr.h  |  1 +
>  3 files changed, 22 insertions(+)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index dabed817d1..68a4243efc 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -59,6 +59,8 @@ typedef struct sPAPRCapabilityInfo {
>      sPAPRCapPossible *possible;
>      /* Make sure the virtual hardware can support this capability */
>      void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp);
> +    void (*cpu_apply)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> +                      uint8_t val, Error **errp);
>  } sPAPRCapabilityInfo;
>  
>  static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
> @@ -472,6 +474,23 @@ void spapr_caps_apply(sPAPRMachineState *spapr)
>      }
>  }
>  
> +void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu)
> +{
> +    int i;
> +
> +    for (i = 0; i < SPAPR_CAP_NUM; i++) {
> +        sPAPRCapabilityInfo *info = &capability_table[i];
> +
> +        /*
> +         * If the apply function can't set the desired level and thinks it's
> +         * fatal, it should cause that.
> +         */
> +        if (info->cpu_apply) {
> +            info->cpu_apply(spapr, cpu, spapr->eff.caps[i], &error_fatal);
> +        }
> +    }
> +}
> +
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
>  {
>      Error *local_err = NULL;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index aef3be33a3..324623190d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -76,6 +76,8 @@ static void spapr_cpu_reset(void *opaque)
>      spapr_cpu->slb_shadow_size = 0;
>      spapr_cpu->dtl_addr = 0;
>      spapr_cpu->dtl_size = 0;
> +
> +    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
>  }
>  
>  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9dbd6010f5..9dd46a72f6 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -800,6 +800,7 @@ static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  
>  void spapr_caps_init(sPAPRMachineState *spapr);
>  void spapr_caps_apply(sPAPRMachineState *spapr);
> +void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu);
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
>  int spapr_caps_post_migration(sPAPRMachineState *spapr);
>  
