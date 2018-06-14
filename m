Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTM0O-0006oB-GU
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTM0K-0004Bj-89
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 02:45:12 -0400
Date: Thu, 14 Jun 2018 16:44:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614064459.GA19339@umbus.fritz.box>
References: <20180530100754.15833-1-clg@kaod.org>
	<20180606063910.GK17757@umbus.fritz.box>
	<326e1949-28d0-941d-54f7-dbba6825388d@kaod.org>
	<20180612055855.GE30690@umbus.fritz.box>
	<87436236-09f6-9ee0-dbe6-00f0147050dc@kaod.org>
	<20180613004752.GN30690@umbus.fritz.box>
	<aa7ef7f9-f387-c99f-7d58-5048f81d4ab0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <aa7ef7f9-f387-c99f-7d58-5048f81d4ab0@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] pnv: add a physical mapping array
 describing MMIO ranges in each chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 09:03:22AM +0200, C=E9dric Le Goater wrote:
> On 06/13/2018 02:47 AM, David Gibson wrote:
> > On Tue, Jun 12, 2018 at 08:13:49AM +0200, C=E9dric Le Goater wrote:
> >> On 06/12/2018 07:58 AM, David Gibson wrote:
> >>> On Wed, Jun 06, 2018 at 09:04:10AM +0200, C=E9dric Le Goater wrote:
> >>>> On 06/06/2018 08:39 AM, David Gibson wrote:
> >>>>> On Wed, May 30, 2018 at 12:07:54PM +0200, C=E9dric Le Goater wrote:
> >>>>>> Based on previous work done in skiboot, the physical mapping array
> >>>>>> helps in calculating the MMIO ranges of each controller depending =
on
> >>>>>> the chip id and the chip type. This is will be particularly useful=
 for
> >>>>>> the P9 models which use less the XSCOM bus and rely more on MMIOs.
> >>>>>>
> >>>>>> A link on the chip is now necessary to calculate MMIO BARs and
> >>>>>> sizes. This is why such a link is introduced in the PSIHB model.
> >>>>>
> >>>>> I think this message needs some work.  This says what it's for, but
> >>>>> what actually *is* this array, and how does it work?
> >>>>
> >>>> OK. It is relatively simple: each controller has an entry defining i=
ts=20
> >>>> MMIO range.=20
> >>>>
> >>>>> The outside-core differences between POWER8 and POWER9 are substant=
ial
> >>>>> enough that I'm wondering if pnvP8 and pnvP9 would be better off as
> >>>>> different machine types (sharing some routines, of course).
> >>>>
> >>>> yes and no. I have survived using a common PnvChip framework but
> >>>> it is true that I had to add P9 classes for each: LPC, PSI, OCC=20
> >>>> They are very similar but not enough. P9 uses much more MMIOs than=
=20
> >>>> P8 which still uses a lot of XSCOM. I haven't looked at PHB4.=20
> >>>
> >>> Well, it's certainly *possible* to use the same machine type, I'm just
> >>> not convinced it's a good idea.  It seems kind of dodgy to me that so
> >>> many peripherals on the system change as a side-effect of setting the
> >>> cpu.  Compare to how x86 works where cpu really does change the CPU,
> >>> plugging it into the same virtual "chipset".  Different chipsets *are*
> >>> different machine types there (pc vs. q35).
> >>
> >> OK, I agree, and we can use a set of common routines to instantiate th=
e=20
> >> different chipset models.=20
> >>
> >> So we would have a common pnv_init() routine to initialize the differe=
nt=20
> >> 'powernv8' and 'powernv9' machines and the PnvChip typename would be a=
=20
> >> machine class attribute ?
> >=20
> > Well.. that's one option.  Usually for these things, it works out
> > better to instead of parameterizing big high-level routines like
> > pnv_init(), you have separate versions of those calling a combination
> > of case-specific and common routines as necessary.
> >=20
> > Mostly it just comes down to what is simplest to implement for you, tho=
ugh.
>=20
> I am introducing a powernv8 machine, the machine init routine is still
> generic and did not change much. But I have deepen the PnvChip class
> inheritance hierarchy with an intermediate class taking care of the
> Chip sub controllers, which gives us something like :
>=20
>   pnv_init()
>     . skiboot
>     . kernel
>     . initrd
>     . chips creation
>     . platform bus/device :
>        isa bus
>        pci layout
>        bmc handling.
>=20
>   p8 chip hierarchy:
> =20
>    power8_v2.0-pnv-chip (gives the cpu type)
>    pnv8-chip   : creates the devices only      =20
>    pnv-chip    : creates xscom and the cores=20
>=20
> The powervn9 machine has this hierarchy :
>=20
>    power9_v2.0-pnv-chip
>    pnv9-chip
>    pnv-chip
>=20
> I had to introduce these new PnvChipClass ops :=20
>=20
>     void (*realize)(PnvChip *chip, Error **errp);

