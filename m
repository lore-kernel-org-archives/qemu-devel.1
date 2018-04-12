Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcW-00070k-Lc
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcU-0005Pw-NK
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:04 -0400
Date: Thu, 12 Apr 2018 15:15:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412051503.GN9425@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
In-Reply-To: <2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 03:39:46PM +0100, C=E9dric Le Goater wrote:
> On 01/17/2018 12:10 PM, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-01-17 at 10:18 +0100, C=E9dric Le Goater wrote:
> >>>>> Also, have we decided how the process of switching between XICS and
> >>>>> XIVE will work vs. CAS ?=20
> >>>>
> >>>> That's how it is described in the architecture. The current choice is
> >>>> to create both XICS and XIVE objects and choose at CAS which one to
> >>>> use. It relies today on the capability of the pseries machine to=20
> >>>> allocate IRQ numbers for both interrupt controller backends. These
> >>>> patches have been merged in QEMU.
> >>>>
> >>>> A change of interrupt mode results in a reset. The device tree is=20
> >>>> populated accordingly and the ICPs are switched for the model in=20
> >>>> use.=20
> >>>
> >>> For KVM we need to only instanciate one of them though.
> >>
> >> Hmm,
> >>
> >> How would we handle a guest rebooting on a kernel without XIVE support=
 ?=20
> >=20
> > It will do CAS again and we can change the devices.
>=20
> So, we would destroy the previous QEMU ICS object and create a new one=20
> in the CAS hcall. That would probably work. There might be some issues=20
> in creating and destroying the ICS KVM device, but that can be studied=20
> without XIVE.

Adding and removing devices at runtime based on guest requests like
this will get really hairy in qemu.

As I've said before for the first cut, I think we want to select just
one as a machine option to avoid this confusion.

Looking further ahead, I think we'll be better off having both the
XIVE and XICS models always present (at least minimally) in qemu, but
with only one "active" at any given time.

Note that having the inactive one destroy and clean up the
corresponding KVM devices is fine, as is deallocating as much of its
runtime state as we can without changing the notional QOM tree.

>=20
> It used to be considered ugly to create a QEMU device at reset time, so=
=20
> I wonder if this is still the case, because when the machine reaches CAS,=
=20
> we really are beyond reset.  =20
>=20
> If this is OK, then the next "issue" is to keep in sync the allocated=20
> IRQ numbers. The IRQ allocator is now merged at the machine level, so=20
> the synchronization is obvious to do when both backend QEMU objects=20
> are available. that's the path I took. If both QEMU objects are not=20
> available, then we need to scan the IRQ number space in the current=20
> interrupt mode and allocate the same IRQs in the newly negotiated mode.=
=20
> Probably OK. I don't see major problems with the current code.=20
>=20
> Migration is a problem. We will need both backend QEMU objects to be=20
> available anyhow if we want to migrate. So we are back to the current=20
> solution creating both QEMU objects but we can try to defer some of the=
=20
> KVM inits and create the KVM device on demand at CAS time.
>=20
> The next problem is the ICP object that currently needs the KVM device=20
> fd to connect the vcpus ... So, we will need to change that also.=20
> That is probably the biggest problem today. We need a way to disconnect=
=20
> the vpcu from the KVM device and see how we can defer the connection.
> I need to make sure this is possible, I can check that without XIVE
> I think.
>=20
> >> Are you suggesting to create the XICS or XIVE device in the CAS negoti=
ation=20
> >> process ? So, the machine would not have any interrupt controller befo=
re=20
> >> CAS. That seems really late to me. grub uses the console for instance.=
=20
> >=20
> > We start with XICS by default.
>=20
> yes.
>=20
> >> I think it should prepare for both options, start in XIVE legacy mode,=
=20
> >> which is XICS, then possibly switch to XIVE exploitation mode.
> >>
> >>>>> And how that will interact with KVM ?=20
> >>>>
> >>>> I expect we will do the same, which is to create two KVM devices to=
=20
> >>>> be able to handle both interrupt controller backends depending on th=
e=20
> >>>> mode negotiated by the guest. =20
> >>>
> >>> That will be an ungodly mess, I'd rather we only instanciate the right
> >>> one.
> >>
> >> It's rather transparent currently in the emulated version. There are t=
wo=20
> >> sets of objects in QEMU, switching is done in CAS. KVM support should =
not=20
> >> change anything in that area.=20
> >>
> >> I expect the 'xive-kvm' object to get/set states for migration, just l=
ike=20
> >> for XICS and to setup the ESB+TIMA memory regions, which is new.=20
> >=20
> > But both XICS and XIVE are completely different kernel KVM devices that=
 will
> > need to "hook" into the same set of internal hooks for things like inte=
rrupts
> > being passed through, RTAS calls etc...=20
> >=20
> > How does KVM knows which one to "activate" ?
>=20
> Can't we add an extra IRQ type and use vcpu->arch.irq_type for that ?=20
> I haven't studied all the low level details though.
>=20
> > I don't think the kernel should have both.=20
>=20
> I hear that. From a QEMU perspective, it is much easier to put everything=
=20
> in place for both interrupt modes and let the guest decide what it wants=
=20
> to use.=20
>=20
> If we choose not to, we will need to find solution to defer the KVM inits
> and to disconnect/reconnect the vcpus. For the latter, we could add a=20
> KVM_DISABLE_CAP ioctl or maybe better add a new capability like=20
> KVM_CAP_IRQ_XIVE to perform the switch.
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrO61cACgkQbDjKyiDZ
s5LcOw//exDAMcRCjcdIgsMkiEwX4GKGzhSCI/WUwaNZz/ToE82DM6voPfQU8MpF
KEKfGvovgr6mxZ5N4myIIwBpe1YmA5w7GD87XhdlUbelYdnOa3smHxascEmeV57X
EZNx3GYLz/enP6cDQzbRTSR/h8TMgxySLCox6X7FZOvLX9rBGZP9FTxmOhp057Qj
toSlwv2mve5hSlYUwyTDcEjQJemAhYTdyS4Mn97RhD3TF8JAr2rlPz3yXl2jbvV0
Bhw88r+eoCPzMydvxUxhqAE+ufPRA36hqhyW9B1mmU+t8Y7yL3SpNsIyuzgF4U/y
8bvrd4RF9fKG7glNl79NV6eRRh+nqlHjM4oiroJLHFct1MWBfX3KtJ661Y2U4Kwz
j8SdKlMPOFiM/SPIyf7ZcLMThpxavY8BoxLB6c8xDBiy0mU4Tplii5KplIB+J85E
O3E9W9mLicD1YKLgsrSF/C6k6TYoVAL+zd3fuF5p35kqJ7Ed1j1Eyp98weMXBxC4
PYA0rvzmKb6Erkg313VCWBojnXa3OrTOo/ig6BLWR4h0q0CrJgSL76pglf96LiZh
omCYedsA3r+mHs95/SN568PuNovYjFUGrphlBYo0oFuJCOiGvf11fxUmJSSsNHJ5
mebBfwTm97m9adMRzwtkxAD5iDaE/ElhGgzNC2XF8IPRjbzFYUU=
=ZcAC
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
