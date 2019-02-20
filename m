Received: from eggs.gnu.org ([209.51.188.92]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwIg0-0000qh-1T
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwIfz-0006Sj-5O
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:36:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwIfy-0006M1-T4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:36:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id m9so1104235qkl.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 19:35:49 -0800 (PST)
Date: Tue, 19 Feb 2019 22:35:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190219222058-mutt-send-email-mst@kernel.org>
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<a7eb2932-c72d-f9cf-c3c4-010f967ca743@redhat.com>
	<20190219152040-mutt-send-email-mst@kernel.org>
	<1590333482.2281318.1550618370282.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590333482.2281318.1550618370282.JavaMail.zimbra@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang zhong <yang.zhong@intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, Feb 19, 2019 at 06:19:30PM -0500, Paolo Bonzini wrote:
> 
> > > Makes sense, but it is also abstraction time. :)  What if instead there
> > > was a function
> > > 
> > > void msi_allocate_irqs(PCIDevice *pdev, int num, bool fallback_to_intx);
> > > 
> > > and then ich.c did
> > > 
> > >     irqs = msi_allocate_irqs(pdev, 1, true);
> > >     s->irq = irqs[0];
> > >     g_free(irqs);
> > > 
> > > ?  "if msi_enabled raise MSI else raise INTX" is really a common idiom.
> > > 
> > > Thanks,
> > > 
> > > Paolo
> > 
> > Maybe it is but the specific issue is not about fallback to INTX of PCI
> > (is the fallback broken for ahci? I don't know).
> 
> It works, the above is just a new abstraction.
> 
> > The trick is there's no pdev at all.
> 
> The trick :) is that in ich.c there is a pdev.  Right now we are assigning to
> s->irq either the INTX irq (if PCI) or a sysbus irq (if sysbus), but then
> we need to know about MSI with a wrapper around s->irq.

Oh you mean just for PCI.

> Instead, my suggestion is to put the wrapper in the PCI core as a qemu_irq
> callback---or perhaps in ich.c, but anyway ahci.c should not care that there
> could be a PCI AHCI device and it would have two different interrupt modes.

I like it very much that devices call pci_set_irq, I'd rather not
have callbacks.


I think the wrapper thay calls either pci_set_irq isn't a problem,
problem is MSI/X has multiple vectors, INTX doesn't.
So for many devices there's something extra that happens
just in one mode but not the other to deal with multiple vectors.

So I don't think it can be an abstraction that everyone
uses. But yes it can be a helper function.

In fact mptsas_update_interrupt seems not to be
PCI spec compliant: it sets both MSI and INTX.

CC original contributor with this question.



> In fact, doing this would also remove the need for s->container, I think.
> 
> Paolo
