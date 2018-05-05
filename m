Received: from eggs.gnu.org ([2001:4830:134:3::10]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosb-0002FM-AM
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEosX-0002Wy-22
	for qemu-devel@nongnu.org; Sat, 05 May 2018 00:33:05 -0400
Date: Sat, 5 May 2018 14:32:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180505043248.GN13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
	<ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
	<20180424064119.GO19804@umbus.fritz.box>
	<0fb72eb1-d9b5-968b-137a-7d44af116530@kaod.org>
	<20180426032812.GD8800@umbus.fritz.box>
	<9c1bbe54-bdbf-ba1b-29b9-bd5df31b0f07@kaod.org>
	<20180427024347.GM8800@umbus.fritz.box>
	<71ed1a12-efc8-0834-547a-5b7d39c96831@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bebzX59uVWocTrAI"
Content-Disposition: inline
In-Reply-To: <71ed1a12-efc8-0834-547a-5b7d39c96831@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 02/35] ppc/xive: add support for the LSI
 interrupt sources
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


--bebzX59uVWocTrAI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 04:25:16PM +0200, C=E9dric Le Goater wrote:
> On 04/27/2018 04:43 AM, David Gibson wrote:
> >>>> I did some work on that topic a while ago :
> >>>>
> >>>> 	https://patchwork.ozlabs.org/cover/836782/
> >>>>
> >>>> But we stopped exploring the idea. May be it was not the good approa=
ch.
> >>>> The PHBs LSIs would benefit from such a split though.
> >>> So, no, I don't think that was a good approach, but that doesn't mean
> >>> other ways of rearranging the irq numbers aren't ok.  The thing here
> >>> is that we don't want to think of an "irq allocator" - there are some
> >>> bits like that in there already, but they were always a mistake.
> >>>
> >>> We have lots of irq space (both XICS and XIVE) so instead we should
> >>> come up with a static mapping of irqs to devices.
> >> yes. I would prefer that also.=20
> >>
> >> We could change the spapr_irq_alloc() routine to get a block of=20
> >> IRQs in the range defined for a device family, and use a device=20
> >> id to offset in that family range ? Here are some figures :
> >>
> >> device family        block size  max devices =20
> >>
> >> EVENT_CLASS_EPOW              1           1 =20
> >> EVENT_CLASS_HOT_PLUG          1           1  =20
> >> VIO_VSCSI                     1          10 =20
> >> VIO_LLAN                      1          10 =20
> >> VIO_VTY                       1           5 =20
> >>                      =20
> >> PCI/PHB                    1024           5 =20
> > No, I'm thinking we should eliminate spapr_irq_alloc() entirely.
> > Well, ok, not entirely, we'll still need it for the old machine
> > types.  But remove it's use for the current machine type completely.
> >=20
> > Instead we have an explicit map of ranges for various purposes.  The
> > one-off things like EPOW and HOTPLUG can have plain constant values.
> > PCI LSIs will be calculated as something like PCI_IRQ_BASE + <phb
> > index>*4 + <irq pin>.  The VIO devices we handle as VIO_BASE + <reg
> > value> or something.
> >=20
> > MSIs will still need some sort of allocation, but we can do that
> > within a range set aside for them.
>=20
> Should we address the static mapping of irqs before introducing XIVE ?=20

Yes, I think so.

> I don't think it changes much of the architecture now that the allocator
> is under the machine. However, I wonder what would be the impact of=20
> PHB hotplug.

I don't think it should be too bad.  We now require that PHBs have the
'index' parameter set, and that won't change with hotplug.  We can
then set aside a region of irq #s for each index of PHB.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bebzX59uVWocTrAI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrtM/AACgkQbDjKyiDZ
s5KjhBAAhHQ1pOS3T188KiQe++voy4wD8uL0gN0gTsbSZl6gAcddyXPlYZXrDHBc
0dapJdRPmG/9V3kIKzVMN66XcnYZFVlOeI8KVBRueZCjNqxZSH0o0JIQ2yGJglsO
lWgAucLMVTrFgrH3/jx201UqPZnq82FePMu66Dzm4DqzFwwN3F6qLAR/c9QjPCFi
qB0Fx7DMrbD5ZTucXFB/gaaSC5K4RujaEqY87UgtQ+m5iUSbZdwZM6kmUOqSBK6H
sv7jL3pKydeLe/5Vd286xvt3eUby7Cwt2p5UGbqe6TaIZVwYnyjOh8EbCdxQPVCX
eCNqzTeW3zcplre/OWu+PLxHnS3qr5ZODZQ2E/tpFkR8dXdY2FlasSrK1VGEVBdW
vzph0eWws+QasMXDEKS1V4VyEXmqB2ijJVZtX+ZIuq24VAZWqRtq5kTRk+bfp189
WHxAwzXwgmI3I6nh1UEdeFUb1OTSHKLOL6cJyvoW6EEYF2P21CqqCIQBAnO/F2cX
H+t8cwMn6Q3A8WwP9HEw/uEvFpusQvoS1KMFn0BKN/mhwqDQj37dx6nNaGkqR+/b
t/mU9XqQ3Evo++jrSH+aWqbAjchGn9aEb9jLxf71wYkxef+uci+mzePS94ULpohH
JsA2BGkedFlaDlnCIUIHKsHxYrd8ZuWnoD87atvneGZ02upVEvA=
=7GEE
-----END PGP SIGNATURE-----

--bebzX59uVWocTrAI--
