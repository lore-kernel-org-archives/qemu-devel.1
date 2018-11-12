Received: from eggs.gnu.org ([2001:4830:134:3::10]:47857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gM9AJ-0008Ct-Gq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gM9AF-0003gi-46
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:09:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1gM9AE-0003f1-Mq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:09:51 -0500
Date: Mon, 12 Nov 2018 11:09:39 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181112100939.vro42goghcv7v6l2@kamzik.brq.redhat.com>
References: <1540290099-146109-1-git-send-email-mjaggi@caviumnetworks.com>
	<4bbb4e76-b714-eafe-f95b-aca1a258e9fe@caviumnetworks.com>
	<86o9avetgz.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o9avetgz.wl-marc.zyngier@arm.com>
Subject: Re: [Qemu-devel] [RFC] [PATCH] kvm: arm: Introduce error code
 KVM_EINVARIANT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Manish Jaggi <mjaggi@caviumnetworks.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Christoffer Dall <christoffer.dall@arm.com>, "quintela@redhat.com" <quintela@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

On Sun, Nov 11, 2018 at 11:36:44AM +0000, Marc Zyngier wrote:
> On Sat, 10 Nov 2018 22:18:47 +0000,
> Manish Jaggi <mjaggi@caviumnetworks.com> wrote:
> > 
> > 
> > CCing a larger audience.
> > Please review.
> > 
> > On 10/23/2018 03:51 PM, Jaggi, Manish wrote:
> > > From: Manish Jaggi <manish.jaggi@cavium.com>
> > >
> > > This patch introduces an error code KVM_EINVARIANT which is returned
> > > by KVM when userland tries to set an invariant register.
> > >
> > > The need for this error code is in VM Migration for arm64.
> > > ARM64 systems use mainly -machine virt -cpu host as parameter to qemu.
> > > Migration requires both Source and destination machines to have same
> > > physical cpu. There are cases where the overall architecture of CPU is
> > > same but the next version of the chip with some bug fixes which have no
> > > effect on qemu operation. In such cases invariant registers like MIDR
> > > have a different value.
> > > Currently Migration fails in such cases.
> > >
> > > Rather than sending a EINVAL, a specifc error code will help
> > > userland program the guest invariant register by querying the migrated
> > > host machines invariant registers.
> 
> But failing migration is a good thing, right? How do you expect that
> the guest will be happy to see a new CPU revision right in the middle
> of its execution? Do you also propose that QEMU starts doing that for
> big-little systems? After all, if ignoring the differences in some
> registers is harmless for migration, surely that should be the case in
> a single system, right?
> 
> > >
> > > Qemu will have a parameter -hostinvariant along with checking of this
> > > error code. So it can be safely assumed that the feature is opt-in
> 
> You're changing the ABI without any buy in from userspace, which is
> not acceptable.
> 
> As it stands, this patch creates a number of issues without solving
> any. Things to think about:
> 
> - How does errata management works when migrating to a different
>   system?
> - big-little, as mentioned above
> - Are all invariant registers equal? A different MIDR has the same
>   effect as a different MMFR0?
> 
> Instead of papering over architectural constants i a system, how about
> allowing the relevant ID registers to be overloaded when not
> incompatible?
> 

In QEMU, I think we need nail down how we define '-cpu host' for kvmarm.
IMO, '-cpu host' is what libvirt calls "host-passthrough"[*], and indeed
migrating a guest using host-passthrough is super risky. You need to
know what you're doing, and likely what you'll want to do is migrate to
an _identical_ host. We should start looking at building cpu models to
better support migration, but errata complicates that. However, for the
sake of argument, let's assume we solved those problems and completed the
implementation of cpu models - so we would no longer be using '-cpu host'
for a "typical" config. So what would '-cpu host' mean? It appears the
current semantics are "source host passthrough", similar to
"host-model"[*]. Rather than "whatever host I'm running on host
passthrough", which is what I think we want and what this patch and the
QEMU counterpart changes seem to be aiming at implementing. Anyway,
whichever of those two semantics we choose for '-cpu host', the user will
still need to know what they're doing and to assume the risks. Without
cpu models, I'm not even sure discussing migration safety makes sense.

(Yeah, I know I ignored big-little. IMO, big-little is an upper layer
problem, as it should just be a vcpu thread to cpu set affinity
assignment issue.)

Thanks,
drew

[*] https://wiki.openstack.org/wiki/LibvirtXMLCPUModel
