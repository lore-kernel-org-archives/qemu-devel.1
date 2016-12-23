Received: from eggs.gnu.org ([2001:4830:134:3::10]:44580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKNvT-0008AE-VJ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cKNvT-0004dm-21
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:22:15 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:32949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cKNvS-0004db-Ks
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 06:22:14 -0500
Received: by mail-ua0-x22d.google.com with SMTP id i68so5295599uad.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 03:22:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222094240.GA26435@pxdev.xzpeter.org>
References: <20161222094240.GA26435@pxdev.xzpeter.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Dec 2016 11:21:53 +0000
Message-ID: <CAFEAcA-6CtHq7w-i=_X9zbBsKeKD1sLsWGze4hgw14er_sd9Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] A question about PCI device address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 22 December 2016 at 09:42, Peter Xu <peterx@redhat.com> wrote:
> Hello,
>
> Since this is a general topic, I picked it out from the VT-d
> discussion and put it here, just want to be more clear of it.
>
> The issue is, whether we have exposed too much address spaces for
> emulated PCI devices?
>
> Now for each PCI device, we are having PCIDevice::bus_master_as for
> the device visible address space, which derived from
> pci_device_iommu_address_space():
>
> AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> {
>     PCIBus *bus = PCI_BUS(dev->bus);
>     PCIBus *iommu_bus = bus;
>
>     while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
>         iommu_bus = PCI_BUS(iommu_bus->parent_dev->bus);
>     }
>     if (iommu_bus && iommu_bus->iommu_fn) {
>         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->devfn);
>     }
>     return &address_space_memory;
> }
>
> By default (for no-iommu case), it's pointed to system memory space,
> which includes MMIO, and looks wrong - PCI device should not be able to
> write to MMIO regions.

This is just legacy, I think, ie a combination of "this used to
be system memory space so let's not break things" and "PC works
mostly like this". It should be possible for the PCI host bridge
emulation to set things up so that the device's visible address
space is whatever it feels like. The PCI APIs we have for doing
this have "iommu" in the name but they work just as well even
if the host bridge doesn't actually have an iommu and is just
setting up a fixed or slightly configurable mapping.
I think it just hasn't been implemented because for guests which
aren't misbehaving it doesn't make any difference.

thanks
-- PMM
