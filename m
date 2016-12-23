Received: from eggs.gnu.org ([2001:4830:134:3::10]:54516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cKDKS-0007wQ-03
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 19:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cKDKO-0005Sg-R5
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 19:03:20 -0500
Received: from ozlabs.org ([103.22.144.67]:38923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cKDKN-0005NJ-QB
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 19:03:16 -0500
Date: Fri, 23 Dec 2016 11:02:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161223000228.GF14282@umbus.fritz.box>
References: <20161222094240.GA26435@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <20161222094240.GA26435@pxdev.xzpeter.org>
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
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2016 at 05:42:40PM +0800, Peter Xu wrote:
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
>         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->dev=
fn);
>     }
>     return &address_space_memory;
> }
>=20
> By default (for no-iommu case), it's pointed to system memory space,
> which includes MMIO, and looks wrong - PCI device should not be able to
> write to MMIO regions.

Sorry, I've realized my earlier comments were a bit misleading.

I'm pretty sure the inbound (=3D=3DDMA) window(s) will be less than the
full 64-bit address space.  However, that doesn't necessarily mean it
won't cover *any* MMIO.

Plus, of course, any MMIO that's provided by PCI (or legacy ISA)
devices - and on the PC platform, that's nearly everything - will also
be visible in PCI space, since it doesn't need to go through the
inbound window for that at all.  Strictly speaking PCI-provided MMIO
may not appear at the same address in PCI space as it does in the
system memory space, but for PC they will be.  By platform convention
the outbound windows are also identity mappings.

Part of the reason I was misleading was that I was thinking of non-PC
platforms, which often have more "native" MMIO devices on the CPU side
of of the PCI host bridge.

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
>     00000000febd0400-00000000febd041f (prio 0, RW): vga ioports remapped
>     00000000febd0500-00000000febd0515 (prio 0, RW): bochs dispi interface
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

No, the arragement of both inbound and outbound windows is certainly
platform dependent (strictly speaking, dependent on the model and
configuration of the host bridge, but that tends to be tied strongly
to the platform).  I think address_space_memory is the closest
approximation we're going to get that works for multiple platforms -
having both inbound and outbound windows identity mapped is pretty
common, I believe, even if they don't strictly speaking cover the
whole address space.

> (btw, I'd appreciate if anyone has quick answer on why we have lots of
>  continuous "pc.ram" in low 2g range - from can_merge() I guess they
>  seem to have different dirty_log_mask, romd_mode, etc., but I still
>  would like to know why they are having these difference. Anyway, this
>  is totally an "optional question" just to satisfy my own curiosity :)

I don't know PC well enough to be sure, but I suspect those low
regions have special meaning for the BIOS.

Note also the large gap between the pc.ram at 1M..2G and 4G..up.  This
is the so-called "memory hole".  You'll notice that all the IO regions
are in that range - that's for backwards compatibility with
32-bit machines where there was obviously nowhere else to put them.
Many 64-bit native platforms (including PAPR) don't have such a thing
and instead have RAM contiguous at 0 and the IO well above 4G in CPU
address space.

The PC PCI host bridge must clearly have an outgoing IO window from
2G..4G (mapping to the same addresses in PCI space) to handle these
devices.  I'm pretty sure there must also be another window much
higher up, to handle 64-bit PCI devices with really big BARs (which
you probably don't have any of on your example system).

Whaet I don't know is whether the 2G..4G range in PCI space will be
specifically excluded from the incoming (DMA) windows on the host
bridge.  It might be that it is, or it might just be that the host
bridge will forward things to the CPU bus only if they don't get
picked up by a device BAR first.  And I guess it's further complicated
by the fact that on PCI-E "up-bound" and "down-bound" transactions can
be distinguished, and the fact that at least some PCI-to-PCI or
PCIe-to-PCI bridges also have configurable inbound and outbound
windows.  I'm not sure if that includes the implicit bridges in PCIe
root ports or switch ports.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYXGmSAAoJEGw4ysog2bOSYscP/1GUXwvc6qoV+2fpCV2qmgdN
BX14+IFwllcp2wg6nzNwPATC1d8pLeZLQ+vr0gBiaj3fYMUHhzGABbZL9VtNoOex
GjuJCB3X/HSF3+UrEUEH0+Nrp0Y4R/r3Zyd+gqUvqjTIhX140YZj5fVV7b4ISTRA
dm+If3AlrdKeRGAFbCcFvfR54gK6oqLMAd7KGGyw9Q0IZNBHmfSRW10K1CyvnjOW
ZQf6pZxYL9p2kluF4IKZJKXZ5GIlP+Ejl7aumw8AsSx0REiy8NpdlGU27q4Zdu+a
NUJz/XIYFklM2BdCgEtOvry8LiUjq3n0PYeLyBNaXOU6/G2IlQGyNA3l8OxCaR6E
rXY9towBImoOG/Ev+jlbijQ+2LVFYH1Je3xHlhWeDlsr5mNgFyHM8+pdgMcPuu+S
wftC9Oxvrs4FFialZSD87YZYqf02fX5WH7HhDTMEWTs49drzSNEfPH6qKnjPAJB8
6xjAii7dlVpq9c1XvFSMVX5XkR9vlC1mso8mmzo5ra9Fowcx3AZ0C51FVHl9KoAP
7SMppU7C9PkPSMWgF9sy9faFxWFiupHRLqGslm4e4tkeAalBV9Eh+Fgi5DPiqfro
39aYRxJGthA06Yd1Jsx+yWW0b2AXWfv1BSF4uWOTnNpa39pl7AivNK6yJ6o7cWEv
7+6n9eN13nj2FSByb34e
=oxOu
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
