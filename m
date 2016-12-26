Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cLTeR-0002B0-Lp
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 06:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cLTeO-00077y-Gc
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 06:41:11 -0500
Received: from ozlabs.org ([103.22.144.67]:55927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cLTeN-00075b-Fb
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 06:41:08 -0500
Date: Mon, 26 Dec 2016 22:40:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161226114015.GA25998@umbus>
References: <20161222094240.GA26435@pxdev.xzpeter.org>
	<d4e36417-3005-0d5f-63b4-ebe621f3a763@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <d4e36417-3005-0d5f-63b4-ebe621f3a763@redhat.com>
Subject: Re: [Qemu-devel] A question about PCI device address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 01:01:34PM +0200, Marcel Apfelbaum wrote:
> On 12/22/2016 11:42 AM, Peter Xu wrote:
> > Hello,
> >=20
>=20
> Hi Peter,
>=20
> > Since this is a general topic, I picked it out from the VT-d
> > discussion and put it here, just want to be more clear of it.
> >=20
> > The issue is, whether we have exposed too much address spaces for
> > emulated PCI devices?
> >=20
> > Now for each PCI device, we are having PCIDevice::bus_master_as for
> > the device visible address space, which derived from
> > pci_device_iommu_address_space():
> >=20
> > AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> > {
> >     PCIBus *bus =3D PCI_BUS(dev->bus);
> >     PCIBus *iommu_bus =3D bus;
> >=20
> >     while(iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
> >         iommu_bus =3D PCI_BUS(iommu_bus->parent_dev->bus);
> >     }
> >     if (iommu_bus && iommu_bus->iommu_fn) {
> >         return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, dev->d=
evfn);
> >     }
> >     return &address_space_memory;
> > }
> >=20
> > By default (for no-iommu case), it's pointed to system memory space,
> > which includes MMIO, and looks wrong - PCI device should not be able to
> > write to MMIO regions.
> >=20
>=20
> Why? As far as I know a PCI device can start a read/write transaction
> to virtually any address, it doesn't matter if it 'lands' in RAM or a MMIO
> region mapped by other device. But I might be wrong, need to read the spe=
c again...

