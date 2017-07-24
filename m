Received: from eggs.gnu.org ([2001:4830:134:3::10]:48963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZU3Q-00040h-1I
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZU3O-0004GK-Pj
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:29:08 -0400
Date: Mon, 24 Jul 2017 13:28:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724032853.GB17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <1500625291.10674.22.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 06:21:31PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2017-07-21 at 17:50 +1000, David Gibson wrote:
> > On Wed, Jul 19, 2017 at 02:02:18PM +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> > > >=20
> > > > I'm somewhat uncomfortable with an irq allocater here in the intc
> > > > code.  As a rule, irq allocation is the responsibility of the machi=
ne,
> > > > not any sub-component.  Furthermore, it should allocate in a way wh=
ich
> > > > is repeatable, since they need to stay stable across reboots and
> > > > migrations.
> > > >=20
> > > > And, yes, we have an allocator of sorts in XICS - it has caused a
> > > > number of problems in the past.
> > >=20
> > > So....
> > >=20
> > > For a bare metal model (which we don't have yet) of XIVE, the IRQ
> > > numbering is entirely an artifact of how the HW is configured. There
> > > should thus be no interrupt numbers visible to qemu.
> >=20
> > Uh.. I don't entirely follow.  Do you mean that during boot the guest
> > programs the irq numbers into the various components?
>=20
> I said a "bare metal model" but yes. Pretty much.=20

Right, by "guest" I meant the kernel running under qemu, even if its
running on a bare-metal equivalent platform.

> > In that case this allocator stuff definitely doesn't belong on the
> > xive code.
> >=20
> > > For a PAPR model things are a bit different, but if we want to
> > > maximize code re-use between the two, we probably need to make sure
> > > the interrupts "allocated" by the machine for XIVE can be represented
> > > by the HW model.
> > >=20
> > > That means:
> > >=20
> > >  - Each chip has a range (high bits are the block ID, which maps to a
> > > chip, low bits, around 512K to 1M interrupts is the per-chip space).
> > >=20
> > >  - Interrupts 0...N of that range (N depends on how much backing
> > > memory and MMIO space is provisioned for each chip) are "generic IPIs"
> > > which are somewhat generic interrupt source that can be triggered with
> > > an MMIO store and routed to any target. Those are used in PAPR for
> > > things like IPIs and some type of accelerator interrupts.
> > >=20
> > >  - Portions of that range (which may or may not overlap the 0...N
> > > above, if they do they "shadow" the generic interrupts) can be
> > > configured to be the HW sources from the various PCIe bridges and
> > > the PSI controller.
> >=20
> > Err.. I'm confused how this not sure this relates to spapr.  There are
> > no chips or PSI there, and the PCI bridges aren't really the same
> > thing.
>=20
> The above is the HW model, sorry for the confusion. With a few comments
> about how they are used in PAPR.
>=20
> So yes, in PAPR there's an "allocator" because the hypervisor will
> create a guest "virtual" (or logical to use PAPR terminology) interrupt
> number space, in order to represents the various interrupts into the
> guest.

Ok, but are each of those logical irqs bound to a specific device/PHB
line/whatever, or can they be configured by the guest?

> Those numbers however are just tokens, they don't have to represent any
> real HW concept. So they can be "allocated" in a rather fixed way, for
> example, you could have something like a fixed map where you put all
> the PCI interrupts at a certain number (a factor of the PHB# with room
> or a fix number per PHB, maybe 16K or so, the HW does 4K max). Another
> based would have a chunk of "general purpose" IPIs (for use for actual
> IPIs and for other things to come). And a range for the virtual device
> interrupts for example. Or you can just use an allocator.

Hm.  So what I'm meaning by an "allocator" is something at least
partially dynamic.  Something you say "give me an irq" and it gives
you the next available or similar.  As opposed to any mapping from
devices to (logical) irqs, which the machine will need to supply one
way or another.

> But it's fundamentally an allocator that sits in the hypervisor, so in
> our case, I would say in the spapr "component" of XIVE, rather than the
> XIVE HW model itself.

Maybe..

> Now what Cedric did, because XIVE is very complex and we need something
> for PAPR quickly, is not a complete HW model, but a somewhat simplified
> one that only handles what PAPR exposes. So in that case where the
> allocator sits is a bit of a TBD...

Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
machine type level needs extreme caution, or the irqs may not be
stable which will generally break migration.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1aXMACgkQbDjKyiDZ
s5KZ2Q//VXKwst5W76K6Di4J7JEgUQmdvHvsn1ZzJ1jr0XtOy0BEAaIUuo8EE8Rn
NWtU0bahtqGCowdiGJM8QA3B3XxUUP9u1lDSoHWWeVvwaI/SMpFEdzXyErD9AiEg
QXVpOhNMg/Oo+gbRmGX7UIo3YStVJ94T42jrygELlHDO+yyeI2YbU3u0EkAbts92
m1wxDu6aJeIypXholMarOI0wkUso6QoG//ozpqsinG5HxBL0EKra6GDpvqaD8txg
DS1M4qXwSKVqjV4vGE3AQWGr9os1DanZr+uEoMd02HNDUGHzVx/9FsPVk2zYLb7h
JWDxuIkqtYqRxDGGcTv/SpRRkZmnhA8jgYjUWny0rjmhI+hEoEY390S68hdIAw0Y
KfATKygo2fHEz4Sj7EYvks2YGeyLnSF+3wU1gUO+Y+Az/KEvE+qy68btXrs+4xJv
ohstr1WZDxjaMTVQ4yOr7xU48FGT1O0GTi/pKU6XmczZPLBZDUTsCRVa8GNBsZyA
gMcsxrUiKrJq2Qj5FmUm95rayX3zcNEVUEeBQAKG4EbStmoBQzetS7XwAq8tyTuZ
NbrdtTaJEH2Ao0qoLCdzJQWWxvR8BPh1j4vnMLMV+m1rt2hRf9CqA8qLDHPLHDwO
NXWY7Wj9u5eL8YKLoDUjf26w05n++cCNxqZM+nLDxUOL2faBy5g=
=TU5g
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
