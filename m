Received: from eggs.gnu.org ([2001:4830:134:3::10]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXkjw-0004t0-Uj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXkjt-0007Ko-O7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:30:40 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:58730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXkjt-0007AA-2G
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:30:37 -0500
Received: from player773.ha.ovh.net (unknown [10.109.146.1])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6721B19CC06
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:30:28 +0100 (CET)
Date: Fri, 14 Dec 2018 11:30:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181214113021.2ec2b737@bahia.lan>
In-Reply-To: <20181214015520.20467-1-aik@ozlabs.ru>
References: <20181214015520.20467-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, gkurz@linux.ibm.com

On Fri, 14 Dec 2018 12:55:20 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> SLOF receives a device tree and updates it with various properties
> before switching to the guest kernel and QEMU is not aware of any changes
> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
> sense to pass the SLOF final device tree to QEMU to let it implement
> RTAS related tasks better, such as PCI host bus adapter hotplug.
> 
> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> assisted NMI - FWNMI).
> 
> This stores the initial DT blob in the sPAPR machine and replaces it
> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> 
> This adds an @update_dt_enabled machine property to allow backward
> migration.
> 
> SLOF already has a hypercall since
> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> 
> This makes use of the new fdt_check_full() helper. In order to allow
> the configure script to pick the correct DTC version, this adjusts
> the DTC presense test.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * fixed leaked fdt_blob during migration
> ---

I still couldn't find time to come up with a new PHB hotplug patchset
but this looks good to me so:

Reviewed-by: Greg Kurz <groug@kaod.org>

Alexey,

I'm using the kaod.org address for the reply but I only received this
on the IBM address and through qemu-devel/qemu-ppc on kaod.org again :-\

>  configure              |  2 +-
>  include/hw/ppc/spapr.h |  7 ++++++-
>  hw/ppc/spapr.c         | 43 +++++++++++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_hcall.c   | 42 +++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events    |  3 +++
>  5 files changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 0a3c6a7..e5312da 100755
> --- a/configure
> +++ b/configure
> @@ -3880,7 +3880,7 @@ if test "$fdt" != "no" ; then
>    cat > $TMPC << EOF
>  #include <libfdt.h>
>  #include <libfdt_env.h>
> -int main(void) { fdt_first_subnode(0, 0); return 0; }
> +int main(void) { fdt_check_full(NULL, 0); return 0; }
>  EOF
>    if compile_prog "" "$fdt_libs" ; then
>      # system DTC is good - use it
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 1987640..86c90df 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -102,6 +102,7 @@ struct sPAPRMachineClass {
>  
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
> @@ -138,6 +139,9 @@ struct sPAPRMachineState {
>      int vrma_adjust;
>      ssize_t rtas_size;
>      void *rtas_blob;
> +    uint32_t fdt_size;
> +    uint32_t fdt_initial_size;
> +    void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
>      uint32_t initrd_base;
> @@ -464,7 +468,8 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>  
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8a18250..42752bd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1654,7 +1654,10 @@ static void spapr_machine_reset(void)
>      /* Load the fdt */
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> -    g_free(fdt);
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_size = fdt_totalsize(fdt);
> +    spapr->fdt_initial_size = spapr->fdt_size;
> +    spapr->fdt_blob = fdt;
>  
>      /* Set up the entry state */
>      spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
> @@ -1908,6 +1911,39 @@ static const VMStateDescription vmstate_spapr_irq_map = {
>      },
>  };
>  
> +static bool spapr_dtb_needed(void *opaque)
> +{
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
> +
> +    return smc->update_dt_enabled;
> +}
> +
> +static int spapr_dtb_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
> +
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_blob = NULL;
> +    spapr->fdt_size = 0;
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_dtb = {
> +    .name = "spapr_dtb",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = spapr_dtb_needed,
> +    .pre_load = spapr_dtb_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
> +        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NULL,
> +                                     fdt_size),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr = {
>      .name = "spapr",
>      .version_id = 3,
> @@ -1937,6 +1973,7 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_cap_ibs,
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
> +        &vmstate_spapr_dtb,
>          NULL
>      }
>  };
> @@ -3871,6 +3908,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      hc->unplug = spapr_machine_device_unplug;
>  
>      smc->dr_lmb_enabled = true;
> +    smc->update_dt_enabled = true;
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      mc->has_hotpluggable_cpus = true;
>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
> @@ -3981,8 +4019,11 @@ static void spapr_machine_3_1_instance_options(MachineState *machine)
>  
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_4_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> +    smc->update_dt_enabled = false;
>  }
>  
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ae913d0..78fecc8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1717,6 +1717,46 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>  
>      args[0] = characteristics;
>      args[1] = behaviour;
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> +                                target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong dt = ppc64_phys_to_real(args[0]);
> +    struct fdt_header hdr = { 0 };
> +    unsigned cb;
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    void *fdt;
> +
> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> +    cb = fdt32_to_cpu(hdr.totalsize);
> +
> +    if (!smc->update_dt_enabled) {
> +        return H_SUCCESS;
> +    }
> +
> +    /* Check that the fdt did not grow out of proportion */
> +    if (cb > spapr->fdt_initial_size * 2) {
> +        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
> +                                          fdt32_to_cpu(hdr.magic));
> +        return H_PARAMETER;
> +    }
> +
> +    fdt = g_malloc0(cb);
> +    cpu_physical_memory_read(dt, fdt, cb);
> +
> +    /* Check the fdt consistency */
> +    if (fdt_check_full(fdt, cb)) {
> +        trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
> +                                           fdt32_to_cpu(hdr.magic));
> +        return H_PARAMETER;
> +    }
> +
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_size = cb;
> +    spapr->fdt_blob = fdt;
> +    trace_spapr_update_dt(cb);
>  
>      return H_SUCCESS;
>  }
> @@ -1822,6 +1862,8 @@ static void hypercall_register_types(void)
>  
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
> +
> +    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>  }
>  
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index dc5e65a..0af155e 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -22,6 +22,9 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
>  spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
> +spapr_update_dt(unsigned cb) "New blob %u bytes"
> +spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> +spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>  
>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
