Received: from eggs.gnu.org ([209.51.188.92]:58583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hK7zZ-0004nT-4H
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hK7zX-0003c7-QP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hK7zX-0003bX-Ki
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 608F38E3D4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 21:02:42 +0000 (UTC)
Date: Fri, 26 Apr 2019 15:02:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190426150236.1af2ff08@x1.home>
In-Reply-To: <20190426132744.2b594bf5@x1.home>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Fri, 26 Apr 2019 13:27:44 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 20 Dec 2018 13:40:35 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Starting from QEMU 4.0, let's specify "split" as the default value for
> > kernel-irqchip.
> > 
> > So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
> >    for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
> >    (omitting all the "kernel_irqchip_" prefix)
> > 
> > Note that this will let the default q35 machine type to depend on
> > Linux version 4.4 or newer because that's where split irqchip is
> > introduced in kernel.  But it's fine since we're boosting supported
> > Linux version for QEMU 4.0 to around Linux 4.5.  For more information
> > please refer to the discussion on AMD's RDTSCP:
> > 
> >   https://lore.kernel.org/lkml/20181210181328.GA762@zn.tnic/  
> 
> It looks like this broke INTx for vfio-pci, see:
> 
> https://bugs.launchpad.net/qemu/+bug/1826422
> 
> In my testing it looks like KVM advertises supporting the KVM_IRQFD
> resample feature, but vfio never gets the unmask notification, so the
> device remains with DisINTx set and no further interrupts are
> generated.  Do we expect KVM's IRQFD with resampler to work in the
> split IRQ mode?  We can certainly hope that "high performance" devices
> use MSI or MSI/X, but this would be quite a performance regression with
> split mode if our userspace bypass for INTx goes away.  Thanks,

arch/x86/kvm/lapic.c:kvm_ioapic_send_eoi() dumps to userspace before
kvm_ioapic_update_eoi() can handle the irq_ack_notifier_list via
kvm_notify_acked_gsi(), so it looks like KVM really ought to return an
error when trying to register a resample IRQFD when irqchip_split(),
but do we have better options?  EOI handling in QEMU is pretty much
non-existent and even if it was in place, it's a big performance
regression for vfio INTx handling.  Is a split irqchip that retains
performant resampling (EOI) support possible?  Thanks,

Alex
