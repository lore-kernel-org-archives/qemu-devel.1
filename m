Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZf58-00008P-Dl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZf52-0003kR-20
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:52:25 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:50343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gZf51-0003gm-89
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:52:19 -0500
Received: from player797.ha.ovh.net (unknown [10.109.160.251])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id E9A8A3841B
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:52:14 +0100 (CET)
Date: Wed, 19 Dec 2018 17:52:09 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181219175209.7a4b6037@bahia.lan>
In-Reply-To: <20181219163541.13979-1-lvivier@redhat.com>
References: <20181219163541.13979-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 19 Dec 2018 17:35:41 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
> designation associated with the identifier input parameter
> 
> This fixes a crash when we try to hotplug a CPU in memory-less and
> CPU-less numa node. In this case, the kernel tries to online the
> node, but without the information provided by this h-call, the node id,
> it cannot and the CPU is started while the node is not onlined.
> 
> It also removes the warning message from the kernel:
>   VPHN is not supported. Disabling polling..
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 

Reviewed-by: Greg Kurz <groug@kaod.org>

> Notes:
>     v3:
>       add parentheses around a and b
>     
>     v2:
>       add hcall-vphn to ibm,hypertas-functions
>       correctly check flags
>       return H_FUNCTION rather than H_PARAMETER
>       update description
> 
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_hcall.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 42 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7a0ab2da54..d961272c8a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1049,6 +1049,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
>      add_str(hypertas, "hcall-sprg0");
>      add_str(hypertas, "hcall-copy");
>      add_str(hypertas, "hcall-debug");
> +    add_str(hypertas, "hcall-vphn");
>      add_str(qemu_hypertas, "hcall-memop1");
>  
>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 78fecc8fe9..1ae3e6ff5e 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1663,6 +1663,42 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
>  
> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                              sPAPRMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    target_ulong flags = args[0];
> +    target_ulong procno = args[1];
> +    PowerPCCPU *tcpu;
> +    int idx;
> +
> +    /* only support procno from H_REGISTER_VPA */
> +    if (flags != 0x1) {
> +        return H_FUNCTION;
> +    }
> +
> +    tcpu = spapr_find_cpu(procno);
> +    if (tcpu == NULL) {
> +        return H_P2;
> +    }
> +
> +    /* sequence is the same as in the "ibm,associativity" property */
> +
> +    idx = 0;
> +#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> +                             ((uint64_t)(b) & 0xffffffff))
> +    args[idx++] = ASSOCIATIVITY(0, 0);
> +    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] = ASSOCIATIVITY(procno, -1);
> +    for ( ; idx < 6; idx++) {
> +        args[idx] = -1;
> +    }
> +#undef ASSOCIATIVITY
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>                                                sPAPRMachineState *spapr,
>                                                target_ulong opcode,
> @@ -1864,6 +1900,10 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
>  
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> +
> +    /* Virtual Processor Home Node */
> +    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> +                             h_home_node_associativity);
>  }
>  
>  type_init(hypercall_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b1a2515107..eb13e2b614 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -447,6 +447,7 @@ struct sPAPRMachineState {
>  #define H_GET_EM_PARMS          0x2B8
>  #define H_SET_MPP               0x2D0
>  #define H_GET_MPP               0x2D4
> +#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
>  #define H_XIRR_X                0x2FC
>  #define H_RANDOM                0x300
>  #define H_SET_MODE              0x31C
