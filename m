Received: from eggs.gnu.org ([209.51.188.92]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwEfs-0004Tu-BU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwEfn-0002nX-Cu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:19:38 -0500
Date: Tue, 19 Feb 2019 18:19:30 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1590333482.2281318.1550618370282.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190219152040-mutt-send-email-mst@kernel.org>
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<a7eb2932-c72d-f9cf-c3c4-010f967ca743@redhat.com>
	<20190219152040-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang zhong <yang.zhong@intel.com>


> > Makes sense, but it is also abstraction time. :)  What if instead there
> > was a function
> > 
> > void msi_allocate_irqs(PCIDevice *pdev, int num, bool fallback_to_intx);
> > 
> > and then ich.c did
> > 
> >     irqs = msi_allocate_irqs(pdev, 1, true);
> >     s->irq = irqs[0];
> >     g_free(irqs);
> > 
> > ?  "if msi_enabled raise MSI else raise INTX" is really a common idiom.
> > 
> > Thanks,
> > 
> > Paolo
> 
> Maybe it is but the specific issue is not about fallback to INTX of PCI
> (is the fallback broken for ahci? I don't know).

It works, the above is just a new abstraction.

> The trick is there's no pdev at all.

The trick :) is that in ich.c there is a pdev.  Right now we are assigning to
s->irq either the INTX irq (if PCI) or a sysbus irq (if sysbus), but then
we need to know about MSI with a wrapper around s->irq.

Instead, my suggestion is to put the wrapper in the PCI core as a qemu_irq
callback---or perhaps in ich.c, but anyway ahci.c should not care that there
could be a PCI AHCI device and it would have two different interrupt modes.
In fact, doing this would also remove the need for s->container, I think.

Paolo
