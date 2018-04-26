Received: from eggs.gnu.org ([2001:4830:134:3::10]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBZbN-0001IO-JS
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBZbJ-0001Iy-ON
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:37:53 -0400
Date: Thu, 26 Apr 2018 15:36:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426053654.GH8800@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
	<20180412050707.GK9425@umbus.fritz.box>
	<2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
	<20180416042605.GC20551@umbus.fritz.box>
	<af9278d1-a0e7-2ee6-7901-d80536932245@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <af9278d1-a0e7-2ee6-7901-d80536932245@kaod.org>
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


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 07:40:09PM +0200, C=E9dric Le Goater wrote:
> On 04/16/2018 06:26 AM, David Gibson wrote:
> > On Thu, Apr 12, 2018 at 10:18:11AM +0200, C=E9dric Le Goater wrote:
> >> On 04/12/2018 07:07 AM, David Gibson wrote:
> >>> On Wed, Dec 20, 2017 at 08:38:41AM +0100, C=E9dric Le Goater wrote:
> >>>> On 12/20/2017 06:09 AM, David Gibson wrote:
> >>>>> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater
> wrote:
[snip]
> >> The XIVE tables are :
> >>
> >> * IVT
> >>
> >>   associate an interrupt source number with an event queue. the data
> >>   to be pushed in the queue is stored there also.
> >=20
> > Ok, so there would be one of these tables for each IVRE,=20
>=20
> yes. one for each XIVE interrupt controller. That is one per processor=20
> or socket.

Ah.. so there can be more than one in a multi-socket system.

> > with one entry for each source managed by that IVSE, yes?
>=20
> yes. The table is simply indexed by the interrupt number in the
> global IRQ number space of the machine.

How does that work on a multi-chip machine?  Does each chip just have
a table for a slice of the global irq number space?

> > Do the XIVE IPIs have entries here, or do they bypass this?
>=20
> no. The IPIs have entries also in this table.
>=20
> >> * EQDT:
> >>
> >>   describes the queues in the OS RAM, also contains a set of flags,
> >>   a virtual target, etc.
> >=20
> > So on real hardware this would be global, yes?  And it would be
> > consulted by the IVRE?
>=20
> yes. Exactly. The XIVE routing routine :
>=20
> 	https://github.com/legoater/qemu/blob/xive/hw/intc/xive.c#L706
>=20
> gives a good overview of the usage of the tables.
>=20
> > For guests, we'd expect one table per-guest? =20
>=20
> yes but only in emulation mode.=20

I'm not sure what you mean by this.

> > How would those be integrated with the host table?
>=20
> Under KVM, this is handled by the host table (setup done in skiboot)=20
> and we are only interested in the state of the EQs for migration.

This doesn't make sense to me; the guest is able to alter the IVT
entries, so that configuration must be migrated somehow.

> This state is set  with the H_INT_SET_QUEUE_CONFIG hcall,

"This state" here meaning IVT entries?

> followed
> by an OPAL call and then a HW update. It defines the EQ page in which
> to push event notification for the couple server/priority.=20
>=20
> >> * VPDT:
> >>
> >>   describe the virtual targets, which can have different natures,
> >>   a lpar, a cpu. This is for powernv, spapr does not have this=20
> >>   concept.
> >=20
> > Ok  On hardware that would also be global and consulted by the IVRE,
> > yes?
>=20
> yes.

Except.. is it actually global, or is there one per-chip/socket?

[snip]
> >>    In the current version I am working on, the XiveFabric interface is
> >>    more complex :
> >>
> >> 	typedef struct XiveFabricClass {
> >> 	    InterfaceClass parent;
> >> 	    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
> >=20
> > This does an IVT lookup, I take it?
>=20
> yes. It is an interface for the underlying storage, which is different
> in sPAPR and PowerNV. The goal is to make the routing generic.

Right.  So, yes, we definitely want a method *somehwere* to do an IVT
lookup.  I'm not entirely sure where it belongs yet.

>=20
> >> 	    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
> >=20
> > This one a VPDT lookup, yes?
>=20
> yes.
>=20
> >> 	    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);
> >=20
> > And this one an EQDT lookup?
>=20
> yes.
>=20
> >> 	} XiveFabricClass;
> >>
> >>    It helps in making the routing algorithm independent of the model.=
=20
> >>    I hope to make powernv converge and use it.
> >>
> >>  - a set of MMIOs for the TIMA. They model the presenter engine.=20
> >>    current_cpu is used to retrieve the NVT object, which holds the=20
> >>    registers for interrupt management. =20
> >=20
> > Right.  Now the TIMA is local to a target/server not an EQ, right?
>=20
> The TIMA is the MMIO giving access to the registers which are per CPU.=20
> The EQ are for routing. They are under the CPU object because it is=20
> convenient.
> =20
> > I guess we need at least one of these per-vcpu. =20
>=20
> yes.
>=20
> > Do we also need an lpar-global, or other special ones?
>=20
> That would be for the host. AFAICT KVM does not use such special
> VPs.

Um.. "does not use".. don't we get to decide that?

> >> The EQs are stored under the NVT. This saves us an unnecessary EQDT=20
> >> table. But we could add one under the XIVE device model.
> >=20
> > I'm not sure of the distinction you're drawing between the NVT and the
> > XIVE device mode.
>=20
> we could add a new table under the XIVE interrupt device model=20
> sPAPRXive to store the EQs and indexed them like skiboot does.=20
> But it seems unnecessary to me as we can use the object below=20
> 'cpu->intc', which is the XiveNVT object. =20

So, basically assuming a fixed set of EQs (one per priority?) per CPU
for a PAPR guest?  That makes sense (assuming PAPR doesn't provide
guest interfaces to ask for something else).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhZXQACgkQbDjKyiDZ
s5IayhAAxsZ3DXnJNH5jEULy26POl3nW9RDrAUYrA97u3Zqk476NWACfi8mKAhTo
sdbqxuWBvqM7uhRcZhtF+dXRmY5jQ093CCz9jYHSbDPR2CvfN+4D00pWR1zjEutG
MVTeUTSLk2M6BrdbpTWVF0a4hxFhnlMFDOoGuQRpqQOLsxWsYyVMWiWscvK+G2E5
ebOY+bCPtl65J5OhWSQk5vE+0XPmiwyWvG50X3YDdnyb8k6zENoIioBq1+dBrrrA
sf/rLSMH3gUpvD83sJlx7aCJx3uelofs2nqT6b9tV8MmVK2Ao4XE5kYlElW1yBAE
N7nZW2k+L6rP2ybqp6Ia3GaNBAHBpaWSeTnzxw5ti63anZC56JYpIbsAUw8CLaPs
y+XCeeGaNzFo3xRYAnnsQO4jK318MzZN5WzMh/BDD7hk/RMFr+HtFckT/Wx2v9GF
39hfSvRZ1R+FFIvBlwkJ0ljpaC7Qlc13sUaEZoK7EO918ULVsN0+dOUWXuwQM7Y4
ajQnc3+bS20lDOpG8+tiv3mwG6YIwm5KzWj20nowfrNKIJu4sPkYKZ5sMDqRC60S
AQQca42DlCeyNwC9a0+mqRVD9a+5/p5DWUbeRe5ub3AYapIe/+iUCpiZf/d4vtvp
JcuvUEPnVY6UG0E2EulHtVbJNKmCy9eDzYFMHw76G7c91tTS5X8=
=t/u9
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
