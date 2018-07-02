Received: from eggs.gnu.org ([2001:4830:134:3::10]:35099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZsF6-000781-W2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZsF2-0002dE-Qb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:23:20 -0400
Date: Mon, 2 Jul 2018 16:23:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702062300.GC3422@umbus.fritz.box>
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
	<20180628035909.GE23134@umbus.fritz.box>
	<b84cc6b91f3af188c3eece0713f849031c5256c8.camel@redhat.com>
	<0149df21ce3f5506c3384e51a20da9f94cf313a6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="56p9wBiXEyg+KhLM"
Content-Disposition: inline
In-Reply-To: <0149df21ce3f5506c3384e51a20da9f94cf313a6.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrea Bolognani <abologna@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>


--56p9wBiXEyg+KhLM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2018 at 10:14:53PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-06-28 at 10:00 +0200, Andrea Bolognani wrote:
> > On Thu, 2018-06-28 at 13:59 +1000, David Gibson wrote:
> > > On Wed, Jun 27, 2018 at 12:22:31PM +0200, Andrea Bolognani wrote:
> > > > On Tue, 2018-06-26 at 19:02 +0200, C=E9dric Le Goater wrote:
> > > > > I didn't follow that discussion but this is "another" kind of PHB.
> > > > > This one models the baremetal controller as found on OpenPOWER and
> > > > > IBM Power machines. pSeries has a virtual PHB.
> > > >=20
> > > > I understand that, and of course libvirt will need to learn about
> > > > this new type of PHB and make sure both pSeries and PowerNV guests
> > > > get the correct one assigned to them.
> > >=20
> > > Hmm.. does it?  I would have thought pnv could act more like x86, in
> > > that libvirt doesn't attempt to create PHBs at all and just use the
> > > ones that are built in.
> >=20
> > AFAIK x86 guests have a single PHB and additional ones cannot be
> > created in any way, which means we don't have to do any additional
> > second-guessing when assigning IDs to additional PCI controllers.
>=20
> That's a surprising limitation. A single PHB only supports a limited
> number of MSIs no ? And only 256 bus numbers...

I think it depends exactly what you call a "PHB".  AIUI, on modern x86
systems, multiple PCI domains are supported, but you access them all
through the same IO ports, using a 'domain' field in some register to
distinguish which you're operating on

Wheter you want to call that multiple PHBs with a register multiplexer
in front of them, or a single PHB off which hang multiple domains is
kind of arbitrary (at least from the guest PoV).

> > > Though, come to that, I wouldn't think pnv support for libvirt would
> > > be much of a priority anyway.  The machine type is still very much in
> > > flux, and it's designed primarily for testing and development, not
> > > "real world" usage.
> >=20
> > Can you *guarantee* that someone won't ask for PowerNV support in
> > libvirt at some point? Because if you can't (and I don't think you
> > can ;) then this is still a valuable conversation to have.
>=20
> It's rather unlikely for now as there is no KVM suport for it (it's
> tricky, our chips aren't designed for full virtualization). That might
> change in the future but not soon.

KVM support isn't really a prerequisite for libvirt support.  More
relevant is that the qemu level machine is still changing a lot.  I
don't believe we're really maintaining version to version option
compatibility at this point, we're certainly not attempting to support
cross version migration for it.

> > > > What I meant is that pSeries guests get a single PHB by default,
> > > > with additional ones being instantiable through -device; this is
> > > > also consistent with how PCI controllers are added to other guest
> > > > types including pc, q35 and aarch64/virt, so it would be really
> > > > nice if PowerNV behaved the same way.
> > >=20
> > > Well.. sure.. but it doesn't.  pSeries is a virtual platform, so we
> > > have a reasonable amount of flexibility to define it as we want.
> > > PowerNV is an emulation of existing hardware which has a specific
> > > behaviour which we need to match.
> >=20
> > Sure, that's something to keep in mind.
> >=20
> > But the thing is, you still need to have *some* flexibility in
> > the number of PHBs, since there is variation among real Power8
> > and Power9 chips; in the current incarnation, that flexibility
> > is provided by the num_phbs parameter, which is an entirely new
> > interface that's exclusive to PowerNV.
> >=20
> > What I'm suggesting is that the same amount of flexibility is
> > offered through a standard interface, namely -device, instead.
>=20
> But that's harder internally to qemu to properly "bind" to the chip
> where the PHB resides etc...=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--56p9wBiXEyg+KhLM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5xMEACgkQbDjKyiDZ
s5KtYg//VvSyRhA9KZWWFo6z+XL0M20ycEwbd5/I5nzHV7KTV6/qf7gE4I6M1HK8
b21foCj3apdG2LS+1lX56X6nWycCA7cHXiNWlm+oDuA8I0X4YhwWrPSqpCF48aM6
FR3Uay8FtBXUzQ73V+eg2MMVx3b52DBwCsPHH5zKTS5YOasFtbu8xk1NK9JAHaSY
Ppz+J/vapzUJu40p1fThcEj+8qxkfL25lY0G+Gu6HWGI8zfylTNkJSrBOnsDMzCT
WoGbLbGuWmAb00gr+14cmreF1LWQiV53ClZF76zXfl0WRvqC25jTvh2fO8WBiYV2
UwLQbyn/a8LYft11tyy7Z64AjLT3HpIKCSwl6cW4fE6gocEoj0tvvjgSfXVu3Sit
tf1Obpdy0bMHJg/qekECCcA+d314sDqeGTM0Tdwa1ZchbPZuC4NlcUEc46II0srl
wBKBQKr2dMJB5vORUxYJD+oYtt7CSXBJh0KndC3PfUg12ZUtGLkD2DGO+5EceRiL
Z+2ZpPJHq700qOS+tISsm5WGGEiUz16hsx5TK6U2BjhhmASyq11wjEWyUJtP6uL4
9m10WPqxd1iOSvY9A7d8LdJ01K3hlvCPeMyEAwEGHdNsRcfLFDVRpILXdslxDmAm
IMyUXOY5hKDOpNtCTUKnnCFUjV5IFwu4uQC/DdvqImUE9wrhAxU=
=rT0d
-----END PGP SIGNATURE-----

--56p9wBiXEyg+KhLM--