So as I noted in another mail, my earlier comment which led Peter to
say that was misleading.  In particular I was talking about *non PCI*
MMIO devices, which barely exist on x86 (and even there the statement
won't necessarily be true).

> The PCI transaction will eventually reach the Root Complex/PCI host bridge
> where an IOMMU or some other hw entity can sanitize/translate, but is out=
 of
> the scope of the device itself.

Right, but we're not talking about the device, or purely within PCI
address space.  We're explicitly talking about what addresses the
RC/host bridge will translate between PCI space and CPU address space.
I'm betting that even on x86, it won't be the whole 64-bit address
space (otherwise how would the host bridge know whether another PCI
device might be listening on that address).

> The Root Complex will 'translate' the transaction into a memory read/write
> in the behalf of the device and pass it to the memory controller.
> If the transaction target is another device, I am not sure if the
> Root Complex will re-route by itself or pass it to the Memory Controller.

It will either re-route itself, or simply drop it, possibly depending
on configuration.  I'm sure the MC won't be bouncing transactions back
to PCI space.  Note that for vanilla PCI the question is moot - the
cycle will be broadcast on the bus segment and something will pick it
up - either a device or the host bridge.  If multiple things try to
respond to the same addresses, things will go badly wrong.

> > As an example, if we dump a PCI device address space into detail on
> > x86_64 system, we can see (this is address space for a virtio-net-pci
> > device on an Q35 machine with 6G memory):
> >=20
> >     0000000000000000-000000000009ffff (prio 0, RW): pc.ram
> >     00000000000a0000-00000000000affff (prio 1, RW): vga.vram
> >     00000000000b0000-00000000000bffff (prio 1, RW): vga-lowmem
> >     00000000000c0000-00000000000c9fff (prio 0, RW): pc.ram
> >     00000000000ca000-00000000000ccfff (prio 0, RW): pc.ram
> >     00000000000cd000-00000000000ebfff (prio 0, RW): pc.ram
> >     00000000000ec000-00000000000effff (prio 0, RW): pc.ram
> >     00000000000f0000-00000000000fffff (prio 0, RW): pc.ram
> >     0000000000100000-000000007fffffff (prio 0, RW): pc.ram
> >     00000000b0000000-00000000bfffffff (prio 0, RW): pcie-mmcfg-mmio
> >     00000000fd000000-00000000fdffffff (prio 1, RW): vga.vram
> >     00000000fe000000-00000000fe000fff (prio 0, RW): virtio-pci-common
> >     00000000fe001000-00000000fe001fff (prio 0, RW): virtio-pci-isr
> >     00000000fe002000-00000000fe002fff (prio 0, RW): virtio-pci-device
> >     00000000fe003000-00000000fe003fff (prio 0, RW): virtio-pci-notify
> >     00000000febd0400-00000000febd041f (prio 0, RW): vga ioports remapped
> >     00000000febd0500-00000000febd0515 (prio 0, RW): bochs dispi interfa=
ce
> >     00000000febd0600-00000000febd0607 (prio 0, RW): qemu extended regs
> >     00000000febd1000-00000000febd102f (prio 0, RW): msix-table
> >     00000000febd1800-00000000febd1807 (prio 0, RW): msix-pba
> >     00000000febd2000-00000000febd2fff (prio 1, RW): ahci
> >     00000000fec00000-00000000fec00fff (prio 0, RW): kvm-ioapic
> >     00000000fed00000-00000000fed003ff (prio 0, RW): hpet
> >     00000000fed1c000-00000000fed1ffff (prio 1, RW): lpc-rcrb-mmio
> >     00000000fee00000-00000000feefffff (prio 4096, RW): kvm-apic-msi
> >     00000000fffc0000-00000000ffffffff (prio 0, R-): pc.bios
> >     0000000100000000-00000001ffffffff (prio 0, RW): pc.ram
> >=20
> > So here are the "pc.ram" regions the only ones that we should expose
> > to PCI devices? (it should contain all of them, including the low-mem
> > ones and the >=3D4g one)
> >=20
>=20
> As I previously said, it does not have to be RAM only, but let's wait
> also for Michael's opinion.
>=20
> > And, should this rule work for all platforms?
>=20
> The PCI rules should be generic for all platforms, but I don't know
> the other platforms.

The rules *within the PCI address space* will be common across
platforms.  But we're discussing the host bridge and the rules across
the PCI/host interface.  This behaviour - what address ranges will be
forwarded in which direction, for example - can and does vary
significantly by platform.

>=20
> Thanks,
> Marcel
>=20
> Or say, would it be a
> > problem if I directly change address_space_memory in
> > pci_device_iommu_address_space() into something else, which only
> > contains RAMs? (of course this won't affect any platform that has
> > IOMMU, aka, customized PCIBus::iommu_fn function)
> >=20
> > (btw, I'd appreciate if anyone has quick answer on why we have lots of
> >  continuous "pc.ram" in low 2g range - from can_merge() I guess they
> >  seem to have different dirty_log_mask, romd_mode, etc., but I still
> >  would like to know why they are having these difference. Anyway, this
> >  is totally an "optional question" just to satisfy my own curiosity :)
> >=20
> > Thanks,
> >=20
> > -- peterx
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYYQGcAAoJEGw4ysog2bOSt2IP/ji03fnuoCkrnRjkU4slvAo9
KEPUDrCSIHWmjLdJ78FF+N4+nRwPf85yd2vW3U765k7dPWGuHNCfVJsD+NQoFRHI
yb5le12aQZdPxWt7orU9VpXzEo/IEGTGUm0D2vS4wMBoIJhECkDv1JYlyRFvziyB
PMmCiX4r8L6mVqiHQnFlmGFNAwF7Znelbx64o7dCtWPllQH9PmNdkpNeTyVTQqq4
/5V0x4LNwRMytXuHRQKc4MZon3YoHloafpfZOoPtzim/EkQwNKOsyNQFg6+U/9aU
Sphku3/CFFsd5miQOpsJCrVdN/AaQXiwRlfld1WWEDldwfOWD14tE9B7beZnjnxW
1gJm5xXo3M/ZUW4rBZWkv1xTK8tdyn9tpFb/dGWv4+pUp/924G7+eYo2HqLexmQL
f1JXVZQSrITZZUUlBXt6Gh2YlhGyr90aR6+Egt3Al1Zg+AIr7fyLKx9/s4vnmA9w
abvkizUwppTLgtJZEHSu0fdGcYSPRIniWp3kBMDQVrX8aAmsI6KanjdVBxEyiA3R
TORT80+eIqTpaW7EzsY0AHKudArsyLbCMw4SvC2S7c0aJRbKgRfNudw/19RTkBA8
4ncjCxrCRp5H7j5QTqK+ZKlJbuHvoAs73C8Wp83euKoKCpW34wOdVd3e6/whdo8u
JCMDeubzGJpsp1KRiYHb
=hGdx
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
