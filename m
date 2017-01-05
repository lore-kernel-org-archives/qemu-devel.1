Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cP5bK-0006qK-Pf
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cP5bH-0000fy-G4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:48:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cP5bH-0000fq-75
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:48:51 -0500
Date: Thu, 5 Jan 2017 08:48:32 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170105104830.GB6299@amt.cnet>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170105013631.GO3315@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] TSC frequency configuration & invtsc migration
 (was Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Wed, Jan 04, 2017 at 11:36:31PM -0200, Eduardo Habkost wrote:
> On Wed, Jan 04, 2017 at 08:26:27PM -0200, Marcelo Tosatti wrote:
> > On Wed, Jan 04, 2017 at 05:59:17PM -0200, Eduardo Habkost wrote:
> > > On Wed, Jan 04, 2017 at 11:39:16AM -0200, Eduardo Habkost wrote:
> > > > On Wed, Jan 04, 2017 at 09:56:56AM -0200, Marcelo Tosatti wrote:
> > > > > On Tue, Dec 27, 2016 at 05:21:20PM -0200, Eduardo Habkost wrote:
> > > > > > Instead of blocking migration on the source when invtsc is
> > > > > > enabled, rely on the migration destination to ensure there's no
> > > > > > TSC frequency mismatch.
> > > > > > 
> > > > > > We can't allow migration unconditionally because we don't know if
> > > > > > the destination is a QEMU version that is really going to ensure
> > > > > > there's no TSC frequency mismatch. To ensure we are migrating to
> > > > > > a destination that won't ignore SET_TSC_KHZ errors, allow invtsc
> > > > > > migration only on pc-*-2.9 and newer.
> > > > > > 
> > > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > [...]
> > > > > > @@ -2655,12 +2656,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
> > > > > >      }
> > > > > >  
> > > > > >      if (level == KVM_PUT_FULL_STATE) {
> > > > > > -        /* We don't check for kvm_arch_set_tsc_khz() errors here,
> > > > > > -         * because TSC frequency mismatch shouldn't abort migration,
> > > > > > -         * unless the user explicitly asked for a more strict TSC
> > > > > > -         * setting (e.g. using an explicit "tsc-freq" option).
> > > > > > +        /* Migration TSC frequency mismatch is fatal only if we are
> > > > > > +         * actually reporting Invariant TSC to the guest.
> > > > > >           */
> > > > > > -        kvm_arch_set_tsc_khz(cpu);
> > > > > > +        ret = kvm_arch_set_tsc_khz(cpu);
> > > > > > +        if ((x86_cpu->env.features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> > > > > > +            ret < 0) {
> > > > > > +            return ret;
> > > > > > +        }
> > > > > >      }
> > > > > 
> > > > > Will the guest continue in the source in this case?
> > > > > 
> > > > > I think this is past the point where migration has been declared
> > > > > successful. 
> > > > > 
> > > > > Otherwise looks good.
> > > > 
> > > > Good point. I will make additional tests and see if there's some
> > > > other place where the kvm_arch_set_tsc_khz() call can be moved
> > > > to.
> > > 
> > > So, if we solve this and do something on (for example) post_load,
> > > we still have a problem: device state is migrated after RAM. This
> > > means QEMU will check for TSC scaling and abort migration very
> > > late.
> > > 
> > > We could solve that by manually registering a SaveVMHandler that
> > > will send the TSC frequency on save_live_setup, so migration is
> > > aborted earlier.
> > > 
> > > But: this sounds like just a complex hack to work around the real
> > > problems:
> > > 
> > > 1) TSC frequency is guest-visible, and anything that affects
> > >    guest ABI should depend on the VM configuration, not on host
> > >    capabilities;
> > 
> > Well not really: the TSC frequency where the guest starts 
> > is the frequency the guest software expects.
> > So it does depend on host capabilities.
> 
> Could you explain where this expectation comes from? I can see
> multiple cases where choosing the TSC frequency where the VM
> starts is not the best option.

1. Boot guest.
2. Calibrate TSC.
3. Use delay() with TSC calibration above, or
use TSC to measure the passage of time (TSC clock 
in userspace).

> I am considering two possible scenarios below. You probably have
> another scenario in mind, so it would be useful if you could
> describe it so we can consider possible solutions.
> 
> 
> Scenario 1:
> 
> You have two hosts: A and B, both with TSC scaling. They have
> different frequencies. The VM can be started on either one of
> them, and can be migrated to either one depending on the policy
> of management software.
> 
> Maybe B is a backup host, the VM is expected to run most times on
> host A, and we want to use the TSC frequency from host A every
> time. Maybe it's the opposite and we want to use the frequency of
> B. Maybe we want to use the lowest frequency of both, maybe the
> highest one. We (QEMU developers) can recommend policy to libvirt
> developers, but a given QEMU process doesn't have information to
> decide what's best.

