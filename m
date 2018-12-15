Received: from eggs.gnu.org ([2001:4830:134:3::10]:46707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gY57W-0002y9-Fw
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 03:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gY57O-0008DA-NU
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 03:16:19 -0500
Date: Sat, 15 Dec 2018 19:09:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215080908.GL29278@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-17-clg@kaod.org>
	<20181211020350.GF4261@umbus.fritz.box>
	<771f030d-b69f-78e4-ac0c-9f37e3ab9c17@kaod.org>
	<20181212005418.GG2719@umbus.fritz.box>
	<d5a33faf-cd68-861e-e795-d587b1b49bc7@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
In-Reply-To: <d5a33faf-cd68-861e-e795-d587b1b49bc7@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 16/19] spapr: introduce a new sPAPR IRQ
 backend supporting XIVE and XICS
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


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 10:13:29AM +0100, C=E9dric Le Goater wrote:
> [ ... ]=20
>=20
>=20
> >>>> +
> >>>> +static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
> >>>> +{
> >>>> +    return spapr_irq_current(spapr)->qirq(spapr, irq);
> >>>
> >>> Urgh... I don't think this is going to work.  IIRC the various devices
> >>> (PHB, VIO, etc.)  are wired up to their qirqs at realize() time, so if
> >>> you reboot from a XIVE guest to XICS guest (or maybe the other way
> >>> around) the peripherals won't be able to signal irqs in the new
> >>> scheme.
> >>
> >> It does. The IRQ numbers are claimed in both backends.
> >=20
> > Yes, I realize that, but the two backends still have their own set of
> > qirqs, which have their own set_irq routines associated with them.
> >=20
> >> This is the problem since the very beginning. For reset and migration
> >> to work, we need to keep in sync the IRQ number space of the machine=
=20
> >> and the different interrupt controllers.
> >=20
> > Sure, we have the numbers in sync, but that won't help if when the
> > peripherals do a qemu_irq_pulse() it goes to the wrong backend's
> > trigger routine.
>=20
> Ah. You mean that the devices could bypass the sPAPR IRQ layer and=20
> trigger the IRQ directly from the IRQ controller model ? it's not=20
> the case today.

Ah, right, sorry.  We're saved by the fact that basically the only
root level devices for spapr are the PHB and VIO devices, and it so
happens that those look up the relevant qirqs from spapr at interrupt
time, rather than in advance.

I think it's fragile to rely on that - qirqs are supposed to be stable
objects that devices can keep a reference to and use later.

> I agree that having a common set of qirqs and a qemu_irq handler=20
> doing the dispatch on the selected interrupt contoller model is=20
> good idea. I didn't go in that direction because KVM brings additional=20
> head aches.
>=20
> Where would put the qirqs ? at the machine level I suppose.

Yes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUtqQACgkQbDjKyiDZ
s5LTiQ/+Jfq0ZMJdsK7Kii68H/0SuH1+FkDvn72pPT8sdGic1mE3YRWuJzXiAlVE
edrDvY69vaO4tg4mRqPSE4/QTTTd0MIZ3p4nKZhOHGTktB2JcW1Sp1BatQvJ1kVq
U1rgbomOEgM9K31jnX+K82mE7opjiEwV/g7QhwbzDnLs+VIinTmtvRAEWUhE7X0+
rNnsz0JhLvneraEPNXvMxU3d6ADnFp0JygluBNtlTBgArHaRfE20tpIMa77/Iv5q
wDWE4i0scrBFgYA6QIZFBCRk68yM0nV8KXxiKA8SxoN1MyV7az4e9iaB+SAOTevx
Z1PDDhlIPmbxyxNqv/OHhCF67SnuORlAk0+oU2UOpKLK/CROL6w6LFYhf5D7eOoj
qaOUOkaaSsNLGZNZ46Aqp9aroYUaSXrKMbLc9NgKASj777XcjuzZEWvfgUstNGkW
RAVTpGUc8r+TI+V97Wd1AIJbclTR2nZJFlRuktu18pEOuCj2fNundW8NQ/5t8v7f
3lh69Um9bPvWVL2/EJglHGo3sid4tVIozViE8EwP/euAKZUDofE6iKHQQxn32mMS
M248KL2vHygz5/AyEP0P8SgQyxBxAMz7M4k6RRZ+erSfLUMDDRkvB3kWq44tEgNj
CIHMaw77p+TEJkSB2T2a9LcbtkxmU2OZnTl+zSoFAu4R8HdlYTQ=
=UVs0
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
