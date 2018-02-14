Received: from eggs.gnu.org ([2001:4830:134:3::10]:49417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elxa2-0006xd-N7
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elxZq-0003KB-HT
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:58:38 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:44372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1elxZq-0003DD-A0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 08:58:26 -0500
Received: from player157.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6D2AC11BDA0
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 14:58:24 +0100 (CET)
Date: Wed, 14 Feb 2018 14:58:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180214145818.334dffc9@bahia.lan>
In-Reply-To: <20180214065135.11633-2-sjitindarsingh@gmail.com>
References: <20180214065135.11633-1-sjitindarsingh@gmail.com>
	<20180214065135.11633-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V2 2/3]
 ppc/spapr-caps: Convert spapr-cap-ibs to be a boolean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Wed, 14 Feb 2018 17:51:34 +1100
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> The spapr-cap cap-ibs can only have values broken or fixed as there is
> no workaround. Currently setting the value workaround will hit an assert
> if the guest makes the hcall h_get_cpu_characteristics.
> 
> Thus this capability is better suited to being represented as a boolean.
> Setting this to OFF corresponds to the old BROKEN, that is no indirect
> branch serialisation. Setting this to ON corresponds to the old FIXED,
> that is indirect branches are serialised.
> 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c      |  2 +-
>  hw/ppc/spapr_caps.c | 12 ++++++------
>  target/ppc/kvm.c    |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 32a876be56..969db6cde2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3886,7 +3886,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> -    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
>  
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e69d308560..05997b0842 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -207,9 +207,9 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
>  {
>      if (tcg_enabled() && val) {
>          /* TODO - for now only allow broken for TCG */
> -        error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
> +        error_setg(errp, "Indirect Branch Serialisation support not available, try cap-ibs=off");
>      } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
> -        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
> +        error_setg(errp, "Indirect Branch Serialisation support not available, try cap-ibs=off");
>      }
>  }
>  
> @@ -263,11 +263,11 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      },
>      [SPAPR_CAP_IBS] = {
>          .name = "ibs",
> -        .description = "Indirect Branch Serialisation" VALUE_DESC_TRISTATE,
> +        .description = "Indirect Branch Serialisation",
>          .index = SPAPR_CAP_IBS,
> -        .get = spapr_cap_get_tristate,
> -        .set = spapr_cap_set_tristate,
> -        .type = "string",
> +        .get = spapr_cap_get_bool,
> +        .set = spapr_cap_set_bool,
> +        .type = "bool",
>          .apply = cap_safe_indirect_branch_apply,
>      },
>  };
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9842b3bb12..3e3e5f9c1f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2495,7 +2495,7 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
>      }
>      /* Parse and set cap_ppc_safe_indirect_branch */
>      if (c.character & H_CPU_CHAR_BCCTRL_SERIALISED) {
> -        cap_ppc_safe_indirect_branch = 2;
> +        cap_ppc_safe_indirect_branch = 1;
>      }
>  }
>  
