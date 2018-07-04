Received: from eggs.gnu.org ([2001:4830:134:3::10]:60449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1fak3M-0007jl-Cp
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1fak3J-0000pW-8n
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:50:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47128
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1fak3J-0000pJ-2x
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:50:45 -0400
Date: Wed, 4 Jul 2018 16:51:24 +0100
From: Will Deacon <will.deacon@arm.com>
Message-ID: <20180704155123.GO4828@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
	<20180704142241.GG4828@arm.com>
	<8636wzysfl.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8636wzysfl.wl-marc.zyngier@arm.com>
Subject: Re: [Qemu-devel] [kvmtool test PATCH 24/24] kvmtool: arm: Add
 support for creating VM with PA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 03:41:18PM +0100, Marc Zyngier wrote:
> On Wed, 04 Jul 2018 15:22:42 +0100,
> Will Deacon <will.deacon@arm.com> wrote:
> > 
> > On Fri, Jun 29, 2018 at 12:15:44PM +0100, Suzuki K Poulose wrote:
> > > diff --git a/arm/kvm.c b/arm/kvm.c
> > > index 5701d41..b1969be 100644
> > > --- a/arm/kvm.c
> > > +++ b/arm/kvm.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/kvm.h>
> > >  #include <linux/sizes.h>
> > >  
> > > +unsigned long kvm_arm_type;
> > > +
> > >  struct kvm_ext kvm_req_ext[] = {
> > >  	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
> > >  	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
> > > @@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
> > >  	{ 0, 0 },
> > >  };
> > >  
> > > +#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
> > > +#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
> > > +#endif
> > > +
> > > +void kvm__arch_init_hyp(struct kvm *kvm)
> > > +{
> > > +	int max_ipa;
> > > +
> > > +	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
> > > +	if (max_ipa < 0)
> > > +		max_ipa = 40;
> > > +	if (!kvm->cfg.arch.phys_shift)
> > > +		kvm->cfg.arch.phys_shift = 40;
> > > +	if (kvm->cfg.arch.phys_shift > max_ipa)
> > > +		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
> > > +		    kvm->cfg.arch.phys_shift, max_ipa);
> > > +	if (kvm->cfg.arch.phys_shift != 40)
> > > +		kvm_arm_type = kvm->cfg.arch.phys_shift;
> > > +}
> > 
> > Seems a bit weird that the "machine type identifier" to KVM_CREATE_VM is
> > dedicated entirely to holding the physical address shift verbatim. Is this
> > really the ABI?
> > 
> > Also, couldn't KVM figure it out automatically if you add memslots at high
> > addresses, making this a niche tunable outside of testing?
> 
> Not really. Let's say I want my IPA space split in two: memory covers
> the low 47 bit, and I want MMIO spanning the top 47 bit. With your
> scheme, you'd end-up with a 47bit IPA space, while you really want 48
> bits (MMIO space implemented by userspace isn't registered to the
> kernel).

That still sounds quite niche for a VM. Does QEMU do that? In any case,
having KVM automatically increase the IPA bits to cover the memslots it
knows about would make sense to me, and also be sufficient for kvmtool
without us having to add an extra command-line argument.

The MMIO case might be better dealt with by having a way to register MMIO
regions rather than having the PA bits exposed directly.

Will
