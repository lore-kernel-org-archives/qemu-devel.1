Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW2KU-0005bj-Hi
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW2KT-00087n-Q7
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:44:14 -0500
Date: Tue, 24 Jan 2017 16:44:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124164204-mutt-send-email-mst@kernel.org>
References: <1485132904-17632-1-git-send-email-zhaoshenglong@huawei.com>
	<20170123180247-mutt-send-email-mst@kernel.org>
	<49fcc1e0-f439-9212-25f1-9b8dce6462cc@redhat.com>
	<20170123190257-mutt-send-email-mst@kernel.org>
	<5760ee8c-f567-0dfd-456f-65f8957b22e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5760ee8c-f567-0dfd-456f-65f8957b22e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] virtio: Fix no interrupt when not
 creating msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org

On Tue, Jan 24, 2017 at 10:25:00AM +0100, Paolo Bonzini wrote:
> 
> 
> On 23/01/2017 18:04, Michael S. Tsirkin wrote:
> >> For virtio-blk, my patch moved the setting of ISR from
> >> virtio_queue_guest_notifier_read to virtio_notify_irqfd.  This is
> >> because the irqfd emulation only needs to trigger the interrupt.
> >> Setting the ISR should have been done elsewhere.
> >>
> >> Can vhost set ISR (I thought it couldn't)?  If so, it seems like ARM was
> >> relying on QEMU's irqfd emulation, as a work around for vhost not
> >> setting ISR.  But this only works if irqfd is directed to QEMU and not
> >> to KVM.  So if vhost cannot set ISR, I think vhost should be disabled
> >> unless MSI is active.
> >>
> >> Am I missing something?
> >
> > vhost doesn't set ISR ATM.  Without MSI we are always bouncing
> > interrupts through QEMU in particular in order to set ISR.
> 
> Where is the code that disables KVM irqfd?
> 
> Paolo


This bit in virtio_pci_set_guest_notifiers does the trick I think:


    bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
        kvm_msi_via_irqfd_enabled();

I don't think we ever used irqfd for level interrupts.

> > Disabling vhost when user requested it was what we did
> > at some point but this just confused people.
> > 
> > 
