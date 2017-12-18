Received: from eggs.gnu.org ([2001:4830:134:3::10]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQtxX-00077S-Hd
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQtxS-0001Ig-MA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:51:51 -0500
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:39447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQtxS-0001Eu-GI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:51:46 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A027DAF82B
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:51:44 +0100 (CET)
Date: Mon, 18 Dec 2017 12:51:35 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171218125135.2cc3de68@bahia.lan>
In-Reply-To: <20171218092024.21645-7-david@gibson.dropbear.id.au>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
	<20171218092024.21645-7-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: Handle Decimal Floating Point
 (DFP) as an optional capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: surajjs@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com

On Mon, 18 Dec 2017 20:20:24 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Decimal Floating Point has been available on POWER7 and later (server)
> cpus.  However, it can be disabled on the hypervisor, meaning that it's
> not available to guests.
> 
> We currently handle this by conditionally advertising DFP support in the
> device tree depending on whether the guest CPU model supports it - which
> can also depend on what's allowed in the host for -cpu host.  That can lead
> to confusion on migration, since host properties are silently affecting
> guest visible properties.
> 
> This patch handles it by treating it as an optional capability for the
> pseries machine type.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         |  7 ++++---
>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>  include/hw/ppc/spapr.h |  3 +++
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 693dd6f7b3..e22888ba06 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -572,7 +572,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>      /* Advertise DFP (Decimal Floating Point) if available
>       *   0 / no property == no DFP
>       *   1               == DFP available */
> -    if (env->insns_flags2 & PPC2_DFP) {
> +    if (spapr_has_cap(spapr, SPAPR_CAP_DFP)) {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
>  
> @@ -3834,7 +3834,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>       */
>      mc->numa_mem_align_shift = 28;
>  
> -    smc->default_caps = spapr_caps(SPAPR_CAP_VSX);
> +    smc->default_caps = spapr_caps(SPAPR_CAP_VSX | SPAPR_CAP_DFP);
>      spapr_caps_add_properties(smc, &error_abort);
>  }
>  
> @@ -3916,7 +3916,8 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
>      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>  
>      spapr_machine_2_12_class_options(mc);
> -    smc->default_caps = spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX);
> +    smc->default_caps = spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX
> +                                   | SPAPR_CAP_DFP);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
>  
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index da066aec8f..61745f0b32 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -70,6 +70,16 @@ static void cap_vsx_allow(sPAPRMachineState *spapr, Error **errp)
>      }
>  }
>  
> +static void cap_dfp_allow(sPAPRMachineState *spapr, Error **errp)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +    CPUPPCState *env = &cpu->env;
> +
> +    if (!(env->insns_flags2 & PPC2_DFP)) {
> +        error_setg(errp, "DFP support not available, try cap-dfp=off");
> +    }
> +}
> +
>  static sPAPRCapabilityInfo capability_table[] = {
>      {
>          .name = "htm",
> @@ -85,6 +95,13 @@ static sPAPRCapabilityInfo capability_table[] = {
>          .allow = cap_vsx_allow,
>          /* TODO: add cap_vsx_disallow */
>      },
> +    {
> +        .name = "dfp",
> +        .description = "Allow Decimal Floating Point (DFP)",
> +        .flag = SPAPR_CAP_DFP,
> +        .allow = cap_dfp_allow,
> +        /* TODO: add cap_dfp_disallow */
> +    },
>  };
>  
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -104,6 +121,7 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
>                            0, spapr->max_compat_pvr)) {
>          caps.mask &= ~SPAPR_CAP_VSX;
> +        caps.mask &= ~SPAPR_CAP_DFP;
>      }
>  
>      return caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 148a03d189..26ac17e641 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -62,6 +62,9 @@ typedef enum {
>  /* Vector Scalar Extensions */
>  #define SPAPR_CAP_VSX               0x0000000000000002ULL
>  
> +/* Decimal Floating Point */
> +#define SPAPR_CAP_DFP               0x0000000000000004ULL
> +
>  typedef struct sPAPRCapabilities sPAPRCapabilities;
>  struct sPAPRCapabilities {
>      uint64_t mask;