I can't see any practical scenario here, you will always want
to start with TSC frequency of the host where the VM was started.

If i am mistaken, please describe a practical case.

(If a practical scenario comes up, and there is a use-case
for setting the TSC frequency on startup, lets say 
a Windows VM which fails to boot if the TSC frequency
is too high, then it should be supported... But the
only known scenario to me, applying to 99.999% of cases, 
is to expose the TSC frequency where the guest booted at).

> Scenario 2:
> 
> Host A has TSC scaling, host B doesn't have TSC scaling. We want
> to be able to start the VM on host A, and migrate to B. In this
> case, the only possible solution is to use B's frequency when
> starting the VM. The QEMU process doesn't have enough information
> to make that decision.

That is a good point. But again, its a special case and 
should be supported by -cpu xxx,tsc-frequency=zzzz.

However, for the vast majority of 99.999% cases, the issue
can be handled entirely in QEMU, without libvirt involvement,
and without adding extra steps to the management software.

> > > 2) Setting TSC frequency depending on the host will make
> > >    migratability unpredictable for management software: the same
> > >    VM config could be migratable to host A when started on host
> > >    B, but not migratable to host A when started on host C.
> > 
> > Well, just check the frequency.
> 
> What do you mean by "just check the frequency"? What exactly
> should management software do?

VM booted on host-A can be migrated to host-B if TSC
frequency matches.

> Whatever management software do, if you just use the source host
> frequency you can get into a situation where you can start a VM
> on host A and migrate it to B, but can't start the VM on host B
> and migrate it to A. This would be confusing for users, and
> probably break assumptions of existing management software.

Well this is a side effect of invariant TSC and migration.

Look, i agree with all your points, but my point is this: i personally
prefer to handle the 99.999% case, which is the TSC frequency exposed is the one
from the host where the guest booted, in QEMU entirely (for example, to
make life easier for people who run qemu manually such as myself).

> > > I suggest we allow migration with invtsc if and only if
> > > tsc-frequency is set explicitly by management software. In other
> > > words, apply only patches 1/4 and 2/4 from this series. After
> > > that, we will need libvirt support for configuring tsc-frequency.
> > 
> > I don't like that for the following reasons:
> > 
> > * It moves low level complexity from QEMU/KVM to libvirt 
> >    (libvirt has to call KVM_GET_TSC_KHZ from a vcpu thread).
> 
> It doesn't. It could ask QEMU for that information (the new
> query-cpu-model-expansion QMP command would allow that).
> 
> Or, alternatively, it could just let the user choose the
> frequency. 

Again, you want to expose the host where the VM booted in most
cases (except the ones you list above).

> It's probably acceptable for many use cases where
> invtsc+migration is important.

Ok, thats better. Can you add a patch to your series with the steps 
as how mgmt software should proceed ?

> > * It makes it difficult to run QEMU manually (i use QEMU
> >    manually all the time).
> 
> I believe the set of people that: 1) need invtsc; 2) need
> migration to work; and 3) run QEMU manually will be able to add
> "tsc-frequency=XXX" to the command-line easily. :)

Ok, so migration is only allowed if tsc-frequency= is specified.

> > * It requires patching libvirt.
> > 
> > In my experience things work better when the functionality is
> > not split across libvirt/qemu.
> 
> In my experience things break when management software is the
> only component able to make a decision but we don't provide
> mechanisms to let management software make that decision.
> 
> The TSC frequency affects migratability to hosts. Choose the
> wrong frequency, and you might not be able to migrate. Only
> management software knows to which hosts the VM could be migrated
> in the future, and which TSC frequency would allow that.

True.

> > Can't this be fixed in QEMU? Just check that destination host supports
> > TSC scaling before migration (or that KVM_GET_TSC_KHZ return value
> > matches on source and destination).
> > 
> 
> This solves only one use case: where you want to expose the
> starting host TSC frequency to the guest. It doesn't cover any
> scenario where the TSC frequency of the starting host isn't the
> best one. (See the two scenarios I described above)

True.

> You seem to have a specific use case in mind. If you describe it,
> we could decide if it's worth the extra migration code complexity
> to deal with invtsc migration without explicit tsc-frequency. By
> now, I am not convinced yet.

I don't have any specific use case in mind. I'm just trying to
avoid moving complexity to libvirt which in my experience is a
the best thing to do.

> Maybe your use case just needs a explicit "invtsc-migration=on"
> command-line flag without a mechanism to abort migration on
> mismatch? I can't tell.

Again, there is no special case.

> Note that even if we follow your suggestion and implement an
> alternative version of patch 4/4 to cover your use case, I will
> strongly recommend libvirt developers to support configuring TSC
> frequency if they want to support invtsc + migration without
> surprising/unpredictable restrictions on migratability.

Well, alright. If you make the TSC frequency of the host
available to mgmt software as you describe, and write the steps mgmt
software should take, i'm good.

Thanks for the help Eduardo.
