Received: from eggs.gnu.org ([2001:4830:134:3::10]:54069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOlmm-00047m-JS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOlmh-0003yb-MU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:39:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cOlmh-0003xK-Dd
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:39:19 -0500
Date: Wed, 4 Jan 2017 11:39:16 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170104133916.GG3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104115656.GB14961@amt.cnet>
Subject: Re: [Qemu-devel] [PATCH 4/4] kvm: Allow migration with invtsc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Wed, Jan 04, 2017 at 09:56:56AM -0200, Marcelo Tosatti wrote:
> On Tue, Dec 27, 2016 at 05:21:20PM -0200, Eduardo Habkost wrote:
> > Instead of blocking migration on the source when invtsc is
> > enabled, rely on the migration destination to ensure there's no
> > TSC frequency mismatch.
> > 
> > We can't allow migration unconditionally because we don't know if
> > the destination is a QEMU version that is really going to ensure
> > there's no TSC frequency mismatch. To ensure we are migrating to
> > a destination that won't ignore SET_TSC_KHZ errors, allow invtsc
> > migration only on pc-*-2.9 and newer.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/i386/pc.h |  7 ++++++-
> >  target/i386/cpu.h    |  1 +
> >  target/i386/cpu.c    |  1 +
> >  target/i386/kvm.c    | 15 +++++++++------
> >  4 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index ceeacca..4270923 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -375,7 +375,12 @@ int e820_get_num_entries(void);
> >  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  
> >  #define PC_COMPAT_2_8 \
> > -    HW_COMPAT_2_8
> > +    HW_COMPAT_2_8 \
> > +    {\
> > +        .driver   = TYPE_X86_CPU,\
> > +        .property = "invtsc-migration",\
> > +        .value    = "off",\
> > +    },
> >  
> >  #define PC_COMPAT_2_7 \
> >      HW_COMPAT_2_7 \
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index a7f2f60..ec8cdbc 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -1208,6 +1208,7 @@ struct X86CPU {
> >      bool expose_kvm;
> >      bool migratable;
> >      bool host_features;
> > +    bool invtsc_migration;
> >      uint32_t apic_id;
> >  
> >      /* if true the CPUID code directly forward host cache leaves to the guest */
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index b0640f1..cc93b81 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -3678,6 +3678,7 @@ static Property x86_cpu_properties[] = {
> >      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> >      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> >      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
> > +    DEFINE_PROP_BOOL("invtsc-migration", X86CPU, invtsc_migration, true),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 6a51399..2c3ee7b 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -962,7 +962,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >          has_msr_mcg_ext_ctl = has_msr_feature_control = true;
> >      }
> >  
> > -    if (!env->user_tsc_khz) {
> > +    if (!cpu->invtsc_migration && !env->user_tsc_khz) {
> >          if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> >              invtsc_mig_blocker == NULL) {
> >              /* for migration */
> > @@ -972,6 +972,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >              migrate_add_blocker(invtsc_mig_blocker);
> >              /* for savevm */
> >              vmstate_x86_cpu.unmigratable = 1;
> > +        }
> >      }
> >  
> >      cpuid_data.cpuid.padding = 0;
> > @@ -2655,12 +2656,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
> >      }
> >  
> >      if (level == KVM_PUT_FULL_STATE) {
> > -        /* We don't check for kvm_arch_set_tsc_khz() errors here,
> > -         * because TSC frequency mismatch shouldn't abort migration,
> > -         * unless the user explicitly asked for a more strict TSC
> > -         * setting (e.g. using an explicit "tsc-freq" option).
> > +        /* Migration TSC frequency mismatch is fatal only if we are
> > +         * actually reporting Invariant TSC to the guest.
> >           */
> > -        kvm_arch_set_tsc_khz(cpu);
> > +        ret = kvm_arch_set_tsc_khz(cpu);
> > +        if ((x86_cpu->env.features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> > +            ret < 0) {
> > +            return ret;
> > +        }
> >      }
> 
> Will the guest continue in the source in this case?
> 
> I think this is past the point where migration has been declared
> successful. 
> 
> Otherwise looks good.

Good point. I will make additional tests and see if there's some
other place where the kvm_arch_set_tsc_khz() call can be moved
to.

-- 
Eduardo
