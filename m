Received: from eggs.gnu.org ([2001:4830:134:3::10]:53099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cLP9z-0007Ip-GB
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 01:53:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cLP9w-0004xP-FG
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 01:53:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cLP9w-0004wi-9s
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 01:53:24 -0500
Date: Mon, 26 Dec 2016 14:53:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161226065316.GB4295@pxdev.xzpeter.org>
References: <20161222094240.GA26435@pxdev.xzpeter.org>
	<CAFEAcA-6CtHq7w-i=_X9zbBsKeKD1sLsWGze4hgw14er_sd9Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-6CtHq7w-i=_X9zbBsKeKD1sLsWGze4hgw14er_sd9Vw@mail.gmail.com>
Subject: Re: [Qemu-devel] A question about PCI device address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Dec 23, 2016 at 11:21:53AM +0000, Peter Maydell wrote:
> On 22 December 2016 at 09:42, Peter Xu <peterx@redhat.com> wrote:
> > Hello,
> >
> > Since this is a general topic, I picked it out from the VT-d
> > discussion and put it here, just want to be more clear of it.
> >
> > The issue is, whether we have exposed too much address spaces for
> > emulated PCI devices?
> >
> > Now for each PCI device, we are having PCIDevice::bus_master_as for
> > the device visible address space, which derived from
> > pci_device_iommu_address_space():
> >
> > AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> > {
> >     PCIBus *bus = PCI_BUS(dev->bus);
> >     PCIBus *iommu_bus = bus;
> >
> >     while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> >         iommu_bus = PCI_BUS(iommu_bus->parent_dev->bus);
> >     }
> >     if (iommu_bus && iommu_bus->iommu_fn) {
> >         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
> >     }
> >     return &address_space_memory;
> > }
> >
> > By default (for no-iommu case), it's pointed to system memory space,
> > which includes MMIO, and looks wrong - PCI device should not be able to
> > write to MMIO regions.
> 
> This is just legacy, I think, ie a combination of "this used to
> be system memory space so let's not break things" and "PC works
> mostly like this". It should be possible for the PCI host bridge
> emulation to set things up so that the device's visible address
> space is whatever it feels like. The PCI APIs we have for doing
> this have "iommu" in the name but they work just as well even
> if the host bridge doesn't actually have an iommu and is just
> setting up a fixed or slightly configurable mapping.
> I think it just hasn't been implemented because for guests which
> aren't misbehaving it doesn't make any difference.

Hmm, yes I see ppc e500 is using that for setting up its own address
space, possibly x86 can leverage it too when we really need this. For
now, I see no strong reason for this enhancement, so let me keep it as
it is, and wait until we have both a strong reason and a PCI guru.

Thank you for your answer! (to Paolo/David as well)

-- peterx
