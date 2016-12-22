Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK0YE-0000Le-Iv
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK0Y9-0002oJ-Kw
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:24:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK0Y9-0002nM-Bu
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:24:37 -0500
References: <20161222094240.GA26435@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0e0370f-c3ac-9591-c0aa-27f0db88d864@redhat.com>
Date: Thu, 22 Dec 2016 11:24:33 +0100
MIME-Version: 1.0
In-Reply-To: <20161222094240.GA26435@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] A question about PCI device address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>



On 22/12/2016 10:42, Peter Xu wrote:
> Hello,
>=20
> Since this is a general topic, I picked it out from the VT-d
> discussion and put it here, just want to be more clear of it.
>=20
> The issue is, whether we have exposed too much address spaces for
> emulated PCI devices?
>=20
> Now for each PCI device, we are having PCIDevice::bus_master_as for
> the device visible address space, which derived from
> pci_device_iommu_address_space():
>=20
> AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> {
>     PCIBus *bus =3D PCI_BUS(dev->bus);
>     PCIBus *iommu_bus =3D bus;
>=20
>     while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
>         iommu_bus =3D PCI_BUS(iommu_bus->parent_dev->bus);
>     }
>     if (iommu_bus && iommu_bus->iommu_fn) {
>         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->d=
evfn);
>     }
>     return &address_space_memory;
> }
>=20
> By default (for no-iommu case), it's pointed to system memory space,
> which includes MMIO, and looks wrong - PCI device should not be able to
> write to MMIO regions.

Hmm, I think that unless you describe that with ACS, PCI devices should
be able to write to MMIO regions.  Possibly not _all_ of them, I don't
know (maybe they cannot write to MMCONFIG?) but after all they can write
to the MSI region, and that is an MMIO region.

If the IOMMU translate callback included the MemTxAttrs, ACS Source
Validation could probably be implemented with an IOMMU region on the
root complex.  Most of the other ACS features either do not apply, or
they are already implicit in the way that all PCI devices' address
spaces are based on address_space_memory.

Paolo

> As an example, if we dump a PCI device address space into detail on
> x86_64 system, we can see (this is address space for a virtio-net-pci
> device on an Q35 machine with 6G memory):
>=20
>     0000000000000000-000000000009ffff (prio 0, RW): pc.ram
>     00000000000a0000-00000000000affff (prio 1, RW): vga.vram
>     00000000000b0000-00000000000bffff (prio 1, RW): vga-lowmem
>     00000000000c0000-00000000000c9fff (prio 0, RW): pc.ram
>     00000000000ca000-00000000000ccfff (prio 0, RW): pc.ram
>     00000000000cd000-00000000000ebfff (prio 0, RW): pc.ram
>     00000000000ec000-00000000000effff (prio 0, RW): pc.ram
>     00000000000f0000-00000000000fffff (prio 0, RW): pc.ram
>     0000000000100000-000000007fffffff (prio 0, RW): pc.ram
>     00000000b0000000-00000000bfffffff (prio 0, RW): pcie-mmcfg-mmio
>     00000000fd000000-00000000fdffffff (prio 1, RW): vga.vram
>     00000000fe000000-00000000fe000fff (prio 0, RW): virtio-pci-common
>     00000000fe001000-00000000fe001fff (prio 0, RW): virtio-pci-isr
>     00000000fe002000-00000000fe002fff (prio 0, RW): virtio-pci-device
>     00000000fe003000-00000000fe003fff (prio 0, RW): virtio-pci-notify
>     00000000febd0400-00000000febd041f (prio 0, RW): vga ioports remappe=
d
>     00000000febd0500-00000000febd0515 (prio 0, RW): bochs dispi interfa=
ce
>     00000000febd0600-00000000febd0607 (prio 0, RW): qemu extended regs
>     00000000febd1000-00000000febd102f (prio 0, RW): msix-table
>     00000000febd1800-00000000febd1807 (prio 0, RW): msix-pba
>     00000000febd2000-00000000febd2fff (prio 1, RW): ahci
>     00000000fec00000-00000000fec00fff (prio 0, RW): kvm-ioapic
>     00000000fed00000-00000000fed003ff (prio 0, RW): hpet
>     00000000fed1c000-00000000fed1ffff (prio 1, RW): lpc-rcrb-mmio
>     00000000fee00000-00000000feefffff (prio 4096, RW): kvm-apic-msi
>     00000000fffc0000-00000000ffffffff (prio 0, R-): pc.bios
>     0000000100000000-00000001ffffffff (prio 0, RW): pc.ram
>=20
> So here are the "pc.ram" regions the only ones that we should expose
> to PCI devices? (it should contain all of them, including the low-mem
> ones and the >=3D4g one)
>=20
> And, should this rule work for all platforms? Or say, would it be a
> problem if I directly change address_space_memory in
> pci_device_iommu_address_space() into something else, which only
> contains RAMs? (of course this won't affect any platform that has
> IOMMU, aka, customized PCIBus::iommu_fn function)
>=20
> (btw, I'd appreciate if anyone has quick answer on why we have lots of
>  continuous "pc.ram" in low 2g range - from can_merge() I guess they
>  seem to have different dirty_log_mask, romd_mode, etc., but I still
>  would like to know why they are having these difference. Anyway, this
>  is totally an "optional question" just to satisfy my own curiosity :)
>=20
> Thanks,
>=20
> -- peterx
>=20
