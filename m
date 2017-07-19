Received: from eggs.gnu.org ([2001:4830:134:3::10]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjK4-0004nT-R0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjK1-00073q-Jb
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXjK1-00073Y-9c
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:23:01 -0400
Date: Wed, 19 Jul 2017 09:23:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170719092302.0e544cf8@Igors-MacBook-Pro.local>
In-Reply-To: <20170719000206.GA2757@localhost.localdomain>
References: <20170712162058.10538-1-ehabkost@redhat.com>
	<20170712162058.10538-5-ehabkost@redhat.com>
	<20170718152726.1f1b0bff@nial.brq.redhat.com>
	<20170719000206.GA2757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target/i386: Don't use
 x86_cpu_load_def() on "max" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 18 Jul 2017 21:02:06 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Jul 18, 2017 at 03:27:26PM +0200, Igor Mammedov wrote:
> > On Wed, 12 Jul 2017 13:20:58 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > When commit 0bacd8b3046f ('i386: Don't set CPUClass::cpu_def on
> > > "max" model') removed the CPUClass::cpu_def field, we kept using
> > > the x86_cpu_load_def() helper directly in max_x86_cpu_initfn(),
> > > emulating the previous behavior when CPUClass::cpu_def was set.
> > > 
> > > However, x86_cpu_load_def() is intended to help initialization of
> > > CPU models from the builtin_x86_defs table, and does lots of
> > > other steps that are not necessary for "max".
> > > 
> > > One of the things x86_cpu_load_def() do is to set the properties
> > > listed at tcg_default_props/kvm_default_props.  We must not do
> > > that on the "max" CPU model, otherwise under KVM we will
> > > incorrectly report all KVM features as always available, and the
> > > "svm" feature as always unavailable.  The latter caused the bug
> > > reported at:
> > Maybe add that all available features for 'max' are set later at realize() time
> > to ones actually supported by host.
> 
> I can add the following paragraph to the commit message.  Is it
> enough to get your Reviewed-by?
> 
>     target/i386: Don't use x86_cpu_load_def() on "max" CPU model
>     
>     When commit 0bacd8b3046f ('i386: Don't set CPUClass::cpu_def on
>     "max" model') removed the CPUClass::cpu_def field, we kept using
>     the x86_cpu_load_def() helper directly in max_x86_cpu_initfn()
>     because it allowed us to reuse the old max_x86_cpu_class_init()
>     code.
>     
>     However, the only X86CPUDefinition fields we really use are
>     vendor/family/model/stepping/model-id, and x86_cpu_load_def()
>     tries to do other stuff that is only necessary when using named
>     CPU models from builtin_x86_defs.
>     
>     One of the things x86_cpu_load_def() do is to set the properties
>     listed at kvm_default_props.  We must not do that on "max" and
>     "host" CPU models, otherwise we will incorrectly report all KVM
>     features as always available, and incorrectly report the "svm"
>     feature as always unavailable under KVM.  The latter caused the
>     bug reported at:
>     
>       https://bugzilla.redhat.com/show_bug.cgi?id=1467599
>       ("Unable to start domain: the CPU is incompatible with host CPU:
>       Host CPU does not provide required features: svm")
> 
>     Replace x86_cpu_load_def() with simple object_property_set*()
>     calls.  In addition to fixing the above bug, this makes the KVM
>     code very similar to the TCG code inside max_x86_cpu_initfn().
>     
> +   For reference, the full list of steps performed by
> +   x86_cpu_load_def() is:
> +   
> +   * Setting min-level and min-xlevel.  Already done by
> +     max_x86_cpu_initfn().
> +   * Setting family/model/stepping/model-id.  Done by the code added
> +     to max_x86_cpu_initfn() in this patch.
> +   * Copying def->features.  Wrong because "-cpu max" features need to
> +     be calculated at realize time.  This was not a problem in the
> +     current code because host_cpudef.features was all zeroes.
> +   * x86_cpu_apply_props() calls.  This causes the bug above, and
> +     shouldn't be done.
> +   * Setting CPUID_EXT_HYPERVISOR.  Not needed because it is already
> +     reported by x86_cpu_get_supported_feature_word(), and because
> +     "-cpu max" features need to be calculated at realize time.
> +   * Setting CPU vendor to host CPU vendor if on KVM mode.
> +     Redundant, because max_x86_cpu_initfn() already sets it to the
> +     host CPU vendor.
> +
>     Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > 
> > Also while looking at it, I've noticed that:
> > x86_cpu_load_def()
> >   ...
> >       if (kvm_enabled()) {                                                         
> >         if (!kvm_irqchip_in_kernel()) {                                          
> >             x86_cpu_change_kvm_default("x2apic", "off");                         
> >         }
> > 
> > and
> > 
> > kvm_arch_get_supported_cpuid() also having
> >         if (!kvm_irqchip_in_kernel()) {                                          
> >             ret &= ~CPUID_EXT_X2APIC;                                            
> >         } 
> > 
> > so do we really need this duplication in x86_cpu_load_def()?
> 
> Those two pieces of code represent two different rules:
> 
> The first encodes the fact that we won't try to enable x2apic by
> default if !kvm_irqchip_in_kernel().  It is required so we don't
> get spurious "feature x2apic is unavailable" warnings (or fatal
> errors if in enforce mode).
> 
> The second encodes the fact that we can't enable x2apic if
> !kvm_irqchip_in_kernel().  It is required so we block the user
> from enabling x2apic manually on the command-line.
> 
> It's true that the first rule is a direct consequence of the
> second rule.  We could figure out a mechanism to make the code
> for the second rule trigger the first rule automatically, but I'm
> not sure it would be worth the extra complexity.  (And it's out
> of the scope of this patch).
Agreed, we can figure it out later.
It will be cleanup and definitely out of scope of this patch.

> 
> > 
> > > 
> > >   https://bugzilla.redhat.com/show_bug.cgi?id=1467599
> > >   ("Unable to start domain: the CPU is incompatible with host CPU:
> > >   Host CPU does not provide required features: svm")
> > > 
> > > Replace x86_cpu_load_def() with simple object_property_set*()
> > > calls.  In addition to fixing the above bug, this makes the KVM
> > > branch in max_x86_cpu_initfn() very similar to the existing TCG
> > > branch.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  target/i386/cpu.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index e2cd157..62d8021 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -1596,15 +1596,21 @@ static void max_x86_cpu_initfn(Object *obj)
> > >      cpu->max_features = true;
> > >  
> > >      if (kvm_enabled()) {
> > > -        X86CPUDefinition host_cpudef = { };
> > > -        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
> > > +        char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
> > > +        char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
> > > +        int family, model, stepping;
> > >  
> > > -        host_vendor_fms(host_cpudef.vendor, &host_cpudef.family,
> > > -                        &host_cpudef.model, &host_cpudef.stepping);
> > > +        host_vendor_fms(vendor, &family, &model, &stepping);
> > >  
> > > -        cpu_x86_fill_model_id(host_cpudef.model_id);
> > > +        cpu_x86_fill_model_id(model_id);
> > >  
> > > -        x86_cpu_load_def(cpu, &host_cpudef, &error_abort);
> > this looses 
> >    env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
> > but it looks like kvm_arch_get_supported_cpuid() will take care of it later
> > at realize() time.
> 
> Yes, kvm_arch_get_supported_cpuid() already sets
> CPUID_EXT_HYPERVISOR, and on -cpu host/max, we only care about
> kvm_arch_get_supported_cpuid() (for KVM) or
> FeatureWord::tcg_features (for TCG).
> 
> This is similar to the x2apic case: x86_cpu_load_def() encodes
> the fact that CPUID_EXT_HYPERVISOR is enabled by default (on the
> predefined CPU models).  kvm_arch_get_supported_cpuid() (and
> FeatureWord::tcg_features) encodes the fact that we _can_ enable
> CPUID_EXT_HYPERVISOR.
> 
> > 
> > > +        object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
> > > +        object_property_set_int(OBJECT(cpu), family, "family", &error_abort);
> > > +        object_property_set_int(OBJECT(cpu), model, "model", &error_abort);
> > > +        object_property_set_int(OBJECT(cpu), stepping, "stepping",
> > > +                                &error_abort);
> > > +        object_property_set_str(OBJECT(cpu), model_id, "model-id",
> > > +                                &error_abort);
> > >  
> > >          env->cpuid_min_level =
> > >              kvm_arch_get_supported_cpuid(s, 0x0, 0, R_EAX);
> > 
> 
