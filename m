Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE6hh-0005rR-Ax
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE6hd-0000zk-70
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:22:53 -0400
Date: Thu, 3 May 2018 15:22:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503052205.GQ13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-5-clg@kaod.org>
	<20180424065131.GQ19804@umbus.fritz.box>
	<5def5bbb-9842-0121-e889-014ba88fd4c5@kaod.org>
	<20180426042002.GF8800@umbus.fritz.box>
	<660d1e36-b269-0202-7ac5-570479bb4083@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline
In-Reply-To: <660d1e36-b269-0202-7ac5-570479bb4083@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/35] spapr/xive: introduce a XIVE
 interrupt controller for sPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 12:43:29PM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 06:20 AM, David Gibson wrote:
> > On Tue, Apr 24, 2018 at 11:46:04AM +0200, C=E9dric Le Goater wrote:
> >> On 04/24/2018 08:51 AM, David Gibson wrote:
> >>> On Thu, Apr 19, 2018 at 02:43:00PM +0200, C=E9dric Le Goater wrote:
> >>>> sPAPRXive is a model for the XIVE interrupt controller device of the
> >>>> sPAPR machine. It holds the routing XIVE table, the Interrupt
> >>>> Virtualization Entry (IVE) table which associates interrupt source
> >>>> numbers with targets.
> >>>>
> >>>> Also extend the XiveFabric with an accessor to the IVT. This will be
> >>>> needed by the routing algorithm.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>
> >>>>  May be should introduce a XiveRouter model to hold the IVT. To be
> >>>>  discussed.
> >>>
> >>> Yeah, maybe.  Am I correct in thinking that on pnv there could be more
> >>> than one XiveRouter?
> >>
> >> There is only one, the main IC.=20
> >=20
> > Ok, that's what I thought originally.  In that case some of the stuff
> > in the patches really doesn't make sense to me.
>=20
> well, there is one IC per chip on powernv, but we haven't reach that part
> yet.

Hmm.  There's some things we can delay dealing with, but I don't think
this is one of them.  I think we need to understand how multichip is
going to work in order to come up with a sane architecture.  Otherwise
I fear we'll end up with something that we either need to horribly
bastardize for multichip, or have to rework things dramatically
leading to migration nightmares.

> >>> If we did have a XiveRouter, I'm not sure we'd need the XiveFabric
> >>> interface, possibly its methods could just be class methods of
> >>> XiveRouter.
> >>
> >> Yes. We could introduce a XiveRouter to share the ivt table between=20
> >> the sPAPRXive and the PnvXIVE models, the interrupt controllers of
> >> the machines. Methods would provide way to get the ivt/eq/nvt
> >> objects required for routing. I need to add a set_eq() to push the
> >> EQ data.
> >=20
> > Hrm.  Well, to add some more clarity, let's say the XiveRouter is the
> > object which owns the IVT. =20
>=20
> OK. that would be a model with some state and not an interface.

Yes.  For papr variant it would have the whole IVT contents as its
state.  For the powernv, just the registers telling it where to find
the IVT in RAM.

> > It may or may not do other stuff as well.
>=20
> Its only task would be to do the final event routing: get the IVE,
> get the EQ, push the EQ DATA in the OS event queue, notify the CPU.

That seems like a lot of steps.  Up to push the EQ DATA, certainly.
And I guess it'll have to ping an NVT somehow, but I'm not sure it
should know about CPUs as such.

I'm not sure at this stage what should own the EQD table.  In the
multichip case is there one EQD table for every IVT?  I'm guessing
not - I figure the EQD table must be effectively global so that any
chip's router can send events to any EQ in the whole system.

> > Now IIUC, on pnv the IVT lives in main system memory. =20
>=20
> yes. It is allocated by skiboot in RAM and fed to the HW using some=20
> IC configuration registers. Then, each entry is configured with OPAL=20
> calls and the HW is updated using cache scrub registers.=20

Right.  At least for the first pass we should be able to treat the
cache scrub registers as no-ops and just not cache anything in the
qemu implementation.

> > Under PAPR is the IVT in guest memory, or is it outside (updated by
> > hypercalls/rtas)?
>=20
> Under sPAPR, the IVT is updated by the H_INT_SET_SOURCE_CONFIG hcall
> which configures the targeting of an IRQ. It's not in the guest=20
> memory.

Right.

> Behind the hood, the IVT is still configured by OPAL under KVM and=20
> by QEMU when kernel_irqchip=3Doff

Sure.  Even with kernel_irqchip=3Don there's still logically a guest IVT
(or "IVT view" I guess), even if it's actual entries are stored
distributed across various places in the host's IVTs.

> >> The XiveRouter would also be a XiveFabric (or some other name) to=20
> >> let the internal sources of the interrupt controller forward events.
> >=20
> > The further we go here, the less sure I am that XiveFabric even makes
> > sense as a concept.
>=20
> See previous email.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqnH0ACgkQbDjKyiDZ
s5KIgxAAq167OK00Rti4cnABRBdVgTsXpFrU2+SAKn7Yr7blTfC+t9+OslJgJrZg
ruYqOCYIydQW+KF2egC/ZFyNda9ZKoMu7FNDMbBhhYMobYRJj25xhZR6XMm452RQ
7qwAu/nZ1jfhhcJTpYh4B+JRm1Pyu+ULGTduSQ6fCCUwml+CpR6B/WR1KKt/8Ghu
BXW07X82fj4iHUa+Ivldeq+yUvFkdBspP9GskNZXtITNJMRkWXUUvQBjmtSiZL2P
BKwzYesJU6HN9fLiTbK/kstL2wBmOR2GjG9n3RkJdufLfyIuCTZ1lTbsUpi1KQwp
6V4N6H/XOlj+S/9chtsl0L0x/fH5rf78xkJ1w0edUJ/7ODGk6DhVIDJo4qHJI8gQ
gfqwPYKgWHp7Dry4LA6wuJBIHSstI2Sre3VMgga4ie+pv2lJmmiWRaZPWY8q9ETo
UeYYaSKQAhX/rsNEGtWQfYM+8RggGjvuT8YSL224H6grOz1BSL0ljxqGT6aQdyB8
4ZR8sMj1YuI1nuBKt5cJ221B5+NnEhsG5OGhZGGvWfP5yWSqAwuQ1awCJqbRNsZ5
KSzy7FHg7lNax4N1zIk9tbAGLpCyWkL4TvjGaF6srn0AJE7HR36uXxrYf3PowD1e
zxWzLyix3tjOLJIwakWNlT9bIht9579F+/BYAf9baz+jhGjDtro=
=olKE
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--
