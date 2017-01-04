Received: from eggs.gnu.org ([2001:4830:134:3::10]:38439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOriX-0006m4-DH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cOriS-0006Xi-ML
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cOriS-0006W6-Eh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:59:20 -0500
Date: Wed, 4 Jan 2017 17:59:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170104195917.GM3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104133916.GG3315@thinpad.lan.raisama.net>
Subject: [Qemu-devel] TSC frequency configuration & invtsc migration (was
 Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Wed, Jan 04, 2017 at 11:39:16AM -0200, Eduardo Habkost wrote:
> On Wed, Jan 04, 2017 at 09:56:56AM -0200, Marcelo Tosatti wrote:
> > On Tue, Dec 27, 2016 at 05:21:20PM -0200, Eduardo Habkost wrote:
> > > Instead of blocking migration on the source when invtsc is
> > > enabled, rely on the migration destination to ensure there's no
> > > TSC frequency mismatch.
> > > 
> > > We can't allow migration unconditionally because we don't know if
> > > the destination is a QEMU version that is really going to ensure
> > > there's no TSC frequency mismatch. To ensure we are migrating to
> > > a destination that won't ignore SET_TSC_KHZ errors, allow invtsc
> > > migration only on pc-*-2.9 and newer.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
[...]
> > > @@ -2655,12 +2656,14 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
> > >      }
> > >  
> > >      if (level == KVM_PUT_FULL_STATE) {
> > > -        /* We don't check for kvm_arch_set_tsc_khz() errors here,
> > > -         * because TSC frequency mismatch shouldn't abort migration,
> > > -         * unless the user explicitly asked for a more strict TSC
> > > -         * setting (e.g. using an explicit "tsc-freq" option).
> > > +        /* Migration TSC frequency mismatch is fatal only if we are
> > > +         * actually reporting Invariant TSC to the guest.
> > >           */
> > > -        kvm_arch_set_tsc_khz(cpu);
> > > +        ret = kvm_arch_set_tsc_khz(cpu);
> > > +        if ((x86_cpu->env.features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
> > > +            ret < 0) {
> > > +            return ret;
> > > +        }
> > >      }
> > 
> > Will the guest continue in the source in this case?
> > 
> > I think this is past the point where migration has been declared
> > successful. 
> > 
> > Otherwise looks good.
> 
> Good point. I will make additional tests and see if there's some
> other place where the kvm_arch_set_tsc_khz() call can be moved
> to.

So, if we solve this and do something on (for example) post_load,
we still have a problem: device state is migrated after RAM. This
means QEMU will check for TSC scaling and abort migration very
late.

We could solve that by manually registering a SaveVMHandler that
will send the TSC frequency on save_live_setup, so migration is
aborted earlier.

But: this sounds like just a complex hack to work around the real
problems:

1) TSC frequency is guest-visible, and anything that affects
   guest ABI should depend on the VM configuration, not on host
   capabilities;
2) Setting TSC frequency depending on the host will make
   migratability unpredictable for management software: the same
   VM config could be migratable to host A when started on host
   B, but not migratable to host A when started on host C.

I suggest we allow migration with invtsc if and only if
tsc-frequency is set explicitly by management software. In other
words, apply only patches 1/4 and 2/4 from this series. After
that, we will need libvirt support for configuring tsc-frequency.

-- 
Eduardo
