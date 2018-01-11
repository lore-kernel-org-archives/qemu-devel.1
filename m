Received: from eggs.gnu.org ([2001:4830:134:3::10]:34210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eZQWB-0002hC-EP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eZQW7-00023q-Jz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:14:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eZQW7-00022O-9q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 19:14:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B0EU47031376
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 19:14:45 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fduc6m36g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 19:14:44 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 19:14:43 -0500
Date: Wed, 10 Jan 2018 22:14:37 -0200
From: joserz@linux.vnet.ibm.com
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
	<20180106004722.1152-2-joserz@linux.vnet.ibm.com>
	<20180109134813.01283a04@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180109134813.01283a04@bahia.lan>
Message-Id: <20180111001437.qvorx45tyu57s2pm@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, david@gibson.dropbear.id.au
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, Jan 09, 2018 at 01:48:13PM +0100, Greg Kurz wrote:
> On Fri,  5 Jan 2018 22:47:22 -0200
> Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> wrote:
> 
> > Power9 supports 4 HW threads/core but it's possible to emulate
> > doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
> > which returns a bitmap with all SMT modes supported by the host.
> > 
> > Today, QEMU forces the SMT mode based on PVR compat table, this is
> > silently done in spapr_fixup_cpu_dt. Then, if user passes thread=8 the
> > guest will end up with 4 threads/core without any feedback to the user.
> > It is confusing and will crash QEMU if a cpu is hotplugged in that
> > guest.
> > 
> > This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
> > supports the SMT mode so it allows Power9 guests to have 8 threads/core
> > if desired.
> > 
> > Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
> 
> Hi,
> 
> I agree with the general idea but I have a few questions.

Hello!!!! Thank you for your detailed review. :)

I'm copying David too because I've seen other bugs related with (v)smt
topic (specially migration) that it could address.

> 
> The MIN(smp_threads, ppc_compat_max_threads(cpu)) computation is
> performed in spapr_fixup_cpu_dt() at CAS, but it is also performed
> in spapr_populate_cpu_dt() at machine reset or when a CPU is added.
> 
> Shouldn't your patch address the latter as well ?

As far as I investigated, I found out that ppc_compat_max_threads() is
called several times, but it always returns the number of threads from
the argument line. Only in spapr_fixup_cpu_dt(), that happens during
the guest kernel initialization when it's realizing the CPUS, is that
ppc_compat_max_threads() will return that MIN(n_threads, compat->max_threads).

Until them, if(cpu->compat_pvr) is zeroed and QEMU doesn't know the
max_threads yet.

That's the reason that I added the code only in spapr_fixup_cpu_dt()
because this is where the change really happens.

> 
> >  hw/ppc/spapr.c       | 14 +++++++++++++-
> >  hw/ppc/trace-events  |  1 +
> >  target/ppc/kvm.c     |  5 +++++
> >  target/ppc/kvm_ppc.h |  6 ++++++
> >  4 files changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d1acfe8858..ea2503cd2f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -345,7 +345,19 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
> >          PowerPCCPU *cpu = POWERPC_CPU(cs);
> >          DeviceClass *dc = DEVICE_GET_CLASS(cs);
> >          int index = spapr_vcpu_id(cpu);
> > -        int compat_smt = MIN(smp_threads, ppc_compat_max_threads(cpu));
> 
> Considering that we have:
> 
> int ppc_compat_max_threads(PowerPCCPU *cpu)
> {
>     const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
>     int n_threads = CPU(cpu)->nr_threads;
> 
>     if (cpu->compat_pvr) {
>         g_assert(compat);
>         n_threads = MIN(n_threads, compat->max_threads);
>     }
> 
>     return n_threads;
> }
> 
> and
> 
> void qemu_init_vcpu(CPUState *cpu)
> {
>     cpu->nr_cores = smp_cores;
>     cpu->nr_threads = smp_threads;
> ...
> }
> 
> ppc_compat_max_threads() already returns the smaller value of
> smp_threads and the maximum number of HW threads for the PVR.
> 
> I don't quite understand why we had this compat_smt calculation
> in the first place...

Mostly it only returns "n_threads = CPU(cpu)->nr_threads" because until
the guest kernel initialization cpu->compat_pvr is false so that
MIN() macro is not executed.

So, until late, QEMU thinks its guest will have 8 threads/core. During
the guest kernel init., that fixup code calls ppc_compat_max_threads
that will now have cpu->compat_pvr true and will change the number
of threads to 4. Example:

