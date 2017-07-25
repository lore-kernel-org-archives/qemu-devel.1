Received: from eggs.gnu.org ([2001:4830:134:3::10]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmQ-0004nk-RA
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmP-0005tY-Iw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:42 -0400
Date: Tue, 25 Jul 2017 22:39:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725123939.GG8978@umbus.fritz.box>
References: <20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
	<1500872645.10674.52.camel@kernel.crashing.org>
	<20170724053827.GI17228@umbus.fritz.box>
	<1500880826.10674.66.camel@kernel.crashing.org>
	<20170724100314.GP17228@umbus.fritz.box>
	<17c42efa-9ef0-077b-a29b-e836f6643768@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <17c42efa-9ef0-077b-a29b-e836f6643768@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 10:52:27AM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 12:03 PM, David Gibson wrote:
> > On Mon, Jul 24, 2017 at 05:20:26PM +1000, Benjamin Herrenschmidt wrote:
> >> On Mon, 2017-07-24 at 15:38 +1000, David Gibson wrote:
> >>>
> >>> Can we assign our logical numbers sparsely, or will that cause other
> >>> problems?
> >>
> >> The main issue is that they probably needs to be the same between XICS
> >> and XIVE because by the time we get the CAS call to chose between XICS
> >> and XIVE, we have already handed out interrupts and constructed the DT,
> >> no ? Unless we do a real CAS reboot...
> >=20
> > A real CAS reboot probably isn't unreasonable for this case.
> >=20
> > I definitely think we need to go one way or the other - either fully
> > unify the irq mapping between xics and xive, or fully separate them.
>=20
> To be able to change interrupt model at CAS time, we need to unify=20
> the IRQ numbering.

Not necessarily, though it certainly might make things easier.

> We don't have much choice because the DT is=20
> already populated.

We could change that, though.

> We also need to share the ICSIRQState flags unless
> we share the interrupt source object between the XIVE and XICS mode.=20
>=20
> In my current tree, I made sure that the same IRQ number ranges=20
> were being used in the XIVE and in the XICS allocator and that the=20
> ICSIRQState flags of the different sPAPR Interrupt sources (XIVE=20
> and XICS) were in sync. That works pretty well for reset, migration=20
> and hotplug, but it is bit hacky.
>=20
> C.
>=20
>=20
> >> Otherwise, there's no reason they can't be sparse no.
> >>
> >>> Note that for PAPR we also have the question of finding logical
> >>> interrupts for legacy PAPR VIO devices.
> >>
> >> We just make them another range ? With KVM legacy today, I just use the
> >> generic interrupt facility for those. So when you do the ioctl to
> >> "trigger" one, I just do an MMIO to the corresponding page and the
> >> interrupt magically shows up wherever the guest is running the target
> >> vcpu. In fact, I'd like to add a way to mmap that page into qemu so
> >> that qemu can triggers them without an ioctl.
> >=20
> > Ok.
> >=20
> >> The guest doesn't care, from the guest perspective they are interrupts
> >> coming from the DT, so they are like PCI etc...
> >=20
> > Ok.
> >=20
> >>>> We can fix the number of "generic" interrupts given to a guest. The
> >>>> only requirements from a PAPR perspective is that there should be at
> >>>> least as many as there are possible threads in the guest so they can=
 be
> >>>> used as IPIs.
> >>>
> >>> Ok.  If we can do things sparsely, allocating these well away from the
> >>> hw interrupts would make things easier.
> >>>
> >>>> But we may need more for other things. We can make this a machine
> >>>> parameter with a default value of something like 4096. If we call N
> >>>> that number of extra generic interrupts, then the number of generic
> >>>> interrutps would be #possible-vcpu's + N, or something like that.
> >>>
> >>> That seems reasonable.
> >>>
> >>>>>> But it's fundamentally an allocator that sits in the hypervisor, s=
o in
> >>>>>> our case, I would say in the spapr "component" of XIVE, rather tha=
n the
> >>>>>> XIVE HW model itself.
> >>>>>
> >>>>> Maybe..
> >>>>
> >>>> You are right in that a mapping is a better term than an allocator
> >>>> here.
> >>>>
> >>>>>> Now what Cedric did, because XIVE is very complex and we need some=
thing
> >>>>>> for PAPR quickly, is not a complete HW model, but a somewhat simpl=
ified
> >>>>>> one that only handles what PAPR exposes. So in that case where the
> >>>>>> allocator sits is a bit of a TBD...
> >>>>>
> >>>>> Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> >>>>> machine type level needs extreme caution, or the irqs may not be
> >>>>> stable which will generally break migration.
> >>>>
> >>>> Yes you are right. We should probably create a more "static" scheme.
> >>>
> >>> Sounds like we're in violent agreement.
> >>
> >> Yup :)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll3PAgACgkQbDjKyiDZ
s5JosA//XWR4Paxvnm3mY1VOncfbcdKWtylkyU47FVEUp6YTD0r/Au0wz6IkQa3F
kp3Otg4brbqtIerdycY4zzs33WOfSeW+zvAneWUzOMrzy52VBB5r3kWYmYEfMHX0
8eDKJAxg43FItNy575YhJ71bRsqC3Cb/Ko2MYsXq42wKjAfAq0mVgKAYqArBzq7+
3MI3un3UN/2I9AWAoPbD9XkGtrSXCmIpCmzoQ2AVVw7E0AkIxBd4Jfve+0/N4vP/
STQd/FFZSiX60Im00LBXJeB/d2G3bwpP5KfgVadgxWKoPFHouWhqTJpjAa+8MlFm
Gb6f8ip61abKgv24Ia2j7rRkNVGhM9ATselOjhy0cu/ljz3wh+QfAmWnOUBZz95E
d7WKA+AhnTE2u1zUgbAIgC6NWBypvBiKDdNte2HQaRELyhA7Ljoc4tuj4AHY2Ykn
7fhdMFbkHOMunK8ncTo/g1GhckytTOnurFB+PO9tMxKmk+yzP4Vz89za9+HERYcy
h8/5gyghIxYcQ+viJwDPvX9tUN6suxiq+t5z7oXyeqDv+76qhtIGObVL77NAkHgj
g65du7MuPbKaziAp3UacUzG/faBR1pfQlLIMQWDMhF1BP+7GRkbDLuU7hkfQWsm9
ghFjhXtWwf00Fth/S0wwwtdbzBaPRpVr7JROXkUohoHyOqGUSbU=
=Bhfj
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
