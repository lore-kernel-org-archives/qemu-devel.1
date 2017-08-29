Received: from eggs.gnu.org ([2001:4830:134:3::10]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmhG7-0005P8-7c
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmhG4-0007aO-HM
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:12:51 -0400
Date: Tue, 29 Aug 2017 11:12:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170829141236.GX15315@localhost.localdomain>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-2-david@gibson.dropbear.id.au>
	<20170426182155-mutt-send-email-mst@kernel.org>
	<20170829114239.GP2578@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829114239.GP2578@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC for-2.10 1/3] pci/pcie: Make a consistent
 helper for switching PCI/PCIe "hybrid" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, marcel@redhat.com, lersek@redhat.com

On Tue, Aug 29, 2017 at 09:42:39PM +1000, David Gibson wrote:
> On Wed, Apr 26, 2017 at 06:23:58PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Mar 28, 2017 at 01:16:49PM +1100, David Gibson wrote:
> > > virtio-pci and XHCI are "hybrid" devices in the sense that they can present
> > > themselves as either PCIe or plain PCI devices depending on the machine
> > > and bus they're connected to.
> > > 
> > > For virtio-pci to present as PCIe it requires that it's connected to a PCIe
> > > bus and that it's not a root bus - this is to ensure that the device is
> > > connected via a PCIe root port or downstream port rather than being a
> > > integrated endpoint.  Some guests (Windows in particular AIUI) don't really
> > > cope with PCIe integrated endpoints.
> > > 
> > > For XHCI it only checks that the bus is PCIe, but that probably means it
> > > would cause problems if attached as an integrated devices directly to a
> > > PCIe root bus.
> > > 
> > > This patch makes the test consistent between XHCI and virtio-pci, and
> > > clarifies things by having them both use a new 'pci_allow_hybrid_pcie()'
> > > helper which performs the same check as virtio-pci.
> > > 
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/pci/pci.c           | 7 +++++++
> > >  hw/usb/hcd-xhci.c      | 2 +-
> > >  hw/virtio/virtio-pci.c | 3 +--
> > >  include/hw/pci/pci.h   | 1 +
> > >  4 files changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index bd8043c..779787b 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -390,6 +390,13 @@ bool pci_bus_is_root(PCIBus *bus)
> > >      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> > >  }
> > >  
> > > +bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
> > > +{
> > > +    PCIBus *bus = pci_dev->bus;
> > > +
> > > +    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > > +}
> > > +
> > >  void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
> > >                           const char *name,
> > >                           MemoryRegion *address_space_mem,
> > 
> > I'd prefer pci_allow_hybrid_pci_pcie.
> 
> Ok, I've made that change for the next spin (aimed at 2.11, obviously).

I'm a bit confused by the naming: by looking at the function
name, I don't know if "allow hybrid" means "this bus+device can
(also) work as Conventional PCI" or "this bus+device can (also)
work as PCI Express".

What about just naming it pci_allow_pcie() or
pci_bus_allow_pcie()?  It looks like the function doesn't care if
the device is hybrid or PCIe-only: it's only checking if the
device can work as PCIe on that bus.  It's up to the device to
decide if it should switch to Conventional PCI or report an error
if the function returns false.

> 
> > 
> > > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > > index f0af852..a7ff4fd 100644
> > > --- a/hw/usb/hcd-xhci.c
> > > +++ b/hw/usb/hcd-xhci.c
> > > @@ -3619,7 +3619,7 @@ static void usb_xhci_realize(struct PCIDevice *dev, Error **errp)
> > >                       PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64,
> > >                       &xhci->mem);
> > >  
> > > -    if (pci_bus_is_express(dev->bus) ||
> > > +    if (pci_allow_hybrid_pcie(dev) ||
> > >          xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
> > >          ret = pcie_endpoint_cap_init(dev, 0xa0);
> > >          assert(ret >= 0);
> > 
> > This seems to change the behaviour for xhci on a root bus - what
> > am I missing?
> 
> Nothing.  I didn't consider the backwards compat implications; I'll
> fix it for the next spin.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Eduardo
