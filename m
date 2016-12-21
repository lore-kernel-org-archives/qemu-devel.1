Received: from eggs.gnu.org ([2001:4830:134:3::10]:54653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJYJp-0001Vq-PG
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJYJm-0000Wj-Ei
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:15:57 -0500
Received: from ozlabs.org ([103.22.144.67]:40241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cJYJl-0000S4-7B
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:15:54 -0500
Date: Wed, 21 Dec 2016 13:53:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161221025337.GA13024@umbus.fritz.box>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<20161219233012.GF23176@umbus.fritz.box>
	<20161220041650.GA22006@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20161220041650.GA22006@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2016 at 12:16:50PM +0800, Peter Xu wrote:
> On Tue, Dec 20, 2016 at 10:30:12AM +1100, David Gibson wrote:
>=20
> [...]
>=20
> > > +static void vtd_switch_address_space(IntelIOMMUState *s, bool enable=
d)
> > > +{
> > > +    GHashTableIter iter;
> > > +    VTDBus *vtd_bus;
> > > +    VTDAddressSpace *as;
> > > +    int i;
> > > +
> > > +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> > > +    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
> > > +        for (i =3D 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
> > > +            as =3D vtd_bus->dev_as[i];
> > > +            if (as =3D=3D NULL) {
> > > +                continue;
> > > +            }
> > > +            trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
> > > +                                           VTD_PCI_SLOT(i), VTD_PCI_=
FUNC(i),
> > > +                                           enabled);
> > > +            if (enabled) {
> > > +                memory_region_add_subregion_overlap(&as->root, 0,
> > > +                                                    &as->iommu, 2);
> > > +            } else {
> > > +                memory_region_del_subregion(&as->root, &as->iommu);
> >=20
> > Why not use memory_region_set_enabled() rather than actually
> > adding/deleting the subregion?
>=20
> Good idea, thanks. :-)
>=20
> [...]
>=20
> > > @@ -2343,15 +2378,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSt=
ate *s, PCIBus *bus, int devfn)
> > >          vtd_dev_as->devfn =3D (uint8_t)devfn;
> > >          vtd_dev_as->iommu_state =3D s;
> > >          vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> > > +
> > > +        /*
> > > +         * When DMAR is disabled, memory region relationships looks
> > > +         * like:
> > > +         *
> > > +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> > > +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_=
alias
> > > +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_i=
ommu_ir
> > > +         *
> > > +         * When DMAR is disabled, it becomes:
> > > +         *
> > > +         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
> > > +         *  0000000000000000-ffffffffffffffff (prio 2, RW): intel_io=
mmu
> > > +         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_=
alias
> > > +         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_i=
ommu_ir
> > > +         *
> > > +         * The intel_iommu region is dynamically added/removed.
> > > +         */
> > >          memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
> > >                                   &s->iommu_ops, "intel_iommu", UINT6=
4_MAX);
> >=20
> > I'm almost certain UINT64_MAX is wrong here.  For one thing it would
> > collide with PCI BARs.  For another, I can't imagine that the IOMMU
> > page tables can really span an entire 2^64 space.
>=20
> Could you explain why here device address space has things to do with
> PCI BARs? I thought BARs are for CPU address space only (so that CPU
> can access PCI registers via MMIO manner), am I wrong?

In short, yes.  So, first think about vanilla PCI - most things are
PCI-E these days, but the PCI addressing model which was designed for
the old hardware is still mostly the same.

With plain PCI, you have a physical bus over which address and data
cycles pass.  Those cycles don't distinguish between transfers from
host to device or device to host.  Each address cycle just gives which
address space: configuration, IO or memory, and an address.

Devices respond to addresses within their BARs, typically such cycles
will come from the host, but they don't have to - a device is able to
send cycles to another device (peer to peer DMA).  Meanwhile the host
bridge will respond to addresses within certain DMA windows,
propagating those access onwards to system memory.  How many DMA
windows there are, their size, location and whether they're mapped
directly or via an IOMMU depends on the model of host bridge.

On x86, traditionally, PCI addresses 0..<somewhere> were simply mapped
directly to memory addresses 0..<somewhere>, identity mapping RAM into
PCI space.  BARs would be assigned above <somewhere>, so they don't
collide.  I suspect old enough machines will have <somewhere> =3D=3D 2G,
leaving 2G..4G for the BARs of 32-bit devices.  More modern x86
bridges must have provisions for accessing memory above 4G, but I'm
not entirely certain how that works.

PAPR traditionally also had a DMA window from 0..2G, however instead
of being direct mapped to RAM, it is always translated via an IOMMU.
More modern PAPR systems have that window by default, but allow the
OS to remove it and configure up to 2 DMA windows of variable length
and page size.  Various other platforms have various other DMA window
arrangements.

With PCI-E, of course, upstream and downstream cycles are distinct,
and peer to peer DMA isn't usually possible (unless a switch is
configured specially to allow it by forwarding cycles from one
downstream port to another).  But the address mndel remains logically
the same: there is just one PCI memory space and both device BARs and
host DMA windows live within it.  Firmware and/or the OS need to know
the details of the platform's host bridge, and configure both the BARs
and the DMA windows so that they don't collide.

> I think we should have a big enough IOMMU region size here. If device
> writes to invalid addresses, IMHO we should trap it and report to
> guest. If we have a smaller size than UINT64_MAX, how we can trap this
> behavior and report for the whole address space (it should cover [0,
> 2^64-1])?

