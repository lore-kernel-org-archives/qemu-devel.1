Received: from eggs.gnu.org ([209.51.188.92]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gymF0-0005QG-Se
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gymEz-0002GK-LS
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:34:26 -0500
Message-ID: <1551224055.2210.13.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 27 Feb 2019 10:34:15 +1100
In-Reply-To: <20190226035532.GM6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226030531.9932-3-sjitindarsingh@gmail.com>
	<20190226035532.GM6872@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 3/4] target/ppc: Implement large
 decrementer support for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org

On Tue, 2019-02-26 at 14:55 +1100, David Gibson wrote:
> On Tue, Feb 26, 2019 at 02:05:30PM +1100, Suraj Jitindar Singh wrote:
> > Implement support to allow KVM guests to take advantage of the
> > large
> > decrementer introduced on POWER9 cpus.
> > 
> > To determine if the host can support the requested large
> > decrementer
> > size, we check it matches that specified in the ibm,dec-bits
> > device-tree
> > property. We also need to enable it in KVM by setting the LPCR_LD
> > bit in
> > the LPCR. Note that to do this we need to try and set the bit, then
> > read
> > it back to check the host allowed us to set it, if so we can use it
> > but
> > if we were unable to set it the host cannot support it and we must
> > not
> > use the large decrementer.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Although changes might be necessary to match it to things I've
> suggested in the earlier patches in the series.
> 
> Is the KVM side support for this already merged?  If so, as of when?

Yes, as of v4.13

> 
> > ---
> >  hw/ppc/spapr_caps.c  | 17 +++++++++++++++--
> >  target/ppc/kvm.c     | 39 +++++++++++++++++++++++++++++++++++++++
> >  target/ppc/kvm_ppc.h | 12 ++++++++++++
> >  3 files changed, 66 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 44542fdbb2..e07568fb94 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -440,8 +440,16 @@ static void
> > cap_large_decr_apply(sPAPRMachineState *spapr,
> >                  pcc->hdecr_bits);
> >              return;
> >          }
> > -    } else {
> > -        error_setg(errp, "No large decrementer support, try cap-
> > large-decr=0");
> > +    } else if (kvm_enabled()) {
> > +        int kvm_nr_bits = kvmppc_get_cap_large_decr();
> > +
> > +        if (!kvm_nr_bits) {
> > +            error_setg(errp, "No large decrementer support, try
> > cap-large-decr=0");
> > +        } else if (val != kvm_nr_bits) {
> > +            error_setg(errp,
> > +                "Large decrementer size unsupported, try -cap-
> > large-decr=%d",
> > +                kvm_nr_bits);
> > +        }
> >      }
> >  }
> >  
> > @@ -452,6 +460,11 @@ static void
> > cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
> >      CPUPPCState *env = &cpu->env;
> >      target_ulong lpcr = env->spr[SPR_LPCR];
> >  
> > +    if (kvm_enabled()) {
> > +        if (kvmppc_enable_cap_large_decr(cpu, !!val))
> > +            error_setg(errp, "No large decrementer support, try
> > cap-large-decr=0");
> > +    }
> > +
> >      if (val)
> >          lpcr |= LPCR_LD;
> >      else
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index d01852fe31..3f650c8fc4 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -91,6 +91,7 @@ static int cap_ppc_safe_cache;
> >  static int cap_ppc_safe_bounds_check;
> >  static int cap_ppc_safe_indirect_branch;
> >  static int cap_ppc_nested_kvm_hv;
> > +static int cap_large_decr;
> >  
> >  static uint32_t debug_inst_opcode;
> >  
> > @@ -124,6 +125,7 @@ static bool kvmppc_is_pr(KVMState *ks)
> >  
> >  static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> >  static void kvmppc_get_cpu_characteristics(KVMState *s);
> > +static int kvmppc_get_dec_bits(void);
> >  
> >  int kvm_arch_init(MachineState *ms, KVMState *s)
> >  {
> > @@ -151,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState
> > *s)
> >      cap_resize_hpt = kvm_vm_check_extension(s,
> > KVM_CAP_SPAPR_RESIZE_HPT);
> >      kvmppc_get_cpu_characteristics(s);
> >      cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s,
> > KVM_CAP_PPC_NESTED_HV);
> > +    cap_large_decr = kvmppc_get_dec_bits();
> >      /*
> >       * Note: setting it to false because there is not such
> > capability
> >       * in KVM at this moment.
> > @@ -1927,6 +1930,15 @@ uint64_t kvmppc_get_clockfreq(void)
> >      return kvmppc_read_int_cpu_dt("clock-frequency");
> >  }
> >  
> > +static int kvmppc_get_dec_bits(void)
> > +{
> > +    int nr_bits = kvmppc_read_int_cpu_dt("ibm,dec-bits");
> > +
> > +    if (nr_bits > 0)
> > +        return nr_bits;
> > +    return 0;
> > +}
> > +
> >  static int kvmppc_get_pvinfo(CPUPPCState *env, struct
> > kvm_ppc_pvinfo *pvinfo)
> >   {
> >       PowerPCCPU *cpu = ppc_env_get_cpu(env);
> > @@ -2442,6 +2454,33 @@ bool kvmppc_has_cap_spapr_vfio(void)
> >      return cap_spapr_vfio;
> >  }
> >  
> > +int kvmppc_get_cap_large_decr(void)
> > +{
> > +    return cap_large_decr;
> > +}
> > +
> > +int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
> > +{
> > +    CPUState *cs = CPU(cpu);
> > +    uint64_t lpcr;
> > +
> > +    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> > +    /* Do we need to modify the LPCR? */
> > +    if (!!(lpcr & LPCR_LD) != !!enable) {
> > +        if (enable)
> > +            lpcr |= LPCR_LD;
> > +        else
> > +            lpcr &= ~LPCR_LD;
> > +        kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> > +        kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
> > +
> > +        if (!!(lpcr & LPCR_LD) != !!enable)
> > +            return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >  {
> >      uint32_t host_pvr = mfpvr();
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index bdfaa4e70a..a79835bd14 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -64,6 +64,8 @@ int kvmppc_get_cap_safe_bounds_check(void);
> >  int kvmppc_get_cap_safe_indirect_branch(void);
> >  bool kvmppc_has_cap_nested_kvm_hv(void);
> >  int kvmppc_set_cap_nested_kvm_hv(int enable);
> > +int kvmppc_get_cap_large_decr(void);
> > +int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
> >  int kvmppc_enable_hwrng(void);
> >  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> > @@ -332,6 +334,16 @@ static inline int
> > kvmppc_set_cap_nested_kvm_hv(int enable)
> >      return -1;
> >  }
> >  
> > +static inline int kvmppc_get_cap_large_decr(void)
> > +{
> > +    return 0;
> > +}
> > +
> > +static inline int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu,
> > int enable)
> > +{
> > +    return -1;
> > +}
> > +
> >  static inline int kvmppc_enable_hwrng(void)
> >  {
> >      return -1;
> 
> 
