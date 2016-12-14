Received: from eggs.gnu.org ([2001:4830:134:3::10]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cH2ZO-00031X-25
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 00:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cH2ZM-0004ED-Tw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 00:57:38 -0500
Message-ID: <1481694982.1555.32.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 14 Dec 2016 16:56:22 +1100
In-Reply-To: <20161212040603.27295-6-david@gibson.dropbear.id.au>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 5/5] pseries: Use smaller default hash
 page tables when guest can resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2016-12-12 at 15:06 +1100, David Gibson wrote:
> We've now implemented a PAPR extension allowing PAPR guest to resize
> their hash page table (HPT) during runtime.
> 
> This patch makes use of that facility to allocate smaller HPTs by
> default.
> Specifically when a guest is aware of the HPT resize facility, qemu
> sizes
> the HPT to the initial memory size, rather than the maximum memory
> size on
> the assumption that the guest will resize its HPT if necessary for
> hot
> plugged memory.
> 
> When the initial memory size is much smaller than the maximum memory
> size
> (a common configuration with e.g. oVirt / RHEV) then this can save
> significant memory on the HPT.
> 
> If the guest does *not* advertise HPT resize awareness when it makes
> the
> ibm,client-architecture-support call, qemu resizes the HPT for
> maxmimum
> memory size (unless it's been configured not to allow such guests at
> all).
> 
> For now we make that reallocation assuming the guest has not yet used
> the
> HPT at all.  That's true in practice, but not, strictly, an
> architectural
> or PAPR requirement.  If we need to in future we can fix this by
> having
> the client-architecture-support call reboot the guest with the
> revised
> HPT size (the client-architecture-support call is explicitly
> permitted to
> trigger a reboot in this way).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c              | 21 ++++++++++++++++-----
>  hw/ppc/spapr_hcall.c        | 32 ++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h      |  2 ++
>  include/hw/ppc/spapr_ovec.h |  1 +
>  4 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f05d0e5..51b189d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1066,8 +1066,8 @@ int spapr_hpt_shift_for_ramsize(uint64_t
> ramsize)
>      return shift;
>  }
>  
> -static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int
> shift,
> -                                 Error **errp)
> +void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> +                          Error **errp)
>  {
>      long rc;
>  
> @@ -1140,14 +1140,20 @@ static void ppc_spapr_reset(void)
>      hwaddr rtas_addr, fdt_addr;
>      void *fdt;
>      int rc;
> +    int hpt_shift;
>  
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
>  
>      /* Allocate and/or reset the hash page table */
> -    spapr_reallocate_hpt(spapr,
> -                         spapr_hpt_shift_for_ramsize(machine-
> >maxram_size),
> -                         &error_fatal);
> +    if ((spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED)
> +        || (spapr->cas_reboot
> +            && !spapr_ovec_test(spapr->ov5_cas, OV5_HPT_RESIZE))) {
> +        hpt_shift = spapr_hpt_shift_for_ramsize(machine-
> >maxram_size);
> +    } else {
> +        hpt_shift = spapr_hpt_shift_for_ramsize(machine->ram_size);
> +    }
> +    spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
>      /* Update the RMA size if necessary */
>      if (spapr->vrma_adjust) {
> @@ -1941,6 +1947,11 @@ static void ppc_spapr_init(MachineState
> *machine)
>          spapr_ovec_set(spapr->ov5, OV5_HP_EVT);
>      }
>  
> +    /* advertise support for HPT resizing */
> +    if (spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) {
> +        spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
> +    }
> +
>      /* init CPUs */
>      if (machine->cpu_model == NULL) {
>          machine->cpu_model = kvm_enabled() ? "host" : smc-
> >tcg_default_cpu;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 1e89061..5bebfc3 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1415,6 +1415,38 @@ static target_ulong
> h_client_architecture_support(PowerPCCPU *cpu_,
>  
>      ov5_guest = spapr_ovec_parse_vector(ov_table, 5);
>  
> +    /*
> +     * HPT resizing is a bit of a special case, because when enabled
> +     * we assume the guest will support it until it says it doesn't,
> +     * instead of assuming it won't support it until it says it
> does.
> +     * Strictly speaking that approach could break for guests which
> +     * don't make a CAS call, but those are so old we don't care
> about
> +     * them.  Without that assumption we'd have to make at least a
> +     * temporary allocation of an HPT sized for max memory, which
> +     * could be impossibly difficult under KVM HV if maxram is
> large.
> +     */
> +    if (!spapr_ovec_test(ov5_guest, OV5_HPT_RESIZE)) {
> +        int maxshift = spapr_hpt_shift_for_ramsize(MACHINE(spapr)-
> >maxram_size);
> +
> +        if (spapr->resize_hpt == SPAPR_RESIZE_HPT_REQUIRED) {
> +            error_report(
> +                "h_client_architecture_support: Guest doesn't
> support HPT resizing, but resize-hpt=required");
> +            exit(1);
> +        }
> +
> +        if (spapr->htab_shift < maxshift) {
> +            CPUState *cs;
> +            /* Guest doesn't know about HPT resizing, so we
> +             * pre-emptively resize for the maximum permitted
> RAM.  At
> +             * the point this is called, nothing should have been
> +             * entered into the existing HPT */
> +            spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> +            CPU_FOREACH(cs) {
> +                run_on_cpu(cs, pivot_hpt,
> RUN_ON_CPU_HOST_PTR(spapr));
> +            }
> +        }
> +    }
> +
>      /* NOTE: there are actually a number of ov5 bits where input
> from the
>       * guest is always zero, and the platform/QEMU enables them
> independently
>       * of guest input. To model these properly we'd want some sort
> of mask,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 954bada..ff3bf87 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -631,6 +631,8 @@ void
> spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType
> drc_type,
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> +void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> +                          Error **errp);
>  
>  /* rtas-configure-connector state */
>  struct sPAPRConfigureConnectorState {
> diff --git a/include/hw/ppc/spapr_ovec.h
> b/include/hw/ppc/spapr_ovec.h
> index 355a344..f5fed87 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -47,6 +47,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
>  #define OV5_DRCONF_MEMORY       OV_BIT(2, 2)
>  #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
>  #define OV5_HP_EVT              OV_BIT(6, 5)
> +#define OV5_HPT_RESIZE          OV_BIT(6, 7)
>  
>  /* interfaces */
>  sPAPROptionVector *spapr_ovec_new(void);

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