Looks sensible up to this point.

>     Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
>     ISABus *(*isa_create)(PnvChip *chip);

I'm a little more dubious about this - I would have thought your
realize() hook could construct the right intc and isa, rather than
going into generic code, then back out to the callback.

But it's not a big deal.

> Overall, it's looking fine and it should remove most of these tests :
>=20
> 	 pnv_chip_is_power9(chip)
>=20
> If not, it means we are missing a PnvChipClass ops anyway.

Nice.

> I will send a patchset this week, the final one will shuffle quite a
> bit of code and the resulting diff will be a bit fuzy. You will have
> to trust me on this one.
>=20
> =20
> >> Nevertheless we would still need to introduce "a physical mapping arra=
y=20
> >> describing MMIO ranges" but we can start by differentiating the chipse=
ts=20
> >> first.
> >=20
> > Well, maybe.  I'm wondering if you can more easily encapsulate the
> > information in that array in a top-level init routine, that calls
> > common helpers with different addresses / device types / whatever.
>=20
> Hmm, I think I understand but could you give me a prototype example.=20
> Please. To make sure.
>=20
> I would like to keep the array somewhere because, in a quick look,=20
> it gives you an overview of the POWER Processor address space.

Ok.  Going to a data-driven approach for constructing things sounds
like it might be a reasonable plan in its own right.  But I'd prefer
not to conflate with other structural questions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsiDugACgkQbDjKyiDZ
s5LMag//QIL5AP4SAWoIuXTYelKzTc+uHURscp89R1JP/LIDZiuQ/qsgyaZ68r+F
xR2vkkpxttwZVV/movBVdpJ6hxzcbyaP8vA4VcNKcXyOcBbxJcqHMwxAYkCqtYWG
VhggM4mbQVaMVNySb8GhySQAdFDIjRn1cPnz1b5d7It/scyyrLdKBWHm7s/H9U6E
rqf44kewvwin4500MpRIvQDJ38liqF7b94C2KBRujoB2KZ76uWueDxXaaUyZ9joc
peawnIrPlyo338xJHTMSuhIzPQpE03Y9Q6RTfcgTw7lSOC3gvB/SlaXAZfTfr2jN
+p4Pf/lgXzj/8Y2JQFf35+tCkSTuWz94tHeXCUtZGc9YGBNV/85IA1WG2wLu5igC
Cf3iUDc00G0HL1e8THOGNBDlAVPg7bpeLFs+SSsbFMe5lesIppgNBRHmwcw6fPak
dIGJ0AgojQ/rrt/a5aovL/UhmiftplPcoO2R7fER3zUEapVx/2wGtwqYKHpCf6C/
Eql6PayjVWgrGvgcquyGbGouQE4H4ljeWPlC7mbOAl12ToKD7GDnvFp3pBKYQRRP
wBMELg5Ubi1PKXwpCeOB9t+m0hzn/5hRbelvOWybl9ZD416e2Qq0dNVV0cIoAO8s
CApC+k1fFp0Ec/iQ7/CJA4tP5CbdaiVyueSai17kKa+vqt9mLps=
=FlmQ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
