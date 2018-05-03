Received: from eggs.gnu.org ([2001:4830:134:3::10]:52573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE40T-0000wY-S6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE40P-0006ER-T7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:30:05 -0400
Date: Thu, 3 May 2018 12:29:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503022951.GK13229@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
	<20180412050707.GK9425@umbus.fritz.box>
	<2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
	<20180416042605.GC20551@umbus.fritz.box>
	<af9278d1-a0e7-2ee6-7901-d80536932245@kaod.org>
	<20180426053654.GH8800@umbus.fritz.box>
	<6ccceb5a-e2fc-6fa3-cc40-c701e5047590@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline
In-Reply-To: <6ccceb5a-e2fc-6fa3-cc40-c701e5047590@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 10:17:13AM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 07:36 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 07:40:09PM +0200, C=E9dric Le Goater wrote:
> >> On 04/16/2018 06:26 AM, David Gibson wrote:
> >>> On Thu, Apr 12, 2018 at 10:18:11AM +0200, C=E9dric Le Goater wrote:
> >>>> On 04/12/2018 07:07 AM, David Gibson wrote:
> >>>>> On Wed, Dec 20, 2017 at 08:38:41AM +0100, C=E9dric Le Goater wrote:
> >>>>>> On 12/20/2017 06:09 AM, David Gibson wrote:
> >>>>>>> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater
> >> wrote:
> > [snip]
> >>>> The XIVE tables are :
> >>>>
> >>>> * IVT
> >>>>
> >>>>   associate an interrupt source number with an event queue. the data
> >>>>   to be pushed in the queue is stored there also.
> >>>
> >>> Ok, so there would be one of these tables for each IVRE,=20
> >>
> >> yes. one for each XIVE interrupt controller. That is one per processor=
=20
> >> or socket.
> >=20
> > Ah.. so there can be more than one in a multi-socket system.
> >  >>> with one entry for each source managed by that IVSE, yes?
> >>
> >> yes. The table is simply indexed by the interrupt number in the
> >> global IRQ number space of the machine.
> >=20
> > How does that work on a multi-chip machine?  Does each chip just have
> > a table for a slice of the global irq number space?
>=20
> yes. IRQ Allocation is done relative to the chip, each chip having=20
> a range depending on its block id. XIVE has a concept of block,
> which is used in skiboot in a one-to-one relationship with the chip.

Ok.  I'm assuming this block id forms the high(ish) bits of the global
irq number, yes?

> >>> Do the XIVE IPIs have entries here, or do they bypass this?
> >>
> >> no. The IPIs have entries also in this table.
> >>
> >>>> * EQDT:
> >>>>
> >>>>   describes the queues in the OS RAM, also contains a set of flags,
> >>>>   a virtual target, etc.
> >>>
> >>> So on real hardware this would be global, yes?  And it would be
> >>> consulted by the IVRE?
> >>
> >> yes. Exactly. The XIVE routing routine :
> >>
> >> 	https://github.com/legoater/qemu/blob/xive/hw/intc/xive.c#L706
> >>
> >> gives a good overview of the usage of the tables.
> >>
> >>> For guests, we'd expect one table per-guest? =20
> >>
> >> yes but only in emulation mode.=20
> >=20
> > I'm not sure what you mean by this.
>=20
> I meant the sPAPR QEMU emulation mode. Linux/KVM relies on the overall=20
> table allocated in OPAL for the system.=20

Right.. I'm thinking of this from the point of view of the guest
and/or qemu, rather than from the implementation.  Even if the actual
storage of the entries is distributed across the host's global table,
we still logically have a table per guest, right?

> >>> How would those be integrated with the host table?
> >>
> >> Under KVM, this is handled by the host table (setup done in skiboot)=
=20
> >> and we are only interested in the state of the EQs for migration.
> >=20
> > This doesn't make sense to me; the guest is able to alter the IVT
> > entries, so that configuration must be migrated somehow.
>=20
> yes. The IVE needs to be migrated. We use get/set KVM ioctls to save=20
> and restore the value which is cached in the KVM irq state struct=20
> (server, prio, eq data). no OPAL calls are needed though.

Right.  Again, at this stage I don't particularly care what the
backend details are - whether the host calls OPAL or whatever.  I'm
more concerned with the logical model.

> >> This state is set  with the H_INT_SET_QUEUE_CONFIG hcall,
> >=20
> > "This state" here meaning IVT entries?
>=20
> no. The H_INT_SET_QUEUE_CONFIG sets the event queue OS page for a=20
> server/priority couple. That is where the event queue data is
> pushed.

Ah.  Doesn't that mean the guest *does* effectively have an EQD table,
updated by this call?  We'd need to migrate that data as well, and
it's not part of the IVT, right?

> H_INT_SET_SOURCE_CONFIG does the targeting : irq, server, priority,
> and the eq data to be pushed in case of an event.

Ok - that's the IVT entries, yes?

> =20
> >> followed
> >> by an OPAL call and then a HW update. It defines the EQ page in which
> >> to push event notification for the couple server/priority.=20
> >>
> >>>> * VPDT:
> >>>>
> >>>>   describe the virtual targets, which can have different natures,
> >>>>   a lpar, a cpu. This is for powernv, spapr does not have this=20
> >>>>   concept.
> >>>
> >>> Ok  On hardware that would also be global and consulted by the IVRE,
> >>> yes?
> >>
> >> yes.
> >=20
> > Except.. is it actually global, or is there one per-chip/socket?
>=20
> There is a global VP allocator splitting the ids depending on the
> block/chip, but, to be honest, I have not dug in the details
>=20
> > [snip]
> >>>>    In the current version I am working on, the XiveFabric interface =
is
> >>>>    more complex :
> >>>>
> >>>> 	typedef struct XiveFabricClass {
> >>>> 	    InterfaceClass parent;
> >>>> 	    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
> >>>
> >>> This does an IVT lookup, I take it?
> >>
> >> yes. It is an interface for the underlying storage, which is different
> >> in sPAPR and PowerNV. The goal is to make the routing generic.
> >=20
> > Right.  So, yes, we definitely want a method *somehwere* to do an IVT
> > lookup.  I'm not entirely sure where it belongs yet.
>=20
> Me either. I have stuffed the XiveFabric with all the abstraction=20
> needed for the moment.=20
>=20
> I am starting to think that there should be an interface to forward=20
> events and another one to route them. The router being a special case=20
> of the forwarder, the last one. The "simple" devices, like PSI, should=20
> only be forwarders for the sources they own but the interrupt controllers=
=20
> should be forwarders (they have sources) and also routers.

I'm not really clear what you mean by "forward" here.

>=20
> >>>> 	    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
> >>>
> >>> This one a VPDT lookup, yes?
> >>
> >> yes.
> >>
> >>>> 	    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);
> >>>
> >>> And this one an EQDT lookup?
> >>
> >> yes.
> >>
> >>>> 	} XiveFabricClass;
> >>>>
> >>>>    It helps in making the routing algorithm independent of the model=
=2E=20
> >>>>    I hope to make powernv converge and use it.
> >>>>
> >>>>  - a set of MMIOs for the TIMA. They model the presenter engine.=20
> >>>>    current_cpu is used to retrieve the NVT object, which holds the=
=20
> >>>>    registers for interrupt management. =20
> >>>
> >>> Right.  Now the TIMA is local to a target/server not an EQ, right?
> >>
> >> The TIMA is the MMIO giving access to the registers which are per CPU.=
=20
> >> The EQ are for routing. They are under the CPU object because it is=20
> >> convenient.
> >> =20
> >>> I guess we need at least one of these per-vcpu. =20
> >>
> >> yes.
> >>
> >>> Do we also need an lpar-global, or other special ones?
> >>
> >> That would be for the host. AFAICT KVM does not use such special
> >> VPs.
> >=20
> > Um.. "does not use".. don't we get to decide that?
>=20
> Well, that part in the specs is still a little obscure for me and=20
> I am not sure it will fit very well in the Linux/KVM model. It should=20
> be hidden to the guest anyway and can come in later.
>=20
> >>>> The EQs are stored under the NVT. This saves us an unnecessary EQDT=
=20
> >>>> table. But we could add one under the XIVE device model.
> >>>
> >>> I'm not sure of the distinction you're drawing between the NVT and the
> >>> XIVE device mode.
> >>
> >> we could add a new table under the XIVE interrupt device model=20
> >> sPAPRXive to store the EQs and indexed them like skiboot does.=20
> >> But it seems unnecessary to me as we can use the object below=20
> >> 'cpu->intc', which is the XiveNVT object. =20
> >=20
> > So, basically assuming a fixed set of EQs (one per priority?)
>=20
> yes. It's easier to capture the state and dump information from
> the monitor.
>=20
> > per CPU for a PAPR guest? =20
>=20
> yes, that's own it works.
>=20
> > That makes sense (assuming PAPR doesn't provide guest interfaces to=20
> > ask for something else).
>=20
> Yes. All hcalls take prio/server parameters and the reserved prio range=
=20
> for the platform is in the device tree. 0xFF is a special case to reset=
=20
> targeting.=20
>=20
> Thanks,
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqdB8ACgkQbDjKyiDZ
s5IiLRAAxQ4dXcVcOO3JSW6N4WRocKVIsM/NdVJGktGuHxayJGVS0LJeB7xRNTgm
n6bTJYZ9SGOwcVSoPNTKaf/jLFqgBteg3V9nzuGEeLSOfHIPjIi2eqoeO7ydaA0H
dQS61PqaJkx9jRDkiP3gFYw4y1wM6N2TBNg3XKlpDJHoetQ5OU3xjVW0vFReb9an
foN1uwd4gPW6Ry875Yz2zFRFBIfTdDEi6gYu0gcNC3C/7dGDRevq3CIRcinuyr7Q
c1gptnOiN+O6qzzi4LCNuGSvssh3vcs5Thkwbk74WjBOmXEy9gXjzI+C7KQZPpkM
3TKl+072scm+rYRHT9LJlRFLMPKOxaeGR6eWdqcITTzVfu5F8o7xbABtyT4Nutil
Mqlycg3q5mRgd8ZyZ11vURqvXqWGkgxZTYyshT+GnLAV9w0ux+2dzWv5Kz4Vvcpb
Z07K5xbUZV0CHCWnKXg6wDj6wCbYuS6FDanaxy+wpKBEnsaWOg6PG1+XYBWNdwRW
kMoo/9bXjpGwb6X1ipsjb2K5qoGoWSu/zgJgMcjeEz8GaFSX7ovxKCwOm6wR2CAM
PuVQ5A99zInrqPIxFzxqLCjcNfi8sMXJFA12VR/ECYneEIVuxptGjxyq4h++uVU/
UvNZ/eJ+W2zWr6TfxQc4XEpMi9QgobU7L/Kqym6tZR85YMb4p5U=
=3RTF
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--
