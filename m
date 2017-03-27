Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csZ2D-0003OX-Q1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csZ28-0003sM-RJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csZ28-0003rz-JX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:06:24 -0400
Date: Mon, 27 Mar 2017 15:06:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170327180621.GM28530@thinpad.lan.raisama.net>
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<20170327154636.GI28530@thinpad.lan.raisama.net>
	<c14eb231-10d1-63cb-ed14-8b7cd131b7b0@suse.de>
	<20170327163333.GL28530@thinpad.lan.raisama.net>
	<164e6c5d-ca36-b92d-2831-468a54cd3efe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164e6c5d-ca36-b92d-2831-468a54cd3efe@suse.de>
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org

On Mon, Mar 27, 2017 at 06:42:49PM +0200, Alexander Graf wrote:
> 
> 
> On 27/03/2017 18:33, Eduardo Habkost wrote:
> > On Mon, Mar 27, 2017 at 06:10:43PM +0200, Alexander Graf wrote:
> > > 
> > > 
> > > On 27/03/2017 17:46, Eduardo Habkost wrote:
> > > > On Mon, Mar 27, 2017 at 04:26:50PM +0200, Alexander Graf wrote:
> > > > > KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
> > > > > instructions. There is work undergoing to enable actual execution
> > > > > of these inside of KVM, but nobody really wants to expose the feature
> > > > > to the guest by default, as it would eat up all of the host CPU.
> > > > 
> > > > Isn't this something that should be reported using
> > > > KVM_GET_EMULATED_CPUID? (QEMU still doesn't know how to use
> > > > KVM_GET_EMULATED_CPUID, however.)
> > > 
> > > Depends how you look at it. In KVM land there are basically 3 ways to deal
> > > with MONITOR/MWAIT:
> > > 
> > >   1) #VMEXIT on every execution, treat them as NOP
> > >   2) let the guest natively execute them (looks like a busy loop for the
> > > host, but saves power)
> > >   3) be smart in KVM about it, add actual emulation and adaptively allow for
> > > native mwait execution or emulated mwait which means we can run inside host
> > > context
> > 
> > Which case is going to be enabled when using your patch? Don't
> > you want to make that configurable?

If the answer to this question is "no", then we can ignore all
the rest of my previous message. :)

> > 
> > This looks like configuration that can't be easily represented
> > using the GET_SUPPORTED_CPUID/KVM_SET_CPUID abstraction, as the
> > ability to enable the feature can't be represented by a single
> > bit.
> > 
> > We already have a few cases where we make
> > kvm_arch_get_supported_cpuid() look at something other than just
> > GET_SUPPORTED_CPUID return values (most cases are related to
> > in-kernel irqchip). We can change kvm_arch_get_supported_cpuid()
> > to look at other flags (like one that would configure mwait
> > behavior), and decide to report CPUID_EXT_MONITOR on those cases.
> > 
> > Would something like the following make sense?
> > 
> > * Having a "mwait=(none|nop|native|smart)" option, to choose
> >   mwait behavior
> > * Making kvm_arch_get_supported_cpuid() return CPUID_EXT_MONITOR
> >   as supported only if the "mwait" option is not "none".
> > 
> > Then:
> > * "-cpu ...,monitor=on" would fail, because mwait=none would be
> >   the default
> > * "-cpu ...,mwait=none,monitor=on" would fail
> > * "-cpu ...,mwait=(nop|native|smart)" would fail if
> >   host KVM doesn't report the corresponding mwait behavior as
> >   supported
> > * "-cpu ...,mwait=(nop|native|smart),monitor=on" would work
> > * "-cpu ...,mwait=(nop|native|smart)" would also work, and
> >   probably should enable CPUID_EXT_MONITOR flag by default
> > 
> > We could still implement "monitor=force" for debugging, but I
> > think we need something safer than "just ignore what KVM is
> > telling us" for production.
> 
> I personally think we want the =force for any cpuid bit that we want to
> randomly poke into the expose CPUID bitmap and if a customer is daring
> enough, leave that to him as an option.
> 
> For anything else, I wouldn't overengineer this interface. I think
> eventually we want to just natively support emulated mwait with proper
> adaptive logic on when to trap vs execute mwait inside the guest (as
> mentioned in the kvm thread on this). Once that's implemented, KVM can just
> expose the MONITOR bit as supported and everyone gets it automatically.
> 
> If at that point, the adaptive interface performs much worse than the naive
> one, we can still think about pushing this into an enable_cap and add a
> specific mwait= option.

Sounds good to me.

I thought the user still had to choose between the options above
somehow, and that KVM was not going to return MONITOR on
GET_SUPPORTED_CPUID because of that. If getting adaptative logic
that's good enough to add MONITOR to GET_SUPPORTED_CPUID is still
a possibility, then that's even better.

-- 
Eduardo
