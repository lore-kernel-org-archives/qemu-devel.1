Received: from eggs.gnu.org ([2001:4830:134:3::10]:59219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ciXVs-0006Js-7S
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ciXVr-0006R8-2L
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:27:40 -0500
Message-ID: <1488248845.2323.13.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 28 Feb 2017 13:27:25 +1100
In-Reply-To: <20170228001221.GB17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<ca5b4ee7d0dc010a545e5ace603dcf019d8d0c02.1487829585.git.sam.bobroff@au1.ibm.com>
	<20170228001221.GB17615@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/12] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-02-28 at 11:12 +1100, David Gibson wrote:
> On Thu, Feb 23, 2017 at 04:59:59PM +1100, Sam Bobroff wrote:
> > 
> > Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
> > information from KVM and present the page encodings in the device
> > tree
> > under ibm,processor-radix-AP-encodings. This provides page size
> > information to the guest which is necessary for it to use radix
> > mode.
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> > v2:
> > 
> > * ppc_radix_page_info now kept in native format, conversion to BE
> > done when adding to the device tree.
> > * radix_page_info moved into the CPU class, cleaning up some code.
> Looks pretty good, although I imaginge it will need a little rework
> to
> rebase on top of the TCG radix stuff.  Also one comment below..

I've reworked a bit so my TCG stuff applies cleanly on top.

> 
> > 
> > 
> >  hw/ppc/spapr.c       | 12 ++++++++++++
> >  include/sysemu/kvm.h |  1 +
> >  target/ppc/cpu-qom.h |  1 +
> >  target/ppc/cpu.h     |  4 ++++
> >  target/ppc/kvm.c     | 27 +++++++++++++++++++++++++++
> >  5 files changed, 45 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index cceb35f083..ca3812555f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -409,6 +409,8 @@ static void spapr_populate_cpu_dt(CPUState *cs,
> > void *fdt, int offset,
> >      sPAPRDRConnector *drc;
> >      sPAPRDRConnectorClass *drck;
> >      int drc_index;
> > +    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
> > +    int i;
> >  
> >      drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU,
> > index);
> >      if (drc) {
> > @@ -494,6 +496,16 @@ static void spapr_populate_cpu_dt(CPUState
> > *cs, void *fdt, int offset,
> >      _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
> >  
> >      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> > +
> > +    if (pcc->radix_page_info) {
> > +        for (i = 0; i < pcc->radix_page_info->count; i++) {
> > +            radix_AP_encodings[i] = cpu_to_be32(pcc-
> > >radix_page_info->entries[i]);
> > +        }
> > +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-
> > encodings",
> > +                          radix_AP_encodings,
> > +                          pcc->radix_page_info->count *
> > +                          sizeof(radix_AP_encodings[0]))));
> > +    }
> >  }
> >  
> >  static void spapr_populate_cpus_dt_node(void *fdt,
> > sPAPRMachineState *spapr)
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 3045ee7678..01a8db1180 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -526,5 +526,6 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id,
> > void *source);
> >   * Returns: 0 on success, or a negative errno on failure.
> >   */
> >  int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
> > +struct ppc_radix_page_info *kvm_get_radix_page_info(void);
> >  int kvm_get_max_memslots(void);
> >  #endif
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index 4807f4d86c..0efb543912 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -195,6 +195,7 @@ typedef struct PowerPCCPUClass {
> >      int bfd_mach;
> >      uint32_t l1_dcache_size, l1_icache_size;
> >      const struct ppc_segment_page_sizes *sps;
> > +    struct ppc_radix_page_info *radix_page_info;
> >      void (*init_proc)(CPUPPCState *env);
> >      int  (*check_pow)(CPUPPCState *env);
> >      int (*handle_mmu_fault)(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> > int mmu_idx);
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index b559b67073..a6c8c5ff4c 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -934,6 +934,10 @@ struct ppc_segment_page_sizes {
> >      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
> >  };
> >  
> > +struct ppc_radix_page_info {
> > +    uint32_t count;
> > +    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
> > +};
> >  
> >  /*****************************************************************
> > ************/
> >  /* The whole PowerPC CPU context */
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index d53ede8b4a..cf62a42c1f 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -48,6 +48,7 @@
> >  #if defined(TARGET_PPC64)
> >  #include "hw/ppc/spapr_cpu_core.h"
> >  #endif
> > +#include "sysemu/kvm_int.h"
> >  
> >  //#define DEBUG_KVM
> >  
> > @@ -329,6 +330,30 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu,
> > struct kvm_ppc_smmu_info *info)
> >      kvm_get_fallback_smmu_info(cpu, info);
> >  }
> >  
> > +struct ppc_radix_page_info *kvm_get_radix_page_info(void)
> > +{
> > +    KVMState *s = KVM_STATE(current_machine->accelerator);
> > +    struct ppc_radix_page_info *radix_page_info;
> > +    struct kvm_ppc_rmmu_info rmmu_info;
> > +    int i;
> > +
> > +    if (!kvm_check_extension(s, KVM_CAP_PPC_MMU_RADIX)) {
> > +        return NULL;
> > +    }
> > +    if (kvm_vm_ioctl(s, KVM_PPC_GET_RMMU_INFO, &rmmu_info)) {
> > +        return NULL;
> > +    }
> > +    radix_page_info = g_malloc0(sizeof(*radix_page_info));
> > +    radix_page_info->count = 0;
> > +    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
> > +        if (rmmu_info.ap_encodings[i]) {
> > +            radix_page_info->entries[i] =
> > rmmu_info.ap_encodings[i];
> > +            radix_page_info->count++;
> > +        }
> > +    }
> > +    return radix_page_info;
> > +}
> > +
> >  static long gethugepagesize(const char *mem_path)
> >  {
> >      struct statfs fs;
> > @@ -2379,6 +2404,8 @@ static void
> > kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
> >          pcc->l1_icache_size = icache_size;
> >      }
> >  
> > +    pcc->radix_page_info = kvm_enabled() ?
> > kvm_get_radix_page_info() : NULL;
> This whole function is only called in the kvm case: no need to check
> kvm_enabled() here.

I've reworked this, so this is irrelevant. I've added a generic
function in mmu-radix64.h which calls kvm_get_radix_page_info if radix
enabled, otherwise returns the default for TCG case.

> 
> > 
> >      /* Reason: kvmppc_host_cpu_initfn() dies when !kvm_enabled()
> > */
> >      dc->cannot_destroy_with_object_finalize_yet = true;
> >  }
