Received: from eggs.gnu.org ([2001:4830:134:3::10]:35614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fYVpa-000258-9V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1fYVpW-0003Vw-2r
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:15:22 -0400
Message-ID: <0149df21ce3f5506c3384e51a20da9f94cf313a6.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Jun 2018 22:14:53 +1000
In-Reply-To: <b84cc6b91f3af188c3eece0713f849031c5256c8.camel@redhat.com>
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
	<20180628035909.GE23134@umbus.fritz.box>
	<b84cc6b91f3af188c3eece0713f849031c5256c8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
To: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 2018-06-28 at 10:00 +0200, Andrea Bolognani wrote:
> On Thu, 2018-06-28 at 13:59 +1000, David Gibson wrote:
> > On Wed, Jun 27, 2018 at 12:22:31PM +0200, Andrea Bolognani wrote:
> > > On Tue, 2018-06-26 at 19:02 +0200, C=C3=A9dric Le Goater wrote:
> > > > I didn't follow that discussion but this is "another" kind of PHB.
> > > > This one models the baremetal controller as found on OpenPOWER an=
d
> > > > IBM Power machines. pSeries has a virtual PHB.
> > >=20
> > > I understand that, and of course libvirt will need to learn about
> > > this new type of PHB and make sure both pSeries and PowerNV guests
> > > get the correct one assigned to them.
> >=20
> > Hmm.. does it?  I would have thought pnv could act more like x86, in
> > that libvirt doesn't attempt to create PHBs at all and just use the
> > ones that are built in.
>=20
> AFAIK x86 guests have a single PHB and additional ones cannot be
> created in any way, which means we don't have to do any additional
> second-guessing when assigning IDs to additional PCI controllers.

That's a surprising limitation. A single PHB only supports a limited
number of MSIs no ? And only 256 bus numbers...

> > Though, come to that, I wouldn't think pnv support for libvirt would
> > be much of a priority anyway.  The machine type is still very much in
> > flux, and it's designed primarily for testing and development, not
> > "real world" usage.
>=20
> Can you *guarantee* that someone won't ask for PowerNV support in
> libvirt at some point? Because if you can't (and I don't think you
> can ;) then this is still a valuable conversation to have.

It's rather unlikely for now as there is no KVM suport for it (it's
tricky, our chips aren't designed for full virtualization). That might
change in the future but not soon.

> > > What I meant is that pSeries guests get a single PHB by default,
> > > with additional ones being instantiable through -device; this is
> > > also consistent with how PCI controllers are added to other guest
> > > types including pc, q35 and aarch64/virt, so it would be really
> > > nice if PowerNV behaved the same way.
> >=20
> > Well.. sure.. but it doesn't.  pSeries is a virtual platform, so we
> > have a reasonable amount of flexibility to define it as we want.
> > PowerNV is an emulation of existing hardware which has a specific
> > behaviour which we need to match.
>=20
> Sure, that's something to keep in mind.
>=20
> But the thing is, you still need to have *some* flexibility in
> the number of PHBs, since there is variation among real Power8
> and Power9 chips; in the current incarnation, that flexibility
> is provided by the num_phbs parameter, which is an entirely new
> interface that's exclusive to PowerNV.
>=20
> What I'm suggesting is that the same amount of flexibility is
> offered through a standard interface, namely -device, instead.

But that's harder internally to qemu to properly "bind" to the chip
where the PHB resides etc...=20

Cheers,
Ben.
