Received: from eggs.gnu.org ([209.51.188.92]:42178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBymr-0000uG-El
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBymq-00051U-39
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:35:57 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hBymp-0004z0-Mx
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:35:56 -0400
Received: from player693.ha.ovh.net (unknown [10.109.146.82])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CD7BC1659E7
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 11:35:52 +0200 (CEST)
Date: Thu, 4 Apr 2019 11:35:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190404113544.16026757@bahia.lan>
In-Reply-To: <1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 3/6] target/ppc: Handle NMI
 guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com, qemu-devel@nongnu.org, mahesh@linux.vnet.ibm.com

On Thu, 4 Apr 2019 14:40:45 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> On Monday 25 March 2019 11:52 AM, David Gibson wrote:
> > On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:  
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> the guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases. This patch handles
> >> KVM_EXIT_NMI exit.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>     (e20bbd3d and related commits)
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |    1 +
> >>  target/ppc/kvm.c       |   16 ++++++++++++++++
> >>  target/ppc/kvm_ppc.h   |    2 ++
> >>  4 files changed, 41 insertions(+)
> >>  
> 
> [...]
> 
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 2427c8e..a593448 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >>          ret = 0;
> >>          break;
> >>  
> >> +    case KVM_EXIT_NMI:
> >> +        DPRINTF("handle NMI exception\n");  
> > 
> > tracepoints are generally preferred to new DPRINTFs.  
> 
> I see DPRINTFs used in all other exit reasons in this function. Do you
> want me to change this particular exit case to tracepoints? I think it
> is better to keep this DPRINTF as of now and change all the DPRINTFs to
> tracepoints in a separate patch set.
> 

git grep shows that all DPRINTFs (25 of them) are in target/ppc/kvm.c. I guess
this can be addressed with a single, mechanical and easy to review preparatory
patch.

> Regards,
> Aravinda
> 
> >   
> >> +        ret = kvm_handle_nmi(cpu, run);
> >> +        break;
> >> +
> >>      default:
> >>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
> >>          ret = -1;
> >> @@ -2803,6 +2808,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >>      return data & 0xffff;
> >>  }
> >>  
> >> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> >> +{
> >> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
> >> +
> >> +    cpu_synchronize_state(CPU(cpu));
> >> +
> >> +    spapr_mce_req_event(cpu, recovered);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  int kvmppc_enable_hwrng(void)
> >>  {
> >>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
> >> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >> index 2c2ea30..df5e85f 100644
> >> --- a/target/ppc/kvm_ppc.h
> >> +++ b/target/ppc/kvm_ppc.h
> >> @@ -80,6 +80,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
> >>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
> >>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
> >>  
> >> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> >> +
> >>  #else
> >>  
> >>  static inline uint32_t kvmppc_get_tbfreq(void)
> >>  
> >   
> 
