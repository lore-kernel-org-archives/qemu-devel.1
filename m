Received: from eggs.gnu.org ([209.51.188.92]:50169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwBvZ-0006y4-Ug
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwBvZ-0002jV-3x
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:23:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwBvY-0002h9-Ts
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 15:23:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so24695395qtc.10
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:23:35 -0800 (PST)
Date: Tue, 19 Feb 2019 15:23:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190219152040-mutt-send-email-mst@kernel.org>
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<a7eb2932-c72d-f9cf-c3c4-010f967ca743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7eb2932-c72d-f9cf-c3c4-010f967ca743@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com

On Tue, Feb 19, 2019 at 07:24:40PM +0100, Paolo Bonzini wrote:
> On 19/02/19 17:07, Thomas Huth wrote:
> > Some machines have an AHCI adapter, but no PCI. To be able to
> > compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> > functions msi_enabled() and msi_notify() for linking.
> > This is required for the upcoming Kconfig-like build system, if
> > a user wants to compile a QEMU binary with just one machine that
> > has AHCI, but no PCI, like the ARM "cubieboard" for example.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/pci/pci-stub.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> > index b941a0e..c04a5df 100644
> > --- a/hw/pci/pci-stub.c
> > +++ b/hw/pci/pci-stub.c
> > @@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
> >      g_assert(false);
> >      return 0;
> >  }
> > +
> > +/* Required by ahci.c */
> > +bool msi_enabled(const PCIDevice *dev)
> > +{
> > +    return false;
> > +}
> > +
> > +void msi_notify(PCIDevice *dev, unsigned int vector)
> > +{
> > +    g_assert_not_reached();
> > +}
> > 
> 
> Makes sense, but it is also abstraction time. :)  What if instead there
> was a function
> 
> void msi_allocate_irqs(PCIDevice *pdev, int num, bool fallback_to_intx);
> 
> and then ich.c did
> 
>     irqs = msi_allocate_irqs(pdev, 1, true);
>     s->irq = irqs[0];
>     g_free(irqs);
> 
> ?  "if msi_enabled raise MSI else raise INTX" is really a common idiom.
> 
> Thanks,
> 
> Paolo

Maybe it is but the specific issue is not about fallback to INTX of PCI
(is the fallback broken for ahci? I don't know).
The trick is there's no pdev at all.

-- 
MST