That's not how the IOMMU works.  How it traps is dependent on the
specific IOMMU model, but generally they'll only even look at cycles
which lie within the IOMMU's DMA window.  On x86 I'm pretty sure that
window will be large, but it won't be 2^64.  It's also likely to have
a gap between 2..4GiB to allow room for the BARs of 32-bit devices.

> >=20
> > > +        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
> > > +                                 "vtd_sys_alias", get_system_memory(=
),
> > > +                                 0, memory_region_size(get_system_me=
mory()));
> >=20
> > I strongly suspect using memory_region_size(get_system_memory()) is
> > also incorrect here.  System memory has size UINT64_MAX, but I'll bet
> > you you can't actually access all of that via PCI space (again, it
> > would collide with actual PCI BARs).  I also suspect you can't reach
> > CPU MMIO regions via the PCI DMA space.
>=20
> Hmm, sounds correct.
>=20
> However if so we will have the same problem if without IOMMU? See
> pci_device_iommu_address_space() - address_space_memory will be the
> default if we have no IOMMU protection, and that will cover e.g. CPU
> MMIO regions as well.

True.  That default is basically assuming that both the host bridge's
DMA windows, and its outbound IO and memory windows are identity
mapped between the system bus and the PCI address space.  I suspect
that's rarely 100% true, but it's close enough to work on a fair few
platforms.

But since you're building a more accurate model of the x86 host
bridge's behaviour here, you might as well try to get it as accurate
as possible.

> > So, I think you should find out what this limit actually is and
> > restrict the alias to that window.
>=20
> /me needs some more reading to figure this out. Still not quite
> familiar with the whole VM memory regions. Hints are welcomed...

It's not really a question of VM memory regions.  Rather it's about
how the host bridge translates between cpu side and PCI side
addresses.

> > >          memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
> > >                                &vtd_mem_ir_ops, s, "intel_iommu_ir",
> > >                                VTD_INTERRUPT_ADDR_SIZE);
> > > -        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUP=
T_ADDR_FIRST,
> > > -                                    &vtd_dev_as->iommu_ir);
> > > -        address_space_init(&vtd_dev_as->as,
> > > -                           &vtd_dev_as->iommu, "intel_iommu");
> > > +        memory_region_init(&vtd_dev_as->root, OBJECT(s),
> > > +                           "vtd_root", UINT64_MAX);
> > > +        memory_region_add_subregion_overlap(&vtd_dev_as->root,
> > > +                                            VTD_INTERRUPT_ADDR_FIRST,
> > > +                                            &vtd_dev_as->iommu_ir, 6=
4);
> > > +        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
> > > +        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> > > +                                            &vtd_dev_as->sys_alias, =
1);
> > > +        if (s->dmar_enabled) {
> > > +            memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
> > > +                                                &vtd_dev_as->iommu, =
2);
> > > +        }
> >=20
> > Hmm.  You have the IOMMU translated region overlaying the
> > direct-mapped alias.  You enable and disable the IOMMU subregion, but
> > you always leave the direct mapping enabled.  You might get away with
> > this because the size of the IOMMU region is UINT64_MAX, which will
> > overlay everything - but as above, I think that's wrong.  If that's
> > changed then guest devices may be able to access portions of the raw
> > address space outside the IOMMU mapped region, which could break the
> > guest's expectations of device isolation.
> >=20
> > I think it would be much safer to disable the system memory alias when
> > the IOMMU is enabled.
>=20
> Reasonable. Will adopt.
>=20
> Thanks!
>=20
> -- peterx
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWe6uAAoJEGw4ysog2bOSHGkP/i+aa4AYOAC836swu6y44LNZ
iyA/6aHrPcKDReI7dnLASq2+j40WLYLNnMuwRBH/suybACiis6OJ2bYZoO3LkU8X
pNT8thqAaAgKoeFx9cqKFAKZZ50ldKK9ui7VJMegg7qvrkR0KLapw7DUwYNRiOA3
FZmy+Y2UV9DAvdIO8I0Dg1AdnurJ2LFrfpY+2JBIwBxuppgLHKQSBmcCYsqbaOOZ
HsDFRuYc7uzSpTuX5ZXNR9OcBN4qUOgjvaPev9dpBmn4OToc4CXVe7G1P+t59u4G
iXtB8+t8XiGfhL5tUbKFg/XDyPPa5VwLweas62TeXwmPAWjV1ZmfOJ1tLTg9fGPT
KhAslv3mu+oDpC3HzIu3D2X/WOkZpnQeniH/VpbshGGIEc/pFdF5FT974h3Feh8P
rCV65hM8SA8irHBfG+0JpkyCAWRB9H9vByduq4Y8AchbFrldCfrFLHRZukL6v1xA
pebAdm0ZGvFL9F+WqNFPOR1rvjtLk8jFv2g3f1EIU0XhzA/FFYx/JgPc6hkq58ip
iyQF9AMG24NytMKHrEIcSQSk7ZC/mG3D67i6Ts6o3Jq7lvghf29BpBjo54rMTMZR
1AlLl62JTxIUwGvXb/mMqIDiC58K4n/xhVOX5KjEu/0U1l9t8KNnr6S5byvlyVI9
Rhp2HMlHoJXC9p1c4xnT
=OOBK
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