qemu-system-ppc64 -smp sockets=1,cores=1,threads=8
 +-> qemu_init_vcpu, spapr_populate_cpu_dt: 8 threads/core
 +-> guest kernel is running and asks about CPUs, spapr_fixup_cpu_dt()
     runs, sets threads to 4, set ibm,ppc-interrupt-server#s and done.
 +-> guest now believes it only has 4 threads.

> 
> > +
> > +        /* set smt to maximum for this current pvr if the number
> > +         * passed is higher than defined by PVR compat mode AND
> > +         * if KVM cannot emulate it.*/
> > +        int compat_smt = smp_threads;
> > +        if ((kvmppc_cap_smt_possible() & smp_threads) != smp_threads &&
> > +                smp_threads > ppc_compat_max_threads(cpu)) {
> > +            compat_smt = ppc_compat_max_threads(cpu);
> > +
> > +            trace_spapr_fixup_cpu_smt(index, smp_threads,
> > +                    kvmppc_cap_smt_possible(),
> > +                    ppc_compat_max_threads(cpu));
> > +        }
> 
> ... so I'm wondering if the above shouldn't be performed in
> ppc_compat_max_threads() directly ? 

Hmm, now I'm believe that the whole code could rely on that
kvmppc_cap_smt_possible() since it will always return the number of
threads supported by the underlying HW. We could have a check in the
very beginning:

if ((kvmppc_cap_smt_possible() & smp_threads) != smp_threads) {
    // explain the user that such setup is wrong and quit.
}

and that part in fixup code could be unecessary.

> 
> >  
> >          if ((index % smt) != 0) {
> >              continue;
> > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > index b7c3e64b5e..a8e29d7ab1 100644
> > --- a/hw/ppc/trace-events
> > +++ b/hw/ppc/trace-events
> > @@ -16,6 +16,7 @@ spapr_irq_alloc(int irq) "irq %d"
> >  spapr_irq_alloc_block(int first, int num, bool lsi, int align) "first irq %d, %d irqs, lsi=%d, alignnum %d"
> >  spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d irqs"
> >  spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free"
> > +spapr_fixup_cpu_smt(int idx, int smpt, int kvmt, int pvrt) "CPU(%d): expected smt %d, kvm support %d, max smt pvr %d"
> >  
> >  # hw/ppc/spapr_hcall.c
> >  spapr_cas_pvr_try(uint32_t pvr) "0x%x"
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 518dd06e98..aac5667bf4 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2456,6 +2456,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
> >      return cap_mmu_hash_v3;
> >  }
> >  
> > +int kvmppc_cap_smt_possible(void)
> > +{
> > +    return cap_ppc_smt_possible;
> > +}
> > +
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >  {
> >      uint32_t host_pvr = mfpvr();
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index ecb55493cc..6ac33d2b4a 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -59,6 +59,7 @@ bool kvmppc_has_cap_fixup_hcalls(void);
> >  bool kvmppc_has_cap_htm(void);
> >  bool kvmppc_has_cap_mmu_radix(void);
> >  bool kvmppc_has_cap_mmu_hash_v3(void);
> > +int kvmppc_cap_smt_possible(void);
> >  int kvmppc_enable_hwrng(void);
> >  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> > @@ -290,6 +291,11 @@ static inline bool kvmppc_has_cap_mmu_hash_v3(void)
> >      return false;
> >  }
> >  
> > +static inline int kvmppc_cap_smt_possible(void)
> > +{
> > +    return -1;
> 
> When CONFIG_KVM is set, the semantics of kvmppc_cap_smt_possible() is:
> - a bitmap with supported SMT modes if KVM has KVM_CAP_PPC_SMT_POSSIBLE
> - 0 if KVM doesn't have KVM_CAP_PPC_SMT_POSSIBLE or we're running in
>   TCG mode
> 
> so it looks a bit weird to return -1 when CONFIG_KVM isn't set (when
> running in TCG mode, we would get different values depending on how
> the QEMU binary was compiled).
> 
> Shouldn't this stub return 0 instead ?

YES! it *must* be otherwise TCG would accept any smt mode,
I'll change it.

Thanks :-)

> 
> Cheers,
> 
> --
> Greg
> 
> > +}
> > +
> >  static inline int kvmppc_enable_hwrng(void)
> >  {
> >      return -1;
> 
