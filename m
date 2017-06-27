Received: from eggs.gnu.org ([2001:4830:134:3::10]:47427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dPrVl-00060W-2N
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dPrVk-0008Mm-0p
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:30:37 -0400
Date: Tue, 27 Jun 2017 16:30:26 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170627143026.3k5gno27afem33v6@kamzik.brq.redhat.com>
References: <1498512656-75289-1-git-send-email-agraf@suse.de>
	<20170627123718.mdfn3o7heu6v7x6n@kamzik.brq.redhat.com>
	<b627df63-9ac1-49ff-931d-74c88d9d7ed5@suse.de>
	<20170627135951.ztukjadpnervqoly@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627135951.ztukjadpnervqoly@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ARM: KVM: Enable in-kernel timers with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, cdall@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jun 27, 2017 at 03:59:51PM +0200, Andrew Jones wrote:
> On Tue, Jun 27, 2017 at 03:00:10PM +0200, Alexander Graf wrote:
> > > > +        /* XXX PMU IRQ is missing */
> > > 
> > > So I was wondering why you chose not to wire up the PMU in order to finish
> > 
> > Because the PMU IRQ is only available from the machine file, so it'll need
> > some more plumbing to get the qemu_irq object available from kvm.c.
> 
> OK, I just wrote a patch based on this patch for the PMU and will post it
> in a second.
> 
> > 
> > > this off, since I knew KVM has commit 3dbbdf78636e "KVM: arm/arm64: Report
> > > PMU overflow interrupts to userspace irqchip", which I presume should
> > > allow the PMU to work too. However, attempting to start a guest with
> > > -machine virt,accel=kvm,kernel-irqchip=off -cpu host,pmu=on doesn't provide
> > > it a PMU. AFAICT, that's only because KVM still has
> > > 
> > >          /*
> > >           * We currently require an in-kernel VGIC to use the PMU emulation,
> > >           * because we do not support forwarding PMU overflow interrupts to
> > >           * userspace yet.
> > >           */
> > >          if (!irqchip_in_kernel(vcpu->kvm) || !vgic_initialized(vcpu->kvm))
> > >                  return -ENODEV;
> > > 
> > > in kvm_arm_pmu_v3_init(). Anyone know why that wasn't removed with
> > > 3dbbdf78636e?

Eh, I missed a2befacf5094 "KVM: arm64: Allow creating the PMU without the
in-kernel GIC", which is still in kvmarm/queue, not yet in Linus master.
I'll have to revisit the QEMU patch I wrote to make sure it still makes
sense.

drew
