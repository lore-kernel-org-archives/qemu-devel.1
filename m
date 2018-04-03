Received: from eggs.gnu.org ([2001:4830:134:3::10]:35590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3AsA-0006iZ-Uw
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 21:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3As6-0002aw-SA
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 21:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f3As6-0002Zw-K5
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 21:36:26 -0400
Date: Mon, 2 Apr 2018 22:36:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180403013623.GF5046@localhost.localdomain>
References: <20180326170658.606-1-juterry@microsoft.com>
	<20180328175050.GH5046@localhost.localdomain>
	<DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On Wed, Mar 28, 2018 at 08:48:54PM +0000, Justin Terry (VM) wrote:
> Hey Eduardo
> 
> Responses inline. Thanks!
> 
> > -----Original Message-----
> > From: Eduardo Habkost <ehabkost@redhat.com>
> > Sent: Wednesday, March 28, 2018 10:51 AM
> > To: Justin Terry (VM) <juterry@microsoft.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; rth@twiddle.net
> > Subject: Re: [PATCH] WHPX fixes an issue with CPUID 1 not returning
> > CPUID_EXT_HYPERVISOR
> > 
> > On Mon, Mar 26, 2018 at 10:06:58AM -0700, Justin Terry (VM) wrote:
> > > Implements the CPUID trap for CPUID 1 to include the
> > > CPUID_EXT_HYPERVISOR flag in the ECX results. This was preventing some
> > > older linux kernels from booting when trying to access MSR's that dont
> > > make sense when virtualized.
> > >
> > > Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> > > ---
> > >  target/i386/whpx-all.c | 79
> > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 78 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c index
> > > bf33d320bf..58435178a4 100644
> > > --- a/target/i386/whpx-all.c
> > > +++ b/target/i386/whpx-all.c
> > > @@ -911,12 +911,62 @@ static int whpx_vcpu_run(CPUState *cpu)
> > >              ret = 1;
> > >              break;
> > >
> > > +        case WHvRunVpExitReasonX64Cpuid: {
> > > +            WHV_REGISTER_VALUE reg_values[5] = {0};
> > > +            WHV_REGISTER_NAME reg_names[5];
> > > +            UINT32 reg_count = 5;
> > > +            UINT64 rip, rax, rcx, rdx, rbx;
> > > +
> > > +            rip = vcpu->exit_ctx.VpContext.Rip +
> > > +                  vcpu->exit_ctx.VpContext.InstructionLength;
> > > +            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> > > +            case 1:
> > > +                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > > +                /* Advertise that we are running on a hypervisor */
> > > +                rcx =
> > > +                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
> > > +                    CPUID_EXT_HYPERVISOR;
> > > +
> > > +                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > > +                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> > > +                break;
> > > +            default:
> > > +                rax = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> > > +                rcx = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> > > +                rdx = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> > > +                rbx = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> > 
> > Interesting, so the WHPX API already tries to provide default values for the
> > CPUID leaves.  Would it make sense to try and use the values returned by
> > cpu_x86_cpuid() in the future?
> > 
> > Is there a way to get the default CPUID results from the WHPX API without
> > calling WHvRunVirtualProcessor(), so QEMU can be aware of what exactly
> > the guest is seeing on CPUID?
> 
> The platform now has two ways to interact with CPUID.
> 
> 1. (As the code is doing now). At partition creation time you
> can register for specific CPUID exits and then respond to the
> CPUID with your custom answer or with the Hypervisor defaults
> that were forwarded to you. Unfortunately, QEMU has no way to
> know the Hypervisor default ahead of time but QEMU can make at
> least make a runtime decision about how to respond.
> 2. At partition creation time the platform allows QEMU to
> inject (set) the default responses for specific CPUID exits.
> This can now be done by setting the  `WHV_X64_CPUID_RESULT` in
> the `CpuidResultList` of `WHV_PARTITION_PROPERTY` to the exit
> values QEMU wants. So effectively you can know the answers
> ahead of time for any that you set but the answers are not
> dynamic.
> 
> The only issues/questions I have there are:
> 
> If we use [1] (like the code is now) I don't see any way to
> keep the exits in cpu_x86_cpuid() matched up with the
> registered exits to WHPX. This means that WHPX would not be
> called in these cases and would instead get the Hypervisor
> default rather than the answer from cpu_x86_cpuid().

I assume you could call cpu_x86_cpuid() on every CPUID exit and
override the hypervisor default completely.  Not a very efficient
solution, but seems simple to implement.

But I'm still not sure if you really want to override the
hypervisor defaults completely (see below).

> 
> If we use [2] to inject the answers at creation time WHPX needs
> access to the CPUX86State at accel init which also doesn't seem
> to be possible in QEMU today. WHPX could basically just call
> cpu_x86_cpuid() for each CPUID QEMU cares about and plumb the
> answer before start. This has the best performance as we avoid
> the additional exits but has an issue in that the results must
> be known ahead of time.

You already have a hook into CPU initialization at
whpx_init_vcpu(), wouldn't it work for you?

> 
> And, we could obviously use a hybrid of the two for cases we
> know. Do you have any ideas that I could try out here on how
> you would like to see this work?

(2) matches very closely how it works on KVM, and using the
contents of cpu_x86_cpuid() (using either method) seems necessary
if you want to safely support live migration between different
host CPUs.

But there's one thing I would like to understand better, before
giving any advice: how important/useful are the hypervisor
defaults for your users?  The cost of making QEMU manage every
single CPUID bit is extra complexity.  The benefit you get in
return is letting management software + QEMU ensure guest ABI is
stable and nothing breaks on live migration.  So it depends on
the use cases you have in mind.

-- 
Eduardo
