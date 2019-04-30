Received: from eggs.gnu.org ([209.51.188.92]:58804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hLblH-00056X-P4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hLblE-0002VO-QO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hLblC-0002SC-GO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 482E38666E
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 23:01:55 +0000 (UTC)
Date: Tue, 30 Apr 2019 17:01:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190430170149.6c82398a@x1.home>
In-Reply-To: <20190429082106.4fd59e77@x1.home>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S .
	Tsirkin" <mst@redhat.com>

On Mon, 29 Apr 2019 08:21:06 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Sat, 27 Apr 2019 10:09:51 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 27/04/19 07:29, Paolo Bonzini wrote:  
> > >     
> > >>> In my testing it looks like KVM advertises supporting the KVM_IRQFD
> > >>> resample feature, but vfio never gets the unmask notification, so the
> > >>> device remains with DisINTx set and no further interrupts are
> > >>> generated.  Do we expect KVM's IRQFD with resampler to work in the
> > >>> split IRQ mode?  We can certainly hope that "high performance" devices
> > >>> use MSI or MSI/X, but this would be quite a performance regression with
> > >>> split mode if our userspace bypass for INTx goes away.  Thanks,    
> > >>
> > >> arch/x86/kvm/lapic.c:kvm_ioapic_send_eoi() dumps to userspace before
> > >> kvm_ioapic_update_eoi() can handle the irq_ack_notifier_list via
> > >> kvm_notify_acked_gsi(),    
> > > 
> > > That wouldn't help because kvm_ioapic_update_eoi would not even be
> > > able to access vcpu->kvm->arch.vioapic (it's NULL).
> > > 
> > > The following untested patch would signal the resamplefd in kvm_ioapic_send_eoi,
> > > before requesting the exit to userspace.  However I am not sure how QEMU
> > > sets up the VFIO eventfds: if I understand correctly, when VFIO writes again to
> > > the irq eventfd, the interrupt request would not reach the userspace IOAPIC, but
> > > only the in-kernel LAPIC.  That would be incorrect, and if my understanding is
> > > correct we need to trigger resampling from hw/intc/ioapic.c.    
> > 
> > Actually it's worse: because you're bypassing IOAPIC when raising the
> > irq, the IOAPIC's remote_irr for example will not be set.  So split
> > irqchip currently must disable the intx fast path completely.
> > 
> > I guess we could also reimplement irqfd and resamplefd in the userspace
> > IOAPIC, and run the listener in a separate thread (using "-object
> > iothread" on the command line and AioContext in the code).  
> 
> This sounds like a performance regression vs KVM irqchip any way we
> slice it.  Was this change a mistake?  Without KVM support, the
> universal support in QEMU kicks in, where device mmaps are disabled
> when an INTx occurs, forcing trapped access to the device, and we
> assume that the next access is in response to an interrupt and trigger
> our own internal EOI and re-enable mmaps.  A timer acts as a
> catch-all.  Needless to say, this is functional but not fast.  It would
> be a massive performance regression for devices depending on INTx and
> previously using the KVM bypass to switch to this.  INTx is largely
> considered a legacy interrupt, so non-x86 archs don't encounter it as
> often, S390 even explicitly disables INTx support.  ARM and POWER
> likely just don't see a lot of these devices, but nearly all devices
> (except SR-IOV VFs) on x86 expect an INTx fallback mode and some
> drivers may run the device in INTx for compatibility.  This split
> irqchip change was likely fine for "enterprise" users concerned only
> with modern high speed devices, but very much not for device assignment
> used for compatibility use cases or commodity hardware users.
> 
> What's a good 4.0.1 strategy to resolve this?  Re-instate KVM irqchip
> as the Q35 default?  I can't see that simply switching to current QEMU
> handling is a viable option for performance?  What about 4.1?  We could
> certainly improve EOI support in QEMU, there's essentially no support
> currently, but it seems like an uphill battle for an iothread based
> userspace ioapic to ever compare to KVM handling?  Thanks,

Poking at this a bit, we can add kvm_irqchip_is_split() to the set of
things we test for in hw/vfio/pci.c:vfio_intx_enable_kvm() to avoid the
KVM INTx bypass when using split IRQ chip.  This at least avoids paths
that cannot work currently.  We'll fall back to vfio's universal EOI
detection of toggling direct mapped MemoryRegions, which is enough for
simple devices like NICs.  However, it's barely functional with an
NVIDIA GeForce card assigned to a Windows VM, it only takes a graphics
test program to send it over the edge and trigger a TDR.  Even with TDR
disabled, the VM will hang.  I also played with ioapic_eoi_broadcast()
calling directly into vfio code to trigger the EOI (without the mmap
toggling), it's even worse, Windows can't even get to the desktop
before it hangs.

So while I was initially impressed that netperf TCP_RR results for a
gigabit NIC were not that different between in-kernel ioapic and split
irqchip, the graphics results have me again wondering why we made this
change and how userspace handling can get us back to a functional level.

The only way I can get the GPU/Windows configuration usable is to
assert the IRQ, immediately de-assert, and unmask the device all from
vfio_intx_interrupt().  An interrupt intensive graphics benchmark runs
at ~80% of KVM irqchip with about 10% more CPU load with this
experiment (but it actually runs!).  Potentially some devices could
mimic INTx using MSI, like legacy KVM device assignment used to do with
this mode, eliminating the unmask ioctl, but even the legacy driver
noted compatibility issues with that mode and neither is a good
reproduction of how INTx is supposed to work.

Any other insights appreciated, and I really would like to understand
what we've gained with split irqchip and whether it's worth this.
Thanks,

Alex
