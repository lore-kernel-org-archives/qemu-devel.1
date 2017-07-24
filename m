Received: from eggs.gnu.org ([2001:4830:134:3::10]:33001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZW4j-0007bl-2D
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZW4h-0000aC-FI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:38:37 -0400
Date: Mon, 24 Jul 2017 15:38:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724053827.GI17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
	<1500872645.10674.52.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <1500872645.10674.52.camel@kernel.crashing.org>
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


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:04:05PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 13:28 +1000, David Gibson wrote:
> > > So yes, in PAPR there's an "allocator" because the hypervisor will
> > > create a guest "virtual" (or logical to use PAPR terminology) interru=
pt
> > > number space, in order to represents the various interrupts into the
> > > guest.
> >=20
> > Ok, but are each of those logical irqs bound to a specific device/PHB
> > line/whatever, or can they be configured by the guest?
>=20
> So for clarity, let's first establish the terminology :-)
>=20
>  - HW number is a HW interrupt number on a "bare metal" system or
> powernv guest. For now we will ignore those, they are effectively a
> side effect of how skiboot configure the XIVE and qemu per-se doesn't
> allocate them.
>=20
>  - A logical number is a "guest physical" interrupt number for a PAPR
> guest. These fall into roughly 2 categories at the moment:
>=20
>     * "interrupts" (or related) properties in the DT, typically
> interrupts for a PCI device, ranges of MSIs etc... that correspond to
> HW sources from a PHB.

Ok, I think this is the one I've mostly been thinking of.

>     * "generic IPIs". Those are ranges of "generic" interrupts that the
> hypervisor gives the guest. On a real system, they correspond to chunks
> allocated off a HW facility for generic interrupts. Generic interrupts
> are the same as normal interrupts from the prespective of
> managing/receiving them, but are "triggered" by an MMIO to a certain HW
> page. There's a DT property telling the guest the interrupt number
> ranges for these guys.
>=20
> So that logical number above is what a PAPR guest obtains from the DT
> and uses for the various H-call used to manage and configure interrupt
> sources.

Ok.

> In addition, the XIVE supports renumbering the interrupt number that
> you obtain in the queues. Both bare metal linux, KVM and guests make
> use of this. This only changes the number you observe in a queue when
> you receive an interrupt, it has no effect on the HW number or logical
> number used for the various management calls.

Ok.

> This is used by Linux so that:
>=20
>   - On bare metal systems or PAPR guest with "exploitation mode" (ie,
> PAPR guest directly using the XIVE), we put the linux interrupt number
> in there as to avoid the reverse-mapping done by linux otherwise when
> receiving an interrupt.
>=20
>   - On PARP guests using the legacy hcalls, KVM configures the logical
> number there.

Ok.

> > > Those numbers however are just tokens, they don't have to represent a=
ny
> > > real HW concept. So they can be "allocated" in a rather fixed way, for
> > > example, you could have something like a fixed map where you put all
> > > the PCI interrupts at a certain number (a factor of the PHB# with room
> > > or a fix number per PHB, maybe 16K or so, the HW does 4K max). Another
> > > based would have a chunk of "general purpose" IPIs (for use for actual
> > > IPIs and for other things to come). And a range for the virtual device
> > > interrupts for example. Or you can just use an allocator.
> >=20
> > Hm.  So what I'm meaning by an "allocator" is something at least
> > partially dynamic.  Something you say "give me an irq" and it gives
> > you the next available or similar.  As opposed to any mapping from
> > devices to (logical) irqs, which the machine will need to supply one
> > way or another.
>=20
> For the sake of repeatability/migration etc... I think a mapping is
> better than an allocator.  IE, a fixed number scheme so that the range
> of interrupts for PHB#x is always a fixed function of x.

Yes, I agree.  In fact that's pretty much exactly the point I'm trying
to make.

Can we assign our logical numbers sparsely, or will that cause other
problems?

Note that for PAPR we also have the question of finding logical
interrupts for legacy PAPR VIO devices.

> We can fix the number of "generic" interrupts given to a guest. The
> only requirements from a PAPR perspective is that there should be at
> least as many as there are possible threads in the guest so they can be
> used as IPIs.

Ok.  If we can do things sparsely, allocating these well away from the
hw interrupts would make things easier.

> But we may need more for other things. We can make this a machine
> parameter with a default value of something like 4096. If we call N
> that number of extra generic interrupts, then the number of generic
> interrutps would be #possible-vcpu's + N, or something like that.

That seems reasonable.

> > > But it's fundamentally an allocator that sits in the hypervisor, so in
> > > our case, I would say in the spapr "component" of XIVE, rather than t=
he
> > > XIVE HW model itself.
> >=20
> > Maybe..
>=20
> You are right in that a mapping is a better term than an allocator
> here.
>=20
> > > Now what Cedric did, because XIVE is very complex and we need somethi=
ng
> > > for PAPR quickly, is not a complete HW model, but a somewhat simplifi=
ed
> > > one that only handles what PAPR exposes. So in that case where the
> > > allocator sits is a bit of a TBD...
> >=20
> > Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> > machine type level needs extreme caution, or the irqs may not be
> > stable which will generally break migration.
>=20
> Yes you are right. We should probably create a more "static" scheme.

Sounds like we're in violent agreement.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1h9EACgkQbDjKyiDZ
s5KfiQ/+J9HViNPdS55MAgF2Y1cXYVxeFqjb/lPW8iNgA14NsWbJwH3mVdw6V27X
ZS/dCLhH1n1NG5FwXKWxJBL6vMakU7lhU5yHFFs4jqnSRkbe5nofNxaNGas5/OUG
6z8NPb06q2ptG23XgfjTibLvglpIBQH49XpiPbb1i23Lck0nHDPRJIOaPxKEJNSn
eutThyFHPP/HfGibX+jKcdOQK/+y9vl4/nrAqQlqcLGq//gvMbUyfkOUBXneFkum
IbgoPIEjprqeYyx9xRfSCnz/795ZF3bTBp1C/KLSTEZ6+TCTIU60k1lqLqAfQQQt
nHwB/NRoGIG2g0ePNwd7WLDZU3w9owSAyg9z+yL+1FqnviuTulGW1QnhpHCkqO+7
3r7eb/C2s+awYVne3Gl06TELJhZvhyxBOA24+22Qs25oyr4XTIOmgenI/QDZ2l41
Xhuj6h+oD0iI0TJbWx4W9iUgYsTaa0TPj89h+XUVgXlhDnP/8YakQFgM1beyu9Ne
AMf5OUFpvKP7NNH37HdZH0FWU01pF/QgzTN9z/0s0cqOlGBNQvdZXtd2sf0UY197
lr9VkYBy++RXGqT1OnSL0r9VNvdefxTiPE8jvlhJtMQSupMZJ7s8VtAWJCdCjd/h
pdW247f/maXdnzGGQyJk61MXrZoI0rP+4UuCZB/aK06fmxrbKVc=
=jdoW
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
