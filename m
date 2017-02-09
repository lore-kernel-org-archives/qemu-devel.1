Received: from eggs.gnu.org ([2001:4830:134:3::10]:41201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cbgyS-0000Q9-PW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cbgyO-0004kk-LN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:08:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cbgyO-0004kH-BO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:08:48 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1951OuT118920
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:08:47 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28gcn7jma5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:08:47 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 9 Feb 2017 15:08:44 +1000
Date: Thu, 9 Feb 2017 16:07:44 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<0de3d80bc7658aac7dc5f6b271045463b572c7ff.1486436186.git.sam.bobroff@au1.ibm.com>
	<20170209021408.GQ17644@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170209021408.GQ17644@umbus.fritz.box>
Message-Id: <20170209050744.GD6905@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/9] spapr: Add ibm,
 processor-radix-AP-encodings to the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, Feb 09, 2017 at 01:14:08PM +1100, David Gibson wrote:
> On Tue, Feb 07, 2017 at 01:56:46PM +1100, Sam Bobroff wrote:
> > Use the new ioctl, KVM_PPC_GET_RMMU_INFO, to fetch radix MMU
> > information from KVM and present the page encodings in the device tree
> > under ibm,processor-radix-AP-encodings. This provides page size
> > information to the guest which is necessary for it to use radix mode.
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> >  hw/ppc/spapr.c   |  7 +++++++
> >  target/ppc/cpu.h |  5 +++++
> >  target/ppc/kvm.c | 32 +++++++++++++++++++++++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index a642e663d4..d629e2630c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -496,6 +496,13 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
> >  
> >      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu,
> >                                  ppc_get_compat_smt_threads(cpu)));
> > +
> > +    if (env->radix_page_info.count) {
> > +        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
> > +                          env->radix_page_info.entries,
> > +                          env->radix_page_info.count *
> > +                          sizeof(env->radix_page_info.entries[0]))));
> > +    }
> >  }
> >  
> >  static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index afb7ddbdd0..5a96d98b6f 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -914,6 +914,10 @@ struct ppc_segment_page_sizes {
> >      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
> >  };
> >  
> > +struct ppc_radix_page_info {
> > +    uint32_t count;
> > +    uint32_t entries[PPC_PAGE_SIZES_MAX_SZ];
> 
> IIUC this info is ready for direct inclusion in the device tree:
> i.e. it's big-endian.  That absolutely needs a comment in the
> structure.  I'm also not sure it's a good idea, since I assume the TCG
> POWER9 code will eventually need to access this information directly
> to implement the radix MMU.
> 
> Might be clearer to make this data structure native and do the BE
> conversion when generating the device tree.

Sounds good, I'll try it.

> > +};
> >  
> >  /*****************************************************************************/
> >  /* The whole PowerPC CPU context */
> > @@ -1053,6 +1057,7 @@ struct CPUPPCState {
> >      ppc_slb_t vrma_slb;
> >      target_ulong rmls;
> >      bool ci_large_pages;
> > +    struct ppc_radix_page_info radix_page_info;
> 
> I'm not sure this belongs in CPUPPCState.  New fields should generally
> be added to PowerPCCPU ("cpu") rather than to CPUPPCState ("env")
> unless they need to be directly accessed from TCG generated code.
> 
> But even more, AFAICT this should vary only with the CPU type/model,
> not with the individual CPU instance.  So this information could
> probably go into the CPU class structure instead of the instance.
> 
> Yes, there are a lot of things that don't obey those rules already -
> that's because a lot of stuff hasn't been converted since the new QOM
> stuff was introduced.  But we shouldn't make it any worse with new
> patches.

Agreed, I'll move it.

> >  #endif
> >  
> >  #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index ec92c64159..390d6342cc 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -328,6 +328,18 @@ static void kvm_get_smmu_info(PowerPCCPU *cpu, struct kvm_ppc_smmu_info *info)
> >      kvm_get_fallback_smmu_info(cpu, info);
> >  }
> >  
> > +static bool kvm_get_rmmu_info(PowerPCCPU *cpu, struct kvm_ppc_rmmu_info *info)
> > +{
> > +    CPUState *cs = CPU(cpu);
> > +    int ret;
> > +
> > +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_PPC_MMU_RADIX)) {
> > +        ret = kvm_vm_ioctl(cs->kvm_state, KVM_PPC_GET_RMMU_INFO, info);
> > +        return (ret == 0);
> > +    }
> > +    return false;
> > +}
> > +
> >  static long gethugepagesize(const char *mem_path)
> >  {
> >      struct statfs fs;
> > @@ -441,9 +453,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >  {
> >      static struct kvm_ppc_smmu_info smmu_info;
> >      static bool has_smmu_info;
> > +    static struct kvm_ppc_rmmu_info rmmu_info;
> > +    static bool has_rmmu_info;
> >      CPUPPCState *env = &cpu->env;
> >      long rampagesize;
> > -    int iq, ik, jq, jk;
> > +    int iq, ik, jq, jk, i;
> >      bool has_64k_pages = false;
> >  
> >      /* We only handle page sizes for 64-bit server guests for now */
> > @@ -508,6 +522,22 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >      if (!has_64k_pages) {
> >          env->mmu_model &= ~POWERPC_MMU_64K;
> >      }
> > +
> > +    /* Collect radix page info from kernel if not already */
> > +    if (!has_rmmu_info) {
> 
> Putting the data in the class would avoid this ugly messing with a
> static local, for one thing.

Yeah, that will be nice :-)

> > +        env->radix_page_info.count = 0;
> > +        if (kvm_get_rmmu_info(cpu, &rmmu_info)) {
> > +            for (i = 0; i < 8; i++) {
> 
> s/8/PPC_PAGE_SIZES_MAX_SZ/ ?

Yes!

> > +                if (rmmu_info.ap_encodings[i]) {
> > +                    env->radix_page_info.entries[i] =
> > +                        cpu_to_be32(rmmu_info.ap_encodings[i]);
> > +                    env->radix_page_info.count++;
> > +                }
> > +            }
> > +        }
> > +        has_rmmu_info = true;
> > +    }
> > +
> >  }
> >  #else /* defined (TARGET_PPC64) */
> >  
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
