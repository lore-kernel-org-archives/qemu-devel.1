Received: from eggs.gnu.org ([209.51.188.92]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gnE4E-0001xL-0w
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gnE4C-00046T-W3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:51:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gnE4C-000463-NU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 21:51:32 -0500
Date: Sat, 26 Jan 2019 00:51:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190126025129.GN4136@habkost.net>
References: <1548381283-16688-1-git-send-email-luwei.kang@intel.com>
	<20190124183909.GA4136@habkost.net>
	<82D7661F83C1A047AF7DC287873BF1E172CCDB7C@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E172CCDB7C@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] i386: extended the cpuid level when Intel
 PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kang, Luwei" <luwei.kang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On Fri, Jan 25, 2019 at 02:21:20AM +0000, Kang, Luwei wrote:
> > > Intel Processor Trace required CPUID[0x14] but the cpuid level is 0xd
> > > when create a kvm guest with e.g. "-cpu qemu64,+intel-pt".
> > >
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > ---
> > >  target/i386/cpu.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c index
> > > 2f54125..da477b3 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -5023,6 +5023,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
> > >          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> > > +
> > > +        /* Intel Processor Trace requires CPUID[0x14] */
> > > +        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> > > +             kvm_enabled()) {
> > > +            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
> > > +        }
> > 
> > This will require a new machine-type compatibility flag to enable the new behavior, so we don't change CPUID data under the guest feet during live migration.
> 
> Hi Eduardo,
>     Thanks for your reply. I have some question on your comments.
>     The cpuid level come from specific machine-type (e.g. qemu64, Skylake-Server) and they are all 0xd, but Intel PT required 0x14 so I extend the cpuid level.
>     I don't fully understand what is the "require a new machine-type compatibility flag" mean, I need to add a new flag in each machine-type? 
>     I try to do live migration with "-cpu qemu64,+intel-pt" and "-cpu host" are all passed test. We didn't change the cpuid data during live migration just initialize the cpuid data when create a new vcpu. Please correct me if anything wrong.

CPUID data is not sent as part of the migration stream (it is
recreated on the migration destination), so if "-cpu qemu,+intel-pt"
results in different CPUID data, migration between QEMU 4.0 and
3.1 will make CPUID level change during live migration.

This is not a serious issue, but it might confuse software
running on the guest.

We can fix that doing this:

target/i386/cpu.c:

static Property x86_cpu_properties[] = {
    ...
    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level, true),
    ....
}
...
static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
{
    ...
        /* Intel Processor Trace requires CPUID[0x14] */
        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) && cpu->intel_pt_auto_level) {
            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
        }
    ...
}

hw/i386/pc.c:

GlobalProperty pc_compat_3_1[] = {
    ...
    { TYPE_X86_CPU, "x-intel-pt-auto-leevl", "off" },
};

> Thanks,
> Luwei Kang
> 
> > 
> > > +
> > >          /* SVM requires CPUID[0x8000000A] */
> > >          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
> > >              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel,
> > > 0x8000000A);
> > > --
> > > 1.8.3.1
> > >
> > 
> > --
> > Eduardo

-- 
Eduardo
