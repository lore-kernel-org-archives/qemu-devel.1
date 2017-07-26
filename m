Received: from eggs.gnu.org ([2001:4830:134:3::10]:42580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daF2S-0003C1-68
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daF2O-00050T-3c
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:39:16 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daF2N-0004z9-RJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:39:12 -0400
Received: by mail-it0-x244.google.com with SMTP id v127so10909918itd.2
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 22:39:11 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <69a908a6-3ec6-54ca-9bda-08d65aae76c1@ozlabs.ru>
Date: Wed, 26 Jul 2017 15:38:43 +1000
MIME-Version: 1.0
In-Reply-To: <150100578691.27487.8944448515009831240.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to
 update the XICS phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 04:03, Greg Kurz wrote:
> The "phandle" property of the XICS node is referenced by the "interrupt-map"
> property of each PHB node. This is used by the guest OS to setup IRQs for
> all PCI devices.
> 
> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF converts
> this value to a SLOF specific one, which is then presented to the guest OS.
> 
> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which is used
> by SLOF to communicate the patched phandle value back to QEMU. This value
> is then cached and preserved accross migration until machine reset.
> 
> This is required to be able to support PHB hotplug.
> 
> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, so we
> have to introduce its number even if QEMU currently doesn't implement it.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  hw/ppc/spapr.c         |   25 +++++++++++++++++++++++--
>  hw/ppc/spapr_hcall.c   |   20 ++++++++++++++++++++
>  include/hw/ppc/spapr.h |   11 ++++++++++-
>  3 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a6cd4efeb97..90485054c2e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -96,8 +96,6 @@
>  
>  #define MIN_RMA_SLOF            128UL
>  
> -#define PHANDLE_XICP            0x00001111
> -
>  /* maximum number of hotpluggable PHBs */
>  #define SPAPR_DRC_MAX_PHB       256
>  
> @@ -1454,6 +1452,7 @@ static void ppc_spapr_reset(void)
>      first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
>  
>      spapr->cas_reboot = false;
> +    spapr->xics_phandle = UINT32_MAX;
>  }
>  
>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> @@ -1652,6 +1651,26 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
>      },
>  };
>  
> +static bool spapr_xics_phandle_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr = opaque;
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(MACHINE(spapr));
> +
> +    /* Don't break older machine types that don't support PHB hotplug. */
> +    return smc->dr_phb_enabled && spapr->xics_phandle != UINT32_MAX;
> +}
> +
> +static const VMStateDescription vmstate_spapr_xics_phandle = {
> +    .name = "spapr_xics_phandle",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_xics_phandle_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(xics_phandle, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr = {
>      .name = "spapr",
>      .version_id = 3,
> @@ -1671,6 +1690,7 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> +        &vmstate_spapr_xics_phandle,
>          NULL
>      }
>  };
> @@ -2702,6 +2722,7 @@ static void spapr_machine_initfn(Object *obj)
>  
>      spapr->htab_fd = -1;
>      spapr->use_hotplug_event_source = true;
> +    spapr->xics_phandle = UINT32_MAX;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL);
>      object_property_set_description(obj, "kvm-type",
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72ea5a8247bf..ce8a9eb66b23 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1623,6 +1623,25 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
>  
> +static target_ulong h_update_phandle(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> +                                     target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong old_phandle = args[0];
> +    target_ulong new_phandle = args[1];
> +
> +    if (new_phandle >= UINT32_MAX) {
> +        return H_PARAMETER;
> +    }
> +
> +    /* We only have a "phandle" property in the XICS node at the moment. */
> +    if (old_phandle != (uint32_t) PHANDLE_XICP) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr->xics_phandle = (uint32_t) new_phandle;
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
>  
> @@ -1717,6 +1736,7 @@ static void hypercall_register_types(void)
>  
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> +    spapr_register_hypercall(KVMPPC_H_UPDATE_PHANDLE, h_update_phandle);
>  
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 8004d9c2ab2c..f09c54d5bb94 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -125,6 +125,8 @@ struct sPAPRMachineState {
>  
>      bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHBs */
>  
> +    uint32_t xics_phandle;
> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> @@ -402,7 +404,9 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_H_UPDATE_PHANDLE (KVMPPC_HCALL_BASE + 0x4)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_PHANDLE
>  
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> @@ -707,4 +711,9 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
>  
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
>  
> +/* Boot time value of the "phandle" property of the "interrupt-controller"
> + * node.
> + */
> +#define PHANDLE_XICP            0x00001111
> +
>  #endif /* HW_SPAPR_H */
> 
> 


-- 
Alexey
